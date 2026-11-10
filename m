Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300728;
	b=bNdMRko2Tq+Mo/a0OJu9TtVPrboJ6Jd0eVu+CCnxYBG9hntAEwXwcv5wGSSSKXmxv76Y
	 ghjYjo1xN530cgsDqDSGp+IHuga41kBeQIgxwkgoQlAwYA8B54YMF1aVEZVLVLItIqtSH
	 KDQ/aQceMBgtxpFZucwOyBkSvdj5IKt4nsQGCdkt00DekR39K5hXMxlcEzln16f5kk3vS
	 3uOp+XD6DuZvbgCY/f7VPxukN2Sjt7aYGod8sPGd1sMOeay0CvocAx1A14xWSO+8uk71a
	 tBX+UQSEYZfImy04g6jRCFuZEhDJxnsQ8aSyWiYeEt6R1k2TY7ZDQtdnuf52UfdBe9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300728;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CmhusFnIKRpHndm/TIvweb7mjKJxX/GPqtrCuccRSII=;
	b=Kjt5eHc2q/z/u0HVrcj4sA27fmOnnUkf+iFqTKyZA7UQwuNb3CtUDZD5fRsgatQpQpAL
	 XC1z2Yrh3Q7+6n0ZjZHqL+R/96zwSoqiIE9LmnT/2071z9SxZxJ2Kbkv/GIrxvXT6CkBw
	 /EGf3DZsUuJwFg/9BhjWsMUHOr+ONWqCfzNFyr1xsLZashRB4rJXvnxFcgtUgvWfh5EEm
	 IOZ6LUw/A9bM+F3pOCBawL4KCYOwYt+zOGx+nZ1m3HSXzqUd00ADwzkotUCiPhf+zTHXv
	 QMzLZhpoE8AKeJI+hwCfOerzUjxKD14vfRsp1vA1bw82wBUNEkMqi5Mh42I/Oylw8bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ljp41dVo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AA606A333;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ljp41dVo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7251F008A6;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300726;
	bh=CmhusFnIKRpHndm/TIvweb7mjKJxX/GPqtrCuccRSII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ljp41dVoKtq4US5DiJHUD84PmQKyoMc01gA73R57vkosl2yXmPYibXhVS5IMdncis
	 v/hM/sgYyHc+bOp+VXIzRV+Eb9LCYaom2R2e93oGVE0RnLG5valY6CGferWJDhssuR
	 d0f+w+thVcuOyown5c3w9cDWeprXSvH+XNH9781gc94tXfLvaVjNwrboA5+iKJg5+T
	 dpGZIrkZtxyZEKEDd60xA0eB/1I0xSEzqaWNC2z2Pp78co0lgdgU6Ns1LXOhPFXuJ/
	 SRDuEyYCcrc9hOoG6TLWA9vBAtblROjLyaTWGQ7eYa0gvSkl36aWKvLqFx3FPTO9Ov
	 R5JmCzk9nAIzg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQhaG-0000000AdcA-0B1R;
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
Subject: [PATCH v2 3/8] swnode: fix device_add_of_node() kernel doc
Date: Tue, 10 Nov 2026 09:51:19 +0100
Message-ID: <20261110085125.2535508-4-johan@kernel.org>
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

Software nodes added to a device by device_add_software_node() are
always secondary firmware nodes even if they may be stored in the
dev->fwnode pointer.

Fix the kernel doc which incorrectly claims that a software node added
using this interface "could become the primary node".

Also clarify that device_remove_software_node() should only be used to
remove software nodes added by device_add_software_node().

Fixes: e68d0119e328 ("software node: Introduce device_add_software_node()")
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/swnode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 65e9388af865..5dc2029f9a7b 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1055,9 +1055,8 @@ EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
  * @dev: The device the software node is meant for.
  * @node: The software node.
  *
- * This function will make @node the secondary firmware node pointer of @dev. If
- * @dev has no primary node, then @node will become the primary node. The
- * function will register @node automatically if it wasn't already registered.
+ * Register @node if it was not already registered and make it the secondary
+ * firmware node of @dev.
  */
 int device_add_software_node(struct device *dev, const struct software_node *node)
 {
@@ -1098,7 +1097,8 @@ EXPORT_SYMBOL_GPL(device_add_software_node);
  * device_remove_software_node - Remove device's software node
  * @dev: The device with the software node.
  *
- * This function will unregister the software node of @dev.
+ * Remove a software node added by device_add_software_node() and
+ * deregister it if this is the last reference.
  */
 void device_remove_software_node(struct device *dev)
 {
-- 
2.56.0

