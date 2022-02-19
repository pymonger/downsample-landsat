# downsample-landsat
Example CWL workflow calling a papermilled notebook.

## Prerequisites

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

## Run downsample-landsat example
1. Run cwltool (to run singularity instead of docker, add `--singularity` option):
   ```
   cwltool --no-match-user --no-read-only downsample_landsat.cwl downsample_landsat-inputs.yml 
   ```

   Output should look similar to this:

   ```
   INFO /Users/pymonger/dev/dowsample-landsat/env/bin/cwl-runner 3.1.20220117131913
   INFO Resolved 'downsample_landsat.cwl' to 'file:///Users/pymonger/dev/downsample-landsat/downsample_landsat.cwl'
   INFO [job downsample_landsat.cwl] /private/tmp/docker_tmpbcv4mmls$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmpbcv4mmls,target=/OroRkb \
       --mount=type=bind,source=/private/tmp/docker_tmp0w63wmpp,target=/tmp \
       --workdir=/OroRkb \
       --log-driver=none \
       --rm \
       --cidfile=/private/tmp/docker_tmphd_hv1a0/20220218154822-867596.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/OroRkb \
       pymonger/downsample-landsat:latest \
       /bin/sh \
       -c \
       papermill /home/jovyan/downsample-landsat/downsample_landsat.ipynb output_nb.ipynb --parameters input_url "https://s3-us-west-2.amazonaws.com/landsat-pds/L8/065/045/LC80650452017120LGN00/LC80650452017120LGN00_BQA.TIF" --parameters min_spin_time "20" --parameters max_spin_time "40" > /private/tmp/docker_tmpbcv4mmls/downsample_landsat-stdout.txt 2> /private/tmp/docker_tmpbcv4mmls/downsample_landsat-stderr.txt
   INFO [job downsample_landsat.cwl] Max memory used: 4115MiB
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
                   "checksum": "sha1$9058f1925184b020cadf8f0ba6bdbfef7875e6a2",
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
           "checksum": "sha1$75de15695bcdce2ea5c2380908f8b8aa3782ab4f",
           "size": 12599,
           "path": "/Users/pymonger/dev/downsample-landsat/output_nb.ipynb"
       },
       "stderr_file": {
           "location": "file:///Users/pymonger/dev/downsample-landsat/downsample_landsat-stderr.txt",
           "basename": "downsample_landsat-stderr.txt",
           "class": "File",
           "checksum": "sha1$eb409e0ec0ed3e8212732aad0a725d4c3d45d41a",
           "size": 1186,
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
   -rw-r--r--  1 pymonger  wheel  20777 Feb 18 15:51 LC80650452017120LGN00_BQA_downsampled.TIF
   -rw-r--r--  1 pymonger  wheel  49848 Feb 18 15:51 LC80650452017120LGN00_BQA_downsampled.browse.png
   -rw-r--r--  1 pymonger  wheel   3008 Feb 18 15:51 LC80650452017120LGN00_BQA_downsampled.met.json
   ```
   You can visualize the `LC80650452017120LGN00_BQA_downsampled.TIF` file in QGIS.

## Run stage_out example

Building off of the previous dowsample_landsat example:
1. Ensure that the `LC80650452017120LGN00_BQA_downsampled` dataset directory exists.
   If not, run the `downsample_landsat` example above.
1. Copy the `stage_out-inputs.yml.tmpl` file to `stage_out-inputs.yml`:
   ```
   cp stage_out-job.yml.tmpl stage_out-job.yml
   ```

   then edit `stage_out-job.yml`:
   ```
   vi stage_out-job.yml
   ```

   and insert the values for:
   - `aws_access_key_id`
   - `aws_secret_access_key`

   These values can be copied from your valid `$HOME/.aws/credentials` file.
1. Run cwl-runner (to run singularity instead of docker, add `--singularity` option):
   ```
   cwl-runner stage_out.cwl stage_out-inputs.yml 
   ```

   Output should look similar to this:

   ```
   INFO /Users/pymonger/dev/downsample-landsat/env/bin/cwltool 3.1.20220117131913
   INFO Resolved 'stage_out.cwl' to 'file:///Users/pymonger/dev/downsample-landsat/stage_out.cwl'
   stage_out.cwl:8:3: Warning: checking item
                      Warning:   Field `class` contains undefined reference to
                      `http://commonwl.org/cwltool#Secrets`
   INFO stage_out.cwl:8:3: Unknown hint http://commonwl.org/cwltool#Secrets
   INFO [job stage_out.cwl] /private/tmp/docker_tmp9qh_b9au$ docker \
       run \
       -i \
       --mount=type=bind,source=/private/tmp/docker_tmp9qh_b9au,target=/nnlHtP \
       --mount=type=bind,source=/private/tmp/docker_tmpubyc67dk,target=/tmp \
       --mount=type=bind,source=/Users/pymonger/dev/downsample-landsat/LC80650452017120LGN00_BQA_downsampled,target=/var/lib/cwl/stgfe3b1207-71f3-41a4-ba09-c6fbc1bfd8e7/LC80650452017120LGN00_BQA_downsampled,readonly \
       --workdir=/nnlHtP \
       --read-only=true \
       --log-driver=none \
       --user=503:20 \
       --rm \
       --cidfile=/private/tmp/docker_tmpgejedl8z/20220218160324-178256.cid \
       --env=TMPDIR=/tmp \
       --env=HOME=/nnlHtP \
       pymonger/aws-cli \
       sh \
       -c \
       'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive /var/lib/cwl/stgfe3b1207-71f3-41a4-ba09-c6fbc1bfd8e7/LC80650452017120LGN00_BQA_downsampled s3://hysds-dataset-bucket-gman-test/test/LC80650452017120LGN00_BQA_downsampled' > /private/tmp/docker_tmp9qh_b9au/stage_out-stdout.txt 2> /private/tmp/docker_tmp9qh_b9au/stage_out-stderr.txt
   INFO [job stage_out.cwl] Max memory used: 678MiB
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
           "checksum": "sha1$d88463d7e25ff6903a785798d1e5141204655895",
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
   2022-02-18 16:03:28      20777 LC80650452017120LGN00_BQA_downsampled.TIF
   2022-02-18 16:03:28      49848 LC80650452017120LGN00_BQA_downsampled.browse.png
   2022-02-18 16:03:28       3008 LC80650452017120LGN00_BQA_downsampled.met.json
   ```

## Building Container Image
```
git clone https://github.com/pymonger/downsample-landsat.git
cd downsample-landsat
docker build --rm --force-rm -t pymonger/downsample-landsat:latest -f Dockerfile .
```
