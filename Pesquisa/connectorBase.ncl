<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="connectorBase" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.ncl.org.br/NCL3.0/EDTVProfile http://www.ncl.org.br/NCL3.0/profiles/NCL30EDTV.xsd">
	<head>
		<connectorBase>
			<causalConnector id="onBegin1StartN">
				<simpleCondition role="onBegin"/>
				<simpleAction max="unbounded" qualifier="par" role="start"/>
			</causalConnector>
			<causalConnector id="onEnd1StopN">
				<simpleCondition role="onEnd"/>
				<simpleAction max="unbounded" qualifier="par" role="stop"/>
			</causalConnector>
			<causalConnector id="onEndStart">
				<simpleCondition role="onEnd"/>
				<simpleAction max="unbounded" qualifier="par" role="start"/>
			</causalConnector>
			<causalConnector id="PauseStart">
				<simpleCondition role="onBegin"/>
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="start"/>
					<simpleAction max="unbounded" qualifier="par" role="stop"/>
				</compoundAction>
			</causalConnector>
			<causalConnector id="onKeySelection1StartNStopN">
				<connectorParam name="keyCode"/>
				<simpleCondition key="$keyCode" role="onSelection"/>
				<compoundAction operator="seq">
					<simpleAction max="unbounded" role="stop" qualifier="seq"/>
					<simpleAction max="unbounded"  role="start" qualifier="seq"/>
				</compoundAction>
			</causalConnector>
			<causalConnector id="onKeySelection1StartNStopN2">
				<simpleCondition role="onBegin"/>
				<compoundAction delay="5s" operator="seq">
					<simpleAction max="1" role="stop"/>
					<simpleAction max="1" role="start"/>
				</compoundAction>
			</causalConnector>
			<causalConnector id="onKeySelection1ResumeNstopN">
				<connectorParam name="keyCode"/>
				<simpleCondition key="$keyCode" role="onSelection"/>
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="resume"/>
					<simpleAction max="unbounded" qualifier="par" role="stop"/>
				</compoundAction>
			</causalConnector>
			<causalConnector id="onKeySelection1StopN">
				<connectorParam name="keyCode"/>
				<simpleCondition key="$keyCode" role="onSelection"/>
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="stop"/>
				</compoundAction>
			</causalConnector>
			<causalConnector id="onKeySelectionStart">
				<connectorParam name="keyCode"/>
				<simpleCondition key="$keyCode" role="onSelection"/>
				<simpleAction role="start"/>
			</causalConnector>
			<causalConnector id="onKeySelectionSet">
				<connectorParam name="keyCode"/>
				<connectorParam name="var"/>
				<simpleCondition key="$keyCode" role="onSelection"/>
				<simpleAction role="set" value="$var"/>
			</causalConnector>
			<causalConnector id="onBeginSet">
				<connectorParam name="var"/>
				<simpleCondition role="onBegin"/>
				<simpleAction role="set" value="$var"/>
			</causalConnector>
		</connectorBase>
	</head>
</ncl>
