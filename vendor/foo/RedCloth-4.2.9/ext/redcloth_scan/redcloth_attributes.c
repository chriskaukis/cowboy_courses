
#line 1 "ragel/redcloth_attributes.c.rl"
/*
 * redcloth_attributes.c.rl
 *
 * Copyright (C) 2009 Jason Garber
 */
#define RSTRING_NOT_MODIFIED
#include <ruby.h>
#include "redcloth.h"


#line 16 "ragel/redcloth_attributes.c.rl"



#line 18 "ext/redcloth_scan/redcloth_attributes.c"
static const char _redcloth_attributes_actions[] = {
	0, 1, 2, 1, 4, 1, 5, 1, 
	6, 1, 7, 1, 8, 1, 11, 1, 
	12, 1, 13, 1, 15, 1, 18, 1, 
	19, 2, 3, 14, 2, 10, 17, 2, 
	13, 0, 2, 13, 1, 2, 13, 2, 
	2, 13, 5, 2, 13, 6, 2, 13, 
	7, 2, 13, 8, 3, 9, 10, 16
	
};

static const short _redcloth_attributes_key_offsets[] = {
	0, 0, 6, 11, 27, 33, 38, 44, 
	60, 66, 87, 108, 118, 129, 137, 146, 
	153, 159, 164, 180, 201, 205, 210, 224, 
	240, 257, 274, 291, 304, 318, 325, 331, 
	346, 360, 375, 385, 391, 406, 420, 435, 
	445, 452, 462, 473, 492, 513, 535, 557, 
	579, 598, 618, 634, 650, 660, 671, 690, 
	711, 733, 755, 777, 796, 816, 819, 825, 
	840, 854, 869, 878, 888, 899, 918, 939, 
	961, 983, 1005, 1024, 1044
};

static const char _redcloth_attributes_trans_keys[] = {
	0, 9, 10, 32, 11, 13, 0, 9, 
	32, 10, 13, 0, 9, 10, 32, 35, 
	41, 45, 95, 11, 13, 48, 57, 65, 
	90, 97, 122, 0, 9, 10, 32, 11, 
	13, 0, 9, 32, 10, 13, 0, 9, 
	10, 32, 11, 13, 0, 9, 10, 32, 
	35, 41, 45, 95, 11, 13, 48, 57, 
	65, 90, 97, 122, 0, 9, 10, 32, 
	11, 13, 0, 9, 10, 32, 95, 117, 
	125, 11, 13, 34, 35, 37, 39, 45, 
	46, 48, 59, 65, 90, 97, 122, 0, 
	9, 10, 32, 95, 117, 125, 11, 13, 
	34, 35, 37, 39, 45, 46, 48, 59, 
	65, 90, 97, 122, 32, 35, 45, 95, 
	48, 57, 65, 90, 97, 122, 32, 35, 
	41, 45, 95, 48, 57, 65, 90, 97, 
	122, 45, 95, 48, 57, 65, 90, 97, 
	122, 41, 45, 95, 48, 57, 65, 90, 
	97, 122, 0, 32, 40, 91, 123, 9, 
	13, 0, 9, 10, 32, 11, 13, 0, 
	9, 32, 10, 13, 0, 9, 10, 32, 
	35, 41, 45, 95, 11, 13, 48, 57, 
	65, 90, 97, 122, 0, 9, 10, 32, 
	95, 117, 125, 11, 13, 34, 35, 37, 
	39, 45, 46, 48, 59, 65, 90, 97, 
	122, 45, 95, 97, 122, 45, 93, 95, 
	97, 122, 32, 95, 34, 35, 37, 39, 
	45, 46, 48, 59, 65, 90, 97, 122, 
	32, 95, 117, 125, 34, 35, 37, 39, 
	45, 46, 48, 59, 65, 90, 97, 122, 
	32, 95, 114, 117, 125, 34, 35, 37, 
	39, 45, 46, 48, 59, 65, 90, 97, 
	122, 32, 95, 108, 117, 125, 34, 35, 
	37, 39, 45, 46, 48, 59, 65, 90, 
	97, 122, 32, 40, 95, 117, 125, 34, 
	35, 37, 39, 45, 46, 48, 59, 65, 
	90, 97, 122, 39, 43, 61, 92, 95, 
	34, 35, 45, 57, 63, 64, 97, 122, 
	39, 41, 43, 61, 92, 95, 34, 35, 
	45, 57, 63, 64, 97, 122, 0, 32, 
	40, 91, 123, 9, 13, 0, 9, 10, 
	32, 11, 13, 0, 9, 10, 32, 35, 
	45, 95, 11, 13, 48, 57, 65, 90, 
	97, 122, 0, 9, 10, 32, 45, 95, 
	11, 13, 48, 57, 65, 90, 97, 122, 
	0, 9, 10, 32, 41, 45, 95, 11, 
	13, 48, 57, 65, 90, 97, 122, 0, 
	9, 10, 32, 40, 46, 91, 123, 11, 
	13, 0, 9, 10, 32, 11, 13, 0, 
	9, 10, 32, 35, 45, 95, 11, 13, 
	48, 57, 65, 90, 97, 122, 0, 9, 
	10, 32, 45, 95, 11, 13, 48, 57, 
	65, 90, 97, 122, 0, 9, 10, 32, 
	41, 45, 95, 11, 13, 48, 57, 65, 
	90, 97, 122, 0, 9, 10, 32, 40, 
	46, 91, 123, 11, 13, 0, 9, 10, 
	32, 46, 11, 13, 0, 9, 10, 32, 
	45, 95, 11, 13, 97, 122, 0, 9, 
	10, 32, 45, 93, 95, 11, 13, 97, 
	122, 0, 9, 10, 32, 95, 11, 13, 
	34, 35, 37, 39, 45, 46, 48, 59, 
	65, 90, 97, 122, 0, 9, 10, 32, 
	95, 117, 125, 11, 13, 34, 35, 37, 
	39, 45, 46, 48, 59, 65, 90, 97, 
	122, 0, 9, 10, 32, 95, 114, 117, 
	125, 11, 13, 34, 35, 37, 39, 45, 
	46, 48, 59, 65, 90, 97, 122, 0, 
	9, 10, 32, 95, 108, 117, 125, 11, 
	13, 34, 35, 37, 39, 45, 46, 48, 
	59, 65, 90, 97, 122, 0, 9, 10, 
	32, 40, 95, 117, 125, 11, 13, 34, 
	35, 37, 39, 45, 46, 48, 59, 65, 
	90, 97, 122, 0, 9, 10, 32, 39, 
	43, 61, 92, 95, 11, 13, 34, 35, 
	45, 57, 63, 64, 97, 122, 0, 9, 
	10, 32, 39, 41, 43, 61, 92, 95, 
	11, 13, 34, 35, 45, 57, 63, 64, 
	97, 122, 0, 9, 10, 32, 35, 41, 
	45, 95, 11, 13, 48, 57, 65, 90, 
	97, 122, 0, 9, 10, 32, 35, 41, 
	45, 95, 11, 13, 48, 57, 65, 90, 
	97, 122, 0, 9, 10, 32, 45, 95, 
	11, 13, 97, 122, 0, 9, 10, 32, 
	45, 93, 95, 11, 13, 97, 122, 0, 
	9, 10, 32, 95, 11, 13, 34, 35, 
	37, 39, 45, 46, 48, 59, 65, 90, 
	97, 122, 0, 9, 10, 32, 95, 117, 
	125, 11, 13, 34, 35, 37, 39, 45, 
	46, 48, 59, 65, 90, 97, 122, 0, 
	9, 10, 32, 95, 114, 117, 125, 11, 
	13, 34, 35, 37, 39, 45, 46, 48, 
	59, 65, 90, 97, 122, 0, 9, 10, 
	32, 95, 108, 117, 125, 11, 13, 34, 
	35, 37, 39, 45, 46, 48, 59, 65, 
	90, 97, 122, 0, 9, 10, 32, 40, 
	95, 117, 125, 11, 13, 34, 35, 37, 
	39, 45, 46, 48, 59, 65, 90, 97, 
	122, 0, 9, 10, 32, 39, 43, 61, 
	92, 95, 11, 13, 34, 35, 45, 57, 
	63, 64, 97, 122, 0, 9, 10, 32, 
	39, 41, 43, 61, 92, 95, 11, 13, 
	34, 35, 45, 57, 63, 64, 97, 122, 
	40, 91, 123, 0, 9, 10, 32, 11, 
	13, 0, 9, 10, 32, 35, 45, 95, 
	11, 13, 48, 57, 65, 90, 97, 122, 
	0, 9, 10, 32, 45, 95, 11, 13, 
	48, 57, 65, 90, 97, 122, 0, 9, 
	10, 32, 41, 45, 95, 11, 13, 48, 
	57, 65, 90, 97, 122, 0, 9, 10, 
	32, 40, 91, 123, 11, 13, 0, 9, 
	10, 32, 45, 95, 11, 13, 97, 122, 
	0, 9, 10, 32, 45, 93, 95, 11, 
	13, 97, 122, 0, 9, 10, 32, 95, 
	11, 13, 34, 35, 37, 39, 45, 46, 
	48, 59, 65, 90, 97, 122, 0, 9, 
	10, 32, 95, 117, 125, 11, 13, 34, 
	35, 37, 39, 45, 46, 48, 59, 65, 
	90, 97, 122, 0, 9, 10, 32, 95, 
	114, 117, 125, 11, 13, 34, 35, 37, 
	39, 45, 46, 48, 59, 65, 90, 97, 
	122, 0, 9, 10, 32, 95, 108, 117, 
	125, 11, 13, 34, 35, 37, 39, 45, 
	46, 48, 59, 65, 90, 97, 122, 0, 
	9, 10, 32, 40, 95, 117, 125, 11, 
	13, 34, 35, 37, 39, 45, 46, 48, 
	59, 65, 90, 97, 122, 0, 9, 10, 
	32, 39, 43, 61, 92, 95, 11, 13, 
	34, 35, 45, 57, 63, 64, 97, 122, 
	0, 9, 10, 32, 39, 41, 43, 61, 
	92, 95, 11, 13, 34, 35, 45, 57, 
	63, 64, 97, 122, 0, 9, 10, 32, 
	35, 41, 45, 95, 11, 13, 48, 57, 
	65, 90, 97, 122, 0
};

static const char _redcloth_attributes_single_lengths[] = {
	0, 4, 3, 8, 4, 3, 4, 8, 
	4, 7, 7, 4, 5, 2, 3, 5, 
	4, 3, 8, 7, 2, 3, 2, 4, 
	5, 5, 5, 5, 6, 5, 4, 7, 
	6, 7, 8, 4, 7, 6, 7, 8, 
	5, 6, 7, 5, 7, 8, 8, 8, 
	9, 10, 8, 8, 6, 7, 5, 7, 
	8, 8, 8, 9, 10, 3, 4, 7, 
	6, 7, 7, 6, 7, 5, 7, 8, 
	8, 8, 9, 10, 8
};

static const char _redcloth_attributes_range_lengths[] = {
	0, 1, 1, 4, 1, 1, 1, 4, 
	1, 7, 7, 3, 3, 3, 3, 1, 
	1, 1, 4, 7, 1, 1, 6, 6, 
	6, 6, 6, 4, 4, 1, 1, 4, 
	4, 4, 1, 1, 4, 4, 4, 1, 
	1, 2, 2, 7, 7, 7, 7, 7, 
	5, 5, 4, 4, 2, 2, 7, 7, 
	7, 7, 7, 5, 5, 0, 1, 4, 
	4, 4, 1, 2, 2, 7, 7, 7, 
	7, 7, 5, 5, 4
};

static const short _redcloth_attributes_index_offsets[] = {
	0, 0, 6, 11, 24, 30, 35, 41, 
	54, 60, 75, 90, 98, 107, 113, 120, 
	127, 133, 138, 151, 166, 170, 175, 184, 
	195, 207, 219, 231, 241, 252, 259, 265, 
	277, 288, 300, 310, 316, 328, 339, 351, 
	361, 368, 377, 387, 400, 415, 431, 447, 
	463, 478, 494, 507, 520, 529, 539, 552, 
	567, 583, 599, 615, 630, 646, 650, 656, 
	668, 679, 691, 700, 709, 719, 732, 747, 
	763, 779, 795, 810, 826
};

static const char _redcloth_attributes_indicies[] = {
	0, 2, 3, 2, 0, 1, 0, 2, 
	2, 0, 1, 0, 2, 3, 4, 5, 
	6, 7, 7, 0, 7, 7, 7, 1, 
	8, 10, 11, 10, 8, 9, 8, 10, 
	10, 8, 9, 0, 2, 3, 13, 0, 
	12, 8, 10, 11, 14, 15, 16, 17, 
	17, 8, 17, 17, 17, 9, 8, 10, 
	11, 18, 8, 12, 8, 10, 11, 19, 
	20, 21, 22, 8, 20, 20, 20, 20, 
	20, 20, 9, 0, 2, 3, 23, 24, 
	25, 26, 0, 24, 24, 24, 24, 24, 
	24, 1, 27, 29, 27, 27, 27, 27, 
	27, 28, 30, 31, 32, 30, 30, 30, 
	30, 30, 28, 33, 33, 33, 33, 33, 
	28, 34, 35, 35, 35, 35, 35, 28, 
	28, 28, 37, 38, 39, 28, 36, 40, 
	42, 43, 42, 40, 41, 40, 42, 42, 
	40, 41, 40, 42, 43, 44, 45, 46, 
	47, 47, 40, 47, 47, 47, 41, 40, 
	42, 43, 48, 49, 50, 51, 40, 49, 
	49, 49, 49, 49, 49, 41, 52, 52, 
	52, 28, 53, 54, 53, 53, 28, 55, 
	55, 55, 55, 55, 55, 55, 55, 28, 
	56, 56, 57, 58, 56, 56, 56, 56, 
	56, 56, 28, 56, 56, 59, 57, 58, 
	56, 56, 56, 56, 56, 56, 28, 56, 
	56, 60, 57, 58, 56, 56, 56, 56, 
	56, 56, 28, 56, 61, 56, 57, 58, 
	56, 56, 56, 56, 56, 56, 28, 62, 
	62, 62, 62, 62, 62, 62, 62, 62, 
	28, 62, 56, 62, 62, 62, 62, 62, 
	62, 62, 62, 28, 28, 28, 64, 65, 
	66, 28, 63, 67, 2, 3, 2, 67, 
	1, 67, 2, 3, 68, 69, 70, 70, 
	67, 70, 70, 70, 1, 67, 2, 3, 
	2, 71, 71, 67, 71, 71, 71, 1, 
	67, 2, 3, 2, 72, 73, 73, 67, 
	73, 73, 73, 1, 67, 2, 3, 13, 
	74, 75, 76, 77, 67, 12, 78, 10, 
	11, 10, 78, 9, 78, 10, 11, 79, 
	80, 81, 81, 78, 81, 81, 81, 9, 
	78, 10, 11, 10, 82, 82, 78, 82, 
	82, 82, 9, 78, 10, 11, 10, 83, 
	84, 84, 78, 84, 84, 84, 9, 78, 
	10, 11, 18, 74, 75, 76, 77, 78, 
	12, 78, 10, 11, 18, 75, 78, 12, 
	78, 10, 11, 10, 85, 85, 78, 85, 
	9, 78, 10, 11, 10, 86, 87, 86, 
	78, 86, 9, 78, 10, 11, 88, 89, 
	78, 89, 89, 89, 89, 89, 89, 9, 
	78, 10, 11, 19, 20, 21, 22, 78, 
	20, 20, 20, 20, 20, 20, 9, 78, 
	10, 11, 19, 20, 90, 21, 22, 78, 
	20, 20, 20, 20, 20, 20, 9, 78, 
	10, 11, 19, 20, 91, 21, 22, 78, 
	20, 20, 20, 20, 20, 20, 9, 78, 
	10, 11, 19, 92, 20, 21, 22, 78, 
	20, 20, 20, 20, 20, 20, 9, 78, 
	10, 11, 10, 93, 93, 93, 93, 93, 
	78, 93, 93, 93, 93, 9, 78, 10, 
	11, 10, 93, 20, 93, 93, 93, 93, 
	78, 93, 93, 93, 93, 9, 78, 10, 
	11, 14, 15, 16, 17, 17, 78, 17, 
	17, 17, 9, 67, 2, 3, 4, 5, 
	6, 7, 7, 67, 7, 7, 7, 1, 
	67, 2, 3, 2, 94, 94, 67, 94, 
	1, 67, 2, 3, 2, 95, 96, 95, 
	67, 95, 1, 67, 2, 3, 97, 98, 
	67, 98, 98, 98, 98, 98, 98, 1, 
	67, 2, 3, 23, 24, 25, 26, 67, 
	24, 24, 24, 24, 24, 24, 1, 67, 
	2, 3, 23, 24, 99, 25, 26, 67, 
	24, 24, 24, 24, 24, 24, 1, 67, 
	2, 3, 23, 24, 100, 25, 26, 67, 
	24, 24, 24, 24, 24, 24, 1, 67, 
	2, 3, 23, 101, 24, 25, 26, 67, 
	24, 24, 24, 24, 24, 24, 1, 67, 
	2, 3, 2, 102, 102, 102, 102, 102, 
	67, 102, 102, 102, 102, 1, 67, 2, 
	3, 2, 102, 24, 102, 102, 102, 102, 
	67, 102, 102, 102, 102, 1, 103, 104, 
	105, 28, 106, 42, 43, 42, 106, 41, 
	106, 42, 43, 107, 108, 109, 109, 106, 
	109, 109, 109, 41, 106, 42, 43, 42, 
	110, 110, 106, 110, 110, 110, 41, 106, 
	42, 43, 42, 111, 112, 112, 106, 112, 
	112, 112, 41, 106, 42, 43, 42, 37, 
	38, 39, 106, 36, 106, 42, 43, 42, 
	113, 113, 106, 113, 41, 106, 42, 43, 
	42, 114, 115, 114, 106, 114, 41, 106, 
	42, 43, 116, 117, 106, 117, 117, 117, 
	117, 117, 117, 41, 106, 42, 43, 48, 
	49, 50, 51, 106, 49, 49, 49, 49, 
	49, 49, 41, 106, 42, 43, 48, 49, 
	118, 50, 51, 106, 49, 49, 49, 49, 
	49, 49, 41, 106, 42, 43, 48, 49, 
	119, 50, 51, 106, 49, 49, 49, 49, 
	49, 49, 41, 106, 42, 43, 48, 120, 
	49, 50, 51, 106, 49, 49, 49, 49, 
	49, 49, 41, 106, 42, 43, 42, 121, 
	121, 121, 121, 121, 106, 121, 121, 121, 
	121, 41, 106, 42, 43, 42, 121, 49, 
	121, 121, 121, 121, 106, 121, 121, 121, 
	121, 41, 106, 42, 43, 44, 45, 46, 
	47, 47, 106, 47, 47, 47, 41, 0
};

static const char _redcloth_attributes_trans_targs[] = {
	29, 30, 1, 2, 3, 32, 34, 51, 
	29, 35, 4, 5, 35, 6, 7, 37, 
	39, 50, 8, 9, 44, 45, 39, 10, 
	55, 56, 34, 12, 0, 13, 12, 13, 
	15, 14, 15, 14, 62, 63, 67, 69, 
	61, 62, 16, 17, 18, 64, 66, 76, 
	19, 70, 71, 66, 21, 21, 15, 23, 
	23, 24, 15, 25, 26, 27, 28, 30, 
	31, 52, 54, 29, 3, 32, 51, 33, 
	34, 33, 36, 40, 41, 43, 29, 7, 
	37, 50, 38, 39, 38, 42, 42, 39, 
	9, 44, 46, 47, 48, 49, 53, 53, 
	34, 10, 55, 57, 58, 59, 60, 11, 
	20, 22, 61, 18, 64, 76, 65, 66, 
	65, 68, 68, 66, 19, 70, 72, 73, 
	74, 75
};

static const char _redcloth_attributes_trans_actions[] = {
	23, 17, 0, 0, 0, 40, 40, 17, 
	21, 17, 0, 0, 31, 0, 0, 40, 
	40, 17, 0, 0, 17, 17, 49, 0, 
	17, 17, 49, 1, 0, 0, 0, 5, 
	5, 1, 7, 0, 31, 31, 31, 31, 
	19, 17, 0, 0, 0, 40, 40, 17, 
	0, 17, 17, 49, 1, 0, 9, 1, 
	0, 0, 11, 0, 0, 0, 0, 34, 
	34, 34, 34, 28, 1, 17, 37, 37, 
	43, 17, 31, 31, 31, 31, 52, 1, 
	17, 37, 37, 43, 17, 37, 17, 46, 
	1, 37, 17, 17, 17, 17, 37, 17, 
	46, 1, 37, 17, 17, 17, 17, 3, 
	3, 3, 25, 1, 17, 37, 37, 43, 
	17, 37, 17, 46, 1, 37, 17, 17, 
	17, 17
};

static const char _redcloth_attributes_to_state_actions[] = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 13, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 13, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0
};

static const char _redcloth_attributes_from_state_actions[] = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 15, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 15, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0
};

static const short _redcloth_attributes_eof_trans[] = {
	0, 1, 1, 1, 9, 9, 1, 9, 
	9, 9, 1, 0, 0, 0, 0, 0, 
	41, 41, 41, 41, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 68, 68, 
	68, 68, 68, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 68, 68, 68, 68, 68, 
	68, 68, 68, 68, 68, 0, 107, 107, 
	107, 107, 107, 107, 107, 107, 107, 107, 
	107, 107, 107, 107, 107
};

static const int redcloth_attributes_start = 29;
static const int redcloth_attributes_error = 0;

static const int redcloth_attributes_en_inline = 61;
static const int redcloth_attributes_en_link_says = 29;


#line 19 "ragel/redcloth_attributes.c.rl"


VALUE
redcloth_attribute_parser(machine, self, p, pe)
  int machine;
  VALUE self;
  char *p, *pe;
{
  int cs, act;
  char *ts = 0, *te = 0, *reg = 0, *bck = NULL, *attr_reg = NULL, *eof = NULL;
  VALUE regs = rb_hash_new();
  VALUE attr_regs = rb_hash_new();

  
#line 425 "ext/redcloth_scan/redcloth_attributes.c"
	{
	cs = redcloth_attributes_start;
	ts = 0;
	te = 0;
	act = 0;
	}

#line 33 "ragel/redcloth_attributes.c.rl"

  cs = machine;

  
#line 438 "ext/redcloth_scan/redcloth_attributes.c"
	{
	int _klen;
	unsigned int _trans;
	const char *_acts;
	unsigned int _nacts;
	const char *_keys;

	if ( p == pe )
		goto _test_eof;
	if ( cs == 0 )
		goto _out;
_resume:
	_acts = _redcloth_attributes_actions + _redcloth_attributes_from_state_actions[cs];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 ) {
		switch ( *_acts++ ) {
	case 12:
#line 1 "NONE"
	{ts = p;}
	break;
#line 459 "ext/redcloth_scan/redcloth_attributes.c"
		}
	}

	_keys = _redcloth_attributes_trans_keys + _redcloth_attributes_key_offsets[cs];
	_trans = _redcloth_attributes_index_offsets[cs];

	_klen = _redcloth_attributes_single_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + _klen - 1;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + ((_upper-_lower) >> 1);
			if ( (*p) < *_mid )
				_upper = _mid - 1;
			else if ( (*p) > *_mid )
				_lower = _mid + 1;
			else {
				_trans += (unsigned int)(_mid - _keys);
				goto _match;
			}
		}
		_keys += _klen;
		_trans += _klen;
	}

	_klen = _redcloth_attributes_range_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( (*p) < _mid[0] )
				_upper = _mid - 2;
			else if ( (*p) > _mid[1] )
				_lower = _mid + 2;
			else {
				_trans += (unsigned int)((_mid - _keys)>>1);
				goto _match;
			}
		}
		_trans += _klen;
	}

_match:
	_trans = _redcloth_attributes_indicies[_trans];
_eof_trans:
	cs = _redcloth_attributes_trans_targs[_trans];

	if ( _redcloth_attributes_trans_actions[_trans] == 0 )
		goto _again;

	_acts = _redcloth_attributes_actions + _redcloth_attributes_trans_actions[_trans];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 )
	{
		switch ( *_acts++ )
		{
	case 0:
#line 5 "ragel/redcloth_common.rl"
	{ MARK(); }
	break;
	case 1:
#line 6 "ragel/redcloth_common.rl"
	{ MARK_B(); }
	break;
	case 2:
#line 7 "ragel/redcloth_common.rl"
	{ MARK_ATTR(); }
	break;
	case 3:
#line 9 "ragel/redcloth_common.rl"
	{ STORE("text"); }
	break;
	case 4:
#line 10 "ragel/redcloth_common.rl"
	{ CLEAR_REGS(); RESET_REG(); }
	break;
	case 5:
#line 35 "ragel/redcloth_common.rl"
	{ STORE_ATTR("class"); }
	break;
	case 6:
#line 36 "ragel/redcloth_common.rl"
	{ STORE_ATTR("id"); }
	break;
	case 7:
#line 38 "ragel/redcloth_common.rl"
	{ STORE_ATTR("lang"); }
	break;
	case 8:
#line 39 "ragel/redcloth_common.rl"
	{ STORE_ATTR("style"); }
	break;
	case 9:
#line 20 "ragel/redcloth_attributes.rl"
	{ STORE("name"); }
	break;
	case 10:
#line 21 "ragel/redcloth_attributes.rl"
	{ STORE_B("name_without_attributes"); }
	break;
	case 13:
#line 1 "NONE"
	{te = p+1;}
	break;
	case 14:
#line 16 "ragel/redcloth_attributes.rl"
	{te = p;p--;{ SET_ATTRIBUTES(); }}
	break;
	case 15:
#line 16 "ragel/redcloth_attributes.rl"
	{{p = ((te))-1;}{ SET_ATTRIBUTES(); }}
	break;
	case 16:
#line 25 "ragel/redcloth_attributes.rl"
	{te = p;p--;{ SET_ATTRIBUTES(); }}
	break;
	case 17:
#line 26 "ragel/redcloth_attributes.rl"
	{te = p;p--;{ SET_ATTRIBUTE("name_without_attributes", "name"); }}
	break;
	case 18:
#line 25 "ragel/redcloth_attributes.rl"
	{{p = ((te))-1;}{ SET_ATTRIBUTES(); }}
	break;
	case 19:
#line 26 "ragel/redcloth_attributes.rl"
	{{p = ((te))-1;}{ SET_ATTRIBUTE("name_without_attributes", "name"); }}
	break;
#line 597 "ext/redcloth_scan/redcloth_attributes.c"
		}
	}

_again:
	_acts = _redcloth_attributes_actions + _redcloth_attributes_to_state_actions[cs];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 ) {
		switch ( *_acts++ ) {
	case 11:
#line 1 "NONE"
	{ts = 0;}
	break;
#line 610 "ext/redcloth_scan/redcloth_attributes.c"
		}
	}

	if ( cs == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	if ( p == eof )
	{
	if ( _redcloth_attributes_eof_trans[cs] > 0 ) {
		_trans = _redcloth_attributes_eof_trans[cs] - 1;
		goto _eof_trans;
	}
	}

	_out: {}
	}

#line 37 "ragel/redcloth_attributes.c.rl"

  return regs;
}

VALUE
redcloth_attributes(self, str)
  VALUE self, str;
{
  StringValue(str);
  int cs = redcloth_attributes_en_inline;
  return redcloth_attribute_parser(cs, self, RSTRING_PTR(str), RSTRING_PTR(str) + RSTRING_LEN(str) + 1);
}

VALUE
redcloth_link_attributes(self, str)
  VALUE self, str;
{
  StringValue(str);
  int cs = redcloth_attributes_en_link_says;
  return redcloth_attribute_parser(cs, self, RSTRING_PTR(str), RSTRING_PTR(str) + RSTRING_LEN(str) + 1);
}
