Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFA42669C
	for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196935; cv=none; b=PU3JjYB3w0DBDBEkNYdOeAQ+AZpr8Ruya6A4jFSwTFHOJHMHgYl9T7mBD01NaX2QxlmUl3JGuinIC2Npi1AAnEQ0aLHHIDzlMDTnmGspi7IzeSuZh9eOU8YTT6f8mDJoz3Jb5wIayo0QASNVFQFt96TR3JqHPmsNv2YZwWBxTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196935; c=relaxed/simple;
	bh=mRHP7DPmTRhCyJSapKjrLYKc8ZrRP1+CLeJPIp0+9zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sj8twMt9t6RzBd12YLHFdOAyFgyQ75pLYJbfzh4n4SQh1xdePV/ERcmW0FMfZN8qXRlAxZWI/t5Xb48VRDUAa/WHi8gGk9CNUET7ADz3nthI+Z82qp++pqjF2rSAE1OkMpFKP9DezQVfgdzJvAVZ/AYuxTi03PV7DJ51IkB/THA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiZPfam9; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiZPfam9"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbedf433a99so7682a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788196933; x=1788801733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7xAZZtpGxyPOmJ3ommqS1U3mGROgCWZZo46yXfEq5o=;
        b=WiZPfam9bQw0ZppvJRsPeKlAUJfnebcIP+lBjsbwHEijJ7PJnmeR+e4OdyV84GTP4v
         lxgzRTwcfOV9TJfXSU/cnm6D7MrNT45AJ6hJf9Ge3tAwn70vmB/of8KdVjKHDmUv4tDV
         Mizy7ErF7+jW5AKanGxrU4KpRTlDX85f9NkVaaXdlF2UEkOpBFatMDcouJ4zaNfzacmb
         /iQarnpqJ3stgaSfdMlQ/0HpFdB9FKYkiTPoOGAYG1b/7fiX6ev15JMUqUrj2Xh35emx
         QhieqMT52IwfpRMpCqWfbpOrOf13wt/haYzMOak8QBTBYQqNH8tkDJ5l/e+0wQYaabNq
         piKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788196933; x=1788801733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7xAZZtpGxyPOmJ3ommqS1U3mGROgCWZZo46yXfEq5o=;
        b=qfWQWUxj+tBXeb+Ogi0bWUi+gJ4k35c9NSb8tHchrGtZMVD4SGHPCBaJpN220JeWNI
         nTokgZwPqRpqAyBu9lgFx1R2TWdzOO/qujPpAIgvT0PRQOBnk2DzgVb+YqEEVZzGwuiK
         jAvFzXAfbyKKRlF3jfbjkjGHlVzScJvFJfjtj7V2Wu+3YgvjwG3sxaovGXy7B7hhygxE
         fmtl2BVK3Yve/r/Tv2bWy28f9E8CshEMo978MkYAwGdF25rtHzOi+txdzL3cRgE6dwJE
         1JuNOi5EnxkIleowzG1b83Bfh3AZCTySeIx8M7N+A6V4aWVl3Z/NVm4Zg7FnMmHel9MO
         3Q7g==
X-Forwarded-Encrypted: i=1; AHgh+RqG6koFrTRnLdaZ04uGaQkdvy6indlduVkgpxX0ejVY6CgsYQ0wYJIAxz+hmimRYLGnF7nB/wjagAg=@vger.kernel.org
X-Gm-Message-State: AFuF++mvcDw/BBdI9Lyz34RJEJBNtG/rJL5B3XOspHTmkN4qjyhojwp9
	yEEasWgDBw/RbjT/fkEzjTz00u/0KxchhdNZ0D8peIkwxCuQH6K8LdJc
X-Gm-Gg: AR+sD10Hp7woRIMA2deckwi0zeSsc5rb5Tdyr2giLIZwXwx36jU7vOwLFT5bSPl+rBF
	iDsn2Rla/0CqgblNnDn6Z+bih2sEmqrgv4oilDGR+gsB5xxaU6p9HKbAbE6X86MTijiHfUPx3rn
	+einr+FIZUDAXOWFEcc9iUUEFKWHJI5ZFW8jotwf0tsoiO0/R2ihV93Oc8c9i5kqn/Igiz4azZH
	ebIJNlYiGAqKngJ8wK4StdR8GpAtC/u3It9GraJo6Rik5AnAwb6OXl2smGvi49TyJ5q2FzPScLK
	8RfBrrnpZI3xe6LubXN2joFqj73gNvEc8u0dYqd8GIvaCkCWnAKxeqt5Bsx1UUwJybPWYdNMIEA
	X/Zt4n60zYiUc+y9wdExa4s4ADRdlh4RcOJ/ogCCpxit7ZVI7TLtLIzko5a02xhTzlTNqwuJ2hP
	dkXASiOTstYJhSuqZQZbCok97c9DF026RrxkTV/8liaRkpMNL94FYzKAG11gTgRDCwyQakUwBmv
	2w/vR2T4c7mjOCOHaugIYcUQ1Ze3qSvKWNIbg8tb9rwT0N9RO90Fl21fLxIdas=
X-Received: by 2002:a05:6a21:6004:b0:3d1:9166:5c68 with SMTP id adf61e73a8af0-3d265f403d0mr50469041637.8.1788196933425;
        Mon, 31 Aug 2026 10:22:13 -0700 (PDT)
Received: from Mac.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be440sm36241012eec.7.2026.08.31.10.22.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 10:22:12 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [PATCH v8 2/2] i2c: mux: Propagate firmware nodes to channel adapters
Date: Mon, 31 Aug 2026 10:22:07 -0700
Message-ID: <7a4cf4b288afaaa085e1c4ec592fbb0fb43eefd4.1788181174.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788181174.git.ahmadexp@gmail.com>
References: <cover.1788181174.git.ahmadexp@gmail.com>
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
 drivers/i2c/i2c-mux.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 77921e5132bc..dfe54b6d6567 100644
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
 
@@ -264,11 +265,11 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
-static struct device_node *
+static struct fwnode_handle *
 i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
 {
-	struct device_node *dev_node = muxc->dev->of_node;
-	struct device_node *mux_node, *child;
+	struct fwnode_handle *dev_node = dev_fwnode(muxc->dev);
+	struct fwnode_handle *mux_node, *child;
 	u32 reg;
 	int ret;
 
@@ -276,34 +277,34 @@ i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
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
 
@@ -366,11 +367,9 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
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
@@ -414,7 +413,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	return 0;
 
 err_free_priv:
-	of_node_put(priv->adap.dev.of_node);
+	fwnode_handle_put(priv->channel_node);
 	kfree(priv);
 	return ret;
 }
@@ -427,7 +426,6 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 	while (muxc->num_adapters) {
 		struct i2c_adapter *adap = muxc->adapter[--muxc->num_adapters];
 		struct i2c_mux_priv *priv = adap->algo_data;
-		struct device_node *np = adap->dev.of_node;
 
 		muxc->adapter[muxc->num_adapters] = NULL;
 
@@ -437,7 +435,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 
 		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 		i2c_del_adapter(adap);
-		of_node_put(np);
+		fwnode_handle_put(priv->channel_node);
 		kfree(priv);
 	}
 }
-- 
2.50.1 (Apple Git-155)

