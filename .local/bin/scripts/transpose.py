#! /usr/bin/env python3
#
# 2019-07-03 
# Colton Grainger 
# CC-0 Public Domain

"""
Tranpose csv
"""
import pandas as pd
import os
df = pd.DataFrame.from_csv("2019-07-03-minimal.csv")
df.transpose().to_csv("2019-07-03-tranposed-metadata.csv")
