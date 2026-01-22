Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845DF330B2D;
	Thu, 22 Jan 2026 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070756; cv=none; b=ALg+A9IoeUUmeFAfx8jVzTEVOafJmaJexr0lMHj68WbyK9f2IaVB6UyqnW4oS5nZzT3kDR7D9Y+Lgl1juveF76AuP7CQMHdHIy21FAF0Kk8w9ZspoFDO0Hv2+Qw6tcumlIdgfuXOYKza0ROmGz4Omw5TEHCM9eHK2/bA5JEaD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070756; c=relaxed/simple;
	bh=OhygDeif0qaAagip01OdretnzJcVMNjCREuPz9F/O50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HxL02AzN51QZKHg9nlucto8YCVfouR5PBfeSwlpqzoUXkHhru90+QZcWk4tFz7iibdIv4jCXslgmdMT6xF7NZH4HNSH/dm4AL1CcVkbL0xoxSG2uhePKuGZqoCmkgtTb6f8iKnXW+BDbs0dQRChiy3gtyd2MlpH8/6c8yV3svRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyzmRYku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyzmRYku"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20F94C19425;
	Thu, 22 Jan 2026 08:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769070756;
	bh=OhygDeif0qaAagip01OdretnzJcVMNjCREuPz9F/O50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VyzmRYkuOWEfxuT/Y5fH6dL5MFLwGYTXYTk+C8BSMZNyhN1NeX7tqLqG21ChSPSb8
	 2V1pOUnL3nz9kUWL4GO2IPnZXoBTWmH1bNYQN6ic4/s+GBpCnibveRASviIsYtXauX
	 QmaRP5fWfbIvQyq96c72UVTysgI06ShjT+6aePAafKakmZyBlZ/xH+xbf3x6OLbdbH
	 j+a4aCB8KrWCfmoaE5mevugVyeCy9JWS5JHpH7N6IcBZmYRvMEYawpFZohGk8u5Zyy
	 Ex/GYIJ3CnCN6aO1D33Gzy0fICnxJDE6LU/PjfUk/DeHPLvngf6eZn8IbcfsB3DxBt
	 /BIpf6YpoqOjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1313AD625E0;
	Thu, 22 Jan 2026 08:32:36 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Thu, 22 Jan 2026 08:32:32 +0000
Subject: [PATCH v2 2/2] i2c: xiic: make the clock optional
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-i2c-xiic-v2-2-134f5d743e8b@nexthop.ai>
References: <20260122-i2c-xiic-v2-0-134f5d743e8b@nexthop.ai>
In-Reply-To: <20260122-i2c-xiic-v2-0-134f5d743e8b@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769070755; l=1147;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=30Y4elib2oXS0UgCTGXSQddfRG4H8frOGSLNdFvW0G8=;
 b=CuQl/jaFtohkiawpscgRaSfDh2zFoUAaQuD8v9qu3C6qO1n1SZkhluEHqHAaMg63WZ1k0TuCj
 hh0YTdPwwufAH7lEYU6hJCjs0ZmN4/0UP91yD28VLrFcVOAge1JCGsd
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
index 2ca736cbf688..3d86b2077d6b 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1459,7 +1459,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	mutex_init(&i2c->lock);
 	spin_lock_init(&i2c->atomic_lock);
 
-	i2c->clk = devm_clk_get_enabled(dev, NULL);
+	i2c->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(i2c->clk))
 		return dev_err_probe(dev, PTR_ERR(i2c->clk),
 				     "failed to enable input clock.\n");

-- 
2.52.0


