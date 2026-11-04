Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832325;
	b=c93fAsTItQ0v2N9LPTGQohJsH0cKEA1EmRKImELeB+JM0TIKnxLqdN/t5zBicNj+MlNP
	 cO4+oIf5v/b4ycuE4uhi816sTx0TeDuSR0j5f/rPgsinmBaiON+JRjXvohAcU+elPSwpi
	 IoYwGCgm1eE+uh2X4M93xIzJK2rkmpnt24v6e3k3oBod0cXXBC2IXBKkFlNwQ6QaU+88n
	 zb/cIVc5jJiq52Y2YLDP3LZwG9Fna8N15AymFHXkHoJooNjQ/rX5ZjkfuIX1aJhEzdrGF
	 i5fPR3Eu0r+QpTnd34Le9H4BE8nc3CbwT+Lk7Qj21iLcj8pZSn3dKCI/ePGFZv3jsMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832325;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NisxL0f+f4Kv7Gxb9AXoyNy/iAXVqPNrxuhHVOeyJA4=;
	b=iQT/zl6TeAynkQmJU94AjQmSa8uUi5fn4nuiHNRVTikpNwJKbMVykBXHI586xvtuGqt4
	 u167xg5iI44mDWbbNnFyiuMeTuWJJHtKmjzGH4idmGk9APvdPcey0OKUwaejeSw1SAZuK
	 ugPoPtQjvZ53SifPgHj5Rj34HFSRNgJwGBVNDje9PkhAJj3dTodr2i5hmwVrbz8h12jTI
	 K5CzWWQUHqyuMWwYXenYd+l95mWpAebIm4zZpVl2cPdjQIggp9FTrV8WYd46VJi/JkPBN
	 xyydUMeEFFBM9n58x0Oie/L+9voVSdChfHMNy/qWyXbl3RAcSHVPGWY4LrLVFaCPYeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Ec56sdEU;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978C1606A31B
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 22:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978C1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Ec56sdEU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=NisxL0f+f4Kv7G
	xb9AXoyNy/iAXVqPNrxuhHVOeyJA4=; b=Ec56sdEU3y57YCyf/CEn6SQUt95R4o
	QErllIeqveA3WsEOgmgDxrEg0CLZVONnLRGqYO/G1gwli3qt6FeeMQsn6knljgDr
	+0wUdCaMJ1GF1MT8M9/vXrwYNva+WTfcefsiyaMdt90QSJEc2Vujagw+44tUDgH7
	oO/ieRQNGZNqOsBKf2bhly/zykxJClsVYqBGwgEGnsrtvn1qYwN9AXkcXKfQXSy5
	uhBirr24aa4X5dETwctxVHRQWL8ooWHsBvZFyk31dlm9owg/GT6ecQo5qOHlUcrd
	sxLGk02h+WcC1Nwq7wf2pcb7O1OpNtG4NFESVsbB0taIv8/WN4fotz/g==
Received: (qmail 888325 invoked from network); 4 Nov 2026 23:45:18 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Nov 2026 23:45:18 +0100
X-UD-Smtp-Session: l3s3148p1@syMhIntfvrnAwtcC
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] MAINTAINERS: add i2c-algo-bit to i2c-gpio driver
Date: Thu,  5 Nov 2026 00:44:50 +0200
Message-ID: <20261104224449.1332-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c-gpio is the prime user of i2c-algo-bit, so I also want to be
CCed when patches for the latter are coming in.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..137f39c285cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11234,7 +11234,9 @@ F:	kernel/entry/
 GENERIC GPIO I2C DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 S:	Supported
+F:	drivers/i2c/algos/i2c-algo-bit.c
 F:	drivers/i2c/busses/i2c-gpio.c
+F:	include/linux/i2c-algo-bit.h
 F:	include/linux/platform_data/i2c-gpio.h
 
 GENERIC GPIO I2C MULTIPLEXER DRIVER
-- 
2.53.0

