Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3E364E9D;
	Thu, 29 Jan 2026 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723006; cv=none; b=pZdJZJDYnGspGIbV0C1VcJcwaSM1Txsy3x2LPo4hLTns+OcvSRry7waxdJOdlaAb9cppPKJrSv0trptbPzgBoAFKU2MKJFPibEKAFl6kUr4Dk9PzkXpRLQJnwGmiNnoen3oQXvJD1RHt9u4ucynu/Ufa0wTxi5aaN4Oq1KPlRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723006; c=relaxed/simple;
	bh=63LIznqFOs+vjoKgYNAGULivL80MwirjxtzcB50EozY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=it/0hLUtPWstzGDF2iL/f5PHX+xZURL9s12oCreeERyo/o9supcC7/eViEzpKUloQAhMNHUz/fYO8ESGoOFxQ5/f0zBqvYviAcKT+3WzG+FtCSi3kdnVOhT1r1JLYMktDSxVmHRD35yjaOtj1HPszJDjPcpddbem/+BaSZl+5QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F17P0uMt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F17P0uMt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B307C4CEF7;
	Thu, 29 Jan 2026 21:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769723006;
	bh=63LIznqFOs+vjoKgYNAGULivL80MwirjxtzcB50EozY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F17P0uMtYIGb2OgbcRMRPnqr7mzmm8VMjda/u8aBKUKo4NmcV39qOnU9ufh8EBe2G
	 QUbAcuAQeo10NNTQkdfN6WnqwP0VMxX+fOXzxBSCXuLCSQcAIXbnoT6hXBO859edX3
	 4AFYm9Ucf9mZoBdJl6mR1PqUnGw+I4LiOdDyXsnZsa0aKeipWxjHLvhGlv7ZBkYdJY
	 H886VBWcU8pR35FEZFv8GIwAgco3YIoRc0b+HdmzzUOa/IZ99BdPxydjtP7Hhl6wCB
	 1b4V/aL17a8V88+Hb6+wWmsS1c3hDvUSaEvf3uiqP6bfStKcdMt3LvXX/VlxIUrTnW
	 3ejr3THvlccoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02631D73E9B;
	Thu, 29 Jan 2026 21:43:26 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Thu, 29 Jan 2026 21:43:18 +0000
Subject: [PATCH v7 6/6] i2c xiic: cosmetic: use resource format specifier
 in debug log
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-i2c-xiic-v7-6-727e434897ef@nexthop.ai>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
In-Reply-To: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769723005; l=796;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=AyCNoRBKLYKfBPlFJJJUJ1HZ4ulZ88H5iw5TKWG8oFw=;
 b=uQhYS1vit0sv+bhMHnHmHsL2lmmclZrijbdaPDHxYdtFj5dfVi4YedI9NYD+Z/SyM+YsYV4vz
 IZ6i3jzydC0AASM1+x6xkBVi5X/v2/P+CWVis0tU9y2DhXTR5v7qGMU
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Use standard resource format specifier %pR in debug log.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 37a15065db60..b24b7a7bab8c 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1520,8 +1520,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
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


