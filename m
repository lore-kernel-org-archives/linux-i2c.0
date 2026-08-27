Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD83DC4AF;
	Thu, 27 Aug 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826183; cv=none; b=fetCZRqD6EyyvfrmrX+Q497T98e0nPeuw9WndQLtyG+PTUTO4xLXLwhr3Zk0SPN+fRXnsTgVEMyaPkAbqdiIOj8Sj9zom1dbhzvmdLDCoCM+8lE8okdSWygAF3NbRkWbGDBR6p9fIGGFm4qEkkK8kPgG7qTfeDOIH9oOE+iPYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826183; c=relaxed/simple;
	bh=SbEvIrfZf0UM1Km9jUjL31vDdWKBp9XUP6wj9P4kcoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5J+8WU5FdQFfFLO0Y8sJwG2xfd+JpjoQ7pn/Gcn6xraUY8ZGsKvu2sngfU+phPIwypFDo6UMjn7B481csNxs/HV/mX0WSBgnZ4RpQj6D8N5XPBL7w6hpSJJClo6AT/RpeGXxcaaQ6gfCNk8wyLUGz+k5OXZr6skKkta53/NDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzxAGBPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzxAGBPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34FA1F00A3A;
	Thu, 27 Aug 2026 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787826178;
	bh=seBf3gc5LIy9dpRjrgrmfv7aes/dCe59oN23kOG8nm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HzxAGBPGbCgNCagWCQgEJMoRUiAo9VJ1U4OnVX7Yaq3TJDanly+LFQGK/Zmvvi8wr
	 OvvSWuf+T7YVedf/oYKcYD199YdsTIBvHyY+V1zywu7f2N82yyxyK9P8laG8NUnf0W
	 8mlJYY6Li0DI2c9Pw4hrXKxUaX7NbvK3io6IlhHuXr2Pb0Iuo3wH7YMuozeg5FRwXq
	 Ce/PRS1RjlpOFoz+IQ0a/jrzusJnxkqFmVKDfnZO/wZPaub9hJ06xZvXRXNC7GDGCr
	 qCnxerjUT2RMUIb300gCzd6IPeYgNJHQo91wVNml0rNHV2dtwtQ4DV8NILWujRPGaM
	 lx38PYkF/g0kw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wzXG4-00000002pC5-1B2g;
	Thu, 27 Aug 2026 12:22:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/3] i2c: dev: clean up registration
Date: Thu, 27 Aug 2026 12:20:43 +0200
Message-ID: <20260827102043.673273-4-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827102043.673273-1-johan@kernel.org>
References: <20260827102043.673273-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the get_free_i2c_dev() and put_i2c_dev() helpers and do all setup
and teardown directly in i2cdev_attach_adapter() and
i2cdev_detach_adapter() for consistency and to make the logic clearer.

Note that the device list is only used at detach so the i2c-dev can be
added after registering the class device.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-dev.c | 69 ++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 49c05f2eb223..9ad145f67fc1 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -73,41 +73,6 @@ static struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
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
-	if (del_cdev)
-		cdev_device_del(&i2c_dev->cdev, &i2c_dev->dev);
-
-	scoped_guard(rwsem_write, &i2c_dev->rwsem) {
-		i2c_dev->adap = NULL;
-	}
-
-	put_device(&i2c_dev->dev);
-}
-
 static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
@@ -724,11 +689,17 @@ static int i2cdev_attach_adapter(struct device *dev)
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
@@ -745,13 +716,21 @@ static int i2cdev_attach_adapter(struct device *dev)
 
 	res = cdev_device_add(&i2c_dev->cdev, &i2c_dev->dev);
 	if (res)
-		goto err_put_i2c_dev;
+		goto err_clear_adap;
+
+	spin_lock(&i2c_dev_list_lock);
+	list_add_tail(&i2c_dev->list, &i2c_dev_list);
+	spin_unlock(&i2c_dev_list_lock);
 
 	pr_debug("adapter [%s] registered as minor %d\n", adap->name, adap->nr);
 	return NOTIFY_OK;
 
+err_clear_adap:
+	scoped_guard(rwsem_write, &i2c_dev->rwsem) {
+		i2c_dev->adap = NULL;
+	}
 err_put_i2c_dev:
-	put_i2c_dev(i2c_dev, false);
+	put_device(&i2c_dev->dev);
 	return NOTIFY_DONE;
 }
 
@@ -768,7 +747,17 @@ static int i2cdev_detach_adapter(struct device *dev)
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

