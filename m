Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AD481AB3
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710221; cv=none; b=IbWHafLLqjjk0F+8rSWdHXyPExED8RS0+RhrJUGomasznD2CBUo6c+DlgJyenqAUjYNylqcAMmEdnJ3B55fHPHzaetz6KMGwPaIO9QHau94h6AqplS9c9H9mH1acy7oDMKN4dtyqLu0b5bHmdX/KBM/9PVnMM/Z3v0Y/Vy4dw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710221; c=relaxed/simple;
	bh=NhS3LCjxnt5SLk5Q3V4TefozA3ivXCBUoWmX8Htwvac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWZD9L2zjXgjmV8sPCaUjA+JTmpYbakcg/6rpMwG62PdibQXLCpaSoUokIpOrrf2xOhc+KT8glvt7tVBTg9idy0T876q9LZlcPesLEpCtb2Uc9f5kFg7m2lXFMbYkYFilMbRZ0RZ7PxVCFJyItMT+0VOnY1GP+6SwpiolKF30OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=IpJAB1rN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="IpJAB1rN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cad4170e8eso175527495ad.3
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1784710220; x=1785315020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qiJQiKLPXeplr/aY2yh9xZ+CXInE5joLcgpqCDmPh98=;
        b=IpJAB1rNcHEEbiwgh4KF3XiyIfiuAn30zdzYwBDjd8Oa/Zm4CKZx+zjiMXc8lSEfce
         wWGGJdLIzgCmsdXHkg32UTTruQedKR+UZKpn+vTZNNYwv9skP+V0zGcaDgokdfeMbXCe
         TdXErI+7l9KeVkhyh35HAvXlbX5cyPpeLDL6mVs4FE0JaGWHx4Yi27cLZAGklyLWWAWt
         xib8ttOgURM55IX4MyWP8jn2AfGTIiBhxWAWmxW3hfmKUaOTdZk2cJ7KMbWX5321cLXb
         BVE3VPzhtpUh6VIqurpRcUF4TXhNAHNJDqh5h8kDPO0kj/3MAq2/tLPqh89KXwtANh/T
         eR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710220; x=1785315020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qiJQiKLPXeplr/aY2yh9xZ+CXInE5joLcgpqCDmPh98=;
        b=s6fOcQ9+B2ri66kM2T2fIpnEs8OOTTLxgeYbkADFyySxQQru92ErC85wHItYNtju67
         bX3cxHq+lA3oVL310lsrpHelGUyhYMr3r0CboY5Qwe68QV8mSNKHQcWgeeNNuJeiLe6F
         KsThj9dEpLbtQuXrGPpGfGcThrSIpVFLObr7yer4XqZv4ixbIcwst6YykrzT9pTmLeU+
         MIfL1iaWOOcVK4rgfNF/VwSR21XzdqqKJpnOnxrZ/c8cthCa3eN0jlenxLNJ0qkbifdD
         lzKlahTtbHgMOQx6MyQqxGd+cMoZeU1yIJLI7bLu+FJU7lhzEYXY8Q7ClObfiOu7tozL
         QXow==
X-Forwarded-Encrypted: i=1; AHgh+Roln/L7KiGEBYJyZ62ONhxKuJYqirFBSTdUoyoyUCMI72QsomRJHnJaF7bhvsO0IY0zYq0fAVl09cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvOWMayi5fX97kHTPLKMWtWe7NN4f/7bvIL/ks/IRIYvcNIgg
	LYzfIOqun0YaNyrVDdAdPPic4z0rOki4FHEa+LEXSdutvo5fRtk8BqlO8JzIJyObMiDFaZRPqNG
	Y4+o9RjM=
X-Gm-Gg: AR+sD13F19h8626Py3ttOJjLN+8YLBvxb35GtbqXMAHOxFoZzj1VaB7A6+HFY9EVcx+
	i/UDIeazMDNF4+awneKopc0OcbceA0nXpqhZ8tQC3sj5aLNmzbT6Fdb+EBA71ONvUjSQaC7lzV9
	ezLtJJDGDHwFrqePTLI5NNu/v0qOleR0z8Bp9+VhguZIpGXXb6fxdXZcEm6nSuDHa5m2DpBzd/M
	ch9g3XjX7Jvo5uEKCZtuC5PkHmfSich6ZgUwYAM0wMZoTGm5S6vD4+vc4i03E9wYfHnorNdhUAa
	fST8nMY5QZvh5Ks6muwK8pYsC2kMG49srHxo6vRQtWysIfAVfE0hpP5QyRe6O1Ma49c2JBVt23w
	Mus2PBHgrzxzjdT0jvZoIjNGv218R85kt0fL1umssvrP1T2u5Sdb2R5wZZmMUmoE3ip2zkcGFin
	186cGucgJBtilAT8m+3X3DVIjSZz6ImkQfP489PrnBlb6k6WU=
X-Received: by 2002:a05:6300:4047:b0:3c3:8d4c:668a with SMTP id adf61e73a8af0-3c3ad9ecd08mr20850483637.75.1784710219602;
        Wed, 22 Jul 2026 01:50:19 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13002f39sm4500928c88.1.2026.07.22.01.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:50:19 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Wed, 22 Jul 2026 02:52:41 -0600
Subject: [PATCH v5 2/2] i2c-tools: Document device paths as I2CBUS arg
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-accept-device-path-v5-2-9c0bf9b4da26@brighamcampbell.com>
References: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>
In-Reply-To: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>
To: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8212;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=NhS3LCjxnt5SLk5Q3V4TefozA3ivXCBUoWmX8Htwvac=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ1ZCy7PlAXuvPAp3mFBvGrA+QrLxWo7kHd74tVenJ7w7x
 DePZdKHjlIWBjEuBlkxRRaVW7PUL062fnQwgn8CzBxWJpAhDFycAjCRNX2MDKtM7Eq/7VrDq8Y5
 KdjBNd756Z20A3Okj1S9ijrwcNO9or8Mf4VF7S4yaZ3wXmb31PrENPNs8Ql5ywvubEs48TBSOm3
 fewYA
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

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
index b62f395..78a0955 100644
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
index de03c7d..20fd454 100644
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
index d9d1396..925c2b4 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -59,7 +59,7 @@ static void help(void)
 		"           -v verbose mode\n"
 		"           -V version info\n"
 		"           -y yes to all confirmations\n"
-		"  I2CBUS is an integer or an I2C bus name\n"
+		"  I2CBUS is an integer, I2C bus name, or I2C bus device path\n"
 		"  DESC describes the transfer in the form: [inpst]{r|w}LENGTH[@address]\n"
 		"    1) optional message modifier flags, if supported\n"
 		"       i: ignore NACK from client\n"

-- 
2.55.0

