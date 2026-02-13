Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAC20459A;
	Fri, 13 Feb 2026 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941722; cv=none; b=egWodNfchPLPhZqvFjZetdl/lmIMXW+5G20ezJmVIcE15EHLrg6xscpCCPoGpDBnkAHOVtux2rbka4gF7W2lkxOKyKUSFPvp3ud53q6CA0Qv1wpTSg8oSG9y0tgWimPY8n0eNM46VekJqYK7n3hGDQU73TWzkQyIAkZmKNRG72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941722; c=relaxed/simple;
	bh=jRtEYRL116cS46+BRRnEAwVlx/TCGH4biEvlH/E3jhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ho1EvvvFZYBAqpWOUj61pORdZUy6rOcJN688QGYUDAtskeajtjhvMUI0xRC8UWmq2yo9KqM5svpDLQ8FCHYHBKFDRM/XyPcAt3NyM+TeMNSyyTvgGAJ9gJTeZe/0JRV2UNOQ/l9sbe6M44zmjEKqlK7kQnYPmTajA9y/mJxHp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R79jZ199; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R79jZ199"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96067C19422;
	Fri, 13 Feb 2026 00:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770941722;
	bh=jRtEYRL116cS46+BRRnEAwVlx/TCGH4biEvlH/E3jhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R79jZ199R60NrZW/zFkZAmS7hgm1H/VaM9Uqy8kJVfgCVWeLjKDVUJjSgZUbCYqjE
	 BYl6jMcqQ3n00NWP3Ni8h2NIiHOi1iTRUfU5lKz79xfnd4UfscsHZTnYlDszY23pdQ
	 6+yHN/x+5OeQJSsTrhOETHYpz+chEnf9E7h4ak0fk3bM7wRcqGGHIH72BfIUPPzyqC
	 PrXQbQQTZT22gMM+c7C5bcB57c0GpuA8KnDDpgDTjMCHTGfo3aRT8XOisuXpzVFXUU
	 YjuISzPLa/If29oyOO9DPBmgW//YN1ear6bevVRVXJZyi4jNOiwQj7DiTfkD+Z9aQo
	 yJxs3rSnaYjeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABF1EEA853;
	Fri, 13 Feb 2026 00:15:22 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 13 Feb 2026 00:15:17 +0000
Subject: [PATCH v11 2/7] i2c: xiic: remove duplicate error message
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-i2c-xiic-v11-2-5d18aea11bde@nexthop.ai>
References: <20260213-i2c-xiic-v11-0-5d18aea11bde@nexthop.ai>
In-Reply-To: <20260213-i2c-xiic-v11-0-5d18aea11bde@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, Andrew Lunn <andrew@lunn.ch>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770941721; l=1019;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=RRuL/bQeZiBpUR1djYETZjT+qDSOpjJwtLxb+GfrByQ=;
 b=tQZ8gIzWOuUdSWIA2TzaWKq9q69SdwtT0IEDY3cSzazRtZNGQE5W0tD8wE+gG42Jcc1okv+2z
 f9xApkRqye+BeZjV3kayfunZwOXR8d9hnDM1aZc+oWIOaKD36ktZbJ5
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 65aa280f6fd9..99286af2a0d7 100644
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


