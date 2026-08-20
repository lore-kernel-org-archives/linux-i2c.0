Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B4481A98
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247671; cv=none; b=n4hG4kaxRTs8Rp497rLqXke8aUXRHEn8wTTn+FcCjq56Ma6GEd1H+9iVxCBCwA2zYtNf06mQ6vx1CTsXyqd5BZM5lrm4bpT70F8SYumjLDzIMtshcE8M9sXQtqfPwDX7CVz2LYPC2vYjOP2p+wInEBtnyxgzYOc89ISeryXjJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247671; c=relaxed/simple;
	bh=lTNPzVr6aEGfj5ESPPhRasa2ZHq56ejhJWmSkgBxpYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2LZ4JQrLtKXgov9+wZ+E/v3c2c3XUGa1IY+efRDtBnUcvksbgWCiV4yS1cEhJLGAv+gyEUaF1Fz3aaJQaO2VkaGylH/t5rwnph+1zQ+ef+4ySqpulRMj3WFolWJfBQjZmu8ufuKkJyK4OLTxwTJeB3Ji0hkghR28AHxBPx4FQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSjq2vPC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSjq2vPC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d032846c95so1815095ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787247669; x=1787852469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O7KMdDzbIC1QroGeo8Cy4bum1ArkV9EBPN0TLsbF4kI=;
        b=eSjq2vPCh7JeQFj/2h9Y5SfYgSTF0bMW7mLfekZIQ5nS4Yl91TDuP4gzgZLOTIh/G9
         Ts7BNi3KmIJ/1h5cQxHoxnUlGsiOhPn5e7HzOu0F/9o53m10yLOnny17xd0wDEeX5LH5
         1PbvoW4izj2NjdWghxNzibpRMI3kTzMtZxeG3cs2sTCmscBBXH4V5VJJaefJUoJAd6g3
         u32nLNz02U7mAROXwKUJmRA856XdD+c4bVX7BCeYQEShoH/yFn0Je4CDBuCsoVAmi6Gl
         9nGEaynRxuS7nGZp3GFCKPnJKhLq7JI/3sCAR27QeYc7FRhWj4neJd5Ndk97oThu1pEM
         ydsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787247669; x=1787852469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O7KMdDzbIC1QroGeo8Cy4bum1ArkV9EBPN0TLsbF4kI=;
        b=V+JDMZgOPisYuMDiefRK/O46E/Ctx4igcoV2rr5OI7nOrA8tLvrEhxQF8XWMnBuSNO
         HyVyvfNU+1fpnUEtXVkV4QdYPWQ1MKgmCNbuAqOGVPZACREFhP56Q6+1N5yTx3Uku8dA
         XoJ9zftyP5S/8+1NIeMvNlZVFKDBWwc2yhyPcRxhkjvYqPkHC+Fhltg8Tbkg4TT9FoYB
         opN1jmT7qUdi4Ip0+SkHIZqn0pdA6+NPtc+nAUOnWXY3nY+RT8FmahDNvFavbG5IGvcn
         zHVMGYIWqZqvYltRChuLJyLADn7m3jIUT5/rZoDg3ROYGrGMIGTWBzXdW58PHWbiQ+28
         Xrnw==
X-Forwarded-Encrypted: i=1; AHgh+RrGs4zuiU3Zxe8QtANYpTCvYyqGLaCkxVxYR0E7XY6dyFxoVfxrayfMcWjvjb4s0eWbKNBxvezfW3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsboPrd+cen1T/8bWWbyvAPYkeJSygvox0MN2Hx3KSYXEwk7j6
	BSj318GeEyggHGURfc0lGeppDY9ePi+TeQ7bqFFzz2gTEYui8PN0MvaG
X-Gm-Gg: AR+sD13huunMx2u025QkRZBZDWb3bHYf3maG/3bO2HczobLFzzImPT1nkvE4HwLKoh1
	tb066qKSdTp9cogqFY5wVa+DXesNW7jlyDVn2HvBqXlEBd6pRpahZUAJrpoPLxdyoRCayy/q+jB
	sMRUM+9QnT9dY67/k7FYW4XvA4w35AD6e0YaV5J58/BAOUJ4vIZyDxH0//71bKuXFPwrZ1pBind
	zhfg5KzhDh45cDzQLdcpTgfjKNinne30gC8RiCrt/mT7kwdA1IPxMF6YeFxSqVS6U4RS1/8+wnk
	cj+tGi5Uh3MwlF6boNy84D/7k6c416x0VqZifXm4KcyaWWvTzFUPwLQ9z+dBpHXqAQNANWNFdnY
	uYyDpV38VcnLRvDsoqSu/g/zUFEIxtYqOAQM7pcc1VpJwffEHbEoInHWhGgaSfAW4ys2gYVLNWO
	/Ov5GhzSvgMW4E6xVJWmDXPl4Hha8ngNJNfVcwf66hkvpjFQfA3LXJ6NM5cM8U3aLutDd+s+RI8
	VpgXSPttdXu6sK/BD9aiMLSgRNs+KiJ7hROHAdHytEmUHOa+e/ruw==
X-Received: by 2002:a05:6a20:43ac:b0:3b4:8f18:33a with SMTP id adf61e73a8af0-3cd2fd8e233mr264870637.1.1787247668691;
        Thu, 20 Aug 2026 10:41:08 -0700 (PDT)
Received: from Mac.net ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d6168e5bsm7943356eec.1.2026.08.20.10.41.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 10:41:07 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] i2c: mux: Propagate software nodes to channel adapters
Date: Thu, 20 Aug 2026 10:41:06 -0700
Message-ID: <eb4a8ab1eedd8a01ca34c6a7e0685639d0498423.1787247467.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device Tree channel nodes are associated with the adapters created by
i2c-mux, but equivalent software-node descriptions are not.

When the mux device has a primary software node, find the child whose
reg value matches the channel and use it as the new adapter firmware node.
Keep the node reference through child-client removal and release it after
adapter deletion.

Also balance the Device Tree channel-node reference when adapter
registration fails.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
Changes since v5:
  - Send the I2C prerequisite as a standalone patch for the I2C tree.
  - Limit propagation to mux devices with a primary software node.
  - Avoid secondary-fwnode access and changes to generic adapter lookup.
  - Follow the i2c-atr reference-lifetime pattern for channel nodes.
  - Balance the Device Tree channel reference on adapter-add failure.
  - Rebase onto the I2C i2c-next branch.

v5: https://lore.kernel.org/r/cover.1786746757.git.ahmadexp@gmail.com/
---
 drivers/i2c/i2c-mux.c | 61 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c239ba..76fa89dc6a222 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -33,6 +34,7 @@ struct i2c_mux_priv {
 	struct i2c_adapter adap;
 	struct i2c_algorithm algo;
 	struct i2c_mux_core *muxc;
+	struct fwnode_handle *swnode;
 	u32 chan_id;
 };
 
@@ -264,6 +266,49 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
+static struct fwnode_handle *
+i2c_mux_get_channel_swnode(struct i2c_mux_core *muxc, u32 chan_id)
+{
+	struct fwnode_handle *dev_node = dev_fwnode(muxc->dev);
+	struct fwnode_handle *mux_node, *child = NULL;
+	u32 reg;
+
+	if (!is_software_node(dev_node))
+		return NULL;
+
+	if (muxc->arbitrator)
+		mux_node = fwnode_get_named_child_node(dev_node, "i2c-arb");
+	else if (muxc->gate)
+		mux_node = fwnode_get_named_child_node(dev_node, "i2c-gate");
+	else
+		mux_node = fwnode_get_named_child_node(dev_node, "i2c-mux");
+
+	if (mux_node) {
+		/* A "reg" property indicates an old-style firmware entry. */
+		if (!fwnode_property_read_u32(mux_node, "reg", &reg)) {
+			fwnode_handle_put(mux_node);
+			mux_node = NULL;
+		}
+	}
+
+	if (!mux_node)
+		mux_node = fwnode_handle_get(dev_node);
+	else if (muxc->arbitrator || muxc->gate)
+		child = fwnode_handle_get(mux_node);
+
+	if (!child) {
+		fwnode_for_each_child_node(mux_node, child) {
+			if (fwnode_property_read_u32(child, "reg", &reg))
+				continue;
+			if (chan_id == reg)
+				break;
+		}
+	}
+
+	fwnode_handle_put(mux_node);
+	return child;
+}
+
 int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 			u32 force_nr, u32 chan_id)
 {
@@ -324,8 +369,8 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 		priv->adap.lock_ops = &i2c_parent_lock_ops;
 
 	/*
-	 * Try to populate the mux adapter's of_node, expands to
-	 * nothing if !CONFIG_OF.
+	 * Associate the mux adapter with its DT or software-node channel.
+	 * DT support expands to nothing if !CONFIG_OF.
 	 */
 	if (muxc->dev->of_node) {
 		struct device_node *dev_node = muxc->dev->of_node;
@@ -364,6 +409,10 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 
 		priv->adap.dev.of_node = child;
 		of_node_put(mux_node);
+	} else {
+		priv->swnode = i2c_mux_get_channel_swnode(muxc, chan_id);
+		if (priv->swnode)
+			device_set_node(&priv->adap.dev, priv->swnode);
 	}
 
 	/*
@@ -408,6 +457,8 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	return 0;
 
 err_free_priv:
+	fwnode_handle_put(priv->swnode);
+	of_node_put(priv->adap.dev.of_node);
 	kfree(priv);
 	return ret;
 }
@@ -429,7 +480,13 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 		sysfs_remove_link(&muxc->dev->kobj, symlink_name);
 
 		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
+		/*
+		 * Keep the software node through child removal. The adapter
+		 * device is cleared on deletion, so release the saved reference
+		 * afterwards.
+		 */
 		i2c_del_adapter(adap);
+		fwnode_handle_put(priv->swnode);
 		of_node_put(np);
 		kfree(priv);
 	}

base-commit: b0e590bb83a9e40dc1e77a2c82d7f3e670fb74b3
-- 
2.50.1 (Apple Git-155)
