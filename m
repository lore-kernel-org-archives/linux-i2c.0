Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659662C21E6
	for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171600; cv=none; b=ipXUe6uqn4j/LhFcN5+AVLEJ9AWWlqFzI/W2d++zZq4ylxhCvTRMctORB+tbhV4+oOnqB64p3/DQtdFw6OcMffOnNS1qKZIrn/AKZNH0xxjjmZjeYZDK2aCpx6CRxgnCQgAcUv+7u9VKrpFfgMvFTRauCw8St/Kyq+FwyAYAq+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171600; c=relaxed/simple;
	bh=V/9OnsSxPuuc9oRFuHGeYv6JC6uDrSG47lfNOMTmEPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUrPuVebpc7TTLq1X4jUPk3Tt6e6F4Bhq8JUpOvV4F9Yi22UCUtRIZnA/FJJ/QS5MVNYDRiRcZUozfpcReuG/3AECj7zS+0b/YvJGAkKCL/sng/vxZ9/Ds4z/zAVCCCM6ki472Gsvd2kx/Q8dcLQ5NOGOooQc4nNSJDe3tw+F6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=bkmMJLVc; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="bkmMJLVc"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1370417c01cso8004236c88.1
        for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1780171598; x=1780776398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WD5pDjdvmU7aPgIKHKWDemhY9JruL8/jEEczMSVPsy4=;
        b=bkmMJLVcAY1g1kHUjXNPlfm5Yi3lVjv+XLxdqCy/0wFkJCWJHB5HPhgGFlkrDVMQIf
         7NbZDx9DvSmXTB+9/kDln3c6urkJU0iH5AyhbErmFv42zGk4GYp0zgr/dzS4lDOXcFT5
         b2Z72kDHS7m4PDNeDziLOQ++PNyMaT49LkbkpYciEg4t/16JAPm0zkJFhvaqCfejggsE
         ay344R8bD65wVnUjpaEUV0RiDUa7T1psP32cdSkZt4PfZLbKpnnFbhFboWrEbVnH/J2v
         94tXKMNe+iFNGVUHrbVGZ5dkKBwf28OcxPkM+V92P4wHen0q6LZBbzifUD9Ny4GE85T9
         //Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780171598; x=1780776398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WD5pDjdvmU7aPgIKHKWDemhY9JruL8/jEEczMSVPsy4=;
        b=SeQZGnRTzv7EY9EIZBx8p0XvtK68D3bZg+pMDc6jMxFlW4Wq7/C48RDwJrskW77PC4
         fDD5B0eGSrQUB/RXCb0v3SiNY6Ks2kR+XLwPtcwPGt5xc4pQG9HUoyzTHjFT6HeuUWqs
         HqwlTCOoSyAZm1fKYNkWsUiJ9/t0gSU2l+Epu+nRoSgnHvA/vM4x+dd4x3eDFI07DVLd
         EBrMgKijjzw1+FLnm9ovgRzAZjYKQ/nCgBFVptMdkBR8nkLLCe2TgPUXKRIZlVjPFV4T
         6AttnMy3Lc8IXhqI26wUVZd64v5GvJuedmsdyQuOaNkD9Chg1IJTtbawIym5JjfX8i76
         3uTg==
X-Forwarded-Encrypted: i=1; AFNElJ8iMQdX8sX7pcFXKgKpPWuXlyyPX3PJuGq6JuQKt5Ww0j3vGzJ43xUGVbSMsI+1NWYHS0A445aL0ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZfI7uhBFTofSnM6qqvN3YcoVaWy7Hls03KvMN9nzqlJRDcPV
	HgtvMqOMPFXrvcuT92qEy1Bcc89m+/Yvdwjx8R3Kt7gXCJ/eGAF+IM4V61SEH7dc/rP4bATcPiN
	jZ16H
X-Gm-Gg: Acq92OFLlN4dFsffT/OAoyDgtVUgj6xpl5xjot+Ny/iB6vrdSGwiV4lqeBYDyFRKVUg
	iPhEwGGIUvcwi0CWI8OR9dYs6Wvm/wY59nedeNMFjYUJ3+9MYM3qtYpTcaV2UDjX5fIquIqIHX+
	4cTRKxvG8MqbSljEobYS5yW2brJ5xk3oUzSmLTUSZm0L9LaQMcF5JwFJGjElf5Oy4UtFg+xnuWb
	whFtEf5ToBPisKG1U/Wva+Ytic+SNfCCLxvDk86A4ARMww4uz9mKibpYHAj05DvjxZTw8+DI9dC
	yEBqR7JPblXqgUv6veejhoyf9Z8kdm7wjADBiDNCzhiZljuQVHU6Y0E60Mr0bR678m2ZxNL7mqq
	HiacmrJELILmFUBZ0Mfu6MqkwuZkabBqQ6iI8Cci/Sc0od0QmY8bCEz42t4ASC5Tv4sEvPHcmdI
	eGP7S6f/jBMDJ4VK2Bh11SmlbMJKCQlpvTRyjZZ/bV8GS0V7ApjcxCV71jCaowsCkiItFuzh7vF
	9MxP/8=
X-Received: by 2002:a05:7300:72c5:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-304fa628f82mr2425758eec.22.1780171598369;
        Sat, 30 May 2026 13:06:38 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f316sm4504838eec.19.2026.05.30.13.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:06:37 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Sat, 30 May 2026 14:06:41 -0600
Subject: [PATCH v3 2/2] i2c-tools: Document device paths as I2CBUS arg
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-accept-device-path-v3-2-20c01b8f6726@brighamcampbell.com>
References: <20260530-accept-device-path-v3-0-20c01b8f6726@brighamcampbell.com>
In-Reply-To: <20260530-accept-device-path-v3-0-20c01b8f6726@brighamcampbell.com>
To: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2

i2c-tools now accept device file paths in addition to the i2c adapter
number and i2c adapter name. Add this capability to documentation.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 tools/i2cdetect.8   |  8 ++++----
 tools/i2cdetect.c   |  2 +-
 tools/i2cdump.8     |  7 ++++---
 tools/i2cdump.c     |  2 +-
 tools/i2cget.8      |  9 +++++----
 tools/i2cget.c      |  2 +-
 tools/i2cset.8      | 12 ++++++------
 tools/i2cset.c      |  2 +-
 tools/i2ctransfer.8 |  2 +-
 tools/i2ctransfer.c |  2 +-
 10 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/tools/i2cdetect.8 b/tools/i2cdetect.8
index 5935b2b..fdfff62 100644
--- a/tools/i2cdetect.8
+++ b/tools/i2cdetect.8
@@ -26,10 +26,10 @@ i2cdetect \- detect I2C chips
 .SH DESCRIPTION
 i2cdetect is a userspace program to scan an I2C bus for devices. It
 outputs a table with the list of detected devices on the specified bus.
-\fIi2cbus\fR indicates the number or name of the I2C bus to be scanned, and
-should correspond to one of the busses listed by \fIi2cdetect -l\fR.
-The optional parameters \fIfirst\fR and \fIlast\fR restrict the scanning
-range (default: from 0x08 to 0x77).
+\fIi2cbus\fR indicates the number, name, or device file path of the I2C
+bus to be scanned, and should correspond to one of the busses listed by
+\fIi2cdetect -l\fR.  The optional parameters \fIfirst\fR and \fIlast\fR
+restrict the scanning range (default: from 0x08 to 0x77).
 .PP
 As there is no standard I2C detection command, i2cdetect uses arbitrary
 SMBus commands (namely SMBus quick write and SMBus receive byte) to probe
diff --git a/tools/i2cdetect.c b/tools/i2cdetect.c
index 208ac6c..92d6c81 100644
--- a/tools/i2cdetect.c
+++ b/tools/i2cdetect.c
@@ -38,7 +38,7 @@ static void help(void)
 		"Usage: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]\n"
 		"       i2cdetect -F I2CBUS\n"
 		"       i2cdetect -l\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C bus device path\n"
 		"  If provided, FIRST and LAST limit the probing range.\n");
 }
 
diff --git a/tools/i2cdump.8 b/tools/i2cdump.8
index 6ede625..103051d 100644
--- a/tools/i2cdump.8
+++ b/tools/i2cdump.8
@@ -52,9 +52,10 @@ scripts.
 Allow using addresses between 0x00 - 0x07 and 0x78 - 0x7f. Not recommended.
 .PP
 At least two options must be provided to i2cdump. \fIi2cbus\fR indicates the
-number or name of the I2C bus to be scanned. This number should correspond to one
-of the busses listed by \fIi2cdetect -l\fR. \fIaddress\fR indicates the
-address to be scanned on that bus, and is an integer between 0x08 and 0x77.
+number, name, or device file path of the I2C bus to be scanned. This number
+should correspond to one of the busses listed by \fIi2cdetect -l\fR.
+\fIaddress\fR indicates the address to be scanned on that bus, and is an integer
+between 0x08 and 0x77.
 .PP
 The \fImode\fR parameter, if specified, is one of the letters \fBb\fP, \fBw\fP,
 or \fBi\fP, corresponding to a read size of a single byte, a 16-bit
diff --git a/tools/i2cdump.c b/tools/i2cdump.c
index ce3be2c..6389e68 100644
--- a/tools/i2cdump.c
+++ b/tools/i2cdump.c
@@ -32,7 +32,7 @@ static void help(void)
 {
 	fprintf(stderr,
 		"Usage: i2cdump [-f] [-y] [-r first-last] [-a] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C bus device path\n"
 		"  ADDRESS is an integer (0x08 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    b (byte, default)\n"
diff --git a/tools/i2cget.8 b/tools/i2cget.8
index 69586cc..ba261a9 100644
--- a/tools/i2cget.8
+++ b/tools/i2cget.8
@@ -45,10 +45,11 @@ scripts. Use with caution.
 .B -a
 Allow using addresses between 0x00 - 0x07 and 0x78 - 0x7f. Not recommended.
 .PP
-There are two required options to i2cget. \fIi2cbus\fR indicates the number
-or name of the I2C bus to be scanned.  This number should correspond to one of
-the busses listed by \fIi2cdetect -l\fR. \fIchip-address\fR specifies the
-address of the chip on that bus, and is an integer between 0x08 and 0x77.
+There are two required options to i2cget. \fIi2cbus\fR indicates the number,
+name, or device file path of the I2C bus to be scanned.  This number should
+correspond to one of the busses listed by \fIi2cdetect -l\fR.
+\fIchip-address\fR specifies the address of the chip on that bus, and is an
+integer between 0x08 and 0x77.
 .PP
 \fIdata-address\fR specifies the address on that chip to read from, and is
 an integer between 0x00 and 0xFF. If omitted, the currently active register
diff --git a/tools/i2cget.c b/tools/i2cget.c
index e08ee81..759f016 100644
--- a/tools/i2cget.c
+++ b/tools/i2cget.c
@@ -35,7 +35,7 @@ static void __attribute__ ((noreturn)) help(int status)
 {
 	fprintf(stderr,
 		"Usage: i2cget [-f] [-y] [-a] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE [LENGTH]]]\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C bus device path\n"
 		"  ADDRESS is an integer (0x08 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    b (read byte data, default)\n"
diff --git a/tools/i2cset.8 b/tools/i2cset.8
index e4e1870..d7a2c05 100644
--- a/tools/i2cset.8
+++ b/tools/i2cset.8
@@ -65,12 +65,12 @@ apply as those of option \fB-m\fR.
 .B -a
 Allow using addresses between 0x00 - 0x07 and 0x78 - 0x7f. Not recommended.
 .PP
-There are three required options to i2cset. \fIi2cbus\fR indicates the number
-or name of the I2C bus to be scanned.  This number should correspond to one of
-the busses listed by \fIi2cdetect -l\fR. \fIchip-address\fR specifies the
-address of the chip on that bus, and is an integer between 0x08 and 0x77.
-\fIdata-address\fR specifies the address on that chip to write to, and is an
-integer between 0x00 and 0xFF.
+There are three required options to i2cset. \fIi2cbus\fR indicates the number,
+name, or device file path of the I2C bus to be scanned. This number should
+correspond to one of the busses listed by \fIi2cdetect -l\fR. \fIchip-address\fR
+specifies the address of the chip on that bus, and is an integer between 0x08
+and 0x77. \fIdata-address\fR specifies the address on that chip to write to, and
+is an integer between 0x00 and 0xFF.
 .PP
 The \fIvalue\fR parameter, if specified, is the value to write to that
 location on the chip. If this parameter is omitted, then a short write is
diff --git a/tools/i2cset.c b/tools/i2cset.c
index 8371570..27e3c7f 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -32,7 +32,7 @@ static void __attribute__ ((noreturn)) help(int status)
 {
 	fprintf(stderr,
 		"Usage: i2cset [-f] [-y] [-m MASK] [-r] [-a] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C bus device path\n"
 		"  ADDRESS is an integer (0x08 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    c (byte, no value)\n"
diff --git a/tools/i2ctransfer.8 b/tools/i2ctransfer.8
index 4bdf436..012ca69 100644
--- a/tools/i2ctransfer.8
+++ b/tools/i2ctransfer.8
@@ -84,7 +84,7 @@ This is mainly meant to be used in scripts.
 .PP
 The first parameter
 .I i2cbus
-indicates the number or name of the I2C bus to be used.
+indicates the number, name, or device file path of the I2C bus to be used.
 This number should correspond to one of the busses listed by
 .B i2cdetect -l.
 
diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index b7b46fd..05299c1 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -51,7 +51,7 @@ static void help(void)
 		"           -v verbose mode\n"
 		"           -V version info\n"
 		"           -y yes to all confirmations\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C bus device path\n"
 		"  DESC describes the transfer in the form: {r|w}LENGTH[@address]\n"
 		"    1) read/write-flag 2) LENGTH (range 0-65535, or '?')\n"
 		"    3) I2C address (use last one if omitted)\n"

-- 
2.54.0

