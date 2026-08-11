Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D444471C
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450864; cv=none; b=ISV5iVBWGe7ooAQjLhHi/ybem3gEOjxzXLqQynzzgVWljwXnzAwEHorWKcWguYXIQCuLj3mkmYrGlFSEF6uk1kt3qAA930hwLhHFbjUDdK5Nb/cS4A5fhwjH2XXuUkcQSUc8odyrrdbn8+B3NSSDhcC0WqpH/72z15xBG/Jthag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450864; c=relaxed/simple;
	bh=nKnUL7RA48eM39vIJpkkgut+B3bUEsWflS642HIWZWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5qXU1qo5KrvA6V9XdVX5uAiNWzx+AnrH5/5fc/vsEHrPmx0OUBSbaq4KYp6qTsd1oSQ3Bymoaj7HMvbyzvTdighHVoyEqkBvYbOGXSFPXXQl7mU96VPJAYDcEM8p10+/kKAvoi7KjNWh2zCbDJ+6TGgnkPSgNPHuAiwuU+SdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ekUT60pl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ekUT60pl"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8453427d3f4so3037037b3a.3
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 05:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450862; x=1787055662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vW5QGWu8BTDFFV87gdYCqNM0QrJMO5Ieo8Go/wJMx6I=;
        b=ekUT60plaDGMVpr6QAgLGWJNSkxFGZdx/cwlrcy5Y6rnZ/teyijKkrJmkfJPak01GU
         C0WamYKgufMc0c7Et0+598J1hXXaeja6tI7IuExbztAl/KVFWnH8MMQXAN2AdSg8Y9FE
         5e5sPc/ohnKrK9ZSQ0StH21SqZjkVGCXVv02E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450862; x=1787055662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vW5QGWu8BTDFFV87gdYCqNM0QrJMO5Ieo8Go/wJMx6I=;
        b=NQuxX+WoYHiOK2WHLtS4XvZ3GbkzOYNg/1x25IQoV0Roq7pksLcmh5OdK+09rkO2N8
         zj6mInV00dF/cycAQt6IGgmrWCFdWjwrGuqV02gxsBq6owiSuckFqZVSndw9UtWFVNZd
         FLcoBrfvyL9PSDNsH4azSkCDhZeZwiQokZT3wZrofffaT/ymToZHOzl19OBzPhXX/UWb
         iRlSkwy/WW3PeI/0uO0Nc5xokqxcL82wJpNFSJeGprxnGMUkuso+XM7VOHCzztu6QUi4
         yuYY8q5eHifsjcdzy1vHXzY5bEcZ0f6xERPF0PXp/+n+ryILyddlZgaV9EAN/gXXX85m
         uaaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4LS0E6rf44ERMOafjZMRkAf1iu+9UvLVd71o08n0l3jXvgG2ilyFpMmrZEJzFp53JFsGuAGnioIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtckJm3zEnRMSnxHRgJMIREsiNhvA5NYvBXE9EfjKUsetWRsTQ
	LOixvnxjn4sefVsAi9b1eNJi4KYxcGcluNNURkNf1RjZ+aecpmB7CVFhogZO6RtmPw==
X-Gm-Gg: AR+sD13JudNK/lTOjA7vBJvir1tbT6l75KU2aLiLPTdlDnKAE3UKdQ+9q85ArTFBV5x
	Y//cAyqeLPFUDZBwr2gb7aysWH6Em+coTBgcseWc1wiaddJ/SzpFum4zXnM1r/cdGMac4/udDVL
	I+5jxt/GtCigXPS5Qo+GuZCDATFC9ILywQE786k3KMaUbBA59VnwFNyu3wtDPXXfTn6/JoYIuoq
	TcXefgn8Xd9PrEEcMo0L+IgI54tfVNjZPuyGOr7xZushalP1/QbIjwakKghaVA4wjjWUT0OkItR
	Ix5NuQMeVhCLbsMZdLN/clZdsszT3Y3rIGYTxoGnkQ0Vb7tMAVn6f2gjhwp6kabjSx+HmK5rtO+
	/RpDmcVVo8TrIh9+NrkI5ueI1rDKAyzMhjmOEZ2oM5x7S1J+RJMiDassWRr/U4SaPP1P2BUYwvK
	gYrMynmjrHXQ13DGhTBjWCRszFbTz84r8qLkf4X4Rv6GF6BHYBe/DMTAUprpN1R7vydoWt5px7R
	l22OKt+TBPge89a74bMDN2pDADnBFFDZKqqyFJlPC41Lw==
X-Received: by 2002:a05:6a00:e1b:b0:837:f79d:909 with SMTP id d2e1a72fcca58-84fa889d2a0mr3074138b3a.39.1786450861717;
        Tue, 11 Aug 2026 05:21:01 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:21:00 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: [PATCH v4 6/9] i2c: of-prober: Defer regulator_disable() on successful probe in simple helper
Date: Tue, 11 Aug 2026 20:20:06 +0800
Message-ID: <20260811122011.3539250-7-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260811122011.3539250-1-wenst@chromium.org>
References: <20260811122011.3539250-1-wenst@chromium.org>
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

Tests on the Hana Chromebook showed that if the prober and trackpad
drivers are both builtin, then the time between the prober enabling the
device node and the trackpad driver asynchronously probing is between
5 ms and 30 ms, though sometimes there are outliers exceeding 100 ms.

Wait 100 ms before dropping the enable refcount on our end so that the
actual driver has the opportunity to catch and increase the refcount on
their end.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Added commit message section showing average delay needed
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
2.55.0.679.g6767b8d81c-goog

