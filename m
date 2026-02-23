Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2257309EFA;
	Mon, 23 Feb 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862360; cv=none; b=fy8j9324MCJ1aDOCuYQk2Z1WUdmEVumB24W0WZUuj62GMTDjCwKI0d4Vnc/LeCBQgTnC8fr4PSEJBVfrw5yqV8LMG9PGrMU7Dd1kluAhr3zymOwGMjvAsS8xDUqXdTaIwwtCBC8UXIN376ks80sZ0HM2+hUa/bmZUj1xa7tq1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862360; c=relaxed/simple;
	bh=jRtEYRL116cS46+BRRnEAwVlx/TCGH4biEvlH/E3jhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJhKacgsdPOMbHiAia32Vh/Xa35/QlRRY6Z1SosqNso/Yut2f6FVU5gpJDISjn+wnavWAvWRD4wq+g1kGzVZ9OzpNOLKeX63bdouGBoNILbg0ClcC83sUkzYn2aK4ENE4rjoov+FMztkR4AQz/ZhjJz/nhQuNf0o2CJbE1ktAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY8W00Hz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY8W00Hz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD8DAC19423;
	Mon, 23 Feb 2026 15:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862359;
	bh=jRtEYRL116cS46+BRRnEAwVlx/TCGH4biEvlH/E3jhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hY8W00Hzl/pp0egLIG1G4hWGihy0/D3JpTJM/Hsfo9+C1w0D/XltYitv37hwekP9d
	 +zRiZ9L5LLgVRW6nicOypqEge0cNyNKu1zZGzbkDNPRCw9uspCKq2BaCS2ERehZkyf
	 HBpimFEbeuWhidWOva62rFKM9SUoMqVLn2nBzH5v6udcr+EeFBx60DToBoCAu84raO
	 S0GbIrNEcB+unNERxYv8lLV3yOdJCcz8XIW8i/VhLiv8RNVfpx3SPKc+ZCn/rOZ5cN
	 5Bm9tXywKZL80YLwcyfIu3pua0KkoKEcE/eF+F20y8o+0l21SwV3CCfBDBw1DVXsE1
	 PKTFbyGmk6DjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF79FEA4FD8;
	Mon, 23 Feb 2026 15:59:19 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 23 Feb 2026 15:59:17 +0000
Subject: [PATCH v12 2/7] i2c: xiic: remove duplicate error message
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-xiic-v12-2-b6c9ce4e4f3c@nexthop.ai>
References: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
In-Reply-To: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, Andrew Lunn <andrew@lunn.ch>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771862359; l=1019;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=RRuL/bQeZiBpUR1djYETZjT+qDSOpjJwtLxb+GfrByQ=;
 b=VharzeRkKrxhyXE6WRZHB9DJvlK2n75eKd6wkWUB1AX6r3efg6/vudtjKSJthn0dcTNl9jog/
 Yq1xUm9m4ByDTMwx3ySHPlrWQgQsjZQcLzWOTGNHsP3bFwMCsrDgk7J
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The devm_request_threaded_irq() already prints an error message. Remove
the duplicate.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 65aa280f6fd9..99286af2a0d7 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1491,11 +1491,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					xiic_process, IRQF_ONESHOT,
 					pdev->name, i2c);
-
-	if (ret < 0) {
-		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	i2c->singlemaster =
 		of_property_read_bool(pdev->dev.of_node, "single-master");

-- 
2.52.0


