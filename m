Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300728;
	b=L5qyZY0yoxgoXj8V29FyozG/LAkk8VVNYa8gctsaLLMHj+lGIWSut6ZYQArOl+kPwtr9
	 dl1QhxM3n6FtgXkO+s5PUdHYqjunW5sYCS6Xxrc63oYRQQVGb91XM9SBosODTQiatQisA
	 E2EUtCOCJII6UE2F2dzbLp9hdevuhE3maZ1O2IHnyY/97n2gE5x65vcfQJb6N65rmMWNW
	 hOxDSf+4h4oTEtvlKXBQHQfqd/H+et3sApBjkEtqGjJdenmhMITJqg7ZB6RhvQQ0cNWwP
	 V38rqQgk6K3wiTC2Q+j9X3ETSbEqWaUvDQ6stjEcsE8ifVsBQIMePspSc/tW5dcrxHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300728;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BD24lT/jCAqMVgRkJTQ9FPm/HI2ddCt1Pqe9zssOHQo=;
	b=Rm/rDy8P39JLalGpqVwceewVe0UAglkLXA6XaKWkZE6cfuUNy+w8Vs+Fj8m7m/9BFB6w
	 L4QN/uk/SBLCIBa687qP8g0/Bh1jsHLHZI07+K+l9x350if07RtcSPf0gNTgi6XT3FDfA
	 eXZ4GWXi0hbu2FTLbILR1hINPvzfq9t4W2jY1ZAHUbRbiKkxsG4Gle/mWsKCP8hvshgy1
	 WHo2ruFW5CE8Z5BoGsECwAX7Mpn+RSOo6CjnAB5oFbKYMbPtMuZlibyjCvzVS+GnK9GlL
	 nmg53sM6V6wgyMW2vui5jHqVnYrNheqFwPWJd6dnFoZqPF05Qtrzq+JFPKipw8+5gxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gr2/rW1L";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5160A261D;
	Tue, 10 Nov 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gr2/rW1L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C161F00900;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300726;
	bh=BD24lT/jCAqMVgRkJTQ9FPm/HI2ddCt1Pqe9zssOHQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gr2/rW1LAWeoIOCLoX/zhylGuDBK36vMy8smd2XZ958jj05lKvSUAn0FBGoZcHlzT
	 GdgoN19Ybw2rTPVQyf0EZsjT0zjsYzjKFmWjqJ2xxjuow0Wsyl5PdLExL6JwEsmlqY
	 uNzLGIpXKvMnP0hIeg47cDSawBRRVXO3bcm/LEr6h9OnDoKwEzqnjnHljcsihpqcaY
	 5KkdE4pHXGxLAyXkiKz6xZJ4+f5R8M6J5pw+inulyiIgh1iwwO7VIUShzNFfWa4INn
	 +zH9Yhs8CoUS0sIpGiEDd41d4AkALvZlBRYIFgVzQRX9jHo1w509oCdYrwT1T1cV7m
	 Gg4uanKmcU2sw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQhaG-0000000AdcE-0HdE;
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
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 5/8] driver core: platform: warn on bad fwnode assignment
Date: Tue, 10 Nov 2026 09:51:21 +0100
Message-ID: <20261110085125.2535508-6-johan@kernel.org>
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

Commit e6054f410c97 ("driver core: platform: amend the API contract for
fwnode setters") added a warning to platform_device_set_fwnode() in case
the current firmware node pointer points to a software node as that may
prevent software_node_notify_remove() from being called.

This is only an issue if the platform device has been registered however
as software_node_notify() is only called for registered devices. A
bigger issue is that a secondary firmware node assigned before the call
may be silently lost (and leaked in case of software nodes) as these
helpers do not use set_primary_fwnode().

Replace the current software node check with a warning in case the
device already has a primary or secondary firmware node assigned to
catch any (hard-to-debug) issues due to a secondary node being assigned
before the call.

Note that this also avoids making claims about the device firmware node
pointing to the primary firmware node, which is not the case when the
device only has a secondary node.

Fixes: e6054f410c97 ("driver core: platform: amend the API contract for fwnode setters")
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/platform.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index e0b38dbd5acf..869c044f8182 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -709,8 +709,7 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
  * Assign an OF node to this platform device. Internally keep track of the
  * reference count. Devices created with platform_device_alloc() must use this
  * function instead of assigning the node manually. This function must not be
- * called for a platform device that already has a software node as its primary
- * firmware node assigned.
+ * called for a platform device that already has a firmware node assigned.
  */
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np)
@@ -727,19 +726,16 @@ EXPORT_SYMBOL_GPL(platform_device_set_of_node);
  * Assign a firmware node to this platform device. Internally keep track of the
  * reference count. Devices created with platform_device_alloc() must use this
  * function instead of assigning the node manually. This function must not be
- * called for a platform device that already has a software node as its primary
- * firmware node assigned.
+ * called for a platform device that already has a firmware node assigned.
  */
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode)
 {
 	/*
-	 * If we call this function for a platform device whose primary
-	 * firmware node is a software node, we'll never end up calling the
-	 * symmetric software_node_notify_remove(). There are no users for this
-	 * right now in the tree so just disallow it.
+	 * A secondary firmware node may be lost as set_primary_fwnode() is
+	 * not used here, warn for now if a node has already been set.
 	 */
-	WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));
+	WARN_ON(dev_fwnode(&pdev->dev));
 	fwnode_handle_put(pdev->dev.fwnode);
 	device_set_node(&pdev->dev, fwnode_handle_get(fwnode));
 }
@@ -752,14 +748,16 @@ EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
  *
  * Reuses the OF node of another device in this platform device while
  * internally keeping track of reference counting. This function must not be
- * called for a platform device that already has a software node as its primary
- * firmware node assigned.
+ * called for a platform device that already has a firmware node assigned.
  */
 void platform_device_set_of_node_from_dev(struct platform_device *pdev,
 					  const struct device *dev2)
 {
-	/* See platform_device_set_fwnode(). */
-	WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));
+	/*
+	 * A secondary firmware node may be lost as set_primary_fwnode() is
+	 * not used here, warn for now if a node has already been set.
+	 */
+	WARN_ON(dev_fwnode(&pdev->dev));
 	device_set_of_node_from_dev(&pdev->dev, dev2);
 	pdev->dev.fwnode = of_fwnode_handle(pdev->dev.of_node);
 }
-- 
2.56.0

