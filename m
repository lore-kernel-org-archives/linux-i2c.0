Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6A47D936
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710220; cv=none; b=uX65iYntmtWK/uTpOL5RSbJZQh0/8GeKLun+gcDjLtPWpOweyOer6oUgjNHq5/pr5/7cU63nToP4H6L4n/aNe8Y+l2oiUcly4si3Y/eGk18wzDqv0fMPvwcgZGf3Qx0VszMhAjD0yS6d8gS5A9RH19fTmVi4BclR0125bR1BKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710220; c=relaxed/simple;
	bh=SlBqgn+cAs4Q6pJL+nSDKFyV73+I0ISDuYQ6ytCYOdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqdeB4OieBzNwEsf/IISvHlEcl7Ftwj3eNHK2ZQCbN84yueXWUmg9+M9LdglWU5AIPkQvTovXeH3Wu1bpZ1oBXEIYIVrWSLQ8/p4yk6PkvSNLqzqkzc5HlHk/DIFjiLg8OYDu1y3jIFqwhyQwvCwHzsuN+q2l0nNDzVscKRJAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=KkqTu49j; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="KkqTu49j"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso8756451a12.3
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1784710218; x=1785315018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghLz2EjLEf/AioIDdZ1VIYelH4LKq4EeITDf6ilVGVA=;
        b=KkqTu49jtSnYYv0QHfAuYHMSZVqDaoJg6RPB3eWrHU+xtO/o41UqGDmRQUrx84RhoU
         e374fIdDDP1a4jRlqjPNfh+PUAcB7Jy8zBDqEGcxtuMyiAmNumXSXPowa4cSFdrZw56t
         6epcQfs2CzHW4CuZFXLs3AkXL6VmoA3CgXpUE2nezwidVXGiKDXswuuQ2EzhYwwNuK1f
         aD88QHZObMiz1sdHWF9PBeFJ0uF4nCGoQRRY61mdX2XzkwSEfJiwvGJXWsG92WdixKx1
         vO5IMAu5T0KAxGQJfdhKwvvQB/1vTRORCgiUEk/wJJXsCvk218liMRVRU6wGyaxaA3Pw
         ZzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710218; x=1785315018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghLz2EjLEf/AioIDdZ1VIYelH4LKq4EeITDf6ilVGVA=;
        b=HT+ecUmQaeM4FGtTlQ0ppUpj/vt2p2iO/GviArRHzPs/+tIwmFXEn3MkbGXMUZ8g7+
         LbN1dC+lVGc5/UNFktpPmiTEQmd1hNKE1UojZx0WBLywSik/XSslETY/pVtf1sqEZ9RW
         xB6ceGHI9lD2O9FUX4hQtL1k1DnaZsh0Ho3qjNGT4h0N4gDtZz7Eb5FNuanRI0yglwwC
         hw+QRWL4cMslr4XRUquWq+FdJ+5YJV8KVkVkMno2aa4aYt/YSe7eREioDkQHZUWlTejV
         9C4qGDewz+E71j97Um+5vDh4ohdQrREOu/3H57eIJ8dYRjquUXx5uhgreFl3B8/KXkPI
         4ccg==
X-Forwarded-Encrypted: i=1; AHgh+Ro3Gq1cVgDbJ5lssLqo4nDxgsZX3s76fyiUNWKjXdEntIjdPci5d47k2s1dmVzxhtZlRJ9iZL4JiLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJ9sWE3vaU8uvCIP4fQYLUVijl24vje3ZeG0Iry3iPYrEWnm8
	UGznO6EHV8kAvAMhiLtKzq3L5C9AvyK0oFRH0izlB7tMJlc8zav6/0teEExSiLwTPWE=
X-Gm-Gg: AR+sD1017pYRmCeCdL6N+JZDIEQF5IcagQ8exjNf4JNp6NxCZ0WPvtZnj9NTqFNqCjU
	CbM2hyxd8eTP0OaYElQU57DaPgsovWr6Vlj+McuWooiXl0U/kyMhl8qh8CtIraTUtDEYj5LfQiU
	58+7JvrV5JemH2tGE7C7Xd2hNQdbJZq120ole1vr551gKC7ojtxdgwuCQxQbVpMVGqbJzO/2sj3
	D+EvktXK92fus4iYxcpTDCegxmECWAFN6zHx0TaUfczhXQBsD9mYNK+Cjh4ygK3/7ejdMtKPdMJ
	mqBv5S1GYWIND9IxOMNY7RHW83jQ3AnV7WyfF+z9HkP5wgNH/O/Xu0I2pUAySLRRVqaZ21endRW
	RiPosKK3Rv/AVJMAGjPT1tPvKXjfWvEQqi0Pt2tEwc9pan58E56/RrTvJH1Veh+R0tWjewVQ9bv
	z9f5BO+IOw/mDbRNppUl76boXyUAwEvYkUuQEB6qmLHUrmFMXvhajRtGFYqA==
X-Received: by 2002:a05:6a21:b94:b0:3c3:7fa2:9618 with SMTP id adf61e73a8af0-3c3ad9d1b80mr24751680637.37.1784710218072;
        Wed, 22 Jul 2026 01:50:18 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130a8421sm4075620c88.10.2026.07.22.01.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:50:17 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Wed, 22 Jul 2026 02:52:40 -0600
Subject: [PATCH v5 1/2] i2c-tools: Allow passing device file paths
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260722-accept-device-path-v5-1-9c0bf9b4da26@brighamcampbell.com>
References: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>
In-Reply-To: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>
To: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Brigham Campbell <me@brighamcampbell.com>, 
 =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11650;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=SlBqgn+cAs4Q6pJL+nSDKFyV73+I0ISDuYQ6ytCYOdo=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ1ZCy7NyWa+tLbz2tnybWZ88kEp7JWAz4d2VCUa//iq+0
 g7nFtjZUcLCIMbFICumyKJya5b6xcnWjw5G8E+AmcPKBDKEgYtTACbS8o/hR2/txj0zeFbphKtU
 qW44zbBrias8u/nvlh0TBK1Sth92YGToFFjLIMRp4OR778l546xpy2K/2InLb6p/7LZK1KSi0YM
 LAA==
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
 tools/i2cbusses.c   | 127 ++++++++++++++++++++++++++++++----------------------
 tools/i2cbusses.h   |   3 +-
 tools/i2cdetect.c   |  12 ++---
 tools/i2cdump.c     |  12 ++---
 tools/i2cget.c      |  11 ++---
 tools/i2cset.c      |  11 ++---
 tools/i2ctransfer.c |  11 ++---
 7 files changed, 95 insertions(+), 92 deletions(-)

diff --git a/tools/i2cbusses.c b/tools/i2cbusses.c
index d687615..40d863f 100644
--- a/tools/i2cbusses.c
+++ b/tools/i2cbusses.c
@@ -58,6 +58,42 @@ static struct adap_type adap_types[5] = {
 	  .algo		= "N/A", },
 };
 
+static int open_i2c_dev_by_nr(int i2cbus, char *filename, size_t size, int quiet)
+{
+	int file, len;
+
+	len = snprintf(filename, size, "/dev/i2c/%d", i2cbus);
+	if (len >= (int)size) {
+		fprintf(stderr, "%s: path truncated\n", filename);
+		return -EOVERFLOW;
+	}
+	file = open(filename, O_RDWR);
+
+	if (file < 0 && (errno == ENOENT || errno == ENOTDIR)) {
+		len = snprintf(filename, size, "/dev/i2c-%d", i2cbus);
+		if (len >= (int)size) {
+			fprintf(stderr, "%s: path truncated\n", filename);
+			return -EOVERFLOW;
+		}
+		file = open(filename, O_RDWR);
+	}
+
+	if (file < 0 && !quiet) {
+		if (errno == ENOENT) {
+			fprintf(stderr, "Error: Could not open file "
+				"`/dev/i2c-%d' or `/dev/i2c/%d': %s\n",
+				i2cbus, i2cbus, strerror(ENOENT));
+		} else {
+			fprintf(stderr, "Error: Could not open file "
+				"`%s': %s\n", filename, strerror(errno));
+			if (errno == EACCES)
+				fprintf(stderr, "Run as root?\n");
+		}
+	}
+
+	return file;
+}
+
 static enum adt i2c_get_funcs(int i2cbus)
 {
 	unsigned long funcs;
@@ -65,7 +101,7 @@ static enum adt i2c_get_funcs(int i2cbus)
 	char filename[20];
 	enum adt ret;
 
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 1);
+	file = open_i2c_dev_by_nr(i2cbus, filename, sizeof(filename), 1);
 	if (file < 0)
 		return adt_unknown;
 
@@ -348,37 +384,11 @@ static int lookup_i2c_bus_by_name(const char *bus_name)
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
 
-/*
- * Parse an I2CBUS command line argument and return the corresponding
- * bus number, or a negative value if the bus is invalid.
- */
-int lookup_i2c_bus(const char *i2cbus_arg)
-{
-	unsigned long i2cbus;
-	char *end;
-
-	i2cbus = strtoul(i2cbus_arg, &end, 0);
-	if (*end || !*i2cbus_arg) {
-		/* Not a number, maybe a name? */
-		return lookup_i2c_bus_by_name(i2cbus_arg);
-	}
-	if (i2cbus > 0xFFFFF) {
-		fprintf(stderr, "Error: I2C bus out of range!\n");
-		return -2;
-	}
-
-	return i2cbus;
-}
-
 /*
  * Parse a CHIP-ADDRESS command line argument and return the corresponding
  * chip address, or a negative value if the address is invalid.
@@ -410,39 +420,50 @@ int parse_i2c_address(const char *address_arg, int all_addrs)
 	return address;
 }
 
-int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet)
+/*
+ * Parse a I2CBUS command line argument and return the corresponding file
+ * descriptor, or a negative value if the file can't be resolved. Use *filename
+ * to return the file path. size refers to the size of the buffer which
+ * **filename initially points to.
+ *
+ * For historical reasons, I2CBUS parsing precedence is as follows:
+ * 	number -> name -> device path
+ */
+int open_i2c_dev(char *i2cbus_arg, char **filename, size_t size, int quiet)
 {
-	int file, len;
+	int file, i2cbus;
+	unsigned long i2cbus_ul;
+	char *end;
 
-	len = snprintf(filename, size, "/dev/i2c/%d", i2cbus);
-	if (len >= (int)size) {
-		fprintf(stderr, "%s: path truncated\n", filename);
-		return -EOVERFLOW;
-	}
-	file = open(filename, O_RDWR);
-
-	if (file < 0 && (errno == ENOENT || errno == ENOTDIR)) {
-		len = snprintf(filename, size, "/dev/i2c-%d", i2cbus);
-		if (len >= (int)size) {
-			fprintf(stderr, "%s: path truncated\n", filename);
-			return -EOVERFLOW;
+	i2cbus_ul = strtoul(i2cbus_arg, &end, 0);
+	if (!*end && *i2cbus_arg) {
+		if (i2cbus_ul > 0xFFFFF) {
+			fprintf(stderr, "Error: I2C bus out of range!\n");
+			return -2;
 		}
-		file = open(filename, O_RDWR);
+
+		return open_i2c_dev_by_nr(i2cbus_ul, *filename, size, quiet);
 	}
 
-	if (file < 0 && !quiet) {
-		if (errno == ENOENT) {
-			fprintf(stderr, "Error: Could not open file "
-				"`/dev/i2c-%d' or `/dev/i2c/%d': %s\n",
-				i2cbus, i2cbus, strerror(ENOENT));
-		} else {
-			fprintf(stderr, "Error: Could not open file "
-				"`%s': %s\n", filename, strerror(errno));
-			if (errno == EACCES)
-				fprintf(stderr, "Run as root?\n");
-		}
+	i2cbus = lookup_i2c_bus_by_name(i2cbus_arg);
+	if (i2cbus >= 0) {
+		return open_i2c_dev_by_nr(i2cbus, *filename, size, quiet);
 	}
 
+	*filename = i2cbus_arg;
+	file = open(i2cbus_arg, O_RDWR);
+
+	if (file >= 0 || quiet) return file;
+
+	if (errno == EACCES) {
+		fprintf(stderr, "Error: Could not open file `%s': %s\n"
+			"Run as root?\n", i2cbus_arg, strerror(errno));
+		return file;
+	}
+
+	fprintf(stderr, "Error: Couldn't interpret `%s' as a bus number, "
+		"name, or device file path!\n", i2cbus_arg);
+
 	return file;
 }
 
diff --git a/tools/i2cbusses.h b/tools/i2cbusses.h
index 6f901b6..0cec50f 100644
--- a/tools/i2cbusses.h
+++ b/tools/i2cbusses.h
@@ -29,9 +29,8 @@ struct i2c_adap {
 struct i2c_adap *gather_i2c_busses(void);
 void free_adapters(struct i2c_adap *adapters);
 
-int lookup_i2c_bus(const char *i2cbus_arg);
 int parse_i2c_address(const char *address_arg, int all_addrs);
-int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet);
+int open_i2c_dev(char *i2cbus_arg, char **filename, size_t size, int quiet);
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

