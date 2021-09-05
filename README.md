# TAI_2021_ANIMC

This is the repository for the regular paper **ANIMC: A Soft Approach for Auto-weighted Noisy and Incomplete Multi-view Clustering** published in **IEEE Transactions on Artificial Intelligence (TAI)**  by Xiang Fang, Yuchong Hu, Pan Zhou, and Dapeng Oliver Wu. The [arXiv Version](https://arxiv.org/abs/2011.10331) is available.

## Noisy and Incomplete Multi-view Clustering

Multi-view clustering has wide applications in many image processing scenarios. In these scenarios, original image data often contain missing instances and noises. In this repository, we implement a soft framework Auto-weighted Noisy and Incomplete Multi-view Clustering (ANIMC). 

We conduct extensive experiments on four real-world datasets, and experimental results demonstrate its superior advantages over other state-of-the-art clustering algorithms.
The codes of the compared methods can be found on the authors’ claimed websites.


## File directory

```bash
.
├── main.m				                                               # DEMO file of ANIMC
├── ANIMC.m				                                           # core function of ANIMC
├── scene.mat				                                             # data mat files
├── splitDigitData.m			                                       # construction of incomplete multi-view data
├── init.m				                                               # variable initialization
├── NormalizeFea.m				                                       # regularization of data
├── ClusteringMeasure.m		                                       # clustering performance
├── UpdateV.m                                                    # update variable V
└── bestMap.m, hungarian.m, litekmeans.m, and printResult.m			 # intermediate functions 
```

## Usage

## Recommended operating environment

MATLAB R2019b, Windows 10, 3.30 GHz E3-1225 CPU, and 64 GB main memory.

### Download the ANIMC repository

0. Install the MATLAB. The scripts have been verified in Matlab 2019b.

1. Download this repository via git
    ```bash
    git clone https://github.com/ZeusDavide/TAI_2021_ANIMC.git
    ```
    or download the [zip file](https://github.com/ZeusDavide/TAI_2021_ANIMC/archive/master.zip) manually.
    
2. Get multi-view dataset: the BBCSport dataset from (http://mlg.ucd.ie/datasets/segment.html), the BUAA-VISNIR face dataset from paper "The buaa-visnir face database instructions", the Handwritten digit dataset from (http://archive.ics.uci.edu/ml/datasets.html), and the Outdoor Scene dataset from paper "Experiments on high resolution images towards outdoor scene classification". We only provide the Outdoor Scene dataset "scene.mat" in this repository as an example. For the other datasets in the experiments, please refer to the corresponding links or articles.


3. Add the root folder to the Matlab path before running the scripts.

### Run ANIMC on incomplete multi-view data

To reproduce the experimental results in Section V-C of the paper, we need to run the scripts `main.m`.  


### Run ANIMC on noisy and incomplete multi-view data

To reproduce the experimental results in Section V-D of the paper, we need to run the scripts `main.m` after removing the comment (line 12 to line 20) in main.m.  


### Parameter tuning tips:

- For $\theta$, we set $\theta=0.01$ (i.e., relatively small $\theta$) for $||\bm{V}||_{\theta}$ and $\theta=100$ (i.e., relatively large $\theta$) for $||\bm{A}^{(v)}||_{\theta}$.
- In general, increasing iteration number `time` will promote the clustering performance and consume more time. We recommend its maximum value is 30.

### Citation
If you use this code please cite:

```
@ARTICLE{fangv3h2020,
  author={Fang, Xiang and Hu, Yuchong and Zhou, Pan and Wu, Dapeng Oliver},
  journal={IEEE Transactions on Artificial Intelligence}, 
  title={V$^3$H: View Variation and View Heredity for Incomplete Multiview Clustering}, 
  year={2020},
  volume={1},
  number={3},
  pages={233-247},
  doi={10.1109/TAI.2021.3052425}}
```

## Contact

[Xiang Fang, HUST](xfang9508@gmail.com)
