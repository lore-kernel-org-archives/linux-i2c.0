Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50630C37B;
	Mon, 23 Feb 2026 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862360; cv=none; b=g6zAZGpKz6W40P+BTGJZxUYndxEc5BhaWjegc8WRfqCqbzvYbZL8FVRv2btpFyu6w7hxTWHHCh3wfVMSJfPvCrOln7SlGiv3ULCHXT1SST6biNIkHm0gOoA7y1r6jNX5oTJOjIVmH8isE2tir+IC3TBrYAJ7HtM9wqaiXtVATEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862360; c=relaxed/simple;
	bh=8VgLBNuTxD72+GI4e0fkK8v9sYu+VLaZ56iTicorfVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fttUEU4kCTAsStj99StLfOQS789kifzFgH+YgZmUo2T54nnIMAsa2aIbJDEgO+z6i8clsjrdJt2YYoMJnZQWB3fmLS2WPsP0yvzTt2phRABuO2ieDbLmVKgj+dZ7PJwj8DbLwY1fwp0P1PkXqIzN/V4bHDkWw4XoR8obm84iz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUXNpPay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUXNpPay"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27EE9C116D0;
	Mon, 23 Feb 2026 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862360;
	bh=8VgLBNuTxD72+GI4e0fkK8v9sYu+VLaZ56iTicorfVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NUXNpPayyGsKW9S8uDu3RI4dyDMmw9yk5MjGvGpU8WVZ+jR+qRN/wmS18qegVP6Um
	 U0n0Nt4f1xPvKSuGcTMmcz2Xcjgw9NrbTIF/D4zSz19Zhzn0zmjnCPiind2d2aVGyE
	 7oO1zsUEGWJrje2+ZGsnWnxTmSPApUxGaA/0yaFY+r9/mvl7v+cRKl4SQG4QyculwA
	 VCgQjBZTpGlE8+QPsdDiUklj2vQnIxb9xCkzKr9ii9qD/HDOu8CSP28B9geUCBw3sR
	 531w9w3n832apGGrB1OCMGMShZhqUyT/+oP8ot3Y1cupMxpodQht5IzInp3XadJ7kJ
	 GzOUsFKRgUkGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202BDEA4FC7;
	Mon, 23 Feb 2026 15:59:20 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 23 Feb 2026 15:59:22 +0000
Subject: [PATCH v12 7/7] i2c: xiic: skip input clock setup on non-OF
 systems
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-xiic-v12-7-b6c9ce4e4f3c@nexthop.ai>
References: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
In-Reply-To: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771862359; l=1194;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=usc1CKg+f05YBR4E4GFMUb7OKXzoYUSPfhhuE4yE/XA=;
 b=+y1k9kEklzjax8kw0/GxG/XFD+YRKhH4DvYmswPoEay7CKIIqzhSrJB5CtDpA1+ol87X1I/6o
 wBmNI3aTuLmDsP7/x9j7bzPOs5MdZ3A0bhlLvxYUcuC5Ia6PtpP5mJV
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Currently Linux does not implement ACPI ClockInput() resource to describe
clocks, unlike DT. However the xiic driver is happy if something
magically enables the clock before the driver probes, and does not
turn it off again. The clock should always be considered optional for
ACPI.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 6eb0c6a2618a..3e7735e1dae0 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1464,10 +1464,12 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	spin_lock_init(&i2c->atomic_lock);
 
-	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(i2c->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
-				     "failed to enable input clock.\n");
+	if (is_of_node(fwnode)) {
+		i2c->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(i2c->clk))
+			return dev_err_probe(dev, PTR_ERR(i2c->clk),
+					"failed to enable input clock.\n");
+	}
 
 	i2c->dev = dev;
 

-- 
2.52.0


