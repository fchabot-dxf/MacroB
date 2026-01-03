%
O1003 (Test Macro - Advanced Pattern Tests)
(Purpose: Comprehensive testing of variables 1153-1193)
(Created: 2026-01-03)
(DDCS Expert Macro Test - Multiple Patterns)

(Test 1: Power of 2 values)
N10 (Write powers of 2 to first 10 variables)
#1153 = 1    (2^0)
#1154 = 2    (2^1)
#1155 = 4    (2^2)
#1156 = 8    (2^3)
#1157 = 16   (2^4)
#1158 = 32   (2^5)
#1159 = 64   (2^6)
#1160 = 128  (2^7)
#1161 = 256  (2^8)
#1162 = 512  (2^9)

N20 G04 P0.5 (Dwell 0.5 seconds)

(Test 2: Negative values test)
N30 (Write negative values)
#1163 = -1
#1164 = -10
#1165 = -100
#1166 = -255
#1167 = -1000

N40 G04 P0.5 (Dwell 0.5 seconds)

(Test 3: Specific bit patterns - common in output control)
N50 (Write common bit patterns)
#1168 = 255  (0xFF - all bits set in byte)
#1169 = 128  (0x80 - MSB only)
#1170 = 15   (0x0F - lower nibble)
#1171 = 240  (0xF0 - upper nibble)
#1172 = 85   (0x55 - alternating bits 01010101)
#1173 = 170  (0xAA - alternating bits 10101010)

N60 G04 P0.5 (Dwell 0.5 seconds)

(Test 4: Decimal values)
N70 (Write decimal test values)
#1174 = 1.5
#1175 = 10.25
#1176 = 100.5
#1177 = 0.001
#1178 = 99.999

N80 G04 P0.5 (Dwell 0.5 seconds)

(Test 5: Fill remaining with incremental pattern)
N90 (Fill variables 1179-1193 with values 1000-1014)
#1 = 1179 (Start variable)
#2 = 1193 (End variable)
#3 = 1000 (Start value)

N100 WHILE [#1 LE #2] DO1
N110   #[#1] = #3
N120   #1 = #1 + 1
N130   #3 = #3 + 1
N140 END1

(Test 6: Verify first and last variable)
N150 (Read back and display - if system supports)
#10 = #1153 (Store first variable value)
#11 = #1193 (Store last variable value)

(Test complete)
N160 M30 (Program end)
%
