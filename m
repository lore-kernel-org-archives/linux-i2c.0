Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162A438463
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620465; cv=none; b=WplZXV0/hE4UbXufOwb326//2wmkYNZIlgPlGWZWTWPRrSd2ZxFmZmgjmtGrIJSxZAFatiYKRt5ZQ6rs+UIq2uvSmwkIrIwI64Wj2aWC7ADXHt1ROh/4WJX1IK63euD8xxaD2XCdam3rc/6tYW8Q5AcY4Sc9YhQHByYc9JSzA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620465; c=relaxed/simple;
	bh=9Ni9zhrtKci5P2BRwTspKb8GrclLS+sUdzCWkor5diY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOcgApFZj8xZtAEpuNjfhvQxpgr0O0Yq6vsAJ67jFgZbKrgJcQ9ceuxYChJoh4KGHTy1szacPgN0nSpjLg7HMn31wiqR96rq8VV7lw1AL8m0InVG7vPSZbv+vqFLrK5MT/En1IxWCSBBWmUYXrhr0sOiiWbpV3VY9pjP1PMgruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jtCD3UVT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jtCD3UVT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cca0c5799eso87022525ad.0
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 00:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620462; x=1785225262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7iH2zA1ruu4tS3rL/ntmqLvjt6Xg4qydbdtr1Vk28d0=;
        b=jtCD3UVTieOZoQqULOsFiXtIiCoplzhCAv/fsA99FqyzfH5Nqxnw59NIdTh3ofLGUW
         qvtbHKYC16tah68FgbRWN1SeZy6kIrcsQ0YA06NLuzkN3R8jw3Nz4ISvdISJ+XV7U+73
         TRgTcJ+BaLButP4eeMzVzTttK+9/r0PnfRElI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620462; x=1785225262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7iH2zA1ruu4tS3rL/ntmqLvjt6Xg4qydbdtr1Vk28d0=;
        b=Yj3beDpOeeS419JxY1xfmbBM1yVWlC47yez8ePQe46aTWVUWsqy0dxg2Ia23Iz//E/
         PVPxfWyAvoYCHSymhJ+Nh36tijWjI63G7sKTJrIVYdR+HD3WW6c9HhIRcL5IV0NW8gNi
         dmrqg0INFWsmZxsK1++PSm2V0kWZHzpe6Uif6YdL4vtvASvKoShsLWxJB9uEvCQHFIQT
         hJz6e7gkA9Ai0Hon6+pWN4b0tBsUOFwlanQq+U1dnY4fFhivlouuFQFRlOAqWj1lGE/L
         nLytsvsVUP4mnsma/efMXOFca7GNLIrn2ma7uJByEGweHMtmx7NusYWgmhKHPUMSY/Dw
         CAsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXh4QRBKvTwfz08ChV+Xws6ZUyBD8xrVpLSLOkJwCgDXywcKohKXbHlmsteRXMTew4j6aRXUiKkWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOEHmopEApWwuqBN/bTYuR1cgiapSF6uKDl0UELjcUvdCkklB2
	UQp/m2ayWb3GprMXWGX25t3foM86tm8txXGC9ZioYGGqq36e4Zr1s5wSeifEu7SOww==
X-Gm-Gg: AfdE7cmlH7W7TL8QC5J8NkEaWUBNFaogcGW5QAcWsrKQml+quf/bBrb41qo30lY+L0D
	ahDTG46t3h6oUDsXyWeFfjdqJX7dEXdNRJWN6tq1Zoa/LRPAbZbGYcgvQsedzxVjWkvPR3aADtn
	cffwNnFJZhCihy3wZ1VhfHiv3EIBqMf4v8krZ4J809Gww+5eKPJbIOdUiAZXwP4dlVmrTZS0+2B
	+khRRWE5+KRQTKZQNA3kzHHAexGdnaX5BgjrYDYq1lZvPmaN8Uto1YgHkE9ibhqkJ+NbWCEcLDS
	lxTZGP92SPmZ+6iAuLuCSIZGyk2CTx+n+eMmnDC0YDP80zCCRqNh5HcC7G/WQmJ4/uofAIbBZ3g
	1d9JVgLrnrFeSBWkMYCS/MVVJ/VfNb7oASijnfWaQnKbtKYjiM2QqLzh/mZDusr8IhqZnG5hNSL
	qEtstFez7uflkqF74BCwQpJJ5+Bf2elr20jjd2VzvMc7uWw6kLWlyy2GRs2qQ=
X-Received: by 2002:a17:902:d586:b0:2cc:df15:91f5 with SMTP id d9443c01a7336-2cf34a2a314mr196331925ad.44.1784620462223;
        Tue, 21 Jul 2026 00:54:22 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:21 -0700 (PDT)
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
Subject: [PATCH v3 6/9] i2c: of-prober: Defer regulator_disable() on successful probe in simple helper
Date: Tue, 21 Jul 2026 15:52:20 +0800
Message-ID: <20260721075226.2347933-7-wenst@chromium.org>
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

When a I2C component is found, it's device node is immediately enabled.
This triggers device creation and driver binding. The prober will hold
the regulator enable reference across this part. If the driver probes
synchronously, then it happens within this window. On the other hand,
if the driver probes asynchronously, there is high chance that it
happens after the prober's cleanup function was called, in which case
the regulator would have been disabled when the driver's probe function
is called. This would then require the driver to wait 100 ms for the
hardware to reinitialize, even if the probe function was just a split
second late and the regulator was disabled a few milliseconds ago.

Recently, some of the drivers for the component that are targeted by the
I2C OF component prober gained the ability to skip waiting for hardware
initialization if the regulator was left enabled. This happens when the
PMIC has them on by default, or if the component prober left them on
after probing the component.

Wait a bit of time before dropping the enable refcount on our end so
that the actual driver has the opportunity to catch and increase the
refcount on their end. The 100 ms delay was arbitrarily chosen.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/i2c/i2c-core-of-prober.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index f9f3c0ef93ff..68c929b16b06 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -235,11 +235,23 @@ static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_o
 	return 0;
 }
 
-static void i2c_of_probe_simple_disable_regulator(struct device *dev, struct i2c_of_probe_simple_ctx *ctx)
+static void i2c_of_probe_simple_disable_regulator(struct device *dev,
+						  struct i2c_of_probe_simple_ctx *ctx,
+						  bool defer_disable)
 {
 	if (!ctx->supply)
 		return;
 
+	/*
+	 * Wait a bit of time for async drivers to probe and increase the
+	 * regulator enable count. This allows the drivers to check and
+	 * skip waiting for re-initialization.
+	 */
+	if (defer_disable) {
+		dev_dbg(dev, "Deferring regulator disable\n");
+		msleep(100);
+	}
+
 	dev_dbg(dev, "Disabling regulator supply \"%s\"\n", ctx->opts->supply_name);
 
 	regulator_disable(ctx->supply);
@@ -356,7 +368,7 @@ int i2c_of_probe_simple_enable(struct device *dev, struct device_node *bus_node,
 	return 0;
 
 out_disable_regulator:
-	i2c_of_probe_simple_disable_regulator(dev, ctx);
+	i2c_of_probe_simple_disable_regulator(dev, ctx, false);
 out_put_gpiod:
 	i2c_of_probe_simple_put_gpiod(ctx);
 out_put_supply:
@@ -401,7 +413,7 @@ void i2c_of_probe_simple_cleanup(struct device *dev, void *data)
 	i2c_of_probe_simple_disable_gpio(dev, ctx);
 	i2c_of_probe_simple_put_gpiod(ctx);
 
-	i2c_of_probe_simple_disable_regulator(dev, ctx);
+	i2c_of_probe_simple_disable_regulator(dev, ctx, true);
 	i2c_of_probe_simple_put_supply(ctx);
 }
 EXPORT_SYMBOL_NS_GPL(i2c_of_probe_simple_cleanup, "I2C_OF_PROBER");
-- 
2.55.0.229.g6434b31f56-goog

