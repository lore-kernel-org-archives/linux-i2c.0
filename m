Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918C3C416B
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079779; cv=none; b=oAGkScncHkSutKWE8nXjAD8i5FaNSkVK8GJ1UjrYvkc8StawBg8ycWwIThkbFknJ7zpimfyPhe2PyfU1g9h8EOofRyiM2QrqGsiZS57oKQwGkhyWbztWGx3nnyKWhSDC1aX4o9aqKEAM6QBOw4inBAtn1MX5T6N5fmOtH5+AONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079779; c=relaxed/simple;
	bh=V7cOkFeI+SMCrClZ1qRg1vjKvkY61qr7W7O4sv97AZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NouYrAwSHcCkwTNjh0xeI6Tgwa2/NehMUqFtH6lEUVW963ZfJuKRJHzwpIUQmV2CnN6ieOhgXe+ZNRZV9Zf70prhJgh6ZJ98CmwTmTR1Llu4M3zqNLX8EHJ94q2AiYaP5h/IoU2bVje3O0Al2sETYZMmTDYigglRx1TYZ1yNgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M9/h8NgY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9/h8NgY"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-847aebc56b6so373706b3a.3
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783079777; x=1783684577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1Qi7K0Q2jUkzExsWzvH+ABdRL+B0DFQxVv+X4n7A58=;
        b=M9/h8NgYWoQ7o2l8ye0lo66sKTlRzgH7BvW2v7lUuHWBX20CMZr/LB5rY3rdXehhd8
         q7h1f+k0/5tlEcjjyIMf1CtTkmA4Bq9IMyyx+YxMrfojokT9fVgHJRpKl8WsCsB5alx2
         Md/u5FHWHKQt2BCTfI5PswF8ifDsLEBK4/q8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079777; x=1783684577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1Qi7K0Q2jUkzExsWzvH+ABdRL+B0DFQxVv+X4n7A58=;
        b=eGk5eQQ8YZ4CgVmOIwSi5cdHV4r7A11AUjx+6ixrNrnI7BFPLUSHajpsMcrNYdsWAy
         IVWvygCDQTEQPONJj0I/OXR7pEixGzHJMkL+QrXL9uioS30GrU8sZAl9rnVADK6ZeIk9
         lavsz/jlsUFv0GjjDT6lOLt9BuXk6BXE799UuFpQkKD908Mb8mqaDwOScbfWImE5Jtst
         2JXEVqCJm+SCyxfhBUx0VjbmbrLKajLakJInipAsqh1i4BiYZaJU82Tq4/1b1hwZ41Fi
         yFzuZ8u4fXsV2MwTHbDJKgJV0ChdqLFWayeZyRFszwG6JHjYBGeTuJ3OiScZ/4y0/DVV
         8nCw==
X-Forwarded-Encrypted: i=1; AFNElJ8NRLgyVkqUVKaPYSxU8jtnEaxPQ83ygdfO5jO91PCG/5MCh5o+rM/RJHWmUmpjRg1VVBfAsN0YBtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzToaI7EPGy9lsL+Bniv6HAhlXFr8A4jupfT4JQnbCdGbtMAIzX
	DQcQQZeo74AXS0Ix23GLoKBdPfd/oLOVQiOTMC4d16m9L1NxAk1AMbtYZcLFeuLD/g==
X-Gm-Gg: AfdE7cnJ+WHi2puEN1AlntEezuzZivtOPUEHHDeWDHJXXjDvILrQVKkomf6QdoaKFHf
	s3cB0Qa4f+S5qEeai7lT+sflAC/0FpUquq0GhQTMarO4XlU9LyiVgDsp6qzMOt1JC8kkeb342Lw
	OGsBqdG0IqTqIV0ESIc8jQuWu4OVMqIDiNZk+DOuJpBX6IKPhnnbjZJRBZHeXd4daVmf9m56xq8
	mKbNcXBfSdse2G1CbpljDoqS1Zey93YZeGLDVUh0dGHLBrMGoJDi5xgQxHl32HKQpgL7hLvLtj8
	GPg2h4zaU+s0rDPrtk0FwXho8LYTPODEH+RoXhInJTb5+zGX3duFrInrfZ0psUqb3EEiYE9GYYk
	scxyod+dOwPlwfje6EobIs26UfmQLND6BetfrHkwVvP5gEdbOwKhs2Y6GO0cY3aFDeppnfPVBxW
	PFcuQOVodo9jyM8ZQgLhkxyUvPsNMB5VkR+2NedzbVZxHKw+LuZEha06nXaz0yH0XjfeBd4pjpH
	exffaMq
X-Received: by 2002:a05:6a00:6ca7:b0:845:388b:56f with SMTP id d2e1a72fcca58-847c08956ebmr10321332b3a.40.1783079777502;
        Fri, 03 Jul 2026 04:56:17 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8bd30ca5sm2569540a12.0.2026.07.03.04.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:56:17 -0700 (PDT)
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
Subject: [PATCH v2 2/7] HID: i2c-hid-of: skip post-power-on delay if already powered on
Date: Fri,  3 Jul 2026 19:55:55 +0800
Message-ID: <20260703115601.1323491-3-wenst@chromium.org>
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

On some devices the HID device is powered from an always-on power rail,
or the power rail has been left on by either POR defaults or the
bootloader. By the time the driver probes, the device most certainly
has finished initializing. There is no need for the delay.

In such designs, the system integrators tend to work around the delay
to avoid the boot time penalty by simply omitting it from the device
tree. This is undesired, as the device tree is not fully describing
the hardware.

Instead, check if the regulator supplies are all enabled, and skip
the post-power-on delay if that is the case.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/hid/i2c-hid/i2c-hid-of.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 59393d71ddb9..70afdfb207ac 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
+#include <linux/string_choices.h>
 
 #include "i2c-hid.h"
 
@@ -46,8 +47,12 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
 {
 	struct i2c_hid_of *ihid_of = container_of(ops, struct i2c_hid_of, ops);
 	struct device *dev = &ihid_of->client->dev;
+	bool supply_was_enabled = true;
 	int ret;
 
+	for (unsigned int i = 0; i < ARRAY_SIZE(ihid_of->supplies); i++)
+		supply_was_enabled &= regulator_is_enabled(ihid_of->supplies[i].consumer);
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(ihid_of->supplies),
 				    ihid_of->supplies);
 	if (ret) {
@@ -55,7 +60,8 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
 		return ret;
 	}
 
-	if (ihid_of->post_power_delay_ms)
+	dev_dbg(dev, "supply was %s.\n", str_on_off(supply_was_enabled));
+	if (!supply_was_enabled && ihid_of->post_power_delay_ms)
 		msleep(ihid_of->post_power_delay_ms);
 
 	gpiod_set_value_cansleep(ihid_of->reset_gpio, 0);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

