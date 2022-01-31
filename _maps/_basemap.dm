//#define LOWMEMORYMODE //uncomment this to load behindthescenes only.

#include "map_files\generic\behindthescenes.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Inferno\Inferno.dmm"

		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
