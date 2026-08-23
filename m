Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9413126C0
	for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787502885; cv=none; b=qbhEMxzr37IOj/nGp2ZQKT6xjwpJ7p04JDMWk/XFjf67kWpdI66O7nbSCv7J3BhdBRfByxMCcP2sYq0JLwewvZxDe7C1fD57gujgUGn5rZuXDy5DJpMf4AHAZxCWaw273vIsVooDObzxniRRc1ofNBlPvlZQSlQjdn21CMZOMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787502885; c=relaxed/simple;
	bh=EJfCCTqbNqMzi71//u8ytAzKCePxjJyYif64TVPjsjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhLPeZ1WSyIvIsbOxRGTnoMrAassoLZgnrqyVyY3mgPs9hZRvd2dUHbJI3J0yUWcpDydemDLsgFnkOeANNKFSlAoJrVpx3V6l739gu+KYyJvqqIqDC50l2Q995NIU6A1tcCV21MHoDCu1s/ntDpEySFbcCKc+XA8bh1r+afriDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljlU2ird; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljlU2ird"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84874b52eabso3546718b3a.0
        for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787502883; x=1788107683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TSuRlPLvqVhvoFr/a6EcJQdMGwGvdr0Nq8RIhTw4Mzs=;
        b=ljlU2irdobs7Z9q9OYTc3DUhrumb+MjXY+9SO/sQbsCM/piWuUKPVNwAEyOE8HP0GR
         9jAS5997RxBS7ORxKTmFOHTvrMT0Fb4CRheGAX3UEWGT4cNmuMHXaTTvzFrB7cKh6M6E
         +CG1sVuLePjDCnswVNTmCzoIBvyjjWU8IEY6Y/rpiX9vG2r28fg1Vu61gQCR8J++aBmC
         IubKcvSPfmMzJ786b7aPuAdyjhuaQ4L0+fs+3Hznu00YPmNXcGxRfTf+RCF9QsaqdiVN
         gWuoDzmSZqgjMPsRPotmtFDUFzRJOl/x4HlQnmAwhyzl1tg29tdxxTUQTLP/+0TyqWxG
         O9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787502883; x=1788107683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TSuRlPLvqVhvoFr/a6EcJQdMGwGvdr0Nq8RIhTw4Mzs=;
        b=OsZVJRhHr59+QOkUKmTh+0hqPtnnVhfJgipdYc3U19ondePc/jPPZnWj1KQQhREJSn
         tyuI9eui1eB0ZKd/S75VeQrHjFH5cbNToaxZg8Tn7RT/6D6hG2naAehrWKDxtX1bJziS
         OZUqDAjSzbi8v/RTF7/auT/STInA3CYRN76nMljxl3Mk8VuzKYtltP4/2OeMB/KXvaGM
         MTwXLAHb6TLsViWezoQtWJjVWJ1kAYQhNmihh9gddjP5RCURopbLVB2KlOOPswJw/O2I
         7k5R0EzEwWXbCVAXRT5TflUOLLa2qTY9XtqVJWEiUJ4FzDgq2TN+2GY+Qu6B8JaKwj50
         Uy9g==
X-Forwarded-Encrypted: i=1; AHgh+RpStZTG02BYYrND22571fWjXFOC7SYVoiLjaqxrEKgu6v0JWQHgKZBTgcYatj1lUWKNB0EFQDoFLRg=@vger.kernel.org
X-Gm-Message-State: AFuF++k/t1UOV7+e490jsDgxfuur391BIFKVrDY9XvxTDOnVB71v5++W
	GM8JiheYa5xXPdsiLR/YnngeunAqEBqvvFPp7e2JFBfTAIf+PZF93gu0
X-Gm-Gg: AR+sD116HLxrc+hKbHNn5ndyVXMoxJ6A/f/VY2n9v4R7KnM6g6jX5i1YXo7xBA0EOyz
	0r6W9wRAUmeq13XFvgDXkB+lUD4yUR+pUxKjMb0gT7O2deLmjZGKVBLG/TpzWntOesx/w1JkJtU
	AP+HCjpBZU+5oPdgY/FPFSOlylWlFgPIOO2hVN8Z7igWpTvXMLjgDhTHZ3HRkFTTEtiogEtSioK
	oQ6PCiO5cyJBLfkUg57Mu3OOS2aN2BDQ4NKetJfkdXMqXTQsU0ksFuxrecdIU40Fhybzig6bo48
	sb44+vnq+HNXtHxkJXZGi/grSCXBuhWJtoxaGKP7etAi14SH6525hVTT5HAHlwN19TtKxdjJi1U
	KdhfeXMvqUAhDKfekPEZVosS4RYAo2zw0i/Sr5c+YFOreXrX5D2XDa1VKx2k9B8j09S07d8AVJj
	IuuETgxaPaY3EC3bs9BKbtaHhCe/hdbfWYLn6MpuCdYJ4Oc63/YxvMTl7c7C7pDcdnX/EyeHdIU
	z8NUWifEuDrFv5FOJTgWZ99KhpXtux/Ox/hYQ2rc4KC+wptOTEg+WSnVpc0fQjUDKZKfKDPLlff
	/F3tUcFFTPRxlQ7ql4bsyUouE8HGjVU=
X-Received: by 2002:a05:6a20:ac43:b0:3c3:935a:af2c with SMTP id adf61e73a8af0-3cd2fd03751mr41714282637.3.1787502882736;
        Sun, 23 Aug 2026 09:34:42 -0700 (PDT)
Received: from Mac.net (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860ef75esm17084319c88.7.2026.08.23.09.34.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 09:34:42 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [PATCH v7 2/3] i2c: mux: Factor out channel node lookup
Date: Sun, 23 Aug 2026 09:34:37 -0700
Message-ID: <ab51db7f1d0ca80b0aab631c3215594b6fa33e33.1787502619.git.ahmadexp@gmail.com>
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

Move the existing Device Tree channel-node lookup into a helper in
preparation for using generic firmware-node operations.

This is a pure refactoring with no functional change.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/i2c-mux.c | 84 +++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 68a4c34b5987..a8b94b97a725 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -264,6 +264,51 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
+static struct device_node *
+i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
+{
+	struct device_node *dev_node = muxc->dev->of_node;
+	struct device_node *mux_node, *child = NULL;
+	u32 reg;
+	int ret;
+
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
+		child = of_node_get(mux_node);
+
+	if (!child) {
+		for_each_child_of_node(mux_node, child) {
+			ret = of_property_read_u32(child, "reg", &reg);
+			if (ret)
+				continue;
+			if (chan_id == reg)
+				break;
+		}
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

