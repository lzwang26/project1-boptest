within BuildingControlEmulator.Devices.Fault.Examples;
model dPreSemsorDev
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium for water";

  Buildings.Obsolete.Fluid.Sources.FixedBoundary souW(
    redeclare package Medium = Medium,
    T=273.15 + 20,
    p(displayUnit="Pa") = 100000 + 100,
    nPorts=1) "Source for water"
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Buildings.Obsolete.Fluid.Sources.FixedBoundary sinW(
    redeclare package Medium = Medium,
    T=273.15 + 20,
    p(displayUnit="Pa") = 100000,
    nPorts=1) "Source for water"
    annotation (Placement(transformation(extent={{46,-30},{26,-10}})));
  BuildingControlEmulator.Devices.Fault.TwoWayStuck val(
    m_flow_nominal=1,
    dpValve_nominal=100,
    redeclare package Medium = Medium,
    FauTime=86400*0.5,
    y_stuck=0.5)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Blocks.Sources.Ramp sine(duration=86400, offset=0)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  BuildingControlEmulator.Devices.Fault.dPreSensorDev dPreSensorDev(
    redeclare package Medium = Medium,
    dp=0.1,
    FauTime=14300)
    annotation (Placement(transformation(extent={{-14,-60},{6,-40}})));
equation
  connect(souW.ports[1], val.port_a) annotation (Line(
      points={{-50,-20},{-50,-20},{-20,-20}},
      color={0,127,255},
      thickness=1));
  connect(val.port_b, sinW.ports[1]) annotation (Line(
      points={{0,-20},{26,-20}},
      color={0,127,255},
      thickness=1));
  connect(sine.y, val.y) annotation (Line(
      points={{-39,30},{-10,30},{-10,-8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(dPreSensorDev.port_a, val.port_a) annotation (Line(points={{-14,-50},
          {-26,-50},{-26,-20},{-20,-20}}, color={0,127,255}));
  connect(dPreSensorDev.port_b, val.port_b) annotation (Line(points={{6,-50},{
          12,-50},{12,-30},{0,-30},{0,-20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end dPreSemsorDev;
