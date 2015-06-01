From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/2 i2c-tools] sensors-detect: Refactor manufacturer
 decoding
Date: Mon, 1 Jun 2015 09:27:38 +0200
Message-ID: <20150601092738.158c32c5@endymion.delvare>
References: <20150601092614.539ebc75@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150601092614.539ebc75-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Instead of reencoding pre-DDR3 manufacturer code to DDR3 manufacturer
code, move the common decoding to a separate function.
---
 eeprom/decode-dimms |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2015-06-01 09:14:30.899898763 +0200
+++ i2c-tools/eeprom/decode-dimms	2015-06-01 09:19:01.931673815 +0200
@@ -336,6 +336,21 @@ sub parity($)
 	return ($parity & 1);
 }
 
+# The code byte includes parity, the count byte does not.
+sub manufacturer_common($$)
+{
+	my ($count, $code) = @_;
+	my $manufacturer;
+
+	return "Invalid" if parity($code) != 1
+			 or ($code &= 0x7F) == 0;
+	return "Unknown" if $count >= @vendors
+			 or $code - 1 >= @{$vendors[$count]};
+	$manufacturer = $vendors[$count][$code - 1];
+	$manufacturer =~ s/ \(former .*\)$// if $opt_side_by_side;
+	return $manufacturer;
+}
+
 # New encoding format (as of DDR3) for manufacturer just has a count of
 # leading 0x7F rather than all the individual bytes.  The count bytes includes
 # parity!
@@ -346,12 +361,7 @@ sub manufacturer_ddr3($$)
 
 	return "Undefined" unless spd_written($count, $code);
 
-	return "Invalid" if parity($code) != 1
-			 or ($code & 0x7F) == 0;
-	return "Unknown" if ($count & 0x7F) >= @vendors
-			 or ($code & 0x7F) - 1 >= @{$vendors[$count & 0x7F]};
-	$manufacturer = $vendors[$count & 0x7F][($code & 0x7F) - 1];
-	$manufacturer =~ s/ \(former .*\)$// if $opt_side_by_side;
+	$manufacturer = manufacturer_common($count & 0x7F, $code);
 	$manufacturer .= "? (Invalid parity)" if parity($count) != 1;
 	return $manufacturer;
 }
@@ -369,11 +379,7 @@ sub manufacturer(@)
 	}
 
 	return ("Invalid", []) unless defined $first;
-	return ("Invalid", [$first, @bytes]) if parity($first) != 1;
-	if (parity($ai) == 0) {
-		$ai |= 0x80;
-	}
-	return (manufacturer_ddr3($ai, $first), \@bytes);
+	return (manufacturer_common($ai, $first), \@bytes);
 }
 
 sub manufacturer_data(@)


-- 
Jean Delvare
SUSE L3 Support
