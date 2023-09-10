<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/main">
	<html>
	<head>
	<style>
	input {
		display: none;
	}
	.game {
		position: absolute;
		width: 400px;
		height: 400px;
		top: 40px;
	}
		.node {
			width: 20px;
			height: 20px;
			border: 1px solid black;
			cursor: pointer;
			position: absolute;
			display: block;
			background: white;
		}
		.blank {
			cursor: unset;
			z-index: 1;
		}
		.fox, .fox-a {
			z-index: 0;
			cursor: unset;
		}
		.goose, .goosea, .goose-dead {
			z-index: 0;
		}
		.goose-dead {
			display: none;
		}
		.goosea {
			
		}
		<xsl:for-each select="node">
			.node-<xsl:value-of select="position()" /> {
				top: calc(<xsl:value-of select="y" /> * 45px);
				left: calc(<xsl:value-of select="x" /> * 45px);
			}
			#fox-<xsl:value-of select="position()" />:checked ~ div .fox.node-<xsl:value-of select="position()" /> {
				z-index: 500;
			}
			.fox-m<xsl:value-of select="position()" />:checked ~ div .fox.node-<xsl:value-of select="position()" /> {
				z-index: 500;
				background: #FCA;
			}
			.fox-a<xsl:value-of select="position()" />:checked ~ div .fox.node-<xsl:value-of select="position()" /> {
				z-index: 500;
				background: #ACF;
			}
		</xsl:for-each>
		<xsl:for-each select="node">
			<xsl:variable name="pid" select="position()"/>
			<xsl:for-each select="neighbor">
				#fox-<xsl:value-of select="$pid" />:checked ~ div .fox-m.node-<xsl:value-of select="$pid" /> {
					z-index: 40;
					background: #DDF;
					left: 300px;
					top: 30px;
					cursor: pointer;
				}
				#fox-<xsl:value-of select="$pid" />:checked ~ .gooseInput-<xsl:value-of select="." />:checked ~ div .fox-m.to-<xsl:value-of select="." /> {
					display: none;
				}
				#fox-m<xsl:value-of select="$pid" />-<xsl:value-of select="." />:checked ~ div .fox.node-<xsl:value-of select="." /> {
					z-index: 40;
					background: #DDF;
					left: 300px;
					top: 30px;
					cursor: pointer;
				}
			</xsl:for-each>
			<xsl:for-each select="jump">
				#fox-<xsl:value-of select="$pid" />:checked ~ .gooseInput-<xsl:value-of select="b" />:checked ~ div .fox-j.node-<xsl:value-of select="$pid" />.c-<xsl:value-of select="c" /> {
					z-index: 40;
					background: #DDF;
					left: 300px;
					top: 30px;
					cursor: pointer;
				}
				#fox-<xsl:value-of select="$pid" />:checked ~ .gooseInput-<xsl:value-of select="c" />:checked ~ div .fox-j.c-<xsl:value-of select="c" /> {
					display: none;
				}
				#fox-j<xsl:value-of select="$pid" />-<xsl:value-of select="c" />:checked ~ div .fox.node-<xsl:value-of select="c" /> {
					z-index: 40;
					background: #DDF;
					left: 300px;
					top: 30px;
					cursor: pointer;
				}
				#fox-j<xsl:value-of select="$pid" />-<xsl:value-of select="c" />:checked ~ div .goose-dead.node-<xsl:value-of select="b" /> {
					z-index: 45;
					background: #DDF;
					left: 300px;
					top: 30px;
					cursor: pointer;
				}
				
			</xsl:for-each>
		</xsl:for-each>
		
		
		<xsl:for-each select="goose">
			<xsl:variable name="gid" select="."/>
			<xsl:for-each select="../node">
				<xsl:variable name="pid" select="position()"/>
				#goose-<xsl:value-of select="$gid" />-<xsl:value-of select="position()" />:checked ~ div .goosea-<xsl:value-of select="$gid" />.node-<xsl:value-of select="position()" /> {
					z-index: 50;
				}
				#goose-<xsl:value-of select="$gid" />-<xsl:value-of select="position()" />:checked ~ div .goose-<xsl:value-of select="$gid" />-dead.node-<xsl:value-of select="position()" /> {
					display: block;
				}
				<xsl:for-each select="neighbor">
				#goose-<xsl:value-of select="$gid" />-a<xsl:value-of select="$pid" />:checked ~ div .goose-<xsl:value-of select="$gid" />.node-<xsl:value-of select="." /> {
					z-index: 30;
					background: #FDD;
				}
				</xsl:for-each>
				#goose-<xsl:value-of select="$gid" />-a<xsl:value-of select="$pid" />:checked ~ div .goose-<xsl:value-of select="$gid" />.node-<xsl:value-of select="$pid" /> {
					z-index: 30;
					background: #DFD;
				}
			</xsl:for-each>
		</xsl:for-each>
		
	</style>
	</head>
		<body>
			<xsl:for-each select="node">
				<xsl:variable name="pid" select="position()"/>
				<input type="radio" name="fox">
				<xsl:attribute name="id">fox-<xsl:value-of select="position()" /></xsl:attribute>
				<xsl:if test="z>1"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
				</input>
				<xsl:for-each select="neighbor">
					<input type="radio" name="fox">
					<xsl:attribute name="id">fox-m<xsl:value-of select="$pid" />-<xsl:value-of select="." /></xsl:attribute>
					<xsl:attribute name="class">fox-m<xsl:value-of select="$pid" /></xsl:attribute>
					</input>
				</xsl:for-each>
				<xsl:for-each select="jump">
					<input type="radio" name="fox">
					<xsl:attribute name="id">fox-j<xsl:value-of select="a" />-<xsl:value-of select="c" /></xsl:attribute>
					<xsl:attribute name="class">fox-a<xsl:value-of select="a" /> fox-b<xsl:value-of select="b" /> fox-c<xsl:value-of select="c"/></xsl:attribute>
					</input>
				</xsl:for-each>
			</xsl:for-each>
			
			<xsl:for-each select="goose">
				<xsl:variable name="gid" select="."/>
				<xsl:for-each select="../node">
					<input type="radio">
					<xsl:attribute name="name">goose-<xsl:value-of select="$gid"/></xsl:attribute>
					<xsl:attribute name="id">goose-<xsl:value-of select="$gid"/>-<xsl:value-of select="position()" /></xsl:attribute>
					<xsl:attribute name="class">gooseInput-<xsl:value-of select="position()" /></xsl:attribute>
					<xsl:if test="position()=$gid"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
					</input>
					<input type="radio">
					<xsl:attribute name="name">goose-<xsl:value-of select="$gid"/></xsl:attribute>
					<xsl:attribute name="id">goose-<xsl:value-of select="$gid"/>-a<xsl:value-of select="position()" /></xsl:attribute>
					</input>
				</xsl:for-each>
				<input type="radio">
					<xsl:attribute name="name">goose-<xsl:value-of select="$gid"/></xsl:attribute>
					<xsl:attribute name="id">goose-<xsl:value-of select="$gid"/>-dead</xsl:attribute>
				</input>
			</xsl:for-each>

			<div class="game">
			<xsl:for-each select="node">
				<label>
				<xsl:attribute name="class">node blank node-<xsl:value-of select="position()" /></xsl:attribute>
				</label>
			</xsl:for-each>
			<xsl:for-each select="node">
				<xsl:variable name="pid" select="position()"/>
				<label>
				<xsl:attribute name="for">fox-<xsl:value-of select="$pid" /></xsl:attribute>
				<xsl:attribute name="class">node fox node-<xsl:value-of select="$pid" /></xsl:attribute>
				F
				</label>
				<xsl:for-each select="neighbor">
					<label>
					<xsl:attribute name="for">fox-m<xsl:value-of select="$pid" />-<xsl:value-of select="." /></xsl:attribute>
					<xsl:attribute name="class">node fox-m node-<xsl:value-of select="$pid" /> to-<xsl:value-of select="." /></xsl:attribute>
					F
					</label>
				</xsl:for-each>
				<xsl:for-each select="jump">
					<label>
					<xsl:attribute name="for">fox-j<xsl:value-of select="$pid" />-<xsl:value-of select="c" /></xsl:attribute>
					<xsl:attribute name="class">node fox-j node-<xsl:value-of select="$pid" /> b-<xsl:value-of select="b" /> c-<xsl:value-of select="c" /></xsl:attribute>
					F
					</label>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="goose">
				<xsl:variable name="gid" select="."/>
				<xsl:for-each select="../node">
					<label>
					<xsl:attribute name="for">goose-<xsl:value-of select="$gid"/>-<xsl:value-of select="position()" /></xsl:attribute>
					<xsl:attribute name="class">node goose goose-<xsl:value-of select="$gid"/> node-<xsl:value-of select="position()" /></xsl:attribute>
					
					</label>
					<label>
					<xsl:attribute name="for">goose-<xsl:value-of select="$gid"/>-a<xsl:value-of select="position()" /></xsl:attribute>
					<xsl:attribute name="class">node goosea goosea-<xsl:value-of select="$gid"/> node-<xsl:value-of select="position()" /></xsl:attribute>
					G
					</label>
					<label>
					<xsl:attribute name="for">goose-<xsl:value-of select="$gid"/>-dead</xsl:attribute>
					<xsl:attribute name="class">node goose-dead goose-<xsl:value-of select="$gid"/>-dead node-<xsl:value-of select="position()" /></xsl:attribute>
					G
					</label>
				</xsl:for-each>

			</xsl:for-each>
			</div>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>