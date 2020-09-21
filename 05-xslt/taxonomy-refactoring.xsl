<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:td="http://www.think-dita.com/tdfuncs"
      exclude-result-prefixes="xs td" version="2.0">

      <xsl:output method="xml" encoding="UTF-8" use-character-maps="mychars"/>

      <!-- add brief description here -->

	<xsl:template match="taxonomy">        
      	<xsl:text>&#xA;&#60;!DOCTYPE subjectScheme PUBLIC "-//OASIS//DTD DITA Subject Scheme Map//EN" "subjectScheme.dtd">&#xA;</xsl:text>
      	<xsl:element name="subjectScheme">
      		<xsl:element name="subjectHead">
      			<xsl:element name="subjectHeadMeta">
      				<xsl:element name="navtitle">Taxonomy</xsl:element>
      			</xsl:element>
      		</xsl:element>
      	<xsl:for-each-group select="valuedef" group-by="@keys">
      		<xsl:element name="hasInstance">
      			<xsl:element name="subjectdef">
      				<xsl:attribute name="keys">
      					<xsl:value-of select="concat(@keys,'SbjKey')"/>
      				</xsl:attribute>
      				<xsl:for-each select="current-group()">
      					<xsl:call-template name="create_key"/>
      				</xsl:for-each>
      			</xsl:element>
      		</xsl:element>
      	</xsl:for-each-group>
      		<xsl:for-each-group select="valuedef" group-by="@keys">
      			<xsl:element name="enumerationdef">
      				<xsl:element name="elementdef">
      					<xsl:attribute name="name"><xsl:value-of select="@elem"/></xsl:attribute>
      				</xsl:element>
      				<xsl:element name="attributedef">
      					<xsl:attribute name="name"><xsl:value-of select="@att"/></xsl:attribute>
      				</xsl:element>
      				<xsl:element name="subjectdef">
      					<xsl:attribute name="keyref"><xsl:value-of select="concat(@keys,'SbjKey')"/></xsl:attribute>
      				</xsl:element>
      			</xsl:element>
      		</xsl:for-each-group>
      	</xsl:element>
      </xsl:template>
      	
	<xsl:template name="create_key">         
		<xsl:element name="subjectdef">
			<xsl:attribute name="keys">
				<xsl:value-of select="@code"/>
			</xsl:attribute>
			<xsl:element name="topicmeta">
				<xsl:element name="navtitle">
					<xsl:value-of select="topicmeta/navtitle"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="topicmeta"/>
	<xsl:template match="navtitle"/>
	
      <xsl:character-map name="mychars">
            <xsl:output-character character="&lt;" string="&#60;"/>
            <xsl:output-character character="&gt;" string="&#62;"/>
      </xsl:character-map>

</xsl:stylesheet>
