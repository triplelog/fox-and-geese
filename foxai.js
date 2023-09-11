
let evalfn0 = function(occupied,fox,turn){
	let v = 0;
	let gc = 0;
	for (var j=32;j--;){
		if ((1 << j) & occupied){
			v+= 18;
			if ((1 << j) == fox){
				v -= (10-scores[j].d)+scores[j].m;
			}
			else {
				v += (10-scores[j].d)+scores[j].m;
				gc++;
			}
		}
	}
	if (fox == 0 || gc < 2){
		return -Infinity;
	}
	return v;
}

let evalfn1 = function(occupied,fox,turn){
	let v = 0;
	let gc = 0;
	for (var j=32;j--;){
		if ((1 << j) & occupied){
			v+= 18;
			if ((1 << j) == fox){
				v -= scoresF[j];
			}
			else {
				v += scoresF[j];
				gc++;
			}
		}
	}
	let fm = 0;
	movesT[fox].forEach((k) => {
		if ((1 << k) & occupied){
			v += scoresFT[turn][0];
		}
		else {
			fm++;
		}
	})
	
	jumps[fox].forEach((k) => {
		if (((1 << k[0]) & occupied)){
			if (((1 << k[1]) & ~occupied)){
				v -= scoresFT[turn][1];
				fm++;
			}
			else {
				v += scoresFT[turn][2];
			}
		}
		else {
			fm++;
		}
	})
	v -= scoresFT[turn][3]*fm;
	if (fox == 0 || gc < 2){
		return -Infinity;
	}
	return v;
}

let evalfn = evalfn1;

function gooseSim(occupied,fox,depth){
	let maxEval = {val:-Infinity,type:-1,j:false,k:false};
	for (var j=0;j<32;j++){
		if (((1 << j) & occupied) && (j != fox)){
			moves[j].forEach((k) => {
				if ((1 << k) & ~occupied){
					let val = depth > 0 ? foxSim(move(occupied,1<<fox, 1<<k),fox,depth-1) :evalfn(move(occupied,1<<fox, 1<<k),fox,1);

					if (val > maxEval.val){
						maxEval = {val:val,type:0,j:j,k:k}
					}
				}
			});
		}
	}
	return maxEval.val;
}
function foxSim(occupied,fox,depth){
	let minEval = {val:Infinity,type:-1,k:false};
	moves[fox].forEach((k) => {
		if ((1 << k) & ~occupied){
			let val = depth > 0 ? gooseSim(move(occupied,1<<fox, 1<<k),k,depth-1) : evalfn(move(occupied,1<<fox, 1<<k),fox,0);
			
			if (val < minEval.val){
				minEval.val = val;
				minEval.type = 0;
				minEval.k = k;
			}
		}
	});
	jumps[fox].forEach((k) => {
		if (((1 << k[0]) & occupied) && ((1 << k[1]) & ~occupied)){
			let val = depth > 0 ? gooseSim(jump(occupied,1<<fox, 1<<k[0],1<<k[1]),k[1],evalfn,depth-1) : evalfn(jump(occupied,1<<fox, 1<<k[0],1<<k[1]),k[1],0);

			if (val < minEval.val){
				minEval.val = val;
				minEval.type = 1;
				minEval.k = k;
			}
		}
	});
	return minEval.val;
}
function foxTurn(occupied,fox,depth){
	let minEval = {val:Infinity,type:-1,k:false};
	moves[fox].forEach((k) => {
		if ((1 << k) & ~occupied){
			let val = depth > 0 ? gooseSim(move(occupied,1<<fox, 1<<k),k,depth-1) : evalfn(move(occupied,1<<fox, 1<<k),fox,0);
			
			if (val < minEval.val){
				minEval.val = val;
				minEval.type = 0;
				minEval.k = k;
			}
		}
	});
	jumps[fox].forEach((k) => {
		if (((1 << k[0]) & occupied) && ((1 << k[1]) & ~occupied)){
			let val = depth > 0 ? gooseSim(jump(occupied,1<<fox, 1<<k[0],1<<k[1]),k[1],depth-1) : evalfn(jump(occupied,1<<fox, 1<<k[0],1<<k[1]),k[1],0);
			
			if (val < minEval.val){
				minEval.val = val;
				minEval.type = 1;
				minEval.k = k;
			}
		}
	});
	if (minEval.type == -1){
		alert("Geese win!");
		return false;
	}
	else if (minEval.val == -Infinity){
		alert("Fox win!");
		return false;
	}
	else {
		return minEval;
	}
}