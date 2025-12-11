import pydicom
import numpy as np
import nibabel as nib
import pandas as pd

def load_dicom(path: str) -> np.ndarray:
    return pydicom.dcmread(path)

def load_nifti(path: str) -> np.ndarray:
    return nib.load(path).get_fdata()

def load_parquet(path: str) -> pd.DataFrame:
    return pd.read_parquet(path)
