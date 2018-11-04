# -----------------------------------------------------------------------------
#  MAKEFILE RUNNING COMMAND
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni (@zeroc0d3)
#  Repository : https://github.com/dockube/dockube
#  License    : Apache v2
# -----------------------------------------------------------------------------
# Notes:
# use [TAB] instead [SPACE]

#------------------------
# DocKube Services
#------------------------
dockube-run:
	./dockube-cmd.sh build

compose-build:
	./dockube-cmd.sh compose-build $1

compose-up:
	./dockube-cmd.sh compose-up

dockube-stop:
	./dockube-cmd.sh compose-stop

dockube-down:
	./dockube-cmd.sh compose-down

