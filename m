Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680691;
	b=CZFNVvbj2UbtPKprT7Mm/y/NSr36L9EGLVm8jhuTxhdnYq+gqFbWu9xUyp938Ywr5x9R
	 FnAYC1LVWWz3Ps9NN1IAdo2g6mxwQ8LAhQTUjIjFrFZxqGRqoNFCdMsEz5pdv5IdUrOUz
	 zV1DiaxPzmdNvgnkCH94LbR/UPoSImCxj5cBQ/whDzYL9QYHWRU5aeY7StBSwKJ8TjF8G
	 OZGkwOkXjiwl/x4YX08OFVzFMgaSwXIkNnzIXs3zut/tUoI1/nWU3eRIDp4niw+v6hRcQ
	 PYlqwEYjIBaP3J7GEoriPERQTncvXQ4EV//uA9I3nS14X0pcA3nv0bubuEhNSkuK+Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MIuVuN5S3A1ntm2yRRAwtrIs+TTbfraz8EmH2Z12duY=;
	b=i8y/e7qsIYBzWTYcLAbwGWA88KiEBi6+AxWCNaw1qB8RxIZvFP7KJMNSGyVnHEIutyfW
	 L9lsDdJmhFzn9p0y0Mpw8VP6V7+2adh5Z3OaFAz13HmSWrPJ6CtIRYCeyMc+iwJas9VOw
	 8wMUwSfbNK0JYv/4by+AnIPgArt9F8Sr7LC+lx1DkJHDR7gd30Ak4iYXXDklvkLrSCit1
	 csTLL2BgeMCLX2Adi3AqhzBK5PDGGV4HCNZ0mzGxbQoFUXV6VXhSl03t9nK8gye2VTaKl
	 eDuNUAUcvYovBRKo3DzLYP3ez+Tg4+UmwSNbiGAMH/ejT65RniZI54SuoFXcyQcnYmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="m6KaD/VR";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102E606A335
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 04:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C102E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=m6KaD/VR
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e831e86ebfso22592955ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 20:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680690; x=1794285490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MIuVuN5S3A1ntm2yRRAwtrIs+TTbfraz8EmH2Z12duY=;
        b=m6KaD/VR1u/EiXpoMAUiBnXKyF9mMqN8ys9NKlBlxBXtj5TCevCyWx/nGum2E3muSU
         7A49V6moGBmBJ6IX5nEVF7u1AMj495jwdTWkvaW9uhqkcuwbcnqKeWbWjMk5CpaBaIHQ
         xhD2dHPWuaCTQXbj211R8vuCuC0mD14d2edXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680690; x=1794285490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MIuVuN5S3A1ntm2yRRAwtrIs+TTbfraz8EmH2Z12duY=;
        b=tHcrLogKS882zlrrk1rU7QEu+iL42ld7g1EWwCQiB5xuehkp3CpkQBwERKi8vlpWpx
         OOYSJTUy1fuY0WSWmHWxBTrAKVF6TlcKAa2TFki8fD/DFlh80cgCo+NHfjaS6clrYaGw
         zYvxhnk1aHSUHX60ICgrl5RDvlSCXsScELQaF0RId1cB+q05aHGkuhu3xW3XlpqWkQCF
         xCRAQiYLsTnX01q/Ym7ipPnzNf6Wn+Ug4WFFxcy8G6FJOrDSMBIg9/PhNZyhe09R39QY
         1Ws7NMhn8yeZBRBJTUr4h2ME1zS3h1JSAnQMPRvPiLdDWgUYzBCAsPjop2sZ2UZ7lkWT
         49dQ==
X-Forwarded-Encrypted: i=1; AKwUvBwtJPG37fekwRcsSplop7jxCw6fM+ExC8r8gN2kN55m87SVzT/HVre1hnA3ocEltRfJWwwXbhvRp9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dNw2Tu2E/f4Flcc5c0sDDIZHv5xIO6Q7IdR526jPEMiha4msS
	NWkZXTeAD4gfJT0ntcNh69vl9O6ReiovRfPUyQQOr27FUuzUWLUXkM9mO1npZ+cmSQ==
X-Gm-Gg: AYBFou1y3eDl+krZl0Xv4/Xakn9ZX4jAEyRyskbhFI+F2ROr/Fd7t5Rlm3ct1Z7vA2S
	Gg97hZTD0BQCk5WYY/KVv1Db7qW4nbqor4R8113Ab6f/DyjiFc/gIg3R4NhR6XqimGfWoEzxxOn
	lcXcjf2xIcXCeqMAh1aOUSTFfmF2vcRjM7ebKAjLrczpV+VNPLjcSkiXmlfVipJmF+faGEmPHML
	fwlbxoVRKBnZvu1oYXN+4XrSRfSSXwqSQ/bqy37P9v2nrctZLj2ECLmkPlxh8OtC12aQ8nvOqDv
	z8JCGtpSuGZwLims41CERC+MpmRZrYqTEmtYz3kug20XWFHupoAsMNV5l+WmpukkH4+OubAIbI6
	LMDXvpNCUEzfM2IqRdQhNAJrlH7aP+2Q5/OFczt1SEfqK0V6EReDFC6spEJjkcocuroO+tGdRis
	acShPlLjbT0uMywHB9XDBfA5z8eTLIPrRuFmz66JTivnFM9LymYy4ChMuSohwS41pOrapQoL1wj
	1upDoByJS/b0O4gSAN/MgMhhmc23T3DG/e0zjqKX3mxCHLWSJniCopNRu52dAnyFkXLvQxsEuEa
	VQnHuak69yILFyTaDOSNL6+0rwvLmJ8tNf5kVPW2eIVDbyRnX+zXYJn6g0n8wGXUpYlwd7eUE5p
	vbaYqOpojCLu9
X-Received: by 2002:a17:90a:5d17:b0:3ae:898e:a123 with SMTP id 98e67ed59e1d1-3ae898ea1b4mr7369616a91.14.1793680690189;
        Mon, 02 Nov 2026 20:38:10 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:38:09 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/8] i2c: of-prober: Defer regulator_disable() on successful probe in simple helper
Date: Tue,  3 Nov 2026 12:37:30 +0800
Message-ID: <20261103043734.2179858-7-wenst@chromium.org>
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

When a I2C component is found, its device node is immediately enabled.
This triggers device creation and driver binding. The prober will hold
the regulator enable reference across this part. If the driver probes
synchronously, then it happens within this window. On the other hand,
if the driver probes asynchronously, there is a high chance that it
happens after the prober's cleanup function was called, in which case
the regulator would have been disabled when the driver's probe function
is called. This would then require the driver to wait 100 ms for the
hardware to reinitialize, even if the probe function was just a split
second late and the regulator was disabled a few milliseconds ago.

Recently, some of the drivers for the components that are targeted by the
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
Changes since v6:
- Fixed typo in commit message
Changes since v5:
- Only defer regulator disable if a device was found
Changes since v3:
- Added commit message section showing average delay needed
---
 drivers/i2c/i2c-core-of-prober.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index 97ef58bb4c04..f52ab3f54933 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -238,11 +238,23 @@ static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_o
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
@@ -359,7 +371,7 @@ int i2c_of_probe_simple_enable(struct device *dev, struct device_node *bus_node,
 	return 0;
 
 out_disable_regulator:
-	i2c_of_probe_simple_disable_regulator(dev, ctx);
+	i2c_of_probe_simple_disable_regulator(dev, ctx, false);
 out_put_gpiod:
 	i2c_of_probe_simple_put_gpiod(ctx);
 out_put_supply:
@@ -405,7 +417,8 @@ void i2c_of_probe_simple_cleanup(struct device *dev, void *data, bool device_ena
 	i2c_of_probe_simple_disable_gpio(dev, ctx);
 	i2c_of_probe_simple_put_gpiod(ctx);
 
-	i2c_of_probe_simple_disable_regulator(dev, ctx);
+	/* defer regulator disable if another device driver could enable it in time */
+	i2c_of_probe_simple_disable_regulator(dev, ctx, device_enabled);
 	i2c_of_probe_simple_put_supply(ctx);
 }
 EXPORT_SYMBOL_NS_GPL(i2c_of_probe_simple_cleanup, "I2C_OF_PROBER");
-- 
2.56.0.385.gac671c819a-goog

