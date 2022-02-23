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

## Building the container image
```
pip install jupyter-repo2docker
git clone https://github.com/pymonger/downsample-landsat.git
cd downsample-landsat
repo2docker --image-name pymonger/downsample-landsat:latest .
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

## Running calrissian

### Run 2-step workflow (downsample_landsat & stage_out) example on K8s (Kubernetes) via Calrissian
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
   rm -rf LC80650452017120LGN00_BQA_downsampled *-stderr.txt *-stdout.txt output_nb.ipynb
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
1. Run the workflow:
   ```
   kubectl --namespace="$NAMESPACE_NAME" create -f k8s/CalrissianJob.yaml
   ```

   Monitor execution with:
   ```
   while true; do kubectl --namespace="$NAMESPACE_NAME" logs -f job/calrissian-job && break; sleep 2; done
   ```

   Output should be similar to this:
   ```
   INFO calrissian 0.10.0 (cwltool 3.1)
   https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl:8:3: Warning: checking
                                                                                        item
                                                                                        Warning:   Field
                                                                                        `class` contains
                                                                                        undefined reference
                                                                                        to
                                                                                        `http://commonwl.org/cwltool#Secrets`
   INFO https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl:8:3: Unknown hint
                                                                                        http://commonwl.org/cwltool#Secrets
   https://raw.githubusercontent.com/pymonger/downsample-landsat/main/stage_out.cwl:8:3: Warning: checking
                                                                                         item
                                                                                         Warning:   Field
                                                                                         `class` contains
                                                                                         undefined reference
                                                                                         to
                                                                                         `http://commonwl.org/cwltool#Secrets`
   INFO https://raw.githubusercontent.com/pymonger/downsample-landsat/main/stage_out.cwl:8:3: Unknown hint
                                                                                         http://commonwl.org/cwltool#Secrets
   DEBUG Parsed job order from command line: {
       "id": "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl",
       "workflow_aws_access_key_id": "(secret-cb144351-cd82-4f32-b7ce-8aca63f2284d)",
       "workflow_aws_secret_access_key": "(secret-7babf4eb-2f48-4253-ae99-10f85d86647b)",
       "workflow_base_dataset_url": "s3://hysds-dataset-bucket-gman-test/docker_on_desktop_k8s",
       "workflow_input_url": "https://s3-us-west-2.amazonaws.com/landsat-pds/L8/065/045/LC80650452017120LGN00/LC80650452017120LGN00_BQA.TIF",
       "workflow_max_spin_time": 30,
       "workflow_min_spin_time": 15
   }
   DEBUG Starting ThreadPoolJobExecutor.run_jobs: total_resources=[ram: 16000.0, cores: 8.0], max_workers=None
   DEBUG [workflow ] initialized from https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl
   DEBUG wait_for_completion with 0 futures
   DEBUG [workflow ] inputs {
       "workflow_aws_access_key_id": "(secret-cb144351-cd82-4f32-b7ce-8aca63f2284d)",
       "workflow_aws_secret_access_key": "(secret-7babf4eb-2f48-4253-ae99-10f85d86647b)",
       "workflow_base_dataset_url": "s3://hysds-dataset-bucket-gman-test/docker_on_desktop_k8s",
       "workflow_input_url": "https://s3-us-west-2.amazonaws.com/landsat-pds/L8/065/045/LC80650452017120LGN00/LC80650452017120LGN00_BQA.TIF",
       "workflow_max_spin_time": 30,
       "workflow_min_spin_time": 15
   }
   DEBUG [workflow ] job step https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out not ready
   INFO [workflow ] starting step downsample_landsat
   DEBUG [step downsample_landsat] job input {
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#downsample_landsat/input_url": "https://s3-us-west-2.amazonaws.com/landsat-pds/L8/065/045/LC80650452017120LGN00/LC80650452017120LGN00_BQA.TIF",
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#downsample_landsat/max_spin_time": 30,
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#downsample_landsat/min_spin_time": 15
   }
   DEBUG [step downsample_landsat] evaluated job input to {
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#downsample_landsat/input_url": "https://s3-us-west-2.amazonaws.com/landsat-pds/L8/065/045/LC80650452017120LGN00/LC80650452017120LGN00_BQA.TIF",
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#downsample_landsat/max_spin_time": 30,
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#downsample_landsat/min_spin_time": 15
   }
   INFO [step downsample_landsat] start
   DEBUG [job downsample_landsat] initializing from https://raw.githubusercontent.com/pymonger/downsample-landsat/main/downsample_landsat.cwl as part of step downsample_landsat
   DEBUG [job downsample_landsat] {
       "input_url": "https://s3-us-west-2.amazonaws.com/landsat-pds/L8/065/045/LC80650452017120LGN00/LC80650452017120LGN00_BQA.TIF",
       "max_spin_time": 30,
       "min_spin_time": 15
   }
   DEBUG [job downsample_landsat] path mappings is {}
   DEBUG [job downsample_landsat] command line bindings is [
       {
           "position": [
               -1000000,
               0
           ],
           "datum": "papermill"
       },
       {
           "position": [
               -1000000,
               1
           ],
           "datum": "/home/jovyan/downsample-landsat/downsample_landsat.ipynb"
       },
       {
           "position": [
               -1000000,
               2
           ],
           "datum": "output_nb.ipynb"
       },
       {
           "position": [
               1,
               "input_url"
           ],
           "shellQuote": false,
           "prefix": "--parameters",
           "valueFrom": "input_url \"$(self)\"\n",
           "datum": "https://s3-us-west-2.amazonaws.com/landsat-pds/L8/065/045/LC80650452017120LGN00/LC80650452017120LGN00_BQA.TIF"
       },
       {
           "position": [
               2,
               "min_spin_time"
           ],
           "shellQuote": false,
           "prefix": "--parameters",
           "valueFrom": "min_spin_time \"$(self)\"\n",
           "datum": 15
       },
       {
           "position": [
               3,
               "max_spin_time"
           ],
           "shellQuote": false,
           "prefix": "--parameters",
           "valueFrom": "max_spin_time \"$(self)\"\n",
           "datum": 30
       }
   ]
   DEBUG wait_for_completion with 0 futures
   DEBUG [workflow ] job step https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out not ready
   DEBUG allocate [ram: 0, cores: 0] from available [ram: 16000.0, cores: 8.0]
   INFO [workflow ] start
   DEBUG restore [ram: 0, cores: 0] to available [ram: 16000.0, cores: 8.0]
   DEBUG allocate [ram: 256, cores: 1] from available [ram: 16000.0, cores: 8.0]
   DEBUG [job downsample_landsat] initial work dir {}
   DEBUG wait_for_completion with 2 futures
   DEBUG [workflow ] job step https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out not ready
   DEBUG wait_for_completion with 1 futures
   Building resources spec from {'cores': 1, 'ram': 256}
   --------------------------------------------------------------------------------
   apiVersion: v1
   kind: Pod
   metadata:
     labels: {}
     name: downsample-landsat-pod-tjcdhksn
   spec:
     containers:
     - args:
       - /bin/sh -c 'papermill /home/jovyan/downsample-landsat/downsample_landsat.ipynb
         output_nb.ipynb --parameters input_url "https://s3-us-west-2.amazonaws.com/landsat-pds/L8/065/045/LC80650452017120LGN00/LC80650452017120LGN00_BQA.TIF"
         --parameters min_spin_time "15" --parameters max_spin_time "30"'
       command:
       - /bin/sh
       - -c
       env:
       - name: HOME
         value: /kBtvyI
       - name: TMPDIR
         value: /tmp
       image: !!python/object/new:ruamel.yaml.scalarstring.SingleQuotedScalarString
       - pymonger/downsample-landsat:latest
       imagePullPolicy: Always
       name: downsample-landsat-container
       resources:
         requests:
           cpu: '1'
           memory: 256Mi
       volumeMounts:
       - mountPath: /kBtvyI
         name: calrissian-tmpout
         readOnly: false
         subPath: ls7u6duy
       - mountPath: /tmp
         name: tmpdir
       workingDir: /kBtvyI
     initContainers: []
     restartPolicy: Never
     securityContext:
       runAsGroup: 0
       runAsUser: 1001
     volumes:
     - name: calrissian-input-data
       persistentVolumeClaim:
         claimName: calrissian-input-data
         readOnly: true
     - name: calrissian-tmpout
       persistentVolumeClaim:
         claimName: calrissian-tmpout
         readOnly: false
     - name: calrissian-output-data
       persistentVolumeClaim:
         claimName: calrissian-output-data
         readOnly: false
     - emptyDir: {}
       name: tmpdir
   --------------------------------------------------------------------------------
   
   Created k8s pod name downsample-landsat-pod-tjcdhksn with id 81ee5e8a-3cba-4a6e-99bd-3d3bb70002b3
   PodMonitor adding downsample-landsat-pod-tjcdhksn
   k8s pod 'downsample-landsat-pod-tjcdhksn' started
   [downsample-landsat-pod-tjcdhksn] follow_logs start
   [downsample-landsat-pod-tjcdhksn] Input Notebook:  /home/jovyan/downsample-landsat/downsample_landsat.ipynb
   [downsample-landsat-pod-tjcdhksn] Output Notebook: output_nb.ipynb
   [downsample-landsat-pod-tjcdhksn] Generating grammar tables from /opt/conda/lib/python3.9/site-packages/blib2to3/Grammar.txt
   [downsample-landsat-pod-tjcdhksn] Writing grammar tables to /kBtvyI/.cache/black/22.1.0/Grammar3.9.7.final.0.pickle
   [downsample-landsat-pod-tjcdhksn] Writing failed: [Errno 2] No such file or directory: '/kBtvyI/.cache/black/22.1.0/tmp2ifqiq0k'
   [downsample-landsat-pod-tjcdhksn] Generating grammar tables from /opt/conda/lib/python3.9/site-packages/blib2to3/PatternGrammar.txt
   [downsample-landsat-pod-tjcdhksn] Writing grammar tables to /kBtvyI/.cache/black/22.1.0/PatternGrammar3.9.7.final.0.pickle
   [downsample-landsat-pod-tjcdhksn] Writing failed: [Errno 2] No such file or directory: '/kBtvyI/.cache/black/22.1.0/tmpkeqysb0y'
   Executing:   0%|          | 0/13 [00:00<?, ?cell/s]Executing notebook with kernel: python3
   Executing: 100%|██████████| 13/13 [00:24<00:00,  1.91s/cell]
   [downsample-landsat-pod-tjcdhksn] follow_logs end
   Handling terminated pod name downsample-landsat-pod-tjcdhksn with id 81ee5e8a-3cba-4a6e-99bd-3d3bb70002b3
   handling completion with 0
   CALRISSIAN_DELETE_PODS=(<class 'str'>)
   returning True
   PodMonitor removing downsample-landsat-pod-tjcdhksn
   DEBUG [step downsample_landsat] produced output {
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#downsample_landsat/output_nb_file": {
           "location": "file:///calrissian/tmpout/ls7u6duy/output_nb.ipynb",
           "basename": "output_nb.ipynb",
           "nameroot": "output_nb",
           "nameext": ".ipynb",
           "class": "File",
           "checksum": "sha1$a527d72f07bf3a93d31c715e2480c4c1fde4853d",
           "size": 12599,
           "http://commonwl.org/cwltool#generation": 0
       },
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#downsample_landsat/dataset_dir": {
           "location": "file:///calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled",
           "basename": "LC80650452017120LGN00_BQA_downsampled",
           "nameroot": "LC80650452017120LGN00_BQA_downsampled",
           "nameext": "",
           "class": "Directory"
       }
   }
   INFO [step downsample_landsat] completed success
   shutil.rmtree(/tmp/lu68xq66, True)
   shutil.rmtree(/tmp/k3t1gb1f, True)
   DEBUG restore [ram: 256, cores: 1] to available [ram: 15744.0, cores: 7.0]
   INFO [workflow ] starting step stage_out
   DEBUG [step stage_out] job input {
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out/aws_access_key_id": "(secret-cb144351-cd82-4f32-b7ce-8aca63f2284d)",
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out/aws_secret_access_key": "(secret-7babf4eb-2f48-4253-ae99-10f85d86647b)",
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out/base_dataset_url": "s3://hysds-dataset-bucket-gman-test/docker_on_desktop_k8s",
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out/dataset_dir": {
           "location": "file:///calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled",
           "basename": "LC80650452017120LGN00_BQA_downsampled",
           "nameroot": "LC80650452017120LGN00_BQA_downsampled",
           "nameext": "",
           "class": "Directory"
       }
   }
   DEBUG [step stage_out] evaluated job input to {
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out/aws_access_key_id": "(secret-cb144351-cd82-4f32-b7ce-8aca63f2284d)",
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out/aws_secret_access_key": "(secret-7babf4eb-2f48-4253-ae99-10f85d86647b)",
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out/base_dataset_url": "s3://hysds-dataset-bucket-gman-test/docker_on_desktop_k8s",
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out/dataset_dir": {
           "location": "file:///calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled",
           "basename": "LC80650452017120LGN00_BQA_downsampled",
           "nameroot": "LC80650452017120LGN00_BQA_downsampled",
           "nameext": "",
           "class": "Directory"
       }
   }
   INFO [step stage_out] start
   DEBUG [job stage_out] initializing from https://raw.githubusercontent.com/pymonger/downsample-landsat/main/stage_out.cwl as part of step stage_out
   DEBUG [job stage_out] {
       "aws_access_key_id": "(secret-cb144351-cd82-4f32-b7ce-8aca63f2284d)",
       "aws_secret_access_key": "(secret-7babf4eb-2f48-4253-ae99-10f85d86647b)",
       "base_dataset_url": "s3://hysds-dataset-bucket-gman-test/docker_on_desktop_k8s",
       "dataset_dir": {
           "location": "file:///calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled",
           "basename": "LC80650452017120LGN00_BQA_downsampled",
           "nameroot": "LC80650452017120LGN00_BQA_downsampled",
           "nameext": "",
           "class": "Directory"
       }
   }
   DEBUG [job stage_out] path mappings is {
       "file:///calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled": [
           "/calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled",
           "/var/lib/cwl/stg79c71992-5ea9-458b-b95b-4a5c6e21b484/LC80650452017120LGN00_BQA_downsampled",
           "Directory",
           true
       ]
   }
   DEBUG [job stage_out] command line bindings is [
       {
           "position": [
               -1000000,
               0
           ],
           "datum": "sh"
       },
       {
           "position": [
               0,
               0
           ],
           "datum": "-c"
       },
       {
           "position": [
               0,
               1
           ],
           "valueFrom": "if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive $(inputs.dataset_dir.path) $(inputs.base_dataset_url)/$(inputs.dataset_dir.basename)"
       }
   ]
   DEBUG wait_for_completion with 0 futures
   DEBUG allocate [ram: 256, cores: 1] from available [ram: 16000.0, cores: 8.0]
   DEBUG [job stage_out] initial work dir {
       "_:a80ef6fb-1daf-4bbf-b9f6-4bdfb083f2cf": [
           "[default]\noutput = json\nregion = us-west-2\naws_access_key_id = (secret-cb144351-cd82-4f32-b7ce-8aca63f2284d)\naws_secret_access_key = (secret-7babf4eb-2f48-4253-ae99-10f85d86647b)\n",
           "/kBtvyI/.aws/credentials",
           "CreateFile",
           true
       ]
   }
   DEBUG wait_for_completion with 1 futures
   Building resources spec from {'cores': 1, 'ram': 256}
   --------------------------------------------------------------------------------
   apiVersion: v1
   kind: Pod
   metadata:
     labels: {}
     name: stage-out-pod-jtxmxcmo
   spec:
     containers:
     - args:
       - sh -c 'if [ ! -d $HOME/.aws ]; then cp -rp .aws $HOME/; fi && aws s3 cp --recursive
         /var/lib/cwl/stg79c71992-5ea9-458b-b95b-4a5c6e21b484/LC80650452017120LGN00_BQA_downsampled
         s3://hysds-dataset-bucket-gman-test/docker_on_desktop_k8s/LC80650452017120LGN00_BQA_downsampled'
         > stage_out-stdout.txt 2> stage_out-stderr.txt
       command:
       - /bin/sh
       - -c
       env:
       - name: HOME
         value: /kBtvyI
       - name: TMPDIR
         value: /tmp
       image: pymonger/aws-cli
       imagePullPolicy: Always
       name: stage-out-container
       resources:
         requests:
           cpu: '1'
           memory: 256Mi
       volumeMounts:
       - mountPath: /kBtvyI
         name: calrissian-tmpout
         readOnly: false
         subPath: lq4s56o8
       - mountPath: /tmp
         name: tmpdir
       - mountPath: /var/lib/cwl/stg79c71992-5ea9-458b-b95b-4a5c6e21b484/LC80650452017120LGN00_BQA_downsampled
         name: calrissian-tmpout
         readOnly: true
         subPath: ls7u6duy/LC80650452017120LGN00_BQA_downsampled
       workingDir: /kBtvyI
     initContainers: []
     restartPolicy: Never
     securityContext:
       runAsGroup: 0
       runAsUser: 1001
     volumes:
     - name: calrissian-input-data
       persistentVolumeClaim:
         claimName: calrissian-input-data
         readOnly: true
     - name: calrissian-tmpout
       persistentVolumeClaim:
         claimName: calrissian-tmpout
         readOnly: false
     - name: calrissian-output-data
       persistentVolumeClaim:
         claimName: calrissian-output-data
         readOnly: false
     - emptyDir: {}
       name: tmpdir
   --------------------------------------------------------------------------------
   
   Created k8s pod name stage-out-pod-jtxmxcmo with id 2584dbf3-a249-488e-b0ca-f31ce0873807
   PodMonitor adding stage-out-pod-jtxmxcmo
   k8s pod 'stage-out-pod-jtxmxcmo' started
   [stage-out-pod-jtxmxcmo] follow_logs start
   [stage-out-pod-jtxmxcmo] follow_logs end
   Handling terminated pod name stage-out-pod-jtxmxcmo with id 2584dbf3-a249-488e-b0ca-f31ce0873807
   handling completion with 0
   CALRISSIAN_DELETE_PODS=(<class 'str'>)
   returning True
   PodMonitor removing stage-out-pod-jtxmxcmo
   DEBUG [step stage_out] produced output {
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out/stdout_file": {
           "location": "file:///calrissian/tmpout/lq4s56o8/stage_out-stdout.txt",
           "basename": "stage_out-stdout.txt",
           "nameroot": "stage_out-stdout",
           "nameext": ".txt",
           "class": "File",
           "checksum": "sha1$1e07a567218c77e7b180e996acf38a35910e9cdb",
           "size": 1202,
           "http://commonwl.org/cwltool#generation": 0
       },
       "https://raw.githubusercontent.com/pymonger/downsample-landsat/main/workflow.cwl#stage_out/stderr_file": {
           "location": "file:///calrissian/tmpout/lq4s56o8/stage_out-stderr.txt",
           "basename": "stage_out-stderr.txt",
           "nameroot": "stage_out-stderr",
           "nameext": ".txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "http://commonwl.org/cwltool#generation": 0
       }
   }
   INFO [step stage_out] completed success
   INFO [workflow ] completed success
   DEBUG [workflow ] outputs {
       "final_dataset_dir": {
           "location": "file:///calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled",
           "basename": "LC80650452017120LGN00_BQA_downsampled",
           "nameroot": "LC80650452017120LGN00_BQA_downsampled",
           "nameext": "",
           "class": "Directory"
       },
       "stderr-stage_out": {
           "location": "file:///calrissian/tmpout/lq4s56o8/stage_out-stderr.txt",
           "basename": "stage_out-stderr.txt",
           "nameroot": "stage_out-stderr",
           "nameext": ".txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "http://commonwl.org/cwltool#generation": 0
       },
       "stdout-stage_out": {
           "location": "file:///calrissian/tmpout/lq4s56o8/stage_out-stdout.txt",
           "basename": "stage_out-stdout.txt",
           "nameroot": "stage_out-stdout",
           "nameext": ".txt",
           "class": "File",
           "checksum": "sha1$1e07a567218c77e7b180e996acf38a35910e9cdb",
           "size": 1202,
           "http://commonwl.org/cwltool#generation": 0
       }
   }
   shutil.rmtree(/tmp/cek49zs4, True)
   shutil.rmtree(/tmp/s0152mkc, True)
   DEBUG restore [ram: 256, cores: 1] to available [ram: 15744.0, cores: 7.0]
   DEBUG wait_for_completion with 0 futures
   DEBUG wait_for_completion with 0 futures
   DEBUG Finishing ThreadPoolExecutor.run_jobs: total_resources=[ram: 16000.0, cores: 8.0], available_resources=[ram: 16000.0, cores: 8.0]
   DEBUG Moving /calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled to /calrissian/output-data/LC80650452017120LGN00_BQA_downsampled
   DEBUG Moving /calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.TIF to /calrissian/output-data/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.TIF
   DEBUG Moving /calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.met.json to /calrissian/output-data/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.met.json
   DEBUG Moving /calrissian/tmpout/ls7u6duy/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.browse.png to /calrissian/output-data/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.browse.png
   DEBUG Moving /calrissian/tmpout/lq4s56o8/stage_out-stderr.txt to /calrissian/output-data/stage_out-stderr.txt
   DEBUG Moving /calrissian/tmpout/lq4s56o8/stage_out-stdout.txt to /calrissian/output-data/stage_out-stdout.txt
   DEBUG Removing intermediate output directory /calrissian/tmpout/ls7u6duy
   DEBUG Removing intermediate output directory /calrissian/tmpout/lq4s56o8
   DEBUG Removing intermediate output directory /calrissian/tmpout/y3ehijzu
   {
       "final_dataset_dir": {
           "location": "file:///calrissian/output-data/LC80650452017120LGN00_BQA_downsampled",
           "basename": "LC80650452017120LGN00_BQA_downsampled",
           "class": "Directory",
           "listing": [
               {
                   "class": "File",
                   "location": "file:///calrissian/output-data/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.TIF",
                   "basename": "LC80650452017120LGN00_BQA_downsampled.TIF",
                   "checksum": "sha1$57267ecbe6d1a4cbfd0c547829238953fae27b8f",
                   "size": 20777,
                   "path": "/calrissian/output-data/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.TIF"
               },
               {
                   "class": "File",
                   "location": "file:///calrissian/output-data/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.met.json",
                   "basename": "LC80650452017120LGN00_BQA_downsampled.met.json",
                   "checksum": "sha1$e1e7944264d47886becec7442213a9f97b13f1a0",
                   "size": 3008,
                   "path": "/calrissian/output-data/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.met.json"
               },
               {
                   "class": "File",
                   "location": "file:///calrissian/output-data/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.browse.png",
                   "basename": "LC80650452017120LGN00_BQA_downsampled.browse.png",
                   "checksum": "sha1$11ce07256eaeda95c992c1c98e7cf0971b8c2497",
                   "size": 49848,
                   "path": "/calrissian/output-data/LC80650452017120LGN00_BQA_downsampled/LC80650452017120LGN00_BQA_downsampled.browse.png"
               }
           ],
           "path": "/calrissian/output-data/LC80650452017120LGN00_BQA_downsampled"
       },
       "stderr-stage_out": {
           "location": "file:///calrissian/output-data/stage_out-stderr.txt",
           "basename": "stage_out-stderr.txt",
           "class": "File",
           "checksum": "sha1$da39a3ee5e6b4b0d3255bfef95601890afd80709",
           "size": 0,
           "path": "/calrissian/output-data/stage_out-stderr.txt"
       },
       "stdout-stage_out": {
           "location": "file:///calrissian/output-data/stage_out-stdout.txt",
           "basename": "stage_out-stdout.txt",
           "class": "File",
           "checksum": "sha1$1e07a567218c77e7b180e996acf38a35910e9cdb",
           "size": 1202,
           "path": "/calrissian/output-data/stage_out-stdout.txt"
       }
   }
   INFO Final process status is success
   CALRISSIAN_DELETE_PODS=(<class 'str'>)
   returning True
   Starting Cleanup
   Finishing Cleanup
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
1. Verify that the`LC80650452017120LGN00_BQA_downsampled` dataset directory exists in the output-data directory:
   ```
   ls -ltr output-data/LC80650452017120LGN00_BQA_downsampled/
   ```

   Output should look similar to this:
   ```
   total 160
   -rw-r--r--  1 gmanipon  staff  20777 Feb 18 18:03 LC80650452017120LGN00_BQA_downsampled.TIF
   -rw-r--r--  1 gmanipon  staff   3008 Feb 18 18:03 LC80650452017120LGN00_BQA_downsampled.met.json
   -rw-r--r--  1 gmanipon  staff  49848 Feb 18 18:03 LC80650452017120LGN00_BQA_downsampled.browse.png
   ```

   and was staged to the S3 bucket location:
   ```
   aws s3 ls $(grep base_dataset_url stage_out-inputs.yml | awk '{print $2}')/$(grep path stage_out-inputs.yml | awk '{print $2}')/
   ```

   Output should look similar to this:
   ```
   2022-02-18 16:46:44      20777 LC80650452017120LGN00_BQA_downsampled.TIF
   2022-02-18 16:46:44      49848 LC80650452017120LGN00_BQA_downsampled.browse.png
   2022-02-18 16:46:44       3008 LC80650452017120LGN00_BQA_downsampled.met.json
   ```

### K8s Caveats

#### Azure Kubernetes Service

The default storage class utilizes azure disk which doesn't support `ReadWriteMany` which is required by
Calrissian. To change the default storage class to azure-file (which supports `ReadWriteMany`):

```
$ kubectl get storageclass
NAME                PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
azurefile           kubernetes.io/azure-file   Delete          Immediate              true                   106d
azurefile-premium   kubernetes.io/azure-file   Delete          Immediate              true                   106d
default (default)   kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d
managed-premium     kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d

$ kubectl patch storageclass default -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
storageclass.storage.k8s.io/default patched

$ kubectl get storageclass
NAME                PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
azurefile           kubernetes.io/azure-file   Delete          Immediate              true                   106d
azurefile-premium   kubernetes.io/azure-file   Delete          Immediate              true                   106d
default             kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d
managed-premium     kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d

$ kubectl patch storageclass azurefile -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
storageclass.storage.k8s.io/azurefile patched

$ kubectl get storageclass
NAME                  PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
azurefile (default)   kubernetes.io/azure-file   Delete          Immediate              true                   106d
azurefile-premium     kubernetes.io/azure-file   Delete          Immediate              true                   106d
default               kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d
managed-premium       kubernetes.io/azure-disk   Delete          WaitForFirstConsumer   true                   106d
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
