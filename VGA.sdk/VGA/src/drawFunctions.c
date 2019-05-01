#include <stdio.h>
#include "xbram.h"
#include <stdbool.h>

#define BRAM_BASE_ADDR		XPAR_BRAM_0_BASEADDR

void clearScreen(void)
{
	int idx;
	for(idx = 0; idx < 38400; idx ++)
	{
        XBram_WriteReg(BRAM_BASE_ADDR, 4*idx, 0);
	}
}

uint8_t drawPixel(uint16_t x, uint16_t y, uint8_t value, _Bool overwrite)
{
    if((x > 639) || (y > 479))
    {
        return 1;
    }
    else
    {
        uint32_t baseAddr, dataWord;
        uint8_t bit;

        baseAddr = y * 80 + x / 8;
        bit = x % 8;

        dataWord = (uint32_t) value << ((7 - bit)*4);
        if(overwrite == false)
        {
        	uint32_t storedVal;
        	storedVal = XBram_ReadReg(BRAM_BASE_ADDR, 4*baseAddr);
        	dataWord = dataWord | storedVal;
        }

        XBram_WriteReg(BRAM_BASE_ADDR, 4*baseAddr, dataWord);

        return 0;
    }
}

uint8_t drawHorzLine(uint16_t x1, uint16_t x2, uint16_t y, uint8_t value, _Bool overwrite)
{
	if(x1 > x2)
	{
		return 1;
	}
	else
	{
		uint32_t dataWord, startWord, stopWord, currWord, startAddr, stopAddr;
		uint16_t dist, idx;
		uint8_t x1_mod, x2_mod;

		dataWord = 0x11111111 * value;

		startAddr = y * 80 + x1 / 8;
		x1_mod = x1 % 8;

		stopAddr = y * 80 + x2 / 8;
		x2_mod = x2 % 8;

		dist = stopAddr - startAddr - 1;

		if(x1_mod != 0)
		{
			idx = 1;
			startWord = dataWord >> x1_mod * 4;
			if(overwrite == false)
			{
				currWord = XBram_ReadReg(BRAM_BASE_ADDR, 4*startAddr);
				currWord = currWord & 0xFFFFFFFF << ((8 - x1_mod)*4);;
				startWord = startWord | currWord;
			}
			XBram_WriteReg(BRAM_BASE_ADDR, 4*startAddr, startWord);
		}
		else
		{
			idx = 0;
		}

		for(;idx <= dist; idx++)
		{
			XBram_WriteReg(BRAM_BASE_ADDR, 4*(idx + startAddr), dataWord);
		}

		stopWord = dataWord << ((7 - x2_mod)*4);
		if(overwrite == false)
		{
			currWord = XBram_ReadReg(BRAM_BASE_ADDR, 4*stopAddr);
			if(x2_mod != 7)
			{
				currWord = currWord & (0xFFFFFFFF >> ((x2_mod + 1)*4));
				stopWord = stopWord | currWord;
			}
		}
		XBram_WriteReg(BRAM_BASE_ADDR, 4*stopAddr, stopWord);
		return 0;
	}
}
