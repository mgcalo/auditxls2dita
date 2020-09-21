<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:td="http://www.think-dita.com/tdfuncs"
      exclude-result-prefixes="xs td" version="2.0">

      <xsl:output method="xml" encoding="UTF-8" use-character-maps="mychars"/>

      <!-- add brief description here -->

      <xsl:template name="createtopic">
            <xsl:variable name="topictype">
                  <xsl:value-of select="@type"/>
            </xsl:variable>
            <xsl:text>&#60;!DOCTYPE </xsl:text>
            <xsl:value-of select="$topictype"/>
            <xsl:text> PUBLIC "-//OASIS//DTD DITA 1.3  </xsl:text>
            <xsl:value-of select="td:titleCase($topictype)"/>
            <xsl:text>//EN" "</xsl:text>
            <xsl:value-of select="$topictype"/>
            <xsl:text>.dtd">&#xA;</xsl:text>
            <xsl:element name="{$topictype}">
                  <xsl:attribute name="id">
                        <xsl:value-of select="concat(substring($topictype, 1, 2), '_', @sequence)"/>
                  </xsl:attribute>
                  <xsl:attribute name="xml:lang">en-GB</xsl:attribute>
                  <xsl:attribute name="translate">yes</xsl:attribute>

                  <xsl:comment>Audit sequence: <xsl:value-of select="@sequence"/> ;  Sequence: <xsl:value-of select="substring(@sequence, string-length(@sequence) - 2)"/> ; Level: <xsl:value-of select="@level"/> </xsl:comment>
                  <xsl:apply-templates/>
                  <xsl:call-template name="bodyelement"/>
            </xsl:element>
      </xsl:template>

      <xsl:template match="title">
            <xsl:element name="title">
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>
      <xsl:template match="shortdesc">
            <xsl:element name="shortdesc">
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>
      <xsl:template match="topic[not(contains(@type, 'map'))]/prolog">
            <xsl:element name="prolog">
                  <xsl:element name="source">
                        <xsl:value-of select="ancestor::topic[1]/@legacy_url"/>
                  </xsl:element>
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>

      <xsl:template match="metadata">
            <xsl:element name="metadata">
                  <xsl:if test="experiencelevel or job">
                        <xsl:element name="audience">
                              <xsl:if test="experiencelevel">
                                    <xsl:attribute name="experiencelevel">
                                          <xsl:value-of select="experiencelevel"/>
                              </xsl:attribute>
                              </xsl:if>
                              <xsl:if test="job">
                                    <xsl:attribute name="job">
                                          <xsl:value-of select="job"/>
                                    </xsl:attribute>
                              </xsl:if>
                        </xsl:element>
                  </xsl:if>
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>
      
      <xsl:template match="experiencelevel"/>
      <xsl:template match="job"/>
      
      <xsl:template match="category">
            <xsl:element name="category">
                  <xsl:value-of select="."/>
            </xsl:element>
      </xsl:template>
      
      <xsl:template match="prodinfo">
            <xsl:element name="prodinfo">
                  <xsl:element name="prodname">
                        <xsl:value-of select="prodname"/>
                  </xsl:element>
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>
      
      <xsl:template match="prodname"/>
      
      
      <xsl:template match="component">
            <xsl:element name="component">
                  <xsl:value-of select="."/>
            </xsl:element>
      </xsl:template>

      <xsl:template match="feature">
            <xsl:element name="othermeta">
                  <xsl:attribute name="name">feature</xsl:attribute>
                  <xsl:attribute name="content"><xsl:value-of select="."/></xsl:attribute>
            </xsl:element>
      </xsl:template>

     <xsl:template name="bodyelement">
            <xsl:variable name="topictype">
                  <xsl:value-of select="@type"/>
            </xsl:variable>
            <xsl:choose>
                  <xsl:when test="$topictype = 'concept'">
                        <xsl:element name="conbody"/>
                  </xsl:when>
                  <xsl:when test="$topictype = 'task'">
                        <xsl:element name="taskbody"/>
                  </xsl:when>
                  <xsl:when test="$topictype = 'reference'">
                        <xsl:element name="refbody"/>
                  </xsl:when>
                  <xsl:when test="$topictype = 'troubleshooting'">
                        <xsl:element name="troublebody"/>
                  </xsl:when>
                  <xsl:otherwise/>
            </xsl:choose>
      </xsl:template>


      <!-- create outline, keeping title levels -->

      <xsl:template name="manualstructure">
            <xsl:text>&#xA;&#60;!DOCTYPE map PUBLIC "-//OASIS//DTD DITA 1.3 Map//EN" "map.dtd">&#xA;</xsl:text>
            <xsl:element name="map">
                  <xsl:attribute name="id">
                        <xsl:value-of select="concat('m_', @sequence)"/>
                  </xsl:attribute>
                  
                  <xsl:attribute name="xml:lang">en-GB</xsl:attribute>
                  <xsl:attribute name="translate">yes</xsl:attribute>
                  
                  <xsl:element name="title">
                        <xsl:value-of select="title"/>
                  </xsl:element>
                  <xsl:element name="topicmeta">
                        <xsl:element name="shortdesc">
                              <xsl:value-of select="ancestor-or-self::topic/shortdesc"/>
                        </xsl:element>
                        <xsl:element name="source">
                             <xsl:value-of select="ancestor-or-self::topic/@legacy_url"/>
                        </xsl:element>
                        <xsl:if test="ancestor-or-self::topic/prolog/metadata/experiencelevel or ancestor-or-self::topic/prolog/metadata/job">
                              <xsl:element name="audience">
                                    <xsl:if test="ancestor-or-self::topic/prolog/metadata/experiencelevel">
                                          <xsl:attribute name="experiencelevel">
                                                <xsl:value-of select="ancestor-or-self::topic/prolog/metadata/experiencelevel"/>
                                          </xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test="ancestor-or-self::topic/prolog/metadata/job">
                                          <xsl:attribute name="job">
                                                <xsl:value-of select="ancestor-or-self::topic/prolog/metadata/job"/>
                                          </xsl:attribute>
                                    </xsl:if>
                              </xsl:element>
                        </xsl:if>
                        <xsl:apply-templates select="prolog/metadata/*"/>
                  </xsl:element>

                  <xsl:call-template name="topicrefs"/>
            </xsl:element>
      </xsl:template>


      <xsl:template name="topicrefs">
            <xsl:text>&#xA;</xsl:text>
            <xsl:for-each select="current-group()[not(contains(@type, 'map'))]">
                  <xsl:for-each select="1 to @level">
                        <xsl:text>&#x9;</xsl:text>
                  </xsl:for-each>
                  <xsl:choose>
                        <xsl:when test="following-sibling::topic[1]/@level = @level">
                              <xsl:text>&lt;topicref href="</xsl:text>
                              <xsl:value-of select="@sequence"/>
                              <xsl:text>.xml"/>&#xA;</xsl:text>
                        </xsl:when>
                        <xsl:when test="following-sibling::topic[1]/@level &gt; @level">
                              <xsl:text>&lt;topicref href="</xsl:text>
                              <xsl:value-of select="@sequence"/>
                              <xsl:text>.xml">&#xA;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                              <xsl:text>&lt;topicref href="</xsl:text>
                              <xsl:value-of select="@sequence"/>
                              <xsl:text>.xml"/>&#xA;</xsl:text>
                              <xsl:variable name="nextlevel">
                                    <xsl:choose>
                                          <xsl:when
                                                test="following-sibling::topic[1][not(contains(@type, 'map'))]">
                                                <xsl:value-of
                                                  select="xs:integer(following-sibling::topic[1]/@level)"
                                                />
                                          </xsl:when>
                                          <xsl:otherwise>1</xsl:otherwise>
                                    </xsl:choose>
                              </xsl:variable>
                              <xsl:for-each select="1 to xs:integer(@level - 1)">
                                    <xsl:text>&#x9;</xsl:text>
                              </xsl:for-each>
                              <xsl:variable name="backlevels"
                                    select="xs:integer(@level) - xs:integer($nextlevel)"
                                    as="xs:integer"/>
                              <xsl:for-each select="1 to $backlevels"
                                    >&#60;/topicref>&#xA;</xsl:for-each>
                        </xsl:otherwise>
                  </xsl:choose>
            </xsl:for-each>
      </xsl:template>

      <xsl:template match="topics">
            <xsl:variable name="maincompon">audit</xsl:variable>
            
            <xsl:choose>
                  <xsl:when test="topic[@type='map']">
                        <!-- routine with maps -->
                        
                        <xsl:for-each-group select="topic" group-starting-with=".[@type = 'map']">
                              <xsl:result-document method="xml" indent="yes" href="{@sequence}.ditamap">
                                    <xsl:call-template name="manualstructure"/>
                              </xsl:result-document>
                              
                              
                              <xsl:for-each select="current-group()[not(contains(@type, 'map'))]">
                                    <xsl:result-document method="xml" indent="yes" href="{@sequence}.xml">
                                          <xsl:call-template name="createtopic"/>
                                    </xsl:result-document>
                              </xsl:for-each>
                              
                        </xsl:for-each-group>
                        
                        <!-- create super-map -->
                       
                        <xsl:result-document method="xml" indent="yes" href="allmaps_{$maincompon}.ditamap">
                              <xsl:text>&#xA;&#60;!DOCTYPE map PUBLIC "-//OASIS//DTD DITA 1.3 Map//EN" "map.dtd">&#xA;</xsl:text>
                              <xsl:element name="map">
                                    <xsl:attribute name="id"><xsl:value-of select="concat('allmaps_',$maincompon)"/></xsl:attribute>
                                    
                                    
                                    <xsl:attribute name="xml:lang">en-GB</xsl:attribute>
                                    <xsl:attribute name="translate">yes</xsl:attribute>
                                    <xsl:element name="title"><xsl:value-of select="concat('All maps for ',$maincompon)"/></xsl:element>
                                    <xsl:element name="topicmeta">
                                          <xsl:element name="shortdesc"><xsl:value-of select="concat('All generated maps for ',$maincompon)"/></xsl:element>
                                    </xsl:element>
                                    
                                    <xsl:for-each select="topic[@type = 'map']">
                                          <xsl:element name="mapref">
                                                <xsl:attribute name="href">
                                                      <xsl:value-of select="concat(@sequence, '.ditamap')"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="navtitle"><xsl:value-of select="title"/></xsl:attribute>
                                          </xsl:element>
                                    </xsl:for-each>
                              </xsl:element>
                        </xsl:result-document>
                        
                  </xsl:when>
                  <xsl:otherwise>
                        <!-- routine without maps -->
                        
                        <xsl:for-each select="topic">
                              <xsl:result-document method="xml" indent="yes" href="{@sequence}.xml">
                                    <xsl:call-template name="createtopic"/>
                              </xsl:result-document>
                        </xsl:for-each>
                        
                        <xsl:result-document method="xml" indent="yes" href="alltopics_{$maincompon}.ditamap">
                              <xsl:call-template name="manualstructure"/>
                        </xsl:result-document>
                        
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:template>


      <xsl:function name="td:titleCase" as="xs:string">
            <xsl:param name="str" as="xs:string"/>
            <xsl:sequence
                  select="
                        string-join(for $x in tokenize($str, '\s')
                        return
                              concat(upper-case(substring($x, 1, 1)), lower-case(substring($x, 2))), ' ')"
            />
      </xsl:function>

      <xsl:character-map name="mychars">
            <xsl:output-character character="&lt;" string="&#60;"/>
            <xsl:output-character character="&gt;" string="&#62;"/>
      </xsl:character-map>

</xsl:stylesheet>
