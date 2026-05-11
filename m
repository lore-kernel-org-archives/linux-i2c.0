Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259E23FF88D;
	Mon, 11 May 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510245; cv=none; b=D8BKglDrcveD8gnfMSRkeVJGywbsXJ9OeSRqvLjnzxSF27T2MLdcOGI52+f/Coezkz3uwjctSl508s9rAimmOc4GMBpEn3oq7hvhLND/EQz6Pabpb1ynQytWphVKFTmDiSlhzHGbmRWzzjdxy5EOQtswyDkOwTCd2xOwDx1w1cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510245; c=relaxed/simple;
	bh=30zEGKWoFiUVcuTx5dE6SloFHb/lSaCwgtqhVJSD8PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bB4tW1dxPamWFiBUx5A/6rPL23GNJT+RpsQzjTFoTV8LatxwIQotx27rf7X3UR5iaH6AYC1tDV992mreFAvoleEqa4mcSKLsNj8R/Rer8AQjzTzdZgKVe3iJLKlR9cdpsmoPAv1dVm2Fn2uvewRjyM4D6kiOjB3Y0m4GvwkJqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAKzKpgy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAKzKpgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51B7C2BCFF;
	Mon, 11 May 2026 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510244;
	bh=30zEGKWoFiUVcuTx5dE6SloFHb/lSaCwgtqhVJSD8PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAKzKpgySeSaeZyLquywWpuUipfD38iTyv9CWEISBKysLPkCF6C1nh+M5C7Jfx6D/
	 0apz6p8hQt7/xFqNZ+3EpXsw72sUdXAEK7vwjUnJ6UBe5Tsgie5qdFPpBsMewLYN2E
	 fZ2bMkN+W3/VzqwfaLA2v4BS5pqrvzz7Jl3V/pYC48axdGdRumSIemqdcILkH0Smew
	 lgW9AP2GQxrZKVMHuaWDWBtQTFYGvO9wbaJgbvXaIrbkfwKTdg4LfzY0OhlnS+6ZJ4
	 VqKSlG3tUxDnVjCG3mq9mUbMImADJyKzPuZLkYG036eXnO7658Qo2vz4JWDAsBBB9C
	 R4pvGSC07BePg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMRl4-000000033qH-0uBO;
	Mon, 11 May 2026 16:37:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v3 06/10] i2c: core: disable runtime PM on adapter registration failure
Date: Mon, 11 May 2026 16:37:11 +0200
Message-ID: <20260511143715.729714-7-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511143715.729714-1-johan@kernel.org>
References: <20260511143715.729714-1-johan@kernel.org>
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
index 25d66de41287..fdf7d7d50f79 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1612,6 +1612,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	device_del(&adap->dev);
 err_remove_debugfs:
 	debugfs_remove_recursive(adap->debugfs);
+	pm_runtime_disable(&adap->dev);
 err_put_adap:
 	init_completion(&adap->dev_released);
 	put_device(&adap->dev);
-- 
2.53.0

