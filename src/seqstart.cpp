#include <Rdefines.h>

extern "C" {


	SEXP tmrextrasseqstart(SEXP seqdata, SEXP new_data, SEXP new_indexS){
		int nrow_seqdata=INTEGER(GET_DIM(seqdata))[0];
		int ncol_seqdata=INTEGER(GET_DIM(seqdata))[1]; 
		int nrow_new_data=INTEGER(GET_DIM(new_data))[0];
		int ncol_new_data=INTEGER(GET_DIM(new_data))[1]; 
		int * new_index=INTEGER(new_indexS);
	//	rowindex <- (1:ncol(seqdata))-1
		for(int i=0; i<nrow_seqdata; i++){
			// indexes <-  new.index[ind]+rowindex - tmin +1
			for(int j=0; j<ncol_seqdata;j++){
				int new_j =  new_index[i]+j;
				if(new_j>=0 && new_j<ncol_new_data){
					SET_STRING_ELT(new_data, i+new_j*nrow_new_data, STRING_ELT(seqdata, i+j*nrow_seqdata));
				}
			}
		}
		return new_data;
	}
}
