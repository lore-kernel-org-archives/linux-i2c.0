Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E6313291;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155385; cv=none; b=JXzqfVMuzvPFlFYXd7JiF9vm1PZKfMVSupDaK3VTjKTquFC9zbk/RWaYY5pCO89iH0ZrNQUNgu+U9PP7o/pKuvOqpyDM86UMOp4QGq2DICu7r7T53okNYVSaoIkd3hWwLTmNjD6+r8UQMDpsd2YuQo5kBX0WOUt2NHwUstwA84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155385; c=relaxed/simple;
	bh=9iKYy3t+e8eBDnpd9Bt1UVB5BMTj+yjnzaBUk5NiFYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxdr6oUiwle+CMXv3+8wHxTRKWG2x5gSiopzmvFmM7tstelX9CPFceYXOL77jqyYlucbsZ73CFLMHgP+nVdKGXrcSA8l5/Cd7/dxHTPzL1Uf/WmQo4IIaq1Kt46ZGjXjA7MxNHqV6KQZ/znf4FoQ8HVjtk8muq9NN41HjGsTdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpbBEddZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpbBEddZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 170A8C116D0;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769155385;
	bh=9iKYy3t+e8eBDnpd9Bt1UVB5BMTj+yjnzaBUk5NiFYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LpbBEddZxMLYatntA3RsUqVEW18c/weqjYN3QW83kZaQWlbmS3HswUCkMovg1Alj8
	 6FTwif54aRQ2/0Bz9Csh/EW7p8XrGmVtgEJ0zfM0hxFQKzerWO8INEoviz8itUv+CK
	 LZc+wOJBQJGa/yb/rOYtWt+DwBIi4fv+C2I1Qsm49wfdxcPT1aKCOimNHvVtpH+A7a
	 JxBSAp2SJIPYUqTyfjIwHV/DRIu+z3IEv6uxG5QdjcVuDRk9rOM2j/64K9jB8fW021
	 mZ9xhc2+y51n1bhOj4dYA3RRmjqzTUojoXvNQ78bJZUYoPBRM93qK/sXe8Z+ueLm3e
	 mj/62yaeTIGsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E04D72345;
	Fri, 23 Jan 2026 08:03:04 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 23 Jan 2026 08:02:44 +0000
Subject: [PATCH v3 1/5] i2c: xiic: make the clock optional
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-i2c-xiic-v3-1-eb7cd4254dfb@nexthop.ai>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
In-Reply-To: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769155384; l=1168;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=udjYxPfABO3RAAMRuXRQ2MPbxoAmpLEpeJlZ6QUIK88=;
 b=1ISL2wGnufwGq5e3UKjSjQXpuX+iQsvKQUdspObxRQveDFo7qaQYA+RLlyXWybCKZgjgQUj74
 4AY+GmGZihNCZXTKtr0O8vaOdLn7axz4C86VJlDfTphckQo+rnZLhyM
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The xiic driver is designed to operate without explicit clock configuration
when clocks are not specified in the firmware. This functionality is
already implemented in xiic_setclk(), which performs an early return when
either i2c_clk or input_clk are zero:

This condition is satisfied when clocks are missing, as clk_get_rate(NULL)
returns zero, allowing the driver to rely on hardware-configured timing.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 28015d77599d..603a246a1445 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1464,7 +1464,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	mutex_init(&i2c->lock);
 	spin_lock_init(&i2c->atomic_lock);
 
-	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	i2c->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
 	if (IS_ERR(i2c->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
 				     "failed to enable input clock.\n");

-- 
2.52.0


