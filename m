Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D63A2566
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376854; cv=none; b=YFsp5an1M/TqpgJ/4vP2mQpGS3VZEuaxzTlziIgKFw+Fj/m+t1FDfrh/q8bp6T2et9/xX3WuNfZBbU/E/jHYABWDHRWEVy8f1Au5xqLR9aw2eVJFZXqyVTFYuKV7aDpT8acdIrDWdx+sr7cAmiYoQA71o6vdsbtE8YzkvPZ/szE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376854; c=relaxed/simple;
	bh=+c/3pLSCjN8W96sioUUAyB3Q4h2iU9EyKqZsQlwSrmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RcJB5urf9UoHjh9Ry96IVNEmPgkSUTvIUPpX5M4Y3lx8Hqc4okhMcnV01yHDiBLE8Slg6UlSp55r70UQ0S/P/iFD5ttQ83wt+mQlsXT+BbEE+nldTyZX8dlghXjImRQMOx/Sdeh1lU7lO1WVjY3Eb1U/FQC0rw7/syKxZevH8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC+or1ZB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC+or1ZB"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35bb7afdc38so849224a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376852; x=1774981652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Gsg2Xtdfdl+8IY6r0o/RyYDfTlBlRsSZJpA/oULFGs=;
        b=GC+or1ZBszh9b/mDXpyH6YFSURr0Y7FWzKFYXJDiHRRqorLsJ662RFHGQO6Rh2nR8T
         oswnXCPH9ejMEIda9bLMUS6333IvfiZol2LGDVpZUTvoOlKIt/ifsA+VX1MDE9SJBerP
         Pz/dvsPKLzzLalpazat9fha9s/qqJ+HE2X1R3Ac32KjrOZqYUNAadRzu40i5FaJH7gEL
         RD+nDC6/ZIS/vlM3GAXn+ro61ShH5l17OLFsWgT8gbAzHMt5ve2ZPRoxaEnNEH1+FmOQ
         Tz0GkRr4brxK3jmxMYEBef1q3853H146BClaMsNTRhFsjT5P6bZINZ8q9ev5LG3UWAVN
         6Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376852; x=1774981652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Gsg2Xtdfdl+8IY6r0o/RyYDfTlBlRsSZJpA/oULFGs=;
        b=qigurwHqXQOoUH7KOXokU8g7X2A2vAd9RqgrwiMdt6Ue+Oi6PS/RxgrD+F1/JbrTnY
         EdVbVnGwtwk5OjIcY37ghZxKkgKrUXyRLk3vfbEhzMsf8hrwSHrqiICoGD/6w+RJ/1os
         PL27bIWwGCT++xU33xaGWey1bmgC6T9d9upSESRiPvMwLrmE6Pzro48yu9sxoFDQo+PB
         DPii+o6U1KatFxNYk7x+wiLJaM4FGN7gQdy1iWOJpdcUt2el/E6WGwXiz575w6p0hFn+
         S8OLR1J0wo067i9et0EwvONOuTRzfrlvUfyKnyVF4LjwrX+qM3Oi4M3FCqkm85M6Abdo
         /clg==
X-Gm-Message-State: AOJu0YwVwFCzt2yUIyArPS482B/7cplgdRZkQjOCS4218k/ishLfY0dF
	rnDSrbKC69INnIHuQgP0+fKOjK/6yvCw90QNTNxwDRciK+mHiG4NSqhPCsK4cO2GtHk=
X-Gm-Gg: ATEYQzw8mCvylgSd7S38Jyo0ly8TnbBeTUvewWMRoqnzRurUJkbCNhWti8mW+UnBDqN
	GMaOEJhdy2U14pc6uT+MNgJFAoLHQPD7ZUmRisbJUHIDVFL9jpXfB9MsF62g/kCZDdsw/LmkMKI
	hbAVFhxsXZUQz/YaBemvhazdoBZ++VNZVUgm6aIjT7jtD1AvNIEqW4Wmaf57zw1jcXQJAp767O2
	1rSX+6239C5yM+YxI/cNZBjClZpn0ZfKNFTygSSaTTVTPKh8lS7d0qZS9UU9ucbuVTwiKgvS92J
	NQBwL/TlNGw2C0jdSQ3Vw7WD2Mv792tgGfLeFrvAFHm+fabCBllfB4a2YF16u8oBkVZOsg3d9uO
	PejJttcATsCmQzB6BagMrobsnaLcMJMq1dCb7su+ZJUAAfa7scbp20joN38T9mydc4ccpp8HS6B
	2SN+/0QG9itnmdzjxqmbNj0zwxxEi/8CnSzM/E
X-Received: by 2002:a17:90b:17c8:b0:35b:e591:99d1 with SMTP id 98e67ed59e1d1-35c0ddc4118mr351953a91.29.1774376851910;
        Tue, 24 Mar 2026 11:27:31 -0700 (PDT)
Received: from [127.0.1.1] ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0d6060b5sm350576a91.17.2026.03.24.11.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:27:31 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
Date: Tue, 24 Mar 2026 23:56:50 +0530
Subject: [PATCH 02/10] i2c: tegra: Replace dev_err() with dev_err_probe()
 in probe function
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-deverr-v1-2-7e591cce33a3@gmail.com>
References: <20260324-deverr-v1-0-7e591cce33a3@gmail.com>
In-Reply-To: <20260324-deverr-v1-0-7e591cce33a3@gmail.com>
To: Till Harbaum <till@harbaum.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
 Enrico Zanda <e.zanda1@gmail.com>, Atharv Dubey <atharvd440@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774376818; l=1910;
 i=atharvd440@gmail.com; s=20260314; h=from:subject:message-id;
 bh=T//TFybKN0iS3J929ONSQMLq+NVtMUv+4U4PajSEtpE=;
 b=fr2E/ILXide+l6/sGLPzjFEjto2BGT6qqnz9x0FPbuW7SDMBkCcBooGAF0nF3tgg5wQpoDzh0
 nAnDJBBoQYcAomrkw15oBfCFd8unXKN1lYuv+oiXhwJuhidayGEmEVJ
X-Developer-Key: i=atharvd440@gmail.com; a=ed25519;
 pk=T6i1xWOKT/RUSDYATSgyVG/4X7ac8jPjRSG1mMAcqVk=

From: Enrico Zanda <e.zanda1@gmail.com>

This simplifies the code while improving log.

Signed-off-by: Enrico Zanda <e.zanda1@gmail.com>
Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index bec619b9af4e..51d15fca82fc 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -575,8 +575,8 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 	dma_buf = dma_alloc_coherent(i2c_dev->dma_dev, i2c_dev->dma_buf_size,
 				     &dma_phys, GFP_KERNEL | __GFP_NOWARN);
 	if (!dma_buf) {
-		dev_err(i2c_dev->dev, "failed to allocate DMA buffer\n");
-		err = -ENOMEM;
+		err = dev_err_probe(i2c_dev->dev, -ENOMEM,
+				    "failed to allocate DMA buffer\n");
 		goto err_out;
 	}
 
@@ -588,8 +588,8 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 err_out:
 	tegra_i2c_release_dma(i2c_dev);
 	if (err != -EPROBE_DEFER) {
-		dev_err(i2c_dev->dev, "cannot use DMA: %d\n", err);
-		dev_err(i2c_dev->dev, "falling back to PIO\n");
+		dev_err_probe(i2c_dev->dev, err,
+			      "cannot use DMA, falling back to PIO\n");
 		return 0;
 	}
 
@@ -1953,7 +1953,7 @@ static int tegra_i2c_init_clocks(struct tegra_i2c_dev *i2c_dev)
 
 	err = clk_enable(i2c_dev->div_clk);
 	if (err) {
-		dev_err(i2c_dev->dev, "failed to enable div-clk: %d\n", err);
+		dev_err_probe(i2c_dev->dev, err, "failed to enable div-clk\n");
 		goto unprepare_clocks;
 	}
 
@@ -1979,7 +1979,7 @@ static int tegra_i2c_init_hardware(struct tegra_i2c_dev *i2c_dev)
 
 	ret = pm_runtime_get_sync(i2c_dev->dev);
 	if (ret < 0)
-		dev_err(i2c_dev->dev, "runtime resume failed: %d\n", ret);
+		dev_err_probe(i2c_dev->dev, ret, "runtime resume failed\n");
 	else
 		ret = tegra_i2c_init(i2c_dev);
 

-- 
2.43.0

