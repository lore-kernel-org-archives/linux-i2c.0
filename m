Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC346EF61
	for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196933; cv=none; b=AMH24jQuASCXTIl2K5bFnxvD5C59oNcSRmHd9+fErkeyhuk0P3y3/lb/I5iaIgzPmQB3kKIgy8KtoJPUCftt1LZEoYKvoUeXLphjkC0AF36BPw9y5TrZgQJBhLPLB2rY4JrMeLo2YOj4B7QMl+TO/pi+QE4sffDzvAGR6Lhoxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196933; c=relaxed/simple;
	bh=kaQB+lrsH3P0HaaHF8RgU6g1gH74yTxaoYHjdcZUp/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GriCL60EJS+2WNMwQr0Yq3uBhSc2dYEGVB71WOCJHICVQgztzMKcTbuGm6xxbe8+M00uYITSm4B1YtObA0EM6aiGNjlqZ1tfEuQloTu6Qh7ZVn992lkP2njW9LeykxFRuRDkgnjqf3OtrQ4DTp0yMvwWF2VPstcV2URxd/vyvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5qMW3Hh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5qMW3Hh"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1794a91.3
        for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788196932; x=1788801732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BTWco8T03rFwAd35tBKC8oxqSaTdfmTFdjb2cniG45I=;
        b=R5qMW3HhU1ismGWFP/ET+Cp4eEjgqlf99tLQ2RITbvjpPNHq1A+ba+xuS78Z5efcii
         53pxKENaMKDiOOS6Ejcenu0u54qOc2TFyRM8zr691gUcThbjkYDbmuBBvmJ1VN+j1t0I
         XlHGRSTnBsOtDlKSMaQ6sfNC68OYXIqX7tDRN7kSBkeg+OMvL3ENlm0nADsRRxT6b0Zp
         i9FXxDikJgWe9gwRkYkOWWK2ovBkHQD4tHTEUyE/t7Urkr5dSjtFv9aPDrbB/P5T+aty
         RJI0+iQgtpkhMKKu+NT4tKNp/mHcqe4lefg8YurFS8c8W7YdfecTdWe9AGXCZd4u/9aO
         6mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788196932; x=1788801732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BTWco8T03rFwAd35tBKC8oxqSaTdfmTFdjb2cniG45I=;
        b=Tzaa8NvQDJ4WHn7n6RcEiJE+aKgaHnmHjNQwwulMumN0M5EUmbPkvk1lBRkTQfQRUb
         B9xCT3Ox95sBgwIeTy4vvPTExOHsmSwkLa9vs7Ju3uO2DoicAXqOkTtYtzBPkPu3scmD
         KkO6TS8VZ4kJE96X9ERenMR6Lm0EPbMA/Bpw3HyK0PIzVY9GHpL6TVTuWPuYbjpKGvbL
         +SY6Ep7vjbXV/Y7g//qriIqRirE22GLsyWtiPxrI5TFc+mmGD5/xcH3LAgAUfGkuNDqC
         gcAtCokCNrH3aJ/SyDnGAhlFxi0PUDzJnQ+zA9RzRjVDay/RcDAylJEGaMqxrDRh88Qp
         N1aA==
X-Forwarded-Encrypted: i=1; AKwUvByf/+G750RnPB6nUqR5oVpbCVFAX7Gc2I+aStLQKGuFf1RJWyffmUIRswEWbVzLFjhc7JNSeWFKk3I=@vger.kernel.org
X-Gm-Message-State: AFuF++lCvoOGBSbi137hbW2EBnlrwWN9ue2s6axBd5b+POcr5idYKwjT
	l9UjjfdD+9qDUZ3aU8XT22esaHJZsGGDCFQzokGMM8mB9FpQo8dAOJdP
X-Gm-Gg: AYBFou2Cp1OzrN5VV3y7XMdHkCopWY5Rnc0V2RfYbzeuxd8kFXBHPevDWtZaAPWejHv
	gzrHCIGy6K41gg8lIplo6JGv8lj31lCAzf4N0rsl5IKz9ejNqn/Q13lGQmCwvX0EuivuVxGrP+s
	ugSail2dWKZ7udXNfJSOBKDQTmuvFBsQEOhb7HGKNa8om0AFwPn8AYwwOQKaVQP/76eSAVwG83E
	rB92IOmd9T51/D1JZ2GKX7j9+D3NpTIL3g64BlZiwsWc7urWHzbkWfLrXD9+Ari/4uF3tk3PRp8
	6xVcHMKjG1RQw1Zto68Ev0hHnd0jgbsd7Gd2nfDgx9Jb+PsR24CHem2Nd07SJPcuGP5jHM0+pKn
	4SbV1NYcIXx7DJaDqjsnFXLbBJlqD0Llu9UQpLeVPXhUnL3Rpco8FpzZ5xRCoWCGNfAv70iK/CO
	xj7AvIOmH4SDM5cXKXCDVd/DhiR9Uo8yYu0VEmEpY9Pw/tcvKs+W7ydI5jz61TZhcJvhqv8cpfj
	16PylNoheWWWUglqnXSEY1UO+CGSjLkSwrfn3B8p9BwDrGuJjwxaLvwfHlGwTU=
X-Received: by 2002:a17:90b:48c5:b0:398:9be9:ab8c with SMTP id 98e67ed59e1d1-3989be9ac97mr29497513a91.17.1788196931836;
        Mon, 31 Aug 2026 10:22:11 -0700 (PDT)
Received: from Mac.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be440sm36241012eec.7.2026.08.31.10.22.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 10:22:11 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [PATCH v8 1/2] i2c: mux: Factor out channel node lookup
Date: Mon, 31 Aug 2026 10:22:06 -0700
Message-ID: <6ff921823286515e75b62493e748ed08f4816358.1788181174.git.ahmadexp@gmail.com>
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

Move the existing Device Tree channel-node lookup into a helper in
preparation for using generic firmware-node operations.

This is a pure refactoring with no functional change.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/i2c-mux.c | 82 +++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 68a4c34b5987..77921e5132bc 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -264,6 +264,49 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
 	.unlock_bus =  i2c_parent_unlock_bus,
 };
 
+static struct device_node *
+i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
+{
+	struct device_node *dev_node = muxc->dev->of_node;
+	struct device_node *mux_node, *child;
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
@@ -327,44 +370,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
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

