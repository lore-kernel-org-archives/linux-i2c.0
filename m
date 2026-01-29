Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C92236405F;
	Thu, 29 Jan 2026 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723006; cv=none; b=WBAIUwDS7f7YMkPBHPLDQNImllVNh6RKECdnpIrYWCuTwGBwTMCbdoDnO02d5uEM4qUUSKAGec7e8sv3d9jR49imGfo0Qj2SpilHQje5AM6G1JjlVLosi5FjZ+OAxWRNl7vw2HdIdlBUL2/vidF9VA60PQ+Dtz05EHYn9i8Ocxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723006; c=relaxed/simple;
	bh=IpG7K26YMbIYlMeNw0cmbfVLcX2DzmYeW2ZXxwHgglM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQt46NyNb2TGkE+kduTX3JM085cHccvv1vrm/ocoJnONSxJ4TYRX6vm57RqxHuc3f2ttRIAvNCOXFFGtrIQ6CYdNWXGTcqrN1oi+DRcq49kcMzBcfTEpZsRDunllbwT9tCAE8fvXtICHl9UY5/WWG+5JTRSpqz1HszPvAg7TGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYL33MXb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYL33MXb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFCD9C16AAE;
	Thu, 29 Jan 2026 21:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769723005;
	bh=IpG7K26YMbIYlMeNw0cmbfVLcX2DzmYeW2ZXxwHgglM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sYL33MXb3f9GkOtqfM77vPMoYK6szbN6GSOObPKiYrrkp1YfDoX88/BPiMfYU9T6R
	 HrA3Nu7Jc8pfz7Ks6MB4lpFdRiWxsO6xuSNuUfiLrENpLGD06vhOhNMZVa7fe4BJMU
	 I/0QZcDyzOHYyNZ2tatvLD3tU91G55JUKyuDgBdJ0KaVV5mzAOrPkB9B54IArOuODi
	 LO10ob4jWju0JUgQP9EQVnhCel77MVe9lxyqYrFiI0WadxRq1Ll0lBKBfK+COd0lYs
	 nx9Hu/HmlSQoK5/KtarUmK5mFOxobWU3oA7YHKZQK/sqUVrUwg9BfzD0JsQQlrzs9P
	 1wqVugwkgbvzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6FDD73E9B;
	Thu, 29 Jan 2026 21:43:25 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Thu, 29 Jan 2026 21:43:13 +0000
Subject: [PATCH v7 1/6] i2c: xiic: skip input clock setup on non-OF systems
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-i2c-xiic-v7-1-727e434897ef@nexthop.ai>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
In-Reply-To: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769723005; l=1542;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=6voIA/a0l46cOc5ueYDVp8U+gfCNRwVU2ZoxgHh2Stc=;
 b=uBwWwmjKsmN67KJ/S9Ua6hanWw+GJQYf5zu/W4/drXYAPDqOkwughktr2P0AaBqADRvqAnCOm
 V4MRkqI0US1BbcTMGp7vo1PHJU6tME9zl1ePwNyn+YoiJHIm62Y0GzG
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The xiic driver supports operation without explicit clock configuration
when clocks cannot be specified via firmware, such as on ACPI-based
systems. This behavior is implemented in xiic_setclk(), which returns
early when either i2c_clk or input_clk are zero.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 28015d77599d..912a94d4d080 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1423,6 +1423,7 @@ MODULE_DEVICE_TABLE(of, xiic_of_match);
 
 static int xiic_i2c_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct xiic_i2c *i2c;
 	struct xiic_i2c_platform_data *pdata;
 	const struct of_device_id *match;
@@ -1464,10 +1465,12 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	mutex_init(&i2c->lock);
 	spin_lock_init(&i2c->atomic_lock);
 
-	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(i2c->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
-				     "failed to enable input clock.\n");
+	if (is_of_node(dev->fwnode)) {
+		i2c->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(i2c->clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
+					"failed to enable input clock.\n");
+	}
 
 	i2c->dev = &pdev->dev;
 	pm_runtime_set_autosuspend_delay(i2c->dev, XIIC_PM_TIMEOUT);

-- 
2.52.0


