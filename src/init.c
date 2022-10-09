#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>
void R_init_TraMineRextras(DllInfo *dll);

/* FIXME:
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP tmrextrasseqstart(SEXP, SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"tmrextrasseqstart", (DL_FUNC) &tmrextrasseqstart, 3},
    {NULL, NULL, 0}
};

void R_init_TraMineRextras(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
	R_forceSymbols(dll, TRUE);
}
