Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300729;
	b=AA91Nx1OpImxu1c220BCbNClVRVV7kYVPVGT7rhXRBfJ94vLzg4MJR59Plyf8GhOdMIQ
	 bV4OXd0OZsQIdVauVG39ilk4DRzk6axfjTziS6lW5EsoBFazWoKEcnK5foPOkOmBdRBsb
	 jZxEEWX0XziPGjrHt581WrKKYxEBywYHoLzHcg9Cv2UEeGUOLR52jcpbfNpc32kT61lzG
	 FY/IDnxNEVWE9CV3cg2Q4DXMLFh0m5embuWnsOu5CWmHAEkmw/HOieWucWYw18gRJsujh
	 q53q7otoSJhisZJ3Gkwi/mLg0qtfH80lL1cyD/J4PXoAIMUYxqiHIpFHVg7xmVkk0Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300729;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lbec8qCoQqeixzrhKFMKFios/BqvOdvX1Qkv3i92QOQ=;
	b=3L+BeVtd7qAng8y6PRYrLorvGX8pGewPpC8GXw+m61gbm5TjLbXoB4vAx31zyNLJRgKx
	 pnyncIspGBh6wH3cOwEON67F87RxDp18ozIDwLtmBmMJR/BgsoYzhnycRDlbVJIriyVQ+
	 D+Zc5n4WWEvqaCX88gdJDFEuNx4h8R6yzZk3jhFMh8+dTYkEu4kh9ldtdc7Tc1Za0JXOR
	 w7MrOrTFLPL/qAk1MhTXzgLpJDVUEcdBLZGA5xVPOoOsYTsWFtrLAQeYTfW91ZxxGcRQm
	 sBXVi6HLfI930+a+S1LgoNXuxrwNCDnSjECzmBZpYea7XLAYsl0lO297FGtW02/3fSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C/dC4u9t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EDD60A261C;
	Tue, 10 Nov 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C/dC4u9t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87591F00903;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300726;
	bh=Lbec8qCoQqeixzrhKFMKFios/BqvOdvX1Qkv3i92QOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C/dC4u9tAl3fNv7DwsuyJp2f/dDS7ZEe99fP6EGyPUFwmNjw8Sjt/rZzLhIM4tuqk
	 iHdQUggtoqNwEKo6rdhPH2jGEYsJiNlyEDOEdDs7Dq+79w2qkccK9E3EcbbdsYbMMW
	 EU0QrmHlF4dMzf1wI+/RMOnpK+yC6z/V1q5M9CkJK5Dl0ZV42lpQ0ojMmU3K9WcH2Y
	 gTznHP773p7zczRXVtps9MV6czpJHXiuxFv28yf10BCfAZ1KEOLLFne6WX2yLysGGR
	 UgarqPzx4q6CQnW5ddY2KCI/uTx4oguNt7XOpi21roYlgQ1iJ2iDxvOzXCHWRchNq1
	 wPv1dXQLK2hEA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQhaG-0000000AdcC-0Dyu;
	Tue, 10 Nov 2026 09:52:04 +0100
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
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] swnode: ignore primary nodes in device_remove_software_node()
Date: Tue, 10 Nov 2026 09:51:20 +0100
Message-ID: <20261110085125.2535508-5-johan@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110085125.2535508-1-johan@kernel.org>
References: <20261110085125.2535508-1-johan@kernel.org>
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

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/core.c         | 3 ++-
 drivers/base/platform.c     | 9 ++++-----
 drivers/base/swnode.c       | 3 +++
 drivers/i2c/i2c-core-base.c | 9 +++------
 include/linux/device.h      | 1 +
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bf97b06337a1..460c7ad1eaeb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5212,10 +5212,11 @@ int dev_warn_probe(const struct device *dev, int err, const char *fmt, ...)
 }
 EXPORT_SYMBOL_GPL(dev_warn_probe);
 
-static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
+bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
 	return fwnode && !IS_ERR(fwnode->secondary);
 }
+EXPORT_SYMBOL_GPL(fwnode_is_primary);
 
 /**
  * set_primary_fwnode - Change the primary firmware node of a given device.
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
index 5dc2029f9a7b..a90c20cb84e6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1108,6 +1108,9 @@ void device_remove_software_node(struct device *dev)
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
diff --git a/include/linux/device.h b/include/linux/device.h
index 6b082c638d45..229a15625766 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1280,6 +1280,7 @@ int lock_device_hotplug_sysfs(void);
 int device_offline(struct device *dev);
 int device_online(struct device *dev);
 
+bool fwnode_is_primary(struct fwnode_handle *fwnode);
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
-- 
2.56.0

