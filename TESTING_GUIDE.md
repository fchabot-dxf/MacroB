# DDCS Expert Variable Testing Guide

## Overview
This repository contains test macros for DDCS Expert system variables 1153-1193. These macros are designed to test write functionality to this extended variable range.

## Variable Range Information
- **Variable Range**: #1153 - #1193
- **Total Variables**: 41 variables
- **Type**: System variables (likely PMC extended output interface)
- **Access**: Write-enabled for macro programs

## Test Macro Files

### 1. test_variables_1153-1193.nc (O1000)
**Purpose**: Basic sequential write test

**Description**: Writes sequential values 100-140 to variables 1153-1193 respectively.

**Test Pattern**:
- #1153 = 100
- #1154 = 101
- #1155 = 102
- ... (sequential)
- #1193 = 140

**Use Case**: Basic functionality test to verify all variables are writable.

### 2. test_variables_binary.nc (O1001)
**Purpose**: Binary pattern testing

**Description**: Tests three different binary patterns with delays between each:

**Test Patterns**:
1. **All Zeros**: Clears all variables to 0
2. **All Ones**: Sets all variables to 1
3. **Alternating Pattern**: Sets even variables to 0, odd to 1

**Use Case**: Testing output bit control patterns, useful for verifying individual output states.

### 3. test_variables_loop.nc (O1002)
**Purpose**: Loop-based efficient writing

**Description**: Uses WHILE loop to write sequential values 100-140 to variables 1153-1193.

**Features**:
- Demonstrates loop control in DDCS Expert macros
- More efficient code structure
- Easy to modify for different value ranges

**Use Case**: Template for creating custom variable write patterns with loops.

### 4. test_variables_advanced.nc (O1003)
**Purpose**: Comprehensive pattern testing

**Description**: Tests multiple value types and patterns:

**Test Patterns**:
1. **Powers of 2** (variables 1153-1162): Tests binary bit positions (1, 2, 4, 8, 16, ...)
2. **Negative Values** (variables 1163-1167): Tests negative number handling (-1, -10, -100, -255, -1000)
3. **Bit Patterns** (variables 1168-1173): Common bit masks (0xFF, 0x80, 0x0F, 0xF0, 0x55, 0xAA)
4. **Decimal Values** (variables 1174-1178): Tests floating-point (1.5, 10.25, 100.5, 0.001, 99.999)
5. **Incremental Fill** (variables 1179-1193): Sequential values 1000-1014

**Use Case**: Comprehensive testing of different data types and edge cases.

## How to Use These Macros

### Loading Macros to DDCS Expert

1. **File Transfer**:
   - Copy .nc files to USB drive
   - Insert USB into DDCS Expert controller
   - Navigate to File Manager on DDCS screen

2. **Upload to Controller**:
   - Select "Copy" or "Upload" function
   - Choose the macro file (e.g., test_variables_1153-1193.nc)
   - Copy to the macro directory or program directory

### Running the Macros

**Method 1: MDI Mode**
```
- Enter MDI mode
- Type: O1000 (or O1001, O1002, O1003)
- Press CYCLE START
```

**Method 2: Program Mode**
```
- Enter EDIT or AUTO mode
- Load program O1000 (or desired program number)
- Press CYCLE START
```

**Method 3: Call as Subroutine**
```gcode
M98 P1000  (Call O1000 subroutine)
M98 P1001  (Call O1001 subroutine)
```

### Verifying Results

After running a test macro, you can verify the variable values:

1. **Direct Variable Check** (if supported by your controller):
   - Enter MDI mode
   - Use system menu to view variable values
   - Check variables #1153-#1193

2. **Use Variables in Test Code**:
   ```gcode
   #10 = #1153  (Copy to local variable)
   G01 X#10 F100  (Use value in motion command to observe)
   ```

3. **Monitor Outputs** (if variables control physical outputs):
   - Observe connected output devices
   - Check output LED indicators on controller
   - Use multimeter on output terminals

## Troubleshooting

### Error: "Variable Out of Range"
- **Cause**: Variables #1153-#1193 may not be available in your DDCS version
- **Solution**: Check your DDCS Expert manual for supported variable ranges

### Error: "Write Protected Variable"
- **Cause**: Some system variables may be read-only
- **Solution**: Verify variable functionality with DDCS documentation

### Variables Don't Seem to Change
- **Cause**: Variables may require specific PMC ladder logic configuration
- **Solution**: Check PMC configuration and I/O mapping in system parameters

### Program Won't Load
- **Cause**: File format issues or syntax errors
- **Solution**: Ensure files are plain text with proper line endings (CR+LF or LF)

## Customization

### Creating Your Own Test Pattern

Use this template based on test_variables_loop.nc:

```gcode
%
O1099 (Your Custom Test)

#1 = 1153        (Start variable number)
#2 = 1193        (End variable number)
#3 = [your_value] (Your starting value)

WHILE [#1 LE #2] DO1
  #[#1] = #3     (Write your pattern here)
  #1 = #1 + 1
  #3 = [your_increment_logic]
END1

M30
%
```

## Technical Notes

### Variable Number Ranges in DDCS Expert
- **#1-#33**: Local variables (temporary)
- **#100-#149**: Common variables (shared between programs)
- **#500-#999**: Common variables (retained after power-off)
- **#1000+**: System variables (I/O, machine status, etc.)
- **#1153-#1193**: Extended system variables (this test range)

### Macro B Language Features
- Variable assignment: `#100 = 50`
- Arithmetic: `#100 = #101 + #102`
- Comparisons: `#100 EQ 50`, `#100 GT 10`
- Conditionals: `IF [] THEN ... ELSE ... ENDIF`
- Loops: `WHILE [] DO1 ... END1`
- Indirect addressing: `#[#100]` (use value of #100 as variable number)

## Safety Considerations

**WARNING**: If variables #1153-#1193 control physical outputs:
- Ensure machine is in a safe state before running tests
- Verify no dangerous equipment is connected to test outputs
- Be prepared to use Emergency Stop if unexpected behavior occurs
- Test in dry-run or single-step mode first

## Support and Documentation

For official DDCS Expert documentation:
- Website: http://www.ddcnc.com
- Manual: Download from DDCNC official site
- Forum: http://bbs.ddcnc.com (Chinese language)
- Email: Contact Digital Dream Technology support

## References

- Fanuc Macro B Programming Guide
- DDCS Expert User's Manual (Part 1 & 2)
- DDCS Expert System Variables Documentation

## License

These test macros are provided as-is for testing purposes. Use at your own risk.

---

**Created**: 2026-01-03
**Version**: 1.0
**Compatible**: DDCS Expert controllers with Macro B support
