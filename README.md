# MacroB
Macro building for DDCS EXPERT CNC Control System

## Overview
Collection of G-code macros for DDCS EXPERT CNC controllers, featuring a comprehensive 3D probe macro suite for workpiece setup and measurement.

---

## 3D Probe Macro Suite

Complete set of macros for automated workpiece probing, edge finding, center location, and coordinate system setup.

### Prerequisites
- 3D touch probe installed and calibrated on CNC machine
- DDCS EXPERT controller with macro support
- Probe wired to appropriate input pin

---

## Macro Catalog

### 1. **probe-config** - Configuration & Calibration
Sets up probe parameters and stores them in persistent memory.

**Configurable Parameters:**
- **#56** - Probe tip diameter (mm)
- **#57** - Safe retract distance (mm)
- **#58** - Fast probe feedrate (mm/min)
- **#59** - Slow probe feedrate (mm/min)
- **#60** - Probe backoff distance (mm)
- **#61** - Overtravel distance (mm)

**Usage:**
1. Run macro: `probe-config`
2. Enter calibration values when prompted
3. Values are stored permanently (survive power cycle)
4. Run once, then use other probe macros

**Defaults:**
- Probe diameter: 10.0 mm
- Retract distance: 50.0 mm
- Fast feedrate: 150.0 mm/min
- Slow feedrate: 30.0 mm/min

---

### 2. **probe-corner-finder** - Find Workpiece Corner
Probes X and Y edges to locate a corner and set work zero.

**Features:**
- Corner selection dialogue (1-4)
- Two-axis probing (X and Y)
- Automatic tip radius compensation
- Sets work coordinate system at corner

**Corner Options:**
```
1 = Front Left   (-X -Y)
2 = Front Right  (+X -Y)
3 = Rear Right   (+X +Y)
4 = Rear Left    (-X +Y)
```

**Usage:**
1. Position probe near desired corner
2. Run macro: `probe-corner-finder`
3. Select corner number (1-4)
4. Press START to probe X edge
5. Press START to probe Y edge
6. Press START to set work zero
7. Machine moves to corner position (X0 Y0)

---

### 3. **probe-center-finder** - Find Workpiece Center
Probes opposite edges on X and Y axes to calculate and set work zero at center.

**Features:**
- Probes 4 edges (X-, X+, Y-, Y+)
- Calculates geometric center
- Displays workpiece dimensions
- Uses G4 P-1 infinite dwell for operator control

**Usage:**
1. Position probe near first X edge
2. Run macro: `probe-center-finder`
3. **STEP 1:** Press START → Probes first X edge
4. **STEP 2:** Jog to opposite X edge → Press START
5. **STEP 3:** Jog to first Y edge → Press START
6. **STEP 4:** Jog to opposite Y edge → Press START
7. Press START to set work zero at calculated center
8. Machine moves to center position (X0 Y0)

**Output:**
- Center coordinates (X, Y)
- Workpiece dimensions (width × length)

---

### 4. **probe-rectangle-full** - Complete Rectangle Measurement
Comprehensive 4-edge probing cycle with automatic calculations.

**Features:**
- Guided 4-step probing sequence
- Automatic center calculation
- Workpiece dimension measurement
- Detailed results display
- Progress indicators at each step

**Usage:**
1. Position probe near -X edge
2. Run macro: `probe-rectangle-full`
3. Follow on-screen prompts:
   - **Step 1/4:** Press START → Probe -X edge
   - **Step 2/4:** Jog to +X edge → Press START
   - **Step 3/4:** Jog to -Y edge → Press START
   - **Step 4/4:** Jog to +Y edge → Press START
4. Press START to set work zero at center
5. Machine moves to center position

**Output Display:**
- Center coordinates (X, Y)
- Workpiece size (width × length)
- Individual edge positions
- Step-by-step progress

---

### 5. **probe-edge-single** - Single Edge Finder
Probes a single edge and sets work zero at that edge.

**Features:**
- Quick single-edge setup
- Edge direction selection (1-5)
- Simplified workflow for simple parts

**Edge Options:**
```
1 = -X edge (left)
2 = +X edge (right)
3 = -Y edge (front)
4 = +Y edge (rear)
5 = -Z surface (top)
```

**Usage:**
1. Position probe near desired edge
2. Run macro: `probe-edge-single`
3. Select edge number (1-5)
4. Press START to probe
5. Press START to set work zero at edge

---

### 6. **probe-z-surface** - Z-Axis Top Surface
Finds top surface of workpiece and sets Z zero.

**Features:**
- Two-stage probing (fast then slow)
- Automatic retract after probing
- Safe height positioning

**Usage:**
1. Position probe above workpiece surface
2. Ensure adequate clearance
3. Run macro: `probe-z-surface`
4. Press START to probe surface
5. Press START to set Z zero
6. Probe retracts to 5mm above surface

---

## General Usage Notes

### Safety
- **ALWAYS** verify probe is connected before running macros
- **TEST** with slow feedrates first
- **ENSURE** adequate clearance for probe travel
- **NEVER** exceed machine travel limits
- **VERIFY** probe tip diameter is correctly configured

### Workflow
1. Run `probe-config` first to set calibration values
2. Choose appropriate probe macro for your task:
   - **Quick corner setup** → `probe-corner-finder`
   - **Centered workpiece** → `probe-center-finder`
   - **Full measurement** → `probe-rectangle-full`
   - **Simple edge** → `probe-edge-single`
   - **Z height only** → `probe-z-surface`

### G4 P-1 Infinite Dwell
All macros use `G4 P-1` for infinite dwell, which pauses the program until the operator presses the START button. This provides full control over the probing sequence.

### Variable Storage
- **#56-#61:** Probe configuration (persistent)
- **#100-#110:** Working variables (temporary)
- **#120-#125:** Probed positions (temporary)
- **#130-#131:** Calculated center coordinates
- **#140-#141:** Calculated dimensions
- **#1510-#1512:** Display output values
- **#1505:** Display formatter (-5000 triggers output)
- **#2070:** User input prompt variable

### Coordinate System (DDCS EXPERT Specific)
- Macros set **G54** work coordinate system (WCS) via direct parameter writes
- G54 offsets: **#800** (X), **#801** (Y), **#802** (Z), **#803** (A), **#804** (B)
- G55 offsets: **#810-#814**, G56: **#815-#819**, G57: **#820-#824**, etc.
- **Note:** DDCS EXPERT does NOT support G10 L20 - use direct parameter writes instead
- Previous G54 values are overwritten when running probe macros

---

## Utility Macros

### read-variable
Reads and displays any system variable by address.

### test persistence write / read
Tests variable persistence across power cycles.

---

## Technical Details

**Platform:** DDCS EXPERT M350 CNC Controller
**Language:** G-code macro dialect (DDCS EXPERT specific)
**Probing Commands:** G38.2 (probe toward workpiece)
**Probe Position Variables:** #1925 (X), #1926 (Y), #1927 (Z) - machine coordinates after probe trigger
**Machine Position Variables:** #880 (X), #881 (Y), #882 (Z), #883 (A), #884 (B)
**WCS Offset Setting:** Direct parameter writes to #800-#804 (G54), #810-#814 (G55), etc.
**File Format:** Plain text, no file extension required (.nc optional)
**Encoding:** UTF-8 without BOM, CRLF or LF line endings

### DDCS EXPERT Limitations
- **G10 L20 NOT supported** - causes unwanted motion instead of setting offsets
- **G53 with hardcoded values unreliable** - use incremental moves or variables
- **Variable priming required** - always prime variables before writing #880/#881 to them
- Uses non-standard FANUC variable addresses for WCS offsets

---

## Support

For issues or questions about DDCS EXPERT macro programming:
- [DDCS EXPERT Documentation](https://www.nvcnc.net/ddcs-expert.html)
- [G-code Reference](https://gcodetutor.com/)

---

## Version History

**v1.0** - Initial 3D probe macro suite
- Corner finder with dialogue
- Center finder with full rectangle probing
- Z-axis surface probing
- Configuration management
- Comprehensive documentation
