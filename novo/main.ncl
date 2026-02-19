<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="main" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
    <head>
        <regionBase>
            <region id="regLua" width="100%" height="100%" zIndex="1"/>
        </regionBase>

        <descriptorBase>
            <descriptor id="descLua" region="regLua" focusIndex="1"/>
        </descriptorBase>
    </head>
    <body>
        <port id="pLua" component="appLua"/>
        
        <media id="appLua" src="application.lua" descriptor="descLua"/>
    </body>
</ncl>