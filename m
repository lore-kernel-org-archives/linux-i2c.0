Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781C377AB6
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632424; cv=none; b=rTTjuhk3gV/8IAEHmhBVhDhx0ptAwfEbR10DETst8SYVHr3FeSybJSon4WVmg9IVe3EdQvbUg6A0D7mcfK6hr4VBRktCqUL0lZ3JJhB+DiRh0Ex0ZD1hpJD0ihw/3SDTY0Fdg8J8QqzabKwIT0GhsOcx6C/0BO9XyNVVlIJ4P6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632424; c=relaxed/simple;
	bh=Ilgr0c2G4UGsySFV2bD0fiAVVF8lI3iPrBZ7oXN+Wgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZO2+iepu11HNcM3XJBKX4f8KsOK+Kx6Yf1SHH/6jZ9Sl7s9nC7M3R1XD0p26emMdgoRj8C+ZrprKiC0GHaUodAB98g1YlFCX3crvS0O764lBDH1qh8dkjLYdOfa+IqtRgENi/a8/tm/TPVkqToPqfuYKVOiuyFB1rRm8FaIC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c9K8cPqX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c9K8cPqX"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so5139001a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 21:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787632422; x=1788237222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFuutJe+E+uxqdXe1I5xllbey7G2lsjmwPbc3FHp/cg=;
        b=c9K8cPqXigFe5zjywcRxm/M/n49+Cxa+zh+2mbO2oWIDexxYpJH8rxXXcCzup93G3+
         R2ibgROjUigyp1L3YT6t34gfmGlHlhNJR8Bfuvvb50PkHB1hR/wWuH71TRXwbr5VJ5Qx
         XnN56lnnXzsN5MM2dEDufwFOrSgHCUb0IQWeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787632422; x=1788237222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GFuutJe+E+uxqdXe1I5xllbey7G2lsjmwPbc3FHp/cg=;
        b=D1SV4e3MGRCuLQA6m3JmnOUfkmSBRmgx1VFgYEdnpTqWNIQzgTqqa+V0yMjhCqBtwS
         cqqv3ZqSWcijoWPgHoHCcb6trqlfuiuXvV8GTJE+RsJBq9rz+UVc004Bqb30wN7wPiZ2
         YI3Ue3Xy75xNZRUgvh/Z8sQGuPQ3opOBzwepKzqzuu+apFqQVTz+0ru5o4jy25jCxQIZ
         GusbXx1GxbAaHTq5Ztw2bBOaJ0JP9MX5EJb13e3nhfLYN4aVoeBsKYoCYXV6XgWhzLyu
         ZqJk25qZ1kSHVjEBBVlWZh4YkMt2jHZfnMyDWy+n4505fuMfTNdEl0L9eDxcQDR7895T
         qxAw==
X-Forwarded-Encrypted: i=1; AHgh+RqCSGJdUbsyn0yY95+fGmG/rHpbUdGvAbJobOh+suK4oKiJ1AbqrLyNJ4j+dzP6MIaBMvLznaurGCc=@vger.kernel.org
X-Gm-Message-State: AFuF++lBZMK/Tshl22mg72GAvZGq/2vwTFj/1fXuca4TkC2Hq0ft3xgO
	o97TS7V0XrTyy+1nu413m1xZWHMyqMGOlH07tdkGpqj9Src2upN3CpjkjGA1w2sIUQ==
X-Gm-Gg: AR+sD10yQ7P4OrM/XtAPzOi1ef62/IYvKvEmZQ7vufXuQI7kI4M8DHYt1hXkIwKLKS+
	5dD/N8y8jeHmGaff7n7V8WZ0KWgh5jdXbAjqUXJCfMHUAluXOuUEaN834cHnCCx2EIwJAM7Qy5+
	ntFni7y2t3Gwcn8GGM2L7P/n9h2OszPTLtBA2teyzEo2/TfL7JJDMvnhqeCMm5AUV9gZzJqBN5/
	p+Bez1bHmEpTWFO+yKi9nRINxJ85jkOZExbc2b1Nba2+D3MKpoUZk2AiXm4MZpF6ZfpkHV2h2+H
	efKttsE4OyKR3bcsd2QSOu0xOv4sa2src1vj434LjDAozOo5f/WPPDwud/uBUzJxD0kfL/Nhb1H
	0CpONE3ZT34MXxxfSD4aHk86mNmB2WjVovisqdWAIdqMM/0de7E/+oikrRLxc71X8AVKiK+pBrm
	/gPPLYDRaTWbKFuTS6e7LxGVRJA2gOvNYLKPAP2WZSOlqgamCxU06gHcHGj2q6/++zsl2fLTu1Q
	65dfe60d9ef6epHAwI3z2V21jGgGHNifyPWQh9AjTzjwY7JnfIugpa/Ig==
X-Received: by 2002:a17:90b:164e:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-395c352fa60mr48644179a91.9.1787632422068;
        Mon, 24 Aug 2026 21:33:42 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:a442:9780:24da:cb4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396458212absm2187823a91.0.2026.08.24.21.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:33:41 -0700 (PDT)
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
Subject: [PATCH v5 3/7] HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long
Date: Tue, 25 Aug 2026 12:16:21 +0800
Message-ID: <20260825041628.988369-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
In-Reply-To: <20260825041628.988369-1-wenst@chromium.org>
References: <20260825041628.988369-1-wenst@chromium.org>
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
2.55.0.860.g4b6b3295ed-goog

