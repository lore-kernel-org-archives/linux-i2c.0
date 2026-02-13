Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B6220F38;
	Fri, 13 Feb 2026 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941723; cv=none; b=ofZncEOuu3OHr/BcKFLONk7gKWoZvoJoycAhWf7EOZcA7Gg4Yg7aP38jJNeMiI08/62fIFZJvRD0Trvjt1aWPupDesJEdCgvu6VS9UI7oDkCNx50nHZyCzUU5ImbE7vFW5Pt50uVz2ckeYNzl7j3lOiY/NVZJOm7gDg7G3z8b2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941723; c=relaxed/simple;
	bh=kbn4C8NgmoBQzHsuwllEDpxc5+yBJkccQL4mCYwFGbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4MR4k79/gp0lAkoNqDHJ31Kunf/KTtwQYX8kaquvwtoEDQsk4CaPHAe8gCeq0BHcDMjMqDLG8zNE2isBJIzUjk+6kTeu0bx/RjZUeIvm4LCxVmr8RrZd4vGWpRcrk94/+23VarJiW11Y/km0Iv6pUAjcja1Qf1grp81u/s2mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbZSLlWB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbZSLlWB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAC8EC2BCB9;
	Fri, 13 Feb 2026 00:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770941722;
	bh=kbn4C8NgmoBQzHsuwllEDpxc5+yBJkccQL4mCYwFGbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SbZSLlWB+uyZw+umSQ1E7KOTp6lxAGrm9eOjJprTjFaPi3I/n7D9+g6JMVPuURren
	 coNhVEii/mxACikNsM94a3jjGRf6m5nf/uVjwDaRUXEtVxU7bg148E8usVtdUQ3om0
	 HdccU/9vl9YwuVs0zihcgqjta67Jbjv/iJx7CIWvvNA782toE9Hcox196TGgI2rV19
	 abaPpM3CmK6bVwbOtbIR7zXdGO4ucAB/6Y6/KzZezSWb0hB6Qm1sIuhSlpqD1vD4Lg
	 dlkZtokY6VX2vtwu7/N85ifQD+HGfjF5q7KFTJibW8vd3As/JAnIfbzK/cLqydwIoK
	 PSTns9qdFFh/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE75EEA876;
	Fri, 13 Feb 2026 00:15:22 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 13 Feb 2026 00:15:20 +0000
Subject: [PATCH v11 5/7] i2c: xiic: cosmetic: use resource format specifier
 in debug log
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-i2c-xiic-v11-5-5d18aea11bde@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770941721; l=861;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=58fg1T38jFleb0swh741hN3S1SY1m1FGjswU0Y+gW0c=;
 b=nMJ+FAm5Y+DoCJAmk4Hyhfjm9uY2Br2aFcy0WDdixEHQkgFc+mbox3jTU66zde0Nb8+Y1TGzV
 ah8gaUDKVL+B66m71/PXFzLFcOhjIRENGzKBZbGw1Rqt7lMlnzpmwgj
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Use standard resource format specifier %pR in debug log.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 377fa5948c3f..373c00a93034 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1518,8 +1518,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 			i2c_new_client_device(&i2c->adap, pdata->devices + i);
 	}
 
-	dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
-		(unsigned long)res->start, irq, i2c->i2c_clk);
+	dev_dbg(dev, "mmio %pR irq %d scl clock frequency %d\n",
+		res, irq, i2c->i2c_clk);
 
 	return 0;
 }

-- 
2.52.0


