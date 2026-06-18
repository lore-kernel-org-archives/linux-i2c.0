Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A32EC083
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791538; cv=none; b=eNzQVMSSwosdXJOcdYdt5N6LnVIHzFTYmqT2O5WtMZKkzaePopEqZeSg388r7XtZYBUl4psxrs82QOmml6a8Iqu92vl3r8s5S1eGWCpJSqv+nkXnHUDELpcFM0TO6PEVWbO6B2yfqdDshHdsEdWxEHcH3iv7YaknMwL+Q80X9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791538; c=relaxed/simple;
	bh=49WYRvvdESNtfeki+abkxDaeGhwROzrKuo0qUHo97Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvmLXObsojUrPLKIHs+AeweO1/+RAxbcXjSbJ5WECrIF6tGaB8OCCjBc+GIbueklxQqcDr4Suz8zkJKTTKHPf5+3rH+VRCzY1ONSp0g/huOaykoKTTADgHXwZhKziKlfrxpcTDp2/ro31L8gV3Yel2HRQDugGSvNH+/A5eeGseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcwM4ttp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcwM4ttp"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37cbcf49deaso509852a91.1
        for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781791535; x=1782396335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFQnNTOYhtvDC41BGM0bxTP54ugtmHtJK1nGpmbfAd8=;
        b=DcwM4ttpAK0Gc1OPp6Fm3I4zZ4a5u4YHl8+aOJJCvwEVnYZvCwwe/TafV+ku9+D84x
         4tgFgP8xfvtSkqZIlXjJ28yofSg/GWFbyBNNVG+4Ko8G1NsAqk35DL0KDysj1EVjgnGB
         1BvVKJ3Cu4JStxdzXKMDOG41zyTdu62+e1Dug29UtrW/U8cZXhVL28it4aQC63j/QZ8g
         M7B4yoMkbqear4MdxgSGF7+PWji0Nh7BdaqhZrmiV4Yz2vg2Pjt2kh+mTc+wgefKQE6l
         yhpZWTBJZMMVnT6Ai+AB545oTjFB0qs8Gy3cAd17Ihd1Jc27u4ajOlhFckvP03BotBUu
         Zbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781791535; x=1782396335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFQnNTOYhtvDC41BGM0bxTP54ugtmHtJK1nGpmbfAd8=;
        b=WaTOWQrBW7uTHkxDtLaJATh3tIEJG9ITif2JO0cH1caqsRPzQsstvLk8lUgqHn+KYR
         uQZGQBwCEMBHL3Z9ADDhFmo5m9QDejeoghyI0XeyTJok4MY6TJ50YzB38ng06um4aAIu
         uYnSeISNocuRLR9s6T3KpQH9XrPQqfj+ea0/OhP98Gvggn0z4nDKsZo5P/TIRcivNglW
         qVdb7QtoebaIG/BGwXQKiFfIUnOQUljnO0gdjisEo8BXGtLZpvTX2W6ImHK/DZhKfJdH
         EGK2bIL4eWq5Qjqmylg0KcZNg5Fiv9y2D5oH+Zh3dsM0bY7QSsYLXNbFm+LUjk3gxXp3
         J28w==
X-Gm-Message-State: AOJu0YzJZpjQjhpRFMw1FSpc5HoG8J5Ta86bmw1p95beSotot6gZqP7A
	KWv0ckZdXUhQa8AFgKf5HRck5uifC9OntY9ZU6eaMZmoBzj2k6Bk6EEl
X-Gm-Gg: AfdE7clzu8befJvvP8U/uoCrMh5sGS4F3zEXzEkaK/ssQOSXFXpTb9GHLyPMwJMrlDj
	l+E1cAt/l/7ski5gKMI7z/ZjteFJ5LZk8lW/HfGQJmVpxlUofCX7iaPPaqdmPlUlzN8alwvy1sZ
	ddZL/5bCYtYmOP4C+mEsN1pOg4UnY8cxDC5TadNeNFOJSClSr+hgQ6a46y9s9EnZShWkWMwgtMv
	oGM1HXn+Pmve8qqgvmq4MWiNGbjefUnUvVVPR9oAfwUeKf6afI3SfMAy8ETeaLjuLfeDHuOmoOt
	jiFcoGwoJC8mDALz+YneyabDpuryNorM6crySioOaYZwp7RdTIB8+NFp5XzsNRnDtNv6/948ejD
	bvv1l5DRm1pTUaPz2g7XmixuLoLF5Ql+4v0qYQ/KLOU5Ex8ieAv7Jm89E7dkdkv1/HhKR18OUSo
	cfY4tEca3QpEf9HgQsXyq5ceq3T2Ja8yGx/uhAdkYMfg==
X-Received: by 2002:a17:90b:28c4:b0:37c:b248:1a58 with SMTP id 98e67ed59e1d1-37ce48fcc3bmr3902993a91.24.1781791535352;
        Thu, 18 Jun 2026 07:05:35 -0700 (PDT)
Received: from steellegend.taila75641.ts.net ([2409:40c4:35e:20d7:2ccf:7534:4b88:ba43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ca980sm9961202a91.6.2026.06.18.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:05:34 -0700 (PDT)
From: Uday Khare <udaykhare77@gmail.com>
To: wens@kernel.org,
	andi.shyti@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org
Cc: linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Uday Khare <udaykhare77@gmail.com>
Subject: [PATCH v2] i2c: sun6i-p2wi: Fix device node reference leak in p2wi_probe
Date: Thu, 18 Jun 2026 19:35:25 +0530
Message-ID: <20260618140525.11526-1-udaykhare77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617194522.114984-1-udaykhare77@gmail.com>
References: <20260617194522.114984-1-udaykhare77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In p2wi_probe(), the device node reference obtained via
of_get_next_available_child() is stored in childnp. This reference is
never released, causing a device node reference leak.

Fix this by declaring childnp with the __free(device_node) cleanup
attribute, which automatically releases the device node reference
when childnp goes out of scope.

Fixes: 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support")
Signed-off-by: Uday Khare <udaykhare77@gmail.com>
---
v2:
- Use __free(device_node) and include <linux/cleanup.h> to automate the device
  node reference cleanup instead of manually calling of_node_put() on error and
  success paths (suggested by Chen-Yu Tsai).

 drivers/i2c/busses/i2c-sun6i-p2wi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index dffbe776a195..8469a0ea98d7 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -21,6 +21,7 @@
  * PMIC).
  *
  */
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/io.h>
@@ -184,7 +185,6 @@ static int p2wi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *childnp;
 	unsigned long parent_clk_freq;
 	u32 clk_freq = I2C_MAX_STANDARD_MODE_FREQ;
 	struct p2wi *p2wi;
@@ -217,7 +217,9 @@ static int p2wi_probe(struct platform_device *pdev)
 	 * In this case the target_addr is set to -1 and won't be checked when
 	 * launching a P2WI transfer.
 	 */
-	childnp = of_get_next_available_child(np, NULL);
+	struct device_node *childnp __free(device_node) =
+		of_get_next_available_child(np, NULL);
+
 	if (childnp) {
 		ret = of_property_read_u32(childnp, "reg", &target_addr);
 		if (ret)
-- 
2.54.0

