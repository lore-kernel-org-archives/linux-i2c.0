Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F559382F26;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231012; cv=none; b=SMlzjyD9Dm/onkCaLy9G+7UOqFQESHo2grLjbssV/eRcXhmnP1nkNAoIXagE6i++s9ZQxoRGhyuAvwo3mIdfU4cl53nrXiljRYj2Qs/gNarLyWVOYYHkK/zy8OWzP1kwm1VuBJfdIVnDIXdypT6mN+2dtegfCM43GvdYcsCSUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231012; c=relaxed/simple;
	bh=N46uGMjt3fV1Z3PaiSqd3/q7oyJsZAsXz0u+Q9Byvuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Np+kTErop+8Yga6DZ38NCMzNKHe5Bh3Ri5ViJDTY4ilmvEgoytJkSkcJ7IQsKCA9Jj9K0KQGRRBg/feiSfsNwW1TqgZuwWuVbna7XdeNYEU5BivQR3hNMzWAeUXdFTwKE85qu7wczECzIFqgL/WqV++dSiIHlijujhvUJL+lmHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvGBQGJz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvGBQGJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB02C2BCF4;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778231012;
	bh=N46uGMjt3fV1Z3PaiSqd3/q7oyJsZAsXz0u+Q9Byvuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvGBQGJz0hGMPHiCu9Trw0Fvy5atrFdFSZyWy4UUcp1vBxTMv6I6C8QZa1FwTRmTY
	 ISXYcL/blEL8VGoL0w6yzr2gcYkZAikdF+ErO448HZVzUeLEFHXGL20272S4LOuGiz
	 8jOD7HoElIEDhJsbxgjMHoXjqqBaB2xarAW+edfgOPgxOfup5puKapr6yTkSY0df4F
	 X7B0as3ANodLYZW9cBGzfFVIxvtKT4EhjWcM3Tqp0RRsgKWREALtG0jTWdwhXWc3EZ
	 YZVt16tgrXNl18xh7W8HvV6HDNp+BsWszE85nWPB7uTrP00ZEyeVWVfijC5kFBdzGq
	 TBiuUGMtxrh+g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLH7J-00000001ah4-48g6;
	Fri, 08 May 2026 11:03:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 3/9] i2c: core: fix adapter probe deferral loop
Date: Fri,  8 May 2026 11:03:05 +0200
Message-ID: <20260508090311.379333-4-johan@kernel.org>
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

Drivers must not probe defer after having registered devices as that
will trigger a probe loop if the devices bind to a driver (cf. commit
fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")).

Move the recovery initialisation, where the GPIO lookup may fail, before
registering the adapter to prevent this.

Fixes: 75820314de26 ("i2c: core: add generic I2C GPIO recovery")
Cc: stable@vger.kernel.org	# 5.9
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index e42851a10098..1caaa3b3ee10 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1562,6 +1562,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
 
+	res = i2c_init_recovery(adap);
+	if (res == -EPROBE_DEFER)
+		goto err_put_adap;
+
 	/*
 	 * This adapter can be used as a parent immediately after device_add(),
 	 * setup runtime-pm (especially ignore-children) before hand.
@@ -1574,8 +1578,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		put_device(&adap->dev);
-		goto err_remove_irq_domain;
+		goto err_put_adap;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1584,10 +1587,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
-	res = i2c_init_recovery(adap);
-	if (res == -EPROBE_DEFER)
-		goto out_reg;
-
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	/* create pre-declared device nodes */
@@ -1608,10 +1607,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 out_reg:
 	i2c_deregister_clients(adap);
 	debugfs_remove_recursive(adap->debugfs);
+	device_del(&adap->dev);
+err_put_adap:
 	init_completion(&adap->dev_released);
-	device_unregister(&adap->dev);
+	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
-err_remove_irq_domain:
+
 	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
-- 
2.53.0

