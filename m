Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C9470133
	for <linux-i2c@vger.kernel.org>; Tue,  1 Sep 2026 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249006; cv=none; b=nwfM4l+xXWn6KUtl7qAclVCmg81ENZDlpqEZoTAaJwtNCTrO2TRRTsTJxqbVPwslr1g8DS2NCZ6CD1dMNFjmFkUS0dIfsMmT575pnOOzVWL6ehLcIt4Xz8wBr7HhFGgTJ5HaS1Dz1COYiGgXETSwv7UZMhr0my0UmOuPyFXSVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249006; c=relaxed/simple;
	bh=SPcW+mZp0p9SXTvYafIM3g/Oq10MKnc+TqcPitNlh8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbVBVSrz4c0vpaQJ4wH/kpEEYTKt5d2vmba530VZBStFHjCkrfktK3+8ZLRY/h41W0cuztqRSERK4dyJHTGHvHFKf8tph2b68l123leOUBicp1uhUFkONDqbe9AIAQdwivj5Z97LLrXt1jSRVhu0FHZ69UFCIXzC1SssjNW7YYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zr/ZDFJ3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zr/ZDFJ3"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6f9e2f681so42961885ad.3
        for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788249004; x=1788853804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lkkm1waPZ+HrT9oYZpgc7xZ9xBFanNK2vNiOpJD6Fs8=;
        b=Zr/ZDFJ33z6iPtyMTtb6LEYHj0DKmGGV7xYUfeiTEx1TN65aGbYzIn6Ngx3GZPMBvQ
         kj0GCrxvwIRzY5r04DMSTdmuRiWaGs01ehvy0ynLmhArjdZ0pOMXwePMKcFPMg9vJ6/t
         PqEIK4SyadtP2uOUd+VAOc+pBrpLA4rMXCUaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249004; x=1788853804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lkkm1waPZ+HrT9oYZpgc7xZ9xBFanNK2vNiOpJD6Fs8=;
        b=rxrj7/Nnc+X4dSrglqWY+XJnweWnHLXGjttPbowNzP6aNSt2StdgnB3tBVx/k1YAll
         afy8gKfn0OHZU0ADIM1ZeePIEiCB4bIidXpceD5duUZ5CNmmDIeeoRPyjEPcG6Ozn7Da
         jAP4YWoTz437aZobHUivb/J+u19IYnCjBgC98vSNnE2+h524QcmnVadlWPB0Hu+p4AoQ
         34BCe1mleLOdTykBZ6y9GvSkrsnO41UMbmsYFOsmP2LfyfHNcGf3QYhWDlwuSL1RUx3w
         1ayTly0bUcwxPDq6FaPleV/wYeYZN//QNHAmzNN4t5Dh+iVPqE7dHi3W5EJIZg4TMmUT
         43qw==
X-Forwarded-Encrypted: i=1; AKwUvBxItXYVyaxUPSoF6wPnyl27myjjrPLhky3UFHMbuTLo9mGbysM3N8zu+7kGEyHKOUM5GK97MkxiDuU=@vger.kernel.org
X-Gm-Message-State: AFuF++ktw/zyQP8qz9l89aqudjB36LdHyAzdgtQpmRqxDSqA7LeOIU0f
	Zc/M18tz91kNnqespt5XFKerx13o0Lp1C8fct5PUnKkyBE4gxX8N9nrRv0cOpdTNiQ==
X-Gm-Gg: AYBFou0bvTe7+xKlgUMyZXif3Aqq4oqgvxpKY6QJ9fSfUzA8Hc3xWYntStJWdGtoTnY
	C2Typ5fZiCOt7WyscxazdZtOQudQsEYuArybEhPiz4GbHlMBfFcIk0scXqs8tpN8J4XpIaxxzZS
	wKE+ris6DqFcZOGxSVBy/D/1q2XsCeBhaZNCcuOZteH8S2/5LOS/k9+ii3297MfbABqBNiiD6ks
	tTIBl+LfU40yIIJJ1Mi0G0vcODackNDFJU18xCCGa5omGFrbxIseRDW+J6aM66PPuIc+O4+N+GS
	jvexOqSu1HKYMishhP28/wna/AlmpjGJrZYHj+XdLkrEMNwt7PVv9cLEFPUCUEglqmrLCdOs/im
	HrrFvmcrQNj7PcVYy1VMSjrkLirpHtrUU3V6PJtljMFX8Qk6Eu5QIZWg3Xi063QUk4gOFUmQAyZ
	4mBH8cCXTN2w89UL8p6rlpU1VtQ3QA58BF9OwMkC/Egktt7IRjUCRoireJOGqDRhZh/k2DUSPxk
	RGErbAaUJnyuDBmSfOLtXfFYD1g9U+9WGmN4FXSBa39lw==
X-Received: by 2002:a17:903:3d0f:b0:2d8:d4ce:7e3b with SMTP id d9443c01a7336-2d95d5fc28amr40543015ad.16.1788249004522;
        Tue, 01 Sep 2026 00:50:04 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:8cf:6df0:9c4e:f5e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b699sm48142515ad.59.2026.09.01.00.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:50:04 -0700 (PDT)
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
Subject: [PATCH v6 4/8] i2c: of-prober: skip post-power-on delay if powered on sufficiently long
Date: Tue,  1 Sep 2026 15:49:22 +0800
Message-ID: <20260901074930.764550-5-wenst@chromium.org>
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
2.55.0.897.gb25b4bd76c-goog

