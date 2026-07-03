Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E83CC31F
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079782; cv=none; b=Z0JS9ARJyU1SkMm2SEt8OICTKN8jQgNhXFSsufKapNsCP70PjlcGr43B1RgwjiA8VtTfjDvVRwQ+KfKuByoohrdGkucUyouojTQJFD5kRma76oRO7Nf3+XBHjpDcdgB0uvCmsf+RVcqkSjELY1vwmtvqKz+jvFYzwM4n7U1Gb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079782; c=relaxed/simple;
	bh=3WB9kbXi8DyC6RwIxVdplZ8Uu2gMCJjc4fYI7bbEIgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4MlnJUL4lSoPptpPFXlNk5eXIBOnU7U/flSpmf0P8asb6iccx8NbmlG/VBZB2GRsHxyIxqM6AopJTIbhGZub8JeBKZoPa9ihqOpzA1VCnRAprLMcxl/pAYwJc7bZX8p9AIRz6KpWP9reIu9Mztmdskn0ufhX/Lg+DuRz88Yy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ex8k8qtB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ex8k8qtB"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845eb7b96feso398230b3a.0
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783079781; x=1783684581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZuI6x0GxmbjrjyvyYJDyx48WMW5UeshcsiZCb+EBSg=;
        b=Ex8k8qtB0hQVtWNcMFxcxcC0olBLY33kVAxT2WEh9LpCGGZusORVfEsKnbhZ2vTv7A
         /zqKibvgFE7naCR/x8GulqYH+N8x8KcwCsm1KlWT53JUfuzRzzvP8gSyWn/RGzJqouqq
         pCaWvGA7VKLuOBMAvvH2H51dXPCo+McDzMFP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079781; x=1783684581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FZuI6x0GxmbjrjyvyYJDyx48WMW5UeshcsiZCb+EBSg=;
        b=olNizYCQPgLpa9IkQBJ1IoiOloRXmP62ZM8a0jhHLo8GrTAOPrkTCWdFLH/M11jNsI
         n3Momm5qL1j3o/OccpwlgiSTQGpNSiEbMdTgzyQl0J7/E1midbcD6UykJzh9PiMwIRJJ
         IFLOspAcLT+b4Lpp/MUR2LbZnZJZeLIW00XP0I6yc0QR9StYedOWI/CGD1QNwU5aQX6A
         f3/JCgV0JkOgi22s0xc/3uygoKkEjQ7EDvnXrb7oSIFk4An2bhUz2o6CAXrmmyffsD+C
         FobBpt6M6Qt/NEGFXRP4FsgQ96vcemh4qHpFdTq4DKI+/PCQlTlMw0WONAj2v+YfvfNu
         GkEw==
X-Forwarded-Encrypted: i=1; AHgh+RqMohaOIkU1HYs7htcuFiYREmsDkXL+JXMvDvhrwzkIx4e/IxvF6gSOwlFpq9esPCVI87MMCwPHDwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2kwHRrIrxkQf50ZvsUT4n7SAqOXEmOS/DD692e/mUwe6//kqX
	2LA8iT3IPJD8yiE2P+mz81ApxJ1bGJjYxgozEJusza6mmtRrVy1jzzdnpmPW4g3jNA==
X-Gm-Gg: AfdE7cnV0zLwGa5pAJ1QYKdHTRN7y99x9JaNOswMZlg72Jdl2bCiwbgTt0H7wVcDbHe
	RNpf5sG2uaP1M1P1H75Us8SlZWLsCvTBSXrcrD969HiWIezSh42vWxibIy2Yn7snf057z+7TSUC
	X1y4DH3LD5d+p977lilgz1g9/faov9BOdtrKsCpgZ61tfIsZxALpP3zfFMCaj4AB/4sEtDnUTl1
	kEwqcRxNp/YGfOFSuGO2PrsYzBfH4PkJjzoMzV2/vmrwXlz8XnfPqivu/uaNPB7ldWZSAZJr1O0
	hWxZ60Ahm2WgOZxfA+BtzVymSzNe/IswiI9D5gFGlvLKULRVh1PSRu8Vj83n1NmM99E1degwXba
	QhzNugalGvJi4/brkyLAcq8Cq/tEh0S15FmWGhtaDhzcIDpsXaco6Hnh5EHHmPo0HUyn1HzpkB8
	n3od/JnxE6IdEWwdbpTrXEZUTutz31VqR5qxaPcfsWkYuNT8SkhdiLqhJOGb9TtZDcJsmMbw==
X-Received: by 2002:a05:6a00:94c6:b0:847:902a:57c1 with SMTP id d2e1a72fcca58-847c0ab579bmr10089691b3a.57.1783079780697;
        Fri, 03 Jul 2026 04:56:20 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8bd30ca5sm2569540a12.0.2026.07.03.04.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:56:20 -0700 (PDT)
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
Subject: [PATCH v2 3/7] i2c: of-prober: skip post-power-on delay if already powered on
Date: Fri,  3 Jul 2026 19:55:56 +0800
Message-ID: <20260703115601.1323491-4-wenst@chromium.org>
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

On some devices the I2C component is powered from an always-on power
rail, or the power rail has been left on by either POR defaults or
the bootloader. By the time the prober probes the device, the device
most certainly has finished initializing and can respond. There is no
need for the delay.

In such designs, the system integrators tend to work around the delay
to avoid the boot time penalty by simply omitting it from the device
tree and the component prober. This is undesired, as the device tree
is not fully describing the hardware.

Instead, check if the regulator supplies are all enabled, and skip
the post-power-on delay if that is the case.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/i2c/i2c-core-of-prober.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index 6a82b03809d4..f274e260353c 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/string_choices.h>
 
 /*
  * Some devices, such as Google Hana Chromebooks, are produced by multiple
@@ -219,19 +220,25 @@ static void i2c_of_probe_simple_put_supply(struct i2c_of_probe_simple_ctx *ctx)
 
 static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_of_probe_simple_ctx *ctx)
 {
+	bool supply_was_on;
 	int ret;
 
 	if (!ctx->supply)
 		return 0;
 
-	dev_dbg(dev, "Enabling regulator supply \"%s\"\n", ctx->opts->supply_name);
+	supply_was_on = regulator_is_enabled(ctx->supply);
+
+	dev_dbg(dev, "Enabling regulator supply \"%s\" (was %s)\n", ctx->opts->supply_name,
+		str_on_off(supply_was_on));
 
 	ret = regulator_enable(ctx->supply);
 	if (ret)
 		return ret;
 
-	if (ctx->opts->post_power_on_delay_ms)
+	if (!supply_was_on && ctx->opts->post_power_on_delay_ms) {
+		dev_dbg(dev, "Waiting after enabling regulator\n");
 		msleep(ctx->opts->post_power_on_delay_ms);
+	}
 
 	return 0;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

