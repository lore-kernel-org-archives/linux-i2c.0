Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680673;
	b=4/k1hJgBA5s2dsOHj1hcZOMTOu9spi3g4vY4mbllAPqSU+TzRt/malyhGrFYZEcXzJnX
	 yQTeXfSGoZFmRQvvu5c401K3T71zGBcJY6QCKk+2eTyn4FdTUB3okLl1uOTNthUtl4Ry7
	 5eRzHU8Hy8J7XWRS4sTXzInuSBT5qDyRzEzsS6eX43gkthjnObpi2bxhl93w+NQ0Fya53
	 UzDTqvQiuKIQemXlNqPO9Txg+3t5x9YNnDbkfEXe/82KROR2XtZTwXui2FVGDHaAHcIKZ
	 W59u0l1OzZYxEP+pTKdiQJ3A1KinKCe8rPqdaVmlA20b30SeVkBKVaEKMr1Gte7fa1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ggqaj3bggsrUOqnPqyXrXYqxV+UfImDX5TnRZxULpTQ=;
	b=ANXI6TYdVKiZPwA7vI/qhYQE5ERht1l8AUxprpOJ+zq/ZGeLpEtX6WGaH3q0Lp6R0tsf
	 Mbzn9xs6OPyle9sjJk3ycYzM06BDNyNs0+ozz5r6yqwOKFhOFmj/XXWTWYbd4ybLSXxKa
	 R16KlYNwTpyEDLcpATF8q+YvSv2Ba01WnfYVurMJI7/3IlJksuipy3AcWowBT9LCzTRQF
	 R30XOuuSVHMjiIYkjWqsWLn25G8DONf1LRELrIm1x6h1S1rEQ7u0DhIbZvZ/V9Y/SU399
	 pu6ciOeW9e6KPPRq81svsGS1Mq4kzt1kMtdkMuZj0XrqVdlH53lzUNP3bgKa52ugSxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PdJvRmCB;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E6606A32C
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 04:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 055E6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PdJvRmCB
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so2935789a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 20:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680672; x=1794285472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ggqaj3bggsrUOqnPqyXrXYqxV+UfImDX5TnRZxULpTQ=;
        b=PdJvRmCBW1wQ6OU3g6wpWwu1J+p3JTzSxLtDdRYLIr9+zCvOFml0datlWZ9ZCXiSL5
         jp0vGuECBDFT6Qk+GR4a7krValxFzz4CC2Yy4WM6IlDhVb1rY1oHPLq63weM1s8yeQlx
         ODTMOxlqBLRuml0PHSxQngt/9AX7NwITY+2VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680672; x=1794285472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ggqaj3bggsrUOqnPqyXrXYqxV+UfImDX5TnRZxULpTQ=;
        b=FuFDwGv5Qmq19csGPze39NnOfnXQ4oQHkAerI33WTa7dAvCUB12EKTHski7lOLxdKV
         /FsGJ1iVCRZPthfMofGkiCjFSE5tTGVzNm/vSeAmPMIt8kxps17PD30iNd3msX8/Fd3g
         79uZH/NmC2vxbrYQYda5OeI009U8PEflljxHm3k3TGbuoZSD1YofHFouiKFAxEBD0AnB
         avsSsOZvgPc5ljCNNcI8wPT7ZfX7McbnRliSiaZ0FhJKw/pPy0Kt404adWRBYO+X/wZx
         V+y3uIVaArTcjJyJnso8+jE6fPur/G90MIdy/jASMajQ7VDflvgTaCgXwHQRF1M31ePe
         Hxbw==
X-Forwarded-Encrypted: i=1; AKwUvBxf7Yp8tPC+ZfVn1BKtee3qttTQNI/tarxgiOEPK0Iduj5xsUAubgqob6VEL3tXa27ZmYnd59K0FxA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LNegu7mhZSmcYlszaZOBYR37evHyubrxLwcbZkN+VzlOYVLRM
	jRmnPG8oMZBW1kpmh4lPzMNYpTQOwG89yUNvYZ2U8+mPOebZMn9YO/l7kIxKg7k/nQ==
X-Gm-Gg: AYBFou1svDrSaO4cjqnFXLqQp/aqxxP0JmF10ifZgIxL68n1qmeEETE3MUDKgfdWpjX
	5W827TQL/48CCk4TRhi/UP24jlJ5kAT0xm7Vb7dAVk+ll1VTDVFFkra8RKl0enwHarzRcMp7voM
	yeN3FpV8o0kemtGMC2y3Ees3TdWCv/PQkRUTjGSrQvYTXxzCyPy8GUpV9NZdIYj1FazeN0cazf2
	cWqUMjF85F4Mx2yHTenufwZHNoNwElSVRefs3+ssMP5N2pejwMWSl2l+q742Pa7TEJKqIYnNgB8
	2/XhLny9BbFXrxC25xtoUYJq1oDgzoDQ8WxFpVp/MyS4uQzCtLH3J63at7PfgSnTNQ5OU6wwPhe
	Q898cLUQdAADYWEQiQHEf3HYfz/f05L22S7vUQAlChWM7b3itWf2sGacimhvLQG4R+7lH5sz40h
	F75wwBecYKHmlssGoNFBcV08PDOVoGQl2eHb5Yt0mzj2ur7h2TZ/o/CGQw+vrNbkQe/YGfbzfai
	tH534TFii3qqYSuQo42P5PY0kGXnvwwNrGYx/C8i+Ov/zXpKflrZ7tx5Vw/5YiYQG394qc+7zK/
	ubbMW0EoaV9VpSTg1svPrx2cHWKUO2yj7+tKGOykx7WvZC8/kG/wQAh4+s5XJtt/2n/i0IRHCxK
	D/Lqjq52WnfK4
X-Received: by 2002:a17:90b:562d:b0:3ac:8527:3fcd with SMTP id 98e67ed59e1d1-3ae898385a1mr9902090a91.39.1793680672423;
        Mon, 02 Nov 2026 20:37:52 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:37:51 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH v7 2/8] Input: elan_i2c - Wait for initialization after enabling regulator supply
Date: Tue,  3 Nov 2026 12:37:26 +0800
Message-ID: <20261103043734.2179858-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103043734.2179858-1-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
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

Elan trackpad controllers require some delay after enabling power to
the controller for the hardware and firmware to initialize:

  - 2ms for hardware initialization
  - 100ms for firmware initialization

Until then, the hardware will not respond to I2C transfers. This was
observed on the MT8173 Chromebooks after the regulator supply for the
trackpad was changed to "not always on".

Switch to the new regulator_enable_and_wait(). This makes sure that
enough time has passed since the regulator was first enabled, satisfying
the power sequencing delay requirement. This allows the delay to be
skipped if the regulator supply was already enabled by some other part
of the kernel, such as the I2C OF component prober.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Cc: <stable+noautosel@kernel.org> # needs new regulator API
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v5:
- Added noautosel tag

Changes since v2:
- Switched to new regulator_enable_and_wait() API

Changes since v1:
- Delay only if the regulator was previously disabled / turned off
- Link to v1
  https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/
---
 drivers/input/mouse/elan_i2c_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f5e505edbc33..4bbc6cef8be6 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/time.h>
 #include <linux/uaccess.h>
 #include <linux/unaligned.h>
 
@@ -47,6 +48,8 @@
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
 #define ETP_RETRY_COUNT		3
+/* H/W init 2 ms + F/W init 100 ms w/ round up */
+#define ETP_POWER_ON_DELAY_US	(110 * USEC_PER_MSEC)
 
 /* quirks to control the device */
 #define ETP_QUIRK_QUICK_WAKEUP	BIT(0)
@@ -1260,7 +1263,7 @@ static int elan_probe(struct i2c_client *client)
 	if (IS_ERR(data->vcc))
 		return dev_err_probe(dev, PTR_ERR(data->vcc), "Failed to get 'vcc' regulator\n");
 
-	error = regulator_enable(data->vcc);
+	error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 	if (error) {
 		dev_err(dev, "Failed to enable regulator: %d\n", error);
 		return error;
@@ -1416,7 +1419,7 @@ static int elan_resume(struct device *dev)
 	int error;
 
 	if (!device_may_wakeup(dev)) {
-		error = regulator_enable(data->vcc);
+		error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 		if (error) {
 			dev_err(dev, "error %d enabling regulator\n", error);
 			goto err;
-- 
2.56.0.385.gac671c819a-goog

