Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910435;
	b=XJvRIqDQlMCihdgriqyMGhnSHRd5waAD70+Uk0ax9W533iPG80QIYdHwiF0hy9qO5Up3
	 01+zow6E2g8zHJQHmSF5twCQiYplARjVSwkd0DttxYscHbIHJqxZlew7c5MfJaTWUz42o
	 XUyMMldmzYYTrzOAMIbyzjORkOMHI6deFaDqULapx7xUYgAZhr5jfiq6YV8KYgBhf70x5
	 jggJqXqkR19OuYmFrqp9ljjq4zNcMC0cQdPt2JTfKFk/Wh+teAxVzuQYWquMdxboEGzWK
	 s3YeBliIkv9Zw1y++45WkDw99002JoZmVA7eijYaflUpvWina5Ljhms6VStjl2DDmuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910435;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QjDGLtqha/cHdnXW5I0ZL32wkEI+9zARmUCyRqpihY0=;
	b=f4Q7QwTSqMO7QUNnybCac6r7NVARyo9Mf22i8xrjROktZWFYkASGhYvaDU49h3XyCZgk
	 nmIKXF6axQg0vRw6vtOiG/Nv7OAkcTAomzDqRUQkC9Tu07ru+HW/TMn81LI4btGGCIBCb
	 gO0XWFU4m8V19TGTQg8GxnzTZ5g1Alb//+kIFx6+INeahW6ufxq+JbWSN/ibbWm7LG0E0
	 REPtXDRZ7i7NK/VK6e4GGq6MyTfB9TiEX4IjJNBhqTL3+HTnUwsYMJGaimCzD912+jTuu
	 1B7d1SarJBAHuK0YLb+XwfG1baY7EUZjwdjHuvdPq5i0bNv0PBd9GpXPpIZwGMaEW+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrfsZQnQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E7606A31C;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrfsZQnQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6F81F000C7;
	Tue, 17 Nov 2026 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910434;
	bh=QjDGLtqha/cHdnXW5I0ZL32wkEI+9zARmUCyRqpihY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SrfsZQnQM0pDXE13ETnnK92O6M4fhhjmkDWSdzv9Mt7TB1COZ6ysr/Qy+NzN3ch7x
	 ofybs/5XfaQ0w0WVSLoYseCwra4/ZRwX96nPpX7UND/09qJAJR0aDJBL6kqBzAO6Qy
	 CjQ3be2+txUdWcrBKZSQC8YXc3TDG19gPZSdvFraFgMDpKg8CP3/ZwtQXGh9LFGX/1
	 /kPgCWOM7lImiQFg+xiStMWRw/V9hqiCQqk+GVD6aQhneMPHR4BLc0pnmziJAj+dxx
	 LmvH/ZKoiyOraSk9I+/+WlA+CmjnwCSicmnpLjd2AFPOM2DrfTvHjEd2xMeIqRD61t
	 TND6W2YMrZuMw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTGCG-0000000470b-14mI;
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
Subject: [PATCH v3 3/8] software node: fix device_add_software_node() kernel doc
Date: Tue, 17 Nov 2026 11:13:31 +0100
Message-ID: <20261117101336.980216-4-johan@kernel.org>
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
index ce4efc506b9c..b2593b2fcada 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1048,9 +1048,8 @@ EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
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
@@ -1091,7 +1090,8 @@ EXPORT_SYMBOL_GPL(device_add_software_node);
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
2.56.1

