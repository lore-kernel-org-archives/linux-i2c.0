From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] sensors-detect: Generate XHTML 1.0 compliant markup
Date: Fri, 31 May 2013 14:21:31 +0200
Message-ID: <20130531142131.5b7c6112@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In HTML output mode, generate XHTML 1.0 compliant markup.
---
 eeprom/decode-dimms |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2013-05-31 14:08:38.414677214 +0200
+++ i2c-tools/eeprom/decode-dimms	2013-05-31 14:14:19.065234816 +0200
@@ -413,7 +413,7 @@ sub html_encode($)
 	$text =~ s/</\&lt;/sg;
 	$text =~ s/>/\&gt;/sg;
 	$text =~ s/ degrees C/\&deg;C/sg;
-	$text =~ s/\n/<br>\n/sg;
+	$text =~ s/\n/<br\/>\n/sg;
 	return $text;
 }
 
@@ -438,11 +438,11 @@ sub real_printl($$) # print a line w/ la
 	if ($opt_html) {
 		$label = html_encode($label);
 		@values = map { html_encode($_) } @values;
-		print "<tr><td valign=top>$label</td>";
+		print "<tr><td valign=\"top\">$label</td>";
 		if (!$opt_merge) {
 			print "<td>$_</td>" foreach @values;
 		} elsif ($same_values) {
-			print "<td colspan=".(scalar @values).">$values[0]</td>";
+			print "<td colspan=\"".(scalar @values)."\">$values[0]</td>";
 		} else {
 			# For HTML output, merge adjacent cells even if
 			# the whole line cannot be merged.
@@ -451,7 +451,7 @@ sub real_printl($$) # print a line w/ la
 				$colcnt++;
 				my $value = shift @values;
 				next if (@values && $value eq $values[0]);
-				print "<td" . ($colcnt > 1 ? " colspan=$colcnt" : "") .">$value</td>";
+				print "<td" . ($colcnt > 1 ? " colspan=\"$colcnt\"" : "") .">$value</td>";
 				$colcnt = 0;
 			}
 		}
@@ -508,7 +508,7 @@ sub real_prints($) # print separator w/
 	$ncol = 1 unless $ncol;
 	if ($opt_html) {
 		$label = html_encode($label);
-		print "<tr><td align=center colspan=".(1+$ncol)."><b>$label</b></td></tr>\n";
+		print "<tr><td align=\"center\" colspan=\"".(1+$ncol)."\"><b>$label</b></td></tr>\n";
 	} else {
 		print "\n---=== $label ===---\n";
 	}
@@ -2167,9 +2167,10 @@ if (!$opt_igncheck) {
 
 
 if ($opt_html && !$opt_bodyonly) {
-	print "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\">\n",
-	      "<html><head>\n",
-		  "\t<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=iso-8859-1\">\n",
+	print "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n\n",
+	      "<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\">\n",
+	      "<head>\n",
+		  "\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" />\n",
 		  "\t<title>PC DIMM Serial Presence Detect Tester/Decoder Output</title>\n",
 		  "</head><body>\n";
 }
@@ -2355,7 +2356,7 @@ for $current (0 .. $#dimm) {
 		printl2("\n\nDecoding EEPROM", $dimm[$current]->{file},
 			"text-decoration: underline; font-weight: bold;");
 	}
-	print "<table border=1>\n" if $opt_html;
+	print "<table border=\"1\">\n" if $opt_html;
 
 	my @output = @{$dimm[$current]->{output}};
 	for (my $line = 0; $line < @output; $line++) {


-- 
Jean Delvare
