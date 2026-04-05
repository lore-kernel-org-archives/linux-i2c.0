Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90A224AFA
	for <linux-i2c@vger.kernel.org>; Sun,  5 Apr 2026 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775359650; cv=none; b=uS4rUroEmU83exY2eHl1rmcNyQrGB25rDH85svltCa9lqaqJPW2wJRsSHqNSYXKOdkwLxdzF5yUIdsuAeEmJtbOp0itEEGA1j6DD1r9FZlISAOYOnghCqp393eZjjKOMhYGc6vIj2FSoaJxkRNx4di11wA1PpI87CoeH+5vQRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775359650; c=relaxed/simple;
	bh=DDLHQlFyINNey4rl+Xmr5SI5EPgFf5EE9HdWMzB/WYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzDndujlrPjmt6u1fobXtzk8mJaA2wQBSxtQ3BgILgyckb4D40oFuGfr9/vC897UY2EvhSx528K1cXamepIIi7gJgjBWOWCOyc9qOVnt4e7r8oRdlf6eanmOQy0TmAboxuhj81myms/DOqON/Eua+vxY7NPaQwZcrbsbCFI3HGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls1ooABk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls1ooABk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so18308685ad.3
        for <linux-i2c@vger.kernel.org>; Sat, 04 Apr 2026 20:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775359649; x=1775964449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=//rBlaMcln0/hNGUeQZiaCEO2voM0gCEJk+aW3TsCHE=;
        b=ls1ooABkRLRdJzcZqyCJPQb3W6pgYF/Y5cG2ZUGUNMh9HX+xn9d5GQ9KrfKviSDd2R
         YJWv49mlN8qdVvR+xr759UTsxzFefwLeWKtWVNpOkkMG3a7FiZ2T9cm3tWXaaS9zDnPZ
         z22HWeI4tLd9VkbZu0uLYwBcpzRYTWCyzmFTUcYmitcbJq9uxotI0N2v4I1HNq7RZuT5
         143ToQI/6wWgfHBNL7YMX+geSl6/awLjt/sITZuL9BoHdsEqVPgUCkaIQN/vxXWhAGBG
         EwT7NxJl3OTak5G73AXdGN0AYZpJ8rEMaE7QoZPI1Z+yyEpGQI1NolvFCCNIM8J6zHc/
         yrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775359649; x=1775964449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//rBlaMcln0/hNGUeQZiaCEO2voM0gCEJk+aW3TsCHE=;
        b=pmPwnJE58MNd/1e7yJhe5b+zqfMtOG5SSlhqDKmvG0TvauAJzoM1ZKNK0XXNMcTBfd
         Z8i2VcV9ZCuE0hFopXupF9Mvg8TtozfKs7y0KuwiCWlmszStn17j2dS6VIyFySAJQL53
         xlaBRj0jRiKBz9Y+oxLi5FNwBSAAgyU0WqACnqxQRL91Ri9f2HfmWiR7reFSuM5jmULs
         s9/MWmy9WtjTQpZYFQ50wogQMW9TueOkfeSgnIFX/iRhN375hti/gdBn71wNgAl8htyi
         K7PuJUxCIoB/cNmjSnej70fapTmCH5wlmShp2WQZ5/NOkhyskeMZfsxjB3cI2vGaTc07
         UCEQ==
X-Gm-Message-State: AOJu0Yymv2JDoIoa3XzjGZMT2v2TJgWfavOfcSXFg/ahL/Dlj1rMbzeK
	o1WWn+jv4QoIq6imihayOLIdbqiW7n/cAslJva0xr8gqIN61WAZCvTjs0IZCRXxoKG8=
X-Gm-Gg: AeBDietJ6n2WMUtOKNe9wzyNvVPq+27X0ZQpTHmkUNl48MGadqnrtWcGFyJE9sgluo6
	Shc97eZ14+JJEHNZpLv6A3tQdv36tWfGF3EtziyR1QodpYJ3OKk7NAhZIr3pZLteMGdOBFJQWLL
	FXGK9USOF/JQI16WNGxiSz9aVzluMQLTEcRAfdMiGoHIkNHFiwTQX5sJ2NAyFFlv9TaMil6bMPO
	yRvXLMhO6XUgnLX9R64R9bCFOzaoe1c5jvf/565yqyovT87i6txtMR6nd49Wdwa5E3u8nXpN/oc
	pdynxkqQ1CklncGtdH/1r7wMzdw2YCqqgkhzUYBZN4PhpCGA2d+dXe25HDTxTXHBSQc9ktTwT09
	t8G2DHOtgMoWYCW0gdaASBQwDv2BcEooXelm6IX2e86ZAIoXPJ3CwWkHZFnWfxLd2qVQq3xQyoa
	x2QHXUGSz6rfS/lFSVf0HIIDmk4bR6tr/2YSKzId6TNpn99Kuwz0Dqnc3RCuVhd0FacLcuhMzLd
	1fAtnv3FfnYNlQIuqElCkM=
X-Received: by 2002:a17:903:2acc:b0:2ae:826f:2c50 with SMTP id d9443c01a7336-2b281679199mr91098725ad.12.1775359648552;
        Sat, 04 Apr 2026 20:27:28 -0700 (PDT)
Received: from adeel-linux.ad.umanitoba.ca (nat-243-cc-130-179-243-228.umanitoba.ca. [130.179.243.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747530e4sm102527085ad.18.2026.04.04.20.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 20:27:28 -0700 (PDT)
From: Adeel Zahid <adeel.m.zahid@gmail.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adeel Zahid <adeel.m.zahid@gmail.com>
Subject: [PATCH] i2c: muxes: i2c-mux-reg: use dev_err_probe() for deferred probe
Date: Sat,  4 Apr 2026 22:27:24 -0500
Message-ID: <20260405032724.10085-1-adeel.m.zahid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_err_probe() when the parent I2C adapter is not yet available.

This keeps deferred probe handling and logging consistent with the rest of the driver.

Signed-off-by: Adeel Zahid <adeel.m.zahid@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 1e566ea92bc9..bff1b3783723 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -97,7 +97,8 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 	adapter = of_find_i2c_adapter_by_node(adapter_np);
 	of_node_put(adapter_np);
 	if (!adapter)
-		return -EPROBE_DEFER;
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
+				     "failed to get parent adapter\n");
 
 	mux->data.parent = i2c_adapter_id(adapter);
 	put_device(&adapter->dev);
@@ -177,7 +178,8 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 
 	parent = i2c_get_adapter(mux->data.parent);
 	if (!parent)
-		return -EPROBE_DEFER;
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
+				     "failed to get parent adapter\n");
 
 	if (!mux->data.reg) {
 		dev_info(&pdev->dev,
-- 
2.43.0

