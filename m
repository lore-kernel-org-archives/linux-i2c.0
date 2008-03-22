From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH] Read SPD data from a hexdump (take 2)
Date: Sat, 22 Mar 2008 14:46:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0803221346450.16142@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0803161427360.20723@shell4.speakeasy.net>
	<20080322150222.2a8ccc60@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080322150222.2a8ccc60-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Sat, 22 Mar 2008, Jean Delvare wrote:
> The function below chokes on the header line of i2cdump output:
>
> <file>
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 80 08 08 0e 0b 60 48 00 05 50 60 02 82 04 04 00    ?????`H.?P`????.
> 10: ...
> </file>
>
> Can't parse data at eeprom/decode-dimms.pl line 1119, <F> line 1.
>
> Of course I can delete this first line from the file and then it works,
> but it would be better if the function could simply ignore this header
> line.

[...]
> You repeat the same byte for all the omitted block... this isn't how I
> read man hexdump(1). As I understand it, you are supposed to repeat the
> last line, not the last byte.
>
> Alternatively you could drop support for this special format, which
> doesn't make much sense for a 256-byte EEPROM if you ask me. And in
> practice the only cases where it could happen is for rows of 0x00s or
> 0xffs - it doesn't make a difference if you omit them completely.

I've added code to ignore header lines.  The code to parse the repeat line
syntax is there for the same reason:  hexdump produces that syntax when you
run it on an eeprom file.  Not parsing it requires editing the hexdumps by
hand, which is a lot more trouble than just deleting a one line header.

As far as I can tell, hexdump and od only produce the line repeat when
every byte in the line is the same, so repeating the last byte vs the last
16 bytes is effectively the same.  My goal wasn't to code some complex
"perfect" hex dump parser, but just to work correctly on the formats one
typically has at hand.

> You could use the /i regexp modifier so that you don't have to specify
> both a-f and A-F each time.

Good idea.

> > +		foreach (split(/\s+/, $2)) {
> > +			if(/^(..)(..)$/) {
> > +				$bytes[$addr++] = hex($1);
> > +				$bytes[$addr++] = hex($2);
>
> I'm unsure if we want to support this ambiguous format. You assume
> big-endian byte order here. Even though you document it in the comment
> above, users might not read the source code and so might feed the
> script with little-endian byte order data and get noise out of the
> script.

I've added some better documentation to the help output.  It's the default
format of "hexdump" and I'm not sure if old versions of busybox can produce
the -C format when compiled with certain options.  I think if you turn on
hexdump but not od, you get a limited version that can't do everything.

> > +			} elsif(/^(..)$/) {
> > +				$bytes[$addr++] = hex($1);
> > +			} else {
> > +				print "Can't parse hex word '$_'\n";
>
> I fail to see how this could ever happen.

It was just defensive programming.  In case my regexs to parse the line
were less than perfect, maybe it would get caught here.

> >      $opt_html = 1 if (/-f/);
> >      $opt_bodyonly = 1 if (/-b/);
> >      $opt_igncheck = 1 if (/-c/);
> > +    $use_hexdump = 1 if(/-x/);
> > +    push @dimm_list, $_ if($use_hexdump && !/^-[fbcx]$/);
>
> In anticipation of more options being added in the future, I'd
> use !/^-/ instead. Your variant above also fails if long options are
> used.

Fixed.  Note that all the option regexes should be changed to something
like '/^-?-f/'.  Otherwise a filename like hys72d32500gr-7-b will trigger
the $opt_bodyonly option.  (that's a real example, I named my eeprom dumps
after the part number, but in caps)

---------------------------------------------------------------------------
This adds a "-x" option to decode_dimms.pl, which lets one supply a list of
file names to read SPD data from.  It can parse various hexdump formats,
such as the output from i2cdump and the util-linux and Busybox hexdump
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
@@ -1100,10 +1100,59 @@
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
+		/^(?:0000 )?([a-f\d]{2,7}):? ((:?[a-f\d]{4}\s*){8}|(:?[a-f\d]{2}\s*){16})/i ||
+		/^(?:0000 )?([a-f\d]{2,7}):?\s*$/i or $ok = 0;
+		next if (!$ok && $header);		# skip leading unparsed lines
+
+		$ok or die "Unable to parse input";
+		$header = 0;
+
+		$addr = hex $1;
+		if ($repstart) {
+			@bytes[$repstart .. ($addr-1)] = ($bytes[$repstart-1]) x ($addr-$repstart);
+			$repstart = 0;
+		}
+		last unless defined $2;
+		foreach (split(/\s+/, $2)) {
+			if (/^(..)(..)$/) {
+				$bytes[$addr++] = hex($1);
+				$bytes[$addr++] = hex($2);
+			} else {
+				/^(..)$/;
+				$bytes[$addr++] = hex($1);
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
+		@bytes = read_hexdump($dimm_i);
+		return @bytes[$offset..($offset+63)];
+	} elsif ($use_sysfs) {
 		# Kernel 2.6 with sysfs
 		sysopen(HANDLE, "/sys/bus/i2c/drivers/eeprom/$dimm_i/eeprom", O_RDONLY)
 			or die "Cannot open /sys/bus/i2c/drivers/eeprom/$dimm_i/eeprom";
@@ -1123,19 +1172,29 @@
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
+systems.  It is better to use "hexdump -C", which is not ambiguous.
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

@@ -1155,21 +1214,23 @@


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
@@ -1179,15 +1240,18 @@
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
