#!/usr/bin/env cwltool

cwlVersion: v1.1
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: 'pymonger/downsample-landsat:3.0.0'
baseCommand:
  - papermill
  - /home/jovyan/downsample-landsat/downsample_landsat.ipynb
  - output_nb.ipynb
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing: 
      - $(inputs.input_file)

inputs:
  input_file:
    type: File
    inputBinding:
      position: 1
      shellQuote: false
      prefix: '--parameters'
      valueFrom: |
        input_file "$(self.basename)"
  min_stress_time:
    type: int
    inputBinding:
      position: 2
      shellQuote: false
      prefix: '--parameters'
      valueFrom: |
        min_stress_time "$(self)"
  max_stress_time:
    type: int
    inputBinding:
      position: 3
      shellQuote: false
      prefix: '--parameters'
      valueFrom: |
        max_stress_time "$(self)"

outputs:
  output_nb_file:
    type: File
    outputBinding:
      glob: output_nb.ipynb
  dataset_dir:
    type: Directory
    outputBinding:
      glob: '*_downsampled'
#  stdout_file:
#    type: stdout
#  stderr_file:
#    type: stderr
#stdout: downsample_landsat-stdout.txt
#stderr: downsample_landsat-stderr.txt
