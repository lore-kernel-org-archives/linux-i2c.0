Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6C396566
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376894; cv=none; b=AkDyBc+gdv2+ekg7erjDF9Ww/i8dU9wM2/5NVHHyzBUfKwht6nYmiD8V2AVRbDAQovDDVmejH8hESOpjgqgEFppRErfYjJRFJ4y5O6pZOw+exEUmmkMH4+YESA46cd/ix2m2lEFHyYy2mt0BUx8rXfklfW9/vLlOBBQfGGb2UIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376894; c=relaxed/simple;
	bh=iap5qBBPM9+z7GkIgQPTPNBQ4CZotIn48Ss9ISZDGxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jwwqv+OlDbildmBgZwJlBbQ2cc2vABgXCA343uN2nItoO7KhndO2ki/eeH4qeh1EkHAN/z5NP+/P6Iq/sNWkEuUnSWXdJDpqqua/6tFAIjmINEGzS43qoKDMpVsqg88d/8vQ8esN3mC5JNYlHuaPq9phkS1jGv7EGEAgUnpGOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKoCeDce; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKoCeDce"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so941568a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376892; x=1774981692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOh7L59SGXDe0n/0/CxydhLmu3Ccl2K/OUt14k5rUoM=;
        b=FKoCeDcel0G0anI6qTVqErqOwL60iPwadrkclMevwba2YpJpSB8NUHG+kmnypHCqRN
         gOyu09/OzA4cQFLGKSNcf0Kt+Wfpb95E22E/fhzEf1PqwfPDnnzfAa6lWOyjbLxQMtAV
         UIn3hZOLcB0FwgSNahhtfHE/U0TEebgJkVvvY3O7MEfJgwuB6Eqp0a0FUZl9v16fTNCb
         of2L9Eo5qthsbwzP7RSs04VhPhNpOBt2+RXLSC8CfKSJnZq0uPjxBRP69m+Bo6AXwT5R
         p7AwEFYOXRy3M5tbRFLIneQn2+1rzYzLjfP4e3oTt01TZpX4SNPD4h4zwd/aG50SJdCz
         tSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376892; x=1774981692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LOh7L59SGXDe0n/0/CxydhLmu3Ccl2K/OUt14k5rUoM=;
        b=BacH4tzNXdcE5UjZ6hqs2VhJzkyXuTHTqZ7ikFKkB9E2ZAUYl1NrRu+qll9XisMsBp
         TYO70C7n3QGBla7kPgcZUE7yL96rkZSNOPbXZnDaPLFW8oyNtJvdoQtWGC9DvvZmO79h
         efWt4fnuGvUBdIA3qPOlUfpQUop3Q6X5d33K/JmYBXHRlCu+ME6hlNzN5VEzqSsjVMwg
         xcPVBebpOQw2UTYM5yObtrg0qAFKTJ4+/W8l5QhMM+iYYq0473t7Bv1mq3Mfh581/Khr
         r41Y6iO3S/HG4p7r7e8zzuRwfr2HrjFuF3W+2cQRYzp9dIU+FgF5vBt+HwzT3jHgU8Mp
         a2JQ==
X-Gm-Message-State: AOJu0YwCs1OYbA4ZE4X3pls1dakWoJNq1GJvosnrpm4Z1nIoU9uwZOKF
	TrtX4YUPhTg+Khx5H2LuXOl9k4WZqL4b6i5i/k9GSTt0x+TICoaaZnCzVz0itxhQRrM=
X-Gm-Gg: ATEYQzyL5j/NHcSckmS9vXVCzZn0qU83o2YDBDmmx2flthwtKmWzi3MUkH8aAEUZQTI
	wSbF0KkZcqKeFWzydWuGMPKXUDWzxRNBnrvGQLPhoBCJTn6fhYJNlol46dg3FIzG1gvUOuceuZq
	lFjWphbMrSZtcCwy0utqX6khHRkIzVsTfX1hSv5S2oK8XWGukn/FEw3lbVnGQDfKR3jY3PEC+vf
	SVVgRHH7uaZADIvFnodoj+qApitIPTfK9NvGOxR0kZ6C+yqoNJ765HZHU68y8Hc9in1iaep/mkL
	mfb5RUsFE3yW22F1qLlNml6IpzyFgUhjl+2klmTjZeEhDWol6vFWyPChaH7qKFca9AhuKWgEs06
	fXu407+mFZP+4ey3YXcYxlyj84u+f15K9VCd+rWso82uNtUdh2+3nrbYQeiAnmJhG2L/toUf68P
	C1ewLm6Xr0IShapuRLQ9u2fkdH2g==
X-Received: by 2002:a17:90b:4a4f:b0:359:f22:8879 with SMTP id 98e67ed59e1d1-35c0ddb253amr350462a91.22.1774376892133;
        Tue, 24 Mar 2026 11:28:12 -0700 (PDT)
Received: from [127.0.1.1] ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0d6060b5sm350576a91.17.2026.03.24.11.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:28:11 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
Date: Tue, 24 Mar 2026 23:56:54 +0530
Subject: [PATCH 06/10] i2c: stm32: Replace dev_err() with dev_err_probe()
 in probe function
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-deverr-v1-6-7e591cce33a3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774376818; l=1144;
 i=atharvd440@gmail.com; s=20260314; h=from:subject:message-id;
 bh=fGh6XbxSkvU5zsFALrHQqBdXVjE2X7LO7LjtYihQc1Q=;
 b=bSr5WSYN2sBbQ56eV/RU7Nsc30A+f8iif2b8KvF+i2QPU4oV/n2gxZwRlmFwYUL0Sn4WgwU3t
 BHbt5Op51GJBjc0aJ76ljbLTb0hDHykJdiMU+4SpjB/VkJQQUf6r5CT
X-Developer-Key: i=atharvd440@gmail.com; a=ed25519;
 pk=T6i1xWOKT/RUSDYATSgyVG/4X7ac8jPjRSG1mMAcqVk=

From: Enrico Zanda <e.zanda1@gmail.com>

This simplifies the code while improving log.

Signed-off-by: Enrico Zanda <e.zanda1@gmail.com>
Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/i2c/busses/i2c-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32.c b/drivers/i2c/busses/i2c-stm32.c
index becf8977979f..064e47d6c96f 100644
--- a/drivers/i2c/busses/i2c-stm32.c
+++ b/drivers/i2c/busses/i2c-stm32.c
@@ -39,7 +39,7 @@ struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
 	dma_sconfig.direction = DMA_MEM_TO_DEV;
 	ret = dmaengine_slave_config(dma->chan_tx, &dma_sconfig);
 	if (ret < 0) {
-		dev_err(dev, "can't configure tx channel\n");
+		dev_err_probe(dev, ret, "can't configure tx channel\n");
 		goto fail_tx;
 	}
 
@@ -60,7 +60,7 @@ struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
 	dma_sconfig.direction = DMA_DEV_TO_MEM;
 	ret = dmaengine_slave_config(dma->chan_rx, &dma_sconfig);
 	if (ret < 0) {
-		dev_err(dev, "can't configure rx channel\n");
+		dev_err_probe(dev, ret, "can't configure rx channel\n");
 		goto fail_rx;
 	}
 

-- 
2.43.0

