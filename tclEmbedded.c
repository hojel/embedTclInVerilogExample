#include <tcl.h>
#include "vpi_user.h"

extern int sv_write();

Tcl_Interp *interp;

static int c_write(ClientData dummy,
                   Tcl_Interp *interp,
                   int objc, Tcl_Obj *const objv[])
{
  int address, data;
  if (objc != 3) {
    Tcl_WrongNumArgs(interp, 1, objv, "?address? ?data?");
    return TCL_ERROR;
  }
  Tcl_GetIntFromObj(interp, objv[1], &address);
  Tcl_GetIntFromObj(interp, objv[2], &data);
  (void)sv_write(address,data);
  return TCL_OK;
}

int startTcl()
{
  interp = Tcl_CreateInterp();
  if (Tcl_Init(interp) != TCL_OK) {
    fprintf(stderr, "ERROR: %s\n", Tcl_GetStringResult(interp));
    return 1;
  }
  Tcl_CreateObjCommand(interp, "c_write", c_write, NULL, NULL);
  Tcl_GlobalEval(interp, "c_write 0 1");
  Tcl_Finalize();
  return 0;
}
