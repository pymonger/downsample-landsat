# downsample-landsat
Example CWL workflow calling a papermilled notebook.

## Run Jupyter Lab to view, edit and/or execute the algorithm notebook:
1. Start up Jupyter Lab in a docker container:
   ```
   git clone https://github.com/pymonger/downsample-landsat.git
   cd downsample-landsat
   docker run -p 8888:8888 -v ${PWD}:/home/jovyan/downsample-landsat \
     pymonger/downsample-landsat:latest jupyter lab --ip 0.0.0.0
   ```
1. Open the `downsample_landsat.ipynb` notebook and run it.

## Building the container image
```
pip install jupyter-repo2docker
git clone https://github.com/pymonger/downsample-landsat.git
cd downsample-landsat
repo2docker --user-id 1000 --user-name jovyan \
  --target-repo-dir /home/jovyan/downsample-landsat \
  --no-run --image-name pymonger/downsample-landsat:latest .
```

## Running cwltool

### Prerequisites

1. Clone repo:
   ```
   cd /tmp
   git clone https://github.com/pymonger/downsample-landsat.git
   cd downsample-landsat
   ```
1. Create virtualenv:
   ```
   virtualenv env
   source env/bin/activate
   ```
1. Install `cwltool`:
   ```
   pip install cwltool
   ```

### Run stage-in example
1. Run cwltool (to run singularity instead of docker, add `--singularity` option):
   ```
   cwltool --no-match-user --no-read-only stage_in.cwl stage_in-inputs.yml 
   ```

   Output should look similar to this:

   ```
   INFO /Users/pymonger/dev/downsample-landsat/env/bin/cwltool 3.1.20220224085855
   INFO Resolved 'stage_in.cwl' to 'file:///Users/pymonger/dev/downsample-landsat/stage_in.cwl'
   INFO [job stage_in.cwl] /private/tmp/docker_tmpmve851ng$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpmve851ng,target=/aVKurX \
       --mount=type=bind,source=/private/tmp/docker_tmp6ebtuzts,target=/tmp \
       --workdir=/aVKurX \
       --rm \
       --cidfile=/private/tmp/docker_tmpw5t0r2ia/20220316071941-947315.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/aVKurX \
       pymonger/downsample-landsat:2.0.3 \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/stage_in.ipynb output_nb.ipynb --parameters input_url "https://github.com/pymonger/downsample-landsat/releases/download/1.0.0/LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF"
   Input Notebook:  /home/jovyan/downsample-landsat/stage_in.ipynb
   Output Notebook: output_nb.ipynb
   Generating grammar tables from /srv/conda/envs/notebook/lib/python3.7/site-packages/blib2to3/Grammar.txt
   Writing grammar tables to /aVKurX/.cache/black/22.1.0/Grammar3.7.12.final.0.pickle
   Writing failed: [Errno 2] No such file or directory: '/aVKurX/.cache/black/22.1.0/tmpf2oy2_wy'
   Generating grammar tables from /srv/conda/envs/notebook/lib/python3.7/site-packages/blib2to3/PatternGrammar.txt
   Writing grammar tables to /aVKurX/.cache/black/22.1.0/PatternGrammar3.7.12.final.0.pickle
   Writing failed: [Errno 2] No such file or directory: '/aVKurX/.cache/black/22.1.0/tmp33lqvaka'
   Executing:   0%|          | 0/10 [00:00<?, ?cell/s]Executing notebook with kernel: python3
   Executing: 100%|██████████| 10/10 [00:10<00:00,  1.03s/cell]
   INFO [job stage_in.cwl] Max memory used: 1985MiB
   INFO [job stage_in.cwl] completed success
   {
       "image_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF",
           "basename": "LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF",
           "class": "File",
           "checksum": "sha1$04fdac42fb1affef29ef1d986c5c1d4112edf1d6",
           "size": 2454136,
           "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF"
       },
       "output_nb_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/output_nb.ipynb",
           "basename": "output_nb.ipynb",
           "class": "File",
           "checksum": "sha1$bfb3661961b6b3b50ba6283002162f495dde7e8b",
           "size": 7347,
           "path": "/Users/pymonger/dev/downsample-landsat/output_nb.ipynb"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the `LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF` image file was created:
   ```
   ls -ltr LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF
   ```

   Output should look similar to this:
   ``` 
   -rw-r--r--  1 pymonger  wheel  2454136 Mar 16 07:19 LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF
   ```
   You can visualize the `LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF` file in QGIS.

### Run downsample-landsat example
Building off of the previous stage-in example:
1. Ensure that the `LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF` image file exists.
   If not, run the `stage-in` example above.
1. Run cwltool (to run singularity instead of docker, add `--singularity` option):
   ```
   cwltool --no-match-user --no-read-only downsample_landsat.cwl downsample_landsat-inputs.yml 
   ```

   Output should look similar to this:

   ```
   INFO /Users/pymonger/dev/downsample-landsat/env/bin/cwltool 3.1.20220224085855
   INFO Resolved 'downsample_landsat.cwl' to 'file:///Users/pymonger/dev/downsample-landsat/downsample_landsat.cwl'
   INFO [job downsample_landsat.cwl] /private/tmp/docker_tmpchxpnnbm$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpchxpnnbm,target=/kfDhmD \
       --mount=type=bind,source=/private/tmp/docker_tmpxdhpp8w4,target=/tmp \
       --mount=type=bind,source=/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF,target=/kfDhmD/LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF,readonly \
       --workdir=/kfDhmD \
       --net=none \
       --rm \
       --cidfile=/private/tmp/docker_tmphmisivqs/20220316072201-265958.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/kfDhmD \
       pymonger/downsample-landsat:2.0.3 \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/downsample_landsat.ipynb output_nb.ipynb --parameters input_file "LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF" --parameters min_spin_time "20" --parameters max_spin_time "40"
   Input Notebook:  /home/jovyan/downsample-landsat/downsample_landsat.ipynb
   Output Notebook: output_nb.ipynb
   Generating grammar tables from /srv/conda/envs/notebook/lib/python3.7/site-packages/blib2to3/Grammar.txt
   Writing grammar tables to /kfDhmD/.cache/black/22.1.0/Grammar3.7.12.final.0.pickle
   Writing failed: [Errno 2] No such file or directory: '/kfDhmD/.cache/black/22.1.0/tmp4xm6wn53'
   Generating grammar tables from /srv/conda/envs/notebook/lib/python3.7/site-packages/blib2to3/PatternGrammar.txt
   Writing grammar tables to /kfDhmD/.cache/black/22.1.0/PatternGrammar3.7.12.final.0.pickle
   Writing failed: [Errno 2] No such file or directory: '/kfDhmD/.cache/black/22.1.0/tmp4e1xlywx'
   Executing:   0%|          | 0/14 [00:00<?, ?cell/s]Executing notebook with kernel: python3
   Executing: 100%|██████████| 14/14 [00:37<00:00,  2.68s/cell]
   INFO [job downsample_landsat.cwl] Max memory used: 2693MiB
   INFO [job downsample_landsat.cwl] completed success
   {
       "dataset_dir": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled",
           "basename": "LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png",
                   "basename": "LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png",
                   "checksum": "sha1$1a61fa484cd51240f4cf26598eccd928475ee45c",
                   "size": 37187,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json",
                   "basename": "LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json",
                   "checksum": "sha1$44b316a811bfcd38a1148f0445c199f1b673fb12",
                   "size": 3229,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF",
                   "basename": "LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF",
                   "checksum": "sha1$fcf67dac89fa0e660040f40e20ff51e8af4922a4",
                   "size": 20577,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF"
               }
           ],
           "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled"
       },
       "output_nb_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/output_nb.ipynb",
           "basename": "output_nb.ipynb",
           "class": "File",
           "checksum": "sha1$ebc8887d49610f933aa07372cda44bf7b351ddad",
           "size": 12307,
           "path": "/Users/pymonger/dev/downsample-landsat/output_nb.ipynb"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the `LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled` dataset directory was created:
   ```
   ls -ltr LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/
   ```

   Output should look similar to this:
   ``` 
   total 136
   -rw-r--r--  1 pymonger  wheel  20577 Mar 16 07:22 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF
   -rw-r--r--  1 pymonger  wheel  37187 Mar 16 07:22 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png
   -rw-r--r--  1 pymonger  wheel   3229 Mar 16 07:22 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json
   ```
   You can visualize the `LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF` file in QGIS.

### Run stage-out example

Building off of the previous dowsample-landsat example:
1. Ensure that the `LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled` dataset directory exists.
   If not, run the `downsample-landsat` example above.
1. Copy the `stage_out-inputs.yml.tmpl` file to `stage_out-inputs.yml`:
   ```
   cp stage_out-inputs.yml.tmpl stage_out-inputs.yml
   ```

   then edit `stage_out-inputs.yml`:
   ```
   vi stage_out-inputs.yml
   ```

   and insert the values for:
   - `aws_access_key_id`
   - `aws_secret_access_key`

   These values can be copied from your valid `$HOME/.aws/credentials` file.
1. Run cwltool (to run singularity instead of docker, add `--singularity` option):
   ```
   cwltool stage_out.cwl stage_out-inputs.yml 
   ```

   Output should look similar to this:

   ```
   INFO /Users/pymonger/dev/downsample-landsat/env/bin/cwltool 3.1.20220224085855
   INFO Resolved 'stage_out.cwl' to 'file:///Users/pymonger/dev/downsample-landsat/stage_out.cwl'
   stage_out.cwl:8:3: Warning: checking item
                      Warning:   Field `class` contains undefined reference to
                      `http://commonwl.org/cwltool#Secrets`
   INFO stage_out.cwl:8:3: Unknown hint http://commonwl.org/cwltool#Secrets
   INFO [job stage_out.cwl] /private/tmp/docker_tmpho5gwdv_$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpho5gwdv_,target=/cdZWtz \
       --mount=type=bind,source=/private/tmp/docker_tmplzc1mhtb,target=/tmp \
       --mount=type=bind,source=/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled,target=/var/lib/cwl/stg7f446d64-29d1-4990-ab5c-37a7c81bacd6/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled,readonly \
       --workdir=/cdZWtz \
       --read-only=true \
       --user=503:20 \
       --rm \
       --cidfile=/private/tmp/docker_tmpsm7hcabo/20220316072513-222050.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/cdZWtz \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg7f446d64-29d1-4990-ab5c-37a7c81bacd6/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled s3://hysds-dataset-bucket-gman-test/test/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled'
   upload: ../var/lib/cwl/stg7f446d64-29d1-4990-ab5c-37a7c81bacd6/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json to s3://hysds-dataset-bucket-gman-test/test/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json
   upload: ../var/lib/cwl/stg7f446d64-29d1-4990-ab5c-37a7c81bacd6/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF to s3://hysds-dataset-bucket-gman-test/test/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF
   upload: ../var/lib/cwl/stg7f446d64-29d1-4990-ab5c-37a7c81bacd6/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png to s3://hysds-dataset-bucket-gman-test/test/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png
   INFO [job stage_out.cwl] Max memory used: 684MiB
   INFO [job stage_out.cwl] completed success
   {}
   INFO Final process status is success
   ```
1. Verify that the`LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled` dataset directory was staged to the 
   S3 bucket location.
   ```
   aws s3 ls $(grep base_dataset_url stage_out-inputs.yml | awk '{print $2}')/$(grep path stage_out-inputs.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2022-03-16 07:25:17      20577 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF
   2022-03-16 07:25:17      37187 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png
   2022-03-16 07:25:17       3229 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json
   ```

### Run 3-step workflow (stage-in, downsample-landsat & stage-out) example
Now that we've seen the individual steps at work, we can proceed with running them in 
a CWL workflow. The following image depicts the graph visualiation (dot) of the
DAG workflow.

![workflow](images/workflow.png?raw=true "workflow")

1. Clean out any artifacts that were left as a result of running the previous examples:
   ```
   rm -rf LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled *-stderr.txt *-stdout.txt output_nb.ipynb
   ```
1. Copy the `workflow-inputs.yml.tmpl` file to `workflow-inputs.yml`:
   ```
   cp workflow-inputs.yml.tmpl workflow-inputs.yml
   ```

   then edit `workflow-inputs.yml`:
   ```
   vi workflow-inputs.yml
   ```

   and insert the values for:
   1. `workflow_aws_access_key_id`
   1. `workflow_aws_secret_access_key`

   These values can be copied from your valid `$HOME/.aws/credentials` file.
1. Run cwltool (to run singularity instead of docker, add `--singularity` option):
   ```
   cwltool --no-match-user --no-read-only workflow.cwl workflow-inputs.yml
   ```

   Output should look similar to this:

   ```
   INFO /Users/pymonger/dev/downsample-landsat/env/bin/cwltool 3.1.20220224085855
   INFO Resolved 'workflow.cwl' to 'file:///Users/pymonger/dev/downsample-landsat/workflow.cwl'
   workflow.cwl:8:3: Warning: checking item
                     Warning:   Field `class` contains undefined reference to
                     `http://commonwl.org/cwltool#Secrets`
   INFO workflow.cwl:8:3: Unknown hint http://commonwl.org/cwltool#Secrets
   stage_out.cwl:8:3: Warning: checking item
                      Warning:   Field `class` contains undefined reference to
                      `http://commonwl.org/cwltool#Secrets`
   INFO stage_out.cwl:8:3: Unknown hint http://commonwl.org/cwltool#Secrets
   INFO [workflow ] start
   INFO [workflow ] starting step stage_in
   INFO [step stage_in] start
   INFO [job stage_in] /private/tmp/docker_tmpwnlnw4ma$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpwnlnw4ma,target=/CCnvFQ \
       --mount=type=bind,source=/private/tmp/docker_tmp23jkqho8,target=/tmp \
       --workdir=/CCnvFQ \
       --rm \
       --cidfile=/private/tmp/docker_tmp0nskcqmr/20220316072813-213104.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/CCnvFQ \
       pymonger/downsample-landsat:2.0.3 \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/stage_in.ipynb output_nb.ipynb --parameters input_url "https://github.com/pymonger/downsample-landsat/releases/download/1.0.0/LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF"
   Input Notebook:  /home/jovyan/downsample-landsat/stage_in.ipynb
   Output Notebook: output_nb.ipynb
   Generating grammar tables from /srv/conda/envs/notebook/lib/python3.7/site-packages/blib2to3/Grammar.txt
   Writing grammar tables to /CCnvFQ/.cache/black/22.1.0/Grammar3.7.12.final.0.pickle
   Writing failed: [Errno 2] No such file or directory: '/CCnvFQ/.cache/black/22.1.0/tmpbyebgcir'
   Generating grammar tables from /srv/conda/envs/notebook/lib/python3.7/site-packages/blib2to3/PatternGrammar.txt
   Writing grammar tables to /CCnvFQ/.cache/black/22.1.0/PatternGrammar3.7.12.final.0.pickle
   Writing failed: [Errno 2] No such file or directory: '/CCnvFQ/.cache/black/22.1.0/tmpodt7dq20'
   Executing:   0%|          | 0/10 [00:00<?, ?cell/s]Executing notebook with kernel: python3
   Executing: 100%|██████████| 10/10 [00:04<00:00,  2.42cell/s]
   INFO [job stage_in] Max memory used: 2028MiB
   INFO [job stage_in] completed success
   INFO [step stage_in] completed success
   INFO [workflow ] starting step downsample_landsat
   INFO [step downsample_landsat] start
   INFO [job downsample_landsat] /private/tmp/docker_tmp5mbytoqg$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp5mbytoqg,target=/CCnvFQ \
       --mount=type=bind,source=/private/tmp/docker_tmprmjz3b6i,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmpwnlnw4ma/LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF,target=/CCnvFQ/LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF,readonly \
       --workdir=/CCnvFQ \
       --net=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpflfj1gkn/20220316072819-607421.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/CCnvFQ \
       pymonger/downsample-landsat:2.0.3 \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/downsample_landsat.ipynb output_nb.ipynb --parameters input_file "LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF" --parameters min_spin_time "15" --parameters max_spin_time "30"
   Input Notebook:  /home/jovyan/downsample-landsat/downsample_landsat.ipynb
   Output Notebook: output_nb.ipynb
   Generating grammar tables from /srv/conda/envs/notebook/lib/python3.7/site-packages/blib2to3/Grammar.txt
   Writing grammar tables to /CCnvFQ/.cache/black/22.1.0/Grammar3.7.12.final.0.pickle
   Writing failed: [Errno 2] No such file or directory: '/CCnvFQ/.cache/black/22.1.0/tmpdpjoz9sz'
   Generating grammar tables from /srv/conda/envs/notebook/lib/python3.7/site-packages/blib2to3/PatternGrammar.txt
   Writing grammar tables to /CCnvFQ/.cache/black/22.1.0/PatternGrammar3.7.12.final.0.pickle
   Writing failed: [Errno 2] No such file or directory: '/CCnvFQ/.cache/black/22.1.0/tmphdocj8wh'
   Executing:   0%|          | 0/14 [00:00<?, ?cell/s]Executing notebook with kernel: python3
   Executing: 100%|██████████| 14/14 [00:20<00:00,  1.45s/cell]
   INFO [job downsample_landsat] Max memory used: 3388MiB
   INFO [job downsample_landsat] completed success
   INFO [step downsample_landsat] completed success
   INFO [workflow ] starting step stage_out
   INFO [step stage_out] start
   INFO [job stage_out] /private/tmp/docker_tmpomyfyxc3$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpomyfyxc3,target=/CCnvFQ \
       --mount=type=bind,source=/private/tmp/docker_tmpvhgcumoo,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmp5mbytoqg/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled,target=/var/lib/cwl/stg26824e32-b21e-4f8c-9908-ecda262df49b/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled,readonly \
       --workdir=/CCnvFQ \
       --rm \
       --cidfile=/private/tmp/docker_tmp5eb_pxs9/20220316072842-378321.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/CCnvFQ \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg26824e32-b21e-4f8c-9908-ecda262df49b/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled s3://hysds-dataset-bucket-gman-test/test/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled'
   upload: ../var/lib/cwl/stg26824e32-b21e-4f8c-9908-ecda262df49b/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json to s3://hysds-dataset-bucket-gman-test/test/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json
   upload: ../var/lib/cwl/stg26824e32-b21e-4f8c-9908-ecda262df49b/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF to s3://hysds-dataset-bucket-gman-test/test/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF
   upload: ../var/lib/cwl/stg26824e32-b21e-4f8c-9908-ecda262df49b/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png to s3://hysds-dataset-bucket-gman-test/test/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png
   INFO [job stage_out] Max memory used: 403MiB
   INFO [job stage_out] completed success
   INFO [step stage_out] completed success
   INFO [workflow ] completed success
   {
       "final_dataset_dir": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled",
           "basename": "LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png",
                   "basename": "LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png",
                   "checksum": "sha1$fb0d96740ec6f89741ff94f66f2555f93e7236ff",
                   "size": 37187,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json",
                   "basename": "LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json",
                   "checksum": "sha1$44b316a811bfcd38a1148f0445c199f1b673fb12",
                   "size": 3229,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF",
                   "basename": "LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF",
                   "checksum": "sha1$fcf67dac89fa0e660040f40e20ff51e8af4922a4",
                   "size": 20577,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF"
               }
           ],
           "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the `LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled` dataset directory exists locally:
   ```
   ls -ltr LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/
   ```

   Output should look similar to this:
   ```
   total 136
   -rw-r--r--  1 pymonger  wheel  20577 Mar 16 07:28 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF
   -rw-r--r--  1 pymonger  wheel  37187 Mar 16 07:28 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png
   -rw-r--r--  1 pymonger  wheel   3229 Mar 16 07:28 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json
   ```

   and was staged to the S3 bucket location:
   ```
   aws s3 ls $(grep workflow_base_dataset_url workflow-inputs.yml | awk '{print $2}')/$(ls -d *_downsampled)/
   ```

   Output should look similar to this:
   ```
   2022-03-16 07:28:45      20577 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF
   2022-03-16 07:28:45      37187 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png
   2022-03-16 07:28:45       3229 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json
   ```

## Running calrissian

### Run 3-step workflow (stage-in, downsample-landsat & stage-out) example on K8s (Kubernetes) via Calrissian
Now that we've seen the execution of the workflow on a local machine, it's time to execute the
workflow on a K8s cluster. Once again the following image depicts the graph visualiation (dot) 
of the DAG workflow.

![workflow](images/workflow.png?raw=true "workflow")

In the previous section, we used `cwltool` to execute the CWL workflow which proceeded to
spawn 2 containers corresponding to the 2 steps in the workflow. In this example, we submit
a K8s job to run Calrissian, a CWL-compliant implementation that supports execution of
workflows and their composite steps as K8s jobs.

1. Clean out any artifacts that were left as a result of running the previous examples:
   ```
   rm -rf LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled *-stderr.txt *-stdout.txt output_nb.ipynb
   ```
1. Create namespace and roles:
   ```
   NAMESPACE_NAME=dev
   kubectl create namespace "$NAMESPACE_NAME"
   kubectl --namespace="$NAMESPACE_NAME" create role pod-manager-role \
     --verb=create,patch,delete,list,watch --resource=pods
   kubectl --namespace="$NAMESPACE_NAME" create role log-reader-role \
     --verb=get,list --resource=pods/log
   kubectl --namespace="$NAMESPACE_NAME" create rolebinding pod-manager-default-binding \
     --role=pod-manager-role --serviceaccount=${NAMESPACE_NAME}:default
   kubectl --namespace="$NAMESPACE_NAME" create rolebinding log-reader-default-binding \
     --role=log-reader-role --serviceaccount=${NAMESPACE_NAME}:default
   ```
1. Create secret containing AWS creds. Set the following env variables manually:
   ```
   export aws_access_key_id="<your AWS access key ID>"
   export aws_secret_access_key="<your AWS secret access key>"
   ```

   Then write them to a K8s secret: 
   ```
   kubectl --namespace="$NAMESPACE_NAME" create secret generic aws-creds \
     --from-literal=aws_access_key_id="$aws_access_key_id" \
     --from-literal=aws_secret_access_key="$aws_secret_access_key"
   ```
1. Create volumes (this is the equivalent to creating a unique work directory for the workflow execution job):
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f k8s/VolumeClaims.yaml
   ```

   If on AKS (Azure Kubernetes Service), see the AKS caveat below to create a
   custom storage class that supports the `ReadWriteMany` mode and modifies
   its mount options to work with the pod UID/GID. Then run this afterwards:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f k8s/VolumeClaims.yaml
   ```

   If on GKE (Google Kubernetes Engine), see the GKE caveat below to create an
   NFS server to support `ReadWriteMany` and run this afterwards:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f k8s/gke/VolumeClaims.yaml
   ```

   If on EKS (Elastic Kubernetes Service), see the EKS caveat below to create
   PersistentVolumeClaims backed by EFS (Elastic File Service) to support 
   `ReadWriteMany` and run this afterwards:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f k8s/eks/VolumeClaims.yaml
   ```

   If your K8s cluster is configured with the `longhorn` storage class,
   see the longhorn caveat below to create PersistentVolumeClaims backed 
   by that storage class to support `ReadWriteMany` and run this afterwards:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f k8s/longhorn/VolumeClaims.yaml
   ```
1. Run the workflow:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f k8s/CalrissianJob.yaml
   ```

   Monitor execution with:
   ```
   while true; do kubectl --namespace="$NAMESPACE_NAME" logs -f job/calrissian-job && break; sleep 2; done
   ```

   Additionally, note the jobs and pods that were created by Calrissian as a result
   of the workflow submission:
   ```
   watch kubectl --namespace="$NAMESPACE_NAME" get jobs
   watch kubectl --namespace="$NAMESPACE_NAME" get pods
   ```
1. Once the workflow execution is done, you can copy over the STDOUT/STDERR logs and
   output files. In one terminal window run:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f k8s/AccessVolumes.yaml
   ```

   Then copy out the output-data directory through this pod:
   ```
   kubectl --namespace="$NAMESPACE_NAME" cp access-pv:/calrissian/output-data output-data
   ```
1. Verify that the`LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled` dataset directory exists in the output-data directory:
   ```
   ls -ltr output-data/LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled/
   ```

   Output should look similar to this:
   ```
   total 136
   -rw-r--r--  1 pymonger  staff   3229 Mar 16 07:34 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json
   -rw-r--r--  1 pymonger  staff  37187 Mar 16 07:34 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png
   -rw-r--r--  1 pymonger  staff  20577 Mar 16 07:34 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF
   ```

   and was staged to the S3 bucket location:
   ```
   aws s3 ls $(grep base_dataset_url stage_out-inputs.yml | awk '{print $2}')/$(grep path stage_out-inputs.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2022-03-16 07:28:45      20577 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.TIF
   2022-03-16 07:28:45      37187 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.browse.png
   2022-03-16 07:28:45       3229 LC08_L1TP_065016_20130724_20170309_01_T1_BQA_downsampled.met.json
   ```

### K8s Caveats

#### Azure Kubernetes Service

The default storage class utilizes azure disk which doesn't support `ReadWriteMany` which is required by
Calrissian. The azurefile storage class supports `ReadWriteMany` however it specifies `uid: 0` and `gid: 0`
which can give rise to permission issues in the pods spawned by Calrissian. Here we follow the instructions
at https://docs.microsoft.com/en-us/azure/aks/azure-files-dynamic-pv to create this custom storage class
and set it as the default storage class:

```
$ kubectl --namespace="$NAMESPACE_NAME" create -f k8s/aks/azure-file-sc.yaml
$ kubectl get storageclass
NAME                     PROVISIONER          RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
azurefile                file.csi.azure.com   Delete          Immediate              true                   37m
azurefile-csi            file.csi.azure.com   Delete          Immediate              true                   37m
azurefile-csi-premium    file.csi.azure.com   Delete          Immediate              true                   37m
azurefile-premium        file.csi.azure.com   Delete          Immediate              true                   37m
default (default)        disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   37m
managed                  disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   37m
managed-csi              disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   37m
managed-csi-premium      disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   37m
managed-premium          disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   37m
my-azurefile             file.csi.azure.com   Delete          Immediate              false                  23m

$ kubectl patch storageclass azurefile -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
storageclass.storage.k8s.io/default patched

$ kubectl patch storageclass my-azurefile -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
storageclass.storage.k8s.io/my-azurefile patched

$ kubectl get storageclass
NAME                     PROVISIONER          RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
azurefile                file.csi.azure.com   Delete          Immediate              true                   40m
azurefile-csi            file.csi.azure.com   Delete          Immediate              true                   40m
azurefile-csi-premium    file.csi.azure.com   Delete          Immediate              true                   40m
azurefile-premium        file.csi.azure.com   Delete          Immediate              true                   40m
default                  disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   40m
managed                  disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   40m
managed-csi              disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   40m
managed-csi-premium      disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   40m
managed-premium          disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   40m
my-azurefile (default)   file.csi.azure.com   Delete          Immediate              false                  25m
```
After this, continue with step 5 above:
```
kubectl --namespace="$NAMESPACE_NAME" create -f k8s/VolumeClaims.yaml
```

#### Google Kubernetes Engine

The default storage class utilizes Google persistent disk which doesn't support `ReadWriteMany` 
which is required by Calrissian. Google Cloud Filestore resolves this issue but it is a costly
solution. The alternative is to run NFS in the GKE cluster as described here:
https://medium.com/@Sushil_Kumar/readwritemany-persistent-volumes-in-google-kubernetes-engine-a0b93e203180

Run the following to proceed with setting up an NFS server on your GKE cluster:
```
# provision a GCP persistent disk
gcloud compute disks create --size=10GB --zone=us-west2-a nfs-disk

# provision NFS deployment
kubectl create -f k8s/gke/nfs-server-deployment.yaml

# make NFS server accessible at a fixed IP/DNS
kubectl create -f k8s/gke/nfs-clusterip-service.yaml
```
After this, continue with step 5 above but instead use the `gke/VolumeClaims.yaml` instead:
```
kubectl --namespace="$NAMESPACE_NAME" create -f k8s/gke/VolumeClaims.yaml
```

#### Elastic Kubernetes Service

The default storage class in EKS doesn't support `ReadWriteMany` which is required by 
Calrissian. To accomodate this requirement, we can use EFS to provide `ReadWriteMany`
volumes:
https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html

Continue with step 5 above but instead use the `k8s/eks/VolumeClaims.yaml` instead:
```
kubectl --namespace="$NAMESPACE_NAME" create -f k8s/eks/VolumeClaims.yaml
```

#### Longhorn

The `longhorn` storage class (https://longhorn.io/) is a third-party Kubernetes 
plugin that provides persistent storage with `ReadWriteMany` which is required 
by Calrissian.

Continue with step 5 above but instead use the `k8s/longhorn/VolumeClaims.yaml` instead:
```
kubectl --namespace="$NAMESPACE_NAME" create -f k8s/longhorn/VolumeClaims.yaml
```

### Landsat 8 Datasets

Per https://www.usgs.gov/landsat-missions/landsat-collections:

> NOTE: Landsat Collection 1 based forward processing ended December 31, 2021. As of 
> January 1, 2022, all new Landsat acquisitions are processed into the Collection 2
> inventory structure only. Collection 1 products will remain available for search
> and download until December 31, 2022. 
>
> Users are encouraged to migrate their workflow to Landsat Collection 2 at their
> earliest convenience. Due to advancements in data processing and algorithm
> development, users are discouraged from using Collection 1 and Collection 2
> interchangeably within the same workflow.

If the above workflow fails to download the default Landsat 8 granule, check that
it still exists in the s3://landsat-pds bucket and was not removed/replaced as a
result of the collection 2 forward processing.

NOTE: Due to the variability of data availability in the s3://landsat-pds bucket,
the workflows above use a granule that has been attached as an asset to the 1.0.0
release:

https://github.com/pymonger/downsample-landsat/releases/download/1.0.0/LC08_L1TP_065016_20130724_20170309_01_T1_BQA.TIF

This will ensure that future runs of this workflow will not be broken by the
changes to the s3://landsat-pds bucket.
