Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617147ECDE;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991314; cv=none; b=EnSaYD/72eXS4XaUvBIl64AM3HQ/tyTRr6sCCFXHv0FsYvjBuQPN7g8GixxPoxMVzhNcrS6vPeaeZ+RTr6jxJ0VYg32Xf0GryxKPiEZj0EA01IMLmVt5DmxKxmRVUbDkJLdHmzqs0GpyR+ZQSBQOaP7ao+eQf3v1WWFIJSh/+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991314; c=relaxed/simple;
	bh=9aXxsI+Rl2pPh1JIk3bkX/A2Wgl7wg0KK8314jzIqU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cf8QGxk27WcLYS/p4fqHbFpFHmHbo11AZoxrEe3VHMmVs2daLafruzeUxNF1XLakwhKEiNeTzaIq8JnXKVz8H7hRsv6DEx4Y6NQnLqmlRsKCuZP0dZnXzWqeZzWVs7SOu05IYYFB+LavN9bN4rBGwga/iJ9PeEvThxT20rd/dfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=popbY3aw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="popbY3aw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C07C2BCF4;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991314;
	bh=9aXxsI+Rl2pPh1JIk3bkX/A2Wgl7wg0KK8314jzIqU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=popbY3awU5oosZPRO9B52awnLROk3qx+926UKrFKwe0swX6kuNWBn9x9hV4xOABJY
	 LfPQES7PlumFPuA8myj+TXBts7SgnRWafL7ZWy0IyULwN8JQOajNgJZBiCwPrhSU7y
	 zdfH+7iwr9FIP7cHQO4jDoRtaMGlm27VHnbQPOjnf7YpY3ahKA4fNQZIopK8N1rveu
	 Pr0teqPCX/lDnvVaen96X+Tj1EBUnIqn5jw502N6CqhtFQ7ocRpC4vNaIJDFHd34L3
	 4TbO6fFN3tqmypr/w5NzREMlMk/uRAzsZbjdidI8LdnZMPle9SBP8G8jlotAQnAkj2
	 vnLdmc1Rxts/A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKGlE-00000003Kt4-0eK8;
	Tue, 05 May 2026 16:28:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 7/8] i2c: core: clean up bus id allocation
Date: Tue,  5 May 2026 16:25:46 +0200
Message-ID: <20260505142547.795054-8-johan@kernel.org>
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

Clean up bus id allocation by using a common helper and deferring it
until it is needed during adapter registration.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 86 ++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 6209c5587e99..27cd9ca0ae81 100644
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
+		return res;
+
 	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
@@ -1618,31 +1647,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	init_completion(&adap->dev_released);
 	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
-out_list:
-	mutex_lock(&core_lock);
-	idr_remove(&i2c_adapter_idr, adap->nr);
-	mutex_unlock(&core_lock);
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
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, NULL, adap->nr, adap->nr + 1, GFP_KERNEL);
+	idr_remove(&i2c_adapter_idr, adap->nr);
 	mutex_unlock(&core_lock);
-	if (WARN(id < 0, "couldn't get idr"))
-		return id == -ENOSPC ? -EBUSY : id;
 
-	return i2c_register_adapter(adap);
+	return res;
 }
 
 /**
@@ -1665,17 +1675,8 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
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
 
@@ -1708,10 +1709,7 @@ EXPORT_SYMBOL(i2c_add_adapter);
  */
 int i2c_add_numbered_adapter(struct i2c_adapter *adap)
 {
-	if (adap->nr == -1) /* -1 means dynamically assign bus id */
-		return i2c_add_adapter(adap);
-
-	return __i2c_add_numbered_adapter(adap);
+	return i2c_register_adapter(adap);
 }
 EXPORT_SYMBOL_GPL(i2c_add_numbered_adapter);
 
-- 
2.53.0

