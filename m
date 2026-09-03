Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0684F4736
	for <linux-i2c@vger.kernel.org>; Thu,  3 Sep 2026 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464540; cv=none; b=OpjqaRrLwI7iflKWytJoGS7rfnPu3UdC1gMYpIBOa5FvANhYZ6ZnyLuSnMwwNvYsCzy0lnVdaR91YEkdFq6DyYAXBmtxD8RSGpHP/AP8tQcYrq6Z2FtjfuekAN7wODuuejXgbuagsSO2IMdt4o7y9Ar+Q643k8G5Kr0osvUT4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464540; c=relaxed/simple;
	bh=ZNs/pcmbcxUI5DPLKL73eEDoTCcdGLiiCICCOeiADuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuJb965vBUKRGXR7eHHJrfTbdw3/XwI8JNPO6uxx0B3KvAsjdgwOGWxxknd4sbkKxxz7q6zCXs8SX9IfJC3y/yYhw4tfKo8y9ncw69c3MX2DHV5qqz/PLPWLwFkmz+ueXM3KKfVCTKkpNibJCiawqWp13njoKNbVpN4nUFBDfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzuB9Qnx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzuB9Qnx"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso482882a12.3
        for <linux-i2c@vger.kernel.org>; Thu, 03 Sep 2026 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788464526; x=1789069326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMLGnnXjyoLsWgMjvdIiY7tKz+XpPvMHXGXJiL7xF/Y=;
        b=rzuB9QnxB9b2nQX8VlLFkBEs27X6z/RO8HL35Vx5HL8qeSR78iB2W7xWN0KzIQwYKD
         CpXWpu3+5NBGReF6lZs/5PIp87f/3ztK1zHVcy1ffYYnw+ZD+MSRWCwUciSLiNA1GGYh
         bghSUTUoBhTBWVO25AiPRAku1wStOeY4wUl3aN8UsRJ6/AGAJQDJGdwMf14nF6OziwqU
         /lQppo1COe+ML+ZA+spyAuR61GtPBg8QGGr3uTD828f3DnJ9wMWu/j2XgTSagggsBLxJ
         H/2EIZFN3WAw6GX15bV8zWCq/OJUmNEja7mOXCJdd5ZI5E2+JWgMG0NPySnCnA8NObA2
         sr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464526; x=1789069326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fMLGnnXjyoLsWgMjvdIiY7tKz+XpPvMHXGXJiL7xF/Y=;
        b=hzzv/71sUm/avM6epNCd6hfYzT0Tg72ZRWRGI1mdVaSGnxbyGx4CfaN/fCGIX29vjn
         lOYxtRLQfdoBwhQ7WgLOBdhJ272iQ28wHKUyjjX1cErTP/x/vTWPS0Z8eX+4/J0t8jWR
         gzSmLUGTTn/W66QRiklu2OW28+CopWjV/wtUoznQYOCPw/dVpv/9eXaDC6D3NsKW631J
         tlZ8cY1cQF2JVzbxUD1kPRmnG1dLsSsIrAUEGDfy3nzQ0Ulzbb8EiX02AemMWIaXPp3C
         Hn9qrjeIfTglawIWxp/BAlvvX87DzcPzDrnEETO3E5ea9soU+2KaOUvnxUYPxD9/4mZE
         cJVA==
X-Forwarded-Encrypted: i=1; AKwUvBzhnw7YmT17CBuVhfxi85HXdtss4mQNcBBizx/xfPBLrXQyiPFlCwMcJERhjrH4bgjFwCKyvuzLVko=@vger.kernel.org
X-Gm-Message-State: AFuF++laVtimGizKTOQCukfqspygL7kx+V4P/AB39yGPZDLOuSusrUMk
	3bM3hkVx18jCk8e1hjnLWDBDBDuiamN5Ene4relLFD8GfrO1G3eIgf75
X-Gm-Gg: AYBFou0KhG9pCDGpW6XY2UXwoxx6itUCWvtZ8pYk+1F0t/7tcHVjnEfmkTJ3bVl3c/B
	e+gQqstWYf+jMLX1jE+xw4hyOc2aYdtwCd3PJ5Xnl1kpKEG+/uHsqk9n2su6skLZDNsFUok9xz4
	v6kJDc3z2IfFlDjiSLBe+RN7Ck9YNU3wS6zC27uqNghk5zjx56GPDT04gCvvXUQXuETEo7aqrEd
	x38daFlIicCwb8dXt/qOPAs7KyCZ7nj58nwRw3KCMHE+vXMBAiSVfKJ1sNDf2KTkc4P0hlVvPfp
	GALTHwanOvXW4Eke/hzQrcGWcUGDVthHyukL+Jm75qKBykff50wkB3b0qcsnVjvsurKAFrHce2O
	oZzc17AInQFMGXQed7cTXB8GygLIIzrJrfcyYv5cAegVa6w3jWw24JH+g/+tOKpbSByz3/ciCr7
	zFEfYe2fKHg9qdC3VnzPewpXCB41tyJ3IGQml7ptEnxWW/5JGFvGVOV8IipLxqmLMngsYAsStLr
	gF9xJj27c+oNZE60iB8aEvs6WjlZAbi7DHs5IjWtjWKdd2jW3EFSVyxZA8SiodKAv3lYyjH6D2D
X-Received: by 2002:a17:90a:dfd0:b0:396:61f1:da5c with SMTP id 98e67ed59e1d1-39b260de667mr1265263a91.4.1788464526475;
        Thu, 03 Sep 2026 12:42:06 -0700 (PDT)
Received: from mac.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432441f5f2sm1389184c88.15.2026.09.03.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:42:05 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [PATCH v9 1/2] i2c: mux: Factor out channel node lookup
Date: Thu,  3 Sep 2026 12:40:55 -0700
Message-ID: <89780f7db207c7fe7adbd45e1f38f0a041794c8f.1788298883.git.ahmadexp@gmail.com>
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

Move the existing Device Tree channel-node lookup into a helper in
preparation for using generic firmware-node operations.

This is a pure refactoring with no functional change.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/i2c-mux.c | 83 +++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 68a4c34b5987..37529c7627a6 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -264,6 +264,50 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
+static struct device_node *
+i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
+{
+	struct device_node *dev_node;
+	struct device_node *mux_node, *child;
+	u32 reg;
+	int ret;
+
+	dev_node = dev_of_node(muxc->dev);
+	if (!dev_node)
+		return NULL;
+
+	if (muxc->arbitrator)
+		mux_node = of_get_child_by_name(dev_node, "i2c-arb");
+	else if (muxc->gate)
+		mux_node = of_get_child_by_name(dev_node, "i2c-gate");
+	else
+		mux_node = of_get_child_by_name(dev_node, "i2c-mux");
+
+	if (mux_node) {
+		/* A "reg" property indicates an old-style DT entry */
+		if (!of_property_read_u32(mux_node, "reg", &reg)) {
+			of_node_put(mux_node);
+			mux_node = NULL;
+		}
+	}
+
+	if (!mux_node)
+		mux_node = of_node_get(dev_node);
+	else if (muxc->arbitrator || muxc->gate)
+		return mux_node;
+
+	for_each_child_of_node(mux_node, child) {
+		ret = of_property_read_u32(child, "reg", &reg);
+		if (ret)
+			continue;
+		if (chan_id == reg)
+			break;
+	}
+
+	of_node_put(mux_node);
+	return child;
+}
+
 int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 			u32 force_nr, u32 chan_id)
 {
@@ -327,44 +371,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	 * Try to populate the mux adapter's of_node, expands to
 	 * nothing if !CONFIG_OF.
 	 */
-	if (muxc->dev->of_node) {
-		struct device_node *dev_node = muxc->dev->of_node;
-		struct device_node *mux_node, *child = NULL;
-		u32 reg;
-
-		if (muxc->arbitrator)
-			mux_node = of_get_child_by_name(dev_node, "i2c-arb");
-		else if (muxc->gate)
-			mux_node = of_get_child_by_name(dev_node, "i2c-gate");
-		else
-			mux_node = of_get_child_by_name(dev_node, "i2c-mux");
-
-		if (mux_node) {
-			/* A "reg" property indicates an old-style DT entry */
-			if (!of_property_read_u32(mux_node, "reg", &reg)) {
-				of_node_put(mux_node);
-				mux_node = NULL;
-			}
-		}
-
-		if (!mux_node)
-			mux_node = of_node_get(dev_node);
-		else if (muxc->arbitrator || muxc->gate)
-			child = of_node_get(mux_node);
-
-		if (!child) {
-			for_each_child_of_node(mux_node, child) {
-				ret = of_property_read_u32(child, "reg", &reg);
-				if (ret)
-					continue;
-				if (chan_id == reg)
-					break;
-			}
-		}
-
-		priv->adap.dev.of_node = child;
-		of_node_put(mux_node);
-	}
+	priv->adap.dev.of_node = i2c_mux_get_channel_node(muxc, chan_id);
 
 	/*
 	 * Associate the mux channel with an ACPI node.
-- 
2.50.1 (Apple Git-155)


