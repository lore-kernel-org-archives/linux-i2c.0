Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E19328611
	for <linux-i2c@vger.kernel.org>; Sun,  5 Apr 2026 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775360439; cv=none; b=EnLshN1UHw6g6xGauR6JD+4tHWbxZm4R7o6Ja9/cW1+NZqboi1rnEsJDOzKOEe5+LVLhyS9/tDeWK7odpH/DnL9Nyvk5AaZiMlSp8kYlLEiKkHxURtklzMlh/EFlAfuvRAMk3fIIPS6cUKWrfjXqnz/UtJGWK9IX5/+5KAB6uNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775360439; c=relaxed/simple;
	bh=QYam+d4n776bCkVM54lnTAL+sqyeNTTk+1AnYmT3twY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwPKmw2vgFNj7GNe/EaO9yqvM0EXncjoHTWQUx1C7MSPod8+IW9sxRDSvkvNodM94dX0nFtco/C2k9HwljRHQkZaDLvIQV1874+ni+lmPwuh6ebH1KrHF9jSNaCS+Clx3mpk0M1BTE/dI1IWP+N3Ussj7x9Gxs5D3t3G0ke9pt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAZb6V9M; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAZb6V9M"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so18333295ad.3
        for <linux-i2c@vger.kernel.org>; Sat, 04 Apr 2026 20:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775360436; x=1775965236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/FN5NlH0iS1DMIQZnLtbDssQz5F0UojDeaXB8HEsec=;
        b=OAZb6V9MP9rVPLwvgDvuM5rigo/6pLTg6MMmIXPWtYRD1B/opqo8//RIop4xFAxMAd
         0PE/PvBzBq4tOgq343QexkCyat+LqtIjdP86Hbv31Tw0FdgMNQGFGGqk5mhSqT0TW6SJ
         O7N3SE007acT3+uUawHozqXonDYxcRdCt3CMEuN5LLrNADesDok/fGhj0NSjFIWwH907
         5OxGv5UV6ZTl8CbGhykVxST3728WCrKckgAM173VJmdutTJ6v44Mk3EowJ8fb/70gRi1
         5UyvUs0HAHLr0eZkSkilOo9Mt09rIEaFfdL/jv3HxfmiPERbUrWcRyGu13zzIReNeO4I
         zahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775360436; x=1775965236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/FN5NlH0iS1DMIQZnLtbDssQz5F0UojDeaXB8HEsec=;
        b=Ywl5lTTN11iI9cgdyOhXl3+m0K+KQpyI3JNIPwKlG9m+n6Fpkqmnk5W6692E03GjQr
         PR+MZGnnqg82R6fQtsT6ENYQ2e6zurgzT3tYjZlip0QyPn54jymxmOyhgpZ/KZDXyo6Y
         3iCG0Wgmk7f32WhGjfizkLEDGtr70bu0GWVuZ/0E5AcnEJr8aZR2ZDAFa1mlp1M2bIHR
         M5u9YeWdbObXrOL+AQ/5mmc+tiNyyVTICkyOV3MwU0Dgh1/o72wdPC9ZWZDzzlbOhAq2
         nHkIG0uwTWWGkjrc0cX0aORQ0ocG8PEM6upZ7W3uY51afvI4WP5mE/qIjywjQ1mGmmJS
         ZvDw==
X-Gm-Message-State: AOJu0Yxi49C3JzmDpY2wc0vIyQQz7n70FbievPBDVk6RgVL/JCZDUvtE
	l1Vogn6pLFTssrA/tQ+PnhyUbEocz3qpC26fbV7+3neJHevvvU/DVYk2
X-Gm-Gg: AeBDiesbABSsjwMGfMzwS17KZL1YzntEclR3e77spz141IFRatTOwOS2Qcgt3T7/kVR
	/M/He7mhmVuaZMgXlFCNyKstIsbTg876GL2FfcNJ5JVD7xn+gKCbYxw9CSORV+2ZxZE23lLon5p
	F/zCxf4F5FRqPKihb3AVF8I9sUyQF2wMNCg7QWOPytuRhzpCtRh4JXSRs8EKxOaESKDLbLoQJh4
	+gUMbKVi/4O68G8YtkDnskYERbFWca968rNVW+SgyoHWzsZhAgdsz/JfPVQxCsJBZ28H7hCw6dM
	UwIMtkV7z4giip5f98d8SHdCCbX43oOKJemLlDsxgfVZVZuC8klloRjJOROXgKXTwr2DvhhFB9a
	c1VY6j2O+LdzsrEmTkOUOO6dmTtgS7gMLEsVlEaaUCM9j10J0DD02adrZu5+++1UOs+Dqpg/I6D
	j7XVtlpIDayacek4H8MSMrlZGbbvWCOzg2jNeAHilL382nXg5mI15noLr8j1ObYTZdhfkNbVlkO
	dCmrV01yHk++XDLbq/rbTg=
X-Received: by 2002:a17:903:2c06:b0:2b2:4b4e:e4d8 with SMTP id d9443c01a7336-2b28164c3ccmr87459365ad.4.1775360436559;
        Sat, 04 Apr 2026 20:40:36 -0700 (PDT)
Received: from adeel-linux.ad.umanitoba.ca (nat-243-cc-130-179-243-228.umanitoba.ca. [130.179.243.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497aeffsm99743195ad.43.2026.04.04.20.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 20:40:36 -0700 (PDT)
From: Adeel Zahid <adeel.m.zahid@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Adeel Zahid <adeel.m.zahid@gmail.com>
Subject: [PATCH] i2c: p2wi: use dev_err_probe() for clock and reset errors
Date: Sat,  4 Apr 2026 22:40:21 -0500
Message-ID: <20260405034021.12435-1-adeel.m.zahid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded error logging and returns with dev_err_probe() when acquiring the clock and reset controller in probe.

This makes the error handling more concise and correctly handles deferred probe.

Signed-off-by: Adeel Zahid <adeel.m.zahid@gmail.com>
---
 drivers/i2c/busses/i2c-sun6i-p2wi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index fb5280b8cf7f..2be6d50273bd 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -245,20 +245,16 @@ static int p2wi_probe(struct platform_device *pdev)
 		return irq;
 
 	p2wi->clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(p2wi->clk)) {
-		ret = PTR_ERR(p2wi->clk);
-		dev_err(dev, "failed to enable clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(p2wi->clk))
+		return dev_err_probe(dev, PTR_ERR(p2wi->clk),
+				     "failed to enable clk\n");
 
 	parent_clk_freq = clk_get_rate(p2wi->clk);
 
 	p2wi->rstc = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(p2wi->rstc)) {
-		dev_err(dev, "failed to retrieve reset controller: %pe\n",
-			p2wi->rstc);
-		return PTR_ERR(p2wi->rstc);
-	}
+	if (IS_ERR(p2wi->rstc))
+		return dev_err_probe(dev, PTR_ERR(p2wi->rstc),
+				     "failed to retrieve reset controller\n");
 
 	ret = reset_control_deassert(p2wi->rstc);
 	if (ret) {
-- 
2.43.0

