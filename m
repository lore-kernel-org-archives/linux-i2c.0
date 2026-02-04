Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6338B988;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770188526; cv=none; b=oaUd0aMiBwFKxnMhv2nAHZI3+bFzxBLYpLxYRvabwRkLZL6q6wHG/mRTYifG15Ctu6HAXAmHnvuio5ZeK2xVOMetqPChJ6GvZlcqrCjEn0LzxYmNO1gK4j1cvi9T0/ukZAqml/p2AaQriN/3mLOASUBcSqZWL++UlHz+rbAgpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770188526; c=relaxed/simple;
	bh=SgLmwwZ152akW02BJtaThcmesIM6AsNkaiZ4XeQDmjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJW3StPzjlBxG+tfLTpMgNzQSmlztVlBDXCCPMrHr2v0D0ENTWsV6h11s0dNWwMlsB77emYCRk5L8G9RyE9yDjYFyLhABL4rIWx0NJ2/g/b6F3rl809sC9FYhc4MwqVODC2jkmRP6rC9/mcE7ozl6rqiQQ0nzJD3cBCUJK5k0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgcNqFB2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgcNqFB2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2580C4AF0B;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770188526;
	bh=SgLmwwZ152akW02BJtaThcmesIM6AsNkaiZ4XeQDmjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rgcNqFB2cQy9YhQbk9Hb6ubSDMHG9QsSC786tuid0J4sImjgh2In9a1qBiRj4w5GK
	 hFxUoGz6gDOzYuwsQVPt+OEv1TS8ZmIFxAKd3HFsTNCK5eZD6jeoTyMGRZzKg1nTJr
	 JZRLB2brY1f1ohbN1yBDf+hOG67D6ButbqjjXLSs3uPzYlgVNaPG1pryQO4LdpaUrq
	 qEkUWJJ6l118K71ilJxqpUEn8JKSBNu98vGtyqA3+B2Zkd99gHBHMhQcc7dlTBnnkB
	 gpcKui7F48oM3rpWf2dDuyqaPcypAu5d8ONvjopJy40gsdUXC7naJYftnKfmXFX4fT
	 zABvi/SL+chHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA83E83045;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Wed, 04 Feb 2026 07:02:03 +0000
Subject: [PATCH v10 6/7] i2c: xiic: use numbered adapter registration
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-i2c-xiic-v10-6-c2b996425235@nexthop.ai>
References: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
In-Reply-To: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770188524; l=1381;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=xL4GGvzfnOUyOBc311DCeHt6htrYyvg0WAmQadldh3s=;
 b=nvaPtX2WYKN5A3mJFxAnwPiuL2SSR134HGJkyiILe/FgenSTGKQb4DjMLd+niIVWcaCeyd3yP
 dzeDfcjeizUAzFaYnYmR9yFPCbzCnNYOBUIWbjMLg3plWekhMc906Pc
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Switch from i2c_add_adapter() to i2c_add_numbered_adapter() to enable
platforms to specify fixed I2C bus numbers via the platform device ID.

This allows systems to maintain consistent bus numbering across reboots.
On platforms where the device ID is PLATFORM_DEVID_NONE (the default),
the adapter falls back to dynamic allocation, preserving backward
compatibility.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index eeb8ba8e131e..2c0470452221 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1450,6 +1450,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	/* hook up driver to tree */
 	platform_set_drvdata(pdev, i2c);
 	i2c->adap = xiic_adapter;
+	i2c->adap.nr = pdev->id;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = dev;
 	device_set_node(&i2c->adap.dev, dev_fwnode(dev));
@@ -1506,7 +1507,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
 
 	/* add i2c adapter to i2c tree */
-	ret = i2c_add_adapter(&i2c->adap);
+	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret) {
 		xiic_deinit(i2c);
 		return ret;

-- 
2.52.0


