%
O1002 (Test Macro - Loop-based Variable Write)
(Purpose: Use loop to write to variables 1153-1193)
(Created: 2026-01-03)
(DDCS Expert Macro Test - Using WHILE loop)

(Initialize local variables)
N10 #1 = 1153 (Start variable number)
N20 #2 = 1193 (End variable number)
N30 #3 = 100 (Starting value to write)

(Loop through variables and write sequential values)
N40 WHILE [#1 LE #2] DO1
N50   #[#1] = #3 (Write value to variable)
N60   #1 = #1 + 1 (Increment variable number)
N70   #3 = #3 + 1 (Increment value)
N80 END1

(Test complete - Variables 1153-1193 now contain values 100-140)
N90 M30 (Program end)
%
