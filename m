Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006FB470EAE
	for <linux-i2c@vger.kernel.org>; Tue,  1 Sep 2026 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249011; cv=none; b=ah3w0wuCjv00evMw5i7cPWJQAhcdqB0Kphpn49HlWnSQuqFZSDAC1/faHEr1f5vhiPZ0RgMQTFxCs2aYVMjOACE58ZIcZyK6pDco3V+5C/GL05VKgYv+pOHJZkSEh/FQFJ1sVal4cZAjPFX5TPYKwF+Nz37MY11inoMAc8IrGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249011; c=relaxed/simple;
	bh=6ab1wCEQP5zPcBfT0PBKodK0oU1IQzXD1fGtvF3pHJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaYTDmbZdmTcRMbRJ4ynDnI2rVJ12ggoqR8+czuMXBdJgA9yxO4zWFAThOsiBE2HfjAoVlCEI9dSw/vtrPPISJeWShYHSjhzMUhBfy3Bt7Gq1/EGvIFUE04qm2TY4TPpTuP85k9xT+FJsSgIYLVIRRP3mYmIgxkWSCu22bp1lmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GrVLjJRT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GrVLjJRT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d71a50caa9so7539625ad.0
        for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 00:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788249008; x=1788853808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=377z9agroO9vgw/MPipyApHAj2rPTrxxSFp/0FEh+cY=;
        b=GrVLjJRTUdU/jzM1vH5Wt5/vZikPdp2veR7YQ4ZPfhm11Vzid1cb2wpTIFi7MV+pW0
         5P1nWbZ6I1p2r/lAKYLDXRCcfqoA2dSYcVjDmbl+AXMitvMzAjOgIVvdCXZXJBa8LKaG
         7j+G0INHwm6iHmVC1S13o+0u1QLKzbg4eGtac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249008; x=1788853808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=377z9agroO9vgw/MPipyApHAj2rPTrxxSFp/0FEh+cY=;
        b=lutwsMrrMFUS6VbFCHxb1YoeLgEaKXXdE4wLlnq+qisRyiicBDW4vNEz/2Uz7AmTYz
         Io6QxPJrbR5TuRSs3OaXrnNT36AgCZ08BQpnjS7AhuA6o+pFlxT/Ahoc380MzEL8WyzR
         R4ADVQElia2buz6OmUP+oOsJ8bIKdjrRcEkA5JaLSaWeR77Pj2ZoYDTmCSSnkLsi3amT
         BH91iYkvRVpVu6juhkM/z14UOG8nI3vCuP1epjCjwV/EiYBasd2McJjwkQze0k/X8RgG
         iCsKBZuwtMN0FeVTzSEJf9xQgpG5E8ZN5er8qYBDhrNKQj6srgOQNUmX4f8mEhSexlYv
         GVoA==
X-Forwarded-Encrypted: i=1; AKwUvBxoxkiqS4y/gm5FTXSxzPFzzpc1Q/L0l4xTm1+3kPKn2NIUuW0SouALc5Olo793om+nbHAtjEt4RpM=@vger.kernel.org
X-Gm-Message-State: AFuF++n/+NvJu3aH/bA7CE0Iaq/90yGrRCF4OKL7watET9Xx58k6Q2Jv
	2++DRF4QonCkYps8uDorQWD2SOzgZti2jfvpK4rtzyaAvJ7FAAirYx9K9MYGsJ8ogA==
X-Gm-Gg: AYBFou2CFQ0kDhFVvzAaA7dFyTBqzpW5pw9hG/Uq5MLDQop98OLGTPRoH3odK/oaf+c
	28qJwxV5ch66n1bJr032Vpo+uvz7y3MEot2t09KnMp2Lew3UZWgFmANeFf30LNo+IL3HNZ6nUE3
	lDxotwF4pkw/gaFJjxcEQeUDTIRB+GDyeTkhsib89a8XeFqDR6Zh7rP6wIx2QzwB32Px9JXDqCq
	sKpNOTYNiq3a26Qk3hjOdjKbQRf6gnrOO4Nk4wLbyoP63+fGk7C9UwNhOKsEjQEOYtxmTv7Hd/Y
	4Bm+CV9kAkqRHyipUG9LPkHRyZqva9e5vnLM0PxsjMwU0hJQUOUzp6i9iggK9mWiBc0K1QCd5Jw
	Y1esD8Zn8HBW+MmPLFElhPtUHsMOArUXU6c6mD3NxbtGNqqkPQi0cGKNsRbJLupgBerq8hSNQT7
	A70HaYu18L3Tgnl9jVAUM/uPRUG24WiQljn0s1VgPxBHaXYsCbWFgfEdbsO30J+kUVrHN6c12XW
	dghMLAQk1FiOMydG5bPtEeqroAGrAYgIGwO8gsIV1Y2KA==
X-Received: by 2002:a17:902:ef52:b0:2d9:383a:30f1 with SMTP id d9443c01a7336-2d9383a326bmr139940935ad.4.1788249008298;
        Tue, 01 Sep 2026 00:50:08 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:8cf:6df0:9c4e:f5e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b699sm48142515ad.59.2026.09.01.00.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:50:07 -0700 (PDT)
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
Subject: [PATCH v6 5/8] i2c: of-prober: Let cleanup op know if a device was found
Date: Tue,  1 Sep 2026 15:49:23 +0800
Message-ID: <20260901074930.764550-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260901074930.764550-1-wenst@chromium.org>
References: <20260901074930.764550-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prober's cleanup op may want to do things differently if a device
was found, such as wait for the actual device driver to pick up
resources.

Add a parameter to the cleanup op to pass this information in.

Also fix up an incorrect reference in i2c_of_probe_ops's kernel-doc.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
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
index bb6d47f50ee5..f28a40780d1f 100644
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
+	 * |device_enabled| is true is a component was found and was enabled.
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
2.55.0.897.gb25b4bd76c-goog

