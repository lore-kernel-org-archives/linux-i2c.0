Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27143636B
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620460; cv=none; b=MlXxuyfbiktSAruYEfaA5xrQax6PLqoFsinmOApJMBj51iwaLZ09FK6dFy95ksVXnC8m7X3sN4bJC9zyULS6x5//plWI80onS9Pd/nwNUF0DC+tHVAVkHmkqYH34YtBlvt2nRSatru/xpWIyGpa3mdZzHoGIw6UYBZqg5YVSOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620460; c=relaxed/simple;
	bh=v6GPocRuAdYXxfW5GCiY7PkoQqyVIhzeyfAlaB/90Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ConAskHiaZL4fM2+qHaIhoSdE++jGkKpGaFxzuysmQUcpZz1T+mTPp7fGavPU/xeokex7Wk9Or1/5MTOdGObzB2C7kD1pNjCZBZBUpgk+0DGCMRe1njHwhG2QkYtXCeuBI+DnRxlHTISilFvZU6qpsPnvonC9YdCTO6usoR8oFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QD/LPHKO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QD/LPHKO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso126390795ad.3
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 00:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620459; x=1785225259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwE3F1d5K76sODY+n24O04o43zDEBUUtH4OGbkRqhTY=;
        b=QD/LPHKOGNi2+XaBdLMGVgrUjfGg41mV5vzf5LDIL0lxu/nj+B8IiK4L7jv2Q6jqLy
         idSCOH5tFaGoXd08tPcjpA3XsK4McqhItPoWhaeqM1mmHcB5NQlTWcipQ/c0X87htmTr
         0wS2zOACOf6tn4IXzjpPw/leCVAUW5QjfVkws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620459; x=1785225259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fwE3F1d5K76sODY+n24O04o43zDEBUUtH4OGbkRqhTY=;
        b=qBZatMAh/enDqfx5wrgOqscYmFaaXKAWIBAkLWc3ZkxQh1KrHrRIKs6LYg+qyR6rWj
         MUUETvTOBa23Zblw0g+Q0pXXiTCKuFyAZszg4n7fwmh69qFjDKuUM5HI4sBKrW/HQL/P
         e1BuV9sg06UyfoRxZsTDTCIhuJugrb7ikcdchcP3nLl1CezIIDbgNSvCGi7OnMf5d6k0
         V1Nd8SZTK3CLxzgF9/oL8JtSDhwcZfC4d6dKBKVa9lsI5Geg7Twp1zaRJLjlBq697XBD
         saS74kVmT3rG38K8TvvLtYoRf7tVFDOgS7FXiiIp1BJXrE5nY/WMUZ9IgL46QAq2Z7kQ
         aosg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2RmjGybQNOKQLbRpWlDYMRtIL+jQTz3xmg0Ait9wC1yrJ50QgCdU37y3b0hsrOHOER5U5hL/i4kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCHWZIqbPXPhVdu603lJnJBxG+r/e0IWTtgut0r63M76Mjl7aL
	ZNIyAZ3jdlapeVbxJgpccT44pVN+wtEEVDFdGgnyHPLPuvRBEYRGXCXauQagCUQ+Gw==
X-Gm-Gg: AR+sD11OmjAzhAtkfsGtKHLl0uPIg92CZe25Hiao7aBsH4OH6995HKy9toNvcCTmgvq
	MIzwXfiUIE3FDAwFCKHQAY0CVz7aCc45hjjY5uKI3mc9hY40lMgoHSf9zZvLVY8O6Lj/FWgDwgW
	40dRL8jXEOkMnkE3+eGMsI3vYwU/mpgmHMxwz+ToL3srfrvI8Mq/yrEsvumgbbYUMHtdHoknH8t
	1NUlWp2AVkm7eXSP6nGTR+A7v+/3znOhBWcxPMchInVFgRgcVAC5vKvQJ1L5zwJFTjEfdc13JxX
	JB9vZUhszpws4HejPEceyIVm6dIi+kOM59koFCRUFSsZ+8H95M1XPMbDhYQKNft9wrc2oOxatHU
	26tySEhOxCM/YSxrg0XTKLeCc5Os45IZbJQhqOapzpdZi8cY0DonfQ3zE4ICXFwUWd7tFeULOc5
	a8fy4Mle120EQgHenKq4C/RKxELQ7k/xgl7+OLk0t/qemWYfP1WlrIz3FxpQY=
X-Received: by 2002:a17:903:1ae7:b0:2c0:e5ee:f554 with SMTP id d9443c01a7336-2cf34895672mr185287855ad.8.1784620458954;
        Tue, 21 Jul 2026 00:54:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:18 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] i2c: of-prober: skip post-power-on delay if powered on sufficiently long
Date: Tue, 21 Jul 2026 15:52:19 +0800
Message-ID: <20260721075226.2347933-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721075226.2347933-1-wenst@chromium.org>
References: <20260721075226.2347933-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some devices the I2C component is powered from an always-on power
rail, or the power rail has been left on by either POR defaults or
the bootloader. By the time the prober probes the device, the device
most certainly has finished initializing and can respond. There is no
need for the delay.

In such designs, the system integrators tend to work around the delay
to avoid the boot time penalty by simply omitting it from the device
tree and the component prober. This is undesired, as the device tree
is not fully describing the hardware.

Switch to the new regulator_enable_and_wait() function that makes sure
a certain amount of time has passed since the regulator supply was
actually enabled.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_enable_and_wait() API
---
 drivers/i2c/i2c-core-of-prober.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index 6a82b03809d4..f9f3c0ef93ff 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/time.h>
 
 /*
  * Some devices, such as Google Hana Chromebooks, are produced by multiple
@@ -226,13 +227,11 @@ static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_o
 
 	dev_dbg(dev, "Enabling regulator supply \"%s\"\n", ctx->opts->supply_name);
 
-	ret = regulator_enable(ctx->supply);
+	ret = regulator_enable_and_wait(ctx->supply,
+					ctx->opts->post_power_on_delay_ms * USEC_PER_MSEC);
 	if (ret)
 		return ret;
 
-	if (ctx->opts->post_power_on_delay_ms)
-		msleep(ctx->opts->post_power_on_delay_ms);
-
 	return 0;
 }
 
-- 
2.55.0.229.g6434b31f56-goog

