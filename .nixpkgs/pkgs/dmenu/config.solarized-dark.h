/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Iosevka Expanded:size=12",
	"monospace:size=12"
};
static const char *prompt      = "";       /* -p  option; prompt to the elft of input field */
static const char *normbgcolor = "#002b36"; /* -nb option; normal background                 */
static const char *normfgcolor = "#839496"; /* -nf option; normal foreground                 */
static const char *selbgcolor  = "#073642"; /* -sb option; selected background               */
static const char *selfgcolor  = "#93a1a1"; /* -sf option; selected foreground               */
static const char *outbgcolor  = "#2aa198";
static const char *outfgcolor  = "#002b36";
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 40;
