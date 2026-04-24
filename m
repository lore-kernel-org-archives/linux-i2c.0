Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C13CEBA6
	for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034239; cv=none; b=iHMexJW1J7c6U2OA8J7L+HB1MTOImTlSNk3VVH7pSwlSU3lHkUeSaAUMkhnt1Kvf1187mDd63tRqwmQ4bdYNn67JoySLVu5YGD0FOCpComEYQxhipm1sISpQE+bH2UKfpIMEv6Z09A+uQeQylvuKaBN1bdf/txQ22e7zTIeCFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034239; c=relaxed/simple;
	bh=WNOfl9TMJAgdQRS+Wl9stY3RrXYZyI6/gxecvU1FULI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJMvIEF3pNAqXVGxiy4vmKHx7sKvwc/TzGrDCYdHqo6LHdodOWKvww7W0B7MOoPDPX8j8wzwrMnx2eBs3x5AwnTxO8dOLwRBtUMJSJYUco3VaVuMfCYDliSEifJ+i0SjSphh4dkqIvg4AqM8r12jIHDl3ffHQiqPYbMIW2pU3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=t/y1yHCB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t/y1yHCB"
Received: from [127.0.1.1] (chfd-03-b2-v4wan-176392-cust229.vm15.cable.virginm.net [82.19.20.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 86EDD19A8;
	Fri, 24 Apr 2026 14:35:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1777034124;
	bh=WNOfl9TMJAgdQRS+Wl9stY3RrXYZyI6/gxecvU1FULI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t/y1yHCBELV34W5QxOrNf+WxZZnZbLlYZrKOZ1YknODDpEpAxEXqKSt98NYNAPY6V
	 PdhF60jzifFQU+6IXfE+gFthQ8dNmdVixKK0W5T/IY1FFA/UO18d0rGnN6rdvT3v+3
	 R1n+YjQ7u96RGL+t/afHfiDTGnKc4a1cjLZaANO8=
From: Daniel Scally <dan.scally@ideasonboard.com>
Date: Fri, 24 Apr 2026 13:36:47 +0100
Subject: [PATCH v2 2/2] i2c: imx: Retry failed transfers 3 times
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-i2c-imx-fixes-v2-2-34fb9504aaeb@ideasonboard.com>
References: <20260424-i2c-imx-fixes-v2-0-34fb9504aaeb@ideasonboard.com>
In-Reply-To: <20260424-i2c-imx-fixes-v2-0-34fb9504aaeb@ideasonboard.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Gao Pan <b54642@freescale.com>, Fugang Duan <B38611@freescale.com>, 
 Wolfram Sang <wsa@kernel.org>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Daniel Scally <dan.scally@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=941;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=WNOfl9TMJAgdQRS+Wl9stY3RrXYZyI6/gxecvU1FULI=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBp62PtXN02sS6E4D45jdY5YmHKbzszWjA9vdl+1
 JErMzAIA8OJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCaetj7QAKCRDISVd6bEV1
 MtNrD/9Lgn0kR7oa/zXMFfKfupm9ABSsN51NPAQpnkTCY2La2De4R7O0JnAAS7lH6R78erTaq6U
 5pfv/DTr+bnBTZp5NxmkhDGWYrq+F+Ri4r2bjsfZZgAadxjfqO+MtK+Y+MAkaKiDsF2M1w/jhPe
 +f9rvykIGB9dBRKvLjYSO0OWnJkZ1SqSrIJPZUiM6grOpIsJvaWEv3UXVG3Dq/DpzWBbG71ey7u
 fgt1rpOR1vRSF94lT07m5gT6BPPz+OBjAV08evmR+lotp8GLVQbDwBZskHC4SkRzocHEULuJ29+
 /EgkQQFSgwL6lGirCb4GBI2e91HiQ6yQ3SnK8P2cGtBjhNkEgbolqP3X22ty+72eV3zOSPQRmeM
 E/MSTXfMcrIIShVRErM962IlJqMaPvV9lDwBPu9vOtEF6ksZtDKgXrKkP/iNdxiSnNFynAfbGmK
 tXJY5IfIrms5qK11OoUHkjTZQKyIxk3T82Xcz5ynfeegOpbAh8sRFowZIoUdCIUMZB/RyCu4ExX
 SJGOcYfW1OTi2FiC+BYONVMcO+xKqlcOef+QXfSamnmBLY913sGGnXLx8F7b4MnivaphOnyTtdu
 XrDvlSZvbKyqhtb1pZj3qPbpKPQvbMxtHQAHrke58VKybqXEqOFPm83MsbRg5vUkBznsrKLF7bJ
 Cvp4jwLqwaq5ntw==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

Set the retries member of the i2c_adapter to 3, which will cause the
i2c-core code to retry transfers that lose arbitration 3 times before
giving up.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index b68a0f7105682006bbcfee52891c9a9c2d8c009e..e70e64cc633ff1e13dc61920c0c7960fb6a02622 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1749,6 +1749,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.dev.parent	= &pdev->dev;
 	i2c_imx->adapter.nr		= pdev->id;
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
+	i2c_imx->adapter.retries	= 3;
 	i2c_imx->base			= base;
 	ACPI_COMPANION_SET(&i2c_imx->adapter.dev, ACPI_COMPANION(&pdev->dev));
 

-- 
2.43.0

