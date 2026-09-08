Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842F381B05
	for <linux-i2c@vger.kernel.org>; Tue,  8 Sep 2026 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848789; cv=none; b=XFBh8CdIS6VMhkJNTfWPnnwdBbCPP5m0f8J3TxmBLZRL54QxiqIc7iVx7ypOa4fqSYA1MgyrhVPJMXN2nc74WY2Ff4HtNRPKH8ptb8Ijz5XikXib8K2aO3tMc6ijNnU5woKvr8YyfOUnCYJN0IRppR0rO4Scd9Ie7/sUq7rfql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848789; c=relaxed/simple;
	bh=k/Ku8LU6ugqloGgzvXwvaI4XL7y3mzzbLgYVblGmuGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3lzpdfOVy4BLO9WRDNMJhBkJcJKWjK6Cpm+UQYzkQnutLFvCnezwXJUGvv88CwGaxaRy/R/VKwRaHOvvLeqFofahFEFBbY/1YXzW8oK3AMOhow/7A2WOocGcHPDjHuQMD982rca7EAcqmb48XFL14g+GNMOaqHjCec2fpcUBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeUX4eZX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeUX4eZX"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so3262999a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 23:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788848787; x=1789453587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H+8mig4WNfJCkEjs7JPdgjRjkIJBtDmluQCyK6Ikj9E=;
        b=PeUX4eZXuUqvx7vgB8W54a9Ki94Ckp5L+iLZJZ4+uOI70QHfKX997CU2SXEDRvwWkq
         YdEn2fP2mkR//rxVUwMghVxVcNUYBJ0cvLe2aRCHrEHaWbC7fMypLkIJ96w+HxeAw2ne
         hzBvQVaHSTm/7+aT7tMgKMWhGhOzVHIpsb8tupnm9Uh8GmDccarQLA82AcKH+fOylrxx
         ccbWGfMhW//m8JXJAdihrwk509XDO3djEMrjRW6VCzmk7AtCud5fHZggAyYWsiTkAAuI
         7HyzqWuud8v5+P8q/ruJx+AZwTK+JVaS5FhSz4AePg2RMd/G0624pvKG3zoFpaX+uDZA
         q3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848787; x=1789453587;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H+8mig4WNfJCkEjs7JPdgjRjkIJBtDmluQCyK6Ikj9E=;
        b=kp612BXD1nv13CJcktGREWo+iqSIHanub19vXP/6AkbYbwPwDvFs4aw0STmM1SnZt5
         hgUSDWM+X6SCjeFmyJ4S0xEkNQlKC+sRioBlq+0GAa87vYwO47eBnGF/HQvBQTz+jr2P
         tjHofROlqUBr4xlTF+l9P75MwZsgzVEdlyHxUWKaXKTkvCxndciS1D5OWPfQUIDzr6B/
         /2SHf5oo+jdaoOk15AbYoFcs8FM8810HwC/7TLxWHgUMdajnt/58AiHiUk6oBavn97If
         H55NiKigPZAOYm8Kc2aLw6lgxn3womIDVbQUe92NUTwUfwgY1TGrgvqEzw407e41l69g
         vayQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlOp6nZVw+Kwl4zkfbUmzocSVm2ayGT9lweoMxz/kI/wYfnMd35zonZvT4wuTquemuBn02hg9wHfA=@vger.kernel.org
X-Gm-Message-State: AFuF++mRy0CZS+4rXdwVHlZNZliK7wHYUVeWLR6OWY6Y1dzv1VuG3rmF
	guKUSsz1TfyjN746UD2Qri2MTQpHA530KrpSGRPBWfa1tf/R9lqGk9w0
X-Gm-Gg: AYBFou1M6tvNS6XbCw6tA79RF6P2mhXxlDUE51OBwuZozP9v3XzxgdCDOPpB7ju85EG
	iPtP+6Bfy5RqGGze3AG/ZNE7VFIcDaRvCScV2FF6+CPMsIkMlAWyO5MG4FeGtNvrrGue8EymvJM
	N71KMlUrTkH/YUy5opazgDIVFABzzMs7J3AELcL/xVxMOb5khnlvun+aPJjAh+U9FjnD2bLe0j4
	GHw5ZCXBMfDUQTzI+u5uqs/EfXgsgyDQeGNQShpr+KqBGjGQakFjybYdgazGi8SlKSrfbprlax3
	rWDNA42aH9u+Ji/FxvcWxbi/yxwdsulEGVx3DczfzMYrUvYw1GfryeJoGUdPipg0yk9O4OLLIi5
	dcOieP+2veVigqRedHl8Q3oyNQWJ/UBVT8JpKhU0rpHwU1vGP6ScP7IEF8NjINsSYCeXIcU5JGt
	ceBUu14vITyUSYDEjTkVM+9Uz8NO78jxRMKe37X36aObWJXOh998SAE0p47mq8j0fUIkmyOqpVg
	9AfT6UeQ0tvVjRGq/aAgeyjQrF8B+2x1DbJbLmoVqwvQ1LX7wi7PyWEIU5ivCWeCE+mwdsqUKbj
	83SC6/Bz5vQicl9AJy5t9VOyPsjqaQpfuBXHn506DQ==
X-Received: by 2002:a05:6a21:a05:b0:3cc:9620:5816 with SMTP id adf61e73a8af0-3da39cf20c8mr43080673637.8.1788848787479;
        Mon, 07 Sep 2026 23:26:27 -0700 (PDT)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm30960386c88.11.2026.09.07.23.26.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 23:26:26 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/2] i2c: mux: Factor out channel node lookup
Date: Mon,  7 Sep 2026 23:26:22 -0700
Message-ID: <adf12f66229d5faa0bc75571da1c3f53a1c81dd8.1788623619.git.ahmadexp@gmail.com>
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

Move the existing Device Tree channel-node lookup into a helper in
preparation for using generic firmware-node operations.

This is a pure refactoring with no functional change.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/i2c-mux.c | 84 +++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 68a4c34b5987..d207f0e81807 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -264,6 +264,51 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
+static struct device_node *
+i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
+{
+	struct device_node *dev_node;
+	struct device_node *mux_node;
+	struct device_node *child;
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
@@ -327,44 +372,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
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
