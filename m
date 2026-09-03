Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1150AC39
	for <linux-i2c@vger.kernel.org>; Thu,  3 Sep 2026 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464634; cv=none; b=eW4mx0t70lV7PV0/cJqOm8F/nZPfwdmE73NmPbFL71pUMfhDu6o1zeKIgFhGhg37dltWvj9hDLV8lDwL3Vh4z9USkY6/mdbtRHIDl9apVmIk1mhzRRZ+RM+aVXGeoFLyr/Q08ZeY+Ur/57qbiYO1E8h+ztAd6SfIDOqo7Imr8bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464634; c=relaxed/simple;
	bh=AUwUXYTSiLg+4+ZgzE1c1EjhRaY9RHvKMoQpUgZSGH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fN+aKA6FBS6dH20TbvftGkPAp1fdrz+4TqUoaPIlrchsmaTuap/2A7peFFKGSFPNrb8TSauv7hur8bNbPE/qcQxQ2ZYNc5FwPLco1xlJyWKOxv1/noC83ZbKlDPuTEbsdLi5VdG9IU9oiBzP5QlO1nLp4rM/qK86j2tT+mxW/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoP6Jj7i; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoP6Jj7i"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d8fd3b729dso2038245ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 03 Sep 2026 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788464627; x=1789069427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AahTyLWLBHNpF3GBq6NBDmCN0xxivJBqCrlvcZaObVE=;
        b=OoP6Jj7iDa0tNQ2HEjkY8fjezPYzwIE4Tmj+LEoC7P6yxhHZvEx+7GkleYpGdD0yhV
         EWgdFHEWcOrfe/eC+WbmHPmKs8ePyr1ymQwYpGM4QMtMOB4H68Q6JU2xVFnBaWeOfk2R
         IU2wlLvfTXlHXh2RpAqdai9ZXToD31HntHH2PBHlS5eGFBNa1iilZAokE2V64xkRLSsn
         YWeKM5TTfMU95qW5pWq/gzPbOKmEMKjI0B92L9UeeXU5LqUj9VFPmERkfKj0SKtdKJZJ
         swU1YwTu6uhRllBpj2Nppemja3hj1h43T27i32QTNHVYm6GgsI4jBTtxJIHBLzHcVDlG
         743w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464627; x=1789069427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AahTyLWLBHNpF3GBq6NBDmCN0xxivJBqCrlvcZaObVE=;
        b=hqAL/LjefGW0x/TEwT5E/EKhpRxn95FCUhMGIhA6gxtC3favG+zSDXo3JfQ0KtGkir
         rJyd3QHvKvoniJnaGLc1gHlyubhbiBbjWNiMvxljPRIanxcAQgwyA8tqEdYICp2hgTjJ
         MwU5mQ8gW3DObmON/rUu7e5VDSHnMRAnqCsKvn2pDgZ4kYiw4KniZXt1BoWjbfsA3LpN
         dz0zCHgJmdVyl1ym+X2lQd2o+BSFhxW4iJqOKpFWSrk231UIxlhNXhNBEjY5KQKkxPxw
         vxMloPn4IiRbaZUfzwiTmg5UChoVF79s5+9FI9DdUQkyauB4JWNsQ4DHUgVXkdyC4YmZ
         yjbw==
X-Forwarded-Encrypted: i=1; AKwUvBx0FvEkGPP7Bvk1tPIIbqvSXAIJF8G6xVWOmkB/OjP4SIJUItg1a2AJZz1b6shbsBJX4hVHGKmlaag=@vger.kernel.org
X-Gm-Message-State: AFuF++mNsaAO2z4qfwJyhLISwxjIE8D/AxaFwCrsRw2N3qlYRJw6Z0aM
	Am3NaNeCxejz3wW3fDdfhxVQcitQqPtDX8+JbwWONGb2Y+6EcUtQ/fkH
X-Gm-Gg: AYBFou37JE0uXL9GyZ6CmLTdBeJDOodZO/3Ot5SLCirqzNn9U7VWU9Y9HVdjTIOwyg7
	gKPdanNSj7gt0BXJxRFXxKtA2YbtBMUqfrzPirvFPpEL8SBpTHU5E6Z9DMNzo0UHGvnsF9JGOya
	uhMC7mhDzFaFGCJPTSQcfvOH4huZRgQOdDtYQl4+OsiGROF6oHSAVkjrK2ke62LWp2WaJZwi67o
	CQD7VK/oIiBEHAz1W775+oRcU/1opA6Smmyahf2LP/xnVtTcs9YSiZprqDLLqbAp2kT6ibTcC8C
	TmJZTqxu4jFRZAorK5nhRDfn3YxaNPOoAJAA74hYNW3JLpYw5exzu/ptOyIdXMCOGfTwaWd7sNA
	cANteXPuDh+LbOheb6selBBa6Pv43M+gEVEA2N+jmZIKy7Xs357Mtj8KOXOAKuAMnd2dZPJH3nc
	gj86zVBkwdaqFGDkQHDvOSMwjit8bgYf/wFkH/pK13ggibmrAPgY+eHeNeAwkPXqM77brxrzcsD
	CfNmDe19Ubb7UVHes0PzHBQj93LzUvGQrf5B3yKHJ0aZOVZqGfgWpJGIKG4jqsh+fCsJdZUgt0y
X-Received: by 2002:a17:90b:510c:b0:398:9be6:f999 with SMTP id 98e67ed59e1d1-39b262e27a9mr1194828a91.24.1788464626540;
        Thu, 03 Sep 2026 12:43:46 -0700 (PDT)
Received: from mac.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ce11sm1201335eec.3.2026.09.03.12.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:43:45 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [PATCH v9 2/2] i2c: mux: Propagate firmware nodes to channel adapters
Date: Thu,  3 Sep 2026 12:40:56 -0700
Message-ID: <fbc7f6e21c12b87f56cc8593b380e7460440bab3.1788298883.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788298883.git.ahmadexp@gmail.com>
References: <cover.1788298883.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/i2c/i2c-mux.c | 44 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 37529c7627a6..e0b0116d5b6d 100644
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
 
@@ -264,47 +265,47 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
-static struct device_node *
+static struct fwnode_handle *
 i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
 {
-	struct device_node *dev_node;
-	struct device_node *mux_node, *child;
+	struct fwnode_handle *dev_node;
+	struct fwnode_handle *mux_node, *child;
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
 
@@ -367,11 +368,9 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
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
@@ -415,7 +414,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	return 0;
 
 err_free_priv:
-	of_node_put(priv->adap.dev.of_node);
+	fwnode_handle_put(priv->channel_node);
 	kfree(priv);
 	return ret;
 }
@@ -428,7 +427,6 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 	while (muxc->num_adapters) {
 		struct i2c_adapter *adap = muxc->adapter[--muxc->num_adapters];
 		struct i2c_mux_priv *priv = adap->algo_data;
-		struct device_node *np = adap->dev.of_node;
 
 		muxc->adapter[muxc->num_adapters] = NULL;
 
@@ -438,7 +436,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 
 		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 		i2c_del_adapter(adap);
-		of_node_put(np);
+		fwnode_handle_put(priv->channel_node);
 		kfree(priv);
 	}
 }
-- 
2.50.1 (Apple Git-155)


