let evalfn = function(occupied,fox,turn){
	let v = 0;
	for (var j=32;j--;){
		if ((1 << j) & occupied){
			v++;
		}
	}
	return v;
}



function foxTurn(occupied,fox){
	let minEval = {val:Infinity,type:-1,k:false};
	moves[fox].forEach((k) => {
		if ((1 << k) & ~occupied){
			let val = evalfn(move(occupied,1<<fox, 1<<k),fox,0);
			if (val < minEval.val){
				minEval.val = val;
				minEval.type = 0;
				minEval.k = k;
			}
		}
	});
	jumps[fox].forEach((k) => {
		if (((1 << k[0]) & occupied) && ((1 << k[1]) & ~occupied)){
			let val = evalfn(jump(occupied,1<<fox, 1<<k[0],1<<k[1]),k[1],0);
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
	else {
		return minEval;
	}
}