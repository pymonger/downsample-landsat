#!/usr/bin/env cwl-runner

cwlVersion: v1.1
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: 'pymonger/hello-world:stable'
baseCommand:
  - papermill
  - /home/jovyan/hello-world/downsample_landsat/downsample_landsat.ipynb
  - output_nb.ipynb
requirements:
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true
inputs:
  input_url:
    type: string
    inputBinding:
      position: 1
      shellQuote: false
      prefix: '--parameters'
      valueFrom: |
        input_url "$(self)"
  min_spin_time:
    type: int
    inputBinding:
      position: 2
      shellQuote: false
      prefix: '--parameters'
      valueFrom: |
        min_spin_time "$(self)"
  max_spin_time:
    type: int
    inputBinding:
      position: 3
      shellQuote: false
      prefix: '--parameters'
      valueFrom: |
        max_spin_time "$(self)"
outputs:
  output_nb_file:
    type: File
    outputBinding:
      glob: output_nb.ipynb
  dataset_dir:
    type: Directory
    outputBinding:
      glob: '*_downsampled'
  stdout_file:
    type: stdout
  stderr_file:
    type: stderr
stdout: downsample_landsat-stdout.txt
stderr: downsample_landsat-stderr.txt
