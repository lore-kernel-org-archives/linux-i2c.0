Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5933D6D6
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060654; cv=none; b=NUfTg+2+GywT5K8hoIsKdkMcvJOKYaKR2ZahyX/HijcipclX1lqm5wgCTTq3H46AYSgAMs4AE3MrHHDTv2JY3e7R4QnSHo8QYYUrqQiaKKk6NPxs7NO8wXRr1jnUN3JaY7qboGNQEtbTdpbE4/aoGmC8FgnJuwXS417WdzpA/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060654; c=relaxed/simple;
	bh=htNF8eueg3Mn/3D5su9idQmcI9VgZFrt/5LRaQPDiJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cKtWxeXe47CfdNYkE3f4X99/M/oMkQwBNJmr54aM8+FI0VIhnv99NR7dflEshaWixeUeAP3P/6Vd2jXMXhsR8WEDDTm4oX9CXCyvUr1U6DZiJTRrSKcO5l9T9Re72zx2A/bm1wlQCc097+m1LfMTA0HlUoQFmEGYa+bHhjYlanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNyad0LH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNyad0LH"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8584e80d59so2463492a12.2
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 20:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781060652; x=1781665452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1xEqocq617yA3Nhtp5XMsU0wUBI4nxN63OSaZK9x2k=;
        b=dNyad0LHKEqVJzUvnHWyCciLMxrEsab/vzCR1cqnEEet80xodzdBrfardNIiNTDYsJ
         ClRZIOewDtqEJ7PC5KtMXHCNc13b4CNaP6pb90hi4pJ7cMF1h5W5E2jA1+lfhRq/Ml4n
         sSHdIUSdqVMygnOu4s2U9OCTMWUkCGgsQUQE4oEYUukIHlXchToSgPTWj4wct4c0ALUg
         Niw2rh0EcscKvF6orI5FGK+RyXs4bGHZiIjU1ArHY8ecqIuKXiKdOxXc3Hh36JkeuD15
         3jV57LTlIgVr9vRhLLuLzenS1SnUmY9sEMk4qnrSdcEKkLGJ9WcH2Cu2S5/fClnMXW2A
         9ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781060652; x=1781665452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1xEqocq617yA3Nhtp5XMsU0wUBI4nxN63OSaZK9x2k=;
        b=SbhTJrNlHM9lr6hb0tNepGhd93b9x/4i9hEXvaRK6mKIvG+zNfkRJVIGtsmZH1LGKa
         2mvB+nawKa1QybkCsUBKPK6q5rek6bfPd8dikwMGFLdyEMHAFiDreiCndJG9vwD3FYkG
         XVr99JXkZuTktl4qQPHJDWOX88WYq0TXRBpRxpX6AzYH56GhC5B77udam9Kg6GBl97kb
         ztTa7dmQjCgzPyZbFMyqnhjEl0PnOfvQawq52g3W9AXQbXKRFtOtFIMkoE9gAsl/s92R
         FbI5s1j0SXvQaEFqi1ytvKE2Vjn0FQBeezC+54bMGRHHDG0GYRWSFHUqfr7E/TQjTqdI
         mNWA==
X-Forwarded-Encrypted: i=1; AFNElJ+7J9Hj00EeSGa+Eh44CnF9RhAiJwEgHlxIUBU4arKhub2eoeAjfyTQewHQ+gWZPj/XoG+NNUrM5kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLj0jjNK4TMIdBo1q4pt3O1KDRpXif8qKcsHk1zbYlMPnJfZa
	5lzo/GzqpOGfSCVAR2VCPyLvT/tV7mNUytIF+cZY4l4sj7UMCMhn6rlv
X-Gm-Gg: Acq92OFyQS6LuDa3FinWQqh8WDvPVImZZ/Or7TQKAjPpF1r/DUc4hBmzhbCB6rCnGCX
	A8Y+UT6Bn41j5mdC0mvCG9xjryXlU0AqjZheZbY2uUtycWXoQ82NlMqy4ZPOEAK5F7swjrHLb1P
	uxYH6/EsigxGYy5ewY2CQkwYdknEDTVUQzVzFOFvxCSF4bLIwrxcnsXDxoQONsjrt9ShC62/8/0
	RVPuxQgNqK0DL0sSXL3Wbc73Hb62dXLkDFCfNg/lH+D4X4rJVVELzblkUMvlZgggG8QXp22XwQ/
	HnXopln/3XGxFfUt6FSjrivkB+gV+MVvUWHBfmgL6CLlVpS6Q86jZrVx93PfvzSlvLk+d0lgyf6
	PiBWEV3XNVqlhjmQ9IVHUYNdd1hDnVoINqq+YohcWb0mgKX56X5UmcaKXobnwDiLyP3PNiO2LCH
	E2Yw4Bn/BaXqSNlt8GnE2nShbUaOkVjIH+1WVMhmX1fDYTlMB8A2h8dpWIJnQAje5S11VJcGM0E
	IJ5FYnM1kRCbYp8ZmXt
X-Received: by 2002:a05:6300:6d8b:20b0:39b:ba95:b14c with SMTP id adf61e73a8af0-3b4ccf4051dmr17145756637.24.1781060652242;
        Tue, 09 Jun 2026 20:04:12 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a61b3sm19927082a12.17.2026.06.09.20.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 20:04:11 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v4 0/3] i2c: ma35d1: Add support for MA35D1 I2C controller
Date: Wed, 10 Jun 2026 11:02:05 +0800
Message-Id: <20260610030208.2020275-1-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the I2C controller found in the Nuvoton
MA35D1 SoC. The driver supports controller and optional target mode
and runtime power management.

The implementation has been tested on the Nuvoton MA35D1 SOM board.

Changes in v4:
  - Patch 1 (dt-bindings):
    - Update example interrupt number.
  - Patch 2 (driver):
    - Remove redundant spinlocks and fix 'irq' type to signed.
    - Fix target address recovery in ma35d1_i2c_reset().
    - Refactor IRQ handler for multi-msg reads and NACK/IGNORE_NAK.
    - Fix timeout UAF via explicit IRQ disabling during recovery.
    - Drop IRQF_SHARED and fix PM paths in probe/unregistration.
    - Limit suspend/resume wakeup logic to target mode only.
  - Patch 3 (dts):
    - Add missing i2c0 node to dtsi.
    - Switch SoM configuration from i2c1 to i2c2 with updated pinctrl.
    - Add nau8822 audio codec node under i2c2 on the SoM board.
    - Drop redundant i2c0 alias and clean up dtsi property ordering.
  v3: https://lore.kernel.org/r/20260512073953.564323-1-zychennvt@gmail.com/

Changes in v3:
  - Fix minor DTS formatting issues (whitespace, missing newline)  
  v2: https://lore.kernel.org/r/20260316063726.41048-1-zychennvt@gmail.com

Changes in v2:
  - Overall:
    - Rebase on linux-i2c/i2c-next
    - Switched terminology from "master/slave" to "controller/target".  
  - Patch 1 (dt-bindings):
    - Simplified description and fixed 'reg' size in example.
  - Patch 2 (driver):
    - Modernized using devm_*, generic device properties, and FIELD_PREP/GENMASK.
    - Optimized power management by moving clock control to runtime PM.
    - Simplified code by removing redundant .remove(), .owner, and inlines.
    - Added dev_err_probe() and default bus frequency handling.
  - Patch 3 (dts):
    - Moved i2c aliases to board dts and reordered nodes alphabetically.
  v1: https://lore.kernel.org/r/20260302020822.13936-1-zychennvt@gmail.com

Zi-Yu Chen (3):
  dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
  i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
  arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC

 .../bindings/i2c/nuvoton,ma35d1-i2c.yaml      |  63 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  20 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  72 ++
 drivers/i2c/busses/Kconfig                    |  13 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-ma35d1.c               | 778 ++++++++++++++++++
 6 files changed, 947 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1

