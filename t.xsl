<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="base" select="document('base.xml')"/>
<xsl:template match="/">
	<xsl:variable name="geese" select="g"/>
	<html>
	<head>
	<style>
	input {
		display: none;
	}
	@keyframes turn {
		from {z-index: 1;}
		to {z-index: 60;}
	}
	@keyframes sixty {
		from {top: 0rem;}
		to {top: calc(-58 * var(--ww));}
	}
	html {
		overflow: hidden;
	}
	body {
		--w: 400;
		--ww: 1.5rem;
	}
	@media screen and (min-width: 500px) and (min-height: 500px){
		body  {--w: 500; --ww: 1.5rem;}
	}
	@media screen and (min-width: 600px) and (min-height: 600px){
		body  {--w: 600; --ww: 2rem;}
	}
	@media screen and (min-width: 750px) and (min-height: 750px){
		body  {--w: 750; --ww: 2.5rem;}
	}
	@media screen and (min-width: 900px) and (min-height: 900px){
		body  {--w: 900; --ww: 3rem;}
	}
	@media screen and (min-width: 1200px) and (min-height: 1200px){
		body  {--w: 1200; --ww: 4rem;}
	}
	@media screen and (min-width: 1500px) and (min-height: 1500px){
		body  {--w: 1500; --ww: 5rem;}
	}
	@media screen and (min-width: 1800px) and (min-height: 1800px){
		body  {--w: 1800; --ww: 6rem;}
	}
	.game {
		position: absolute;
		width: calc(var(--w) * 1px);
		height: calc(var(--w) * 1px);
		top: 0px;
		left: 0px;
		
	}
	.gt {
		display: block;
		animation-name: turn;
  		animation-duration: 60s;
		animation-timing-function: linear;
		z-index: 60;
	}
	.ft {
		display: block;
		animation-name: turn;
  		animation-duration: 60s;
		animation-timing-function: linear;
		z-index: 60;
	}
	label {
		font-size: calc(var(--ww) * 0.45);
		text-align: center;
		padding-top: 2px;
		text-shadow: 1px 1px 1px black, -1px -1px 1px black, -1px 1px 1px black, 1px -1px 1px black;

	}
	#clock {
		position: absolute;
		left: 10px;
		top: 10px;
		display: block;
		overflow: hidden;
		width: calc(var(--ww) * 2.5);
		height: calc(var(--ww) + 2px);
		font-size: calc(var(--ww) * 0.5);
		background: white;
		border: 1px solid black;
	}
	#clock > div {
		position: absolute;
		left: 0px;
		top: 0px;
		animation-name: sixty;
		animation-duration: 60s;
		animation-timing-function: steps(59,jump-none);
	}
	#clock > div > div {
		width: calc(var(--ww) * 2.5);
		display: inline-block;
		height: var(--ww);
		text-align: center;
		line-height: var(--ww);
	}
		.node {
			width: calc(var(--ww) * 0.625);
			height: calc(var(--ww) * 0.625);
			border: 1px solid black;
			cursor: pointer;
			position: absolute;
			display: block;
			background: #CCC;
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
		.goose-dead, .fox-m, .fox-j {
			opacity: 0;
		}
		.ft .goosea {
			cursor: default;
		}
		
		.gi:active ~ .gt {
			z-index: 80;
			animation-name: none;
		}
		.fi:active ~ .ft {
			z-index: 80;
			animation-name: none;
		}
		.fi:active ~ .gt #clock > div {
			animation-name: none;
		}
		<xsl:for-each select="$base/main/node">
			.node-<xsl:value-of select="position()" /> {
				top: calc((<xsl:value-of select="y" /> * 1px - 36px ) * var(--w) / 600 - 1rem);
				left: calc((<xsl:value-of select="x" /> * 1px + 4px) * var(--w) / 600 - 1rem);
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
		<xsl:for-each select="$base/main/node">
			<xsl:variable name="pid" select="position()"/>
			<xsl:for-each select="neighbor">
				#fox-<xsl:value-of select="$pid" />:checked ~ div .fox-m.node-<xsl:value-of select="$pid" />, #fox-m<xsl:value-of select="$pid" />-<xsl:value-of select="." />:checked ~ div .fox.node-<xsl:value-of select="." /> {
					z-index: 40;
					background: #DDF;
					left: 10px;
					top: 10px;
					cursor: pointer;
					width: calc(var(--ww) * 2.5);
					height: var(--ww);
					opacity: 1;
					text-shadow: unset;
					line-height: var(--ww);
				}
				#fox-m<xsl:value-of select="$pid" />-<xsl:value-of select="." />:checked ~ div .fox.node-<xsl:value-of select="." />::after {
					content: " Done";
				}
				#fox-<xsl:value-of select="$pid" />:checked ~ .gooseInput-<xsl:value-of select="." />:checked ~ div .fox-m.to-<xsl:value-of select="." /> {
					display: none;
				}
			</xsl:for-each>
			<xsl:for-each select="jump">
				#fox-<xsl:value-of select="$pid" />:checked ~ .gooseInput-<xsl:value-of select="b" />:checked ~ div .fox-j.node-<xsl:value-of select="$pid" />.c-<xsl:value-of select="c" />, #fox-j<xsl:value-of select="$pid" />-<xsl:value-of select="c" />:checked ~ div .fox.node-<xsl:value-of select="c" />, #fox-j<xsl:value-of select="$pid" />-<xsl:value-of select="c" />:checked ~ div .goose-dead.node-<xsl:value-of select="b" /> {
					z-index: 40;
					background: #DDF;
					left: 10px;
					top: 10px;
					cursor: pointer;
					width: calc(var(--ww) * 2.5);
					height: var(--ww);
					opacity: 1;
					text-shadow: unset;
					line-height: var(--ww);
				}
				#fox-<xsl:value-of select="$pid" />:checked ~ .gooseInput-<xsl:value-of select="c" />:checked ~ div .fox-j.c-<xsl:value-of select="c" /> {
					display: none;
				}
				#fox-j<xsl:value-of select="$pid" />-<xsl:value-of select="c" />:checked ~ div .fox.node-<xsl:value-of select="c" />::after {
					content: " Done";
				}
				#fox-j<xsl:value-of select="$pid" />-<xsl:value-of select="c" />:checked ~ div .goose-dead.node-<xsl:value-of select="b" /> {
					z-index: 45;
				}
				
			</xsl:for-each>
		</xsl:for-each>
		
		
		<xsl:for-each select="$base/main/node">
			<xsl:variable name="gid" select="position()"/>
			<xsl:variable name="gci" select="g"/>
			<xsl:if test="contains($geese,$gci)">
			<xsl:for-each select="$base/main/node">
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
					background: #FBB;
				}
				#goose-<xsl:value-of select="$gid" />-a<xsl:value-of select="$pid" />:checked ~ div .goose-<xsl:value-of select="$gid" />.node-<xsl:value-of select="." /> * {
					opacity: 0;
				}
				</xsl:for-each>
				#goose-<xsl:value-of select="$gid" />-a<xsl:value-of select="$pid" />:checked ~ div .goose-<xsl:value-of select="$gid" />.node-<xsl:value-of select="$pid" /> {
					z-index: 30;
					text-shadow: 1px 1px 1px red, -1px -1px 1px red, -1px 1px 1px red, 1px -1px 1px red;
				}
			</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
		
	</style>
	</head>
		<body>

			<xsl:for-each select="$base/main/node">
				<xsl:variable name="pid" select="position()"/>
				<input type="radio" name="fox" class="fi">
				<xsl:attribute name="id">fox-<xsl:value-of select="position()" /></xsl:attribute>
				<xsl:if test="$pid=15"><xsl:attribute name="checked"></xsl:attribute></xsl:if>
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
			
			<xsl:for-each select="$base/main/node">
				<xsl:variable name="gid" select="position()"/>
				<xsl:variable name="gci" select="g"/>
				<xsl:if test="contains($geese,$gci)">
				<xsl:for-each select="$base/main/node">
					<input type="radio">
					<xsl:attribute name="name">goose-<xsl:value-of select="$gid"/></xsl:attribute>
					<xsl:attribute name="id">goose-<xsl:value-of select="$gid"/>-<xsl:value-of select="position()" /></xsl:attribute>
					<xsl:attribute name="class">gi gooseInput-<xsl:value-of select="position()" /></xsl:attribute>
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
				</xsl:if>
			</xsl:for-each>

			<div class="game gt">
			<div id="clock">
				<div>
					<xsl:for-each select="$base/main/sixty">
					<div><xsl:value-of select="." /></div>
					</xsl:for-each>
				</div>
			</div>
			<xsl:for-each select="$base/main/node">
				<label>
				<xsl:attribute name="class">node blank node-<xsl:value-of select="position()" /></xsl:attribute>
				</label>
			</xsl:for-each>
			<xsl:for-each select="$base/main/node">
				<xsl:variable name="pid" select="position()"/>
				<label>
				<xsl:attribute name="for">fox-<xsl:value-of select="$pid" /></xsl:attribute>
				<xsl:attribute name="class">node fox node-<xsl:value-of select="$pid" /></xsl:attribute>
				🦊
				</label>
			</xsl:for-each>
			<xsl:for-each select="$base/main/node">
				<xsl:variable name="gid" select="position()"/>
				<xsl:variable name="gci" select="g"/>
				<xsl:if test="contains($geese,$gci)">
				<xsl:for-each select="$base/main/node">
					<label>
					<xsl:attribute name="for">goose-<xsl:value-of select="$gid"/>-<xsl:value-of select="position()" /></xsl:attribute>
					<xsl:attribute name="class">node goose goose-<xsl:value-of select="$gid"/> node-<xsl:value-of select="position()" /></xsl:attribute>
					<span>🪿</span>
					</label>
					<label>
					<xsl:attribute name="for">goose-<xsl:value-of select="$gid"/>-a<xsl:value-of select="position()" /></xsl:attribute>
					<xsl:attribute name="class">node goosea goosea-<xsl:value-of select="$gid"/> node-<xsl:value-of select="position()" /></xsl:attribute>
					🪿
					</label>
				</xsl:for-each>
				</xsl:if>

			</xsl:for-each>
			</div>
			<div class="game ft">
			<xsl:for-each select="$base/main/node">
				<label>
				<xsl:attribute name="class">node blank node-<xsl:value-of select="position()" /></xsl:attribute>
				</label>
			</xsl:for-each>
			<xsl:for-each select="$base/main/node">
				<xsl:variable name="pid" select="position()"/>
				<label>
				<xsl:attribute name="for">fox-<xsl:value-of select="$pid" /></xsl:attribute>
				<xsl:attribute name="class">node fox node-<xsl:value-of select="$pid" /></xsl:attribute>
				🦊
				</label>
				<xsl:for-each select="neighbor">
					<label>
					<xsl:attribute name="for">fox-m<xsl:value-of select="$pid" />-<xsl:value-of select="." /></xsl:attribute>
					<xsl:attribute name="class">node fox-m node-<xsl:value-of select="$pid" /> to-<xsl:value-of select="." /></xsl:attribute>
					🦊 Move
					</label>
				</xsl:for-each>
				<xsl:for-each select="jump">
					<label>
					<xsl:attribute name="for">fox-j<xsl:value-of select="$pid" />-<xsl:value-of select="c" /></xsl:attribute>
					<xsl:attribute name="class">node fox-j node-<xsl:value-of select="$pid" /> b-<xsl:value-of select="b" /> c-<xsl:value-of select="c" /></xsl:attribute>
					🦊 Jump
					</label>
				</xsl:for-each>
			</xsl:for-each>
			
			<xsl:for-each select="$base/main/node">
				<xsl:variable name="gid" select="position()"/>
				<xsl:variable name="gci" select="g"/>
				<xsl:if test="contains($geese,$gci)">
				<xsl:for-each select="$base/main/node">
					<label>
					<xsl:attribute name="for">goose-<xsl:value-of select="$gid"/>-<xsl:value-of select="position()" /></xsl:attribute>
					<xsl:attribute name="class">node goose goose-<xsl:value-of select="$gid"/> node-<xsl:value-of select="position()" /></xsl:attribute>
					<span>🪿</span>
					</label>
					<label>
					
					<xsl:attribute name="class">node goosea goosea-<xsl:value-of select="$gid"/> node-<xsl:value-of select="position()" /></xsl:attribute>
					🪿
					</label>
					<label>
					<xsl:attribute name="for">goose-<xsl:value-of select="$gid"/>-dead</xsl:attribute>
					<xsl:attribute name="class">node goose-dead goose-<xsl:value-of select="$gid"/>-dead node-<xsl:value-of select="position()" /></xsl:attribute>
					Kill 🪿
					</label>
				</xsl:for-each>
				</xsl:if>

			</xsl:for-each>
			</div>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>