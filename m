Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680687;
	b=NtrkiLSJlDQlgqshXcsR7UMm7CPDih8v09/ug0i3KlMETz+Yj7Wl7LsGRhEmRiB+9+GQ
	 jINOpE3fiEGXwvzPouD3FivRS3yc6J0GAz84Ywjl94gWkIUE/5Pku4VZYoOpVdu3dpilR
	 fOS+6fAUTw0y2kSf/JeJENlTPdyAXLw8cH4u7AweKuKc6gK6z4mSPZaR8ql7j3voNiqNE
	 1TOX/HGSdFDxfpuX3uSGRPdE+j+yE7PDPtHgoJmvPZ/3n2cGani6f0SAGyISoEaaZuhlw
	 rprFvhPfLDouyxLKIoCp3Ihq6N3JdQ6NgWc1NTxccdX+i65nzCaPDhV+2RDotBgpLUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=h2GPV8kPMdAQMoqvFZFNAZKoDNH2JuPpdXamalsnIvU=;
	b=HL4vjzNwPHpnzHe/h/GASSTyCoiHfjUWdbPLk0LVaYox6onKfkUhwLCaOZ4JrxWNsz8T
	 0HRoCkCrou0u3n9Ezgg+2FtiQB5bOKzWk0Ij7PzYB9z//pnkkNMj6nnXGMwxPl9wsl+4m
	 9hKUu1wrH0LTKLIDC8h0LcndCe2e3/Dh/5dfuZM5ptuwoL1Q3oKPLW2NCaYnb2pxLMgE8
	 yYCylKQSJg8wKo5CqTLUo6BlDyWG6G1naLlp9KVTg+ZrobtLb/FhrqsiOzQTheo5+LCuN
	 XgbsSEf7nRia8n/HAkobETUOevcWiQGO9bIogLRwaqDh+R6VsF33FLowMcJ+m7leIJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oLSMcA9W;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C033606A332
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 04:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C033606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oLSMcA9W
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so635668a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 20:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680686; x=1794285486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2GPV8kPMdAQMoqvFZFNAZKoDNH2JuPpdXamalsnIvU=;
        b=oLSMcA9W3IOpt9klu3M+RevOG4/HcHBTfA0yEM6xVIUXFeUd6bjAZ0+mmKcxRr83st
         SPucrPPbzXLyOf4jyjpRoZhJXMkZhQecbEGnmbFAioBSHjVS9hgmo9kxu9B4BgQkHu6l
         3pzjjeCjka3g90UB83kNZSoT8293LPKvhbQcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680686; x=1794285486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2GPV8kPMdAQMoqvFZFNAZKoDNH2JuPpdXamalsnIvU=;
        b=yjt2q5KyNG3OYXK4vL1sxGV5F6TR0Jxg2lWZE3Q3cEflcukdw4mmnj4YC3gBJC1kz+
         IYegpcZGFa8NrqOrkdYUtkmPoHRjOzEWsNHcsFvyxpOoTc3BGTaw/y/eRXTPKIAbi4c/
         xo+1GgWwnExlo+ME7Sqjlm3WcyJ6NM9MZzPPGdF5Tl3ZTHb7VNAGSbZytQ63AKkykpZd
         scLxLT9e5vJWF+7w26yCAjjhcHQzH/xRMuOH307/0aDc5x4V/2K9M7FZNlqlg6Xf235X
         G2vcCkx2HQ4vcLl03+42KkBWJrM4Bu9fusQXSQL3YTjT3d4Mkve6jWBVJfKuToxFn45u
         e+Tw==
X-Forwarded-Encrypted: i=1; AKwUvBzyxnEogUANWk211IQooeY9EjselrcuegRUyycVyjkM3tPEcNX1WlC6vMgMC1dnvuGpGRDsoNwOaCo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wn/gssFOMBGHQa0SltiLfwE/vTuQf54w2edTxyk8fr+na/vgj
	btW1wNV+pR+KJKjP4EWfmlyPd0JLdqBBBRZodJGR+ivJmdCSDQT+RzU4ESrZV4go1g==
X-Gm-Gg: AYBFou3mCGrkVOCItvVHEVEF/XfYi/atc8iJPWeQb+gaitrFxglaXBxius3mdExLRM1
	d9IsM2o9HQscGUDJSWUQx1vLT5gxQdi7ucj9auhAHXZqE9QVuBscni/CoeOWgsYvZAAo99fp1mt
	xaz6iyLsGYTbEd7QLXIqs2t4shRyzj8TANJwNVxYGZImXK7+R2Fi1n7iyeHwF1pRT/bMwHokpFD
	X+ZiRRV/sd1PK50nussAL6viF3zFKs7C704HSZb7c9hLDNKpyraXUS8f52wByxEYY9YP+0iJ3t5
	QxUPfCbESPM6hC0nUMId8UFk9pN7NIJ37/RNEmm65TbLdwzUvYj3az02Yqkkn1whGfBhniRPHFg
	PUisA15XEPnAMhSWE9+MLhkWui93xGo0Svgm4fhCC/Wlzamo2M+qOnPE2RzXkczsMZzX+Qqi5+v
	VAUR7hGUognB5pohM4ZJA4aMiMcX8yA/bBGybX5lBBN5ZPYh2oR6D9PTJ5pbNnOlDqxAP8EU0i0
	UfgxM1KtDNLgZWpTeSx0UHey9cDzwTOhkeNnkoNzxdveWTSg6zpl9MPLYvxxKCiatwTU/Dsq1rP
	KkGtcDmLGPm3dqhtUzH4Db3DaLUtp4XD1jC9KJfaB7vy5tDh93ma/1B5DcwJ/hQuS0zqjAvPkqD
	Y1ztv1P3m2pd8
X-Received: by 2002:a17:90b:1b0f:b0:3ac:a5ff:2cc3 with SMTP id 98e67ed59e1d1-3ae8957d4f8mr10310774a91.8.1793680685963;
        Mon, 02 Nov 2026 20:38:05 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:38:05 -0800 (PST)
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
Subject: [PATCH v7 5/8] i2c: of-prober: Let cleanup op know if a device was found
Date: Tue,  3 Nov 2026 12:37:29 +0800
Message-ID: <20261103043734.2179858-6-wenst@chromium.org>
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

The prober's cleanup op may want to do things differently if a device
was found, such as wait for the actual device driver to pick up
resources.

Add a parameter to the cleanup op to pass this information in.

Also fix up an incorrect reference in i2c_of_probe_ops's kernel-doc.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v6:
- fixed typo in commit message and comments
- fixed missing parameter in cleanup op type declaration

Changes since v5:
- New patch
---
 drivers/i2c/i2c-core-of-prober.c | 8 ++++++--
 include/linux/i2c-of-prober.h    | 7 ++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index f9f3c0ef93ff..97ef58bb4c04 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -130,6 +130,7 @@ int i2c_of_probe_component(struct device *dev, const struct i2c_of_probe_cfg *cf
 	const struct i2c_of_probe_ops *ops;
 	const char *type;
 	struct i2c_adapter *i2c;
+	bool device_found;
 	int ret;
 
 	ops = cfg->ops ?: &i2c_of_probe_dummy_ops;
@@ -159,6 +160,7 @@ int i2c_of_probe_component(struct device *dev, const struct i2c_of_probe_cfg *cf
 	if (ret)
 		goto out_put_i2c_adapter;
 
+	device_found = false;
 	for_each_child_of_node_with_prefix(i2c_node, node, type) {
 		union i2c_smbus_data data;
 		u32 addr;
@@ -171,12 +173,13 @@ int i2c_of_probe_component(struct device *dev, const struct i2c_of_probe_cfg *cf
 		/* Found a device that is responding */
 		if (ops->cleanup_early)
 			ops->cleanup_early(dev, ctx);
+		device_found = true;
 		ret = i2c_of_probe_enable_node(dev, node);
 		break;
 	}
 
 	if (ops->cleanup)
-		ops->cleanup(dev, ctx);
+		ops->cleanup(dev, ctx, device_found && !ret);
 out_put_i2c_adapter:
 	i2c_put_adapter(i2c);
 
@@ -388,12 +391,13 @@ EXPORT_SYMBOL_NS_GPL(i2c_of_probe_simple_cleanup_early, "I2C_OF_PROBER");
  * i2c_of_probe_simple_cleanup - Clean up and release resources for I2C OF prober simple helpers
  * @dev: Pointer to the &struct device of the caller, only used for dev_printk() messages
  * @data: Pointer to &struct i2c_of_probe_simple_ctx helper context.
+ * @device_enabled: True if a device was found and enabled.
  *
  * * If a GPIO line was found and not yet released, set its value to the opposite of that
  *   set in i2c_of_probe_simple_enable() and release it.
  * * If a regulator supply was found, disable that regulator and release it.
  */
-void i2c_of_probe_simple_cleanup(struct device *dev, void *data)
+void i2c_of_probe_simple_cleanup(struct device *dev, void *data, bool device_enabled)
 {
 	struct i2c_of_probe_simple_ctx *ctx = data;
 
diff --git a/include/linux/i2c-of-prober.h b/include/linux/i2c-of-prober.h
index bb6d47f50ee5..11f3a05ce881 100644
--- a/include/linux/i2c-of-prober.h
+++ b/include/linux/i2c-of-prober.h
@@ -45,7 +45,7 @@ struct i2c_of_probe_ops {
 	 *
 	 * Only called if a matching component is actually found. If none are found,
 	 * resources that would have been released in this callback should be released in
-	 * @free_resourcs_late instead.
+	 * @cleanup instead.
 	 */
 	void (*cleanup_early)(struct device *dev, void *data);
 
@@ -53,8 +53,9 @@ struct i2c_of_probe_ops {
 	 * @cleanup: Opposite of @enable to balance refcounts and free resources after probing.
 	 *
 	 * Should check if resources were already freed by @cleanup_early.
+	 * @device_enabled is true if a component was found and was enabled.
 	 */
-	void (*cleanup)(struct device *dev, void *data);
+	void (*cleanup)(struct device *dev, void *data, bool device_enabled);
 };
 
 /**
@@ -131,7 +132,7 @@ struct i2c_of_probe_simple_ctx {
 
 int i2c_of_probe_simple_enable(struct device *dev, struct device_node *bus_node, void *data);
 void i2c_of_probe_simple_cleanup_early(struct device *dev, void *data);
-void i2c_of_probe_simple_cleanup(struct device *dev, void *data);
+void i2c_of_probe_simple_cleanup(struct device *dev, void *data, bool device_enabled);
 
 extern struct i2c_of_probe_ops i2c_of_probe_simple_ops;
 
-- 
2.56.0.385.gac671c819a-goog

