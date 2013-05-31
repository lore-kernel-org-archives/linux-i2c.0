From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] decode-dimms: Generate HTML 4.01 compliant markup
Date: Fri, 31 May 2013 14:20:10 +0200
Message-ID: <20130531142010.48f9f013@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In HTML output mode, generate HTML 4.01 compliant markup.
---
 eeprom/decode-dimms |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2013-05-31 13:18:17.139571898 +0200
+++ i2c-tools/eeprom/decode-dimms	2013-05-31 13:45:09.704948120 +0200
@@ -490,14 +490,16 @@ sub real_printl($$) # print a line w/ la
 	}
 }
 
-sub printl2($$) # print a line w/ label and value (outside a table)
+sub printl2 # print a line w/ label and value (outside a table)
 {
-	my ($label, $value) = @_;
+	my ($label, $value, $style) = @_;
 	if ($opt_html) {
 		$label = html_encode($label);
 		$value = html_encode($value);
+		print "<p", (defined $style ? " style=\"$style\"" : ""), ">";
 	}
 	print "$label: $value\n";
+	print "</p>\n" if $opt_html;
 }
 
 sub real_prints($) # print separator w/ given text
@@ -2165,7 +2167,7 @@ if (!$opt_igncheck) {
 
 
 if ($opt_html && !$opt_bodyonly) {
-	print "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">\n",
+	print "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\">\n",
 	      "<html><head>\n",
 		  "\t<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=iso-8859-1\">\n",
 		  "\t<title>PC DIMM Serial Presence Detect Tester/Decoder Output</title>\n",
@@ -2350,9 +2352,8 @@ for $current (0 .. $#dimm) {
 	if ($opt_side_by_side) {
 		print "\n\n";
 	} else {
-		print "<b><u>" if $opt_html;
-		printl2("\n\nDecoding EEPROM", $dimm[$current]->{file});
-		print "</u></b>" if $opt_html;
+		printl2("\n\nDecoding EEPROM", $dimm[$current]->{file},
+			"text-decoration: underline; font-weight: bold;");
 	}
 	print "<table border=1>\n" if $opt_html;
 


-- 
Jean Delvare
