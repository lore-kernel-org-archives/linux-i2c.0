Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59F470135
	for <linux-i2c@vger.kernel.org>; Tue,  1 Sep 2026 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249004; cv=none; b=a+O4tTTxgeUGjz3+CC/lXVqqTyj6G7oiZwF2SJPspbvFdN4vvhlrQN0nS6b/m/cM1kMbHewr18IHoJtn/IRsX4TgU0KVqaBcS0k9ecvid1VRW4ofyC6lliBk3UrWInfvJ3/Dik1xtG0cDmInFQHOaU09K88zV3Y2a4Pq864tLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249004; c=relaxed/simple;
	bh=KSh5c40N/ncjUkxNS2dUoSiZ9wDsl5oOe77nz1eIIdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTgvoTQFSV5wcXFg/I08Y3iIEsTmotEaWiShtULCCqA3fmK7TvM5pBktv2aMLxj1pzgg/LVu7o5j1Tvcti+iQIpJnnYu+FlI1/4jTZjPMqkhGleO9CqmfddEM4sry7jp1gjJ5NlJYpuIPPv/lkgpS687U5/r8FjwSkAI43QxHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lq846xDp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lq846xDp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d7200b2e15so47414915ad.3
        for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788249001; x=1788853801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJzWbza2zag3QhFxPq/teShXqDf76npySrhO2+9Jdis=;
        b=Lq846xDp2aXhMzO0BQBk2BNWZI23Zq2slbPd+5IkCZNq59bQxrB1RfACIKZaPBzzoE
         7LeWfaoFDZW0aL0f6gq6AIjS5ZIJX1FYRrBjDf5VpyRADYTZNYCuQPPJhWyzanlDJfkh
         gE89DdoSmckyYlvPRmQWRk4B/75Im9he7yJcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249001; x=1788853801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wJzWbza2zag3QhFxPq/teShXqDf76npySrhO2+9Jdis=;
        b=YcsaL5agSPdqLXNdYUvpF4i8jOqrQTlz8iTUp92/PCDXtbhM+fLgptgVQ0uLkjUuPg
         JX3B3+khwvMVaIpQj7mwaawnHFdGlWn9FndIow7DTKz9UvMeZ3xtM/0V8/1XcDPLRl0B
         XgRezw7adXL617wZ1rQq5L2OSG+XJeH1vJH1BJ/mIWcNazmbCz0fDgSM41HUeSdevf2G
         w/pNmqNyVH8J7duC0+OqJi59kGBnlvQ4ks25Q58y22J0OK+jFwbxIxqK8c8ozhPIq7pQ
         kM9ddyizdak9Ydp8Yc3IL2uG4jheiGG9yO6CYiLY5XjxNw+uDECLg+dOzOJReniZVKDA
         J0tw==
X-Forwarded-Encrypted: i=1; AKwUvBzrS9X07wHih7lUJPz7Eypzj6iUqaDwZ8FiIXz+8M7Q/pcvdbEgz4eayoRRDYYIMv5h72K5J3UrVrM=@vger.kernel.org
X-Gm-Message-State: AFuF++ljlDoken25bU4/X+dsQqIOAoc62STMQoCpurVprGpJs5Llgkr+
	+UQqOcDbyLjeima2QufsdJ3cK/hy7LYjjiMqfmVzqghXFZ4N8ZtvqR68TuVwtI3Q5A==
X-Gm-Gg: AYBFou3pqD6wf76fBNTG1FYyJXYTUGlt79T/MkXNHprHHhEjO7qXoA7AUrso9bl9CEn
	1iQr9oJP3uNnnOyxiBApvjV15vti50kY30Z2WIOR6B8D2KiCcX89OaQ/C98W8jf297PpJSh9MOQ
	ZkdT7ekKoocwSdJ5IeX+kQ6TWXBSLdeCMbHK++uwvGq90RplNrU2aKDLc0UanJgR4hNC8poRaab
	9APY7y6pSzD5xsyINfrpV81NQKKxCI2IjGm9uMEkmTB4EztwzqZ1aUl/lkWEpW7KTL6KIwOtUqI
	zVJXNPoqmOlkB3UjrqU4Goo0mvRZghNNyEk/BFx/dEVAoupJsnyjoWgN2STAi1peG86E2C112Hf
	scZV0yLQcLZLNXqjvoYO2Ro5drGBOyUMIXoAlfQfqZ6EV0Nm3uUz1WNgQBZLARK+enPxQlellGu
	/2SkIDrTWAR8SP8NeVyo731ynTBUpkcy44tWvMrG8lGnwFX0WrNIv9ls2iQoqTu28Bl4PywI3L5
	Lf+rvcr2YzFDdceSzuCn/849NnSVcm8EKZX7z8DazB7bQ==
X-Received: by 2002:a17:903:3d0e:b0:2d8:d4d7:f055 with SMTP id d9443c01a7336-2d94a930d44mr91456335ad.22.1788249000970;
        Tue, 01 Sep 2026 00:50:00 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:8cf:6df0:9c4e:f5e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b699sm48142515ad.59.2026.09.01.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:50:00 -0700 (PDT)
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
Subject: [PATCH v6 3/8] HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long
Date: Tue,  1 Sep 2026 15:49:21 +0800
Message-ID: <20260901074930.764550-4-wenst@chromium.org>
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
2.55.0.897.gb25b4bd76c-goog

