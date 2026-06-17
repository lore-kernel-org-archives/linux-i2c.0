Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357DA3CE4AC
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689071; cv=none; b=SfYu2LeL1Jl96ea1OXh3BG7oE10Cs7ZC1MOJJZ3ImPcUH0hqvH6mqqRRRq2MjsHojhrIfRF3WVyJvAFFszNwreHljz84N7fWBlmP1kcwJP2aRKSCC2869DBnhslh15a/auwTJ85zQ+2KxfNNuqV9o6w5+SbNZDR5bnkU38UT/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689071; c=relaxed/simple;
	bh=AcCWvFpOGPE8ThgZVpfh7+Ce7hBwRNiryT75Y6WZ5nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LCiNhSXELBnEZudvoS9UqeRJMAB4WBdCK57QB1KbBBWkF6hbvhR2c49LcaTry0WebnRvQ5r1JICiw0YZno5szwWoM4mgs3tofIdo8tAdSSUeqnkK2Wjc4dr2SgAHqFkZBRLc+FR91xoTigF5KoE+6qXrRG+Cr5WxsPKx6stqedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SYh7ABs0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SYh7ABs0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eeba68948so4096508f8f.1
        for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781689063; x=1782293863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2s7ODgsFiXIvTxdhi2u/3dpArfH9ENrQ7HajG6sFQ8=;
        b=SYh7ABs0zsbmLpU+B1gIDCNAddspYwxRTh6tNvtzZ6FzRGyXsMhHORMgovOfKrEnwa
         ehzEeJTTS9xT+cSF8qCRy90srQBtrtc1c1AKREIl6/d3Xe4MVoi8dIQTcY3Ab4I2Ve5f
         CmWGsRqF6Cc18LT4ClTFV/bUuINznyJlEE3I4gxFQvTHMEXd1BF3DeRti1dlxftZfRbK
         ph0eM6j/LwUNgnGkbCZN27ZkNyj2Jby4VAAuHn/Zzn/eat278IhR0s6VwEAJk/+nTceD
         FDzPDYwCsM+1KY3TWFQ978HGAYnD4cJBz69jALeEtfIPPNfi/OcY8lWoZvKT9n5o2zFG
         HuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689063; x=1782293863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2s7ODgsFiXIvTxdhi2u/3dpArfH9ENrQ7HajG6sFQ8=;
        b=l9aYu97jx/G4HVPKCkeBaMsbGjdMT65A/EYW3I5hpXm1hABtP1DLAX3hICDtAZqThh
         qK3mdY1/VL0nT/chIR9Dp23bzcYe4Ogwy+FQusOIhNTp3za32qHv7Cg/mEmo1G8gsljs
         kNsMUO85buEs8gJlhiYHBLmZ4AqxWMzVx9i/XIBm3e7EQq/+k8B3mmjKMtlHsbhwcUno
         /qpbSP0kFxsHRIEjO9fDwn+fFSw1a5sz+gjcHn/WW+enLuS1ocqR/Vr1ryfql7eBHWNj
         RPVg8DM0C7taO1W3/1LRXQD/mdWT3JtZ++UUbx1lNetjSniiFn+2W9wb05pxMy/CCneL
         nEZQ==
X-Gm-Message-State: AOJu0YxdlZERzCnh3DyDHPTdCrhnjpqxYxHRsvLQY1j/UnMx4RTRjlmq
	eXRW3CGO0PMNDxqUfccd/gh9slPGJAa3E5voqKZmkC39yEG0bmxAg0lLzDTgFGHxo+A=
X-Gm-Gg: AfdE7cl4B+buRCP0cd/vw8EhvJFjbQAkC2WJxsFKWz1tTQxLnm9OE7w4RZisRjPzAoa
	TxtveBLgSeB0+rE4vFcAq0zPBn0wn7fiiCMmMYiH1qLTo4U5ll7t6zYkatc4gzJ16s3ZR59H10U
	AHSjOiBfmYUM1GEbXN6X6EINu9A4Aw7LjsTrSyLVnaotA6pC2J0WBIlNtcuLXNppuIgYkAVgTUf
	sTNmanjkoynkDUaICpOBNk6NekhWLzY1Pb5Ga23wuJMBHRsGFhaFcxb7yycSIi8kOsZWkopWgh2
	hHlerMl9kckuDR4VpmpcHjlZMQjvTlKb0A6eDm3URGdOajcd5B3/c5jZQBrlDbTOHdSX5+/xHRj
	4eZDpKDTlRe1Njk6auBRKyjszarXh9OFSozh4zm2VNj31Q+cF1o7mI1Iw5xDcx6XyUBjAKeEDG2
	Jcmikf5G3/auP74IVkMhQ4+CZ7YSxLZRJXCzytkI33XBhcVVuZjQmJYRdpUTRrFDIBSardyaqGj
	75e
X-Received: by 2002:a05:6000:184b:b0:462:7add:607 with SMTP id ffacd0b85a97d-4627add0679mr3715894f8f.25.1781689063346;
        Wed, 17 Jun 2026 02:37:43 -0700 (PDT)
Received: from localhost (p200300f65f47db04bc2080ea3c93ea6d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:bc20:80ea:3c93:ea6d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f264333sm54446920f8f.4.2026.06.17.02.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:37:42 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] i2c: pxa: Use named initializers for the platform_device_id array
Date: Wed, 17 Jun 2026 11:37:36 +0200
Message-ID:  <827657abb02edb39bc90f7336194f614d383770e.1781688767.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=AcCWvFpOGPE8ThgZVpfh7+Ce7hBwRNiryT75Y6WZ5nk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqMmrgypQUSs/793R8wm/Q6NvMgPOg/zVJPANE4 caDJJJaTE6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajJq4AAKCRCPgPtYfRL+ Tq74B/0X/+LzIOFvqziimcSgvT+urKQ8K2P6Gj8BLLNyy55Dezr6n9XZvqL2O8+7/egx8uJ6gIz Kwln2tPn0cd3TIJ7tKKzKFD6ViigkYPT0d91BFzmtq20C2idg8I8j/Ep+CiDDR4xp87IXgMYSUq rwWjcfQo7Bd95DM6qgD+DwfoGaDPT6znteufjefjnHrdnNOeesbQyqroki22QjHatS5LP+6DwFD VNXl45RM/179CsYG/4IQG5k8qQShAvgfFHTTBdSIAVY2n4ohYGBavB3wxijk3X4L3+M/e3Cg7EV udX0+EE4mZEyqJtSyvYEcdvDlXnMZQ8V2KAezOS91FEsWRQG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct platform_device_id replacing .driver_data by an anonymous union.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this is a preparating patch that is needed before making struct
platform_device_id's .driver_data a union. This is similar to the patch
quest outlined in https://lore.kernel.org/linux-i2c/20260504142639.2119645-2-u.kleine-koenig@baylibre.com/
.

Best regards
Uwe

 drivers/i2c/busses/i2c-pxa.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 9a8b154ab69e..c9927a389aaf 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -214,11 +214,11 @@ static const struct of_device_id i2c_pxa_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
 
 static const struct platform_device_id i2c_pxa_id_table[] = {
-	{ "pxa2xx-i2c",		REGS_PXA2XX },
-	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
-	{ "ce4100-i2c",		REGS_CE4100 },
-	{ "pxa910-i2c",		REGS_PXA910 },
-	{ "armada-3700-i2c",	REGS_A3700  },
+	{ .name = "pxa2xx-i2c",		.driver_data = REGS_PXA2XX },
+	{ .name = "pxa3xx-pwri2c",	.driver_data = REGS_PXA3XX },
+	{ .name = "ce4100-i2c",		.driver_data = REGS_CE4100 },
+	{ .name = "pxa910-i2c",		.driver_data = REGS_PXA910 },
+	{ .name = "armada-3700-i2c",	.driver_data = REGS_A3700 },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);

base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
-- 
2.47.3

