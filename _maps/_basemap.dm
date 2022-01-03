//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\behindthescenes.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Inferno\Inferno.dmm"

		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
