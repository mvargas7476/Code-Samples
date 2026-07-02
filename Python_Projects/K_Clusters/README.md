# K-Clusters

Two K-means experiments:
- **`K-Cluster_Data.py`** — clusters the UCI BitcoinHeist dataset and computes the sum of squared errors (SSE) with `sklearn.cluster`.
- **`Quantizing_Images.py`** — color-quantizes images with K-means, opens the result, then logs the picture name, original size, cluster count, new size, and a user-supplied description.

## Setup
```bash
python3 -m venv kClusters
source kClusters/bin/activate    # Windows: kClusters\Scripts\activate
pip3 install -r requirements.txt
python3 K-Cluster_Data.py       # or: python3 Quantizing_Images.py
```

## Notes
As `k` increases, SSE drops — more clusters means points sit closer to their centroids. Results are written to `K-Cluster_Log.txt` and `Quantizing_Images_Log.txt`.

## Libraries
pandas · numpy · scikit-learn · scikit-image · matplotlib
