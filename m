Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B92153D8;
	Fri, 13 Feb 2026 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941723; cv=none; b=HsVUwGf5ELbTVnTNZTuMz5CS2oHhEN+3G4aGijB3kFBLvndbncRchMyDGDtTE1ZIh5dfjz4oBwxWP9JuzvdQ4vNKMA/B8m8a8sOWzKb83aIqpIkZCRG/MtVrpxisD1fSNdoEwIfRys+PrwV12U6AQpzgC2gdM9/DgTY7bONzitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941723; c=relaxed/simple;
	bh=i0It30sqUuBb6w3dSvN+K4xAmB3+vRycrDLUAHCmoR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYP8f8TSIoDxaLjTU1bVnIG3Dr0iuuq3KrKG+ed6Q87OjNx4gjL9TAPW427avqoQkdpjaq3364BqF+tUjk5E5XuLOi5ZozAGKFv0/xPP5WZ+PjSc8z+ReXgJ7iaOQf8JLDPpbisC/7tzdFsRQdMctlZokLJa1bmeY2gEkXaqruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7w81c0V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7w81c0V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6355C2BCC6;
	Fri, 13 Feb 2026 00:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770941722;
	bh=i0It30sqUuBb6w3dSvN+K4xAmB3+vRycrDLUAHCmoR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O7w81c0VDV7ngVKI/feWUryR8Xc0UgOHb0lphOG17ufO3BtdP9K8bS7JzCcPdMBZU
	 ATTHBx7x9fXidcm9PJWsteQUW/LCNCee9YQfeSTLS+RQ6oqvpq9aSseG2knwZcgx3K
	 j8aFevf7ng/YG6aUSr7MMxqMLSMLxLJKBYyasYUq8fXezAIJCPM/1ae8Y+NOrush2R
	 AGNo5LwAyrTfDRdsJ7o6seBgGVQOjYHirbymgofcQWotfWGOaTtGd8BXCqAHpM7aLo
	 ofR4jHhBOSob/5Z33ENZw/bgi4Ypcs5SYqsMgeN2G9tVFf2zDTSCIxU5pWIFAr38Hx
	 WIDm9WAI2hUog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBF8EEA875;
	Fri, 13 Feb 2026 00:15:22 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 13 Feb 2026 00:15:21 +0000
Subject: [PATCH v11 6/7] i2c: xiic: use numbered adapter registration
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-i2c-xiic-v11-6-5d18aea11bde@nexthop.ai>
References: <20260213-i2c-xiic-v11-0-5d18aea11bde@nexthop.ai>
In-Reply-To: <20260213-i2c-xiic-v11-0-5d18aea11bde@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770941721; l=1381;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=OcfhhTnF0WtrdPeWNqGBAVD1c0SVBN7KhRbWFtUKE0E=;
 b=x96Wn3uuPvc410bLRuXiGYkplzRWuLttTyJI9nXHfMJhzJq0/V8kNe6hltjxFJpDfsYODUu3l
 1BQHVyRnVcIC4Q7VgvNexWkyQetdFE+JV1WlmRrA5BzmvIrAve16DsT
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
index 373c00a93034..2ad75325154c 100644
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


