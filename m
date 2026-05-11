Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D706C3FE37C;
	Mon, 11 May 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510244; cv=none; b=eJGXj4ESDmWsG1/Tr3SmSzU8VX/yUMYGAZjw8A+FBJrODEpdhFPhSxmC596HpH4c/P8e6uNg4U/h4xt8T2G0oe7Z1sFJhKUA6BwTGYcmeCul31t3NA6Q/FjALY0Cm1S+BoFzqRRCg1Vxb3HyUk9vzGenVTXvRkggXyLUgZ0kpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510244; c=relaxed/simple;
	bh=BquGzohizkUxK6KJMBggUVDsdaucr4lh6uE74Vb78n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qV4RFylqjlCfmyk47UvwygnT3sQSHFARZTeMvyeym0vx+qW0/CQ1TpCKa1+VAmfyGsafprdyxSY866pqHEyJ2KsT+XFRVAYogZhV1as3oHwfFVjJ98AkhxTWi90dPIp1//m83mykg1jrvnPoFQs9LnoWGW93iOAoHWQiFqkHWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMtiCCvG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMtiCCvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922A0C4AF09;
	Mon, 11 May 2026 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510244;
	bh=BquGzohizkUxK6KJMBggUVDsdaucr4lh6uE74Vb78n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMtiCCvGb3RaHpsKMkMtW40McZfBOzzqYABk6jiEnMGotBpzhGZMD1fODMAQrqSkE
	 SbWdHBY7GFjdOxVvsyo4HKafKHve1priQVz0GspWeI2ozMq2CzXa4JstdtVYSiGcUg
	 CW93OGsl/Q2ZUi5C1NrXAC8VFmYbPUFVIxNW4OyppXbbvB1jXsGBg13kCXa9q479Ma
	 d+O0F/R1LUIOuq/VOtM9v7dVs4N7kWlgUZebgLtjacAQikOwkZSxbXmvCfhvZFtmyJ
	 eolfMeDPB/ZHQrUSdIa5rk1rYJuXKk+M3witTxpbzuSMgzRSVDa4/1v+9o/22/Huu3
	 ZFR1IHJFHG6nw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMRl4-000000033qF-0qt4;
	Mon, 11 May 2026 16:37:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 05/10] i2c: core: fix adapter debugfs creation
Date: Mon, 11 May 2026 16:37:10 +0200
Message-ID: <20260511143715.729714-6-johan@kernel.org>
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

Clients can be registered from bus notifier callbacks so the debugfs
directory needs to be created before registering the adapter as clients
use that directory as their debugfs parent.

Move debugfs creation before adapter registration to avoid having
clients create their debugfs directories in the debugfs root (which is
also more likely to fail due to name collisions).

Note that failure to allocate the adapter name must now be handled
explicitly as debugfs_create_dir() cannot handle a NULL name (unlike
device_add() which returns an error).

Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
Cc: stable@vger.kernel.org	# 6.8
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1caaa3b3ee10..25d66de41287 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1557,7 +1557,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		goto out_list;
 	}
 
-	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	res = dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	if (res)
+		goto err_remove_irq_domain;
+
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
@@ -1575,14 +1578,14 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	pm_suspend_ignore_children(&adap->dev, true);
 	pm_runtime_enable(&adap->dev);
 
+	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_put_adap;
+		goto err_remove_debugfs;
 	}
 
-	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
-
 	res = i2c_setup_smbus_alert(adap);
 	if (res)
 		goto out_reg;
@@ -1606,13 +1609,14 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 out_reg:
 	i2c_deregister_clients(adap);
-	debugfs_remove_recursive(adap->debugfs);
 	device_del(&adap->dev);
+err_remove_debugfs:
+	debugfs_remove_recursive(adap->debugfs);
 err_put_adap:
 	init_completion(&adap->dev_released);
 	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
-
+err_remove_irq_domain:
 	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
-- 
2.53.0

