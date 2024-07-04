Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1C405F8
	for <linux-i2c@vger.kernel.org>; Thu,  4 Jul 2024 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720131444; cv=none; b=qgOlQ1eonRQwALw5OtpGnoiPoCiEPFpqPA5X9A9YBjb1RAe823AK4Tbq/qOOwAjoy5vfYza+uNwj2YaJcKmdTgZ3woSSloF2HFxP3QTP6CR1BVny8Cqvz4YhApI2tLskF/z/JgxuSSI1C13C1Nx37HZzzYmUYxHllEv1Z2MzlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720131444; c=relaxed/simple;
	bh=U9kX6F2NynFqke8lVdenBDLDD0kM/a5L5wxCfA/OF3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZi/9+KKCXrytRuibxzxlcBQCfzbiqmvfK5Bg0tawSnBTsixiX2Dsf/MjAYUWHXBUO0KgNgo4RAoVvM0pJTe5K4bRGWv3ptb8qfi69VcCxFDlq8JILjhY0VAObDtCf0lOzGy2qTpJonHoypAyvM89fL0/JYcHaNVHdO8OuEt4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVKh5FqV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVKh5FqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF86C3277B;
	Thu,  4 Jul 2024 22:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720131444;
	bh=U9kX6F2NynFqke8lVdenBDLDD0kM/a5L5wxCfA/OF3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVKh5FqVjMkxjqFaASeJTw8Nwe6hJ4n5zXcesQHwii7yTrd5o9zPjOuIrxShRASmi
	 lJcFEg3qzv0EKvS2l1I+59YKcfmeaPeFb41EedD2XWBe39zKrEuGX/VoC92Ehno/Lj
	 +DE4YxXQihhZxeEh0jYxObo6hA9dnObFqNmiAYA4xzCQMJ6gExqJ1dP3pC7N6Gyv/Z
	 ysjk96qGVM5Z/s5HravnF1SxK2sdRqwbXoUueqLCT/N/WLd5FxnllCnot35xW0Zu5h
	 a9ZOhhNunQ/m+MvABdhm2XKIEWgW/KvRmtXSpUISugUMIQP1mzl/5YIUhLFhFr6slU
	 U1d21poUNlLkQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-i2c@vger.kernel.org
Cc: sr@denx.de,
	andi.shyti@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	upstream@airoha.com,
	benjamin.larsson@genexis.eu
Subject: [PATCH 2/2] i2c: mt7621: make device_reset optional
Date: Fri,  5 Jul 2024 00:16:15 +0200
Message-ID: <3ea697be239c450cbc622f3e2e9dff8bf17515c0.1720130844.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720130844.git.lorenzo@kernel.org>
References: <cover.1720130844.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rely on device_reset_optional() instead of device_reset() in
mtk_i2c_reset routine since Airoha EN7581 reset controller does not
implement the reset callback and device reset is not mandatory on this
SoC. This will remove the following log:

i2c-mt7621 1fbf8000.i2c0: I2C reset failed!

Tested-by: Ray Liu <ray.liu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/i2c/busses/i2c-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 81d46169bc1f..8cd89a2f59df 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -85,7 +85,7 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
 {
 	int ret;
 
-	ret = device_reset(i2c->adap.dev.parent);
+	ret = device_reset_optional(i2c->adap.dev.parent);
 	if (ret)
 		dev_err(i2c->dev, "I2C reset failed!\n");
 
-- 
2.45.2

