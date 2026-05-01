Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E04219E7
	for <linux-i2c@vger.kernel.org>; Fri,  1 May 2026 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667444; cv=none; b=qiW51sxckbOGhfapX/qly4gXg1WcVCUjzyPMirlcpUOtaimDuAuNIxQY8pktUD+p7NOhHuwCIUqQkpS7r/Sn6K0y86sVAlDtPPJPFNId8ITzWMudbvt07yHwvhBLJ22PeIHzLzkoBksweBMyunPxxDcubyQhPRHa9irgAMtQ4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667444; c=relaxed/simple;
	bh=v5qF9oUjFKKNNHiaZ/cDzrCvSYhthuRxEl4ePROAuGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etSHOdF3E7KTaR2+5Jx3aUBylv65ptgR0m7kQ5QSegZIfcvcxQN31RGOhF+PAe2Wgv1jf3eMA/jLeDE/yGP5Qo2hFBIZnG+3SxjiqTl6hZXEjBkQkRh0syeuMg26Wzj5FATNMNFD4WVnJYheyOns+FWtW1UwWZ2+UPqxm6sFvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGO+jCXH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGO+jCXH"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f8b60e485so1065610b3a.0
        for <linux-i2c@vger.kernel.org>; Fri, 01 May 2026 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777667442; x=1778272242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVBnu6Q/tQcYvEy05j8zTeFYSonQvouDAQt7Xng1rGU=;
        b=FGO+jCXHSKDpIfZTzi+KqeQj1n2RE+xbiek+qNmJE4PdwTd714zf5EQvYG57oIi6Oi
         tZ9UxnPr/9Xbpud32rn/Z1BnaaZ/sKZELwdT2oRc/N8Ha/vE28DQfIsPHwy4xqyOguWT
         L3l7oGbbQukeSzast7sN4t8wVpyQrESwJStsqRuHp6NTwdZ+mXvFNE/SroyTjrI9QPjD
         y5NzCZAikmvok/G26FdM8VeGryxnBvexH065x/hW399eHtojC+sON90MlK5c4SmeOggK
         slhFI51+7FhLP68Yhn/L5Q+/YbC0OKAYGLLdmOt2T5TwR51z5Jtqu4MKAAf6/a34N2vS
         n6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777667442; x=1778272242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qVBnu6Q/tQcYvEy05j8zTeFYSonQvouDAQt7Xng1rGU=;
        b=GjkuXQHSJiC/FH1vayFGBtLOHmW7juWGNqNyGTTffVTXCCyfY0vXpYToUn2SZ+hSqX
         4Q5NeiPbLsgx8jNQ1ru6jaKtNssyiN6YQtYJMlpJbWGqsF+0f3m/JwGwKAI/jcQFa/z3
         eGS4CH6c+XtvWxE/Z8UsJr3eNt0QgUrk9f9AhQKbu4+Q+zSDWAhkU7Q5tjpQ0b68Q81q
         YDAsKxe7UpFLFXOImXhhq5b+znpi5B3IXWezdyLfzc26bVlUNhNZfoqxy8o8/urrEMeQ
         NisAf5agritYLjp4ST3OgghpMhGe93FJHzz3GQ8REK4HIBk2u5rBy9eNKUDbWSuQkYdX
         q0vA==
X-Forwarded-Encrypted: i=1; AFNElJ8nApwGTrtbYPKm3VMji4uLRNnnsO483eMQoZIApYMsBsBu9EU47ZXIAjtAQZib4PMVrUDzcH8A+BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/iiEBuvaWj9wxoRLHXNNPDK+Acdy4f93hlzpu03kVfKZN7tZ
	T2hqwzTDOEpuL7nWkERNhQCjhK3WB2HBXcRzmD9louVibo9XDeCDuvNd
X-Gm-Gg: AeBDietEsHGmQV9TysjZB4AKVEJ3a7X+lxD3wnwPBRk0hRW6U8AReWVGdRp0xtmuWw1
	mIgLQTBVXWo/KBw3hfMOO0VDlpdQytdw9DXIeGXGHZllKD4irdAEgSx3ez/Aa0dIgf/8J/BESbe
	FrceOJftCfLYcpq9lmkbG6MKsDcn7elCA2jk/XEkTW0DrkhRjoSKFHUrmUD0sJxGDzqlLZCc4J4
	AXo5hUx8mOegXso17yYcZFWdKUoZLfvUpYpoUVf1JWHZqSIXa+p/RhCQ1roFbC0TAYxqyB5DGfD
	p2FiVJIsBLQ+wOkTxzm1PZQ2/JttjRJU/pvA3jAhG7sahmq48hdtkoMQmh9Ai297sZ8TOX783Dp
	vvo8kwHah+C+yHvJlWncGSRpBAqHbqenUsx4rIIqOOuMQEUnMRa5xDxPVUY1fZ7Mvffppa4rnMA
	6JCJa8qtRUB0f0rIHH88y6CtDZ3Q8pP0vAHwbvbiYQsLqG7A/U0j9kekHlGYcH5unGlVHhx7Xx
X-Received: by 2002:a05:6a00:330b:b0:827:4343:4c1 with SMTP id d2e1a72fcca58-8352d20b2a9mr661002b3a.29.1777667442262;
        Fri, 01 May 2026 13:30:42 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b84aedsm3230595b3a.57.2026.05.01.13.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:30:41 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Felix Gu <ustc.gu@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH v2] i2c: sun6i-p2wi: fix of_node reference leak in probe
Date: Sat,  2 May 2026 02:00:02 +0530
Message-Id: <20260501203002.3382428-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com>
References: <20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_next_available_child() returns a device_node pointer with an
incremented reference count.  The reference taken in p2wi_probe() for
the optional child node was dropped on neither the early return when
the "reg" property is missing/invalid nor on the success path, so a
reference is leaked once on every successful probe and twice on every
failed one.

Use the scoped __free(device_node) cleanup helper at the point of
acquisition so the reference is dropped automatically on every exit
path.

Suggested-by: Felix Gu <ustc.gu@gmail.com>
Link: https://lore.kernel.org/linux-i2c/20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com/
Fixes: 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support")

Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
Changes since v1 (Felix Gu, https://lore.kernel.org/linux-i2c/20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com/):
  - Reword the commit message to make explicit that the leak is of an
    of_node *reference*, not of an allocation.
  - checkpatch --strict --codespell: clean.
  - Build-tested: x86_64 allmodconfig (CONFIG_I2C_SUN6I_P2WI=m via
    COMPILE_TEST) and arm sunxi_defconfig.  No new warnings.
  - Runtime test: not performed; no Allwinner A31 hardware available.

 drivers/i2c/busses/i2c-sun6i-p2wi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index fb5280b8cf7f..652b37b57159 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -184,7 +184,6 @@ static int p2wi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *childnp;
 	unsigned long parent_clk_freq;
 	u32 clk_freq = I2C_MAX_STANDARD_MODE_FREQ;
 	struct p2wi *p2wi;
@@ -223,7 +222,8 @@ static int p2wi_probe(struct platform_device *pdev)
 	 * In this case the target_addr is set to -1 and won't be checked when
 	 * launching a P2WI transfer.
 	 */
-	childnp = of_get_next_available_child(np, NULL);
+	struct device_node *childnp __free(device_node) =
+		of_get_next_available_child(np, NULL);
 	if (childnp) {
 		ret = of_property_read_u32(childnp, "reg", &target_addr);
 		if (ret) {
-- 
2.25.1

