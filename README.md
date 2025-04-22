# lisplab

## 📁 `4plottings`

- **`PPA3.lsp` – Plot Portrait A3**  
  Automates plotting of closed `LWPOLYLINE` entities from the "PRINT_A3" layer to a Portrait A3 PDF. Adjusts plot settings for correct scale and orientation.

- **`PPA4.lsp` – Plot Portrait A4**  
  Similar to `PPA3`, but for Portrait A4. Handles smaller paper size and ensures correct scaling for A4 printing. Uses the "PRINT_A4" layer.

- **`PLA3.lsp` – Plot Landscape A3**  
  Plots closed `LWPOLYLINE` entities from the "PRINT_A3" layer to a Landscape A3 PDF. Supports custom filename input with an option for 'XX' for auto-increment.

- **`PLA4.lsp` – Plot Landscape A4**  
  Similar to `PLA3`, but for Landscape A4. Ensures correct scaling and fitting to A4-sized paper. Uses the "PRINT_A4" layer.

---

> If you modify one file, make sure to update the other three files as well, as they all share similar structures and dependencies. Optionally, if you prefer, you can combine all four scripts into a single `.lsp` file. The combined script can include an initial command selection to choose between different plotting options (Portrait or Landscape, A3 or A4). This allows for greater flexibility and a more streamlined workflow.


