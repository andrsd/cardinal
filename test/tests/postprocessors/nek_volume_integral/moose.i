[Mesh]
  type = FileMesh
  file = ../meshes/pyramid.exo
[]

[AuxVariables]
  [temp_test]
  []
  [pressure_test]
  []
  [velocity_test]
  []
  [velocity_component]
  []
[]

[ICs]
  [temp_test]
    type = FunctionIC
    variable = temp_test
    function = temp
  []
  [pressure_test]
    type = FunctionIC
    variable = pressure_test
    function = pressure
  []
  [velocity_test]
    type = FunctionIC
    variable = velocity_test
    function = velocity
  []
  [velocity_component]
    type = FunctionIC
    variable = velocity_component
    function = velocity_component
  []
[]

[Variables]
  [dummy]
  []
[]

[Kernels]
  [dummy]
    type = Diffusion
    variable = dummy
  []
[]

[BCs]
  [fixed]
    type = DirichletBC
    variable = dummy
    value = 1.0
    boundary = '1'
  []
[]

[Functions]
  [temp]
    type = ParsedFunction
    value = 'exp(x)+sin(y)+x*y*z'
  []
  [pressure]
    type = ParsedFunction
    value = 'exp(x)+exp(y)+exp(z)'
  []
  [velocity]
    type = ParsedFunction
    value = 'sqrt(sin(x)*sin(x)+(y+1)*(y+1)+exp(x*y*z)*exp(x*y*z))'
  []
  [velocity_x]
    type = ParsedFunction
    value = 'sin(x)'
  []
  [velocity_y]
    type = ParsedFunction
    value = 'y+1'
  []
  [velocity_z]
    type = ParsedFunction
    value = 'exp(x*y*z)'
  []
  [velocity_component] # velocity along some generic direction (0.1, 0.2, 0.3)
    type = ParsedFunction
    value = '(vel_x * 0.1 + vel_y * 0.2 + vel_z * 0.3) / sqrt(0.1*0.1 + 0.2*0.2 + 0.3*0.3)'
    vars = 'vel_x vel_y vel_z'
    vals = 'velocity_x velocity_y velocity_z'
  []
[]

[Executioner]
  type = Transient
  dt = 5e-4
  num_steps = 1
[]

[Outputs]
  csv = true
  execute_on = 'final'
[]

[Postprocessors]
  [volume]
    type = VolumePostprocessor
  []
  [temp_integral]
    type = ElementIntegralVariablePostprocessor
    variable = temp_test
  []
  [pressure_integral]
    type = ElementIntegralVariablePostprocessor
    variable = pressure_test
  []
  [velocity_integral]
    type = ElementIntegralVariablePostprocessor
    variable = velocity_test
  []
  [velocity_component]
    type = ElementIntegralVariablePostprocessor
    variable = velocity_component
  []
[]
