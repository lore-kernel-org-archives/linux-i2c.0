Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFF48032B;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991314; cv=none; b=Y9n/vqBJvm8SaDzbTO7NVjoR/TBXYuO68mNhCDaJRb+HfJ83sgOZG3lu1QeGcBdElanHKyogqeJeOGNVnkJPP94yJ9FqeVOQE7qvNtZMsm7DdBz8HuMJbYJ0enPclEyFaGOPQezJ8xGKuiDhhQlTZDYNPtgtDsi1Q+M6u03DrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991314; c=relaxed/simple;
	bh=GVNjGWQe5bv+gTghSpE+56z4pksH8B5uOoLXv1jc2DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7LdDdpvc5faZ7qTAbWQWDmvoyOqfGAwwPo0FdxJg63P86ODcyluhL7ixsAQpNFMydcokZdlTqCw8TDr3pGxTqCUY9GQYV+HeSWodNHKDdaK19hRBEwKGsxfxo4ai5Ahgstlst8KmnYtySSvmd49SYmxWrkGBvYmuBmo1b4B6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So/GGH5l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So/GGH5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677D1C2BCF7;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991314;
	bh=GVNjGWQe5bv+gTghSpE+56z4pksH8B5uOoLXv1jc2DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=So/GGH5lw10lbCJOq5uU2s0unc/CkzIJy2jJsbB+Ze5g5VIi1Vw+4RwB/lrtvZ38S
	 ZOsIAXBEEJfJZSzJxvkRkMRDyugKojBl3gYbZiwl958V1qfhu6H0RRREuXXjuuyXH0
	 Rp088w2dp9r1A+xNl+mYurWgMnQPJwUoK5kNxVfv8Dnh/p6TyulS383wIggkRYt6Su
	 naMqNYup/6x6NqB5bNDM8KO6XL0fPPU9hJKGlQnKQbm81eGgYmDtRU/9Lyl2J8edfP
	 bdiepPcW2EdXpKB+WLSWoawd4cHCXWlbKxSDSaauZeLd0tEWkk/5y+s1noaI33Nd1l
	 2N6zEfeXT4Cjw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKGlE-00000003Ksy-0Wxo;
	Tue, 05 May 2026 16:28:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 4/8] i2c: core: disable runtime PM on adapter registration failure
Date: Tue,  5 May 2026 16:25:43 +0200
Message-ID: <20260505142547.795054-5-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505142547.795054-1-johan@kernel.org>
References: <20260505142547.795054-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Runtime PM is disabled by driver core when deregistering a device (and
on registration failure) but add an explicit disable to balance the
enable call when adapter registration fails for symmetry.

Fixes: 23a698fe65ec ("i2c: core: treat EPROBE_DEFER when acquiring SCL/SDA GPIOs")
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 6f198d1325a6..31f7d43e4ab5 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1609,6 +1609,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	device_del(&adap->dev);
 err_remove_debugfs:
 	debugfs_remove_recursive(adap->debugfs);
+	pm_runtime_disable(&adap->dev);
 err_put_adap:
 	init_completion(&adap->dev_released);
 	put_device(&adap->dev);
-- 
2.53.0

