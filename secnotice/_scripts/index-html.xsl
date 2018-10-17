<!--
  - This program is free software; you can redistribute it and/or modify
  - it under the terms of the GNU General Public License as published by
  - the Free Software Foundation; either version 2 of the License, or
  - (at your option) any later version.
  -
  - This program is distributed in the hope that it will be useful,
  - but WITHOUT ANY WARRANTY; without even the implied warranty of
  - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  - GNU General Public License for more details.
  -
  - You should have received a copy of the GNU General Public License
  - along with this program.  If not, see
  - <http://www.gnu.org/licenses/>.
  -->
<xsl:stylesheet
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:qsn="http://qemu.org/xmlns/security-notice/1.0"
  xmlns:qsnl="http://qemu.org/xmlns/security-notice-list/1.0"
  exclude-result-prefixes="xsl qsn qsnl"
  version="1.0">

  <xsl:output method="html" indent="yes"/>

  <xsl:param name="permalink" select="'/secnotice/'"/>

  <xsl:template match="/qsnl:security-notice-list">---
title: QEMU Security Notices
permalink: <xsl:value-of select="$permalink"/>
---

   <p>
     If you believe you have identified a new security issue in QEMU, please
     follow the <a href="https://wiki.qemu.org/SecurityProcess">security process</a>
     to report it in a non-public way. Do <strong>NOT</strong> use the bug tracker,
     mailing lists, or IRC to report non-public security issues.
   </p>

    <ul>
      <xsl:apply-templates select="qsnl:security-notice">
	<xsl:sort select="@name" order="descending" />
      </xsl:apply-templates>
    </ul>

    <p class="alt">
      Alternative formats: <a href="index.xml">[xml]</a>
    </p>
  </xsl:template>

  <xsl:template name="qsnhref">
    <xsl:param name="id"/>

    <xsl:variable name="dir" select="substring-before($id, '-')"/>
    <xsl:variable name="file" select="substring-after($id, '-')"/>

    <xsl:value-of select="concat($dir, '/', $file)"/>
  </xsl:template>

  <xsl:template match="qsnl:security-notice">
    <xsl:variable name="notice" select="document(concat('../../', @name))"/>
    <xsl:variable name="id" select="$notice/qsn:security-notice/qsn:id"/>
    <xsl:variable name="summary" select="$notice/qsn:security-notice/qsn:summary"/>
    <xsl:variable name="href">
      <xsl:call-template name="qsnhref">
	<xsl:with-param name="id" select="$id"/>
      </xsl:call-template>
    </xsl:variable>

    <li><a href="{$href}">QSN-<xsl:value-of select="$id"/>: <xsl:value-of select="$summary"/></a></li>
  </xsl:template>
</xsl:stylesheet>
