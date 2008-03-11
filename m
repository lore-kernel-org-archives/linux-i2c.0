From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2cdump: Let the user specify a register range
Date: Tue, 11 Mar 2008 14:12:12 +0100
Message-ID: <20080311141212.4cff32bd@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Hendrik Sattler <post-azCMwr5LJFZ+Wm55xJeGF4QuADTiUCJX@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

This is a proposal for a new option to i2cdump, which would let the
user specify a register range to be probed (instead of the default 0x00
to 0xff). This improvement was suggested to me by Hendrik Sattler.

Index: tools/i2cdump.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- tools/i2cdump.c	(r=E9vision 5106)
+++ tools/i2cdump.c	(copie de travail)
@@ -61,12 +61,15 @@
 	int pec =3D 0, even =3D 0;
 	int flags =3D 0;
 	int force =3D 0, yes =3D 0, version =3D 0;
+	const char *range =3D NULL;
+	int first =3D 0x00, last =3D 0xff;
 =

 	/* handle (optional) flags first */
 	while (1+flags < argc && argv[1+flags][0] =3D=3D '-') {
 		switch (argv[1+flags][1]) {
 		case 'V': version =3D 1; break;
 		case 'f': force =3D 1; break;
+		case 'r': range =3D argv[1+(++flags)]; break;
 		case 'y': yes =3D 1; break;
 		default:
 			fprintf(stderr, "Warning: Unsupported flag "
@@ -179,6 +182,39 @@
 		}
 	}
 =

+	/* Parse optional range string */
+	if (range) {
+		char *dash;
+
+		first =3D strtol(range, &dash, 0);
+		if (dash =3D=3D range || *dash !=3D '-'
+		 || first < 0 || first > 0xff) {
+			fprintf(stderr, "Error: Invalid range parameter!\n");
+			exit(1);
+		}
+		last =3D strtol(++dash, &end, 0);
+		if (end =3D=3D dash || *end !=3D '\0'
+		 || last < first || last > 0xff) {
+			fprintf(stderr, "Error: Invalid range parameter!\n");
+			exit(1);
+		}
+
+		/* Check mode constraints */
+		switch (size) {
+		case I2C_SMBUS_BYTE:
+		case I2C_SMBUS_BYTE_DATA:
+			break;
+		case I2C_SMBUS_WORD_DATA:
+			if (!even || (!(first%2) && last%2))
+				break;
+			/* Fall through */
+		default:
+			fprintf(stderr,
+			        "Error: Range parameter not compatible with selected mode!\n");
+			exit(1);
+		}
+	}
+
 	file =3D open_i2c_dev(i2cbus, filename, 0);
 	if (file < 0) {
 		exit(1);
@@ -273,6 +309,11 @@
 				fprintf(stderr, "Probing bank %d using bank "
 				        "register 0x%02x.\n", bank, bankreg);
 		}
+		if (range) {
+			fprintf(stderr,
+			        "Probe range limited to 0x%02x-0x%02x.\n",
+			        first, last);
+		}
 =

 		fprintf(stderr, "Continue? [Y/n] ");
 		fflush(stderr);
@@ -334,7 +375,7 @@
 		}
 =

 		if (size =3D=3D I2C_SMBUS_BYTE) {
-			res =3D i2c_smbus_write_byte(file, 0);
+			res =3D i2c_smbus_write_byte(file, first);
 			if(res !=3D 0) {
 				fprintf(stderr, "Error: Write start address "
 				        "failed, return code %d\n", res);
@@ -347,9 +388,24 @@
 		for (i =3D 0; i < 256; i+=3D16) {
 			if (size =3D=3D I2C_SMBUS_BLOCK_DATA && i >=3D s_length)
 				break;
+			if (i/16 < first/16)
+				continue;
+			if (i/16 > last/16)
+				break;
+
 			printf("%02x: ", i);
 			for (j =3D 0; j < 16; j++) {
 				fflush(stdout);
+				/* Skip unwanted registers */
+				if (i+j < first || i+j > last) {
+					printf("   ");
+					if (size =3D=3D I2C_SMBUS_WORD_DATA) {
+						printf("   ");
+						j++;
+					}
+					continue;
+				}
+
 				if (size =3D=3D I2C_SMBUS_BYTE_DATA) {
 					block[i+j] =3D res =3D
 					  i2c_smbus_read_byte_data(file, i+j);
@@ -390,6 +446,11 @@
 				if (size =3D=3D I2C_SMBUS_BLOCK_DATA
 				 && i+j >=3D s_length)
 					break;
+				/* Skip unwanted registers */
+				if (i+j < first || i+j > last) {
+					printf(" ");
+					continue;
+				}
 =

 				res =3D block[i+j];
 				if (res < 0)
@@ -410,8 +471,19 @@
 	} else {
 		printf("     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f\n");
 		for (i =3D 0; i < 256; i+=3D8) {
+			if (i/8 < first/8)
+				continue;
+			if (i/8 > last/8)
+				break;
+
 			printf("%02x: ", i);
 			for (j =3D 0; j < 8; j++) {
+				/* Skip unwanted registers */
+				if (i+j < first || i+j > last) {
+					printf("     ");
+					continue;
+				}
+
 				res =3D i2c_smbus_read_word_data(file, i+j);
 				if (res < 0)
 					printf("XXXX ");
Index: tools/i2cdump.8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- tools/i2cdump.8	(r=E9vision 5140)
+++ tools/i2cdump.8	(copie de travail)
@@ -5,6 +5,7 @@
 .SH SYNOPSIS
 .B i2cdump
 .RB [ -f ]
+.RB [ "-r first-last" ]
 .RB [ -y ]
 .I i2cbus
 .I address
@@ -30,6 +31,11 @@
 kernel driver in question. It can also cause i2cdump to return invalid
 results. So use at your own risk and only if you know what you're doing.
 .TP
+.B -r first-last
+Limit the range of registers being accessed. This option is only available
+with modes \fBb\fP, \fBw\fP, \fBc\fP and \fBW\fP. For mode \fBW\fP,
+\fBfirst\fR must be even and \fBlast\fR must be odd.
+.TP
 .B -y
 Disable interactive mode. By default, i2cdump will wait for a confirmation
 from the user before messing with the I2C bus. When this flag is used, it

Hendrik, with this patch applied (on top of i2c-tools 3.0.0 or SVN),
you should be able to dump the registers of your 0Z99x chip with:

i2cdump -r 0x00-0x14 0 0x5c w

Please give it a try and let me know how it goes.

-- =

Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
