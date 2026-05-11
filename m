Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EFE3FE374;
	Mon, 11 May 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510244; cv=none; b=Jce8x2iKFVAWjYLwiF2KlYP8e61EQWhUI+1iCk63EDgfI2s1Z6aZyaeSQENL3Yqwy/T16qu0e4zNdntBJC72dq96OINHxryFJ0rgruvmKZYQ7foSTC3qMCi0x1XmBgutlTvLm/s2EP+RWC5vYW+ioez9BzGN2749J8KL13fY1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510244; c=relaxed/simple;
	bh=eihvSdYvDEAsiJ1gC2UmX+JrpysYRhv4c4ZhELH2oFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCSFi2ePQaRnvlZAYfZBCzJpcj0w+TourAzSJJp6Ia10bxCMlbsMksLuAui7wONYmd5dyHgD/+6FgAXV5xlDYzOTjLvmnMYLxiDDy4p8f1PQTrVz6u+ipeCScu7hWoTiMqOVX3Fv4PwIjCACuswH2Y4AcI/uqZ780FxSkBvpN5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyFxaBQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyFxaBQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDEFC2BCB0;
	Mon, 11 May 2026 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510244;
	bh=eihvSdYvDEAsiJ1gC2UmX+JrpysYRhv4c4ZhELH2oFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyFxaBQQ5zsgZLcSdXevXVELWJZPDA4A62EFrf3G7Qm/t3icPpXHcuGM4m5WHmlN4
	 ZAStR07MncXtv9e9pCAIwQ1MIk+6ltJSQjGGHD9QAuCktNuCBZsb8SzYHr4fw/4nmx
	 x5ndwSXHE/nUAmqbXV90e0rGsaydVJMyC3ISY0k1fi3BO4rN7kJwBO59KiHoDc1Grn
	 ygQHwjywkTGMhtOpvdMm/vzr7MIE6x1AA02KUuTm/c75Or0QuhgPnM39fgNNI31Jzk
	 +/coZMeZ9zCqqhGxjvGJcuvQeey41hKfgnT/FRMQNAADXJYW3oRu7aynWGiH8AaZ7J
	 327/N5aiBUgwQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMRl4-000000033qN-14K4;
	Mon, 11 May 2026 16:37:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 09/10] i2c: core: clean up bus id allocation
Date: Mon, 11 May 2026 16:37:14 +0200
Message-ID: <20260511143715.729714-10-johan@kernel.org>
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

Clean up bus id allocation by using a common helper and deferring it
until it is needed during adapter registration.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 89 +++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 38f425aecef8..2cd384433d83 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1517,23 +1517,48 @@ int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr)
 }
 EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
 
+static int i2c_allocate_adapter_id(struct i2c_adapter *adap)
+{
+	int id, start, end;
+
+	if (adap->nr == -1) {
+		start = __i2c_first_dynamic_bus_num;
+		end = 0;
+	} else {
+		start = adap->nr;
+		end = adap->nr + 1;
+	}
+
+	mutex_lock(&core_lock);
+	id = idr_alloc(&i2c_adapter_idr, NULL, start, end, GFP_KERNEL);
+	mutex_unlock(&core_lock);
+	if (id < 0) {
+		if (adap->nr != -1 && id == -ENOSPC)
+			id = -EBUSY;
+		pr_err("adapter '%s': failed to allocate id: %d\n", adap->name, id);
+		return id;
+	}
+
+	adap->nr = id;
+
+	return 0;
+}
+
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
-	int res = -EINVAL;
+	int res;
 
 	/* Can't register until after driver model init */
-	if (WARN_ON(!is_registered)) {
-		res = -EAGAIN;
-		goto out_list;
-	}
+	if (WARN_ON(!is_registered))
+		return -EAGAIN;
 
 	/* Sanity checks */
 	if (WARN(!adap->name[0], "i2c adapter has no name"))
-		goto out_list;
+		return -EINVAL;
 
 	if (!adap->algo) {
 		pr_err("adapter '%s': no algo supplied!\n", adap->name);
-		goto out_list;
+		return -EINVAL;
 	}
 
 	if (!adap->lock_ops)
@@ -1554,13 +1579,17 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res) {
 		pr_err("adapter '%s': can't create Host Notify IRQs (%d)\n",
 		       adap->name, res);
-		goto out_list;
+		return res;
 	}
 
-	res = dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	res = i2c_allocate_adapter_id(adap);
 	if (res)
 		goto err_remove_irq_domain;
 
+	res = dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	if (res)
+		goto err_free_id;
+
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
@@ -1624,33 +1653,14 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	init_completion(&adap->dev_released);
 	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
-err_remove_irq_domain:
-	i2c_host_notify_irq_teardown(adap);
-out_list:
+err_free_id:
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
 	mutex_unlock(&core_lock);
-	return res;
-}
-
-/**
- * __i2c_add_numbered_adapter - i2c_add_numbered_adapter where nr is never -1
- * @adap: the adapter to register (with adap->nr initialized)
- * Context: can sleep
- *
- * See i2c_add_numbered_adapter() for details.
- */
-static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
-{
-	int id;
-
-	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, NULL, adap->nr, adap->nr + 1, GFP_KERNEL);
-	mutex_unlock(&core_lock);
-	if (WARN(id < 0, "couldn't get idr"))
-		return id == -ENOSPC ? -EBUSY : id;
+err_remove_irq_domain:
+	i2c_host_notify_irq_teardown(adap);
 
-	return i2c_register_adapter(adap);
+	return res;
 }
 
 /**
@@ -1673,17 +1683,8 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	int id;
 
 	id = of_alias_get_id(dev->of_node, "i2c");
-	if (id >= 0) {
-		adapter->nr = id;
-		return __i2c_add_numbered_adapter(adapter);
-	}
-
-	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, NULL,
-		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
-	mutex_unlock(&core_lock);
-	if (WARN(id < 0, "couldn't get idr"))
-		return id;
+	if (id < 0)
+		id = -1;
 
 	adapter->nr = id;
 
@@ -1719,7 +1720,7 @@ int i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	if (adap->nr == -1) /* -1 means dynamically assign bus id */
 		return i2c_add_adapter(adap);
 
-	return __i2c_add_numbered_adapter(adap);
+	return i2c_register_adapter(adap);
 }
 EXPORT_SYMBOL_GPL(i2c_add_numbered_adapter);
 
-- 
2.53.0

