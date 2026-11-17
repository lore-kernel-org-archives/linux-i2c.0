Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910435;
	b=LLIrpn5xtZo5o4xqXYtsV/FJKKvuTxYVUpT9kXGXSGc5lm8hd7Gl/1B9J9gipt3dJ0qP
	 uJSZ3BaYbDepcEL3OqZbIQLSSAIV8guDQ9h5qs3o6Nf7v+4uAgB66PeCjsfAjADbUB9oK
	 5Lfyzc1POnYQzo2+pv9yxi4JGnYXhvMXUEcQ69I1lUxwCEP2StBPWF6KvXZf6bJKumvet
	 nmelwiTOHvBO8yBV3L3CEafKbWPnglV1ZyOtRmwFqvGt+Pa3w5NkprVtsAf5hu6aUHSjQ
	 0ozTszRR5JqvvkpH//z0JnsO91qOQh7ICE3pWy1ZXyrsZGj6sNkA27MG8UROUCdcR7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910435;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Uqr0RsAzwR704VqAsb1fcnnG192uX0RBTlwymj9VnQ8=;
	b=DQrp3FB6GhPySHMZTtgYKBHe1yhN5UBpH3287kd8LI1TXH4VwzcVvNbV6vwAJpbuDRI9
	 gYlTHRRnS3vbEHV8NJkbNg4GGLf5CjyktFMWhkTw3QHeX/KI5CUfi0vocT7fcl0Lg1Sch
	 9wjl7nbe9uXJ6Atgoc4zuSEnssjN8FLeOjwVgtl/4cjsiQawk5FgjpFwb9OnSlBBp9c/9
	 sG/CwiN/BmFi2PaJq6AC56jNLoqiT/uFCJ8KUbwh5kfvTrbO2bbFzdITxJWhWzlm219g+
	 DkRA2Qq1EnWV2eaIJRI9qXrOiLEiUww9FO80YKAdMTv2gX2mx44dvc0W/DXPlK5vt8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfrfYdv8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EBC606A337;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfrfYdv8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070E31F000CC;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910435;
	bh=Uqr0RsAzwR704VqAsb1fcnnG192uX0RBTlwymj9VnQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VfrfYdv8VQOrLMzD7fZ3dxk5i00YnKbKtVsWidxqYL1qRaVpdI6O2GBVUg2H6hsmj
	 EEDXyJ1CnHZ9r/scqGR/3h9EAnr5scdIKMRe3U1le/dvh9ucDBaC4iK+n1pOdexZbh
	 sOWP96m+EdfCe30q/h2FAIZxcfr/hNydZJUAmKFf56XM83yAbRFNcLrwjFJwUHHbc0
	 pGPtiqUtSfShMTBCMEr7sIbNVRDEvkBXxUgmlCL6mM+yN8ePgW5cfmwhpLdLAtKBGP
	 +JQ86p08sQVFwPZa1SxJanPcqL5/KrGYYlYmGn0cP5sL6oAN4UtH+0f8zT2RQKF6Dm
	 2nM1j2XQ3rULw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTGCG-0000000470j-1Ixn;
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
Subject: [PATCH v3 7/8] software node: fix software_node_notify() primary node comment
Date: Tue, 17 Nov 2026 11:13:35 +0100
Message-ID: <20261117101336.980216-8-johan@kernel.org>
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

The firmware node pointer in struct device may point to either a primary
or a secondary firmware node and driver core sets the dev pointer of
that node when registering devices.

Fix the comments in software_node_notify() and
software_node_notify_remove() which incorrectly suggest that driver
core only sets the dev pointer of primary firmware nodes.

Fixes: 37e586675993 ("software node: add fw_devlink support")
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/swnode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 95283d8bda26..78e224539b02 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1162,8 +1162,8 @@ void software_node_notify(struct device *dev)
 		return;
 
 	/*
-	 * When the software node is the device's secondary firmware node,
-	 * the core only records the owning device on the primary fwnode
+	 * When a device has both a primary and a secondary firmware node the
+	 * core only records the owning device in the primary node
 	 * (see device_add()). fw_devlink resolves a supplier device through
 	 * fwnode->dev, so without this a consumer referencing the software
 	 * node could never find the supplier device and would defer forever.
@@ -1198,9 +1198,8 @@ void software_node_notify_remove(struct device *dev)
 	sysfs_remove_link(&dev->kobj, "software_node");
 
 	/*
-	 * Drop the device pointer mirrored onto a secondary software node in
-	 * software_node_notify(). For a primary software node the core owns
-	 * fwnode->dev and clears it in device_del().
+	 * Clear any device pointer set in a secondary software node in
+	 * software_node_notify().
 	 */
 	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
 		swnode->fwnode.dev = NULL;
-- 
2.56.1

