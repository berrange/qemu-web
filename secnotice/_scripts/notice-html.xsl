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
  exclude-result-prefixes="xsl qsn"
  version="1.0">

  <xsl:output method="html" indent="yes"/>

  <xsl:template name="selfhref">
    <xsl:param name="id"/>
    <xsl:param name="ext"/>

    <xsl:variable name="dir" select="substring-before($id, '-')"/>
    <xsl:variable name="file" select="substring-after($id, '-')"/>

    <xsl:value-of select="concat('/secnotice/', $dir, '/', $file, $ext)"/>
  </xsl:template>

  <xsl:template match="/qsn:security-notice">---
title: QEMU Security Notice: QSN-<xsl:value-of select="qsn:id"/>
permalink: <xsl:call-template name="selfhref">
  <xsl:with-param name="id" select="qsn:id"/>
</xsl:call-template>
---

    <h2>
      <xsl:value-of select="qsn:summary"/>
    </h2>

    <xsl:apply-templates select="qsn:lifecycle"/>
    <xsl:apply-templates select="qsn:credits"/>

    <xsl:apply-templates select="qsn:reference"/>
    <xsl:apply-templates select="qsn:description"/>
    <xsl:apply-templates select="qsn:impact"/>
    <xsl:apply-templates select="qsn:workaround"/>
    <xsl:apply-templates select="qsn:repository"/>

    <hr/>

    <xsl:call-template name="selflink"/>
  </xsl:template>

  <xsl:template name="selflink">
    <p class="alt">
      Alternative formats:
      <a>
	<xsl:attribute name="href">
	  <xsl:call-template name="selfhref">
	    <xsl:with-param name="id" select="qsn:id"/>
	    <xsl:with-param name="ext" select="'.xml'"/>
	  </xsl:call-template>
	</xsl:attribute>
	<xsl:text>[xml]</xsl:text>
      </a>
      <xsl:text> </xsl:text>
      <a>
	<xsl:attribute name="href">
	  <xsl:call-template name="selfhref">
	    <xsl:with-param name="id" select="qsn:id"/>
	    <xsl:with-param name="ext" select="'.txt'"/>
	  </xsl:call-template>
	</xsl:attribute>
	<xsl:text>[text]</xsl:text>
      </a>
    </p>
  </xsl:template>

  <xsl:template match="qsn:lifecycle">
    <h3>Lifecycle</h3>
    <table>
      <tr>
	<th>Reported on:</th>
	<td><xsl:value-of select="qsn:reported"/></td>
      </tr>
      <tr>
	<th>Published on:</th>
	<td><xsl:value-of select="qsn:published"/></td>
      </tr>
      <tr>
	<th>Fixed on:</th>
	<td><xsl:value-of select="qsn:fixed"/></td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="qsn:credits">
    <h3>Credits</h3>
    <table>
      <xsl:for-each select="qsn:reporter">
	<tr>
	  <xsl:if test="position() = 1">
	    <th>Reported by:</th>
	  </xsl:if>
	  <xsl:if test="position() > 1">
	    <th></th>
	  </xsl:if>
	  <td>
	    <a href="mailto:{qsn:email}"><xsl:value-of select="qsn:name"/></a>
	  </td>
	</tr>
      </xsl:for-each>
      <xsl:for-each select="qsn:patcher">
	<tr>
	  <xsl:if test="position() = 1">
	    <th>Patched by:</th>
	  </xsl:if>
	  <xsl:if test="position() > 1">
	    <th></th>
	  </xsl:if>
	  <td>
	    <a href="mailto:{qsn:email}"><xsl:value-of select="qsn:name"/></a>
	  </td>
	</tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="qsn:advisory">
    <xsl:value-of select="@type"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="@id"/>
  </xsl:template>

  <xsl:template match="qsn:bug">
    <xsl:value-of select="@tracker"/>
    <xsl:text> bug #</xsl:text>
    <xsl:value-of select="@id"/>
  </xsl:template>

  <xsl:template match="qsn:reference">
    <h3>See also</h3>
    <ul>
    <xsl:for-each select="qsn:advisory|qsn:bug">
      <li><xsl:apply-templates select="."/></li>
    </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="qsn:description">
    <h3>Description</h3>
    <p>
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

  <xsl:template match="qsn:impact">
    <h3>Impact</h3>
    <p>
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

  <xsl:template match="qsn:workaround">
    <h3>Workaround</h3>
    <p>
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

  <xsl:template name="gitbranch">
    <xsl:param name="branch"/>

    <a href="http://git.qemu.org/?p=qemu.git;a=shortlog;h=refs/heads/{$branch}"><xsl:value-of select="$branch"/></a>
  </xsl:template>

  <xsl:template name="gittag">
    <xsl:param name="tag"/>

    <a href="http://git.qemu.org/?p=qemu.git;a=tag;h={$tag}"><xsl:value-of select="$tag"/></a>
  </xsl:template>

  <xsl:template name="gitchange">
    <xsl:param name="change"/>

    <a href="http://git.qemu.org/?p=qemu.git;a=commit;h={$change}"><xsl:value-of select="$change"/></a>
  </xsl:template>

  <xsl:template match="qsn:repository">
    <h3>Related commits</h3>

    <xsl:for-each select="qsn:branch">
      <table>
	<tr>
	  <th>Branch</th>
	  <td>
	    <xsl:call-template name="gitbranch">
	      <xsl:with-param name="branch" select="qsn:name"/>
	    </xsl:call-template>
	  </td>
	</tr>
	<xsl:for-each select="qsn:tag[@state='vulnerable']">
	  <tr>
	    <th>Broken in:</th>
	    <td>
	      <xsl:call-template name="gittag">
		<xsl:with-param name="tag" select="."/>
	      </xsl:call-template>
	    </td>
	  </tr>
	</xsl:for-each>
	<xsl:for-each select="qsn:tag[@state='fixed']">
	  <tr>
	    <th>Fixed in:</th>
	    <td>
	      <xsl:call-template name="gittag">
		<xsl:with-param name="tag" select="."/>
	      </xsl:call-template>
	    </td>
	  </tr>
	</xsl:for-each>
	<xsl:for-each select="qsn:change[@state='vulnerable']">
	  <tr>
	    <th>Broken by:</th>
	    <td>
	      <xsl:call-template name="gitchange">
		<xsl:with-param name="change" select="."/>
	      </xsl:call-template>
	    </td>
	  </tr>
	</xsl:for-each>
	<xsl:for-each select="qsn:change[@state='fixed']">
	  <tr>
	    <th>Fixed by:</th>
	    <td>
	      <xsl:call-template name="gitchange">
		<xsl:with-param name="change" select="."/>
	      </xsl:call-template>
	    </td>
	  </tr>
	</xsl:for-each>
      </table>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
