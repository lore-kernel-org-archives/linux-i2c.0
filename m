Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED5214A64;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770188526; cv=none; b=EJB1zkuYqgv6SOr/th/4NtkBiCk2BWZ5Y8/FsVFD4KiOEMBzpq1cOC+YOfHx3qWApptE0vOTAnY4l+f0A0g49eoeWIRaCrVuHEnMuTNNWoK53CcyrXMT9zDtzNNw2yqsILENxGqctmkL+IxRITdaNlAoG4jWgnvi7LM+BmNXOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770188526; c=relaxed/simple;
	bh=9NOBASfi7anGmRe6t5aBWM/Ma9uXjL5J+KNCF/CduQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKR0qz4fW5aI2Uvunr4jiOVGX2mPqX8Uo/azG24LJFZU/hD1sBCPGteUszOMQ11+/AfpJvW6EzVQW68S2kjTp1NR/OS9QCo7wTLOzG2Wgtrrl9kYLfx+ZX9wWrH2/rc7S+Gxvrx2E7aSMd72DJiD22ZngQ3dZIBdpPyvb1DUfjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsWNPmDR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsWNPmDR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 082DCC4CEF7;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770188526;
	bh=9NOBASfi7anGmRe6t5aBWM/Ma9uXjL5J+KNCF/CduQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jsWNPmDRZ85oWbZXtLagXOGu5HAkQ6Mgvjg3HHv++seCo5dJYY7KZnH3CEj6jW0FZ
	 HEn25k25i7sOZHP2ZJi6ABrnxhUIix2n+75cQwnRQRWFGNpmZQSLQaYj2qNz/bbMTX
	 EZs4G58Gu7wGKeShyDnE0/mwnlk/e8jN1wrhqmSuqZL+nl9k5ZLG1MCf/HLagsRIIX
	 PiwQs7xwz0YQFIGg9ihXaFR5e6pqiWpYCA1ICsyG2iguhUL7AY85d3n9tFawo2OMpd
	 8eqg2RJWlhWwhXM7cJU3U4ckTYx+dxyVNt3btBjhnnimMUjl2VyJgLCxTpBd5t21CM
	 Uu2ohpTShJA6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8560E83046;
	Wed,  4 Feb 2026 07:02:05 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Wed, 04 Feb 2026 07:01:59 +0000
Subject: [PATCH v10 2/7] i2c: xiic: remove duplicate error message
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-i2c-xiic-v10-2-c2b996425235@nexthop.ai>
References: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
In-Reply-To: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770188524; l=958;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=KsvKdIRhjvHhQgBTA+p4IEJ0A4qmuGyZ80lYOv0Q75M=;
 b=ufqp1GSog2x+XC55gJykBp5HNgxRWON+z4LqmAJybnGnJH1/Q/fAsVXn5SVvn5oIVCBZZnKrN
 jkxUwQ/API9Cw4Bxm9qLa1wSdiieH3WbQyY+EABioxMiTEYwy/ikiTR
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The devm_request_threaded_irq() already prints an error message. Remove
the duplicate.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 16ff83fe280b..4cb7c40fb565 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1491,11 +1491,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					xiic_process, IRQF_ONESHOT,
 					pdev->name, i2c);
-
-	if (ret < 0) {
-		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	i2c->singlemaster =
 		of_property_read_bool(pdev->dev.of_node, "single-master");

-- 
2.52.0


