Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB538B7B0;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770188526; cv=none; b=hB1gv/6xMTx5bfALYQBQhYkrQTded+vUrGhPMLzwlTEG9SUmZoO7UN9CMDyBu4zYSra19M+ZAQTJUThuW1rwlWAqHs5VF713ifPpW/Qfitbnd0KtXBw1IRKrmBhDjZu/balhgP1+rHd3y4HDpovM2qyQntAogWbsHlVGkYAetdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770188526; c=relaxed/simple;
	bh=LxoVmxDXXmBVVhAwbDaeJQFyxYsskpuHqN1apdaJrQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAXrwOGvZeTsDrK1MGSl88uPfDuo1WlWOZVqCLY6N2ooPCThIIp3gkQ70mn3KxhnTb2oWE+RsJcnf1t068NSlMv/TqdDXYFnVvz1Y7wRCQwU/KtCuHzQ9wYvT9Vntb25QsL7HWnifJvfcPUKjqCsqxc+QlpzroPNS/PM1kgGhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvOsPjvl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvOsPjvl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 808DFC4CEF7;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770188526;
	bh=LxoVmxDXXmBVVhAwbDaeJQFyxYsskpuHqN1apdaJrQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qvOsPjvlRvEeB863eDniO9/cNx7xpbkYJ9PJs/VbIhCsGngxfWlzo4lOlhI/pu9ag
	 zZROTKOdwP31rUV9F7m9GTvhGzE5fCKFRKoeuPcR/tGDAIxkRE3p01Va5LO+0mu20h
	 T92AsDvX7iG4LGarkrbNIcmASwodrhrQhLEDijLL2jrfr6/rP+mPILmoLttAwY0qjz
	 RG9bzhBjUT/6x9a58ZagjIwejDimtSrsMGARyt1hLuq0T3KMqy7AXbKkKB8I3gjkvP
	 wxvBFuLMNHQmviO8rq5v3ndrIfEyj1gltGLVgP3Dllk/+QelAOT30cVhLXXCTy7Vyg
	 iEJacJnlPRJOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DEBE83046;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Wed, 04 Feb 2026 07:02:02 +0000
Subject: [PATCH v10 5/7] i2c: xiic: cosmetic: use resource format specifier
 in debug log
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-i2c-xiic-v10-5-c2b996425235@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770188524; l=863;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=GiIahtjK7bofJukLRpl9r+0ubtXiljSfc9Z/DVdZ0TM=;
 b=72tWL1XIDqJBVGstyFSC+vlQjYPs0Sjvsxzk1Ub8ypO9jg+iDiKrYc6LfJ3ZUZlGO7gBgoIr5
 drnWtMdenUhCSAMUvkhIIcVBdRzS60KY3L5S2CcYi69rBSj0iG2aAiV
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
index bee663f91f10..eeb8ba8e131e 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1518,8 +1518,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 			i2c_new_client_device(&i2c->adap, pdata->devices + i);
 	}
 
-	dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
-		(unsigned long)res->start, irq, i2c->i2c_clk);
+	dev_dbg(dev, "mmio %pR irq %d scl clock frequency %d\n",
+		res, irq, i2c->i2c_clk);
 
 	return ret;
 }

-- 
2.52.0


