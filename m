From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/3] Refactor the handling of the i2cbus command line
 argument
Date: Sat, 12 Apr 2008 14:34:05 +0200
Message-ID: <20080412143405.2b98af62@hyperion.delvare>
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

Refactor the handling of the I2CBUS parameter. This ensures more
consistency accross the i2c tools.

---
 tools/i2cbusses.c |   24 ++++++++++++++++++++++++
 tools/i2cbusses.h |    1 +
 tools/i2cdetect.c |   11 ++---------
 tools/i2cdump.c   |   10 ++--------
 tools/i2cget.c    |    6 ++----
 tools/i2cset.c    |    6 ++----
 6 files changed, 33 insertions(+), 25 deletions(-)

--- i2c-tools.orig/tools/i2cbusses.c	2008-04-12 11:26:14.000000000 +0200
+++ i2c-tools/tools/i2cbusses.c	2008-04-12 13:31:43.000000000 +0200
@@ -25,6 +25,7 @@
 #include <sys/stat.h>
 #include <string.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
 #include <dirent.h>
@@ -217,6 +218,29 @@ done:
 		               "and also modprobed your i2c bus drivers\n");
 }
 
+/*
+ * Parse an I2CBUS command line argument and return the corresponding
+ * bus number, or a negative value if the bus is invalid.
+ */
+int lookup_i2c_bus(const char *i2cbus_arg)
+{
+	long i2cbus;
+	char *end;
+
+	i2cbus = strtol(i2cbus_arg, &end, 0);
+	if (*end || !*i2cbus_arg) {
+		fprintf(stderr, "Error: I2CBUS argument not a number!\n");
+		return -1;
+	}
+	if (i2cbus < 0 || i2cbus > 0xff) {
+		fprintf(stderr, "Error: I2CBUS argument out of range "
+		        "(0-255)!\n");
+		return -2;
+	}
+
+	return i2cbus;
+}
+
 int open_i2c_dev(const int i2cbus, char *filename, const int quiet)
 {
 	int file;
--- i2c-tools.orig/tools/i2cbusses.h	2008-04-12 11:26:14.000000000 +0200
+++ i2c-tools/tools/i2cbusses.h	2008-04-12 11:28:55.000000000 +0200
@@ -24,6 +24,7 @@
 
 void print_i2c_busses(int procfmt);
 
+int lookup_i2c_bus(const char *i2cbus_arg);
 int open_i2c_dev(const int i2cbus, char *filename, const int quiet);
 int set_slave_addr(int file, int address, int force);
 
--- i2c-tools.orig/tools/i2cdetect.c	2008-04-12 11:26:14.000000000 +0200
+++ i2c-tools/tools/i2cdetect.c	2008-04-12 11:28:55.000000000 +0200
@@ -235,15 +235,8 @@ int main(int argc, char *argv[])
 		help();
 		exit(1);
 	}
-	i2cbus = strtol(argv[flags+1], &end, 0);
-	if (*end) {
-		fprintf(stderr, "Error: I2CBUS argument not a number!\n");
-		help();
-		exit(1);
-	}
-	if ((i2cbus < 0) || (i2cbus > 0xff)) {
-		fprintf(stderr, "Error: I2CBUS argument out of range "
-		        "(0-255)!\n");
+	i2cbus = lookup_i2c_bus(argv[flags+1]);
+	if (i2cbus < 0) {
 		help();
 		exit(1);
 	}
--- i2c-tools.orig/tools/i2cdump.c	2008-04-12 11:26:14.000000000 +0200
+++ i2c-tools/tools/i2cdump.c	2008-04-12 11:28:55.000000000 +0200
@@ -91,14 +91,8 @@ int main(int argc, char *argv[])
 		help();
 		exit(1);
 	}
-	i2cbus = strtol(argv[flags+1], &end, 0);
-	if (*end) {
-		fprintf(stderr, "Error: First argument not a number!\n");
-		help();
-		exit(1);
-	}
-	if (i2cbus < 0 || i2cbus > 0xff) {
-		fprintf(stderr, "Error: I2CBUS argument out of range!\n");
+	i2cbus = lookup_i2c_bus(argv[flags+1]);
+	if (i2cbus < 0) {
 		help();
 		exit(1);
 	}
--- i2c-tools.orig/tools/i2cget.c	2008-04-12 11:26:14.000000000 +0200
+++ i2c-tools/tools/i2cget.c	2008-04-12 11:28:55.000000000 +0200
@@ -187,11 +187,9 @@ int main(int argc, char *argv[])
 	if (argc - flags < 3)
 		help();
 
-	i2cbus = strtol(argv[flags+1], &end, 0);
-	if (*end || i2cbus < 0 || i2cbus > 0x3f) {
-		fprintf(stderr, "Error: I2CBUS argument invalid!\n");
+	i2cbus = lookup_i2c_bus(argv[flags+1]);
+	if (i2cbus < 0)
 		help();
-	}
 
 	address = strtol(argv[flags+2], &end, 0);
 	if (*end || address < 3 || address > 0x77) {
--- i2c-tools.orig/tools/i2cset.c	2008-04-12 11:26:14.000000000 +0200
+++ i2c-tools/tools/i2cset.c	2008-04-12 11:28:55.000000000 +0200
@@ -78,11 +78,9 @@ int main(int argc, char *argv[])
 	if (argc < flags + 5)
 		help();
 
-	i2cbus = strtol(argv[flags+1], &end, 0);
-	if (*end || i2cbus < 0 || i2cbus > 0x3f) {
-		fprintf(stderr, "Error: I2CBUS argument invalid!\n");
+	i2cbus = lookup_i2c_bus(argv[flags+1]);
+	if (i2cbus < 0)
 		help();
-	}
 
 	address = strtol(argv[flags+2], &end, 0);
 	if (*end || address < 0 || address > 0x7f) {


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
