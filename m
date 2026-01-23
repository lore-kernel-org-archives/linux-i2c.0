Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DA305066;
	Fri, 23 Jan 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186057; cv=none; b=nOQMMsRbUJ75hQmBfIh04FKOqHHdMui3ABhy2XTvOGABTeBNxmuRRatvxChB/uzxGH/TotJJiVVygn/Ka4JRtxnedJf69WYFrrvPrKLI8KciwUbF+arHg5jNWmL1IT7CtNLS/mVuiHwzeLcn8ul+4A+UZf2qAqJ4RWRxGFi2x3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186057; c=relaxed/simple;
	bh=0j9fka9qYEljxA2gF2TFcdOGxmcCOdV/rmK49EHEP+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdlGoEo0zErLbcsnuYl3dklLqhGSh/np0SGehJhytMvJaG8B/OklWkSGYguTkqqf0AsOKgZPvmiFcm+mA2Eb4xDTXUhYT+rzO0YJ6HTpE9jVXRz/i7igY1+N1h+4B0fL+5Sr4Wj7v9OTd/zT4Z63b0VVluJejbudFM2LYw1tDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7zBMseF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7zBMseF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E110DC19421;
	Fri, 23 Jan 2026 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769186057;
	bh=0j9fka9qYEljxA2gF2TFcdOGxmcCOdV/rmK49EHEP+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I7zBMseFop7gn5wUH3Gy2Z+oom+2FKUWp1yajwGARs3SqTDXcgRq9LfpTYaqlq73B
	 E19os8fjCaySlALvD8m3eoTxbSK8tGOpG0TT/PnYU//UH1qjjGDjNQv6N374q2DIk6
	 90a1p+dZOncsl32kQV91sS5UTXqDAeO2xl5LQVQE2CSohDjaUm6scUxiR8TLdEgpuv
	 GPOezWseLPhlfI9aCmBoeYFccxRmnX84hCqk67/7HSFYbqGfKsLB1oJR86vJE5LJB+
	 p9dhJLFtgoufvlVSj4/uaycvbujs+E7nUOM7wfKSfOFn/TTMVweDe+MntMi7rmPRi0
	 SrHE3iMMoxq7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3962D6CFD7;
	Fri, 23 Jan 2026 16:34:16 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 23 Jan 2026 16:34:15 +0000
Subject: [PATCH v4 2/5] i2c: xiic: make the clock optional
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-i2c-xiic-v4-2-4a3eba3510ce@nexthop.ai>
References: <20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai>
In-Reply-To: <20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769186056; l=1147;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=epD2VW7nyikMBdytoxP7e2Rce+7IIwA5ENNJm0jD8gY=;
 b=D9uydca7fy2OIAMy8n1HUFnVYz4YxJwcME46moeenGRF3EONXGqNcmYgkvV5+CtF0DohQcWRv
 XMv8nFAHL5sDzRkNr8AWxvqu7jJNbOr/IPTQ/XAgLhDipB2EtSVoSLQ
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
index 12321654055f..2da7e9d1d5ca 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1465,7 +1465,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	mutex_init(&i2c->lock);
 	spin_lock_init(&i2c->atomic_lock);
 
-	i2c->clk = devm_clk_get_enabled(dev, NULL);
+	i2c->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(i2c->clk))
 		return dev_err_probe(dev, PTR_ERR(i2c->clk),
 				     "failed to enable input clock.\n");

-- 
2.52.0


