Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D5F29BDB0;
	Tue, 27 Jan 2026 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547845; cv=none; b=EWpYnCcXvSKZ1N7L+kcYV3ebWs6vIgbCFxwanJ0pBqiS03buiF78yLb4cPnUK73gtZjWVA75MGoy8yToGOXyfjACBi9MCRb4cY4XQeZZGEsIyJWhVhZMtyTYG2d4zf9EpHnqRQL//8eUXMLvmdMRXihd0o5676EFRX1gD8ov97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547845; c=relaxed/simple;
	bh=eZPY6w3BtKVgEbAI10QJgfb0N2mPTbsUo8V2C9rWc5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESRKGUcmtqBFMRY9HwH+7AT2lqn/KzZCbVkt1hS1Qbxg4yYgd5Rlz0bhclvtGF7aHk8hpmgWg933/u0ymuNmZ9gE11EmJUwBavcdtiII7QQPJ+D5WWKWQdTbsAPmlwje10Qk2d/7lRk4+JxxSRuGSXqtIgGJbzCmlEgAtNUOKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwbcEu6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwbcEu6G"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29053C2BC9E;
	Tue, 27 Jan 2026 21:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769547845;
	bh=eZPY6w3BtKVgEbAI10QJgfb0N2mPTbsUo8V2C9rWc5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fwbcEu6GBHbP4+8pyD1D3gPJ65gHZgC8DHwPIAtWGR0QSlU/eD3/xOsBvQxhhGMnm
	 EFRWYvb5LGp3cVSWUrvSE2sjOUKmIcKZDtqFT9d4ixF0SfgiUlEKuV8+eVDRAA+YTw
	 A19LMbOhuimjn5Vq1UrbBHPQ3w0IrOeAD9jhxL4teteKT54110XhnW+6MwOTaQfjeJ
	 Zhemqhieirl/AOP9zp7miI5q59eowHOmNzzOwia4UxrLUgo5TvJUARxtsCXALX+Gcc
	 XI1hE5x8ir8/Rw4JYjdlc14e3uqXesVKjpL2dpfUT1tFoEDKWBiZIUZKuS8DGi1QqR
	 4jjHZvxguR42A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5B6D2FEE4;
	Tue, 27 Jan 2026 21:04:05 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Tue, 27 Jan 2026 21:04:01 +0000
Subject: [PATCH v6 7/7] i2c xiic: cosmetic: use resource format specifier
 in debug log
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-i2c-xiic-v6-7-e82e2f6f657c@nexthop.ai>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
In-Reply-To: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769547844; l=796;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=J/OOC66/6Sfkv45zHVfl6G0fbEDSnRoOH90Sob9a/M4=;
 b=z1VOfeSfINJ+Sstk8oOzEEhkqTiF6gN4ilY61XZnUqvtY+JdfITXn0FrwNvt7w5NXQLoEP46x
 gWmqDw/yDK5CjuOytBGF9I+DiHWVDhrQtAD84j7KCtB7BKY/N1qjOQ1
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
index 9b763d8dbe84..75b43f469861 100644
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


