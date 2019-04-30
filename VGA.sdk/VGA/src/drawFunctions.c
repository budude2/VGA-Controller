#include <stdio.h>
#include "xbram.h"

#define BRAM_BASE_ADDR		XPAR_BRAM_0_BASEADDR

uint8_t drawPixel(uint16_t x, uint16_t y, uint8_t value)
{
    if((x > 649) || (y > 639))
    {
        return 1;
    }
    else
    {
        uint32_t baseAddr, dataWord;
        uint8_t bit;

        baseAddr = y * 80 + x / 8;
        bit = x % 8;

        dataWord = (uint32_t) value << (8 - bit);

        XBram_WriteReg(BRAM_BASE_ADDR, 4*baseAddr, dataWord);

        return 0;
    }
}
