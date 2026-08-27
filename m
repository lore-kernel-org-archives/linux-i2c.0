Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B933FDC05;
	Thu, 27 Aug 2026 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821726; cv=none; b=a/26Nb1CsuA4L1K0x+snJbAjWSENM02EssxNhStdUT01pjz+w8KAST1C+VqW8BB0S9DmoOCzhCjzLld9mVrRIhqD5KUN4Cnz6iNY5JFCxV4mSXKbQ/WCNa0Po6/rLJmhaVKRJm5sby2uRKgHkzwArY5QTiVgPpSBQ9pVi4L1Lj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821726; c=relaxed/simple;
	bh=Xxv7LmKVMXjjYZv8NFNSnSakxsax5lAclsdAXTnQ2l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItyCHQX2YORjnHZMDu59c3tYRo27Hrma2PhBtvLArtTJh6bHNtZF7Benq7aiVNIHTIqYK3ZeVb1GvXqb1AMb4vwl94LEpMHCjxOjIMF5WtNvXSYLvqz7kuAFEesgoLaYeptgWrflG5/8Paknv2cQn/8QtLm+R+8+9yVuhDCStDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAhJr41G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAhJr41G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DF61F00A3D;
	Thu, 27 Aug 2026 09:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787821722;
	bh=F71mUxpCC9lB/TEKxDCkjypZdTsveKGITFGaS7b2D3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lAhJr41GxJEmPP3oyjG45cL2Vbh5L1ZjsdRdEei2nqSzlLO5AUj+WoboC0Ig52pub
	 dgVurvYvDnaicJJfKRumb6NCSnqDlC/pSSOsBNcVmFo1qC01eHiyd59zCim/Bp7GIy
	 FuIXCzsSlZ4kIXqzyGXwQsRpYNu/JcIcf5HHybhKDiZGVTlzSy6YQorILeJkVfgsdV
	 i8ly9vl+4WmYHtXYSmD0NizTg0bVmpvM4f9UZZb2NBH6xVHAOox3OI1IT9j91bdM0O
	 /VfAyX79/ltgfSrLiY1EVNKbVk7HILv5neb2wcK086/rI4uDL+bHlOccgA6gRh4QmB
	 Qv3g+3Whf/MDQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wzW6C-00000002g8J-0vxR;
	Thu, 27 Aug 2026 11:08:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] i2c: dev: clean up registration
Date: Thu, 27 Aug 2026 11:08:04 +0200
Message-ID: <20260827090804.638565-4-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827090804.638565-1-johan@kernel.org>
References: <20260827090804.638565-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the get_free_i2c_dev() and put_i2c_dev() helpers and do all set up
and tear down directly in i2cdev_attach_adapter() and
i2cdev_detach_adapter() for consistency and to make the logic clearer.

Note that the device list is only used at detach so the i2c-dev can be
added after registering the class device.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-dev.c | 64 ++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 319bc46cc207..1aa798b87dcd 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -73,42 +73,6 @@ static struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
 	return i2c_dev;
 }
 
-static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
-{
-	struct i2c_dev *i2c_dev;
-
-	if (adap->nr >= I2C_MINORS) {
-		pr_err("Out of device minors (%d)\n", adap->nr);
-		return ERR_PTR(-ENODEV);
-	}
-
-	i2c_dev = kzalloc_obj(*i2c_dev);
-	if (!i2c_dev)
-		return ERR_PTR(-ENOMEM);
-	i2c_dev->adap = adap;
-
-	spin_lock(&i2c_dev_list_lock);
-	list_add_tail(&i2c_dev->list, &i2c_dev_list);
-	spin_unlock(&i2c_dev_list_lock);
-	return i2c_dev;
-}
-
-static void put_i2c_dev(struct i2c_dev *i2c_dev, bool del_cdev)
-{
-	spin_lock(&i2c_dev_list_lock);
-	list_del(&i2c_dev->list);
-	spin_unlock(&i2c_dev_list_lock);
-	if (del_cdev) {
-		cdev_device_del(&i2c_dev->cdev, &i2c_dev->dev);
-
-		scoped_guard(rwsem_write, &i2c_dev->rwsem) {
-			i2c_dev->adap = NULL;
-		}
-	}
-
-	put_device(&i2c_dev->dev);
-}
-
 static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
@@ -718,11 +682,17 @@ static int i2cdev_attach_adapter(struct device *dev)
 		return NOTIFY_DONE;
 	adap = to_i2c_adapter(dev);
 
-	i2c_dev = get_free_i2c_dev(adap);
-	if (IS_ERR(i2c_dev))
+	if (adap->nr >= I2C_MINORS) {
+		pr_err("Out of device minors (%d)\n", adap->nr);
+		return NOTIFY_DONE;
+	}
+
+	i2c_dev = kzalloc_obj(*i2c_dev);
+	if (!i2c_dev)
 		return NOTIFY_DONE;
 
 	init_rwsem(&i2c_dev->rwsem);
+	i2c_dev->adap = adap;
 
 	cdev_init(&i2c_dev->cdev, &i2cdev_fops);
 	i2c_dev->cdev.owner = adap->owner;
@@ -741,11 +711,15 @@ static int i2cdev_attach_adapter(struct device *dev)
 	if (res)
 		goto err_put_i2c_dev;
 
+	spin_lock(&i2c_dev_list_lock);
+	list_add_tail(&i2c_dev->list, &i2c_dev_list);
+	spin_unlock(&i2c_dev_list_lock);
+
 	pr_debug("adapter [%s] registered as minor %d\n", adap->name, adap->nr);
 	return NOTIFY_OK;
 
 err_put_i2c_dev:
-	put_i2c_dev(i2c_dev, false);
+	put_device(&i2c_dev->dev);
 	return NOTIFY_DONE;
 }
 
@@ -762,7 +736,17 @@ static int i2cdev_detach_adapter(struct device *dev)
 	if (!i2c_dev) /* attach_adapter must have failed */
 		return NOTIFY_DONE;
 
-	put_i2c_dev(i2c_dev, true);
+	spin_lock(&i2c_dev_list_lock);
+	list_del(&i2c_dev->list);
+	spin_unlock(&i2c_dev_list_lock);
+
+	cdev_device_del(&i2c_dev->cdev, &i2c_dev->dev);
+
+	scoped_guard(rwsem_write, &i2c_dev->rwsem) {
+		i2c_dev->adap = NULL;
+	}
+
+	put_device(&i2c_dev->dev);
 
 	pr_debug("adapter [%s] unregistered\n", adap->name);
 	return NOTIFY_OK;
-- 
2.54.0

