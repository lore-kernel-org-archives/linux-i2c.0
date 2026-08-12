Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89544780B
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544252; cv=none; b=LjxSEAYqAXIa4P1lmXsPqx6zONMB4oYRl/XOI91WwaPqDwwRCQX8tCErgFzp4/kdVoRv4Kr1j5El1QhToJvEP9XjBcLF4Eb/6gNnaFsVoCWTp388NQp9wG5ZXVNIU8iQKTuRRmZFS0go5QAjR2UtJ+2P8cuFo66TopKzicoab2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544252; c=relaxed/simple;
	bh=TMJAnG8b4psorsvMOOOR3YdZzaqaqHlSJnvqJmht61Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPkMbxKaxN085X/5oU3KUAqNtJM53rWUkAHDt3Uz7/WV8560UbaW9gSREbb/BehiW2eUxV3lIFLgLkUH5JodlZ3ojCbtrS3F3Jct21OC96M3DLXBNK7fecnEGlAbm8lAZiDuXc+STjJX4kdLGBcsQpf7rMCLLGqZvNhApH+yt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSN8aq1O; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSN8aq1O"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca88130e09aso627369a12.3
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786544248; x=1787149048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CiwN7fMyor0aHM1D7i8wQ5RI5PPro03COVrr2/AFUGU=;
        b=rSN8aq1OBO3CaDMuvy9LtomCaSAd5F5oiH3VqSFaySpywPPzx+IlEwaWaE0W6VAS/V
         nCprzmgvpmoF2X5PT7d2qqT/7yfLYG9kqSzhD47mQyYXOzLbXXFQMvOG0egone3L4+FN
         7DzO1oERXDl/pQaHMcsGyDIaH61U5I/Tawqa+hLtx3QGD2fQLS8cI4ux6nqUMw6/nIDI
         J5r3BA1h+8RpjVpNebPVipkZ13BrJDy70UJdxWprcpB87QdzkBM52aw+aUDlRC1VCafI
         zh8JB4fqpWPNCfwDpnu+Q8u0tmx9kC+VARo3mQAUQY3JKYr9vgjqWw5JVAtGHeE9nHBI
         FXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786544248; x=1787149048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CiwN7fMyor0aHM1D7i8wQ5RI5PPro03COVrr2/AFUGU=;
        b=QMf82XVGfgV4Ahig925bY5y3Qbz7V1OvIzYUPRLrJiECWymkNd72VWghJFdPaX95Iw
         R8y49frY8dBDuzSWYV3mbDRPIL7Xh4I3d+CMP9ylZr0o50o8Yak9mPKwxErgLDkN2IOc
         SncitgBlvjMOJYwXrfQspCRNJLhh9UlFPrTDjZWkZ80Y1/Z7wC7575rmHXO7OHte74YZ
         810FTdue7PiGfnIqKCV49UGOGf//lMGZQ3AYKbtroVGY+y9Mv9N6zmFX4pfTcqt4tgeW
         HpWqsdjCP4a+B1VmqT5gGZ20xI9/klw7eegSHWWmqzB1gfPh6IVdFnVq0JZseF+ipKal
         UEnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkXk3/DDgur4rl9GTScmxjSGGMcy8QXxvnE1juFC7+MeeHcvNBM4j5qawAE+5x8Su9whcvHttfjw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxutVMeC3c33BRoU9aK6hmJhjXd0dYx7Yc7nXMMbP7Rr8vuC5WG
	kQ7Wogyu55XJExq3JQN83l9AWtJeMrL5HIntYYp4ioZzrYl1R5CwrWtS
X-Gm-Gg: AR+sD11iKEzkOw4IQpwKlP+vV3Y0kCGz6EeH/e+Xu2Oi7p2aQhL8oEzHrviqq3GecjA
	8yl4sBDxqhETLh3ETiqGm7qL0RajcFlNBtFrbH+t/6xQuaa4whABNUK/qTIqIqxJHesyq0z8HTt
	Ave1Q7qwbKpOmPowAFQIkpMb0rIYj/UxQTCjiZTFszkvkNTwOSUWkHfBCcKOqwLAgFFvLsc1OZZ
	TVjF0SJR0Tkz0jXmQIOAfnm2z5r7g/K81G4KzCJRhnbALzV7qq5pVAojpDJ8l5N6y85vlrOz6vP
	uZLBWR2mhMmWu2vg+PefUJV7UEEt6FEXEzOkFR/EbXEcFIWoHH5E1q/6uhPBnZrCxqoFRufrN6i
	ofL//7e1z3j6bnbLtYfhwT6oAM7HTR4KNv8S749x7gjIq0CPjj/eyk6A1EtAqVrZUZu4qDOp3zW
	a7BU11XSrKpmXMJfhDWhQI3BP0WKXOLiQvcb+RMFJQw1ylIX24IBPYomIGMUme02BDnMKfQatD7
	8r5bArLlcd/kJZKihNQq4dUzZ9tA+OIdFGEtDsuXeTf+uHvYg==
X-Received: by 2002:a05:6a20:2587:b0:3c3:c3fb:2473 with SMTP id adf61e73a8af0-3cc3f731173mr5685375637.20.1786544247452;
        Wed, 12 Aug 2026 07:17:27 -0700 (PDT)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf361d57asm11963071eec.6.2026.08.12.07.17.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 07:17:25 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nam Tran <trannamatk@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v4 3/5] i2c: mux: Propagate software nodes to channel adapters
Date: Wed, 12 Aug 2026 07:17:13 -0700
Message-ID: <e962f3ba58a44cbec8e1f0cfae321d5c8d99d8b6.1786543681.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1786543681.git.ahmadexp@gmail.com>
References: <cover.1786543681.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device Tree channel nodes are associated with the adapters created by
i2c-mux, but equivalent software-node descriptions are not.

Find the software-node child whose reg value matches the channel and
assign it to the new adapter. Keep a reference for the adapter lifetime
so downstream clients can find the channel by firmware node.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/i2c-mux.c | 71 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c239b..040284236275 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -20,11 +20,13 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -33,6 +35,7 @@ struct i2c_mux_priv {
 	struct i2c_adapter adap;
 	struct i2c_algorithm algo;
 	struct i2c_mux_core *muxc;
+	struct fwnode_handle *swnode;
 	u32 chan_id;
 };
 
@@ -264,10 +267,60 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
+static struct fwnode_handle *
+i2c_mux_get_channel_swnode(struct i2c_mux_core *muxc, u32 chan_id)
+{
+	struct fwnode_handle *dev_node = dev_fwnode(muxc->dev);
+	struct fwnode_handle *mux_node, *child = NULL;
+	u32 reg;
+
+	/* A software node supplementing ACPI is the secondary fwnode. */
+	if (!is_software_node(dev_node)) {
+		if (IS_ERR_OR_NULL(dev_node))
+			return NULL;
+		dev_node = dev_node->secondary;
+	}
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
 	struct i2c_adapter *parent = muxc->parent;
+	struct fwnode_handle *channel_node = NULL;
 	struct i2c_mux_priv *priv;
 	char symlink_name[20];
 	int ret;
@@ -324,8 +377,8 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 		priv->adap.lock_ops = &i2c_parent_lock_ops;
 
 	/*
-	 * Try to populate the mux adapter's of_node, expands to
-	 * nothing if !CONFIG_OF.
+	 * Associate the mux adapter with its DT or software-node channel.
+	 * DT support expands to nothing if !CONFIG_OF.
 	 */
 	if (muxc->dev->of_node) {
 		struct device_node *dev_node = muxc->dev->of_node;
@@ -364,6 +417,8 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 
 		priv->adap.dev.of_node = child;
 		of_node_put(mux_node);
+	} else {
+		channel_node = i2c_mux_get_channel_swnode(muxc, chan_id);
 	}
 
 	/*
@@ -374,6 +429,16 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 				      ACPI_COMPANION(muxc->dev),
 				      chan_id);
 
+	if (channel_node) {
+		ret = device_add_software_node(&priv->adap.dev,
+					       to_software_node(channel_node));
+		if (!ret)
+			priv->swnode = channel_node;
+		fwnode_handle_put(channel_node);
+		if (ret)
+			goto err_free_priv;
+	}
+
 	if (force_nr) {
 		priv->adap.nr = force_nr;
 		ret = i2c_add_numbered_adapter(&priv->adap);
@@ -408,6 +473,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	return 0;
 
 err_free_priv:
+	device_remove_software_node(&priv->adap.dev);
 	kfree(priv);
 	return ret;
 }
@@ -430,6 +496,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 
 		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 		i2c_del_adapter(adap);
+		fwnode_handle_put(priv->swnode);
 		of_node_put(np);
 		kfree(priv);
 	}
-- 
2.50.1 (Apple Git-155)

