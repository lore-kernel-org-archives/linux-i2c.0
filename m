Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD830566E
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793460; cv=none; b=qXxFiTC9tUIMmeygioziBFL+YXjBvCzBTLIGGARHABp8OtfReuaSP1bYGA5x/qHYrxT57jp9ofaIh+qQVteJAQ2lsds3s1QE+S5HKiRCSSWOjxkcR9Bcick5AvnEqP7adHRGs1Ih7y+juleYY+x1cypjub00gZY2bc725+y+r0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793460; c=relaxed/simple;
	bh=3RrLXo8g5qNVx7ZmgCg1GjrH6fG8zBsnfo5ZLbth0eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=planMJi6/wpLz2brbCtXN7Spu2U6aGMo4XpVgmGjo2+inJezoRC9OcUEi+ExkVFACk7nKr0kdVjSIoWq0ssVcEDi56cBL/UMGGX27iNfKMSABjVp+hapJoF21Y/HPr9ULLCPDnzqdPZdIIb3wC9STeGl5vDv0JoXhwsdOSfiPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfDvzvno; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfDvzvno"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c3546924so9025365ad.3
        for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781793457; x=1782398257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWNFSAoF1QlxpTcEDqHs6xokC99S7BGwHt6RGWcEFBE=;
        b=NfDvzvnow+QIfY7pvBhvBScRJaAYEoUtyAPLlwy0+E/ifb8oKLR+i7589LmZPOc8iR
         s57D1DshuMtkmcsvms0hepsCG3UbVjuGovskWaAmq7JpHiTFkuxrS5uZ6YZLxFwFSW9k
         qkJ+yCo8rewaB71i+xzt9vFltTWuhuJ7Zg/GFk3UuyvWM6wgQXRR/OwvdNuGZVqCMK8L
         9E0rET95LQRvZB6wqmTR125cBga5QrQ95GIq3mbG1S8naTZA347tTek22Bw/PIRTXgkf
         W/+253QI/rvUuYzDr8VgjJyHqWVpGpBg/vYbsWrDrrP0ft2R1XUEN+axqdpgn39xiOG3
         n6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781793457; x=1782398257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWNFSAoF1QlxpTcEDqHs6xokC99S7BGwHt6RGWcEFBE=;
        b=fwP4nIuiRCjLOZKtDb7aNFGPslrloiHMbHNs3i8bBwcAanYGKSoWitWCMvRpM4giDh
         9Cd3ty1my6J42PSnLYZ/QTB0wP0/EwSisKQzYyScvGy3VD2wy3VIqN/MDYOiuTUlg/2K
         hKTDbXUOLY1DZjXJZalco8t4MdZJAeZz+Pavv8w1VmcXWziQJK1toYdUbWFlBDsri/BL
         weDPwGD9VhrKLY1tgbAQv8Vsh4+QzK+262fh9TqZJNzRxjjqAuoyS1Z24W5HDTY8MaFN
         azLpzaheY/jkQ2GYXCW0jiuFJ8UYxuwjGIWS+ZY/uQLMpKsxPVonnCT5WwDbC8tt1bjZ
         MqYA==
X-Forwarded-Encrypted: i=1; AFNElJ9WxifvwJfXDrLUHEJ4/5mS0FrvWM8TAptZab6Itl7bfaHUmmbGJKCTwgto+3VwGq4X7cirPGOFvac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaCF/zSDrSn5FAkx/l4x8Aaz+FcwJqKw3+qWpmM1mNHrG7CS0Y
	DWyW+9hCarsk/q/hf2l6kkoyJJ3p+V70/BWXjHm8+HKHja361bhUPxk0
X-Gm-Gg: AfdE7clFHOO9/rMaP8RWdOa31c60dIM0O2VuHUwvrwwXpuZ8ie2ebI9+23Y9PKFBB+R
	mKeMJO9S81nuTLhJBQH01m+eOC0bJmvANXelWH6p3U3vgsH2705wNAUz+iSZVRDMknEpOL5jWlY
	tpmb5rQGLTl+Fsmk38ong/jC9//vANeoQo32IeMC546WqyRSpWOAU4SLWV00JPyyUPdbeHsY+Ni
	20mntrobSEhq2cgO676TcGJx+zGpTbn55Eq5eTPgdLgzqVy4pOrFDh1eiWN7ZQgz1Hq5WeTmwVu
	r+7jcrZNUHRpCIkCeDHaL7lFPYHxd7wpkqj7To8I6VUsHOpSRb1Zm62pFMIAhY8LOUX9385rLFu
	Mw9vTNVgWYvpISoDmcaIJfzZVPvBSvR6uDlTwWxqWsRtyN+Yu/LFznFvQlXpX0aiAMsgDKiFAUO
	RbNj6AXEDdfpg0jcY3VZEP0FNqsNKsb6YgCuTCqFzkbg==
X-Received: by 2002:a17:902:f64d:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2c6e47253b2mr49138885ad.8.1781793457447;
        Thu, 18 Jun 2026 07:37:37 -0700 (PDT)
Received: from steellegend.taila75641.ts.net ([2409:40c4:35e:20d7:2ccf:7534:4b88:ba43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6f9aec764sm22554115ad.2.2026.06.18.07.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:37:36 -0700 (PDT)
From: Uday Khare <udaykhare77@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Uday Khare <udaykhare77@gmail.com>
Subject: [PATCH v3] i2c: sun6i-p2wi: Fix device node reference leak in p2wi_probe
Date: Thu, 18 Jun 2026 20:07:27 +0530
Message-ID: <20260618143727.18534-1-udaykhare77@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Fix this by calling of_node_put(childnp) on both the error and success
paths.

Fixes: 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support")
Signed-off-by: Uday Khare <udaykhare77@gmail.com>
---
v3:
- Revert back to manual of_node_put() because the function uses goto-based
  error handling, and mixing the two styles is discouraged (reported by
  Sashiko-bot).
v2:
- Use __free(device_node) and include <linux/cleanup.h> to automate the device
  node reference cleanup instead of manually calling of_node_put() on error and
  success paths (suggested by Chen-Yu Tsai).

 drivers/i2c/busses/i2c-sun6i-p2wi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index dffbe776a195..7c0239f8937e 100644
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
@@ -217,14 +216,19 @@ static int p2wi_probe(struct platform_device *pdev)
 	 * In this case the target_addr is set to -1 and won't be checked when
 	 * launching a P2WI transfer.
 	 */
+	struct device_node *childnp;
+
 	childnp = of_get_next_available_child(np, NULL);
 	if (childnp) {
 		ret = of_property_read_u32(childnp, "reg", &target_addr);
-		if (ret)
+		if (ret) {
+			of_node_put(childnp);
 			return dev_err_probe(dev, -EINVAL,
 					     "invalid target address on node %pOF\n", childnp);
+		}
 
 		p2wi->target_addr = target_addr;
+		of_node_put(childnp);
 	}
 
 	p2wi->regs = devm_platform_ioremap_resource(pdev, 0);
-- 
2.54.0

