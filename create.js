const fs = require('fs');
const nunjucks = require('nunjucks');

let lines = [[26,27,28,29,19,18,16,11,9,8,7],[19,15,14,11,24,17,22,21,20,19],[25,0,1,22,31,25],[1,2,3,4,13,7],[13,12,10,24,16,23,15],[29,30,31,21,17,6,4,12,8],[3,5,6,10,9],[25,27,28,30,19],[0,1,2,5,17,16]];
let nodesOld = [[531,570],[495,449],[470,403],[475,372],[493,341],[432,364],[434,330],[552,201],[503,171],[411,165],[431,199],[322,156],[499,222],[585,268],[249,137],[219,158],[287,222],[345,297],[240,266],[196,322],[240,380],[279,399],[340,403],[249,200],[328,205],[23,559],[95,560],[73,527],[109,476],[112,406],[180,432],[253,448]];
let nodes = [];
let moves = [];
let jumps = [];
let idx= 0;
let fox = 14;
for (var i=0;i<32;i++){
	if (i == fox){
		nodes.push([nodesOld[i][0],nodesOld[i][1],2]);
	}
	else {
		if (Math.random() < 0.5){
			nodes.push([nodesOld[i][0],nodesOld[i][1],1]);
		}
		else {
			nodes.push([nodesOld[i][0],nodesOld[i][1],0]);
		}
	}
	moves.push([]);
	jumps.push([]);
}
for (var i=0;i<lines.length;i++){
	for (var j=1;j<lines[i].length;j++){
		let a = lines[i][j-1];
		let b = lines[i][j];
		moves[a].push(b);
		moves[b].push(a);
		if (j<lines[i].length-1){
			let c = lines[i][j+1];
			jumps[a].push([a,b,c]);
			jumps[c].push([c,b,a]);
		}
		else if (lines[i][j] == lines[i][0]){
			let c = lines[i][1];
			jumps[a].push([a,b,c]);
			jumps[c].push([c,b,a]);
		}
	}
}


let html = nunjucks.render("xmltemplate.xml",{nodes:nodes,moves:moves,jumps:jumps});
fs.writeFileSync('out.xml',html);