#ifdef _WIN32
	#include <windows.h>
#else
	#include <unistd.h>
#endif

#include <stdio.h>
#include <stdlib.h>


void call_rick(void) {
	#ifdef _WIN32
		system("start cmd /k curl -L ascii.live/can-you-hear-me");
	#else
		system("xterm -hold -e 'curl -L ascii.live/can-you-hear-me' &");
	#endif
}

int main(void) {
	puts("Just kidding :) It's just prank from \"loveberland\"");
	puts("To end this just close me ><");
	while (1) {
		call_rick();
		
		#ifdef _WIN32
			Sleep(10000);
		#else
			sleep(10);
		#endif
	}
	return (0);
}