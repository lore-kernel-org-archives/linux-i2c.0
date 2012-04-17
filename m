From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: decode-dimms: Module Configuration Type not reported for DDR2/3
Date: Tue, 17 Apr 2012 13:18:57 +0200
Message-ID: <20120417131857.4e05c67b@endymion.delvare>
References: <4F8C8A74.90804@icyb.net.ua>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/LzDD8FhDnq_ncdlxG1y/NWV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F8C8A74.90804-+43SdJ71VxTsG83rWm+8vg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andriy Gapon <avg-+43SdJ71VxTsG83rWm+8vg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--MP_/LzDD8FhDnq_ncdlxG1y/NWV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andriy,

On Tue, 17 Apr 2012 00:09:08 +0300, Andriy Gapon wrote:
> It seems that Module Configuration Type ("ECC", "No Parity", etc) is not
> reported for DDR2 and DDR3 module types.  Not sure if resolution could be as
> easy as adding sdram_module_configuration_type() calls in the corresponding
> decode procedures.

Won't be so easy. For DDR2 there is one new bit to decode
(Address/Command Parity). For DDR3 byte 11 has a completely different
meaning, and the information seem to be no longer available. As I read
the specification, the only way to tell if a DDR3 module has any form
of parity or ECC is to check the extra bus width in bits 4-3 of byte 8.
But this is a boolean type of information then, telling "there is some
form of data error detection/correction". No way to tell between parity
and ECC AFAICS, and information about Address/Command Parity is gone
too.

I am attaching two patches, one for DDR2, one for DDR3, please give
them a try.

-- 
Jean Delvare

--MP_/LzDD8FhDnq_ncdlxG1y/NWV
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=decode-dimms-ddr2-module-config.patch

---
 eeprom/decode-dimms |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2011-02-16 14:58:41.000000000 +0100
+++ i2c-tools/eeprom/decode-dimms	2012-04-17 10:22:06.784083856 +0200
@@ -525,16 +525,21 @@ sub sdram_voltage_interface_level($)
 	return ($_[0] < @levels) ? $levels[$_[0]] : "Undefined!";
 }
 
-# Common to SDR and DDR SDRAM
+# Common to SDR, DDR and DDR2 SDRAM
 sub sdram_module_configuration_type($)
 {
-	my @types = (
-		"No Parity",			# 0
-		"Parity",			# 1
-		"ECC",				# 2
-	);
+	my $byte = $_[0] & 0x07;
+	my @edc;
 
-	return ($_[0] < @types) ? $types[$_[0]] : "Undefined!";
+	return "No Parity" if $byte == 0;
+
+	# Data ECC includes Data Parity so don't print both
+	push @edc, "Data Parity" if ($byte & 0x03) == 0x01;
+	push @edc, "Data ECC" if ($byte & 0x02);
+	# New in DDR2 specification
+	push @edc, "Address/Command Parity" if ($byte & 0x04);
+
+	return join ", ", @edc;
 }
 
 # Parameter: EEPROM bytes 0-127 (using 3-62)
@@ -1019,6 +1024,9 @@ sub decode_ddr2_sdram($)
 	printl("Voltage Interface Level",
 	       sdram_voltage_interface_level($bytes->[8]));
 
+	printl("Module Configuration Type",
+	       sdram_module_configuration_type($bytes->[11]));
+
 	printl("Refresh Rate", ddr2_refresh_rate($bytes->[12]));
 
 	my @burst;

--MP_/LzDD8FhDnq_ncdlxG1y/NWV
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=decode-dimms-ddr3-module-config.patch

---
 eeprom/decode-dimms |    2 ++
 1 file changed, 2 insertions(+)

--- i2c-tools.orig/eeprom/decode-dimms	2012-04-17 10:22:06.000000000 +0200
+++ i2c-tools/eeprom/decode-dimms	2012-04-17 10:42:10.205990901 +0200
@@ -1169,6 +1169,8 @@ sub decode_ddr3_sdram($)
 
 	printl("SDRAM Device Width", (1 << (($bytes->[7] & 7) + 2))." bits");
 
+	printl("Bus Width Extension", ($bytes->[8] & 24)." bits");
+
 	my $taa;
 	my $trcd;
 	my $trp;

--MP_/LzDD8FhDnq_ncdlxG1y/NWV--
