Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EFC23BF9B
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771471752; cv=none; b=mKnWE1+5a769Kpwwx3vtNaOa6ibX1EM6OfWBkLbkqzFmAJZaydZbDlR4XTh0liPPGyVyynRNvrh6dk21p8a46Y0Kdb2DrNcZGC1Zli89ZXOVV7CFEoxDw9EdTS246nRrW/RQLuPpoe+ZzSDx1vgH87+3FIngGHL+NVy2H8rVj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771471752; c=relaxed/simple;
	bh=pvHKYYWQeN+UrekZeo7tkVfYqOKXHOdrjh1cJoirygU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hKMN2fxOQAcawQY2KslugdJ+oE5YDNUFFJ3/NC+Qu/V4TOw51Id3+vA0thAXm4PmtfdAEbXSV0zTVxAD2Ub8v7GM1DSai8p2/YAMOKbFsqcw8v8vCSeNWKt6ZZyKfsoPuqBirsX6GNdsasf5P397gpfcKagF3b24mGOzD5MBRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=Q6f1DQuJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="Q6f1DQuJ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d19d3c7208so406895a34.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Feb 2026 19:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1771471749; x=1772076549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFMdy7MFqa8WzXMdOLXhTh6RzvKu5mz0WBoO1xgtXfM=;
        b=Q6f1DQuJcPQVmdSm2LdH59TbiZnlrfCmfx1d7YGHSFpUFEXi13BthIlXoikDX+l6oZ
         CvHeCVEFDo3i/jI3fHs3mqOjAoh01SqN1tbviEicAo8ePRJTMs0NA1aYBEvsj9eyMnkx
         x7QZg0zpsj3yiEjQfqt/RuUr6ALA6MB1cubL0cLgHxPyuDX1BXw36LaeaKHrULOmqPDS
         xAQThH2CfyNoH8U3OgiMBCUw2+ySk9qjcTxkyU7kNKiCzwTNJXXOIyayQARYXyxoolOj
         ggllD5rG6TwAfMCAVT6F2C54vPz8aMMfENCajj9XykGURHf9vBMlm9OAoJgVOG751ZVu
         7Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771471749; x=1772076549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFMdy7MFqa8WzXMdOLXhTh6RzvKu5mz0WBoO1xgtXfM=;
        b=E/XfaObnmox8Jyv5Cl9I60Hq5J7StEkKp7J62GVPhDnZ77gM3Eod6vfsHXE5S9siJQ
         FcdEJeFLbsIyfedEEUl5vH+YGYLWdBufxmPG56C21BXi8JcyxRyXuZGADSflnBPMZYjy
         VhVpGKEdOFB2qBfUdSOGNHgi07o1WB/bJnLcpsd36yMfE677ym413kwAQ09+GN6q+C60
         Weha22R+ca+UZlhORihw6HanDQJqEfh4S3+K0qkgBRCNvpZpdMBbl/Hr3+EOAkRouCCE
         XeZ0zCyjonlEtxgokEoMISxepZEtIbfElRG4GRh3/IgRUNvmYXvGPQdgEuOtHvX54Fpy
         2PRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFk3obqPBOen/++CR5OcksBPu/CUKhGa5/ibHtwCJsCV979YBLlP1gAikAYAFndpZIfA6oTMW6HRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hozaJd21BtXsL+xeg2xXHakyNGF1uN+B24ZaHvePMgXWYzvO
	4g1Gjx5HlBM0THiRaX3N4fEXEqlHgblxW2H6FpZmg0/GZ08fO2FFXZ92vZ9CEJKtDq2yNDJdw73
	5keDq
X-Gm-Gg: AZuq6aJXaBxQgdz/fX4o4+xJUqnE5BVtDpU6kuG0XyzRWf4jojdwwwdE5D6EG851UfL
	lpox3vwviYQQG0XvgHgeYCUeAsx33I4SrulLDX/385LblCh7R4bvNPTzVeBdnWQu/RgMGRcBYeb
	16AwrmAoAeomtPZBgA4dGAcxACSk+cgHPrdK/YNl13U/y+opOX7QeONxNCBnx8/5HtOyWRZGD6I
	Mc5gUj218mU1cCoiSoKb66xkqj/UlACJ2sco9+vVRb2SEXI8N7uVwp0Bw0ZKRumir5lqTI/3+hG
	B3DuYL4TwU5GzR4wUOiMib/PT3YOzR92WSBPyJoG8U+C46YbBz101uZOyOvF5e8brRJHhEPJOZ4
	lTe68rE2c9jUub3UTtw+Lqe2QCEhWYw1K5Kgy4yT97OKwBssh0/ZcJnumdE6+KSHPirjUTfAK1H
	DZdUuchwy13YlItngszP9xpU8wbWwLqul6woU94Eqf1K8uRrbROY0+05wj7mb8fKANWEB0MD2H9
	p0zGhBuLZg=
X-Received: by 2002:a05:6830:2588:b0:7ce:519d:10c7 with SMTP id 46e09a7af769-7d505da9e44mr2766595a34.7.1771471749230;
        Wed, 18 Feb 2026 19:29:09 -0800 (PST)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4c22d11a3sm14728519a34.6.2026.02.18.19.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 19:29:08 -0800 (PST)
From: Brigham Campbell <me@brighamcampbell.com>
To: Jean Delvare <jdelvare@suse.de>,
	linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Brigham Campbell <me@brighamcampbell.com>,
	=?UTF-8?q?Gero=20Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: [PATCH] Make userspace tools accept device file paths
Date: Wed, 18 Feb 2026 20:28:49 -0700
Message-ID: <20260219032849.668488-1-me@brighamcampbell.com>
X-Mailer: git-send-email 2.52.0
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
Otherwise, if it can be stat'ed as a path and is a character device file
of major device type 89, return the character device's minor number.
Otherwise, parse the string as an i2c bus controller name.

This will likely incur a small performance hit for users that pass the
i2c bus name, but users concerned with performance should be linking
against libi2c anyways.

Suggested-by: Gero Schwäricke <gero.schwaericke@sevenlab.de>
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---

I tested these changes by compiling and running i2cget and i2cset,
passing in i2c bus IDs, device file paths, and names.

Gero suggested this change on the linux-i2c mailing list recently.
Link: https://lore.kernel.org/linux-i2c/DE53PTBTBBBY.24N093ZM03IKQ@sevenlab.de/

Yikes. I better go finish my homework before it's late... Thanks for
reading this far!
---
 tools/i2cbusses.c   | 31 +++++++++++++++++++++++++------
 tools/i2cdetect.8   | 12 ++++++------
 tools/i2cdetect.c   |  2 +-
 tools/i2cdump.8     |  7 ++++---
 tools/i2cdump.c     |  2 +-
 tools/i2cget.8      |  6 +++---
 tools/i2cget.c      |  2 +-
 tools/i2cset.8      |  6 +++---
 tools/i2cset.c      |  2 +-
 tools/i2ctransfer.8 |  6 +++---
 tools/i2ctransfer.c |  2 +-
 11 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/tools/i2cbusses.c b/tools/i2cbusses.c
index d687615..32f51bf 100644
--- a/tools/i2cbusses.c
+++ b/tools/i2cbusses.c
@@ -23,6 +23,7 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <sys/param.h>	/* for NAME_MAX */
 #include <sys/ioctl.h>
 #include <string.h>
@@ -348,15 +349,24 @@ static int lookup_i2c_bus_by_name(const char *bus_name)
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
 
+static int lookup_i2c_bus_by_path(const char *path)
+{
+	struct stat stat_buf;
+
+	if (stat(path, &stat_buf))
+		return -1;
+
+	if ((!S_ISCHR(stat_buf.st_mode)) || (major(stat_buf.st_rdev) != 89))
+		return -2;
+
+	return minor(stat_buf.st_rdev);
+}
+
 /*
  * Parse an I2CBUS command line argument and return the corresponding
  * bus number, or a negative value if the bus is invalid.
@@ -365,11 +375,20 @@ int lookup_i2c_bus(const char *i2cbus_arg)
 {
 	unsigned long i2cbus;
 	char *end;
+	int char_dev = 0;
 
 	i2cbus = strtoul(i2cbus_arg, &end, 0);
 	if (*end || !*i2cbus_arg) {
-		/* Not a number, maybe a name? */
-		return lookup_i2c_bus_by_name(i2cbus_arg);
+		/* Not a number, maybe a path? */
+		char_dev = lookup_i2c_bus_by_path(i2cbus_arg);
+		if (char_dev >= 0)
+			return char_dev;
+		/* Not a character device file path, maybe a name? */
+		char_dev = lookup_i2c_bus_by_name(i2cbus_arg);
+		if (char_dev == -1)
+			fprintf(stderr, "Error: I2C bus argument doesn't match"
+				" any bus name or character device file!\n");
+		return char_dev;
 	}
 	if (i2cbus > 0xFFFFF) {
 		fprintf(stderr, "Error: I2C bus out of range!\n");
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
index bb2f146..6cc34ff 100644
--- a/tools/i2cdetect.c
+++ b/tools/i2cdetect.c
@@ -38,7 +38,7 @@ static void help(void)
 		"Usage: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]\n"
 		"       i2cdetect -F I2CBUS\n"
 		"       i2cdetect -l\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C character device file path\n"
 		"  If provided, FIRST and LAST limit the probing range.\n");
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
index d315e2f..491ca56 100644
--- a/tools/i2cdump.c
+++ b/tools/i2cdump.c
@@ -32,7 +32,7 @@ static void help(void)
 {
 	fprintf(stderr,
 		"Usage: i2cdump [-f] [-y] [-r first-last] [-a] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C character device file path\n"
 		"  ADDRESS is an integer (0x08 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    b (byte, default)\n"
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
index 17d78bf..1707fbd 100644
--- a/tools/i2cget.c
+++ b/tools/i2cget.c
@@ -35,7 +35,7 @@ static void __attribute__ ((noreturn)) help(int status)
 {
 	fprintf(stderr,
 		"Usage: i2cget [-f] [-y] [-a] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE [LENGTH]]]\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C character device file path\n"
 		"  ADDRESS is an integer (0x08 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    b (read byte data, default)\n"
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
index aaf7faf..68ce9b6 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -32,7 +32,7 @@ static void __attribute__ ((noreturn)) help(int status)
 {
 	fprintf(stderr,
 		"Usage: i2cset [-f] [-y] [-m MASK] [-r] [-a] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C character device file path\n"
 		"  ADDRESS is an integer (0x08 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    c (byte, no value)\n"
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
index 4db98e3..4ab37a6 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -51,7 +51,7 @@ static void help(void)
 		"           -v verbose mode\n"
 		"           -V version info\n"
 		"           -y yes to all confirmations\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C character device file path\n"
 		"  DESC describes the transfer in the form: {r|w}LENGTH[@address]\n"
 		"    1) read/write-flag 2) LENGTH (range 0-65535, or '?')\n"
 		"    3) I2C address (use last one if omitted)\n"

base-commit: c1b0305972e89aae048068a3b228f35ef0206243
-- 
2.52.0

