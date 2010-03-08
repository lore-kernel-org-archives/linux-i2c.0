From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] decode-dimms: Add support for at24 kernel driver
Date: Mon, 8 Mar 2010 10:36:43 +0100
Message-ID: <20100308103643.5965454f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add support for at24 kernel driver, in addition to the legacy eeprom
kernel driver.
---
 eeprom/decode-dimms |   47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2009-06-09 13:14:35.000000000 +0200
+++ i2c-tools/eeprom/decode-dimms	2010-03-08 09:00:05.000000000 +0100
@@ -1707,24 +1707,51 @@ printh('Memory Serial Presence Detect De
 Jean Delvare, Trent Piepho and others');
 
 
+# From a sysfs device path and an attribute name, return the attribute
+# value, or undef (stolen from sensors-detect)
+sub sysfs_device_attribute
+{
+	my ($device, $attr) = @_;
+	my $value;
+
+	open(local *FILE, "$device/$attr") or return "";
+	$value = <FILE>;
+	close(FILE);
+	return unless defined $value;
+
+	chomp($value);
+	return $value;
+}
+
 sub get_dimm_list
 {
-	my ($dir, $file, @files);
+	my (@dirs, $dir, $file, @files);
 
 	if ($use_sysfs) {
-		$dir = '/sys/bus/i2c/drivers/eeprom';
+		@dirs = ('/sys/bus/i2c/drivers/eeprom', '/sys/bus/i2c/drivers/at24');
 	} else {
-		$dir = '/proc/sys/dev/sensors';
+		@dirs = ('/proc/sys/dev/sensors');
 	}
 
-	if (opendir(local *DIR, $dir)) {
-		while (defined($file = readdir(DIR))) {
-			next if $use_sysfs && $file !~ /^\d+-[\da-f]+$/i;
-			next if !$use_sysfs && $file !~ /^eeprom-/;
-			push @files, { eeprom => "$file",
-				       file => "$dir/$file" };
+	foreach $dir (@dirs) {
+		if (opendir(local *DIR, $dir)) {
+			while (defined($file = readdir(DIR))) {
+				if ($use_sysfs) {
+					next if $file !~ /^\d+-[\da-f]+$/i;
+					next if ! -d "$dir/$file";
+					my $attr = sysfs_device_attribute("$dir/$file", "name");
+					next unless defined $attr && ($attr eq "eeprom" || $attr eq "spd");
+				} else {
+					next if $file !~ /^eeprom-/;
+				}
+				push @files, { eeprom => "$file",
+					       file => "$dir/$file" };
+			}
+			close(DIR);
 		}
-		close(DIR);
+	}
+
+	if (@files) {
 		return sort { $a->{file} cmp $b->{file} } @files;
 	} elsif (! -d '/sys/module/eeprom') {
 		print "No EEPROM found, are you sure the eeprom module is loaded?\n";


-- 
Jean Delvare
