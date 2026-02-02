Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180930E842;
	Mon,  2 Feb 2026 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064656; cv=none; b=tkI2bbI/Ttzt0h05PIDJRuaWinnsknlaeDfIwWQ+fly1t2D8oV+DMoj0mB17dk61hYk1HeRZmpNbFVewm/B2QaNLqJYJgLtK8cSEwvqrMeudIGeNOibCI6f0STvnWE21tsNijEeyppgZCJSh1d4qjdIdRi2iODqtPLmOpI4yMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064656; c=relaxed/simple;
	bh=Xksoe2+S7Mf+L+o1XLDCUHOeZtAgXsNJ8wt02v5c5fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZz3Micocyl9O9/yPM6R2hmec5kGoKt4MCQRmRyAQX0YOjAD9jZ5sbCgHJug9K9I2bUsrIfH5FrasmfGrdd/vyHtTNF5IVn2lXBgv2WaaOxSz2Jcmb9FWEzqxAl6vhsx7U960bemVAXddYq1nK9guo5xt9YOuNanD7BNnp8TxoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD2LGyb7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD2LGyb7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56D55C2BCB1;
	Mon,  2 Feb 2026 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770064656;
	bh=Xksoe2+S7Mf+L+o1XLDCUHOeZtAgXsNJ8wt02v5c5fE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uD2LGyb79vtLQ27ZflKOdGS31cNVKV16K1yKZAqPGM0X7keSbvKWPlejyAYZbGMxd
	 IrU1PQzTW5ybZO91p8VBqORtypSss0t1N9dpdKk+WKqQY/kD24hE/yTrv0Y7iAMqbx
	 o5qF+EBMpov0ZYcJPlG97wga2oGS+vWDzFvX5WN7+6SGc1f0b8knsL6qJXhxc4w4Hw
	 PpUatl0or53JPtRqA9LAHVgw2sjcdkQjoVCEPiLvaHeQ6iEQ9+O2LhfqBDYrdvx6yv
	 LU32jWOcTQ5l7Mytuh9PGybtZ0ErxQMKyCvFebdOMiym2Tvfnzf1dD4O++x410biUl
	 091HTGHncwFng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47768E7FDD4;
	Mon,  2 Feb 2026 20:37:36 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 02 Feb 2026 20:37:22 +0000
Subject: [PATCH v9 5/7] i2c: xiic: cosmetic: use resource format specifier
 in debug log
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-i2c-xiic-v9-5-ce4695f5267d@nexthop.ai>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
In-Reply-To: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770064654; l=856;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=t2F391AQVy1CL9rMsRzI2NPAaYKBn3gbJ/BmjKyoXVM=;
 b=W3gV+F76fdQ6UqgI5HpUynyGfb5qvfIWV9fvKzLobDKxlBrKDdvI9S8L9/eeV50woSaJbJUYs
 qnRcBQYalwQAnRxJqrUci5kHgtCWUlFjDY67md93N50xL8ZdEltZZyp
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
index ade0fd66451b..eeb8ba8e131e 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1518,8 +1518,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 			i2c_new_client_device(&i2c->adap, pdata->devices + i);
 	}
 
-	dev_dbg(dev, "mmio %08lx irq %d scl clock frequency %d\n",
-		(unsigned long)res->start, irq, i2c->i2c_clk);
+	dev_dbg(dev, "mmio %pR irq %d scl clock frequency %d\n",
+		res, irq, i2c->i2c_clk);
 
 	return ret;
 }

-- 
2.52.0


