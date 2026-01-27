Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1B29AAEA;
	Tue, 27 Jan 2026 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547845; cv=none; b=iZmWQJLmwqQvVOnvBrq0fHtmR9SEWY6fG/y830Vx2kS0B8BIpXqdISnBmSsPRDE3Mt2xFSQl66vrA+XEDCH4rpGUqf9QJ0SNIoGBxPVs/Vq5NNimkONNqkYwKffQQoPP7QWgmILC0rxU7K+l6fmucg++/eBo6eboFGRiUveAhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547845; c=relaxed/simple;
	bh=ej605a6zZQZZe+X66wSrKgUfMRVc5y1sH/aNDWf2N4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJ29mgs3HctGtj4uP1Psq85iYuEVkSTY29ni7K45O6X0Gw1OygGaVQbU9aA6uzPWQ8lpDd0ZGonekLUVEoHD5tGC+hD0RcZKB0cv0ztzsuAt8MUJpxEchWCr9DOvcHH5EFOpfVD8QP9wa7QgzKiRHy+cu2DpZ9llV9/YyuCBJq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f25Meu4n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f25Meu4n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0B74C2BC86;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769547845;
	bh=ej605a6zZQZZe+X66wSrKgUfMRVc5y1sH/aNDWf2N4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f25Meu4nr+5YbAu4+qzKe8WUc1TowwvU+G6BBXoUovPmHcU/LPbnZ4tCzhZ5JpnBY
	 V0VpEfsPWUWMOBwAQFmIR6CJqOa4eGzKCljqx2p+3amsci2W9Zf7y6hzE74Jt9/DPJ
	 QGaB7C3kMaL8S8eTL7hT5/yKfREPISNd8O7YtmX4sVz1Zdr+8ij3ftyhwOPB6Ki3N3
	 TV+cLJBOQs1TmsmPWW9MUsVxGJnswb0Bsi0PxMHwBUIbZVVwT7O//+6VYfg7JPJuNV
	 tefCmjWfdAUTsuDzuWRx9MukPNI9VXv4Hsx4xESQVTcu6lmvuEDZdVGGJ/xFB/MygV
	 bDlqbjrhEeVbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95FBD2FED9;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Tue, 27 Jan 2026 21:03:58 +0000
Subject: [PATCH v6 4/7] i2c: xiic: remove duplicate error message
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-i2c-xiic-v6-4-e82e2f6f657c@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769547843; l=855;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=Qad9qP9qV5p3BTdOEhFWMpn1MKAqkOhCBKD6rPKS91w=;
 b=ThzdzrdD6qPaVI7taYTjp+E/HSOKbCSYkPxLortCjGK6CmUoYpzD3fy8kMQzm7PAsyZdrdBhX
 JnuCOlzBG7yBNneuRnAhm1sUftr4ZhPT4xj9Pl26/gyeB02DvulZL3w
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The devm_request_threaded_irq() already prints an error message. Remove
the duplicate.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 973463a3a7f9..95242d39f554 100644
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


