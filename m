Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655731BCAE;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231012; cv=none; b=Xv9uo+10hcpvptOZECQvg86GcwmqRzILit1zNOQpyTGzXXH73uNb+OY82WH1yXidzqy70HvkZDlYQiQAC42v4sEIsyw2oJyKDtdIxAgTtkIeUPCZC1ltmtvDLG9Np4JFiO8LxuCOSAE1gMItRDLlCTrP0AstHTovNF3HkktPgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231012; c=relaxed/simple;
	bh=Syz9agCjo0v7ek7ZUl8IDRv5CIYKzs5t99pAAWh8o7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbSeOr3cAgbAf2DWNvmnHfxjunAZ+9RVZApX1gA2y1ipkHMorHHMkWC14sJDLZY1PaWUlChUDE1G3GcVKjCJ/yWodMX95PnYBq8OvQhErITjdtiUrs9ItGoj/SaZDN0XsNsfimmT/ePVUv4+SFuoTc76Hut40z6qCWXgwGL4XaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLqs0GVM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLqs0GVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249D2C4AF09;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778231012;
	bh=Syz9agCjo0v7ek7ZUl8IDRv5CIYKzs5t99pAAWh8o7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLqs0GVMLLCptnQypnTSmCyxArTXWwcl2P94VKpfYL2luahviZpwXjwxm4SVPjFmP
	 n+Nzp8IubS4ZtvPJ7HiXVznR64zW27v/lbtDGAe43dLAF0OxFzzwtaXotCN2yNI1X0
	 wb5Htxsr9VE06+Gzgz/I1ENnXrx31QAmtPH3MIuLrVcL6XJqGLLGzzFpmNuUTMU36U
	 zJqVczTW9NBI/C3abuBtiiPNodbRCsyGqMtmUSUQAp7BdU5Jj0mQJYNc/JmbZqX0kT
	 1QNro4tFaYdUKdNZIGTZ0uQdUYfHgxiC4BBLO/sH7bYJxdQOzxHKqQIlTJPSSPBUKt
	 bjTa6dMQz6UVg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLH7J-00000001ah0-42SO;
	Fri, 08 May 2026 11:03:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 1/9] i2c: core: fix irq domain leak on adapter registration failure
Date: Fri,  8 May 2026 11:03:03 +0200
Message-ID: <20260508090311.379333-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508090311.379333-1-johan@kernel.org>
References: <20260508090311.379333-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to tear down the host notify irq domain on adapter
registration failure to avoid leaking it.

This issue was flagged by Sashiko when reviewing another adapter
registration fix.

Fixes: 4d5538f5882a ("i2c: use an IRQ to report Host Notify events, not alert")
Cc: stable@vger.kernel.org	# 4.10
Cc: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9c46147e3506..abe8341c1d6e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1574,7 +1574,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
 		put_device(&adap->dev);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1609,6 +1609,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
 	wait_for_completion(&adap->dev_released);
+err_remove_irq_domain:
+	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
-- 
2.53.0

