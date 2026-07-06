Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C362BD02
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783311956; cv=none; b=JnvemM2cLFJSfT9I6mPsf3AMGD9DBo9N2hZQXJpPjdg/wBaFCmy6iNAg6ObTTF3hBaXdjaPemm+wh7ggtNrfTfkK+QaQy0PpF3BUV++QGLJ86O3c8Fv5jeFViu0oFS8jq5G8gUKDwtREww6G1+9VZmBp0LVxH6OPORVCHwq2cYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783311956; c=relaxed/simple;
	bh=3qD/MwQJsMYhCbRFJtChmIKKJ1ahwDi1yOkdkYnmb6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZI79C/D6iGRDt6oHnAh/8+pGoSI9U7gK3IyJYORuxMtddnZRA96dZdfe+jCwl3t85d9Rxw3FTC1ysueiFrMHlpt+eNf2RGNTbijHovn4BLxq8cK3IbnFaE3kOTEf/CRfshD/tyhMoN7Iwicvx8uwgyZ8+iPiGKoo2STP6SHilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=fp/NV7T9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="fp/NV7T9"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1462108a91.1
        for <linux-i2c@vger.kernel.org>; Sun, 05 Jul 2026 21:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783311954; x=1783916754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZo5ERk4aN7wOeLZv2EzgPERxJsH0zD+jPLcjjPwLno=;
        b=fp/NV7T9W2nr7CB2lhFwbD1qsS5+6v1982hUHdLFTtt1Cp13xvuxl0oPrxBjooGgum
         Jg1nfuBxneCl/I4WpCfOCHrUeZQcmBKRSrvYxmKIuxvM5FFReIC1R2SIpew+g5JQSblt
         olsYqiY/YoHxY4JIKCpJf8bZHFRgewAWpWkeVpehgV6bRQoTqj6xnL1I1M9oCYc3evt8
         HEoDz/VHGRuIY+7pkhluW3Tut65jpJnuN+2EL3g+r2T9z4FKcECMLimqDa03WlkTwUDw
         Ex9uGWE1wouen17DrRX4FUehP8Wnweh2yuzqGlF9CHjWUYCEg+nKgNEu43lZmECqlgXn
         CuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783311954; x=1783916754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AZo5ERk4aN7wOeLZv2EzgPERxJsH0zD+jPLcjjPwLno=;
        b=loWaPHF2GwvJTpw/y85iD9XWzUJiRnn2BZx62IdY9o8fOUBm8H/goFZubgAGkcXxqk
         w+BophjL0QcvsyzhxyrmJHXbOVkSZ6O941e5ul41VLD8JC4SnavxJNS5QjnenyTrbcen
         BCegHVGBkNSMXD5bj3zTZPt+/T1PlyQyqsj12HBYW7BUUcSxKjADkMRGW02V3l6TyWXs
         EZjZ4bRjpS6JQsoLl5QNrSd21SjOYM4NaQz1MdSjivd5p0P2NhyFQT8D+/6tUQPn2zze
         KOX5yZzi8gyMeakLGVEBWnq5Mf2dm8NnSR41VtL4e7aVJVR6OWjlZzZZ+cDgY5IxO6F8
         Yrug==
X-Forwarded-Encrypted: i=1; AHgh+RpNDQz5mak4yMYyrT7kGM+3Ye6oQpOqkPAHBIjtXV5lUuFD8ci5vVztLZuQVKBHDeh8L53OM7v2hE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhpeYtfiR+K01V+AUxwVTUO+DjLkDeO5cKwNIg1WZyStplaGPc
	atgcFbnvjHdi67+tg1bbgGLNrn1e8fk6Q65rV4A8ZdSlcOQGQri3aVJ+x3PXzkyZQfM=
X-Gm-Gg: AfdE7clq3J0vlEtmWcaQkH61K6JPKXMVhFJtNQlx5FrTbLooUTYlyIOwK0yNIlSmsP5
	can+MaFK2zRodF2OzvIa+xD9dmYmYAXIgRMWrie9TxY1OVfDNRuvb/sMo9OxpX3b/FbMyQM2rIK
	muv6cJ6g98/n2L6vkoyY8N0ylptkDagD+Kc6JRVW3VfmwBCDnzmK3S804xNoNBddfeYM2whx73K
	iIJPYnJz3NO5JYSHx4ivi9oDmRBZsF648hvP/SgGi50j0jhfSCcS1RXQedMaBZVect9ohcOgb6h
	XBVDYrMTZAr9jaKh8ryUve5QweoohpJw3X/Rvf8mt7E0Hg4Dz2lJpDbQn0U+qG3IlRfzmbLLv4Z
	zS4e2ZPRDjK7qzBsn/oy9V+hOrsWc649cTjtyk7EWbFhFeBR0+xgBwZU1ryVAp1Ibwsy4xQgqq+
	EO9hOcWzn0Q3XIGo/C8CJr0QiGCpgrCpMDj6BMr11mgvG34OeKvASMwZhymJJ5S64bdvyl
X-Received: by 2002:a05:6a21:3318:b0:3b3:be1f:c89b with SMTP id adf61e73a8af0-3c03e21f2f8mr9052341637.22.1783311954264;
        Sun, 05 Jul 2026 21:25:54 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm56766475c88.8.2026.07.05.21.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 21:25:53 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Sun, 05 Jul 2026 22:27:53 -0600
Subject: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com>
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com>
In-Reply-To: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com>
To: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Brigham Campbell <me@brighamcampbell.com>, 
 =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8781;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=3qD/MwQJsMYhCbRFJtChmIKKJ1ahwDi1yOkdkYnmb6U=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ5a33smPzBp1e+e7SR5fKaUs5f3F0PbT+a0m6smbdlxiM
 Fkfn/Cuo5SFQYyLQVZMkUXl1iz1i5OtHx2M4J8AM4eVCWQIAxenAEyE/R8jQ9MnhXj2No3XhzL9
 vvo/nn7B5JSdufjeosVebYzWPh/Zshn+CtfZiIt1WORKSt/TzRLS0+OO7WjWNI17ciPdpeFZ+FR
 2AA==
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Make i2c-tools binaries accept a device file path or symlink directly.
This is useful, for example, for use with stable symlinks generated by
udev.

In the case of conflict, the bus parameter is parsed with the following
precedence in order to maintain backwards compatibility:

number -> name -> device path

Suggested-by: Gero Schwäricke <gero.schwaericke@sevenlab.de>
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 tools/i2cbusses.c   | 40 ++++++++++++++++++++++++++++++++++------
 tools/i2cbusses.h   |  4 +++-
 tools/i2cdetect.c   | 12 ++++--------
 tools/i2cdump.c     | 12 ++++--------
 tools/i2cget.c      | 11 ++++-------
 tools/i2cset.c      | 11 ++++-------
 tools/i2ctransfer.c | 11 ++++-------
 7 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/tools/i2cbusses.c b/tools/i2cbusses.c
index d687615..54f3238 100644
--- a/tools/i2cbusses.c
+++ b/tools/i2cbusses.c
@@ -65,7 +65,7 @@ static enum adt i2c_get_funcs(int i2cbus)
 	char filename[20];
 	enum adt ret;
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 1);
+	file = open_i2c_dev_num(i2cbus, filename, sizeof(filename), 1);
 	if (file < 0)
 		return adt_unknown;
 
@@ -348,10 +348,6 @@ static int lookup_i2c_bus_by_name(const char *bus_name)
 		}
 	}
 
-	if (i2cbus == -1)
-		fprintf(stderr, "Error: I2C bus name doesn't match any "
-			"bus present!\n");
-
 done:
 	free_adapters(adapters);
 	return i2cbus;
@@ -410,7 +406,7 @@ int parse_i2c_address(const char *address_arg, int all_addrs)
 	return address;
 }
 
-int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet)
+int open_i2c_dev_num(int i2cbus, char *filename, size_t size, int quiet)
 {
 	int file, len;
 
@@ -446,6 +442,38 @@ int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet)
 	return file;
 }
 
+int open_i2c_dev_path(const char *i2cbus_arg, int quiet)
+{
+	int file = open(i2cbus_arg, O_RDWR);
+
+	if (file < 0 && !quiet) {
+		fprintf(stderr, "Error: Could not open file "
+			"`%s': %s\n", i2cbus_arg, strerror(errno));
+		if (errno == EACCES)
+			fprintf(stderr, "Run as root?\n");
+	}
+
+	return file;
+}
+
+int open_i2c_dev(char *i2cbus_arg, char **filename, size_t size, int quiet)
+{
+	int file, i2cbus;
+
+	i2cbus = lookup_i2c_bus(i2cbus_arg);
+
+	if (i2cbus < 0) {
+		*filename = i2cbus_arg;
+		file = open_i2c_dev_path(i2cbus_arg, quiet);
+		if (file < 0)
+			fprintf(stderr, "Failed to open `%s' as a bus name "
+					"and as a path.\n", i2cbus_arg);
+		return file;
+	}
+
+	return open_i2c_dev_num(i2cbus, *filename, size, quiet);
+}
+
 int set_slave_addr(int file, int address, int force)
 {
 	/* With force, let the user read from/write to the registers
diff --git a/tools/i2cbusses.h b/tools/i2cbusses.h
index 6f901b6..5de3056 100644
--- a/tools/i2cbusses.h
+++ b/tools/i2cbusses.h
@@ -31,7 +31,9 @@ void free_adapters(struct i2c_adap *adapters);
 
 int lookup_i2c_bus(const char *i2cbus_arg);
 int parse_i2c_address(const char *address_arg, int all_addrs);
-int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet);
+int open_i2c_dev(char *i2cbus_arg, char **filename, size_t size, int quiet);
+int open_i2c_dev_num(int i2cbus, char *filename, size_t size, int quiet);
+int open_i2c_dev_path(const char *i2cbus_arg, int quiet);
 int set_slave_addr(int file, int address, int force);
 
 #define MISSING_FUNC_FMT	"Error: Adapter does not have %s capability\n"
diff --git a/tools/i2cdetect.c b/tools/i2cdetect.c
index 3c22f17..b62f395 100644
--- a/tools/i2cdetect.c
+++ b/tools/i2cdetect.c
@@ -213,8 +213,9 @@ static void print_i2c_busses(void)
 int main(int argc, char *argv[])
 {
 	char *end;
-	int i2cbus, file, res;
-	char filename[20];
+	int file, res;
+	char filename_buf[20];
+	char *filename = filename_buf;
 	unsigned long funcs;
 	int mode = MODE_AUTO;
 	int first = 0x08, last = 0x77;
@@ -277,11 +278,6 @@ int main(int argc, char *argv[])
 		help();
 		exit(1);
 	}
-	i2cbus = lookup_i2c_bus(argv[optind]);
-	if (i2cbus < 0) {
-		help();
-		exit(1);
-	}
 
 	/* read address range if present */
 	if (argc == optind + 3 && mode != MODE_FUNC) {
@@ -321,7 +317,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(argv[optind], &filename, sizeof(filename_buf), 0);
 	if (file < 0) {
 		exit(1);
 	}
diff --git a/tools/i2cdump.c b/tools/i2cdump.c
index d315e2f..ce3be2c 100644
--- a/tools/i2cdump.c
+++ b/tools/i2cdump.c
@@ -100,9 +100,10 @@ static int check_funcs(int file, int size, int pec)
 int main(int argc, char *argv[])
 {
 	char *end;
-	int i, j, res, i2cbus, address, size, file;
+	int i, j, res, address, size, file;
 	int bank = 0, bankreg = 0x4E, old_bank = 0;
-	char filename[20];
+	char filename_buf[20];
+	char *filename = filename_buf;
 	int block[256];
 	int pec = 0, even = 0;
 	int opt;
@@ -135,11 +136,6 @@ int main(int argc, char *argv[])
 		help();
 		exit(1);
 	}
-	i2cbus = lookup_i2c_bus(argv[optind]);
-	if (i2cbus < 0) {
-		help();
-		exit(1);
-	}
 
 	if (argc < optind + 2) {
 		fprintf(stderr, "Error: No address specified!\n");
@@ -235,7 +231,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(argv[optind], &filename, sizeof(filename_buf), 0);
 	if (file < 0
 	 || check_funcs(file, size, pec)
 	 || set_slave_addr(file, address, force))
diff --git a/tools/i2cget.c b/tools/i2cget.c
index 17d78bf..e08ee81 100644
--- a/tools/i2cget.c
+++ b/tools/i2cget.c
@@ -169,9 +169,10 @@ static int confirm(const char *filename, int address, int size, int daddress,
 int main(int argc, char *argv[])
 {
 	char *end;
-	int res, i2cbus, address, size, file;
+	int res, address, size, file;
 	int daddress;
-	char filename[20];
+	char filename_buf[20];
+	char *filename = filename_buf;
 	int pec = 0;
 	int opt;
 	int force = 0, yes = 0, version = 0, all_addrs = 0;
@@ -199,10 +200,6 @@ int main(int argc, char *argv[])
 	if (argc < optind + 2)
 		help(1);
 
-	i2cbus = lookup_i2c_bus(argv[optind]);
-	if (i2cbus < 0)
-		help(1);
-
 	address = parse_i2c_address(argv[optind+1], all_addrs);
 	if (address < 0)
 		help(1);
@@ -251,7 +248,7 @@ int main(int argc, char *argv[])
 		length = I2C_SMBUS_BLOCK_MAX;
 	}
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(argv[optind], &filename, sizeof(filename_buf), 0);
 	if (file < 0
 	 || check_funcs(file, size, daddress, pec)
 	 || set_slave_addr(file, address, force))
diff --git a/tools/i2cset.c b/tools/i2cset.c
index aaf7faf..8371570 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -151,9 +151,10 @@ int main(int argc, char *argv[])
 {
 	char *end;
 	const char *maskp = NULL;
-	int res, i2cbus, address, size, file;
+	int res, address, size, file;
 	int value, daddress, vmask = 0;
-	char filename[20];
+	char filename_buf[20];
+	char *filename = filename_buf;
 	int pec = 0;
 	int opt;
 	int force = 0, yes = 0, version = 0, readback = 0, all_addrs = 0;
@@ -183,10 +184,6 @@ int main(int argc, char *argv[])
 	if (argc < optind + 3)
 		help(1);
 
-	i2cbus = lookup_i2c_bus(argv[optind]);
-	if (i2cbus < 0)
-		help(1);
-
 	address = parse_i2c_address(argv[optind+1], all_addrs);
 	if (address < 0)
 		help(1);
@@ -301,7 +298,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(argv[optind], &filename, sizeof(filename_buf), 0);
 	if (file < 0
 	 || check_funcs(file, size, pec)
 	 || set_slave_addr(file, address, force))
diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index a49b734..d9d1396 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -257,8 +257,9 @@ static enum supported_flags_retval
 
 int main(int argc, char *argv[])
 {
-	char filename[20];
-	int i2cbus, address = -1, file, opt, nmsgs = 0, nmsgs_sent, i;
+	char filename_buf[20];
+	char *filename = filename_buf;
+	int address = -1, file, opt, nmsgs = 0, nmsgs_sent, i;
 	int force = 0, yes = 0, version = 0, verbose = 0, all_addrs = 0, binary = 0;
 	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];
 	enum parse_state state = PARSE_GET_DESC;
@@ -293,11 +294,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	i2cbus = lookup_i2c_bus(argv[optind++]);
-	if (i2cbus < 0)
-		exit(1);
-
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(argv[optind++], &filename, sizeof(filename_buf), 0);
 	if (file < 0 || get_funcs(file, &funcs) || check_funcs(funcs))
 		exit(1);
 

-- 
2.55.0

