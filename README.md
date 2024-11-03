# SoilCorrection_Methods
 Correction of soil effects on TOC reflectance
This repository contains the data and code associated with the research article:

**"Separation of the Direct Reflection of Soil from Canopy Spectral Reflectance"**  
**Authors**: Peiqi Yang, Christiaan van der Tol, Jing Liu, Zhigang Liu  
**Journal**: *Remote Sensing of Environment* (link and doi will be provided soon)

The data and code are intended for testing purposes only. For research use, please contact Peiqi Yang at [p.yang@njnu.edu.cn](mailto:p.yang@njnu.edu.cn) or [peiqiyangweb@gmail.com](mailto:peiqiyangweb@gmail.com).

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

## Data Description

The dataset is based on simulations from the SCOPE (Soil-Canopy Observation of Photosynthesis and Energy fluxes) model, covering a variety of parameters as described in **Table 4** of the article (SCOPE-Exp1). The variables include:

- **leaf chlorophyll content** (Cab)
- **Leaf internal structure**
- **Canopy Leaf Area Index** (LAI) and **Leaf Angle Distribution** (LAD)
- **Sun and viewing zenith angles**
- **Relative azimuth angles**
- **Soil reflectance**

### Data Format

The data is stored in MATLAB `.mat` files with a structured format, including the following variables:

- **Soil Reflectance**: Soil spectral reflectance 
- **TOC Reflectance**: Top-of-canopy reflectance 
- ** Soil Single Scattering**: Direct soil reflection to TOC reflectance
- ** Leaf Single Scattering**: Direct scattering of leaves to TOC reflectance
- **Multiple Scattering**: Contribution of multiple scattering to TOC reflectance
- **Canopy LAI**: Canopy leaf area index values
- **Leaf Cab**: Chlorophyll content of leaves

## Code Description

The code provides three methods to estimate the contribution of soil single scattering to TOC reflectance:

1. **Method-RBB**
2. **Method-TBB**
3. **Method-LAB**

For detailed descriptions of these methods, please refer to the corresponding article or contact the corresponding author Peiqi Yang. 
