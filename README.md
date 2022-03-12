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
   INFO /Users/pymonger/dev/downsample-landsat/env/bin/cwltool 3.1.20220217222804
   INFO Resolved 'stage_in.cwl' to 'file:///Users/pymonger/dev/downsample-landsat/stage_in.cwl'
   INFO [job stage_in.cwl] /private/tmp/docker_tmp24xdxpjo$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp24xdxpjo,target=/yVvPPt \
       --mount=type=bind,source=/private/tmp/docker_tmpue4sakfc,target=/tmp \
       --workdir=/yVvPPt \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmp0vx7ymle/20220302125605-425913.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/yVvPPt \
       pymonger/downsample-landsat:2.0.0 \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/stage_in.ipynb output_nb.ipynb --parameters input_url "https://s3-us-west-2.amazonaws.com/landsat-pds/c1/L8/065/045/LC08_L1TP_065045_20210714_20210721_01_T1/LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF" > /private/tmp/docker_tmp24xdxpjo/stage_in-stdout.txt 2> /private/tmp/docker_tmp24xdxpjo/stage_in-stderr.txt
   INFO [job stage_in.cwl] Max memory used: 2054MiB
   INFO [job stage_in.cwl] completed success
   {
       "image_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF",
           "basename": "LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF",
           "class": "File",
           "checksum": "sha1$433786a60356cfef0d99c24144db98eb79686a37",
           "size": 1997366,
           "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF"
       },
       "output_nb_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/output_nb.ipynb",
           "basename": "output_nb.ipynb",
           "class": "File",
           "checksum": "sha1$1a0f8081a85f4f652f9c872ecd68fd909a02a60e",
           "size": 7307,
           "path": "/Users/pymonger/dev/downsample-landsat/output_nb.ipynb"
       },
       "stderr_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/stage_in-stderr.txt",
           "basename": "stage_in-stderr.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/pymonger/dev/downsample-landsat/stage_in-stderr.txt"
       },
       "stdout_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/stage_in-stdout.txt",
           "basename": "stage_in-stdout.txt",
           "class": "File",
           "checksum": "sha1$75b9ecef258f8d4a687c64d80a3da76f282c31f3",
           "size": 1057,
           "path": "/Users/pymonger/dev/downsample-landsat/stage_in-stdout.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the `LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF` image file was created:
   ```
   ls -ltr LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF
   ```

   Output should look similar to this:
   ``` 
   -rw-r--r--  1 pymonger  wheel  1997366 Mar  2 12:56 LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF
   ```
   You can visualize the `LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF` file in QGIS.

### Run downsample-landsat example
Building off of the previous stage-in example:
1. Ensure that the `LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF` image file exists.
   If not, run the `stage-in` example above.
1. Run cwltool (to run singularity instead of docker, add `--singularity` option):
   ```
   cwltool --no-match-user --no-read-only downsample_landsat.cwl downsample_landsat-inputs.yml 
   ```

   Output should look similar to this:

   ```
   INFO /Users/pymonger/dev/downsample-landsat/env/bin/cwltool 3.1.20220217222804
   INFO Resolved 'downsample_landsat.cwl' to 'file:///Users/pymonger/dev/downsample-landsat/downsample_landsat.cwl'
   INFO [job downsample_landsat.cwl] /private/tmp/docker_tmpr5ebt491$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpr5ebt491,target=/tpDYGB \
       --mount=type=bind,source=/private/tmp/docker_tmp2n4bly9w,target=/tmp \
       --mount=type=bind,source=/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF,target=/tpDYGB/LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF,readonly \
       --workdir=/tpDYGB \
       --net=none \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmp2iul8hnj/20220302130031-621716.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/tpDYGB \
       pymonger/downsample-landsat:2.0.0 \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/downsample_landsat.ipynb output_nb.ipynb --parameters input_file "LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF" --parameters min_spin_time "20" --parameters max_spin_time "40" > /private/tmp/docker_tmpr5ebt491/downsample_landsat-stdout.txt 2> /private/tmp/docker_tmpr5ebt491/downsample_landsat-stderr.txt
   INFO [job downsample_landsat.cwl] Max memory used: 1952MiB
   INFO [job downsample_landsat.cwl] completed success
   {
       "dataset_dir": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled",
           "basename": "LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json",
                   "basename": "LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json",
                   "checksum": "sha1$9ef1fba7adf92279482c9dfdc3a8ae5d95aa7f70",
                   "size": 3116,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF",
                   "basename": "LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF",
                   "checksum": "sha1$57267ecbe6d1a4cbfd0c547829238953fae27b8f",
                   "size": 20777,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png",
                   "basename": "LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png",
                   "checksum": "sha1$4b5ff3f42615abf50ffed9b0cc32b9f23a9e6e23",
                   "size": 50629,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png"
               }
           ],
           "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled"
       },
       "output_nb_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/output_nb.ipynb",
           "basename": "output_nb.ipynb",
           "class": "File",
           "checksum": "sha1$eae9af768b2d6115531dbe789b4d6acf415c894e",
           "size": 12231,
           "path": "/Users/pymonger/dev/downsample-landsat/output_nb.ipynb"
       },
       "stderr_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/downsample_landsat-stderr.txt",
           "basename": "downsample_landsat-stderr.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/pymonger/dev/downsample-landsat/downsample_landsat-stderr.txt"
       },
       "stdout_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/downsample_landsat-stdout.txt",
           "basename": "downsample_landsat-stdout.txt",
           "class": "File",
           "checksum": "sha1$33abbe0c82fc2c10c98767fd30cedf7883a358e7",
           "size": 1363,
           "path": "/Users/pymonger/dev/downsample-landsat/downsample_landsat-stdout.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the `LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled` dataset directory was created:
   ```
   ls -ltr LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/
   ```

   Output should look similar to this:
   ``` 
   total 160
   -rw-r--r--  1 pymonger  wheel  20777 Mar  2 13:01 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF
   -rw-r--r--  1 pymonger  wheel  50629 Mar  2 13:01 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png
   -rw-r--r--  1 pymonger  wheel   3116 Mar  2 13:01 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json
   ```
   You can visualize the `LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF` file in QGIS.

### Run stage-out example

Building off of the previous dowsample-landsat example:
1. Ensure that the `LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled` dataset directory exists.
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
   INFO /Users/pymonger/dev/downsample-landsat/env/bin/cwltool 3.1.20220217222804
   INFO Resolved 'stage_out.cwl' to 'file:///Users/pymonger/dev/downsample-landsat/stage_out.cwl'
   stage_out.cwl:8:3: Warning: checking item
                      Warning:   Field `class` contains undefined reference to
                      `http://commonwl.org/cwltool#Secrets`
   INFO stage_out.cwl:8:3: Unknown hint http://commonwl.org/cwltool#Secrets
   INFO [job stage_out.cwl] /private/tmp/docker_tmpqzxwnh2u$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpqzxwnh2u,target=/rgrrqW \
       --mount=type=bind,source=/private/tmp/docker_tmp24aq06by,target=/tmp \
       --mount=type=bind,source=/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled,target=/var/lib/cwl/stg3401acae-259c-499b-8f12-16681fa3541c/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled,readonly \
       --workdir=/rgrrqW \
       --read-only=true \
       --log-driver=none \
       --user=503:20 \
       --rm \
       --cidfile=/private/tmp/docker_tmpiutj6fgi/20220302130708-168306.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/rgrrqW \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg3401acae-259c-499b-8f12-16681fa3541c/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled s3://hysds-dataset-bucket-gman-test/test/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled' > /private/tmp/docker_tmpqzxwnh2u/stage_out-stdout.txt 2> /private/tmp/docker_tmpqzxwnh2u/stage_out-stderr.txt
   INFO [job stage_out.cwl] Max memory used: 465MiB
   INFO [job stage_out.cwl] completed success
   {
       "stderr_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/stage_out-stderr.txt",
           "basename": "stage_out-stderr.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/pymonger/dev/downsample-landsat/stage_out-stderr.txt"
       },
       "stdout_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/stage_out-stdout.txt",
           "basename": "stage_out-stdout.txt",
           "class": "File",
           "checksum": "sha1$d4fa0661ef3c522717ff1ae043fef25c8b3b8d8d",
           "size": 1151,
           "path": "/Users/pymonger/dev/downsample-landsat/stage_out-stdout.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the`LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled` dataset directory was staged to the 
   S3 bucket location.
   ```
   aws s3 ls $(grep base_dataset_url stage_out-inputs.yml | awk '{print $2}')/$(grep path stage_out-inputs.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2022-02-18 16:25:52      20777 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF
   2022-02-18 16:25:52      49848 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png
   2022-02-18 16:25:52       3008 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json
   ```

### Run 3-step workflow (stage-in, downsample-landsat & stage-out) example
Now that we've seen the individual steps at work, we can proceed with running them in 
a CWL workflow. The following image depicts the graph visualiation (dot) of the
DAG workflow.

![workflow](images/workflow.png?raw=true "workflow")

1. Clean out any artifacts that were left as a result of running the previous examples:
   ```
   rm -rf LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled *-stderr.txt *-stdout.txt output_nb.ipynb
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
   INFO /Users/pymonger/dev/downsample-landsat/env/bin/cwltool 3.1.20220217222804
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
   INFO [job stage_in] /private/tmp/docker_tmp1p7p0v4a$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp1p7p0v4a,target=/sFjOOZ \
       --mount=type=bind,source=/private/tmp/docker_tmp04brussx,target=/tmp \
       --workdir=/sFjOOZ \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpq2cofbuj/20220302131059-727166.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/sFjOOZ \
       pymonger/downsample-landsat:2.0.0 \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/stage_in.ipynb output_nb.ipynb --parameters input_url "https://s3-us-west-2.amazonaws.com/landsat-pds/c1/L8/065/045/LC08_L1TP_065045_20210714_20210721_01_T1/LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF" > /private/tmp/docker_tmp1p7p0v4a/stage_in-stdout.txt 2> /private/tmp/docker_tmp1p7p0v4a/stage_in-stderr.txt
   INFO [job stage_in] Max memory used: 2044MiB
   INFO [job stage_in] completed success
   INFO [step stage_in] completed success
   INFO [workflow ] starting step downsample_landsat
   INFO [step downsample_landsat] start
   INFO [job downsample_landsat] /private/tmp/docker_tmpuxqihtw3$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpuxqihtw3,target=/sFjOOZ \
       --mount=type=bind,source=/private/tmp/docker_tmpcrwdoigw,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmp1p7p0v4a/LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF,target=/sFjOOZ/LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF,readonly \
       --workdir=/sFjOOZ \
       --net=none \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpcykdec29/20220302131107-407491.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/sFjOOZ \
       pymonger/downsample-landsat:2.0.0 \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/downsample_landsat.ipynb output_nb.ipynb --parameters input_file "LC08_L1TP_065045_20210714_20210721_01_T1_BQA.TIF" --parameters min_spin_time "15" --parameters max_spin_time "30" > /private/tmp/docker_tmpuxqihtw3/downsample_landsat-stdout.txt 2> /private/tmp/docker_tmpuxqihtw3/downsample_landsat-stderr.txt
   INFO [job downsample_landsat] Max memory used: 1975MiB
   INFO [job downsample_landsat] completed success
   INFO [step downsample_landsat] completed success
   INFO [workflow ] starting step stage_out
   INFO [step stage_out] start
   INFO [job stage_out] /private/tmp/docker_tmp6awts2g8$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp6awts2g8,target=/sFjOOZ \
       --mount=type=bind,source=/private/tmp/docker_tmphuv499r8,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmpuxqihtw3/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled,target=/var/lib/cwl/stgd93000df-dfa3-494a-884f-22232ee34400/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled,readonly \
       --workdir=/sFjOOZ \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpgyo6eb7n/20220302131137-217301.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/sFjOOZ \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stgd93000df-dfa3-494a-884f-22232ee34400/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled s3://hysds-dataset-bucket-gman-test/docker_on_desktop_k8s/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled' > /private/tmp/docker_tmp6awts2g8/stage_out-stdout.txt 2> /private/tmp/docker_tmp6awts2g8/stage_out-stderr.txt
   INFO [job stage_out] Max memory used: 570MiB
   INFO [job stage_out] completed success
   INFO [step stage_out] completed success
   INFO [workflow ] completed success
   {
       "final_dataset_dir": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled",
           "basename": "LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json",
                   "basename": "LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json",
                   "checksum": "sha1$9ef1fba7adf92279482c9dfdc3a8ae5d95aa7f70",
                   "size": 3116,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF",
                   "basename": "LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF",
                   "checksum": "sha1$57267ecbe6d1a4cbfd0c547829238953fae27b8f",
                   "size": 20777,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png",
                   "basename": "LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png",
                   "checksum": "sha1$d526be0fb6ba45341b9847879410a97461cf5309",
                   "size": 50629,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png"
               }
           ],
           "path": "/Users/pymonger/dev/downsample-landsat/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled"
       },
       "stderr-downsample_landsat": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/downsample_landsat-stderr.txt",
           "basename": "downsample_landsat-stderr.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/pymonger/dev/downsample-landsat/downsample_landsat-stderr.txt"
       },
       "stderr-stage_out": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/stage_out-stderr.txt",
           "basename": "stage_out-stderr.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/pymonger/dev/downsample-landsat/stage_out-stderr.txt"
       },
       "stdout-downsample_landsat": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/downsample_landsat-stdout.txt",
           "basename": "downsample_landsat-stdout.txt",
           "class": "File",
           "checksum": "sha1$e9b873e5c4666b2bfa659b6efe888662d07475d7",
           "size": 1363,
           "path": "/Users/pymonger/dev/downsample-landsat/downsample_landsat-stdout.txt"
       },
       "stdout-stage_out": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/stage_out-stdout.txt",
           "basename": "stage_out-stdout.txt",
           "class": "File",
           "checksum": "sha1$9225c661356421610bedc2472bb9bb57a67f63a5",
           "size": 1202,
           "path": "/Users/pymonger/dev/downsample-landsat/stage_out-stdout.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the `LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled` dataset directory exists locally:
   ```
   ls -ltr LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/
   ```

   Output should look similar to this:
   ```
   total 160
   -rw-r--r--  1 pymonger  wheel  20777 Mar  2 13:11 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF
   -rw-r--r--  1 pymonger  wheel  50629 Mar  2 13:11 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png
   -rw-r--r--  1 pymonger  wheel   3116 Mar  2 13:11 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json
   ```

   and was staged to the S3 bucket location:
   ```
   aws s3 ls $(grep workflow_base_dataset_url workflow-inputs.yml | awk '{print $2}')/$(ls -d *_downsampled)/
   ```

   Output should look similar to this:
   ```
   2022-02-18 16:34:47      20777 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF
   2022-02-18 16:34:47      49848 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png
   2022-02-18 16:34:47       3008 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json
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
   rm -rf LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled *-stderr.txt *-stdout.txt output_nb.ipynb
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
   NAMESPACE_NAME=dev
   kubectl --namespace="$NAMESPACE_NAME" cp access-pv:/calrissian/output-data output-data
   ```
1. Verify that the`LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled` dataset directory exists in the output-data directory:
   ```
   ls -ltr output-data/LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled/
   ```

   Output should look similar to this:
   ```
   total 160
   -rw-r--r--  1 pymonger  staff  20777 Feb 18 18:03 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF
   -rw-r--r--  1 pymonger  staff   3008 Feb 18 18:03 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json
   -rw-r--r--  1 pymonger  staff  49848 Feb 18 18:03 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png
   ```

   and was staged to the S3 bucket location:
   ```
   aws s3 ls $(grep base_dataset_url stage_out-inputs.yml | awk '{print $2}')/$(grep path stage_out-inputs.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2022-02-18 16:46:44      20777 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.TIF
   2022-02-18 16:46:44      49848 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.browse.png
   2022-02-18 16:46:44       3008 LC08_L1TP_065045_20210714_20210721_01_T1_BQA_downsampled.met.json
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
