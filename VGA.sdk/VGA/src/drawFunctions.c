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
