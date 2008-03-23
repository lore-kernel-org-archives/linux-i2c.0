From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH] Read SPD data from a hexdump (take 2)
Date: Sun, 23 Mar 2008 13:46:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0803231252590.16142@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0803161427360.20723@shell4.speakeasy.net>
	<20080322150222.2a8ccc60@hyperion.delvare>
	<Pine.LNX.4.58.0803221346450.16142@shell2.speakeasy.net>
	<20080323130547.538eed81@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080323130547.538eed81-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c list <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 23 Mar 2008, Jean Delvare wrote:
> Hi Trent,
>
> On Sat, 22 Mar 2008 14:46:43 -0700 (PDT), Trent Piepho wrote:
> > On Sat, 22 Mar 2008, Jean Delvare wrote:
> > > You repeat the same byte for all the omitted block... this isn't how I
> > > read man hexdump(1). As I understand it, you are supposed to repeat the
> > > last line, not the last byte.
> > >
> > > Alternatively you could drop support for this special format, which
> > > doesn't make much sense for a 256-byte EEPROM if you ask me. And in
> > > practice the only cases where it could happen is for rows of 0x00s or
> > > 0xffs - it doesn't make a difference if you omit them completely.
> >
> > I've added code to ignore header lines.  The code to parse the repeat line
> > syntax is there for the same reason:  hexdump produces that syntax when you
> > run it on an eeprom file.  Not parsing it requires editing the hexdumps by
> > hand, which is a lot more trouble than just deleting a one line header.
>
> Maybe I did not express myself clearly enough. I didn't mean to stop
> supporting the special "compact" format by choking on it, but by
> simply ignoring the "*" line as you do for i2cdump's header line (and
> filling the @bytes array with zeroes, which would be presumably simpler
> than what you did.)

It seems like doing that would be even worse than the almost correct way
I'm handing the repeat lines now.  Any hex dump that my code would parse
incorrectly would also be parsed incorrectly by ignoring repeat lines.
Plus some far more likely hexdumps would also be parsed incorrectly when
ignoring the repeat codes that are handled correctly with my code.

Correctly handling the repeat lines also means one can use the same code to
turn a hexdump back into a binary file.

I've improved the hexdump reading code to handle line repeats correctly.

> > I've added some better documentation to the help output.  It's the default
>
> Good start, but I'd go further and warn the user at runtime when
> parsing hexdumps using this format. For example:
>
> Warning: Assuming hexdump uses big-endian byte order

Ok, added that.

This adds a "-x" option to decode_dimms.pl, which lets one supply a list of
file names to read SPD data from.  It can parse various hexdump formats, such
as the output from i2cdump, eeprog, and the util-linux and Busybox hexdump
progams run on a sysfs eeprom file.

Useful for decoding SPD data that you cut and pasted from a manufacturer's
website or from a DIMM installed on an embeded system that does not have
perl/etc, but does have a serial console with busybox.

---
Index: eeprom/decode-dimms.pl
===================================================================
--- eeprom/decode-dimms.pl	(revision 5156)
+++ eeprom/decode-dimms.pl	(working copy)
@@ -46,8 +46,8 @@
 use strict;
 use POSIX;
 use Fcntl qw(:DEFAULT :seek);
-use vars qw($opt_html $opt_body $opt_bodyonly $opt_igncheck $use_sysfs
-	    @vendors %decode_callback $revision);
+use vars qw($opt_html $opt_body $opt_bodyonly $opt_igncheck $use_sysfs $use_hexdump
+	    @vendors %decode_callback $revision @dimm_list);

 $revision = '$Revision$ ($Date$)';
 $revision =~ s/\$\w+: (.*?) \$/$1/g;
@@ -1100,10 +1100,63 @@
 	printl $l, $temp;
 }

+# Read various hex dump style formats: hexdump, hexdump -C, i2cdump, eeprog
+# note that normal 'hexdump' format on a little-endian system byte-swaps
+# words, using hexdump -C is better.
+sub read_hexdump ($)
+{
+	my $addr = 0;
+	my $repstart = 0;
+	my @bytes;
+	my $header = 1;
+	my $word = 0;
+
+	open F, '<', $_[0] or die "Unable to open: $_[0]";
+	while (<F>) {
+		my $ok = 1;
+
+		chomp;
+		if (/^\*$/) {
+			$repstart = $addr;
+			next;
+		}
+		/^(?:0000 )?([a-f\d]{2,8}):?\s+((:?[a-f\d]{4}\s*){8}|(:?[a-f\d]{2}\s*){16})/i ||
+		/^(?:0000 )?([a-f\d]{2,8}):?\s*$/i;
+		next if (!defined $1 && $header);		# skip leading unparsed lines
+
+		defined $1 or die "Unable to parse input";
+		$header = 0;
+
+		$addr = hex $1;
+		if ($repstart) {
+			@bytes[$repstart .. ($addr-1)] =
+				(@bytes[($repstart-16)..($repstart-1)]) x (($addr-$repstart)/16);
+			$repstart = 0;
+		}
+		last unless defined $2;
+		foreach (split(/\s+/, $2)) {
+			if (/^(..)(..)$/) {
+			        $word |= 1;
+				$bytes[$addr++] = hex($1);
+				$bytes[$addr++] = hex($2);
+			} else {
+				$bytes[$addr++] = hex($_);
+			}
+		}
+	}
+	close F;
+	$header and die "Unable to parse any data from hexdump '$_[0]'";
+	$word and printc "Warning: Assuming big-endian order 16-bit hex dump";
+	return @bytes;
+}
+
 sub readspd64 ($$) { # reads 64 bytes from SPD-EEPROM
 	my ($offset, $dimm_i) = @_;
 	my @bytes;
-	if ($use_sysfs) {
+	if ($use_hexdump) {
+		@bytes = read_hexdump($dimm_i);
+		return @bytes[$offset..($offset+63)];
+	} elsif ($use_sysfs) {
 		# Kernel 2.6 with sysfs
 		sysopen(HANDLE, "/sys/bus/i2c/drivers/eeprom/$dimm_i/eeprom", O_RDONLY)
 			or die "Cannot open /sys/bus/i2c/drivers/eeprom/$dimm_i/eeprom";
@@ -1123,19 +1176,30 @@
 }

 for (@ARGV) {
-    if (/-h/) {
-		print "Usage: $0 [-c] [-f [-b]]\n",
+    if (/^-?-h/) {
+		print "Usage: $0 [-c] [-f [-b]] [-x file [files..]]\n",
 			"       $0 -h\n\n",
 			"  -f, --format            print nice html output\n",
 			"  -b, --bodyonly          don't print html header\n",
 			"                          (useful for postprocessing the output)\n",
 			"  -c, --checksum          decode completely even if checksum fails\n",
+			"  -x,                     Read data from hexdump files\n",
 			"  -h, --help              display this usage summary\n";
+		print <<"EOF";
+
+Hexdumps can be the output from hexdump, hexdump -C, i2cdump, eeprog and
+likely many other progams producing hex dumps of one kind or another.  Note
+that the default output of "hexdump" will be byte-swapped on little-endian
+systems and will therefor not be parsed correctly.  It is better to use
+"hexdump -C", which is not ambiguous.
+EOF
 		exit;
     }
-    $opt_html = 1 if (/-f/);
-    $opt_bodyonly = 1 if (/-b/);
-    $opt_igncheck = 1 if (/-c/);
+    $opt_html = 1 if (/^-?-f/);
+    $opt_bodyonly = 1 if (/^-?-b/);
+    $opt_igncheck = 1 if (/^-?-c/);
+    $use_hexdump = 1 if (/^-x/);
+    push @dimm_list, $_ if ($use_hexdump && !/^-/);
 }
 $opt_body = $opt_html && ! $opt_bodyonly;

@@ -1155,21 +1219,23 @@


 my $dimm_count = 0;
-my @dimm_list;
 my $dir;
-if ($use_sysfs) { $dir = '/sys/bus/i2c/drivers/eeprom'; }
-else { $dir = '/proc/sys/dev/sensors'; }
-if (-d $dir) {
-	@dimm_list = split(/\s+/, `ls $dir`);
-} elsif (! -d '/sys/module/eeprom') {
-	print "No EEPROM found, are you sure the eeprom module is loaded?\n";
-	exit;
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
 	$_ = $dimm_list[$i];
 	if (($use_sysfs && /^\d+-\d+$/)
-	 || (!$use_sysfs && /^eeprom-/)) {
+	 || (!$use_sysfs && /^eeprom-/)
+	 || $use_hexdump) {
 		my @bytes = readspd64(0, $dimm_list[$i]);
 		my $dimm_checksum = 0;
 		$dimm_checksum += $bytes[$_] foreach (0 .. 62);
@@ -1179,15 +1245,18 @@
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
-			my $dimm_num = $1 - 49;
-			printl "Guessing DIMM is in", "bank $dimm_num";
+		if (!$use_hexdump) {
+			if (($use_sysfs && /^[^-]+-([^-]+)$/)
+			 || (!$use_sysfs && /^[^-]+-[^-]+-[^-]+-([^-]+)$/)) {
+				my $dimm_num = $1 - 49;
+				printl "Guessing DIMM is in", "bank $dimm_num";
+			}
 		}

 # Decode first 3 bytes (0-2)

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
