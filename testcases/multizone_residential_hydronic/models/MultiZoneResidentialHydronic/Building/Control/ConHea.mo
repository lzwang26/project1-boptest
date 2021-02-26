within MultiZoneResidentialHydronic.Building.Control;
model ConHea "General controller for heating system"

  Buildings.Controls.Continuous.LimPID conHea(
    Ni=0.1,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    Td=1e4,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    k=k,
    Ti=Ti)
         "Controller for heating"
    annotation (Placement(transformation(extent={{-60,16},{-52,24}})));
  Modelica.Blocks.Interfaces.RealInput T annotation (Placement(transformation(
        rotation=0,
        extent={{-8,-8},{8,8}},
        origin={-108,12}), iconTransformation(extent={{-116,2},{-100,18}})));
  Modelica.Blocks.Interfaces.RealOutput yHea
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Interfaces.RealInput TSet annotation (Placement(
        transformation(
        rotation=0,
        extent={{-8,-8},{8,8}},
        origin={-108,30}), iconTransformation(extent={{-116,22},{-100,38}})));
  Modelica.Blocks.Math.Gain gaiHea(k=Khea)
    annotation (Placement(transformation(extent={{-28,16},{-20,24}})));
  parameter Real Khea=1e6 "Gain value for the heating controller";
  parameter Real k=1e-2 "Gain of controller";
  parameter Modelica.SIunits.Time Ti=1e2
    "Time constant of Integrator block";
  parameter String zone="1" "Zone designation";
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveTSetHea(u(
      min=273.15 + 10,
      max=273.15 + 95,
      unit="K"), description="Air temperature heating setpoint for " + zone)
    annotation (Placement(transformation(extent={{-94,26},{-86,34}})));

  IBPSA.Utilities.IO.SignalExchange.Overwrite oveActHea(u(
      min=0,
      max=1,
      unit="1"), description="Actuator heating signal for " + zone)
    annotation (Placement(transformation(extent={{-44,16},{-36,24}})));
equation
  connect(TSet, oveTSetHea.u)
    annotation (Line(points={{-108,30},{-94.8,30}}, color={0,0,127}));
  connect(conHea.y, oveActHea.u)
    annotation (Line(points={{-51.6,20},{-44.8,20}}, color={0,0,127}));
  connect(gaiHea.u, oveActHea.y)
    annotation (Line(points={{-28.8,20},{-35.6,20}}, color={0,0,127}));
  connect(gaiHea.y, yHea) annotation (Line(points={{-19.6,20},{-14,20},{-14,10},
          {10,10}}, color={0,0,127}));
  connect(oveTSetHea.y, conHea.u_s) annotation (Line(points={{-85.6,30},{-70,30},
          {-70,20},{-60.8,20}}, color={0,0,127}));
  connect(T, conHea.u_m)
    annotation (Line(points={{-108,12},{-56,12},{-56,15.2}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-20},{0,40}},   preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-100,-20},{0,40}})),
    Documentation(info="<html>
<h4>Control</h4>
<p>PID heating control to match a setpoint of temperature.</p>
</html>"));
end ConHea;
