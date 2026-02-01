Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39052277CAB;
	Sun,  1 Feb 2026 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914670; cv=none; b=j4jggA7x4Z5NAOFMUyMi3YRSL6Utpi7n3Dk1boSNk9VV12gdtneyBGAEU175C1irI31hvZt3bRzYhkUTdvK4sFG1NrwxYL6UYr62mJC9pcdSCdEY0RQ5B0fxRiWbSKpq2OzbGrmrOEYolDI24abm27o9uO9K1V7KKQ3zbV84r2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914670; c=relaxed/simple;
	bh=A8qVLeDBMXcKbF5rH0cEPyooLb9F1EeK5SG34k1Wr1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jB1L/ZoMFUN+nCjl9Fg1iCy8vFgEq0UAPgcn0LXYsT0AIc+OJf9ocMLCNG/iVauC14MMQuCF3gE2hs9NJ4hiYyAxEtfTFfJkaJNPcEIebG7lJth1CNqQVzsYUIpZGKZEytnJAtJhBUcUCPPAWhR/DjcmWoS+hDDQJ0Kc6zwR3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPEzAQoY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPEzAQoY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFAE3C2BCC6;
	Sun,  1 Feb 2026 02:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769914669;
	bh=A8qVLeDBMXcKbF5rH0cEPyooLb9F1EeK5SG34k1Wr1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rPEzAQoYjOhxuo2tI2sSXAhWK9GFjL3Mg8ButKWsj3XSymKBe7nUI2g7s7ekjOULQ
	 9VM1tUoS68np+QJ825LsdoSwTakuXzk0qd6rrRHvneImZrAll5Eu8XAZ7EWJOf1f1Q
	 W2QRYEbLwQOOAmKedpH5P5/MSuapydbrs1xo/O9QjVDNNdqHs+UOPZmz4EwUP+nIuH
	 35ATfRPG1LeAl3k4bm1pIetksd94K2xfAWCGil2EotkIkOcSHIpTuUMojZ0NmoS9ZC
	 jxzSk7Tfi1eNtiehERYKMJHWYsz7TXObZoNzESQI9xoMOVQ8PsEhAJJzV6EdwTGnFw
	 v1xdO0fZDwDdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66A6E7C704;
	Sun,  1 Feb 2026 02:57:49 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Sun, 01 Feb 2026 02:57:50 +0000
Subject: [PATCH v8 6/6] i2c: xiic: skip input clock setup on non-OF systems
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-i2c-xiic-v8-6-deb2dd158d1a@nexthop.ai>
References: <20260201-i2c-xiic-v8-0-deb2dd158d1a@nexthop.ai>
In-Reply-To: <20260201-i2c-xiic-v8-0-deb2dd158d1a@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769914669; l=1114;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=BKvE7ant0Fm54tZZqWG3GDfI7eCUIcrHxeGQX55zS9M=;
 b=TEcBXJVksU3Zrhk0vDfNaX378FepkQeslTyJbrsuCmswuXtaTlQ1OQ7tcRM1XwOa1NXgysa2p
 /WEFlYEWYnUDo+9bWHREcTsKuOpk5oDv+I/8FfMcjk+g8G1ccNvF5Hj
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The xiic driver supports operation without explicit clock configuration
when clocks are not specified via firmware, such as when the ACPI tables
are missing the description of the clocks.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index b8439b78d1ce..98befb46ac27 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1462,10 +1462,12 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	spin_lock_init(&i2c->atomic_lock);
 
-	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(i2c->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
-				     "failed to enable input clock.\n");
+	if (is_of_node(dev_fwnode(dev))) {
+		i2c->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(i2c->clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
+					"failed to enable input clock.\n");
+	}
 
 	i2c->dev = dev;
 

-- 
2.52.0


