Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300728;
	b=0529ESlXbk8FJhreSC+1N3GXKtay8qkNajsqcGL6lhtR+Edqt4h65Xe1B4KBj9iU9z5u
	 8Y2oIjGyYcgFL4U3jsfZuwZxUax7eZoYxzQD6F9fLpBc0e9RUy4C5uHwvXT8OvsFLIqm5
	 faj0XmSUcUYBoeQoXxohkPilTXJUi10e7bm+cZ8b/GJhrsrjoQVDyBYo+t3SAVP3nLm+T
	 S8J1DKsnMEfGttlRVjuPi4m11KDGSqp3OGhMZeVOCPJa96YrEngl7jNkkKYeaRQcOpCuU
	 jP2Dj51ULbUPiV5mJJjwb/qcXNEa3gT2eyQX9PWvTsaeATAckVteuR3mkr4bLpWIWtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300728;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KPkSyWmMxgDZuWDbTvIEXPsXYBpnEBPaDZSbFviXDFY=;
	b=eRfbUH6TpVai8AIoAZzALeV1Yknx4yyLmxWMhFR4iQs62kw9NFyIXjjFlkufdfdSgBkG
	 +EYKuSL414hTe4wbJBFqv0+adM7EQFLxMP8U7utZs3337oiF+gTh+P0WFyXRybNaOPMMZ
	 dnUozDPGEhNCwNxc5Y+MnojShSpOqoJ+tE3yzeVHAvkYhimJLmiBf8c6B0cUGsVxbloUO
	 MK+zd06DEkVb2yemHhl/IRTBaplB2FiY7nbZfvwHSgIzHBPM+V2oAssfRuslq8z/X/pKT
	 XfGXUGHcmLflS8FdeJozAquehQT18rRAoVcvVWYA7yz2ku7TRL48JD9kS3D3jQSLwNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=areamqLr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BAE606A33C;
	Tue, 10 Nov 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=areamqLr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B098B1F008BD;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300726;
	bh=KPkSyWmMxgDZuWDbTvIEXPsXYBpnEBPaDZSbFviXDFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=areamqLrr2+WLInL6xF6oO1rPJLMODIhdyXAGv3v4LFmNX4ZuJIXuibyDNp3zo6Ob
	 +jLAsTrQ1onUhG0V9HKYx5j4wCVYpv8hK8kGZII+b2KxFQtfzcQqkQgROR8E9QQMBB
	 rCLblL6yXni7wzejibF0vEUO3ikY8lH8PzHvn8oan8g1At1lHwUcklkFccbwP5WKhJ
	 Pv6U6UnCGwmd9oQSrhe6st0BTtuaPXSnFPSzbxGEkbucC1rv15vgLlmcdWG/W/j0hu
	 Qlg2DNZEioFEaSGwfh3USL0GROrKS01nT+Xy/vndLELBWqTOoMjbaIChFdubxdyCsi
	 WOL8kiMkSjTjA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQhaG-0000000AdcI-0NOh;
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
Subject: [PATCH v2 7/8] swnode: fix software_node_notify() primary node comment
Date: Tue, 10 Nov 2026 09:51:23 +0100
Message-ID: <20261110085125.2535508-8-johan@kernel.org>
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
index a90c20cb84e6..8e12f518e13f 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1169,8 +1169,8 @@ void software_node_notify(struct device *dev)
 		return;
 
 	/*
-	 * When the software node is the device's secondary firmware node,
-	 * the core only records the owning device on the primary fwnode
+	 * When a device has both a primary and a secondary firmware node the
+	 * core only records the owning device in the primary node
 	 * (see device_add()). fw_devlink resolves a supplier device through
 	 * fwnode->dev, so without this a consumer referencing the software
 	 * node could never find the supplier device and would defer forever.
@@ -1205,9 +1205,8 @@ void software_node_notify_remove(struct device *dev)
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
2.56.0

