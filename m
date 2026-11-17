Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910435;
	b=kaLCkugeY4cWgS/hv1H1MQnFg4DCNjN7+3NQRRL2P7MzFAtAS/qH5HzFxSyTRoAgmV2P
	 6oaiukf7gN3+OBBeXf0v8Mz5cIdY9GZWSY/FOvcWcxBgjJ6DRxkBorG1yeNsiwfccdRdH
	 vsek4PqbqAtCxkkrlp8AJY57+Oz8zfZZoijrWVWWIdr7QGqzjAql6uQw76tB+kZEYHND9
	 LMBQcw5Ou9cTiOgy7IjCMgwuqELOwL5v9PjBkd+Vnrvjhrag6Fs00hX6xrVy8clnOfRN4
	 s38x6lhmRONIYZ/sL/ghZZA9iJt4zuSMvTne6cfYGtG4o3s21u8ya27CZSttHPCoCxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910435;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4jlqSsikhkzX8mCpT01GQh10pK/u5joTN7XrOtPpIoM=;
	b=5YtCGuXsHNbqRgnSqq+ndBWF5zQjc/Jrtv2jNvShejfzUs9TXRzsvtUldG+v+Ww8eyMr
	 GGSpDHBUafRvSa7zyJ2ClpBKH+8Ai1JqK/7kuaqEfqS5oadCU7ELYjK2nljjM1j+0tr1u
	 +Xt65/t3nI7qq3z7GqnIZOm1VAY+QDTOhKJzm+CVmJCxwrklR7e7KYOitCrXLUVUdUzYE
	 +uacAjKKzN3wjAAF2BpilOa0XajIpS6DtM+Wgmaaqe+ATV7W9orAAq1mRzSUWSlC1ohlI
	 acOpkDTC/ixoDhWZhvKqMi6EpZWpSeK89588HCHTYDrg9v65paCh6EnvwBZx9P7wpRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqUY3xlH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3658A606A323;
	Tue, 17 Nov 2026 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqUY3xlH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C544C1F000C4;
	Tue, 17 Nov 2026 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910434;
	bh=4jlqSsikhkzX8mCpT01GQh10pK/u5joTN7XrOtPpIoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LqUY3xlHehE6SuG+gveIHrRZ8Xpe4WluCUtItV7nKkL/s4LQMN3z7UOgFE0Ee77gn
	 eZV6JcJcGGr6mdUlLKfbnWPg09nBPfaei1yg8WAZxmEIGNfAwJ6U+8wcHVZRXo+6r9
	 6iTtTgQXC9dgNXClViwO4QlvynLUAsbuc+BUZuaDYLFMhOcYze9mnojJiOOWpyhrxE
	 s7hQIA6dGen7kMNueLpktm4+BrxDx7nCihh2x28y7ahRfOKVzsnmEqL8p4GpcK6q3c
	 p8LLYIdROvE/9ATHOOwM6cAG59NxhmEErYUZMYQO2fY/CNohKr48vEtcfsW6cEqJfN
	 re6L6n6SxKsVg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTGCG-0000000470d-17zT;
	Tue, 17 Nov 2026 11:13:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] software node: ignore primary nodes in device_remove_software_node()
Date: Tue, 17 Nov 2026 11:13:32 +0100
Message-ID: <20261117101336.980216-5-johan@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117101336.980216-1-johan@kernel.org>
References: <20261117101336.980216-1-johan@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_remove_software_node() should only be used to remove secondary
firmware nodes added by device_add_software_node() but will currently
drop a reference also if a device has a primary software node.

Bail out early if device_remove_software_node() is called for a device
whose primary firmware node is a software node and fix up the two
callers that currently work around this themselves.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # I2C part
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/base.h         | 2 ++
 drivers/base/core.c         | 2 +-
 drivers/base/platform.c     | 9 ++++-----
 drivers/base/swnode.c       | 3 +++
 drivers/i2c/i2c-core-base.c | 9 +++------
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 866b2beb6baa..5474735e3e76 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -315,6 +315,8 @@ static inline int devtmpfs_create_node(struct device *dev) { return 0; }
 static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
 #endif
 
+bool fwnode_is_primary(struct fwnode_handle *fwnode);
+
 void software_node_init(void);
 void software_node_notify(struct device *dev);
 void software_node_notify_remove(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index bf97b06337a1..ef36e336a576 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5212,7 +5212,7 @@ int dev_warn_probe(const struct device *dev, int err, const char *fmt, ...)
 }
 EXPORT_SYMBOL_GPL(dev_warn_probe);
 
-static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
+bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
 	return fwnode && !IS_ERR(fwnode->secondary);
 }
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index be5d2f315fdb..e0b38dbd5acf 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -598,15 +598,14 @@ static void platform_device_release(struct device *dev)
 {
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
-	bool fwnode_is_software_node = is_software_node(dev_fwnode(dev));
 
 	device_remove_software_node(dev);
 	/*
-	 * If the firmware node is a software node, its reference count
-	 * was decremented by device_remove_software_node().
+	 * Must be done after device_remove_software_node() which may have
+	 * freed a secondary firmware node and cleared the fwnode pointer.
 	 */
-	if (!fwnode_is_software_node)
-		fwnode_handle_put(pa->pdev.dev.fwnode);
+	fwnode_handle_put(dev->fwnode);
+
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b2593b2fcada..95283d8bda26 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1101,6 +1101,9 @@ void device_remove_software_node(struct device *dev)
 	if (!swnode)
 		return;
 
+	if (fwnode_is_primary(&swnode->fwnode))
+		return;
+
 	if (device_is_registered(dev))
 		software_node_notify_remove(dev);
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index c55ca14eaad9..af3ae2a83626 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1056,7 +1056,6 @@ EXPORT_SYMBOL_GPL(i2c_new_client_device);
 void i2c_unregister_device(struct i2c_client *client)
 {
 	struct fwnode_handle *fwnode;
-	bool fwnode_is_software_node;
 
 	if (IS_ERR_OR_NULL(client))
 		return;
@@ -1067,14 +1066,12 @@ void i2c_unregister_device(struct i2c_client *client)
 	else if (is_acpi_device_node(fwnode))
 		acpi_device_clear_enumerated(to_acpi_device_node(fwnode));
 
-	fwnode_is_software_node = is_software_node(fwnode);
 	device_remove_software_node(&client->dev);
 	/*
-	 * If the firmware node is a software node, its reference count
-	 * was decremented by device_remove_software_node().
+	 * Must be done after device_remove_software_node() which may have
+	 * freed a secondary firmware node and cleared the fwnode pointer.
 	 */
-	if (!fwnode_is_software_node)
-		fwnode_handle_put(fwnode);
+	fwnode_handle_put(client->dev.fwnode);
 	device_unregister(&client->dev);
 }
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
-- 
2.56.1

