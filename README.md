# MacroB - DDCS Expert Macro Testing

Test macros for DDCS Expert CNC controller system variables.

## About

This repository contains test macros for writing to DDCS Expert system variables 1153-1193. These macros are designed to verify write functionality to the extended PMC output interface variable range.

## Contents

- **test_variables_1153-1193.nc** (O1000) - Basic sequential write test
- **test_variables_binary.nc** (O1001) - Binary pattern testing (0s, 1s, alternating)
- **test_variables_loop.nc** (O1002) - Loop-based efficient writing
- **test_variables_advanced.nc** (O1003) - Comprehensive pattern testing (powers of 2, negative values, bit patterns, decimals)

## Quick Start

1. Copy the desired .nc file to your DDCS Expert controller via USB
2. Load the program (O1000, O1001, O1002, or O1003)
3. Run in MDI or AUTO mode
4. Verify variable values or observe output behavior

## Documentation

See [TESTING_GUIDE.md](TESTING_GUIDE.md) for detailed information on:
- How to use each test macro
- Variable range specifications
- Customization examples
- Troubleshooting tips
- Safety considerations

## System Requirements

- DDCS Expert CNC controller
- Fanuc Macro B support enabled
- System variables #1153-#1193 available (check your manual)

## About DDCS Expert

DDCS Expert is a high-performance 3-5 axis offline CNC controller by Digital Dream Company, featuring:
- ARM+FPGA architecture
- Linux-based standalone operation
- Fanuc G-code compatibility
- 1MHz output pulse capability

## Support

- Official Site: http://www.ddcnc.com
- Forum: http://bbs.ddcnc.com

## License

Provided as-is for testing purposes. Use at your own risk.
