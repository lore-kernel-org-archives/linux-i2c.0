Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20052C0296
	for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787502886; cv=none; b=DHER6epYG/6sVW1/IHnTujse9bdAu6kmJ/NrUWh55A6AG5KGLFBsTxz9+mYafoW0TxRXoet28GgwdXcZpFLs0WHCmoRQrmcCk7ktyzXPMwshmcIpphyIEh3xtlsBP/Jaw2dWHi5LxlFrYvKMfH5XASjiUO4enF0DHiXMBi+ByZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787502886; c=relaxed/simple;
	bh=HUYvrAXW6ktdAawFO9BGSNSafLNtS5sykuLnjS6hzPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUVDRBxYjxy/3fEDdHPAb0uz4jd2PBiB+cJ48an00nCMmKw6PJGpD8CXhfCNRFMD/CVJkkl42OG+9gFX0dWo0LJFy7wEaTyrj13uvy2SnUNKV6dN33hmyiqIrQUcPQImZNsxvZ6oR38f2b/JdVbTlSAiEGCER4EYg47gDZiGYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2zYf7qW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2zYf7qW"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceb096e675so30428985ad.0
        for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787502884; x=1788107684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GxGKUYSLhGHGkrvjs/JDyLU+7Ol+Ws3V83G2cQ2UfpU=;
        b=A2zYf7qWs9x/jOWQrxU+qooeXt95Y8s8kUJ87ciFHIDELzVyXfXxf/BMT/3aEoo43G
         E26BeXXC2Xps/X1SY0KrkFgGnCeUOUwCb8CED6aO/N1AxmxMwciOL5qFgwmON8xVSHJr
         OQtNgBQGG5pmtmrcG7N5EQWuPS8m8SbGkJCYrd/lkg25gdix4H0ShodpFL24rMD3uHqK
         jzrjz3KjGa1oUbu4IsjeIBcV7Ps/AI5GVybK4xcwn4QFqm/ewOA+hjzEcnT8b0G6GVhd
         cWu8snQkXj4QU46yIADWn9baGsYB3y/Um2OZvAGWnx8jZrw1P39S/yNnBwMY/mh7U6a0
         MDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787502884; x=1788107684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GxGKUYSLhGHGkrvjs/JDyLU+7Ol+Ws3V83G2cQ2UfpU=;
        b=Mfj72xIMKFhqqVZnHCDfcq1CYDM16n9fFFhkBSBxV9mXx5ZgOjk4hlo8saLmKPPFJP
         QV2LxxZN4Kgsu82hjV9DWcgK+bjUv06K7Y4nTMAgCQRxWCo7TDdkF0cGzm05FQrhmo6J
         l50gkansVGor+Mj3uZEaTgfs2Nxb1vW/VsXoI+eHwk0P+oqCervSk8cmMBEuDpBjBaKB
         Bx+5mVncrIXQq0dCzR0t2rsYIH29uYqVKm+sZi1LLaCj0M38khfDZAjXnBKjEEO5TyEJ
         8G7R0qmAbpPxoWRUoJwiSYhg582LNp75F3MS5ddvrAZ8oAbV3Of0kZMNIcRAqzhawwZI
         6rHw==
X-Forwarded-Encrypted: i=1; AHgh+RpU4J76LihyJv3itmC1CHeSYe0/DpQAvzjgNFY0qPzAI51Cl3IW6JojmThefOdr3TRJRWs9MYXn3mc=@vger.kernel.org
X-Gm-Message-State: AFuF++nMMriT8eBf+JDAa30Y+dLnbqoWILLDXWgaDZx0t5QQFKn4iG1+
	ygMD6k+kxo4p4mR2MloiJ3MWXqIgcHO6KbR+pWQDqHv4m1yFu+hm2ITV
X-Gm-Gg: AR+sD13IXF42ld577l6wqOUBGngk7xr2puVUV5KpvJTEmO0w6L+aSQelcrwQzGN0wRe
	YO7CyjSMYyTjRGG3xhO36oZSBs8YxmDdod/24ORoyrGe9+pneAxj3o6EXO5fFtjXwMd1L8yBT5q
	ny/UhXKRvVLo/sRc0iVsIh1cRHO9x2idJCoxjAEqXzDhxwH3cRvtNReU3sfxRXglYMO0Imy+t/X
	ZBBTW9mzmhTHuBoAKVvo+7sHXI2TWUbIMGOs5CpWJHvUzCNsjlUEt1RgnwFnRzuNS5NMuU4KX7x
	7sOhhzCTgOEhFZ/kwIHi2mRPmraVHR/nsmZofvqbieSM3K7Sv0RJ5PDV4mcUSmg7wLAa4HbHu2l
	rrH69lLBG6XqZjXU15o7oP7CK0uVUdpcsfyrFdlQbd59rTa+za3hoiTDSKglT07wcIMFgoYMVsq
	DSjBb3iMRA7PqBGIXPmME2qQ0CEG0JtYb2qPm2m+9/Nx0FxVzHLIg4T+bSHLYEH4ykRKdaxYInv
	9lQzSXGnSPITqOBUNVjIzr9IysUpsymCl78p5N8zA0HYlcVioBOdzVrhsqfOEuHoZn9U3h3Qpa2
	gwkl40IglYXHPh+iZoAv
X-Received: by 2002:a17:90b:5790:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-395deecf08fmr24060528a91.7.1787502884014;
        Sun, 23 Aug 2026 09:34:44 -0700 (PDT)
Received: from Mac.net (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860ef75esm17084319c88.7.2026.08.23.09.34.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 09:34:43 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [PATCH v7 3/3] i2c: mux: Propagate software nodes to channel adapters
Date: Sun, 23 Aug 2026 09:34:38 -0700
Message-ID: <a4abcd31c3a6758e219f5edcdd4acd307e674f18.1787502619.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1787502619.git.ahmadexp@gmail.com>
References: <cover.1787502619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device Tree channel nodes are associated with the adapters created by
i2c-mux, but equivalent software-node descriptions are not.

Use generic firmware-node operations for the existing channel lookup and
accept either an OF node or a software node. Associate the returned node
with the adapter so child I2C devices can be instantiated from
software-node properties.

Save the adapter firmware node before adapter deletion and release the
reference afterwards, following the lifetime pattern in i2c-atr.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/i2c-mux.c | 45 +++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index a8b94b97a725..b37d36d3b121 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -264,40 +265,40 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
-static struct device_node *
+static struct fwnode_handle *
 i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
 {
-	struct device_node *dev_node = muxc->dev->of_node;
-	struct device_node *mux_node, *child = NULL;
+	struct fwnode_handle *dev_node = dev_fwnode(muxc->dev);
+	struct fwnode_handle *mux_node, *child = NULL;
 	u32 reg;
 	int ret;
 
-	if (!dev_node)
+	if (!is_of_node(dev_node) && !is_software_node(dev_node))
 		return NULL;
 
 	if (muxc->arbitrator)
-		mux_node = of_get_child_by_name(dev_node, "i2c-arb");
+		mux_node = fwnode_get_named_child_node(dev_node, "i2c-arb");
 	else if (muxc->gate)
-		mux_node = of_get_child_by_name(dev_node, "i2c-gate");
+		mux_node = fwnode_get_named_child_node(dev_node, "i2c-gate");
 	else
-		mux_node = of_get_child_by_name(dev_node, "i2c-mux");
+		mux_node = fwnode_get_named_child_node(dev_node, "i2c-mux");
 
 	if (mux_node) {
-		/* A "reg" property indicates an old-style DT entry */
-		if (!of_property_read_u32(mux_node, "reg", &reg)) {
-			of_node_put(mux_node);
+		/* A "reg" property indicates an old-style firmware entry. */
+		if (!fwnode_property_read_u32(mux_node, "reg", &reg)) {
+			fwnode_handle_put(mux_node);
 			mux_node = NULL;
 		}
 	}
 
 	if (!mux_node)
-		mux_node = of_node_get(dev_node);
+		mux_node = fwnode_handle_get(dev_node);
 	else if (muxc->arbitrator || muxc->gate)
-		child = of_node_get(mux_node);
+		child = fwnode_handle_get(mux_node);
 
 	if (!child) {
-		for_each_child_of_node(mux_node, child) {
-			ret = of_property_read_u32(child, "reg", &reg);
+		fwnode_for_each_child_node(mux_node, child) {
+			ret = fwnode_property_read_u32(child, "reg", &reg);
 			if (ret)
 				continue;
 			if (chan_id == reg)
@@ -305,7 +306,7 @@ i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
 		}
 	}
 
-	of_node_put(mux_node);
+	fwnode_handle_put(mux_node);
 	return child;
 }
 
@@ -368,11 +369,9 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	else
 		priv->adap.lock_ops = &i2c_parent_lock_ops;
 
-	/*
-	 * Try to populate the mux adapter's of_node, expands to
-	 * nothing if !CONFIG_OF.
-	 */
-	priv->adap.dev.of_node = i2c_mux_get_channel_node(muxc, chan_id);
+	/* Associate the mux adapter with its OF or software-node channel. */
+	device_set_node(&priv->adap.dev,
+			i2c_mux_get_channel_node(muxc, chan_id));
 
 	/*
 	 * Associate the mux channel with an ACPI node.
@@ -416,7 +415,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	return 0;
 
 err_free_priv:
-	of_node_put(priv->adap.dev.of_node);
+	fwnode_handle_put(dev_fwnode(&priv->adap.dev));
 	kfree(priv);
 	return ret;
 }
@@ -429,7 +428,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 	while (muxc->num_adapters) {
 		struct i2c_adapter *adap = muxc->adapter[--muxc->num_adapters];
 		struct i2c_mux_priv *priv = adap->algo_data;
-		struct device_node *np = adap->dev.of_node;
+		struct fwnode_handle *fwnode = dev_fwnode(&adap->dev);
 
 		muxc->adapter[muxc->num_adapters] = NULL;
 
@@ -439,7 +438,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 
 		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 		i2c_del_adapter(adap);
-		of_node_put(np);
+		fwnode_handle_put(fwnode);
 		kfree(priv);
 	}
 }
-- 
2.50.1 (Apple Git-155)

