From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: [PATCH] Read SPD data from a hexdump (take 2)
Date: Sun, 16 Mar 2008 14:33:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0803161427360.20723@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c list <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is updated version of the previous patch.  I realized that I used four
space indent in the last one.  I changed it to 8, and then mode the hexdump
reading code to another function as it was getting too indented.  Also, it
can now understand the format of "eeprog".

This adds a "-x" option to decode_dimms.pl, which lets one supply a list of
file names to read SPD data from.  It can parse various hexdump formats,
such as the output from i2cdump and the util-linux and Busybox hexdump
progams run on a sysfs eeprom file.

Useful for decoding SPD data that you cut and pasted from a manufacturer's
website or from a DIMM installed on an embeded system that does not have
perl/etc, but does have a serial console with busybox.

-----
--- i2c-tools/eeprom/decode-dimms.pl.orig	2008-03-16 14:19:21.000000000 -0700
+++ i2c-tools/eeprom/decode-dimms.pl	2008-03-16 14:27:15.000000000 -0700
@@ -46,7 +46,7 @@
 use strict;
 use POSIX;
 use Fcntl qw(:DEFAULT :seek);
-use vars qw($opt_html $opt_body $opt_bodyonly $opt_igncheck $use_sysfs
+use vars qw($opt_html $opt_body $opt_bodyonly $opt_igncheck $use_sysfs $use_hexdump
 	    @vendors %decode_callback $revision);

 $revision = '$Revision: 5089 $ ($Date: 2008-01-04 08:34:36 -0800 (Fri, 04 Jan 2008) $)';
@@ -1081,10 +1081,51 @@
 	printl $l, $temp;
 }

+# Read various hex dump style formats:	hexdump, hexdump -C, i2cdump, eeprog
+# note that normal 'hexdump' format on a little-endian system byte-swaps
+# words, using hexdump -C is better.
+sub readhexdump ($) {
+	my $addr = 0;
+	my $repstart = 0;
+	my @bytes;
+
+	open F, '<', $_[0] or die "Unable to open: $_[0]";
+	while(<F>) {
+		chomp;
+		if(/^\*$/) {
+			$repstart = $addr;
+			next;
+		}
+		/^(?:0000 )?([a-fA-F\d]{2,7}):? ((:?[a-fA-F\d]{4}\s*){8}|(:?[a-fA-F\d]{2}\s*){16})/ ||
+		/^(?:0000 )?([a-fA-F\d]{2,7}):?\s*$/ or die "Can't parse data";
+		$addr = hex $1;
+		if ($repstart) {
+			@bytes[$repstart .. ($addr-1)] = ($bytes[$repstart-1]) x ($addr-$repstart);
+			$repstart = 0;
+		}
+		last unless defined $2;
+		foreach (split(/\s+/, $2)) {
+			if(/^(..)(..)$/) {
+				$bytes[$addr++] = hex($1);
+				$bytes[$addr++] = hex($2);
+			} elsif(/^(..)$/) {
+				$bytes[$addr++] = hex($1);
+			} else {
+				print "Can't parse hex word '$_'\n";
+			}
+		}
+	}
+	close F;
+	return @bytes;
+}
+
 sub readspd64 ($$) { # reads 64 bytes from SPD-EEPROM
 	my ($offset, $dimm_i) = @_;
 	my @bytes;
-	if ($use_sysfs) {
+	if ($use_hexdump) {
+		@bytes = readhexdump($dimm_i);
+		return @bytes[$offset..($offset+63)];
+	} elsif ($use_sysfs) {
 		# Kernel 2.6 with sysfs
 		sysopen(HANDLE, "/sys/bus/i2c/drivers/eeprom/$dimm_i/eeprom", O_RDONLY)
 			or die "Cannot open /sys/bus/i2c/drivers/eeprom/$dimm_i/eeprom";
@@ -1103,20 +1144,25 @@
 	return @bytes;
 }

+my @dimm_list;
+
 for (@ARGV) {
     if (/-h/) {
-		print "Usage: $0 [-c] [-f [-b]]\n",
+		print "Usage: $0 [-c] [-f [-b]] [-x file [files..]]\n",
 			"       $0 -h\n\n",
 			"  -f, --format            print nice html output\n",
 			"  -b, --bodyonly          don't print html header\n",
 			"                          (useful for postprocessing the output)\n",
 			"  -c, --checksum          decode completely even if checksum fails\n",
+			"  -x,                     Read data from hexdump files\n",
 			"  -h, --help              display this usage summary\n";
 		exit;
     }
     $opt_html = 1 if (/-f/);
     $opt_bodyonly = 1 if (/-b/);
     $opt_igncheck = 1 if (/-c/);
+    $use_hexdump = 1 if(/-x/);
+    push @dimm_list, $_ if($use_hexdump && !/^-[fbcx]$/);
 }
 $opt_body = $opt_html && ! $opt_bodyonly;

@@ -1136,21 +1182,24 @@


 my $dimm_count=0;
-my @dimm_list;
 my $dir;
-if ($use_sysfs) { $dir = '/sys/bus/i2c/drivers/eeprom'; }
-else { $dir = '/proc/sys/dev/sensors'; }
-if (-d $dir) {
-	@dimm_list = split(/\s+/, `ls $dir`);
-} elsif (! -d '/sys/module/eeprom') {
-	print "No EEPROM found, are you sure the eeprom module is loaded?\n";
-	exit;
+
+if (!$use_hexdump) {
+	if ($use_sysfs) { $dir = '/sys/bus/i2c/drivers/eeprom'; }
+	else { $dir = '/proc/sys/dev/sensors'; }
+	if (-d $dir) {
+		@dimm_list = split(/\s+/, `ls $dir`);
+	} elsif (! -d '/sys/module/eeprom') {
+		print "No EEPROM found, are you sure the eeprom module is loaded?\n";
+		exit;
+	}
 }

 for my $i ( 0 .. $#dimm_list ) {
 	$_=$dimm_list[$i];
 	if (($use_sysfs && /^\d+-\d+$/)
-	 || (!$use_sysfs && /^eeprom-/)) {
+	 || (!$use_sysfs&& /^eeprom-/)
+	 || $use_hexdump) {
 		my @bytes = readspd64(0, $dimm_list[$i]);
 		my $dimm_checksum = 0;
 		$dimm_checksum += $bytes[$_] foreach (0 .. 62);
@@ -1160,15 +1209,18 @@
 		$dimm_count++;

 		print "<b><u>" if $opt_html;
-		printl2 "\n\nDecoding EEPROM", ($use_sysfs ?
+		printl2 "\n\nDecoding EEPROM",
+		        $use_hexdump ? $dimm_list[$i] : ($use_sysfs ?
 			"/sys/bus/i2c/drivers/eeprom/$dimm_list[$i]" :
 			"/proc/sys/dev/sensors/$dimm_list[$i]");
 		print "</u></b>" if $opt_html;
 		print "<table border=1>\n" if $opt_html;
-		if (($use_sysfs && /^[^-]+-([^-]+)$/)
-		 || (!$use_sysfs && /^[^-]+-[^-]+-[^-]+-([^-]+)$/)) {
-			my $dimm_num=$1 - 49;
-			printl "Guessing DIMM is in", "bank $dimm_num";
+		if (!$use_hexdump) {
+			if (($use_sysfs && /^[^-]+-([^-]+)$/)
+			 || (!$use_sysfs && /^[^-]+-[^-]+-[^-]+-([^-]+)$/)) {
+				my $dimm_num=$1 - 49;
+				printl "Guessing DIMM is in", "bank $dimm_num";
+			}
 		}

 # Decode first 3 bytes (0-2)

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
