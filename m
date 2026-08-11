Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8F444705
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450853; cv=none; b=M5KlypUsCJzdG78lbv1UksLUDWHSeV8RC+d7cIJBJSi8xy9+/KUNPb1mgYlGFmtvMcwYSY9m8ONIF+BF3tZFpcILLuTDzw3K39xHJoGUZKkih/zp+/XmVWVqkVkKPhvLyytMBhUz49rGeir41tiuq2Av388jhzp2LZi1+PioGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450853; c=relaxed/simple;
	bh=uirJlTrzUDnDWGluHgHaYZhmNeiDmkFi3DnjsuZpHfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+VSHiP10so9W6JxqjjK09iyJ/BncKnPiCUWvkAf+YxwpgtkFI2SjD4fVdCpGs+febYX2kQHIYrjkpJVHfE9hKu3xug50OiDWj7A3DbOhrUD5Hr07+e13FalnGGrty+TTv0pTQuJiuOGGqqOeIY6Fx1uZBdw8Dvni9QH0VDcQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AHysLrxK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AHysLrxK"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so750781b3a.2
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450851; x=1787055651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsFbGvUc+lL3nEmcNAop98oZPFXcbP5zb4ZbtxDxx0U=;
        b=AHysLrxKBQRBWDPQAOCDHjM1n5xvZQ2q4T4wopMN1EbGiPvP79efhy6Y3H7y6zDD72
         lyfi2zZZ8MGtj8/g5V/hUMa8gIMA8lo5N2dUIF8D11cVzr9S9opuhIFIzZiQirmuKigP
         xwvegTrWzYjUhwxR0dEjzjN0A14QdcOpuXZTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450851; x=1787055651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GsFbGvUc+lL3nEmcNAop98oZPFXcbP5zb4ZbtxDxx0U=;
        b=UjX2+uS3u96cKlc6R3QQxRAMquUcYHGw4UJA0sCk8yAqWgIXO6ZeSNaCZIGq8tJFgn
         SwY+GV4ow+eW2czL6hgRT84Ma894bDVV2FRTnkmEikKtgVqTkqeEfHAvoNcmDgahchjB
         SX5DSkK3iJI23K6HDeSs+t+TKX3JWCyqWiE3hnsDjsvmsbRlVCgGQ18Rh4feGmGvoVhc
         B1tQ8cmslLmeHaDyNfn3ez79n546IqVv8kR2QB3XN17nodQ8gdX5xInWE/shR09FNILS
         u2aggmmQQGNS7kBNmQJ49KKHV2CXHJENO4rx4qlkd6+5H9QzlShq6g9LKTwo0W/wUjLZ
         4FAA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4CWLJ28a6F+TLA/bmVQrOLoFjjUAtWL63ri9OTrjp6vE4m7RkNbWZLnbZ6QsjfpPqjDjWGgROxkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx20PLYGqwPNiig4p7Ja9ibhq0Oc7Bn5eA2+ExnyD5AJcDvY9u4
	KS5znKfu7wliQ4DwIkMV3LYFo2ghEEtLL/hfcmtwrn7lNeypEp6l7Ks/qe5YXeo6ow==
X-Gm-Gg: AR+sD10sz/grqi/gAxTLdbhG82wR+9Fze6iWrpSn1z+LQ02Pev5rScNEPpFB5V31EWb
	CYIQlZOgCy1fTu3R0EFFZTE+xBN6Eyk/lswFmpGNxo7dhHQ8BNbSvjRxIct5HuIC+84/MdsP2Fp
	nvhNQauOSMJBcSbb8jjI/lxzHh93NXkGFMIIW3YLjJuihjU2eZHLgFIA2NPQqM1viXpORldV53v
	mss6Qp7qu9F9mVKBv71FJp4YDNRjnHhYlkDwj70vt4i5M9VFY2fPa/wZEnG876M9RkWTe6Ezobq
	t0l1eXXyNC7YjJTrWpxiKrQDTkwi/vUUoMa1Dgh0/UyDKzZkHIW4t0QiSbDmhKERpDFadfjms0h
	JE4RE+ayVMB+3qBx/MABkRhdwAmVvTjjJ+bi108mXNdpwy6s5xYt9iSBzdpvQFcbWJF0cs3kjk3
	CIm2Vkcdw8RlOX8vl+Lo3z4FZ2fRm7VY4RsGVtByRNfWAW4dyayjw619y03JHz4TgXretY2s9a9
	ZzEgCF70XDqPAK4I5acle8ji4eRn1Tj3ApGiHXYA8oRPg==
X-Received: by 2002:a05:6a00:8d1:b0:846:22ea:e171 with SMTP id d2e1a72fcca58-84fa872c289mr2761703b3a.3.1786450851388;
        Tue, 11 Aug 2026 05:20:51 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:20:50 -0700 (PDT)
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
Subject: [PATCH v4 4/9] HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long
Date: Tue, 11 Aug 2026 20:20:04 +0800
Message-ID: <20260811122011.3539250-5-wenst@chromium.org>
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
2.55.0.679.g6767b8d81c-goog

