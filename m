Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78843C7DE0
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229683; cv=none; b=c/KamQ1PBJNsi3vheJb1nkc+oJaMOBAUTIJi41YDvBhOxRH3XqyYdS5mZU28gkZMJdvJmMVfQYTVr4G3ACtmD3VpsP1GhUpxKTP6ZiZZQUtpfeePKF+twM8Qp5o/aflA1Q2h2D+bZv1zVXCoQbOdXEyN6duqWCDqRI6/XqeYkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229683; c=relaxed/simple;
	bh=ofUAbbHRyPHF2+WZMsyv4sIjIxWIo36tBn4si/5B2oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JnnEZ6RUMgUWlRiLfLGMuxX0jLWPvbzoaxlSQ0yXC/I2KyKiTfWMyFZOWMz/f6mp34GEl3u22z/3XZ+RwKAHNm2j478oXF6omdtH7g54eYuAYHiolgN9/28zWQx/darqo3q4nh97hIaM+ZRZQizANP0NnK07aymQ3ymGOYEqHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FKE1l2s4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FKE1l2s4"
Received: from [127.0.1.1] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C42E882A;
	Wed, 11 Mar 2026 12:46:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773229611;
	bh=ofUAbbHRyPHF2+WZMsyv4sIjIxWIo36tBn4si/5B2oM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FKE1l2s4Of5i0HqjjK8dCromhjXVGu3GCseyNJOf+dZBoc+BHnwqxlcihU9m62kXm
	 dVcWJY4C429LGjMCg1S+EoBw0t9ks9pt1Gzl/e4bW0tdVPHKOUA6rDtpzBsnlk6wg5
	 1eLJwdCAzJBlAmTacYN57BUnG9nVVP8PsP8H7gXA=
From: Daniel Scally <dan.scally@ideasonboard.com>
Date: Wed, 11 Mar 2026 11:47:44 +0000
Subject: [PATCH 2/2] i2c: imx: Retry failed transfers 3 times
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-i2c-imx-fixes-v1-2-e625034d8202@ideasonboard.com>
References: <20260311-i2c-imx-fixes-v1-0-e625034d8202@ideasonboard.com>
In-Reply-To: <20260311-i2c-imx-fixes-v1-0-e625034d8202@ideasonboard.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Daniel Scally <dan.scally@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=899;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=ofUAbbHRyPHF2+WZMsyv4sIjIxWIo36tBn4si/5B2oM=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBpsVZsuZ91wkDZMsDS7+YdrSbe3ydk0V4fQTsFG
 an/LR2EMguJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCabFWbAAKCRDISVd6bEV1
 MtE7D/wKSfPxBRaS79FrKe7SK3ziz80lAe/tsm2IRlziuO+Sc9Yd61+5gREcH4wVpk3mc03JSR7
 0+/KMpkRryzCD/MjQeLKGRxuZLmrsFguCItFzlIUtzTKeAOUnCKDtfLL4XQutfMZ40g1C0trGP4
 kGP59Vc/cv73SQ7+6pxpGCzMPMiXs8Q6MJLm7GfrUIGCDqEiKPH6EQWU0lFZkuQEP83sNHZCx5K
 0gCRHlSctwMeQeiNErAw6NOlTC11xw9zF5ku/+HcYcd371R8fZEM5mbbazGpMdC4R42SSYEw9Ti
 vnoqasFP198wsFsfu/VjljpaOIxmkJe5DNR4H1TSq6YM0mVuzMA/X9cuuZlnBAWbG8Y4dd0jrUs
 XraLh/Av61DXCol201fEHXg8/XfTRndarVzP3wNn/2y4Ok9c2LmnWDoudPoYUW0DZ0CoRq79Z0F
 rhKzaRGXi23r07k7b40PxIkaQ4D/t3xGuL2U91bSiatwrtYseG1dKBeNSLs3t3kS41L9pOwGamz
 qNQQp14oQDVlyscZ+F6vZ1iMJgdO/P/Bkc9oKJ5m/CN/Id2QennMIxdrwizMufwc061w6d98vlK
 dVdudAd1yJmS/qhhfc3I86AuMuCWUZyBkD8MC1rf3h00aFjiY3T7841z9RHtDHxUv5rpF7VrIgJ
 uHg+a0eUj624aRA==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

Set the retries member of the i2c_adapter to 3, which will cause the
i2c-core code to retry transfers that lose arbitration 3 times before
giving up.

Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ed2316ab1ba8b6261dabe8af4377136a002e2f0b..fc807b4c19137b9451796d009094b26da59e8799 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1736,6 +1736,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.dev.parent	= &pdev->dev;
 	i2c_imx->adapter.nr		= pdev->id;
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
+	i2c_imx->adapter.retries	= 3;
 	i2c_imx->base			= base;
 	ACPI_COMPANION_SET(&i2c_imx->adapter.dev, ACPI_COMPANION(&pdev->dev));
 

-- 
2.43.0

