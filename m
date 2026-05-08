Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD5320CD1;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231012; cv=none; b=gUwSG/vUt+By9vBJ2uM/F1bHd2rZvinB4ZflhnXhaOMD9pVWHDrRqaMJPawJqmpypFhIduffL4Mux/8R2Rl0OI4GOkPMrXxRrn0hVWOSBWHeohMMdTpwIuDM+sMckcy94IpWLZ17TTtVzDv47y4BzAx//Gjy82lWPz9B6FLDWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231012; c=relaxed/simple;
	bh=kpcGn8XwWVqIg5gDPPh2/2boUjm7BaR9MU68se3eHf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNygvGdnUfitVO4LfIwy8yBmlF7hx2yqmztBsTQcGBlEnyLr4zR+6EJLaHcRieITnjRRkjDcm05J6XQ7rwJdaboAaHEHYNeCueLuOV22wU5Q5p3kK/iGhR0YHg2FuwKisT7/kqgaoXfac0m0a47/HG/69251pPsqYNWGuU20Bec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IshByKyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IshByKyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2948BC2BCF6;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778231012;
	bh=kpcGn8XwWVqIg5gDPPh2/2boUjm7BaR9MU68se3eHf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IshByKyYkOasqzmdh2HKBpPzkLGcYokzvoWgYpOVoNk8I5bEdmkPOFCc9n/Oey47c
	 d3doV84N3Ulx4hGbOJ4AhaAvPYAVC8Wr8/YEnm6SHv+axnXq9uu4nMUgd8MJ+MoSI3
	 cgTaPzu7jErCQ20LCP6W1BaQiMzXgjpJ4tfSeTQ++HAFRcHiq5Y/tk7pYol2nZM0CM
	 ZpLEg4nyP2CD92fH0zlLU4Zn/8SdoZqd22nRc1CYUIvk5moat1/r9jPvtdBEJfoSJu
	 AEft38ihE6PqOgeON+YdXCfyObfMjsDDGV5Bvb1MGZjkerHTrhr2dnSNz9NP3kTybi
	 dvWQ38bgm0bLw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLH7K-00000001ahE-08I6;
	Fri, 08 May 2026 11:03:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 8/9] i2c: core: clean up bus id allocation
Date: Fri,  8 May 2026 11:03:10 +0200
Message-ID: <20260508090311.379333-9-johan@kernel.org>
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

Clean up bus id allocation by using a common helper and deferring it
until it is needed during adapter registration.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 85 +++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index f72f15a1b067..5350ee54132b 100644
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
@@ -1554,9 +1579,13 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res) {
 		pr_err("adapter '%s': can't create Host Notify IRQs (%d)\n",
 		       adap->name, res);
-		goto out_list;
+		return res;
 	}
 
+	res = i2c_allocate_adapter_id(adap);
+	if (res)
+		goto err_remove_irq_domain;
+
 	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
@@ -1619,32 +1648,13 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
 
-	i2c_host_notify_irq_teardown(adap);
-out_list:
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
@@ -1667,17 +1677,8 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
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
 
@@ -1713,7 +1714,7 @@ int i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	if (adap->nr == -1) /* -1 means dynamically assign bus id */
 		return i2c_add_adapter(adap);
 
-	return __i2c_add_numbered_adapter(adap);
+	return i2c_register_adapter(adap);
 }
 EXPORT_SYMBOL_GPL(i2c_add_numbered_adapter);
 
-- 
2.53.0

