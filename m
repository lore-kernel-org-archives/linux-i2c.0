From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C_FUNC_SMBUS_QUICK on i2c-mxs
Date: Thu, 30 Aug 2012 14:28:25 +0200
Message-ID: <20120830142825.2f9dc9a1@endymion.delvare>
References: <CAOMZO5Dyp-+GXkWZvgsFXbZv15N+4u3iuPjw-sqwLn=5bVGBsw@mail.gmail.com>
	<20120830133945.7c56ae0f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120830133945.7c56ae0f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek =?UTF-8?B?VmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 30 Aug 2012 13:39:45 +0200, Jean Delvare wrote:
> Looking at the code in i2cdetect, it appears the checks are more strict
> than they need to be. Instead of bailing out by default if either quick
> writes or short reads aren't supported, we could simply warn and skip
> the addresses we can't probe. Only if both quick writes and short reads
> are unsupported, we should bail out. I can implement this easily if it
> solves your problem.

Like this:

If either SMBus Quick Write or SMBus Receive Byte command is missing,
still proceed and do a best-effort detection.
---
 tools/i2cdetect.c |   56 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 15 deletions(-)

--- i2c-tools.orig/tools/i2cdetect.c	2012-04-26 12:05:55.000000000 +0200
+++ i2c-tools/tools/i2cdetect.c	2012-08-30 14:21:08.551693987 +0200
@@ -47,10 +47,11 @@ static void help(void)
 		"  If provided, FIRST and LAST limit the probing range.\n");
 }
 
-static int scan_i2c_bus(int file, int mode, int first, int last)
+static int scan_i2c_bus(int file, int mode, unsigned long funcs,
+			int first, int last)
 {
 	int i, j;
-	int res;
+	int cmd, res;
 
 	printf("     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f\n");
 
@@ -59,8 +60,26 @@ static int scan_i2c_bus(int file, int mo
 		for(j = 0; j < 16; j++) {
 			fflush(stdout);
 
+			/* Select detection command for this address */
+			switch (mode) {
+			default:
+				cmd = mode;
+				break;
+			case MODE_AUTO:
+				if ((i+j >= 0x30 && i+j <= 0x37)
+				 || (i+j >= 0x50 && i+j <= 0x5F))
+				 	cmd = MODE_READ;
+				else
+					cmd = MODE_QUICK;
+				break;
+			}
+
 			/* Skip unwanted addresses */
-			if (i+j < first || i+j > last) {
+			if (i+j < first || i+j > last
+			 || (cmd == MODE_READ &&
+			     !(funcs & I2C_FUNC_SMBUS_READ_BYTE))
+			 || (cmd == MODE_QUICK &&
+			     !(funcs & I2C_FUNC_SMBUS_QUICK))) {
 				printf("   ");
 				continue;
 			}
@@ -79,8 +98,8 @@ static int scan_i2c_bus(int file, int mo
 			}
 
 			/* Probe this address */
-			switch (mode) {
-			case MODE_QUICK:
+			switch (cmd) {
+			default: /* MODE_QUICK */
 				/* This is known to corrupt the Atmel AT24RF08
 				   EEPROM */
 				res = i2c_smbus_write_quick(file,
@@ -91,13 +110,6 @@ static int scan_i2c_bus(int file, int mo
 				   write-only chips (mainly clock chips) */
 				res = i2c_smbus_read_byte(file);
 				break;
-			default:
-				if ((i+j >= 0x30 && i+j <= 0x37)
-				 || (i+j >= 0x50 && i+j <= 0x5F))
-					res = i2c_smbus_read_byte(file);
-				else
-					res = i2c_smbus_write_quick(file,
-					      I2C_SMBUS_WRITE);
 			}
 
 			if (res < 0)
@@ -318,18 +330,32 @@ int main(int argc, char *argv[])
 		exit(0);
 	}
 
-	if (mode != MODE_READ && !(funcs & I2C_FUNC_SMBUS_QUICK)) {
+	if (!(funcs & (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_READ_BYTE))) {
+		fprintf(stderr,
+			"Error: Bus doesn't support detection commands\n");
+		close(file);
+		exit(1);
+	}
+	if (mode == MODE_QUICK && !(funcs & I2C_FUNC_SMBUS_QUICK)) {
 		fprintf(stderr, "Error: Can't use SMBus Quick Write command "
 			"on this bus\n");
 		close(file);
 		exit(1);
 	}
-	if (mode != MODE_QUICK && !(funcs & I2C_FUNC_SMBUS_READ_BYTE)) {
+	if (mode == MODE_READ && !(funcs & I2C_FUNC_SMBUS_READ_BYTE)) {
 		fprintf(stderr, "Error: Can't use SMBus Read Byte command "
 			"on this bus\n");
 		close(file);
 		exit(1);
 	}
+	if (mode == MODE_AUTO) {
+		if (!(funcs & I2C_FUNC_SMBUS_QUICK))
+			fprintf(stderr, "Warning: Can't use SMBus Quick Write "
+				"command, will skip some addresses\n");
+		if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE))
+			fprintf(stderr, "Warning: Can't use SMBus Read Byte "
+				"command, will skip some addresses\n");
+	}
 
 	if (!yes) {
 		char s[2];
@@ -352,7 +378,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	res = scan_i2c_bus(file, mode, first, last);
+	res = scan_i2c_bus(file, mode, funcs, first, last);
 
 	close(file);
 


-- 
Jean Delvare
