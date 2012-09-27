<?xml version="1.0" encoding="UTF-8"?>
<!-- 
  Purpose:
     Create bubble help table of content structures

   Author:    Thomas Schraitle <toms@opensuse.org>
   Copyright: 2012, Thomas Schraitle

-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="exsl">
  
  <xsl:template name="bubble-toc">
    <xsl:param name="node" 
      select="(ancestor-or-self::book | ancestor-or-self::article)[1]"/>
    
    <ol>
      <xsl:apply-templates select="$node" mode="bubble-toc"/>
    </ol>
  </xsl:template>
  
  <xsl:template name="bubble-subtoc">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="nodes" select="NOT-AN-ELEMENT"/>
    
    <xsl:variable name="depth">
      <xsl:choose>
        <xsl:when test="local-name(.) = 'section'">
          <xsl:value-of select="count(ancestor::section) + 1"/>
        </xsl:when>
        <xsl:when test="local-name(.) = 'sect1'">1</xsl:when>
        <xsl:when test="local-name(.) = 'sect2'">2</xsl:when>
        <xsl:when test="local-name(.) = 'sect3'">3</xsl:when>
        <xsl:when test="local-name(.) = 'sect4'">4</xsl:when>
        <xsl:when test="local-name(.) = 'sect5'">5</xsl:when>
        <xsl:when test="local-name(.) = 'refsect1'">1</xsl:when>
        <xsl:when test="local-name(.) = 'refsect2'">2</xsl:when>
        <xsl:when test="local-name(.) = 'refsect3'">3</xsl:when>
        <xsl:when test="local-name(.) = 'topic'">1</xsl:when>
        <xsl:when test="local-name(.) = 'simplesect'">
          <!-- sigh... -->
          <xsl:choose>
            <xsl:when test="local-name(..) = 'section'">
              <xsl:value-of select="count(ancestor::section)"/>
            </xsl:when>
            <xsl:when test="local-name(..) = 'sect1'">2</xsl:when>
            <xsl:when test="local-name(..) = 'sect2'">3</xsl:when>
            <xsl:when test="local-name(..) = 'sect3'">4</xsl:when>
            <xsl:when test="local-name(..) = 'sect4'">5</xsl:when>
            <xsl:when test="local-name(..) = 'sect5'">6</xsl:when>
            <xsl:when test="local-name(..) = 'topic'">2</xsl:when>
            <xsl:when test="local-name(..) = 'refsect1'">2</xsl:when>
            <xsl:when test="local-name(..) = 'refsect2'">3</xsl:when>
            <xsl:when test="local-name(..) = 'refsect3'">4</xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="depth.from.context" select="count(ancestor::*)-count($toc-context/ancestor::*)"/>
    
    <!--<xsl:call-template name="toc.line">
      <xsl:with-param name="toc-context" select="$toc-context"/>
    </xsl:call-template>-->
    <xsl:if test="$autotoc.label.in.hyperlink = 0">
      <xsl:variable name="label">
        <xsl:apply-templates select="." mode="label.markup"/>
      </xsl:variable>
      <xsl:copy-of select="$label"/>
      <xsl:if test="$label != ''">
        <xsl:value-of select="$autotoc.label.separator"/>
      </xsl:if>
    </xsl:if>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="context" select="$toc-context"/>
          <xsl:with-param name="toc-context" select="$toc-context"/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:if test="not($autotoc.label.in.hyperlink = 0)">
        <xsl:variable name="label">
          <xsl:apply-templates select="." mode="label.markup"/>
        </xsl:variable>
        <xsl:copy-of select="$label"/>
        <xsl:if test="$label != ''">
          <xsl:value-of select="$autotoc.label.separator"/>
        </xsl:if>
      </xsl:if>
      
      <xsl:apply-templates select="." mode="titleabbrev.markup"/>
    </a>
    <!--  -->
    <xsl:if test="( (self::set or self::book or self::part) or 
      $bubbletoc.section.depth &gt; $depth) and 
      count($nodes)>0 and 
      $bubbletoc.max.depth > $depth.from.context">
      <li>
        <xsl:apply-templates mode="bubble-toc" select="$nodes">
          <xsl:with-param name="toc-context" select="$toc-context"/>
        </xsl:apply-templates>
      </li>
    </xsl:if>
  </xsl:template>
  
  
  <xsl:template match="book" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes" 
        select="part|reference|preface|chapter|appendix|article|topic|bibliography|
        glossary|index|refentry|bridgehead[$bridgehead.in.toc != 0]"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="part|reference" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="appendix|chapter|article|topic|index|glossary|bibliography|preface|
        reference|refentry|bridgehead[$bridgehead.in.toc != 0]"
      />
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="preface|chapter|appendix|article|topic" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="section|sect1|simplesect[$simplesect.in.toc != 0]|
        topic|refentry|glossary|bibliography|index|
        bridgehead[$bridgehead.in.toc != 0]"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="sect1" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="sect2|bridgehead[$bridgehead.in.toc != 0]"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="sect2" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="sect3|bridgehead[$bridgehead.in.toc != 0]"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="sect3" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="sect4|bridgehead[$bridgehead.in.toc != 0]"
      />
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="sect4" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="sect5|bridgehead[$bridgehead.in.toc != 0]"
      />
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="sect5" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="simplesect" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="section" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="section|refentry|simplesect[$simplesect.in.toc != 0]|
        bridgehead[$bridgehead.in.toc != 0]"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="bibliography|glossary" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <xsl:call-template name="bubble-subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="title" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="object" select=".."/>
          <xsl:with-param name="toc-context" select="$toc-context"/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  
  <xsl:template match="index" mode="bubble-toc">
    <xsl:param name="toc-context" select="."/>
    
    <!-- If the index tag is not empty, it should be it in the TOC -->
    <xsl:if test="* or $generate.index != 0">
      <xsl:call-template name="bubble-subtoc">
        <xsl:with-param name="toc-context" select="$toc-context"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  
</xsl:stylesheet>