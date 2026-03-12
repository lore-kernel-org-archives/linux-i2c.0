Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B631E85D
	for <linux-i2c@vger.kernel.org>; Thu, 12 Mar 2026 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303522; cv=none; b=OOdD5HrXKY3vKsVVZGUVvZbjM0uJhYBKk4otGGdNtlMKrHb0LoZ09jJ5pstpka1Ck8tjjSr1jHC29aEiDgUK6yO/mZDb4Ptl8AEiTH/qobGSw5eU+cqC8NjElI5BlpVwCMs/MLbcqpgoVVqgjUwyMKzEWV/O/F9pBiZAzGtGH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303522; c=relaxed/simple;
	bh=pX9umT/KWKAUU5fzwX7HIBMNSq/ByyJ1vQQtNsUexFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E2zjXyqCkxHW03YqMpimORS6zMYbKEzjXBd0Qgwyvk+0q2S8Rxbc2PpfDii1VVumaxs+U+IivNswk+v2etKRZ447X6QLplZdnXh2KGpbHRcK8yJUWcYMN9cuUpFjNPlAgWL4UnFFkWwpFRrycM7WecgyaQjhJ8dxvu06HjOIu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=abqxdXbN; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="abqxdXbN"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cb40149037so79059185a.2
        for <linux-i2c@vger.kernel.org>; Thu, 12 Mar 2026 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1773303519; x=1773908319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W0JdJVGI/MfW77KRqUhvjsF2smM8iHWfHqBG85Hycmw=;
        b=abqxdXbNSlxfo+J/IgjyC3/2wkev675VEypP8dWEHkv7k0t6K2576VRSM7J5xGwPKk
         1lS0EMYulO9fZyyQGtT/rH+T+gb3geWgPWyyq7uDXObtJy2z+TGd7UU2cCxmDMmL4rWE
         8lqqJZ3kF0pg5y7mM12A9UeopSRQhA4OCWbYsqrv/M02NfTV3GwY6TOyysWkHpLfcpGe
         tscFek3Nu0JcHz8WA/mR9ZIcedCqoy0k7HKQ2XBAL4BRlpoi0KWjqiFbJ5EZ7SEVavqR
         gWgyRgMf8xGW1U/4kOHWnTlVR4PXEkLtNQLKMnJStjOF9Swc/boRl7UvrLTtMhXwih7n
         0y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303519; x=1773908319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0JdJVGI/MfW77KRqUhvjsF2smM8iHWfHqBG85Hycmw=;
        b=Z/3ux2ADwp8eOfpxB1/u07u0qz4zCMKkGqjVjq2OsBglN9kOLwiBxFi3pbOFxHMLXd
         W1V/ozgE1wvIjH087h/ldV+hbQnE2QMNS+0buNilTe/IXcW25sGALER29Jg/zhJjEGNI
         i2GNMBeDdW5y/j6hmUbxAogj91nyLFnuvdy5SrgzDTu7r4eG7+hMYIvAKTSC2WSpDotA
         Tc5sJugwWaYyH6Kq+eI0EFurHQapcBH8cfeQ2yNBwSacZ2/E4XVdh2hoIafOEA9HfEmd
         zMC1EmMTgh8jBKfQKqrYi+Zz+PfpNX0uZePloLzyWRyqdRZ5URZyA0tPRkYoEXelgdy9
         ILRw==
X-Forwarded-Encrypted: i=1; AJvYcCVH+khVtlIk9i27MjKWxJHgnapa7ws/WIUoVVKhF0jPXiK9O0iNgKpopqicm+RA8izundTjgB0uiUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz788HrSIVba3cmmyJgQsrlvz4aHpekVZbee4hy6Aba+oHqYAgg
	Z091stabcY3Yrv/Ab1xxItJ+SYuCBbRP2Mtemo3ivxFqF1wAJInK+R3lHAsxbxgAV+o=
X-Gm-Gg: ATEYQzz2u7I7i7O5SODhN4eGaWNzJ+/3orswZVpZ/n2BonIKEd9nb/QhGsonC3Rmerz
	UuPmeqZrn5diAUShpYClenji4gVTfJ/yyjCjAGc7HU+ptssdlawQq9Lk9/7DXC1iPUTrm343MAQ
	bksASB1s74gPyFCB/M4YL444J88iPAXbk4yjewlkQEg5U/G7yPHHhofQjSNxG0xBGu8Ddad0i6H
	4tGfMK6Bx0ZunR/x21KWDAul+jQNsDUHm5nhDC7ZTVYFWTIqcVu4TM9KnE5Cvxy+1EiHP9WKFTM
	A5lk7ZucEJ9BfMMpATMUolbzHM9N5I0pES1wPzoG/1nQiXT87xn54aMX1nlt3VTH5hEovSog0jU
	D0EL0/dBkZEkd4L77RtYRZOMQq5UQlOGx9NzUnXIZVc26O2CJS1moPGmhvXB6ySidIvZQuQx4gF
	rtZkjPjgtbXxMAqyGs8oOQ3HoxqGIy8THmAeg51JI02XQPtu4LWIX/r0wcXchr1KAW6lt/tAzCA
	BI04wypfMKacYs0/w==
X-Received: by 2002:a05:620a:290e:b0:8cd:80e1:5a0e with SMTP id af79cd13be357-8cda1abb349mr717213585a.63.1773303518764;
        Thu, 12 Mar 2026 01:18:38 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([2605:fb40:0:c09:323a:5679:3782:80b8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fc09e4sm300303185a.3.2026.03.12.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:18:38 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: Jean Delvare <jdelvare@suse.de>,
	linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Brigham Campbell <me@brighamcampbell.com>,
	=?UTF-8?q?Gero=20Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: [PATCH v2] i2c-tools: Allow passing device file paths
Date: Thu, 12 Mar 2026 02:18:08 -0600
Message-ID: <20260312081808.347978-1-me@brighamcampbell.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The userspace i2c utilities already allow the user to select an i2c bus
controller via either ID or the bus's unique name (as shown by
`i2cdetect -l`). It would be convenient to also be able to specify the
device file path. This would allow system administrators to create a
stable symlink to any particular i2c controller and pass the symlink to
i2cget, i2cset, etc... directly.

This commit changes lookup_i2c_bus to also allow for device file paths.
The i2cbus_arg string is now treated as follows:

If it can be parsed as a number, return that number directly.
Otherwise, if it can be stat'ed as a path and is a character device
file, use the path directly. Otherwise, parse the string as an i2c bus
controller name.

This will likely incur a small performance hit for users that pass the
i2c bus name, but users concerned with performance should be linking
against libi2c anyways.

Suggested-by: Gero Schwäricke <gero.schwaericke@sevenlab.de>
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---

I've tested these changes using i2cdetect, i2cget, and i2cset. However,
I still consider this v2 a work-in-progress. In particular, I don't like
that the code copies the path from argv into filename for two reasons:
1.  It's needless and 2. it introduces another potential edge case in
the case that the user passes in a path longer than PATH_MAX.

I'm looking for comments and feedback. I'm interested to know whether or
not you maintainers believe I'm on the right track with these changes
and what you might suggest. I sense that some slightly more invasive
changes may help clean up the code.

Changes since v1:
 * Introduce i2c_bus_hint struct in favor of hard-coding device major
   number 89.

 tools/i2cbusses.c   | 72 ++++++++++++++++++++++++++++++++++++---------
 tools/i2cbusses.h   | 14 +++++++--
 tools/i2cdetect.8   | 12 ++++----
 tools/i2cdetect.c   | 13 ++++----
 tools/i2cdump.8     |  7 +++--
 tools/i2cdump.c     | 13 ++++----
 tools/i2cget.8      |  6 ++--
 tools/i2cget.c      | 13 ++++----
 tools/i2cset.8      |  6 ++--
 tools/i2cset.c      | 13 ++++----
 tools/i2ctransfer.8 |  6 ++--
 tools/i2ctransfer.c | 13 ++++----
 12 files changed, 124 insertions(+), 64 deletions(-)

diff --git a/tools/i2cbusses.c b/tools/i2cbusses.c
index d687615..09a34e1 100644
--- a/tools/i2cbusses.c
+++ b/tools/i2cbusses.c
@@ -23,6 +23,7 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <sys/param.h>	/* for NAME_MAX */
 #include <sys/ioctl.h>
 #include <string.h>
@@ -37,6 +38,7 @@
 #include "i2cbusses.h"
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
+#include <linux/limits.h>
 
 enum adt { adt_dummy, adt_isa, adt_i2c, adt_smbus, adt_unknown };
 
@@ -62,10 +64,14 @@ static enum adt i2c_get_funcs(int i2cbus)
 {
 	unsigned long funcs;
 	int file;
-	char filename[20];
+	char filename[PATH_MAX];
 	enum adt ret;
+	struct i2c_bus_hint hints;
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 1);
+	hints.type = hint_bus_num;
+	hints.value.num = i2cbus;
+
+	file = open_i2c_dev(&hints, filename, sizeof(filename), 1);
 	if (file < 0)
 		return adt_unknown;
 
@@ -348,35 +354,62 @@ static int lookup_i2c_bus_by_name(const char *bus_name)
 		}
 	}
 
-	if (i2cbus == -1)
-		fprintf(stderr, "Error: I2C bus name doesn't match any "
-			"bus present!\n");
-
 done:
 	free_adapters(adapters);
 	return i2cbus;
 }
 
+static int is_path_char_dev(const char *path)
+{
+	struct stat stat_buf;
+
+	if (stat(path, &stat_buf))
+		return 0;
+
+	if (!S_ISCHR(stat_buf.st_mode))
+		return 0;
+
+	return 1;
+}
+
 /*
  * Parse an I2CBUS command line argument and return the corresponding
  * bus number, or a negative value if the bus is invalid.
  */
-int lookup_i2c_bus(const char *i2cbus_arg)
+int lookup_i2c_bus(const char *i2cbus_arg, struct i2c_bus_hint *hints)
 {
 	unsigned long i2cbus;
 	char *end;
+	int char_dev = 0;
 
 	i2cbus = strtoul(i2cbus_arg, &end, 0);
 	if (*end || !*i2cbus_arg) {
-		/* Not a number, maybe a name? */
-		return lookup_i2c_bus_by_name(i2cbus_arg);
+		/* Not a number, maybe a path? */
+		if (is_path_char_dev(i2cbus_arg)) {
+			hints->type = hint_bus_path;
+			hints->value.path = i2cbus_arg;
+			return 0;
+		}
+		/* Not a character device file path, maybe a name? */
+		char_dev = lookup_i2c_bus_by_name(i2cbus_arg);
+		if (char_dev == -1) {
+			fprintf(stderr, "Error: I2C bus argument doesn't match"
+				" any bus name or character device file!\n");
+			return -1;
+		}
+		hints->type = hint_bus_num;
+		hints->value.num = char_dev;
+		return 0;
 	}
 	if (i2cbus > 0xFFFFF) {
 		fprintf(stderr, "Error: I2C bus out of range!\n");
 		return -2;
 	}
 
-	return i2cbus;
+	hints->type = hint_bus_num;
+	hints->value.num = i2cbus;
+
+	return 0;
 }
 
 /*
@@ -410,11 +443,22 @@ int parse_i2c_address(const char *address_arg, int all_addrs)
 	return address;
 }
 
-int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet)
+int open_i2c_dev(const struct i2c_bus_hint *hints, char *filename, size_t size, int quiet)
 {
 	int file, len;
 
-	len = snprintf(filename, size, "/dev/i2c/%d", i2cbus);
+	if (hints->type == hint_bus_path) {
+		file = open(hints->value.path, O_RDWR);
+		snprintf(filename, size, "%s", hints->value.path);
+		if (file >= 0) {
+			return file;
+		} else {
+			fprintf(stderr, "Couldn't open %s: %s\n", hints->value.path, strerror(errno));
+			return -ENOENT;
+		}
+	};
+
+	len = snprintf(filename, size, "/dev/i2c/%d", hints->value.num);
 	if (len >= (int)size) {
 		fprintf(stderr, "%s: path truncated\n", filename);
 		return -EOVERFLOW;
@@ -422,7 +466,7 @@ int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet)
 	file = open(filename, O_RDWR);
 
 	if (file < 0 && (errno == ENOENT || errno == ENOTDIR)) {
-		len = snprintf(filename, size, "/dev/i2c-%d", i2cbus);
+		len = snprintf(filename, size, "/dev/i2c-%d", hints->value.num);
 		if (len >= (int)size) {
 			fprintf(stderr, "%s: path truncated\n", filename);
 			return -EOVERFLOW;
@@ -434,7 +478,7 @@ int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet)
 		if (errno == ENOENT) {
 			fprintf(stderr, "Error: Could not open file "
 				"`/dev/i2c-%d' or `/dev/i2c/%d': %s\n",
-				i2cbus, i2cbus, strerror(ENOENT));
+				hints->value.num, hints->value.num, strerror(ENOENT));
 		} else {
 			fprintf(stderr, "Error: Could not open file "
 				"`%s': %s\n", filename, strerror(errno));
diff --git a/tools/i2cbusses.h b/tools/i2cbusses.h
index 6f901b6..89cd6f9 100644
--- a/tools/i2cbusses.h
+++ b/tools/i2cbusses.h
@@ -19,6 +19,8 @@
 
 #include <unistd.h>
 
+enum hint_type { hint_bus_num, hint_bus_path };
+
 struct i2c_adap {
 	int nr;
 	char *name;
@@ -26,12 +28,20 @@ struct i2c_adap {
 	const char *algo;
 };
 
+struct i2c_bus_hint {
+	enum hint_type type;
+	union {
+		int num;
+		const char *path;
+	} value;
+};
+
 struct i2c_adap *gather_i2c_busses(void);
 void free_adapters(struct i2c_adap *adapters);
 
-int lookup_i2c_bus(const char *i2cbus_arg);
+int lookup_i2c_bus(const char *i2cbus_arg, struct i2c_bus_hint *hints);
 int parse_i2c_address(const char *address_arg, int all_addrs);
-int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet);
+int open_i2c_dev(const struct i2c_bus_hint *hints, char *filename, size_t size, int quiet);
 int set_slave_addr(int file, int address, int force);
 
 #define MISSING_FUNC_FMT	"Error: Adapter does not have %s capability\n"
diff --git a/tools/i2cdetect.8 b/tools/i2cdetect.8
index 5935b2b..034476c 100644
--- a/tools/i2cdetect.8
+++ b/tools/i2cdetect.8
@@ -24,12 +24,12 @@ i2cdetect \- detect I2C chips
 .I -l
 
 .SH DESCRIPTION
-i2cdetect is a userspace program to scan an I2C bus for devices. It
-outputs a table with the list of detected devices on the specified bus.
-\fIi2cbus\fR indicates the number or name of the I2C bus to be scanned, and
-should correspond to one of the busses listed by \fIi2cdetect -l\fR.
-The optional parameters \fIfirst\fR and \fIlast\fR restrict the scanning
-range (default: from 0x08 to 0x77).
+i2cdetect is a userspace program to scan an I2C bus for devices. It outputs a
+table with the list of detected devices on the specified bus. \fIi2cbus\fR
+indicates the number, name, or device file path of the I2C bus to be scanned
+(\fIi2cdetect -l\fR may be used to display I2C bus numbers and names). The
+optional parameters \fIfirst\fR and \fIlast\fR restrict the scanning range
+(default: from 0x08 to 0x77).
 .PP
 As there is no standard I2C detection command, i2cdetect uses arbitrary
 SMBus commands (namely SMBus quick write and SMBus receive byte) to probe
diff --git a/tools/i2cdetect.c b/tools/i2cdetect.c
index bb2f146..eda1758 100644
--- a/tools/i2cdetect.c
+++ b/tools/i2cdetect.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
+#include <linux/limits.h>
 #include <i2c/smbus.h>
 #include "i2cbusses.h"
 #include "../version.h"
@@ -38,7 +39,7 @@ static void help(void)
 		"Usage: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]\n"
 		"       i2cdetect -F I2CBUS\n"
 		"       i2cdetect -l\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C character device file path\n"
 		"  If provided, FIRST and LAST limit the probing range.\n");
 }
 
@@ -205,13 +206,14 @@ static void print_i2c_busses(void)
 int main(int argc, char *argv[])
 {
 	char *end;
-	int i2cbus, file, res;
-	char filename[20];
+	int file, res;
+	char filename[PATH_MAX];
 	unsigned long funcs;
 	int mode = MODE_AUTO;
 	int first = 0x08, last = 0x77;
 	int opt;
 	int yes = 0, version = 0, list = 0;
+	struct i2c_bus_hint hints;
 
 	/* handle (optional) flags first */
 	while ((opt = getopt(argc, argv, "FVahlqry")) != -1) {
@@ -269,8 +271,7 @@ int main(int argc, char *argv[])
 		help();
 		exit(1);
 	}
-	i2cbus = lookup_i2c_bus(argv[optind]);
-	if (i2cbus < 0) {
+	if (lookup_i2c_bus(argv[optind], &hints)) {
 		help();
 		exit(1);
 	}
@@ -313,7 +314,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(&hints, filename, sizeof(filename), 0);
 	if (file < 0) {
 		exit(1);
 	}
diff --git a/tools/i2cdump.8 b/tools/i2cdump.8
index 6ede625..e1ce463 100644
--- a/tools/i2cdump.8
+++ b/tools/i2cdump.8
@@ -52,9 +52,10 @@ scripts.
 Allow using addresses between 0x00 - 0x07 and 0x78 - 0x7f. Not recommended.
 .PP
 At least two options must be provided to i2cdump. \fIi2cbus\fR indicates the
-number or name of the I2C bus to be scanned. This number should correspond to one
-of the busses listed by \fIi2cdetect -l\fR. \fIaddress\fR indicates the
-address to be scanned on that bus, and is an integer between 0x08 and 0x77.
+number, name, or device file path of the I2C bus to be scanned (\fIi2cdetect
+-l\fR may be used to display I2C bus numbers and names). \fIaddress\fR
+indicates the address to be scanned on that bus, and is an integer between 0x08
+and 0x77.
 .PP
 The \fImode\fR parameter, if specified, is one of the letters \fBb\fP, \fBw\fP,
 or \fBi\fP, corresponding to a read size of a single byte, a 16-bit
diff --git a/tools/i2cdump.c b/tools/i2cdump.c
index d315e2f..f7eb72c 100644
--- a/tools/i2cdump.c
+++ b/tools/i2cdump.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
+#include <linux/limits.h>
 #include <i2c/smbus.h>
 #include "i2cbusses.h"
 #include "util.h"
@@ -32,7 +33,7 @@ static void help(void)
 {
 	fprintf(stderr,
 		"Usage: i2cdump [-f] [-y] [-r first-last] [-a] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C character device file path\n"
 		"  ADDRESS is an integer (0x08 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    b (byte, default)\n"
@@ -100,15 +101,16 @@ static int check_funcs(int file, int size, int pec)
 int main(int argc, char *argv[])
 {
 	char *end;
-	int i, j, res, i2cbus, address, size, file;
+	int i, j, res, address, size, file;
 	int bank = 0, bankreg = 0x4E, old_bank = 0;
-	char filename[20];
+	char filename[PATH_MAX];
 	int block[256];
 	int pec = 0, even = 0;
 	int opt;
 	int force = 0, yes = 0, version = 0, all_addrs = 0;
 	const char *range = NULL;
 	int first = 0x00, last = 0xff;
+	struct i2c_bus_hint hints;
 
 	/* handle (optional) flags first */
 	while ((opt = getopt(argc, argv, "Vafhr:y")) != -1) {
@@ -135,8 +137,7 @@ int main(int argc, char *argv[])
 		help();
 		exit(1);
 	}
-	i2cbus = lookup_i2c_bus(argv[optind]);
-	if (i2cbus < 0) {
+	if (lookup_i2c_bus(argv[optind], &hints)) {
 		help();
 		exit(1);
 	}
@@ -235,7 +236,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(&hints, filename, sizeof(filename), 0);
 	if (file < 0
 	 || check_funcs(file, size, pec)
 	 || set_slave_addr(file, address, force))
diff --git a/tools/i2cget.8 b/tools/i2cget.8
index 69586cc..0e7e8df 100644
--- a/tools/i2cget.8
+++ b/tools/i2cget.8
@@ -45,9 +45,9 @@ scripts. Use with caution.
 .B -a
 Allow using addresses between 0x00 - 0x07 and 0x78 - 0x7f. Not recommended.
 .PP
-There are two required options to i2cget. \fIi2cbus\fR indicates the number
-or name of the I2C bus to be scanned.  This number should correspond to one of
-the busses listed by \fIi2cdetect -l\fR. \fIchip-address\fR specifies the
+There are two required options to i2cget. \fIi2cbus\fR indicates the number,
+name, or device file path of the I2C bus to be scanned (\fIi2cdetect -l\fR may
+be used to display I2C bus numbers and names). \fIchip-address\fR specifies the
 address of the chip on that bus, and is an integer between 0x08 and 0x77.
 .PP
 \fIdata-address\fR specifies the address on that chip to read from, and is
diff --git a/tools/i2cget.c b/tools/i2cget.c
index 17d78bf..11b44b5 100644
--- a/tools/i2cget.c
+++ b/tools/i2cget.c
@@ -26,6 +26,7 @@
 #include <unistd.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
+#include <linux/limits.h>
 #include <i2c/smbus.h>
 #include "i2cbusses.h"
 #include "util.h"
@@ -35,7 +36,7 @@ static void __attribute__ ((noreturn)) help(int status)
 {
 	fprintf(stderr,
 		"Usage: i2cget [-f] [-y] [-a] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE [LENGTH]]]\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C character device file path\n"
 		"  ADDRESS is an integer (0x08 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    b (read byte data, default)\n"
@@ -169,14 +170,15 @@ static int confirm(const char *filename, int address, int size, int daddress,
 int main(int argc, char *argv[])
 {
 	char *end;
-	int res, i2cbus, address, size, file;
+	int res, address, size, file;
 	int daddress;
-	char filename[20];
+	char filename[PATH_MAX];
 	int pec = 0;
 	int opt;
 	int force = 0, yes = 0, version = 0, all_addrs = 0;
 	int length;
 	unsigned char block_data[I2C_SMBUS_BLOCK_MAX];
+	struct i2c_bus_hint hints;
 
 	/* handle (optional) flags first */
 	while ((opt = getopt(argc, argv, "Vafhy")) != -1) {
@@ -199,8 +201,7 @@ int main(int argc, char *argv[])
 	if (argc < optind + 2)
 		help(1);
 
-	i2cbus = lookup_i2c_bus(argv[optind]);
-	if (i2cbus < 0)
+	if (lookup_i2c_bus(argv[optind], &hints))
 		help(1);
 
 	address = parse_i2c_address(argv[optind+1], all_addrs);
@@ -251,7 +252,7 @@ int main(int argc, char *argv[])
 		length = I2C_SMBUS_BLOCK_MAX;
 	}
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(&hints, filename, sizeof(filename), 0);
 	if (file < 0
 	 || check_funcs(file, size, daddress, pec)
 	 || set_slave_addr(file, address, force))
diff --git a/tools/i2cset.8 b/tools/i2cset.8
index e4e1870..3b53d9e 100644
--- a/tools/i2cset.8
+++ b/tools/i2cset.8
@@ -65,9 +65,9 @@ apply as those of option \fB-m\fR.
 .B -a
 Allow using addresses between 0x00 - 0x07 and 0x78 - 0x7f. Not recommended.
 .PP
-There are three required options to i2cset. \fIi2cbus\fR indicates the number
-or name of the I2C bus to be scanned.  This number should correspond to one of
-the busses listed by \fIi2cdetect -l\fR. \fIchip-address\fR specifies the
+There are three required options to i2cset. \fIi2cbus\fR indicates the number,
+name, or device file path of the I2C bus to be scanned (\fIi2cdetect -l\fR may
+be used to display I2C bus numbers and names). \fIchip-address\fR specifies the
 address of the chip on that bus, and is an integer between 0x08 and 0x77.
 \fIdata-address\fR specifies the address on that chip to write to, and is an
 integer between 0x00 and 0xFF.
diff --git a/tools/i2cset.c b/tools/i2cset.c
index aaf7faf..88c8d34 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
+#include <linux/limits.h>
 #include <i2c/smbus.h>
 #include "i2cbusses.h"
 #include "util.h"
@@ -32,7 +33,7 @@ static void __attribute__ ((noreturn)) help(int status)
 {
 	fprintf(stderr,
 		"Usage: i2cset [-f] [-y] [-m MASK] [-r] [-a] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C character device file path\n"
 		"  ADDRESS is an integer (0x08 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    c (byte, no value)\n"
@@ -151,14 +152,15 @@ int main(int argc, char *argv[])
 {
 	char *end;
 	const char *maskp = NULL;
-	int res, i2cbus, address, size, file;
+	int res, address, size, file;
 	int value, daddress, vmask = 0;
-	char filename[20];
+	char filename[PATH_MAX];
 	int pec = 0;
 	int opt;
 	int force = 0, yes = 0, version = 0, readback = 0, all_addrs = 0;
 	unsigned char block[I2C_SMBUS_BLOCK_MAX];
 	int len;
+	struct i2c_bus_hint hints;
 
 	/* handle (optional) flags first */
 	while ((opt = getopt(argc, argv, "Vafhm:ry")) != -1) {
@@ -183,8 +185,7 @@ int main(int argc, char *argv[])
 	if (argc < optind + 3)
 		help(1);
 
-	i2cbus = lookup_i2c_bus(argv[optind]);
-	if (i2cbus < 0)
+	if (lookup_i2c_bus(argv[optind], &hints))
 		help(1);
 
 	address = parse_i2c_address(argv[optind+1], all_addrs);
@@ -301,7 +302,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(&hints, filename, sizeof(filename), 0);
 	if (file < 0
 	 || check_funcs(file, size, pec)
 	 || set_slave_addr(file, address, force))
diff --git a/tools/i2ctransfer.8 b/tools/i2ctransfer.8
index 4bdf436..51a3e58 100644
--- a/tools/i2ctransfer.8
+++ b/tools/i2ctransfer.8
@@ -84,9 +84,9 @@ This is mainly meant to be used in scripts.
 .PP
 The first parameter
 .I i2cbus
-indicates the number or name of the I2C bus to be used.
-This number should correspond to one of the busses listed by
-.B i2cdetect -l.
+indicates the number, name, or device file path of the I2C bus to be used.
+.B i2cdetect -l
+may be used to display I2C bus numbers and names.
 
 .PP
 The next parameter is one or multiple
diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index 4db98e3..410e0cc 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -25,6 +25,7 @@
 #include <unistd.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
+#include <linux/limits.h>
 #include "i2cbusses.h"
 #include "util.h"
 #include "../version.h"
@@ -51,7 +52,7 @@ static void help(void)
 		"           -v verbose mode\n"
 		"           -V version info\n"
 		"           -y yes to all confirmations\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C character device file path\n"
 		"  DESC describes the transfer in the form: {r|w}LENGTH[@address]\n"
 		"    1) read/write-flag 2) LENGTH (range 0-65535, or '?')\n"
 		"    3) I2C address (use last one if omitted)\n"
@@ -142,12 +143,13 @@ static int confirm(const char *filename, struct i2c_msg *msgs, __u32 nmsgs)
 
 int main(int argc, char *argv[])
 {
-	char filename[20];
-	int i2cbus, address = -1, file, opt, nmsgs = 0, nmsgs_sent, i;
+	char filename[PATH_MAX];
+	int address = -1, file, opt, nmsgs = 0, nmsgs_sent, i;
 	int force = 0, yes = 0, version = 0, verbose = 0, all_addrs = 0, binary = 0;
 	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];
 	enum parse_state state = PARSE_GET_DESC;
 	unsigned int buf_idx = 0;
+	struct i2c_bus_hint hints;
 
 	memset(msgs, 0, sizeof(msgs));
 
@@ -177,11 +179,10 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	i2cbus = lookup_i2c_bus(argv[optind++]);
-	if (i2cbus < 0)
+	if (lookup_i2c_bus(argv[optind++], &hints))
 		exit(1);
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(&hints, filename, sizeof(filename), 0);
 	if (file < 0 || check_funcs(file))
 		exit(1);
 

base-commit: c1b0305972e89aae048068a3b228f35ef0206243
-- 
2.53.0

