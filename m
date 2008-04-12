From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/3] Allow passing i2c bus by name
Date: Sat, 12 Apr 2008 14:38:27 +0200
Message-ID: <20080412143827.3bbb0a5b@hyperion.delvare>
References: <20080412135841.1983d15c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080412135841.1983d15c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make it possible to pass the i2c bus by name instead of by number. As
there is no guarantee that i2c bus numbering will stay the same over
time (for example if hardware is added of removed, or simply due to
loading the drivers in a different order), passing the i2c bus by name
is more robust.

The i2c bus names are supposed to be unique. If you request a bus by
name and this name happens to not be unique, then the tools will play
it safe and quit. This is better than writing to the wrong device.

---
 tools/i2cbusses.c |   38 ++++++++++++++++++++++++++++++++++++--
 tools/i2cdetect.8 |    4 ++--
 tools/i2cdump.8   |    4 ++--
 tools/i2cget.8    |    4 ++--
 tools/i2cset.8    |    4 ++--
 5 files changed, 44 insertions(+), 10 deletions(-)

--- i2c-tools.orig/tools/i2cbusses.c	2008-04-12 13:41:19.000000000 +0200
+++ i2c-tools/tools/i2cbusses.c	2008-04-12 13:41:31.000000000 +0200
@@ -340,6 +340,40 @@ void print_i2c_busses(int procfmt)
 	free_adapters(adapters);
 }
 
+static int lookup_i2c_bus_by_name(const char *bus_name)
+{
+	struct i2c_adap *adapters;
+	int i, i2cbus = -1;
+
+	adapters = gather_i2c_busses();
+	if (adapters == NULL) {
+		fprintf(stderr, "Error: Out of memory!\n");
+		return -3;
+	}
+
+	/* Walk the list of i2c busses, looking for the one with the
+	   right name */
+	for (i = 0; adapters[i].name; i++) {
+		if (strcmp(adapters[i].name, bus_name) == 0) {
+			if (i2cbus >= 0) {
+				fprintf(stderr,
+					"Error: I2C bus name is not unique!\n");
+				i2cbus = -4;
+				goto done;
+			}
+			i2cbus = adapters[i].nr;
+		}
+	}
+
+	if (i2cbus == -1)
+		fprintf(stderr, "Error: I2CBUS argument doesn't match any "
+			"I2C bus name\n");
+
+done:
+	free_adapters(adapters);
+	return i2cbus;
+}
+
 /*
  * Parse an I2CBUS command line argument and return the corresponding
  * bus number, or a negative value if the bus is invalid.
@@ -351,8 +385,8 @@ int lookup_i2c_bus(const char *i2cbus_ar
 
 	i2cbus = strtol(i2cbus_arg, &end, 0);
 	if (*end || !*i2cbus_arg) {
-		fprintf(stderr, "Error: I2CBUS argument not a number!\n");
-		return -1;
+		/* Not a number, maybe a name? */
+		return lookup_i2c_bus_by_name(i2cbus_arg);
 	}
 	if (i2cbus < 0 || i2cbus > 0xff) {
 		fprintf(stderr, "Error: I2CBUS argument out of range "
--- i2c-tools.orig/tools/i2cdetect.8	2007-06-27 17:16:10.000000000 +0200
+++ i2c-tools/tools/i2cdetect.8	2008-04-12 13:42:43.000000000 +0200
@@ -1,4 +1,4 @@
-.TH I2CDETECT 8 "June 2007"
+.TH I2CDETECT 8 "April 2008"
 .SH NAME
 i2cdetect \- detect I2C chips
 
@@ -23,7 +23,7 @@ i2cdetect \- detect I2C chips
 .SH DESCRIPTION
 i2cdetect is a userspace program to scan an I2C bus for devices. It
 outputs a table with the list of detected devices on the specified bus.
-\fIi2cbus\fR indicates the number of the I2C bus to be scanned, and
+\fIi2cbus\fR indicates the number or name of the I2C bus to be scanned, and
 should correspond to one of the busses listed by \fIi2cdetect -l\fR.
 The optional parameters \fIfirst\fR and \fIlast\fR restrict the scanning
 range (default: from 0x03 to 0x77).
--- i2c-tools.orig/tools/i2cdump.8	2008-03-11 13:49:27.000000000 +0100
+++ i2c-tools/tools/i2cdump.8	2008-04-12 13:42:51.000000000 +0200
@@ -1,4 +1,4 @@
-.TH I2CDUMP 8 "March 2008"
+.TH I2CDUMP 8 "April 2008"
 .SH NAME
 i2cdump \- examine I2C registers
 
@@ -43,7 +43,7 @@ will perform the operation directly. Thi
 scripts.
 .PP
 At least two options must be provided to i2cdump. \fIi2cbus\fR indicates the
-number of the I2C bus to be scanned. This number should correspond to one
+number or name of the I2C bus to be scanned. This number should correspond to one
 of the busses listed by \fIi2cdetect -l\fR. \fIaddress\fR indicates the
 address to be scanned on that bus, and is an integer between 0x00 and 0x7F.
 .PP
--- i2c-tools.orig/tools/i2cget.8	2007-06-27 17:16:10.000000000 +0200
+++ i2c-tools/tools/i2cget.8	2008-04-12 13:43:00.000000000 +0200
@@ -1,4 +1,4 @@
-.TH I2CGET 8 "June 2007"
+.TH I2CGET 8 "April 2008"
 .SH "NAME"
 i2cget \- read from I2C/SMBus chip registers
 
@@ -36,7 +36,7 @@ will perform the operation directly. Thi
 scripts. Use with caution.
 .PP
 There are two required options to i2cget. \fIi2cbus\fR indicates the number
-of the I2C bus to be scanned.  This number should correspond to one of
+or name of the I2C bus to be scanned.  This number should correspond to one of
 the busses listed by \fIi2cdetect -l\fR. \fIchip-address\fR specifies the
 address of the chip on that bus, and is an integer between 0x03 and 0x77.
 .PP
--- i2c-tools.orig/tools/i2cset.8	2007-06-27 17:16:10.000000000 +0200
+++ i2c-tools/tools/i2cset.8	2008-04-12 13:43:07.000000000 +0200
@@ -1,4 +1,4 @@
-.TH I2CSET 8 "June 2007"
+.TH I2CSET 8 "April 2008"
 .SH "NAME"
 i2cset \- set I2C registers
 
@@ -40,7 +40,7 @@ will perform the operation directly. Thi
 scripts.
 .PP
 There are four required options to i2cset. \fIi2cbus\fR indicates the number
-of the I2C bus to be scanned.  This number should correspond to one of
+or name of the I2C bus to be scanned.  This number should correspond to one of
 the busses listed by \fIi2cdetect -l\fR. \fIchip-address\fR specifies the
 address of the chip on that bus, and is an integer between 0x00 and 0x7F.
 \fIdata-address\fR specifies the address on that chip to write to, and is an


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
