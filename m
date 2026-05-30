Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC011C5F11
	for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171599; cv=none; b=A+DsaLcak68XKQu3hhKwhGHkRfuuRXFHC0gQ7PPkGl2delSw6YA75CMN0WBu72muAA8MwB26/mvxq1M5bC7BpjK14S63kmcrQJgoAOiqz+iWXzYIIGMVvQzf6hzMZuepsP1zxlEFojYSY2e5gfTpGz318EFvz8nHExwoasEdBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171599; c=relaxed/simple;
	bh=Kaw9YVfcjIF3106pIvrqCXqqguWhbt6QdpQ/qdzO3pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SguutthmHYqhEwTTGT1n8/RHZux1nmtdvFLgZW1WFAvx3qInA7LoWngqbxPYMUxkl9rCtuZhRpmktz3cDS3HrtRl37ZD6xvl/srpBqEwNrspztmQ5TnjGx8I9EjLW4tolt73CeA0TFIgmgiN8mYZzpEKpetYBryAfwgqJPso8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=mBoyoCR4; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="mBoyoCR4"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1363e78746eso11603452c88.1
        for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1780171597; x=1780776397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNmMjau5Dwr+9nJtsB9rpyyAwiweWCuvsbFtL047nXQ=;
        b=mBoyoCR4D7j3pjBTajxj+34YDSP02UVhu5NpiZFulSlAJrBUWYV3CI3KcyfBRxvYHC
         Lo8Eo85bFZkfelS73CiNkkiXU+GRD0y8JmnceQrSfoNJC0uif/1RWm/Kr3mLCGKom9jD
         AEiUBhJmvvSO4AOdd2ccict0nEQrkQ4dufaiQ//r1MfRG9wwaNoxBePduaRzQ6J35KuB
         7HMbVRKVuncTmuzLWvdnaw1456/HZ7pAnZ9i0By6CI8sf5DVfKgVlPzEVgT4gkbAcAAk
         Rnd/9C2W6ggy3uaV+HyiLwll0+3/CXikQCrWbiAHSKHeaPTDaexJthKGrH3Hj6eocKtl
         HICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780171597; x=1780776397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNmMjau5Dwr+9nJtsB9rpyyAwiweWCuvsbFtL047nXQ=;
        b=XhVEEpb8bUIPOpizARaXuvwcL5biGZF6GUXTZYs8NER3Rxgqc7Pf+cj1zKscJnoEkl
         5nrepPhqHd+T9I298qJAYzg9vr6aeTQt0/nI+xkRwvVhxLtGhHFem6b9PBq1/llpvcDp
         pnnk+3131JdX+zbou7AhewlzLyHyWCdaMrARMldVW1XgJwMmmJMuq2/LCkMj2U6F7wgy
         Y6xkuBE6lmScqYjmzXv9v1AGQh5QY2HD0MBEoLH/Z5wcxJrp6HINchRChAVITAJqR55+
         Ib02ovtlP8G/Sx4eSkZnAR2VfqAORf9Om6ZrtsxgrWdm8GV2LkWjK/N5WtL/jsQS3gDe
         ZvSA==
X-Forwarded-Encrypted: i=1; AFNElJ9iB7MOk/xI5LQmxazDfCd0D8dJxRp/B9CFF5DK79vXYjBDM6DfvzHvie1ckkHHTenX846KbNgZPjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpOmM9hDLKUUYU8xsxLbPYZ/tmmigJeK4o3M+WmKTlvc9hbbRw
	B/dYXRfg35RzwzqaYp57BPkUSsxUT9TTUPHWTqVsZleuGHdbk0fsEirDTjuBD3FPjVt5LLCle+n
	hIKNS
X-Gm-Gg: Acq92OH2Su9e2krb6itUv4P8YRNn5i/IwHOFc48A2XpjAYgV7bktyEWK1YgH+G2VTFB
	jTTmN312D2qJNcNzHue/2QcEIDAv4/ncJQWgvzrJ5HcMmaRjR4Uja7ZEg6IoKVpBk2Hv+DxCLtF
	6YsdZCSn1Om9x2/x/hIQ2/XeKhOfjmUa5x60UBjSh8k93uY4h/eyN5hj0fSgsAkVeqihVQSsRvl
	ER6ZZmBXy3JafgTthlL1HEbc1uokknRGQgUMeLpKpR36hO3fo9Yr4dy0AuFw0E7sqtO0tGbZ3q/
	D38OgsFHjdtBRd/b+m4nNa+jxfyzXaX+fPZApV0YiUJTEeUwNoI5Ygtg099RQtDpJKvWaxj7yFM
	IbJXc/E8nLHPSvxKv+13z5Y2BMM10ZD4i82RHgS6GKI4Hw4Ja/k0MFXa7TpS2gTZpgn8JkKGqKI
	wPRoXFdEqiKTM4+9IYRPW9oo19rX3Dp06NluHvzTPwj+HGLATk0A0Wq4RE8KmO96GbImf5ayxso
	IFPAls=
X-Received: by 2002:a05:7022:1286:b0:136:5fe8:a5c7 with SMTP id a92af1059eb24-137d4026ccamr1915522c88.3.1780171596712;
        Sat, 30 May 2026 13:06:36 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36c6eabsm3660745c88.7.2026.05.30.13.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:06:36 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Sat, 30 May 2026 14:06:40 -0600
Subject: [PATCH v3 1/2] i2c-tools: Allow passing device file paths
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-accept-device-path-v3-1-20c01b8f6726@brighamcampbell.com>
References: <20260530-accept-device-path-v3-0-20c01b8f6726@brighamcampbell.com>
In-Reply-To: <20260530-accept-device-path-v3-0-20c01b8f6726@brighamcampbell.com>
To: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Brigham Campbell <me@brighamcampbell.com>, 
 =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: b4 0.15.2

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
index bb2f146..208ac6c 100644
--- a/tools/i2cdetect.c
+++ b/tools/i2cdetect.c
@@ -205,8 +205,9 @@ static void print_i2c_busses(void)
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
@@ -269,11 +270,6 @@ int main(int argc, char *argv[])
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
@@ -313,7 +309,7 @@ int main(int argc, char *argv[])
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
index 4db98e3..b7b46fd 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -142,8 +142,9 @@ static int confirm(const char *filename, struct i2c_msg *msgs, __u32 nmsgs)
 
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
@@ -177,11 +178,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	i2cbus = lookup_i2c_bus(argv[optind++]);
-	if (i2cbus < 0)
-		exit(1);
-
-	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	file = open_i2c_dev(argv[optind++], &filename, sizeof(filename_buf), 0);
 	if (file < 0 || check_funcs(file))
 		exit(1);
 

-- 
2.54.0

