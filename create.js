const fs = require('fs');
const nunjucks = require('nunjucks');

let nodes = [];
let moves = [];
let jumps = [];
let idx= 0;
let fox = 13;
for (var i=0;i<5;i++){
	for (var j=0;j<5;j++){
		moves[idx]=[];
		jumps[idx]=[];
		if (idx == fox){
			nodes.push([i,j,2]);
		}
		else {
			if (Math.random() < 0.5){
				nodes.push([i,j,1]);
			}
			else {
				nodes.push([i,j,0]);
			}
		}
		
		for (var ii=Math.max(0,i-1);ii<Math.min(5,i+2);ii++){
			for (var jj=Math.max(0,j-1);jj<Math.min(5,j+2);jj++){
				if (i == ii && j == jj){continue;}
				moves[idx].push(ii*5+jj);
			}
		}
		for (var ii=Math.max(i%2,i-2);ii<Math.min(5,i+3);ii+=2){
			for (var jj=Math.max(j%2,j-2);jj<Math.min(5,j+3);jj+=2){
				if (i == ii && j == jj){continue;}
				jumps[idx].push([i*5+j,(ii+i)/2*5+(jj+j)/2,ii*5+jj]);
			}
		}
		idx++;
	}
}

let html = nunjucks.render("xmltemplate.xml",{nodes:nodes,moves:moves,jumps:jumps});
fs.writeFileSync('out.xml',html);