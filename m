Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD9382388
	for <linux-i2c@vger.kernel.org>; Tue,  8 Sep 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848791; cv=none; b=dHGWJw3XMtGJPhdJyMrsJ7fj1WHllwcnK9RZmWd0uk0e4YpEjLyRb+BpQFzpBau4iEw0oOmzK/OYKwH4ug6Vt7SKuNES/k84N7esX9wWcl1pvlpc2wDtdptlgPMpp6/Z0subjLBmFI5csz8SuswUbw3hywKY554PC5gHSDx5n8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848791; c=relaxed/simple;
	bh=97JdfI+gRP1Pezy2CAC1AmZs6867Bh/GeLRKB1Pid9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOo96qRbiJkny1MhnWgFWDRn34a2LIuxFDhAd20yEQ2Tb4mH46zBVx1r1MElAG704Rt9uq40sXGxUZSydj8lmZfU6zNg2h1zboMg29Vd+oYb3KWmugdu6Y+ba/iZB5sN1LdWyP1bZEM6qVhGwhpjIxlQk0xpgbU44liWL8ZoxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O//bnrcr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O//bnrcr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84830c774a0so4020930b3a.1
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 23:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788848789; x=1789453589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fOo554LOyHwXNx9s3zqKma38NV/omqaXfwDDRqw2vNo=;
        b=O//bnrcrzXiW0yAVa9RfTbyWqJubSsATdqVk/uSDCmXQcvnaA5E5pHEfrH4ohVAtNA
         8zQRq45G8iXnf7Jwdo/QLM5Z7xdyCAAGpMHhF7kAEaUnVPaQ3pc2GsVO9jLiEHVHzgRD
         f/0PR2+8ih9x+1BLL8LyLdgi90wZCyDPxvDycAh6pXEOFDZo4ue3DfIcloB/yqiipGab
         rqnpeYFt4lPAmd0EUp4RtUrEHGzPdvpcc14kvnr1suPeZRZ2JCmz+HBtDeGaZ3C2dhvI
         vzbOs5QLl/cNgNYiEH2w4FlGuC5U6yxIQnnNcrs7Y2ztIRiXtNoksdPcHPuzzlMFJJDk
         JmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848789; x=1789453589;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOo554LOyHwXNx9s3zqKma38NV/omqaXfwDDRqw2vNo=;
        b=OGjuketKaYeKSSFuiHl+LQSq/+X97ytGGXeGO5UPeIfohHml3rKDA0+sbt8EoDnsIO
         bVzBx4wCfRMfggQ0GGjblxNSS+nT6pqUpkOLrho467Syq7yiFC1FUc0Uhyw20roT8k+o
         EBB47bO0n0jNYmhjyMzXwiurWoRHDSLIAieA0gMYbm+2EG8Nduu17/RT8uBozThZpTh2
         ADQTtXCLAUCMoHQ0W3zC8Ll9lXR/fnGdEKSDjcRK6t78axYzOEquA6QteCa6dKTcg9f3
         dqMfEbN7Cf5oJbZrQbSOJ3C00uPOQzRwaMp666QBZ9MNw+yVBSRJAmMF1zU2jV+x/kO2
         m7lw==
X-Forwarded-Encrypted: i=1; AKwUvBzFX/55CiqLFo6D97tJkuilvFkJe11isBQ6exeswT8LFu+K8416jEhfwc/SCKrSU2NvtinX76B/0X8=@vger.kernel.org
X-Gm-Message-State: AFuF++mWStM/PBzIe93KMHP/lgNxDV1lkaDDVBYZgo7l3UZ2tbNXLqgG
	s7kAs99lFnHkofVf7dz9ph7D128mttDkBUy6VYfDv377Hpg7jurrTZ4Y
X-Gm-Gg: AYBFou2s0DzLz81PzbUIh05Akn/Rid4AOBZIpHCLDdU42A6ZTaWF6IfFzgEDzbgUi/R
	adDJVVd/kQ0gItaJcF0y/t9z7csk3vOwGei06gaAESsCk2uBhyrdrkDbBACMUjBsBVrD/m1gtTD
	1rOndd44CkmXARZmA5nN3wGWMcckjSaURsudecjIR1L0sPtC9QPUNQfQCqk0aNX3aruTJZcD4+Z
	nT+yG3n+M8gZSJ1djfERMqGvNIxfEqzYYg4+aSgBdybNjhJ6AJ4leXuuUCllaSQPKSCj80ptwxX
	2P/Gu2xgEh2c1muEWzI8kFHe4loP0EgRW85exivbk5gEPMquyC+BH2tZ7HjcdQ6FM4Rg7OExDhL
	EaE3aeSC//6AYjxNMDrVtq3BxHrukbv7s6Z3YBS8gLcQCXJVFHUuNnsapZtrgbpqh4B6xlnZONs
	PY2iBS1OmnWSemsVKMPo1mIXCfpP28291HjJ51rUopxtcgM055wBwzOeLaezBsQLJ+Yvw+twu7y
	hHfTC2fvkopR5/hxlswJhPfzT5Ld0phs5fyMDuBrzy6Pv7yQhaHqpeVE5h+raWuvyQkaxaM6fNF
	zwbUIwhM397NrahAdpkZmUkjgEJHruM6ml+lILcMSg==
X-Received: by 2002:a05:6a21:70c5:b0:3d3:b00a:6f03 with SMTP id adf61e73a8af0-3da3a17910bmr41885190637.28.1788848789099;
        Mon, 07 Sep 2026 23:26:29 -0700 (PDT)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm30960386c88.11.2026.09.07.23.26.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 23:26:28 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] i2c: mux: Propagate firmware nodes to channel adapters
Date: Mon,  7 Sep 2026 23:26:23 -0700
Message-ID: <00b33b4b352848ff87dd9089190b35d8732676f3.1788623619.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788623619.git.ahmadexp@gmail.com>
References: <cover.1788623619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Device Tree channel nodes are associated with the adapters created by
i2c-mux, but equivalent firmware-node descriptions are not.

Use generic firmware-node operations for the existing channel lookup
and associate the returned node with the adapter. Do not restrict the
lookup by firmware-node type, so Device Tree, software nodes, and ACPI
descriptions all follow the same property traversal. The existing
acpi_preset_companion() call remains in place for the standard ACPI
channel association.

Keep a separate reference to the node returned by the generic lookup
because acpi_preset_companion() may replace the device's primary
firmware node. Release the saved reference after adapter deletion.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/i2c-mux.c | 46 +++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index d207f0e81807..53428098ddc7 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -24,7 +24,7 @@
 #include <linux/i2c-mux.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -33,6 +33,7 @@ struct i2c_mux_priv {
 	struct i2c_adapter adap;
 	struct i2c_algorithm algo;
 	struct i2c_mux_core *muxc;
+	struct fwnode_handle *channel_node;
 	u32 chan_id;
 };
 
@@ -264,48 +265,48 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
-static struct device_node *
+static struct fwnode_handle *
 i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
 {
-	struct device_node *dev_node;
-	struct device_node *mux_node;
-	struct device_node *child;
+	struct fwnode_handle *dev_node;
+	struct fwnode_handle *mux_node;
+	struct fwnode_handle *child;
 	u32 reg;
 	int ret;
 
-	dev_node = dev_of_node(muxc->dev);
+	dev_node = dev_fwnode(muxc->dev);
 	if (!dev_node)
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
 		return mux_node;
 
-	for_each_child_of_node(mux_node, child) {
-		ret = of_property_read_u32(child, "reg", &reg);
+	fwnode_for_each_child_node(mux_node, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret)
 			continue;
 		if (chan_id == reg)
 			break;
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
+	/* Associate the mux adapter with its channel firmware node. */
+	priv->channel_node = i2c_mux_get_channel_node(muxc, chan_id);
+	device_set_node(&priv->adap.dev, priv->channel_node);
 
 	/*
 	 * Associate the mux channel with an ACPI node.
@@ -416,7 +415,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	return 0;
 
 err_free_priv:
-	of_node_put(priv->adap.dev.of_node);
+	fwnode_handle_put(priv->channel_node);
 	kfree(priv);
 	return ret;
 }
@@ -429,7 +428,6 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 	while (muxc->num_adapters) {
 		struct i2c_adapter *adap = muxc->adapter[--muxc->num_adapters];
 		struct i2c_mux_priv *priv = adap->algo_data;
-		struct device_node *np = adap->dev.of_node;
 
 		muxc->adapter[muxc->num_adapters] = NULL;
 
@@ -439,7 +437,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 
 		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 		i2c_del_adapter(adap);
-		of_node_put(np);
+		fwnode_handle_put(priv->channel_node);
 		kfree(priv);
 	}
 }
-- 
2.50.1 (Apple Git-155)
