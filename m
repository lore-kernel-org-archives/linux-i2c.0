Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B73A2566
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376843; cv=none; b=fA8fJBUlKK1CLEk43F9QC0qouTTgl96Gja+cU2oIqtIZoJsLjN0//55t7ECOHZg6LjolksY2XC4DOX21fFUIeXThcoJ3AXLKw8N4PzbZqKzUtGeh/WJ1axFo84pHE20vzZzDKCUV3TcwjRY77nU2EdH3wOwe0/b2ot1mM6WcCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376843; c=relaxed/simple;
	bh=WceX/6ppqZ5DUDCGfEWL1pZY9tLdtFM/DeuPHESZPQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3R47qlohky9aCmNtHEEm6QOH4nqe56v/KFRHiqroNXXHtrnhuFLkjBJBGOtrEfpyU1gRES01U69c6P4G6K82Cv8tfS+LEE73M4PMKozbgSBcRPCBZokMJTC0vzbNDoDICt3ELtVCOO3M3+GXmpP7k1NblvEarsM3ZF4a+OAgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1OR6qgw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1OR6qgw"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35b88a4f123so69417a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376841; x=1774981641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JU53ztXeIg9rAt/w2RhxQEA1HrNV+jGEvjmkGqWYdZA=;
        b=N1OR6qgwQZFIk1qimWDJyLNC+TZimmi7uUoEB0KNSGLSQ6R8NqoJvBUMPtkqrn/hUi
         5d7JWuQhIS65yAhQspsKOpNRvA5T/olX2q0F2IfNBMUTtFoKDQP0yaH2p6cy3G53A8LT
         4scid4z+Trm7rWBKmp0M810wqUhWF/HLjnl8OEg1FDuBVSOiYWNtfVFBb15VIUBPjOHR
         SaCWhmunjTbPRZBz41LBsud4/ZVhv7JSOI8JkY2Lc+4TjI9PkSbjyjoYQ+tANwPQrz48
         pee7fBS7IEfZnEwi9jG5lJPkLVey2125luyoENugBAx7jDkrPRMdNNLAjTkB4NtMwi76
         kQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376841; x=1774981641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JU53ztXeIg9rAt/w2RhxQEA1HrNV+jGEvjmkGqWYdZA=;
        b=SAmPatHBXzAPTcGyTlHbS/9efoPy6kWYuBzp/saJyltAh5nEElvPkNhYuWi2eN0fFl
         z6tVZHG11qvwzqxkLRM9xey0nlOz/vhERfGk7jcRXjSYYaUWHlq0OOSYT4qUytszjHMJ
         mM+9cHExp5J3XQBJRRtgQzImqVi6jD2cud52if/OqrSBudiTuQLj6uIt4mhk1EyO7Q65
         Ag9K8Xj7cpOokhI84x+Pt5gs9/fBBRjv4e+eZw3TxA00VJzb/nKHPdyEcHorgyFwQC68
         B99Ohwkb8vRR6j1JziQSgYke33Ia4VqkHKh+0LRM3f/3PIlrXqBLEbtQ6bJfBQXCfm9r
         Ue8A==
X-Gm-Message-State: AOJu0Yzynbx3yX+mhPfOX0LWx16lMSoH0BE3JN/W1rrMIdyfYt44trjz
	rMig295Gd8cbznacuosaf/eZMBq3lDyTn7i0TYPvMkW1bEVFwAOhXCjuI4QoXay1zNE=
X-Gm-Gg: ATEYQzyZ3DOnBp+YZHYJ0QzApRrrY6BkMS/YaYtR+0+XknUsp9CqU7Og7/BPXTWd0WP
	gFTRKiu3QXNn3FyUbERKe1piJlBU1pOJxynpPMmkIr4P8XNauAGmR4he4UctzKdfXN0awBxFKa1
	pkj6PJ7hScSJ0tTgLgrJmghwZ5J7WY0PY2yMbHNIRIA2gW0jpldT5pq1HFx2PFh4I1qEqE5cNVS
	BFd2ppNX6ermZocmB0HEXKuYGuFgTtnn4JnewQZK1etj4iTDjBr2KD+ROF7Xv55MW5I3xLAIrKc
	D64aFNHSx1o9J4WaM5FVFLqAGXGagOYGuAN741KDxcFMYHbqNN0Yyh6aKGTnTQ2X4SY8UxLTh4e
	1S68mmAvgGquX71I0/kpO2mBeHL844CkzUxlLmc0yxYeaRf0wRHPIh8ufNO6+s4vC235MT/AQDb
	P9YJLy1gSJZLWsTvydjeijJMuH5Q==
X-Received: by 2002:a17:90b:57e3:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-35c0d1451d7mr559615a91.8.1774376841343;
        Tue, 24 Mar 2026 11:27:21 -0700 (PDT)
Received: from [127.0.1.1] ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0d6060b5sm350576a91.17.2026.03.24.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:27:20 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
Date: Tue, 24 Mar 2026 23:56:49 +0530
Subject: [PATCH 01/10] i2c: tiny-usb: Replace dev_err() with
 dev_err_probe() in probe function
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-deverr-v1-1-7e591cce33a3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774376818; l=922;
 i=atharvd440@gmail.com; s=20260314; h=from:subject:message-id;
 bh=/rm2EO54Io9Vb7rL8ZSyeOBixCamQEqxJe9F/gCdBcU=;
 b=ndfdbjfGLfy7wqu+RVI89cU1BdFSOOxdC43vbHuPhEqbITAhbeTXofEpCDO4hCGofdSsBz5rg
 /eaMZdocnKzBw4U70BqYrFGGqU2cbJzMF6jNMLwPSl+hIPTFUD50Y/N
X-Developer-Key: i=atharvd440@gmail.com; a=ed25519;
 pk=T6i1xWOKT/RUSDYATSgyVG/4X7ac8jPjRSG1mMAcqVk=

From: Enrico Zanda <e.zanda1@gmail.com>

This simplifies the code while improving log.

Signed-off-by: Enrico Zanda <e.zanda1@gmail.com>
Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 9ef495f88ef2..0637c71126f9 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -260,9 +260,8 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 		 dev->usb_dev->bus->busnum, dev->usb_dev->devnum);
 
 	if (usb_write(&dev->adapter, CMD_SET_DELAY, delay, 0, NULL, 0) != 0) {
-		dev_err(&dev->adapter.dev,
-			"failure setting delay to %dus\n", delay);
-		retval = -EIO;
+		retval = dev_err_probe(&dev->adapter.dev, -EIO,
+				       "failure setting delay to %dus\n", delay);
 		goto error;
 	}
 

-- 
2.43.0

