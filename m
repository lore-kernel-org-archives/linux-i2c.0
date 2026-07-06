Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C5238C0A
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783311957; cv=none; b=Vc87hOGAU1WmUnN7IT40Ax4kj6S/CDsyc1sNgQxxBtUUw+AM2xzvSJ3adVcdcBXPN4xRvBprDr/jGrloey7zv/AZb51kJS4w9Ah57t3Tp3OhJ3H0ehFGQbIolACCoyEEjtsgUZHaqGnNfpi6CkYE/hu9K6avTYOi8vPtjyOh7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783311957; c=relaxed/simple;
	bh=NhS3LCjxnt5SLk5Q3V4TefozA3ivXCBUoWmX8Htwvac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eL8wBRWBWkNjfl9x1DJFcsjQnC7ZcuQwGTxZR841KI097eDkElv+Qp7c7yW0Tqq/BHMoivqAEaHtJ3SjH7V8d8MNOIuvVBp17jnHinsTv5+WZZwmGHvAGT8qNo1knY42em8hA4TZw6KP6WXKHasQUdCwhfD7NUCUH6tDNB+KAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=ev6howEW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="ev6howEW"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1289006a12.3
        for <linux-i2c@vger.kernel.org>; Sun, 05 Jul 2026 21:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783311956; x=1783916756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qiJQiKLPXeplr/aY2yh9xZ+CXInE5joLcgpqCDmPh98=;
        b=ev6howEW6mdShbFuUPFYX539qr62YgkoK2c2gAHTMQoaVZ0fWPQl5hwHIPSng5jraz
         Wexj/h8VoqlJtxpTRjtRG2/liu0Yw9T38uzRVfTCGivIgRI91v4gompDpSBqxy0H4nZv
         ko+aV5GB3FmkKbFzSAv3EgwN51prnazavb1ZSUKnJcJFHMR4SWIfDmX1bWOdLqGDt0ZC
         aMLCaCsjFHUZImkEafUKvqLl3zc1ogJGucFY6xOeN6wXmYzlz+BpS3+gfwSpfe2b9giY
         wtEzLcmrzpbLLTMZAkQjaX1qhCxqgNvBQcumg8ZmTCM7ogQxKIrUiUDCQlqulYgS78+X
         jzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783311956; x=1783916756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qiJQiKLPXeplr/aY2yh9xZ+CXInE5joLcgpqCDmPh98=;
        b=rB8eprSzymSnS0oVhTwvKuWqDFH0xJNEKbExzRm+GiodJEf+HJqzmTagtN0y5DZyZI
         Yvp5ZXMmR6dSEYZVam6xP9Eg/nBsN9lae/TBTKcn4i+yPGy/+retOsGRBTO64VNOgPcY
         brAYlEUrdaWRoiWErNlvorSIVoUsEyLtb+5xs69+kzA1f6LN03tK0qWJCmODjAPlCMPE
         J+poxZMWUsgL9K3zwNo5kZWx7ioZiOsoLuzLnEakokdHBb3enMAmNN/xFH/4cO+gcF/1
         oUUS/5sxNB/Ypf6YDeFstZdKH2p0Y+Ux9AuaY4et7gBSX0k7RSpvCS2YXH7oC+Ns00Ly
         8Ezw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4NK7uBJyyiGr6paQYSgeL6hS/f9/OV+r0+3LEHxSZdS0+LOZ+hZ1JzX3tNRDvWnYppLd4La95SjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweMYYfLJ8HJiI8Lsnot2bZCRE+jo4R46360M98zt7iHFclu00k
	8d0VZp9kof+gITXpSvC4RdyslnHTB1OVoLY6NvtcJ58xDbp9yVOK6qf/+/bikoxx/LY=
X-Gm-Gg: AfdE7cnDmnDgkM9haGd6KQVs50l/SyffZPxug1EBNCoxTm30j+/gzgS/EaEunvHUNPJ
	ymjo0G1jJoL+58zD8nGjXM9PXObG11cnJDXRdkacdcmUhddXfMoe69+w1rnBUBhnIhpj7/qAJzE
	dZqzuxy1Moa05mWGEFOnO5gkZVKI7iNv1XRtGUdbUO7o3MupSCQ+r+eKsCmjEfjQhyyu8G9SFNU
	hlJdwLfeCmLKmEGmIpTv0f2ncqhialeuiwJF270DUI3Tl2g5sEnfrho2HE69hHJc+ZegJ0IusqS
	IJc0qk4Cta+WC38eG692G+9hjBkexDDopNHUaVPmk5PV1RJdbUWGMTC2wyrFI00NuHNT0GKRa8P
	ipq/JX7JXYfEca9V9NPlXzdN8S+LNUPJ9XOmRZID9kpcGljsyaJTPSpkpkp9+xEhHap6r47SRgs
	5RRjeGrGWuu84G2zN36KLiy1nb2s/WkNwlNY+QH1elklh/H2jEBlgJwddsAQ==
X-Received: by 2002:a05:6a21:10e:b0:3bf:bc9a:db16 with SMTP id adf61e73a8af0-3c03e1ff210mr9856506637.11.1783311955640;
        Sun, 05 Jul 2026 21:25:55 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f44fba9a4sm23365262eec.10.2026.07.05.21.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 21:25:55 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Sun, 05 Jul 2026 22:27:54 -0600
Subject: [PATCH v4 2/2] i2c-tools: Document device paths as I2CBUS arg
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-accept-device-path-v4-2-c62caa708a9e@brighamcampbell.com>
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com>
In-Reply-To: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com>
To: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8212;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=NhS3LCjxnt5SLk5Q3V4TefozA3ivXCBUoWmX8Htwvac=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ5a33kkrKYX71p8VlnYpBzt+unm2UEOlY360gKbNnNPLm
 m7MYzLqKGVhEONikBVTZFG5NUv94mTrRwcj+CfAzGFlAhnCwMUpABMpamRkONXA/DfkhWH5/p1Z
 Fc/v/vSUlzw9k/XIWhcndtu5lRucVRkZWs+tVHF+Jhj7N5f9/uu90gnL95mkLbGv+/2NpbtpQds
 9VgA=
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

