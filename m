Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12209437128
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620457; cv=none; b=aSByO3zUQusxGP19l9plOeYWI4x+GxwhTwA4NQhGdJFVt1RuYwFKrt6SjvpWWglFI1qaEdatnYt0BELwHgsFXhSK1jfrACADtckxjS6/yfuMVHGPmt9kYOlk0MnSZv8Cy128UkzZI+CjsW2irkmudfeTUmXZXxNYDdVGOw13MXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620457; c=relaxed/simple;
	bh=J3v6D8PZoDet97Lhy7NyAMAWEZCEiDewv+amHOXW9oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3Pf+1xUTCIMAvgdw9NNzc9MyZFWzaOU7dNEq3GCBKOtrojueq9c0MemnsVdYZxQrR79omQnhuBZ6laHd6qVKuSnr/ju1AKIOrAEtvw+4MUeLJHXXejwLhv8hrxBXZgbh2oIgv6S9wMYQcylqfG3m3uro1BePClqVun2e+X8yNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SUL68HRM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SUL68HRM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso82450755ad.2
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620455; x=1785225255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNKmqRLcn9Q9wFj4nPUvbsCt3JMsfIzkeIOJzLyzvCI=;
        b=SUL68HRM9N0nP1WKCb2UCBU8WNS8USD3r8qKfWisijf75G1XTCZgftHcPQTJkbiaOi
         KywUj8Ubf2/3s0WCHC/onG25jsQ61Uxvs260icpkH8xUwKTGCAisqdt+9WjAdB+kok41
         mSEp6ThAF7DhAjk5ptWS/nBFFrLg28DnFvlcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620455; x=1785225255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SNKmqRLcn9Q9wFj4nPUvbsCt3JMsfIzkeIOJzLyzvCI=;
        b=GBTaiRrL7q4YwwVaBT9z+M5XA8AeIrPg+1RRtvWxRCaS78pF0vEvqpS3VDwqpq409J
         aiUqii8nvxicdBMMCAX/OVFyG98fDJXF3oFAyPC3E7TLX8CpcapEQS7vooYm8aWlEucw
         zBedJvmPybE4jUU49IUiB3w2kFaa100Tgf0uPBGsQG/yqj2ZTyUggiExoPKfICspC+kJ
         fv+2v4Pu454pfBqZh5TvSPenQypSHWCoToGgYQpME34tmcve5YHReVYzRlfD77gPcsEx
         LwNhgU7TE9olRNQRdHkgvzRlllrpesUGEM7pDCLzsHZUjsmDWqKCn1Hd7ymejAT17Kru
         NJnw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9WnfuNVdsAw6pMXcEKJ8jSfbL/1HA+5E3A8ZEr3aqKGL/Oe/Ebm4xUxo8zhWzhVEr31yyub52UEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykrgn/U8jc+VtCOHtaz+iKX1LShE1ggA5PE3P2nq0gmeTBh7zN
	XSzkOzW+WiP4Ltmd7m+ltXIGsn/wQj0CC/1B0besQGs3ZJ9Q/SD8wa6dPI2WwSNC8A==
X-Gm-Gg: AR+sD10v88dEa0uBcT/0TK4YMFldbA12nz0CpExuRadN6THiz2mhJjnZKvWJS3KkHxx
	L62ybddRGD7aEl8k/l7/dEXeXgGTtw/dUCK4uVCDPe1UQtEuFL4Hyu5GJe2ZzD/gfSwyiROXG1v
	BHqVkLT1Es0YEThRYPGqK4T5A4FXf4/Be+mly144CKK4MBtUo/XIUTQGK8ALVcEZcpulUH1+hR/
	fNM38VhdlAPtWtt5pPersQJUdSNcGF3spbEplR1tMfq/R0CYJku7ADWbtSxSoRtWSq0/shVgI8/
	5nvE0fFYYzGPRQI05AIrgEW6V3UZ3BtZgMTxmtGuuGiZrvaJCy8tuFQfy+d47PvCmLt73PjiZDM
	IFZOD/yHg7bEpvWMBF6/oP5ZhOOBVkObq3PbLx2niiHSL8RDWqh5Mqauxqz2jJiqcXaeDe9F4rV
	eWjjbwl8GFeJOKASvQWHgMWJtTk+mLy4buFc8XJhaospvtjDfBcM+OW67fihhDG6uOxe91Yw==
X-Received: by 2002:a17:903:2f84:b0:2c6:a012:6241 with SMTP id d9443c01a7336-2cf34850f28mr198999395ad.6.1784620455632;
        Tue, 21 Jul 2026 00:54:15 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:15 -0700 (PDT)
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
Subject: [PATCH v3 4/9] HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long
Date: Tue, 21 Jul 2026 15:52:18 +0800
Message-ID: <20260721075226.2347933-5-wenst@chromium.org>
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

On some devices the HID device is powered from an always-on power rail,
or the power rail has been left on by either POR defaults or the
bootloader. By the time the driver probes, the device most certainly
has finished initializing. There is no need for the delay.

In such designs, the system integrators tend to work around the delay
to avoid the boot time penalty by simply omitting it from the device
tree. This is undesired, as the device tree is not fully describing
the hardware.

Switch to the new regulator_bulk_enable_and_wait() function that makes
sure a certain amount of time has passed since the regulator supplies
were actually enabled.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_bulk_enable_and_wait() API
---
 drivers/hid/i2c-hid/i2c-hid-of.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 59393d71ddb9..fdaad451e710 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time.h>
 
 #include "i2c-hid.h"
 
@@ -48,16 +49,14 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
 	struct device *dev = &ihid_of->client->dev;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ihid_of->supplies),
-				    ihid_of->supplies);
+	ret = regulator_bulk_enable_and_wait(ARRAY_SIZE(ihid_of->supplies),
+					     ihid_of->supplies,
+					     ihid_of->post_power_delay_ms * USEC_PER_MSEC);
 	if (ret) {
 		dev_warn(dev, "Failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
-	if (ihid_of->post_power_delay_ms)
-		msleep(ihid_of->post_power_delay_ms);
-
 	gpiod_set_value_cansleep(ihid_of->reset_gpio, 0);
 	if (ihid_of->post_reset_delay_ms)
 		msleep(ihid_of->post_reset_delay_ms);
-- 
2.55.0.229.g6434b31f56-goog

