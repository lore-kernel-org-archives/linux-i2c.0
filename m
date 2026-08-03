Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8E4334A2
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790231; cv=none; b=UiS8mcZipqAkAgtkP130LAP274DkBYeo3dtedv/+KIO1a3J6dwppQVAxp0AcEl0VcUai+OaIo5Zwz/12PqQ4tfJB5AAeYlNDusp4JvX4Kwspf5p1MvBxU2VpSWpmO9AGRECsHA2t06YlucySvrNvRB64slDNwiQSYmnPdMyB9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790231; c=relaxed/simple;
	bh=Mv2fB5QTMgzygfKi4oX9eQwPWNNkjLy2vCUnRHb4K0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDZd1in1tb2ERrqQTdLeoXk0GHUebZ75ev6vnPVWjBfsqjx3vGLcQehxyCvRDxCz531yAm7yWi0uyEecNEPY/bihH/a4ZoeVWHyZe47F1dPU5GC7NS9Cz+HevREgM4coiXi1DEEUtpjI9uxqhnsy/u1O1WhyOCKaKho46sq63XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5/NJ34K; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5/NJ34K"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso2899498a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785790230; x=1786395030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jXjf3n6y2o2sUp9ziyNWD3SU5x1Q1/QeHjG5pG2QUDY=;
        b=R5/NJ34KbgbSSSwP/mL7/dZ/mxx+64Oj39jF8LRMthrCM21JJAEe9emil60hag8QPu
         nVAiKqVQ5JkM893S+WpcxRS8TZpKxim9FquWzc9SyaIB8Ijh3lXCr4+vDyq5CerCcgrw
         LZg75+PfFwImIuT/JAOZMFSdKyMb1rhviawBF7V73lMvl2JUbcNchdVxqde8bhe1tbj5
         rrxbhvvh1dTpyHdVhQoC6rY6jHOmNsDuR14gQXJqsZVfEK4Oly3LWWQz68rIgapkToDf
         vfDnp5I4EsbeeViocd1l3xMKGjNGzs4YBBUPH/xeeWOd6tLHBhih0ZjLxtZaiDDd+FLk
         C2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785790230; x=1786395030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jXjf3n6y2o2sUp9ziyNWD3SU5x1Q1/QeHjG5pG2QUDY=;
        b=HkQFzErPEkETA3aMRo7q5/tYoGsPxhPD7XC731sD3g/L5/RoXk/b5m/p3BwLeieKp4
         0wlL1R6LzOQfzABxpJymUIEX/8TKQ5C1cvp8ob1N/DUi5vRWIe+S2JpTD6CuK0Wyxe9F
         QkoPnk/M/h4zHl7jmY4bW/UqjRSIBCOCUTLaogufctl3i0Y3O7J8TQdA8LthRvV0TPuJ
         V7hogw3tL2LiUY3KXZQl+dpZZYP/JVFuY+SkNCyFN+RRd9dcqDd3Rr7dyDoHBDxhfHFK
         FVfSmBvUZY7P5WlKQ3b3Rx1D7WkucBlZMTFFRKi3hgcW4Q3qySbV5HK93EJABEShpQFU
         Qa4g==
X-Forwarded-Encrypted: i=1; AHgh+Rr59yjP1oo+0p1btcsOMKx6TvepXZxmgLVosq80gMI749dzGkIHEcfEwGt20/Zh7Ba2TisfsT9X1E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/qvtsfDNmDr+Zm/6zC0TsvhQGc8blK8QzKbYBEVjaAK/Aq21
	7WPi8S9Dzq3cO1JjGHkseNbH0RDeynb8QStH5EX2tLMXvpll2JSTAiTR
X-Gm-Gg: AR+sD123+JtHjf1wT0+bizRJYOWa9TZaSIkCAmAYcHNetXIYH888aluXAbINPl7715w
	d6cJFp4r7CCj0AYdtz11E1DkKgGqoYRWST3XvWf3n2WbWfHrNmhPlRSAwGuo0toSOdS0P3nn/qa
	N+5OlHG4Af2ugvp9zh+UMyK5mgs+IkoCTTdWjxKpjNrgfS1go6gP9ZmUvl4Viej+aSnF5b94u7C
	wfswJsljFhPJIwgARpCFXALpejNqRSM1wR9NVSD+EcE7BPCmdq0a/dPF7RjOwBhRztNhQgGMQgt
	rtlgg5OJZOibBMMu8hF5zxZogdKp0dr6tkv/XzvsFre5li2nAxsAjIOTKa5MfDmiMWmPRyx7mG9
	2tfRpCGegFPCLhfDuFbsyZRvewq/OeNuhyz+B8idJh1dlQCZtV4o1Fywf+/3B3V2rH1dcj31AI1
	I+cioWoFVDLEDlQelRZswRSRQVQk9CZZUiNF4AtSXDELT3CPiWzBm1tjoIWlmvu/v04rTix3l03
	9cp9A==
X-Received: by 2002:a17:90b:53c7:b0:38d:a150:ee04 with SMTP id 98e67ed59e1d1-38fbc4ef153mr9786906a91.30.1785790229767;
        Mon, 03 Aug 2026 13:50:29 -0700 (PDT)
Received: from Mac.net ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm33112324c88.11.2026.08.03.13.50.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 13:50:28 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Nam Tran <trannamatk@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 3/6] i2c: mux: Propagate software nodes to channel adapters
Date: Mon,  3 Aug 2026 13:50:08 -0700
Message-ID: <20260803205011.1249-4-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260803205011.1249-1-ahmadexp@gmail.com>
References: <20260803205011.1249-1-ahmadexp@gmail.com>
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
 drivers/i2c/i2c-mux.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c2..1e587ea4e 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -264,6 +265,49 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
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
@@ -364,6 +408,12 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 
 		priv->adap.dev.of_node = child;
 		of_node_put(mux_node);
+	} else {
+		struct fwnode_handle *fwnode;
+
+		fwnode = i2c_mux_get_channel_swnode(muxc, chan_id);
+		if (fwnode)
+			device_set_node(&priv->adap.dev, fwnode);
 	}
 
 	/*
@@ -408,6 +458,8 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	return 0;
 
 err_free_priv:
+	if (is_software_node(dev_fwnode(&priv->adap.dev)))
+		fwnode_handle_put(dev_fwnode(&priv->adap.dev));
 	kfree(priv);
 	return ret;
 }
@@ -420,6 +472,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 	while (muxc->num_adapters) {
 		struct i2c_adapter *adap = muxc->adapter[--muxc->num_adapters];
 		struct i2c_mux_priv *priv = adap->algo_data;
+		struct fwnode_handle *fwnode = dev_fwnode(&adap->dev);
 		struct device_node *np = adap->dev.of_node;
 
 		muxc->adapter[muxc->num_adapters] = NULL;
@@ -430,6 +483,8 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 
 		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 		i2c_del_adapter(adap);
+		if (is_software_node(fwnode))
+			fwnode_handle_put(fwnode);
 		of_node_put(np);
 		kfree(priv);
 	}
-- 
2.50.1 (Apple Git-155)

