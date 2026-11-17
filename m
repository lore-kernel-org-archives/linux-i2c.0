Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910435;
	b=xA/nrykJRRhwfBZe3cKKK6nhergKNfvS9ajexic8inua5lucdYzSvy3+NcKFnLJCwGq1
	 xSEECE7doEMf2uoNL63cKZ+46lLTL1wj24CmmSrON0jAGY5WYBaLlMBrc2pm8y4CBXjKe
	 Gu94D7zV9dVfKL54fNU4QOlVn0Q152EBgJM4Cx39xRGSyb+5NtUkfDio3TofINSw+VbUd
	 yWS9xwSkpixE/inrltEPdOWTML5sp8b6enwmxTqKhtffRjGF5g0x2lhunj8Ghk93SAuoO
	 59qy02fbTKM676Mx7/knODd0j2wpi8elLd+5Pq2ZbxheyqCRHKJgJSwzLlHmE5jyVaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910435;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ltLXVUq9Lnhms8Nu65Pre/DZwxfC10R1s3hxISTFQsM=;
	b=pqKyfIcKFjXYKhnh6RbyeQCEeXQ7HqVyOPoPKGhjqe4keR3ZiUN9s55JxbzPRNOpwKj7
	 AzHbxMSx2o6sX0UB8LOJshXVc/8dLsRe38HmlxI3hwrST3SVLfQa+/UEhkPbpj93z0g0L
	 0+xeVDiYwPE8wA9p1nJg6NYIQ71yEs/PQEg4luoRxbZaYU+tuySl2tt/QO4vs5hdOldtb
	 hhqSJEaLUbhyIlrERGjK9g6V2dnPbsAPoRjh/RBCXoVu+f073EVJU9OeLSw4/UyGMPP9k
	 TbQ4pCj4yxEBzC2xScryRQG6zTVOmPZ+dFV/D5RAZX343ciPrzTTLxQXdJZEpwNqupQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzUgwfSn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38031606A32C;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzUgwfSn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ED71F000CD;
	Tue, 17 Nov 2026 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910435;
	bh=ltLXVUq9Lnhms8Nu65Pre/DZwxfC10R1s3hxISTFQsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WzUgwfSnu46E2vS2brhYDnkU3dhUSeiNtLSE7ZvyWYTwyDEbltBHF18kaEIxghSZx
	 Erg6t09hQ7pyhXfTylUl6nU4CJDwpGQci3rOj6K1ydl8Ln5NCU+hqKvQI1YHqvDaZd
	 y6jW4OqsVRkW6F5T6diu3ZB3hQuklJeO4FalHANPbluevKMspegWy/x/Ii78IkJYpG
	 cHsuICYSUFzAXhg142PacPpzPRyNUPh15N621+rsbXcr7u6Jk6TrQfmuRAg0sGpwRn
	 LMCw+iqPvD7t6dP92QI3iDBF/njhp030m665UESX8V6jFZc/vI3GjaMc7uEv1femBz
	 QN2kEQdtHK9TA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTGCG-0000000470f-1B3c;
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
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v3 5/8] driver core: platform: warn on bad fwnode assignment
Date: Tue, 17 Nov 2026 11:13:33 +0100
Message-ID: <20261117101336.980216-6-johan@kernel.org>
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

Commit e6054f410c97 ("driver core: platform: amend the API contract for
fwnode setters") added a warning to platform_device_set_fwnode() in case
the current firmware node pointer points to a software node as that may
prevent software_node_notify_remove() from being called.

This is only an issue if the platform device has been registered however
as software_node_notify() is only called for registered devices. A
bigger issue is that a secondary firmware node assigned before the call
may be silently lost (and leaked in case of software nodes) as these
helpers do not use set_primary_fwnode().

Amend the current software node check, which fails to trigger if the
device also has a primary non-software node, with a warning in case the
device already has a secondary firmware node assigned to catch any
(hard-to-debug) issues due to a secondary node being assigned before the
call.

Note that this also avoids making claims about the device firmware node
pointing to the primary firmware node, which is not the case when the
device only has a secondary node.

Fixes: e6054f410c97 ("driver core: platform: amend the API contract for fwnode setters")
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/platform.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index e0b38dbd5acf..06ce980b57b1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -708,9 +708,10 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
  *
  * Assign an OF node to this platform device. Internally keep track of the
  * reference count. Devices created with platform_device_alloc() must use this
- * function instead of assigning the node manually. This function must not be
- * called for a platform device that already has a software node as its primary
- * firmware node assigned.
+ * function instead of assigning the node manually.
+ *
+ * This function must not be called for a platform device that already has a
+ * software node or secondary firmware node assigned.
  */
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np)
@@ -726,21 +727,24 @@ EXPORT_SYMBOL_GPL(platform_device_set_of_node);
  *
  * Assign a firmware node to this platform device. Internally keep track of the
  * reference count. Devices created with platform_device_alloc() must use this
- * function instead of assigning the node manually. This function must not be
- * called for a platform device that already has a software node as its primary
- * firmware node assigned.
+ * function instead of assigning the node manually.
+ *
+ * This function must not be called for a platform device that already has a
+ * software node or secondary firmware node assigned.
  */
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode)
 {
+	struct fwnode_handle *old = pdev->dev.fwnode;
+
 	/*
-	 * If we call this function for a platform device whose primary
-	 * firmware node is a software node, we'll never end up calling the
-	 * symmetric software_node_notify_remove(). There are no users for this
-	 * right now in the tree so just disallow it.
+	 * A secondary firmware node may be lost as set_primary_fwnode() is
+	 * not used here, and software_node_notify_remove() is not called for
+	 * a registered device with a software node, warn for now.
 	 */
-	WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));
-	fwnode_handle_put(pdev->dev.fwnode);
+	WARN_ON(old && (old->secondary || is_software_node(old)));
+
+	fwnode_handle_put(old);
 	device_set_node(&pdev->dev, fwnode_handle_get(fwnode));
 }
 EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
@@ -751,15 +755,19 @@ EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
  * @dev2: device whose OF node to reuse
  *
  * Reuses the OF node of another device in this platform device while
- * internally keeping track of reference counting. This function must not be
- * called for a platform device that already has a software node as its primary
- * firmware node assigned.
+ * internally keeping track of reference counting.
+ *
+ * This function must not be called for a platform device that already has a
+ * software node or secondary firmware node assigned.
  */
 void platform_device_set_of_node_from_dev(struct platform_device *pdev,
 					  const struct device *dev2)
 {
+	struct fwnode_handle *old = pdev->dev.fwnode;
+
 	/* See platform_device_set_fwnode(). */
-	WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));
+	WARN_ON(old && (old->secondary || is_software_node(old)));
+
 	device_set_of_node_from_dev(&pdev->dev, dev2);
 	pdev->dev.fwnode = of_fwnode_handle(pdev->dev.of_node);
 }
-- 
2.56.1

