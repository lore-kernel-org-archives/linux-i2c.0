Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AAD3A168E
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376832; cv=none; b=ZYaLloPC+0zXXK7Sy2sP52OHctb8NoO1oS/5+nv+5eKnc0TgDWo4vLoYnWYHlNtrCdAoibM6OJyhaAnbpFgumUK3Lz4612REJoecWbrP0h9OgDsOFXwLYz/v3stE73KsTUXcVYy/nZxLyG6GO5/r2FGYwf5pBqiY8MgUkNFr9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376832; c=relaxed/simple;
	bh=4eB96+tZs9fT6uON/Cp8K3KPDm65oymtk7Doe5oPZv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ukMLFlvKa0PvZ/rhH/YPMf+8RmB0/+8yB0cxZFXccObsFVzaqaKBftzdsCCJ7N2jFhN1uqAhJeLnR9bPOeoWKBI5Uo8w7J2NUueV5Avvu02tHjwyIb0FnLTKZZV/cwE1fWZpDXAzBsWQQVPdaGb4nDUuOAqs9ywZ2wk9GNZ5jCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpEXC/oN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpEXC/oN"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so2790958a91.0
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376830; x=1774981630; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8dxWxemVY09l/RSeGxRpi4JIV8mJaxVcxtXBlCQ2JM=;
        b=XpEXC/oNeo5md0WXZtgCy1QM4IRtU6BT8OM7YHE31BjNGNDNg92JzKXFT7QtK/5v5a
         AqwhYGDl9T5Zja6YMzdcLrMl6rqCK5FMxffZQOcTHT7LTtuWF+/RCKtcICAArLg25q7C
         tgGc7htb4wkLkZkhgMtwb+0g+GwmO/EmhrumW08MmkD5FskL37bxS5eOMDKas3VaUK/4
         lm/F5plj25EHGQBoY0P1v+TqKIBWZt5R0mWdMOoKSsM3ckwWv6IKvcjAd5NjmLS2Pupd
         w6/YksfSTnej2aKCU/rO+BekHmmPw4Bo5QJIkxJ5O6mQgZed2OsFTM6AfkTKZr/FPKSU
         pJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376830; x=1774981630;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8dxWxemVY09l/RSeGxRpi4JIV8mJaxVcxtXBlCQ2JM=;
        b=rVujpWwnSbbJCErM7JB3OLPdQ9GGmsffRiI/gy2Q6aRn8CCJW6/s6jbk8mrqEcKlfv
         rx28IqpnK6jJwNPfqWjpSiDtP0P1M0M4HYBX4eSEOxrDr0nI0Pi9Mvbvt8eUf+ivz+TB
         PZ8TMZoFylL/SkDhAoqpMvbH5HN/hqyIMJzSjz5O52cNMPBPgbTxGTjwc9Dq3eZB/tt1
         Ry29MNyaPfqPgPtx1gO7iCyvW4W9gQ00NnsruPQV+ZHpYLVOxw0VABh9zYGnOVgvO0BC
         4U7A/biE/jKOiR92TnjLQMyszLbgyTMhTwVM61axCQeh50ELV6jWVpzNNR9cU4J9q1Wk
         cUqQ==
X-Gm-Message-State: AOJu0YyZaBJUSFQKBKxgyBDixexSv7HrNIcQp8zbSkXgW5NrTxs2dRuN
	bF/D3l62kEbt/Gq6P4z88oTnpRV0OvzL8e+kzQ6L0mzoIyikISPo+7gdDeq9Kfp6ebM=
X-Gm-Gg: ATEYQzxioycCPIGR/UAaWEt0RSq5ozNcRsVKfIeFg51DC2JNKV66Ayt1HjkUNLo+N4Q
	2aIEiBaoAYyZfciXeFf83Avn2L5sOQOYLKOCwo4p2ltJWpItOzwaw01Xz5OKYGxvNzXDz5X7N/P
	RCelDXVq5Y/ZFZs3mvFt2Ga88xBU+9YSL+j3R+lBT/2Svg7DXj5CDKqzpeVjJKrQD08Mlo9YZc1
	lPn7pZwc+4vVo5XVNLn0u5qWAxbQhEOFaD7nVRXE0MBJgzpyE/S3FahEnnUsyDk4rv6IRF3CCLH
	LNOTq8mzUJq73XkgbMbfosG3Fi6dXD1CApN9C3OgdyHYXh+VvOfH/+txsWmFJbKdWJwTiUz593E
	JXEWCBR7raxdbQ7ckwI49DhRkiYp2WAgCuJIv0G46OMpj/uCr1Ac/RTBPznOwWzpIZysGqjt5xJ
	BVnHoo0AhVnrobHxq19FSch8/iDA==
X-Received: by 2002:a17:90a:e705:b0:35a:329:73c6 with SMTP id 98e67ed59e1d1-35c0dc80d99mr378084a91.3.1774376829881;
        Tue, 24 Mar 2026 11:27:09 -0700 (PDT)
Received: from [127.0.1.1] ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0d6060b5sm350576a91.17.2026.03.24.11.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:27:09 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 00/10] i2c: Replace dev_err() with dev_err_probe()
Date: Tue, 24 Mar 2026 23:56:48 +0530
Message-Id: <20260324-deverr-v1-0-7e591cce33a3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnXwmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMT3ZTUstSiIl2TJIMkg1RTA0NL02QloOKCotS0zAqwQdGxtbUAXM4
 talgAAAA=
X-Change-ID: 20260324-deverr-4b0b0e50195c
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774376818; l=1970;
 i=atharvd440@gmail.com; s=20260314; h=from:subject:message-id;
 bh=4eB96+tZs9fT6uON/Cp8K3KPDm65oymtk7Doe5oPZv8=;
 b=JHbyxUnpSIHVtTKhxJxQI2JLJGqRVx4xwS3l4IGQaiBFJ6HmJ/N18C/fndglYd7QgKbDy3Fs5
 kHTwhOvM/fYAd0raQ4P7x22Q0EFLgoDhJRXmkPQQ67kohmHbtFETWXF
X-Developer-Key: i=atharvd440@gmail.com; a=ed25519;
 pk=T6i1xWOKT/RUSDYATSgyVG/4X7ac8jPjRSG1mMAcqVk=

This patch series replaces dev_err() with dev_err_probe() in the probe() 
functions of each module. 

This simplifies the code and improves logs.

---
This Patch series was intially sent out by Encrio[1],  
this series is an effort to get it reviewed and upstream 
it. 
 
[1]: https://lore.kernel.org/all/20250520194400.341079-3-e.zanda1@gmail.com/t/#u

---
Enrico Zanda (10):
      i2c: tiny-usb: Replace dev_err() with dev_err_probe() in probe function
      i2c: tegra: Replace dev_err() with dev_err_probe() in probe function
      i2c: sun6i-p2wi: Replace dev_err() with dev_err_probe() in probe function
      i2c: stm32f7: Replace dev_err() with dev_err_probe() in probe function
      i2c: stm32f4: Replace dev_err() with dev_err_probe() in probe function
      i2c: stm32: Replace dev_err() with dev_err_probe() in probe function
      i2c: st: Replace dev_err() with dev_err_probe() in probe function
      i2c: sprd: Replace dev_err() with dev_err_probe() in probe function
      i2c: sis96x: Replace dev_err() with dev_err_probe() in probe function
      i2c: sis630: Replace dev_err() with dev_err_probe() in probe function

 drivers/i2c/busses/i2c-sis630.c     | 31 +++++++--------
 drivers/i2c/busses/i2c-sis96x.c     | 30 +++++++-------
 drivers/i2c/busses/i2c-sprd.c       | 13 +++----
 drivers/i2c/busses/i2c-st.c         | 34 +++++++---------
 drivers/i2c/busses/i2c-stm32.c      |  4 +-
 drivers/i2c/busses/i2c-stm32f4.c    | 53 ++++++++++---------------
 drivers/i2c/busses/i2c-stm32f7.c    | 78 ++++++++++++++-----------------------
 drivers/i2c/busses/i2c-sun6i-p2wi.c | 55 ++++++++++----------------
 drivers/i2c/busses/i2c-tegra.c      | 12 +++---
 drivers/i2c/busses/i2c-tiny-usb.c   |  5 +--
 10 files changed, 127 insertions(+), 188 deletions(-)
---
base-commit: c612261bedd6bbab7109f798715e449c9d20ff2f
change-id: 20260324-deverr-4b0b0e50195c

Best regards,
-- 
Atharv Dubey <atharvd440@gmail.com>

