Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E37C3CC9E8
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079787; cv=none; b=BQZ16bJLo4SL83XmzYcW1Ywr/2eEKf4XkJqVyj1Zp172mlyVllbd7N0Ecp8LTTAvmk3DU88uV1WgXHzr9souR1nlIks3tTnAZSy75I+eqfpm2aenWt9UUiKVn2La1S7JkvGUjOVqbn6teEzEVoHl7bkoyoMotB5mnOMlbYZyYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079787; c=relaxed/simple;
	bh=Pzcw/PU8fgEt1+CMQEaORchCpFD86JpQkzeAI5IPaoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vElXDzZ1JY6f403zUP9FGxKzHGFHsWkXs+awDfvIwDcQg9T8+IJBg5oM6XDC5f9FiGDHtrPtxn2tNyeXF423Iv9Zb54GEZDPPjX+15tjdHbGFqwGpbhhuDuxtMj4VLRIz4haJyley0KETUEcyLmD+kbXMeCwScxjcypiUnHeoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SXIVjV8Y; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SXIVjV8Y"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so358406a12.2
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783079784; x=1783684584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gw4z7buIoW/cUS61jHzCC4K3rs/jF8wPJIaBNozTAWk=;
        b=SXIVjV8Ydd10DkKxm4bhr/871Icc5Wkjem8Y2AJp9fiBxEi9K6g3MVl3naExdVT95K
         +8IoQiNVtZWq4PTohB6CQaAdQoPYlcS09QKEqdkTKIltc5RcKUn4bWZ/JXx92wuNhCBg
         nWYet+rgisV61t0mxdbjhin46kwJC0n6lk2vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079784; x=1783684584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gw4z7buIoW/cUS61jHzCC4K3rs/jF8wPJIaBNozTAWk=;
        b=jOEOtg8hPLeq8b+ixAPeCBpusC33pYtDRODHnQCtQGaCF7AQkp08jAM9VE4Y9AMWvw
         HGpWDlwqQX7pZyiNR9oqawv5wrr8DwLgBbnkrQO/s5RIEYEXeoW9v4Hs6QmMBHh8PeMk
         ZTnOnx7WPvTeK0kjqg8HByG0Z1VeVIDDQDSVnjt87BuhugUlKGHpvwFtV65NyDQpTnWb
         CKTIpD9bRtZL/aw+CXqRH42IOAs2V396iwydz3nv+KF6xmsFJvyRKrep9ymeJJ+m6RuW
         f0s5A+QI7Pwf74mKbwB2JMvMvj6L9Hpl0FJspud1/8X25em715/YHP4ZawJzQ288sIBD
         tRqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IU0bTypGQRYWV+5Wgd5iuMVk9xjLp6fVn/xAZh0Z2kkuCVQpblBixKOytn0yuU0TpqKIkTn53ER0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hCUI718FwDK+I4bK2J9wjaoyCFsFeGR4BdvIvTGJK8+TSxTo
	snqIZilp6XKUnNMWKef4Jh7aCb1xWQjZPyVXQ13zg17r43bzGcwB0f0pBvhp6l541g==
X-Gm-Gg: AfdE7cmeBAlqsl7iXtDPcEwUKlkVcSMHZpKcmWT6g4Ii0qVVQTVjBLqr78ycEvN8Y0p
	luhVRCWWdrShqZb39K7KocSH2OquhHjcZAoKNkxx8kuLBB7oPS00ISLqqudLgY7Pi4DYMWLXh2m
	oBtr9QN9EoXxhxbccUsBnZZ/5+G0jt3iBtWNII500O6XbzOs40xFcLDao24uP4/KNyymL+Ay2Vn
	JWFLCrujU4i12i2sDgSWWUOE3tuz7ozQnyLLK0lwtOoRq/6AnxCoTF2dIDH8u6oylCLrT8SxyfO
	7vMzYA89JlPAVtG3tVRbO17DY3fOBFc+4PKRcBqeeb2qRxbfhEpMCRxKD2v+qSb8sb8QhhJhrYS
	BSRnqG2kzAm9PItZG8R84J+agGii8CTozlDHlsiFwTd0ivF2t2ApTGzgE2gN+UcwqWXnchHbqPG
	8TctVv/CteQ9dsIV4nq0LEuyfPITOI/ebuXro9pbuNd0MlMMlat6hRiEbLxB1WR1fR4A5EhQ==
X-Received: by 2002:a05:6a20:1449:b0:3b4:888f:b3f7 with SMTP id adf61e73a8af0-3bfed474d94mr12242560637.42.1783079783900;
        Fri, 03 Jul 2026 04:56:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8bd30ca5sm2569540a12.0.2026.07.03.04.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:56:23 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] i2c: of-prober: Defer regulator_disable() on successful probe in simple helper
Date: Fri,  3 Jul 2026 19:55:57 +0800
Message-ID: <20260703115601.1323491-5-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703115601.1323491-1-wenst@chromium.org>
References: <20260703115601.1323491-1-wenst@chromium.org>
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
index f274e260353c..17495125467e 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -243,11 +243,23 @@ static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_o
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
@@ -364,7 +376,7 @@ int i2c_of_probe_simple_enable(struct device *dev, struct device_node *bus_node,
 	return 0;
 
 out_disable_regulator:
-	i2c_of_probe_simple_disable_regulator(dev, ctx);
+	i2c_of_probe_simple_disable_regulator(dev, ctx, false);
 out_put_gpiod:
 	i2c_of_probe_simple_put_gpiod(ctx);
 out_put_supply:
@@ -409,7 +421,7 @@ void i2c_of_probe_simple_cleanup(struct device *dev, void *data)
 	i2c_of_probe_simple_disable_gpio(dev, ctx);
 	i2c_of_probe_simple_put_gpiod(ctx);
 
-	i2c_of_probe_simple_disable_regulator(dev, ctx);
+	i2c_of_probe_simple_disable_regulator(dev, ctx, true);
 	i2c_of_probe_simple_put_supply(ctx);
 }
 EXPORT_SYMBOL_NS_GPL(i2c_of_probe_simple_cleanup, "I2C_OF_PROBER");
-- 
2.55.0.rc0.799.gd6f94ed593-goog

