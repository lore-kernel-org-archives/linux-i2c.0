Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009267;
	b=3TLE7CN+3KD6/jAad2vrN/ZROFHathLUlxp4lozzBpQFSKMkG2z8zrHnrjgL2r0IhaCh
	 xmGHRzJgrarBL84RzUKKfspOp4am5FPu0CIey20pnNbMY7P8c7+mJN+yRDA1eAaH9G3bH
	 H+sAxOWsKX4Ly/or+LKSjdV0FGiG88ghgnuHRs7fdO1rlTpl0dHfIIsUaeN/oGpkE7n4P
	 WGxHJnk6E7VC1B+G73u1uQxKD8Cw0on/Rv/CjPPSZZgFqMQ4oItPJ5ZlGiH7CJczDffzy
	 8sg9abHgYMyBMmgnJnhhOMQ59biIDAzrb9IOnFGrjwUGTqYQNWwKmQedTyD6jUAyVxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009267;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=D9V4WkGeE1gNbwV0EuTSccb8kH3ZkT64phRaT3tM55k=;
	b=0f6eF6hbPefZ+uJVNN2GIrqfz36ks6whY/IdJRg3N575wt+Ohga3e5/JIFfydqahzoBj
	 rfQtNDc/LulN/1znwc+QxOEOMBVTspW2Ah3FKp8NTASvkms3JP+QgYJbRj6ahUOh7oaiL
	 E6Zb0VZePon9TM2m+3zTgWvIwbDKXkJdMebe4PKmKeFEv9wLV5O8HoGuinrN3XpwaLD+6
	 aF4/k2bSgmY+okDig78SZCvqduKqZChv3KtjELbfj/OkfmIrux92FJFo9mEF/xY1b5u0F
	 emnshDL44hk+Tlu1LN9UM5UODbYeGMzxsgNHjJxNflf4Mp4/zx9VudUnClshyD4M9lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QxPwFnlB;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65D60A2610
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 13:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B65D60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QxPwFnlB
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 74F96C4CBD9;
	Wed, 18 Nov 2026 13:41:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9F9635FE9B;
	Wed, 18 Nov 2026 13:41:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7DB711BC20A9;
	Wed, 18 Nov 2026 14:41:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795009263; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=D9V4WkGeE1gNbwV0EuTSccb8kH3ZkT64phRaT3tM55k=;
	b=QxPwFnlBQzMJjMVMjLqYccma9uxQ7cISONOrB1G0WNBWLYWpAakFpuyFkVPcXuP9TByPH4
	T7U8pFhv8dy6Dpee17NiN2L7rqEIASFVfL1o2avGDdpP7gzInaCQcVDvHTDM8yQ5JZraG/
	RhGx/Xoh1XaNr6NsSIlu1MwsJg4SpDZCTnIQ46gHJC/mb5SxpbzTNYvzO4lIfkE4dqt4TP
	BEx9DZiusYe5YKCW15Q+RPM8IVLNdIOPIXL/kaNPkQBdgCiRxnVVrSwx1AsH7sMkrXrbKY
	r2Z5uhT3RN/Dp+u9d84cRH+KvF/I62FBUTotXCH+Oz/FVyP42BDg+Vvk5p092w==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v10 6/6] i2c: atr: Create missing devlink between ATR and adapter physical device
Date: Wed, 18 Nov 2026 14:39:15 +0100
Message-ID: <20261118133927.366482-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118133927.366482-1-herve.codina@bootlin.com>
References: <20261118133927.366482-1-herve.codina@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

When removing an i2c controller device handling an i2c bus where an i2c
ATR (address translator) is connected to, the removal process hangs and
is stuck in the wait_completion() call done in i2c_del_adapter().

The i2c_del_adapter() tries to removed the i2c adapter related to the
i2c controller device and the wait_completion() is waiting for the i2c
adapter device release. This release is performed when the device is no
more used (i.e. refcount reaches zero).

When an i2c ATR is involved in an i2c path, the struct dev topology is
the following:

    +----------------+                   +-------------------+
    | i2c controller |       atr->parent |   deserializer    |
    |     device     |      +----------- |      device       |
    |   (supplier)   |      |            |    (atr->dev)     |
    |       ^        |      |            +-------------------+
    |       |        |      |
    |  dev's parent  |      |            +-------------------+
    |       |        |      |            |    serializer     |
    |   i2c adapter <-------+            |      device       |
    |     device    <------------------- |  (desc->parent)   |
    |   (no driver)  |      i2c client   |        ^          |
    +----------------+                   |        |          |
                                         |   dev's parent    |
                                         |        |          |
                                         | i2c adapter chanX |
                                         |     device        |
                                         |   (no driver)     |
                                         +-------------------+

When an i2c ATR channel adapter is created, a reference is taken to its
adapter dev's parent. This parent is the device owning the channel
adapter (desc->parent), not necessarily atr->dev.

No relationship exists between the device owning the ATR channel adapter
and the i2c controller device (physical device) in order to have that
device calling i2c_del_adapter() to remove its downstream adapters and
so, release references taken to the upstream adapter.

This consumer/supplier relationship is typically a devlink relationship.

Also, i2c ATRs can be chained and so, the upstream adapter can be
supplied by either an i2c controller device or an other i2c ATR or mux
device.

In order to get the physical device of the adapter an ATR is connected
to, rely on the newly introduced i2c_adapter_get_physdev() and create
the missing devlink between the device owning the ATR channel adapter
(desc->parent) and the physical device of the adapter the ATR is
connected to.

With that done, the device owning the ATR channel adapter is removed
before the device handling the upstream i2c adapter (i2c controller
device or i2c mux/ATR device). All references are released and the
i2c_del_adapter() call performed by driver handling the upstream adapter
device is not blocking anymore.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/i2c/i2c-atr.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index 7c599d2d09c4..5bc7e31ba998 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -788,9 +788,12 @@ int i2c_atr_add_adapter(struct i2c_atr *atr, struct i2c_atr_adap_desc *desc)
 	struct fwnode_handle *bus_handle = desc->bus_handle;
 	struct i2c_adapter *parent = atr->parent;
 	char symlink_name[ATR_MAX_SYMLINK_LEN];
+	struct device *parent_physdev;
 	struct device *dev = atr->dev;
 	u32 chan_id = desc->chan_id;
 	struct i2c_atr_chan *chan;
+	struct i2c_client *client;
+	struct device_link *dl;
 	int ret, idx;
 
 	if (chan_id >= atr->max_adapters) {
@@ -864,6 +867,49 @@ int i2c_atr_add_adapter(struct i2c_atr *atr, struct i2c_atr_adap_desc *desc)
 		chan->alias_pool = atr->alias_pool;
 	}
 
+	/*
+	 * There is no relationship set between the device registering the ATR
+	 * channel adapter and the physical device handling the parent adapter.
+	 * Create this missing relationship so that the consumer device (the one
+	 * owning the ATR channel adapter) and the downstream adapters attached
+	 * to it are removed before the supplier (the physical device handling
+	 * the ATR upstream adapter).
+	 */
+	parent_physdev = i2c_get_adapter_physdev(parent);
+	client = i2c_verify_client(desc->parent);
+	if (!parent_physdev) {
+		dev_warn(dev,
+			 "no physical device for the parent adapter, skip device link\n");
+	} else if (parent_physdev == desc->parent) {
+		/*
+		 * The parent physical device is the parent adapter itself
+		 * itself. Skip the device link
+		 */
+		put_device(parent_physdev);
+	} else if (client && client->adapter == parent) {
+		/*
+		 * The device owning this ATR channel adapter is an I2C
+		 * client on the parent adapter. i2c_del_adapter(parent)
+		 * will unregister it and remove the channel adapters it
+		 * owns before waiting for the parent adapter to be
+		 * released. No device link is needed, and adding one
+		 * would make the driver core unbind it before the parent
+		 * physical device's .remove() callback.
+		 */
+		put_device(parent_physdev);
+	} else {
+		dl = device_link_add(desc->parent, parent_physdev,
+				     DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!dl) {
+			dev_err(dev, "failed to create device link to %s\n",
+				dev_name(parent_physdev));
+			put_device(parent_physdev);
+			ret = -EINVAL;
+			goto err_free_alias_pool;
+		}
+		put_device(parent_physdev);
+	}
+
 	atr->adapter[chan_id] = &chan->adap;
 
 	ret = i2c_add_adapter(&chan->adap);
-- 
2.56.0

