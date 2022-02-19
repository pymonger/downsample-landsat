#!/usr/bin/env cwltool

cwlVersion: v1.1
class: Workflow
$namespaces:
  cwltool: 'http://commonwl.org/cwltool#'
hints:
  'cwltool:Secrets':
    secrets:
      - workflow_aws_access_key_id
      - workflow_aws_secret_access_key

inputs:
  workflow_input_url: string
  workflow_min_spin_time: int
  workflow_max_spin_time: int
  workflow_aws_access_key_id: string
  workflow_aws_secret_access_key: string
  workflow_base_dataset_url: string

outputs:
  final_dataset_dir:
    type: Directory
    outputSource: downsample_landsat/dataset_dir
  stdout-downsample_landsat:
    type: File
    outputSource: downsample_landsat/stdout_file
  stderr-downsample_landsat:
    type: File
    outputSource: downsample_landsat/stderr_file
  stdout-stage_out:
    type: File
    outputSource: stage_out/stdout_file
  stderr-stage_out:
    type: File
    outputSource: stage_out/stderr_file

steps:

  downsample_landsat:
    run: downsample_landsat.cwl
    in:
      input_url: workflow_input_url
      min_spin_time: workflow_min_spin_time
      max_spin_time: workflow_max_spin_time
    out:
      - output_nb_file
      - dataset_dir
      - stdout_file
      - stderr_file

  stage_out:
    run: stage_out.cwl
    in:
      aws_access_key_id: workflow_aws_access_key_id
      aws_secret_access_key: workflow_aws_secret_access_key
      dataset_dir: downsample_landsat/dataset_dir
      base_dataset_url: workflow_base_dataset_url
    out:
      - stdout_file
      - stderr_file
