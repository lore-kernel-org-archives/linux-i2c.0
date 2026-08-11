Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80C443E36
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450858; cv=none; b=nHiKkQrFJcSfgbVgJJB45sVK+ZWQ9Mmn8Bgmh4+mGdo/3da2fyrVdur8I9IASnz/vxIf3lHCZ0EBm/UG4JHjq+pJaIDzp8Oedfkz6P2lxtCCDlmeAc77myGo8Y5AbdIO4bSy5lIkUIUD9cAI5GdLWN5XpeE2sd9L0VKDQP1ckE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450858; c=relaxed/simple;
	bh=eYYAZt1D/azsw9KiyzJSs5x1E12lPK58GJkuELjCTl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKbzjDJK506O7yeyrC8Iv5qiNrMeM/4ej0nC1JPqZYNSx+dilQawlLO7IuYaoCxpzUAz1UarerkaxZvLdIoKon9mfwUk1PxR6xbs0XfLNiUXzpGTy6jC/QVcvqd09Zg9yikBvBtdYsK/mN7afa11tUOLK5xHicb13HZfqHJ2VlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UmD2gsVl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UmD2gsVl"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8485b358552so469789b3a.2
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450857; x=1787055657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W0rjMz7r89FDG00LgKpSG7rJxKNH2nfPyMU32ONUt3s=;
        b=UmD2gsVlUCkjjjCgEhB1BENgxroVNIETQZHZCmnABrHU5UOkWXXEsRTLE2H6VlqswC
         Jwd9uk4puvmNyLdAv/+kOFXYWMaMEzwZVN8nDqoxsHFx15ilzAGsGF8XINHTtjhKO5av
         hQCaIKiV3T+hipr5e16zLCF9RhDKedg4OQyG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450857; x=1787055657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W0rjMz7r89FDG00LgKpSG7rJxKNH2nfPyMU32ONUt3s=;
        b=EsUezbA1tcQr5MqK2D1VgmpsxCl39BJVjBEDPW8ZefiA1al/kVw+qkuAdfjxMuEiC2
         H3JNxEZlLk2/WCfCXHi+QosB/K5VxRgrjzBU9Vw5hTOvFz3LC7ClvoqixRifz6jL/NdK
         mLa9Gcx/AOVXze9k3/Qo7H/9d08Cna+pci0jfeoXEegdEaxBFeTSvwwQalZSz4wokXBZ
         XCIdhOCy4IZ22qdTYiRum+XC37lHsSeXQ3kiY6JAhPS/9EmoloOkGq4rQ6p3+30wbJ9S
         +h4kOS5HvbfBOh/ftMG9Sbyo9SOrVlsF+S8CBwwUGkD4YZfyt4UEAma89wDOy2B4sRS2
         SNlw==
X-Forwarded-Encrypted: i=1; AHgh+RrEWOeLn1yuVrR+v+BSYfaHsQWFViGhNOlKdgOI3Wmktanjwq+ZZnrT7i+3XNti9b1vLAnbUlza2Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIykgkbUgrxf+8Wvo6cJ3xSDxFty00GEio0roTwtJlmvzEIeR
	Xs/rEWu6BoMvwO4jaEvl1damNUcrPqixf3rqtsncfT46lNx9MXKdDXUxBLUufot1Bg==
X-Gm-Gg: AR+sD13QOKC+z4AswGvblNfWqnNnVx0oPzKYXQ+btchqS4UgcyF0hMSWVlOFu2A+C8+
	3MymiT37WfqN5uZB14Gp/an1N5X1GArHWLdNzBjdqpuIHAu1AcRn0ySJEImeUicw3nAHpR/GLhl
	026S/aPlIVV4eO8VuffxblyrFXfUKWdbOWIu2ICzelfiFTPFBZFYcVMrc9WAT+8q7RM8SrVdW3E
	UXpKeQLV6Ckh3LpE7UyR4YyT9HBB+JSZXAm8B+KmLC62jKeGlMJbkfy0/erR16KCfzXe+JOo4va
	2p9AWRb1ieRGbJhLNHyP+f0BlmwrcGESoqCstdz/cDtz6nSTtIbrktqUpl23OPV2JQJkSwTYm7H
	dlefjRw+IOLeorIL7Lsu/xH31LXZgvnpyA31M3CWZVpCYlFV80ISCjWpz+elJIOyEQqlNGt3cD5
	YfTgZvR4Ezic61zqE/yCdMYC2OVxjb7yc8LLAPg81aUOYaKKutRWPVOzpk5Dqed+GTxnwrO+JWz
	eJhDIFz5ihcULpsu8LZi4a3knj1JInKM2fDedx7Jnl/qQ==
X-Received: by 2002:a05:6a00:32c3:b0:845:40d1:87fa with SMTP id d2e1a72fcca58-84fa873632emr3028343b3a.25.1786450856753;
        Tue, 11 Aug 2026 05:20:56 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:20:54 -0700 (PDT)
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
Subject: [PATCH v4 5/9] i2c: of-prober: skip post-power-on delay if powered on sufficiently long
Date: Tue, 11 Aug 2026 20:20:05 +0800
Message-ID: <20260811122011.3539250-6-wenst@chromium.org>
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
2.55.0.679.g6767b8d81c-goog

