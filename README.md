# downsample-landsat
Example CWL workflow calling a papermilled notebook.

## Run Jupyter Lab to view, edit and/or execute the algorithm notebook:
1. Start up Jupyter Lab in a docker container:
   ```
   git clone https://github.com/pymonger/downsample-landsat.git
   cd downsample-landsat
   docker run -p 8888:8888 -v ${PWD}:/home/jovyan/downsample-landsat \
     pymonger/downsample-landsat:latest jupyter lab
   ```
1. Open the `downsample_landsat.ipynb` notebook and run it.

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

### Run downsample-landsat example
1. Run cwltool (to run singularity instead of docker, add `--singularity` option):
   ```
   cwltool --no-match-user --no-read-only downsample_landsat.cwl downsample_landsat-inputs.yml 
   ```

   Output should look similar to this:

   ```
   INFO /Users/pymonger/dev/downsample-landsat/env/bin/cwltool 3.1.20220217222804
   INFO Resolved 'downsample_landsat.cwl' to 'file:///Users/pymonger/dev/downsample-landsat/downsample_landsat.cwl'
   INFO [job downsample_landsat.cwl] /private/tmp/docker_tmpnrpkmkcx$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpnrpkmkcx,target=/XHcuTa \
       --mount=type=bind,source=/private/tmp/docker_tmp5d82bqd2,target=/tmp \
       --workdir=/XHcuTa \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpyjp_9jit/20220218162051-497685.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/XHcuTa \
       pymonger/downsample-landsat:latest \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/downsample_landsat.ipynb output_nb.ipynb --parameters input_url "https://s3-us-west-2.amazonaws.com/landsat-pds/L8/065/045/LC80650452017120LGN00/LC80650452017120LGN00_BQA.TIF" --parameters min_spin_time "20" --parameters max_spin_time "40" > /private/tmp/docker_tmpnrpkmkcx/downsample_landsat-stdout.txt 2> /private/tmp/docker_tmpnrpkmkcx/downsample_landsat-stderr.txt
   INFO [job downsample_landsat.cwl] Max memory used: 1890MiB
   INFO [job downsample_landsat.cwl] completed success
   {
       "dataset_dir": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled",
           "basename": "LC80650452017120LGN00_BQA_downsampled",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.met.json",
                   "basename": "LC80650452017120LGN00_BQA_downsampled.met.json",
                   "checksum": "sha1$e1e7944264d47886becec7442213a9f97b13f1a0",
                   "size": 3008,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.TIF",
                   "basename": "LC80650452017120LGN00_BQA_downsampled.TIF",
                   "checksum": "sha1$57267ecbe6d1a4cbfd0c547829238953fae27b8f",
                   "size": 20777,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.TIF"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.browse.png",
                   "basename": "LC80650452017120LGN00_BQA_downsampled.browse.png",
                   "checksum": "sha1$3339445859af69181acf691e238af493f61d4d27",
                   "size": 49848,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.browse.png"
               }
           ],
           "path": "/Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled"
       },
       "output_nb_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/output_nb.ipynb",
           "basename": "output_nb.ipynb",
           "class": "File",
           "checksum": "sha1$85ffe4cf55c8b999ca73f89448c5e8b6ce0ab432",
           "size": 12598,
           "path": "/Users/pymonger/dev/downsample-landsat/output_nb.ipynb"
       },
       "stderr_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/downsample_landsat-stderr.txt",
           "basename": "downsample_landsat-stderr.txt",
           "class": "File",
           "checksum": "sha1$ecff815dcf78ab0a23de9c47257527b2354abb26",
           "size": 1184,
           "path": "/Users/pymonger/dev/downsample-landsat/downsample_landsat-stderr.txt"
       },
       "stdout_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/downsample_landsat-stdout.txt",
           "basename": "downsample_landsat-stdout.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/pymonger/dev/downsample-landsat/downsample_landsat-stdout.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the `LC80650452017120LGN00_BQA_downsampled` dataset directory was created:
   ```
   ls -ltr LC80650452017120LGN00_BQA_downsampled/
   ```

   Output should look similar to this:
   ``` 
   total 160
   -rw-r--r--  1 pymonger  wheel  20777 Feb 18 16:21 LC80650452017120LGN00_BQA_downsampled.TIF
   -rw-r--r--  1 pymonger  wheel  49848 Feb 18 16:21 LC80650452017120LGN00_BQA_downsampled.browse.png
   -rw-r--r--  1 pymonger  wheel   3008 Feb 18 16:21 LC80650452017120LGN00_BQA_downsampled.met.json
   ```
   You can visualize the `LC80650452017120LGN00_BQA_downsampled.TIF` file in QGIS.

### Run stage_out example

Building off of the previous dowsample_landsat example:
1. Ensure that the `LC80650452017120LGN00_BQA_downsampled` dataset directory exists.
   If not, run the `downsample_landsat` example above.
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
   INFO [job stage_out.cwl] /private/tmp/docker_tmpmd94esqb$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpmd94esqb,target=/JZJjRa \
       --mount=type=bind,source=/private/tmp/docker_tmpavpielz1,target=/tmp \
       --mount=type=bind,source=/Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled,target=/var/lib/cwl/stg7368e2ad-b784-4fda-8bab-5384a7d04630/LC80650452017120LGN00_BQA_downsampled,readonly \
       --workdir=/JZJjRa \
       --read-only=true \
       --log-driver=none \
       --user=503:20 \
       --rm \
       --cidfile=/private/tmp/docker_tmpjwe6mvnw/20220218162549-534126.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/JZJjRa \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg7368e2ad-b784-4fda-8bab-5384a7d04630/LC80650452017120LGN00_BQA_downsampled s3://hysds-dataset-bucket-gman-test/test/LC80650452017120LGN00_BQA_downsampled' > /private/tmp/docker_tmpmd94esqb/stage_out-stdout.txt 2> /private/tmp/docker_tmpmd94esqb/stage_out-stderr.txt
   INFO [job stage_out.cwl] Max memory used: 347MiB
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
           "checksum": "sha1$73d3553afef8e2741dcfd74e2629f742d9ebac82",
           "size": 1151,
           "path": "/Users/pymonger/dev/downsample-landsat/stage_out-stdout.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the`LC80650452017120LGN00_BQA_downsampled` dataset directory was staged to the 
   S3 bucket location.
   ```
   aws s3 ls $(grep base_dataset_url stage_out-inputs.yml | awk '{print $2}')/$(grep path stage_out-inputs.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2022-02-18 16:25:52      20777 LC80650452017120LGN00_BQA_downsampled.TIF
   2022-02-18 16:25:52      49848 LC80650452017120LGN00_BQA_downsampled.browse.png
   2022-02-18 16:25:52       3008 LC80650452017120LGN00_BQA_downsampled.met.json
   ```

### Run 2-step workflow (downsample_landsat & stage_out) example
Now that we've seen the individual steps at work, we can proceed with running them in 
a CWL workflow. The following image depicts the graph visualiation (dot) of the
DAG workflow.

![workflow](images/workflow.png?raw=true "workflow")

1. Clean out any artifacts that were left as a result of running the previous examples:
   ```
   rm -rf LC80650452017120LGN00_BQA_downsampled *-stderr.txt *-stdout.txt output_nb.ipynb
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
   INFO [workflow ] starting step downsample_landsat
   INFO [step downsample_landsat] start
   INFO [job downsample_landsat] /private/tmp/docker_tmpd_xwkbcw$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpd_xwkbcw,target=/UYCYXw \
       --mount=type=bind,source=/private/tmp/docker_tmpnrcbwai8,target=/tmp \
       --workdir=/UYCYXw \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmpewfezoeq/20220218163408-295295.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/UYCYXw \
       pymonger/downsample-landsat:latest \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/downsample_landsat.ipynb output_nb.ipynb --parameters input_url "https://s3-us-west-2.amazonaws.com/landsat-pds/L8/065/045/LC80650452017120LGN00/LC80650452017120LGN00_BQA.TIF" --parameters min_spin_time "15" --parameters max_spin_time "30" > /private/tmp/docker_tmpd_xwkbcw/downsample_landsat-stdout.txt 2> /private/tmp/docker_tmpd_xwkbcw/downsample_landsat-stderr.txt
   INFO [job downsample_landsat] Max memory used: 1969MiB
   INFO [job downsample_landsat] completed success
   INFO [step downsample_landsat] completed success
   INFO [workflow ] starting step stage_out
   INFO [step stage_out] start
   INFO [job stage_out] /private/tmp/docker_tmpz7jgnusv$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpz7jgnusv,target=/UYCYXw \
       --mount=type=bind,source=/private/tmp/docker_tmplkoeijg9,target=/tmp \
       --mount=type=bind,source=/private/tmp/docker_tmpd_xwkbcw/LC80650452017120LGN00_BQA_downsampled,target=/var/lib/cwl/stg27244ef8-5d6d-4bd7-b8a1-aadf76e3f8fc/LC80650452017120LGN00_BQA_downsampled,readonly \
       --workdir=/UYCYXw \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmppeg7c3bv/20220218163444-037473.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/UYCYXw \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stg27244ef8-5d6d-4bd7-b8a1-aadf76e3f8fc/LC80650452017120LGN00_BQA_downsampled s3://hysds-dataset-bucket-gman-test/test/LC80650452017120LGN00_BQA_downsampled' > /private/tmp/docker_tmpz7jgnusv/stage_out-stdout.txt 2> /private/tmp/docker_tmpz7jgnusv/stage_out-stderr.txt
   INFO [job stage_out] Max memory used: 445MiB
   INFO [job stage_out] completed success
   INFO [step stage_out] completed success
   INFO [workflow ] completed success
   {
       "final_dataset_dir": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled",
           "basename": "LC80650452017120LGN00_BQA_downsampled",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.met.json",
                   "basename": "LC80650452017120LGN00_BQA_downsampled.met.json",
                   "checksum": "sha1$e1e7944264d47886becec7442213a9f97b13f1a0",
                   "size": 3008,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.TIF",
                   "basename": "LC80650452017120LGN00_BQA_downsampled.TIF",
                   "checksum": "sha1$57267ecbe6d1a4cbfd0c547829238953fae27b8f",
                   "size": 20777,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.TIF"
               },
               {
                   "class": "File",
                   "location": "file:///Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.browse.png",
                   "basename": "LC80650452017120LGN00_BQA_downsampled.browse.png",
                   "checksum": "sha1$d51d3f917f596091a17eb9aa165b1dcd11d44bf4",
                   "size": 49848,
                   "path": "/Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.browse.png"
               }
           ],
           "path": "/Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled"
       },
       "stderr-downsample_landsat": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/downsample_landsat-stderr.txt",
           "basename": "downsample_landsat-stderr.txt",
           "class": "File",
           "checksum": "sha1$107da707bee89581546f089deda128f09348c197",
           "size": 1265,
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
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/Users/pymonger/dev/downsample-landsat/downsample_landsat-stdout.txt"
       },
       "stdout-stage_out": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/stage_out-stdout.txt",
           "basename": "stage_out-stdout.txt",
           "class": "File",
           "checksum": "sha1$f86a58db855da50e27cda34ccc6875ba685d2814",
           "size": 1151,
           "path": "/Users/pymonger/dev/downsample-landsat/stage_out-stdout.txt"
       }
   }
   INFO Final process status is success
   ```
1. Verify that the `LC80650452017120LGN00_BQA_downsampled` dataset directory exists locally:
   ```
   ls -ltr LC80650452017120LGN00_BQA_downsampled/
   ```

   Output should look similar to this:
   ```
   total 160
   -rw-r--r--  1 pymonger  wheel  20777 Feb 18 16:34 LC80650452017120LGN00_BQA_downsampled.TIF
   -rw-r--r--  1 pymonger  wheel  49848 Feb 18 16:34 LC80650452017120LGN00_BQA_downsampled.browse.png
   -rw-r--r--  1 pymonger  wheel   3008 Feb 18 16:34 LC80650452017120LGN00_BQA_downsampled.met.json
   ```

   and was staged to the S3 bucket location:
   ```
   aws s3 ls $(grep workflow_base_dataset_url workflow-inputs.yml | awk '{print $2}')/$(ls -d *_downsampled)/
   ```

   Output should look similar to this:
   ```
   2022-02-18 16:34:47      20777 LC80650452017120LGN00_BQA_downsampled.TIF
   2022-02-18 16:34:47      49848 LC80650452017120LGN00_BQA_downsampled.browse.png
   2022-02-18 16:34:47       3008 LC80650452017120LGN00_BQA_downsampled.met.json
   ```

## Building Container Image
```
git clone https://github.com/pymonger/downsample-landsat.git
cd downsample-landsat
docker build --rm --force-rm -t pymonger/downsample-landsat:latest -f Dockerfile .
```
