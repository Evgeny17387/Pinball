import defines::COLOR_TRANSPARENT, defines::COLOR_DEFAULT;
import defines::LETTER_HEIGHT, defines::LETTER_WIDTH;

module letter
(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	offsetX,
	input 	logic	[10:0]	offsetY,
	input	logic	[4:0] 	letter,
	input 	logic 			drawLetter,
	input 	logic 	[7:0]	color,
	output	logic			drawLetterBitMask,
	output	logic	[7:0]	RGBLetter
);

`ifdef PICTURES

//wellcome
//22-4-11-11-2-14-12-4
//end
//4, 13, 3
//game over
//6, 0, 12, 4, 26, 14, 21, 4, 17
//press 0 to start
//15, 17, 4, 18, 18, 26, 28, 26 19, 14, 26, 18, 19, 0, 17, 19
//press 1 to start
//15, 17, 4, 18, 18, 26, 29, 26 19, 14, 26, 18, 19, 0, 17, 19
//your score is:
//24, 14, 20, 17, 26, 18, 2, 14, 17, 4, 26, 8, 18, 27
//single
//18, 8, 13, 6, 11, 4
//Dual
//3, 20, 0, 11

// A - 0
// B - 1
// C - 2
// D - 3
// E - 4
// F - 5
// G - 6
// H - 7
// I - 8
// J - 9
// K - 10
// L - 11
// M - 12
// N - 13
// O - 14
// P - 15
// Q - 16
// R - 17
// S - 18
// T - 19
// U - 20
// V - 21
// W - 22
// X - 23
// Y - 24
// Z - 25
// <space bar> - 26
// <colon> - 27
// 0 - 28

bit [0:29] [0:LETTER_HEIGHT - 1] [0:LETTER_WIDTH - 1] letter_bitmap = {
// A - 0
{
	32'b00000011111111111111111110000000,
	32'b00000011111111111111111110000000,
	32'b00000011111111111111111110000000,
	32'b00000011111111111111111110000000,
	32'b00000011111111111111111110000000,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111
},
// B - 1
{
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000
},
// C - 2
{
	32'b00000111111111111111111111111000,
	32'b00000111111111111111111111111000,
	32'b00000111111111111111111111111000,
	32'b00000111111111111111111111111000,
	32'b00000111111111111111111111111000,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b00000111111111111111111111111000,
	32'b00000111111111111111111111111000,
	32'b00000111111111111111111111111000,
	32'b00000111111111111111111111111000,
	32'b00000111111111111111111111111000
},
// D - 3
{
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000
},
// E - 4
{
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111111111111110000000000000000,
	32'b11111111111111110000000000000000,
	32'b11111111111111110000000000000000,
	32'b11111111111111110000000000000000,
	32'b11111111111111110000000000000000,
	32'b11111111111111110000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111
},
// F - 5
{
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111111111111111111100000000000,
	32'b11111111111111111111100000000000,
	32'b11111111111111111111100000000000,
	32'b11111111111111111111100000000000,
	32'b11111111111111111111100000000000,
	32'b11111111111111111111100000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000
},
// G - 6
{
	32'b00000111111111111111111111111111,
	32'b00000111111111111111111111111111,
	32'b00000111111111111111111111111111,
	32'b00000111111111111111111111111111,
	32'b00000111111111111111111111111111,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000111111111111,
	32'b11111100000000000000111111111111,
	32'b11111100000000000000111111111111,
	32'b11111100000000000000111111111111,
	32'b11111100000000000000111111111111,
	32'b11111100000000000000111111111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b11111100000000000000000000111111,
	32'b00000111111111111111111111000000,
	32'b00000111111111111111111111000000,
	32'b00000111111111111111111111000000,
	32'b00000111111111111111111111000000,
	32'b00000111111111111111111111000000
},
// H - 7
{
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111
},
// I - 8
{
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000
},
// J - 9
{
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b00000000000000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111100000000000000111111111,
	32'b11111111111111111111111111111111,
	32'b00000000111111111111111000000000
},
// K - 10
{
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000011111110000000,
	32'b11111110000000000011111110000000,
	32'b11111110000000000011111110000000,
	32'b11111110000000000011111110000000,
	32'b11111110000000000011111110000000,
	32'b11111111111111111100000000000000,
	32'b11111111111111111100000000000000,
	32'b11111111111111111100000000000000,
	32'b11111111111111111100000000000000,
	32'b11111111111111111100000000000000,
	32'b11111111111111111100000000000000,
	32'b11111110000000000011111110000000,
	32'b11111110000000000011111110000000,
	32'b11111110000000000011111110000000,
	32'b11111110000000000011111110000000,
	32'b11111110000000000011111110000000,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111,
	32'b11111110000000000000000011111111
},
// L - 11
{
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111
},
// M - 12
{
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111111111110000001111111111111,
	32'b11111111111110000001111111111111,
	32'b11111111111110000001111111111111,
	32'b11111111111110000001111111111111,
	32'b11111111111110000001111111111111,
	32'b11111111111111111111111111111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111
},
// N - 13
{
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111111111110000000000001111111,
	32'b11111111111110000000000001111111,
	32'b11111111111110000000000001111111,
	32'b11111111111110000000000001111111,
	32'b11111111111110000000000001111111,
	32'b11111111111110000000000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000000000001111111111111,
	32'b11111100000000000001111111111111,
	32'b11111100000000000001111111111111,
	32'b11111100000000000001111111111111,
	32'b11111100000000000001111111111111,
	32'b11111100000000000001111111111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111
},
// O - 14
{
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000
},
// P - 15
{
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111111111111111111111111000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000,
	32'b11111100000000000000000000000000
},
// Q - 16
{
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000001111110000011111,
	32'b11111000000000001111110000011111,
	32'b11111000000000001111110000011111,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111100000,
	32'b00000111111111111111111111111111,
	32'b00000111111111111111111111111111,
	32'b00000111111111111111111111111111
},
// R - 17
{
	32'b11111111111111111111111100000000,
	32'b11111111111111111111111100000000,
	32'b11111111111111111111111100000000,
	32'b11111111111111111111111100000000,
	32'b11111111111111111111111100000000,
	32'b11111000000000000000000011111000,
	32'b11111000000000000000000011111000,
	32'b11111000000000000000000011111000,
	32'b11111000000000000000000011111000,
	32'b11111000000000000000000011111000,
	32'b11111111111111111111111111111000,
	32'b11111111111111111111111100000000,
	32'b11111111111111111111111100000000,
	32'b11111111111111111111111100000000,
	32'b11111111111111111111111100000000,
	32'b11111111111111111111111100000000,
	32'b11111000000000001111110000000000,
	32'b11111000000000001111110000000000,
	32'b11111000000000001111110000000000,
	32'b11111000000000001111110000000000,
	32'b11111000000000001111110000000000,
	32'b11111000000000001111111111100000,
	32'b11111000000000000000011111100000,
	32'b11111000000000000000011111100000,
	32'b11111000000000000000011111100000,
	32'b11111000000000000000011111100000,
	32'b11111000000000000000011111100000,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111,
	32'b11111000000000000000000000011111
},
// S - 18
{
	32'b00000011111111111111111111111111,
	32'b00000011111111111111111111111111,
	32'b00000011111111111111111111111111,
	32'b00000011111111111111111111111111,
	32'b00000011111111111111111111111111,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111110000000000000000000000000,
	32'b11111111111111111111111110000000,
	32'b00000011111111111111111110000000,
	32'b00000011111111111111111110000000,
	32'b00000011111111111111111110000000,
	32'b00000011111111111111111110000000,
	32'b00000011111111111111111110000000,
	32'b00000000000000000000000011111111,
	32'b00000000000000000000000011111111,
	32'b00000000000000000000000011111111,
	32'b00000000000000000000000011111111,
	32'b00000000000000000000000011111111,
	32'b00000000000000000000000011111111,
	32'b00000000000000000000000011111111,
	32'b00000000000000000000000011111111,
	32'b00000000000000000000000011111111,
	32'b00000000000000000000000011111111,
	32'b00000000000000000000000011111111,
	32'b11111111111111111111111110000000,
	32'b11111111111111111111111110000000,
	32'b11111111111111111111111110000000,
	32'b11111111111111111111111110000000,
	32'b11111111111111111111111110000000
},
// T - 19
{
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000
},
// U - 20
{
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b11111111000000000000000011111111,
	32'b00000001111111111111111110000000,
	32'b00000001111111111111111110000000,
	32'b00000001111111111111111110000000,
	32'b00000001111111111111111110000000,
	32'b00000001111111111111111110000000
},
// V - 21
{
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111111111110000001111111111111,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111111111111111111000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000
},
// W - 22
{
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111100000011111110000001111111,
	32'b11111111111110000001111111111111,
	32'b11111111111110000001111111111111,
	32'b11111111111110000001111111111111,
	32'b11111111111110000001111111111111,
	32'b11111111111110000001111111111111,
	32'b11111111111110000001111111111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111
},
// X - 23
{
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111111111111111111000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111
},
// Y - 24
{
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b11111100000000000000000001111111,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111110000001111111000000,
	32'b00000011111111111111111111000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000
},
// Z - 25
{
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b00000000000000000000000001111111,
	32'b00000000000000000000000001111111,
	32'b00000000000000000000000001111111,
	32'b00000000000000000000000001111111,
	32'b00000000000000000000000001111111,
	32'b00000000000000000001111111111111,
	32'b00000000000000000001111111000000,
	32'b00000000000000000001111111000000,
	32'b00000000000000000001111111000000,
	32'b00000000000000000001111111000000,
	32'b00000000000000000001111111000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000000000011111110000000000000,
	32'b00000011111110000000000000000000,
	32'b00000011111110000000000000000000,
	32'b00000011111110000000000000000000,
	32'b00000011111110000000000000000000,
	32'b00000011111110000000000000000000,
	32'b00000011111110000000000000000000,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111
},
// <space bar> - 26
{
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000
},
// <colon> - 27
{
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000111111111111111100000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000
},
// 0 - 28
{
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b11111111000000000000000111111111,
	32'b11111111000000000000000111111111,
	32'b11111111000000000000000111111111,
	32'b11111111000000000000111111111111,
	32'b11111111000000000000111111111111,
	32'b11111111000000000000111111111111,
	32'b11111111000000000000111111111111,
	32'b11111111000000000000111111111111,
	32'b11111111000011111111000111111111,
	32'b11111111000011111111000111111111,
	32'b11111111000011111111000111111111,
	32'b11111111000011111111000111111111,
	32'b11111111000011111111000111111111,
	32'b11111111000011111111000111111111,
	32'b11111111111100000000000111111111,
	32'b11111111111100000000000111111111,
	32'b11111111111100000000000111111111,
	32'b11111111111100000000000111111111,
	32'b11111111111100000000000111111111,
	32'b11111111000000000000000111111111,
	32'b11111111000000000000000111111111,
	32'b11111111000000000000000111111111,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000,
	32'b00000001111111111111111100000000
},
// 0 - 29
{
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b11111111111111111111100000000000,
	32'b11111111111111111111100000000000,
	32'b11111111111111111111100000000000,
	32'b11111111111111111111100000000000,
	32'b11111111111111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b00000000001111111111100000000000,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111,
	32'b11111111111111111111111111111111
}
};
`endif

always_ff@(posedge clk or negedge resetN)
begin

	if(!resetN) begin

		drawLetterBitMask <= 1'b0;

	end
	else begin

		drawLetterBitMask <= 1'b0;

		if (drawLetter == 1'b1)

`ifdef PICTURES
			drawLetterBitMask <= (letter_bitmap[letter][offsetY][offsetX]);
`else
			drawLetterBitMask <= 1'b1;
`endif

	end

end

assign RGBLetter = color;

endmodule 
