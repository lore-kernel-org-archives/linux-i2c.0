Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39324343E7
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620456; cv=none; b=akx1/eGrTuHOwBc1NpJwV0Gk4s9iVI/UHD/wvr4r4P2le+Qa/rx/C9lJNZ4y5fBXtb9J49D58KCGUO0exaL+R1dqhguNP9uBY36pZBf7JWdtnE9+9pKosKUMSdZoVjFZKsvfSHHY7r0tEugCDbnEwpe8lMXbZBBhe0aWnlTRvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620456; c=relaxed/simple;
	bh=mZz+oxzJzJ+AFnTHJSeHvs13/lb/cPqLyNtaVfdyUoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2w5sX4T4BqPTq0IouRYnpyye5fRJAZtpJKvbJyFYyeRJ7ZHFfEHhJrFk3ihu5mAbJ5UQEcMlM2cgb+D001JnltLDEecVxporqHfuy/s0Uv87Qrrv770U9Ueq6LtVHPN0weoxiktGSiEJjh1GwFLHRqouqLhnsR/zSvAje/wwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eHRcjrFJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eHRcjrFJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cace91f112so112955725ad.0
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620452; x=1785225252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sl4qlttmKIif7Xuk+0Av+jVf6HGOZu8iMGZv9Qz/Mv0=;
        b=eHRcjrFJ4NE6VohnhBYzld9TrjywI2x4/yh8PXwCSx55wLGdzXb6CEznhk73xt/2wj
         t+tufpCb4j3ZxF+kR9vbZpOMMkEQ3qJGxpOYGFZSninyCeWCTuyF5BBABZx5kPrsJ9Bt
         eF84wxg58OntBp+ZjwCH9n6331Yv8XlmTtWi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620452; x=1785225252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sl4qlttmKIif7Xuk+0Av+jVf6HGOZu8iMGZv9Qz/Mv0=;
        b=dqkhuh20Ldyf3OINXEpM0LVUaGgjkA9AyKpbp8YQcvACC4pEQhKDpJKX9fcw2SI7LI
         c9ojf1xS1usB1f/TcSgYMqsa53bVulPJ3S9O5I6euPfKG4eC9PHsEBQeNnyNJYwB2WQH
         tn/ohuk1edLPCNKljLFuHb/kwf1B8leztuwQZpHZ8oB/QFEFrOMUvIS9V0ZidtN5CdUH
         FzwnLfWGMWLqfX0E/TwDty9YXQoPIocUcxfG41xg7cok9YlsV/O3N6vakJ4cTU5cC/gr
         h4vsdyC3/hDiVMjHlyKNdb8Ch6EB++RQATw4lM8rgNDoBPtDsSHU17DHgUahCphUf1bL
         vHSA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2EhxVGAbCDLBsEppAyKCyLDRmcxh9ebF+W5mzOjVxAdzedlX/SuZVaZeLli6IXdi11A/pRlaGD8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJd0cfS7v7xks0g03HfV3gNluzGVNATmoSjUlxxcj7UsAei8cj
	rBDizCUEtGZXbgbybAgfO9P4IzDBqsTZZZGcB8uGtvTq4P8/ZRP7Jqh/E7Q2lfKrCA==
X-Gm-Gg: AR+sD10Rj+wOhuNk5INPuD2T96mIzVfkbUmzvYRlrUdZXiub6HpbryXFSbWoSmx/L3j
	3cE2B6kxqalnbXCI1op0cEn2dB6d5ShZg7FOLY9AL0MgLoT8JrMiDLsJARULvRYqzAq3v6Bqihg
	dkaqlEiKfNnlR/2AWBuEuVyNPmlhPRrIKLmp1AsxNhSJcssrNRghnIoLRi3WTsYyoOouRQPjZN7
	1spMPPLmD4IyUS0f5b12T+k9qje3zEm33Px4WHCq+yNGZemb9d3eInYUfSDxacoXs5fXa0U0MM9
	FsCIx0O3YFh2bn0NNrahIuSTdkiw+tdXWXfuTTzWI8L164u0Q/Q5Rk11yhVUfuUny1kmxmOaV/A
	o4Gp8Juf7Pw/m1gwjg0hPTByJdlUCtTX11Me9W3naG5xoMSt6Zl/0neEpoWQ2ImzT4e1MgyeMpb
	QjVqTk14tQALwOkXKALhqSW2h7YDx+oOyAvCvOydNfDym6Qckp+rz05bh54sQ=
X-Received: by 2002:a17:903:1210:b0:2ce:d34a:5959 with SMTP id d9443c01a7336-2cf34a3a5eemr181108535ad.44.1784620452343;
        Tue, 21 Jul 2026 00:54:12 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:11 -0700 (PDT)
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
Subject: [PATCH v3 3/9] Input: elan_i2c - Wait for initialization after enabling regulator supply
Date: Tue, 21 Jul 2026 15:52:17 +0800
Message-ID: <20260721075226.2347933-4-wenst@chromium.org>
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

Elan trackpad controllers require some delay after enabling power to
the controller for the hardware and firmware to initialize:

  - 2ms for hardware initialization
  - 100ms for firmware initialization

Until then, the hardware will not respond to I2C transfers. This was
observed on the MT8173 Chromebooks after the regulator supply for the
trackpad was changed to "not always on".

Switch to the new regulator_enable_and_wait(). This makes sure that
enough time has passed since the regulator was first enabled, satisfying
the power sequencing delay requirement. This allows the delay to be
skipped if the regulator supply was already enabled by some other part
of the kernel, such as the I2C OF component prober.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_enable_and_wait() API

Changes since v1:
- Delay only if the regulator was previously disabled / turned off
- Link to v1
  https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/
---
 drivers/input/mouse/elan_i2c_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 9f024a435dbf..77885930bf9e 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/time.h>
 #include <linux/uaccess.h>
 #include <linux/unaligned.h>
 
@@ -47,6 +48,8 @@
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
 #define ETP_RETRY_COUNT		3
+/* H/W init 2 ms + F/W init 100 ms w/ round up */
+#define ETP_POWER_ON_DELAY_US	(110 * USEC_PER_MSEC)
 
 /* quirks to control the device */
 #define ETP_QUIRK_QUICK_WAKEUP	BIT(0)
@@ -1250,7 +1253,7 @@ static int elan_probe(struct i2c_client *client)
 	if (IS_ERR(data->vcc))
 		return dev_err_probe(dev, PTR_ERR(data->vcc), "Failed to get 'vcc' regulator\n");
 
-	error = regulator_enable(data->vcc);
+	error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 	if (error) {
 		dev_err(dev, "Failed to enable regulator: %d\n", error);
 		return error;
@@ -1406,7 +1409,7 @@ static int elan_resume(struct device *dev)
 	int error;
 
 	if (!device_may_wakeup(dev)) {
-		error = regulator_enable(data->vcc);
+		error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 		if (error) {
 			dev_err(dev, "error %d enabling regulator\n", error);
 			goto err;
-- 
2.55.0.229.g6434b31f56-goog

