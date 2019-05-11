void clearScreen(void);
uint8_t drawPixel(uint16_t, uint16_t, uint8_t, _Bool);
void drawHorzLine(uint16_t x1, uint16_t x2, uint16_t y, uint8_t value, _Bool overwrite);
uint8_t drawVertLine(uint16_t y1, uint16_t y2, uint16_t x, uint8_t value, _Bool overwrite);
