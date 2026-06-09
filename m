Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE83EF65B;
	Tue,  9 Jun 2026 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998581; cv=fail; b=OKb2r2mAnQ+PmjxVP/EdwdbZNIcEVuMdUfJ4tX6G25rQlWl+MCpNSekS6a7GoKp3oTPV/CtDudyzYB6BU0BK5O1dM6Gt/y/6kmHdeHMXSmk2cAAlRiJpSOJ8XiLK0+ItP/m5xJGZI/hUTdRUDE0ZMRg4Ulegw7e/Vzm7j2ZUToU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998581; c=relaxed/simple;
	bh=XUgO6GCEcMzgB9QdBp/KF+OZgoaf2DISHs2ROGxIgAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMWfHL4kGNyq717wkj5/k6HPqVGL94o+YPAnDkzUvTt0Ch8T4LNmQYVUocmGO0+vfcwzzSLUhHt0cWRpEcc0ja29oyb+QqYuDtT9ZO7eCEciGtk/dmhiL9LzP0NFWI0xxH8VZjB28/edE5UZGhUVQTByz74KUfDIQimnGIKIHyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B2JmQsT7; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B2JmQsT7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXb5Lof7Bs2d0c8OVXEijz6YywV758WCvRbRt5cp6KK0pf2haUiTINGjF3six+Ezx7C3hsGLysKGbECl/xa6iKZLi2V5lCi474UsiBQPeJISdNMr4NdDeIg8ESSJPcg60GqRf8EbUAW5IRwmm9UWYQxUB2NWwDCru4u0N3iwBJxR+nZwrZfzV5eTpKujY2wCu+d68WF/t2deoEHdLGuSZANpQvBqwQj+3Ew8GdIX1jA2gPG5r5N175oxxiMMcqx4p/GnFPNdInQh0romvX4EmIAjUkkbG9Eoe6yifxHPlycrK77pJJdMOGQJPmE9x/09UNf9JK4QFV5aOAlS4QXcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unxXFS3IMUVAeMhsUZWA10uSxPsWcIQ1okZQURK4Ru0=;
 b=hmdMVSUj4hI33tu1B2ZpMj0My1CJuPM8puPb4WB+6evzm/hDUz/7/nHGShzfvlR8AGB7i/OTq6KfywD6BUQpabAu33iMIrESPQWrfCIVlq+UpTLKiYfK9dX6W4UU9sE9Q84zYXONBPR+eB6heTC1bpQM/sdDdRPCh16VP1QMwOfgqUI5tKeWVnkOEUL0YPyuDniOjNi7hGFXAL3AkX3gjKFBX9zSvEEZKkaV8Kz9KbSb91gZzE2/yFyAG1Ra9GRJU1XyYqNJhi0UbcqD5yvNdDxj1Hf4ztnoT9Iopf7PJCnlkL+aJ5QGDT1g9Bgdui9XWttTIKOvDF+FP0RijSCKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unxXFS3IMUVAeMhsUZWA10uSxPsWcIQ1okZQURK4Ru0=;
 b=B2JmQsT772HhtaE0FTUC2JtoJEDiu7W3Lzk8hzNPmCNJpoXaAkPlGtrEEYRD/0Ee4kB9S3bCf+7VTsL2Tz4BYy+vTb63jiqpW7i1am8JLkLKvFSXD0118u+BuOZ4wrYVJHIq4jsxq25swqJwQMOCSszrIIaJ+hSDiJ+sGGoZp4sV99VxiqHBSwUPfTeP33vim17Ndy+NTa1Zrv6b7XH+ilreMOPx2EJLcKQja+wH6NNGcg8hWFptBY7sE6JbHeCz+EIIj85v1AXw60tT1X0x82jeWWTwj/NNOybDSHylW8AiOvlyBaEAqNIytAYiSycjFHbqc95Gw7vB30TX+uSCZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 09:49:35 +0000
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c]) by DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 09:49:35 +0000
From: carlos.song@oss.nxp.com
To: aisheng.dong@nxp.com,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v4 2/2] i2c: imx-lpi2c: reset controller in probe stage
Date: Tue,  9 Jun 2026 17:51:19 +0800
Message-ID: <20260609095119.924029-3-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609095119.924029-1-carlos.song@oss.nxp.com>
References: <20260609095119.924029-1-carlos.song@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:295::10) To DU0PR04MB9466.eurprd04.prod.outlook.com
 (2603:10a6:10:35a::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9466:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 8641b8df-5d5d-4b74-a11a-08dec60c69c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|18002099003|22082099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	gYgqw4JS5rHPpCaVNKn771mkYKfxhR6HRD8NxuDL3xSX7UJJT4ZUxopSyJ6PWi6o+BXAUKqTiU49kGowjIOAFn4nfjM4ke+rQdAR3MlqLRYIvXLIXGTrCyOuAB9cDUYAHyTKlt6g6pxJoxXMQ6O9RLA7hbYflwQHQuHGOmI/lIvEO8UTf5py82rz57ks32b7lMtfyh6wHVDzan/vBvqbadMz2FtVOu08j8fvy9B748jfx3qwTC1RBRLIjmtZouNLeieQ4P8NoqW7uRACFSZ2/8GoUGJr7RE0azaG+R/jkrGveifcdPo/IKSh1nB/kujkNKC2obwTIwrvR2bza38DfIWsylDUS7Z67Eku2xgzKVpCLwrIqz/UAIN52OOItnioze+lNfAsBlq5rL5DRxoq5UcQSgyHDDmEkFpHPJoxDgYObqpTvEex7/530pgQIjiRgOWHT1/wyB9GmbZ5ExnYwzS2lT4rVIr+piWiYOPWoj9XxYr85kVFnrmU5diyGP6yTpt7j5/q8GcFOr+CcL8JHQX6HbipCLJOyoIu678xo0R6V3N7SknUlfSonWAdtROZjZ/MZ++MaahWpErW+Bmt9trMEaPhZKhbtu7S/P9JsGFLDJSiGoxdkObvWpXTwbDo6mJoVjAYA6rfBWUgy90IG7r7xGrMW91P/uSFA56c0y9GuWqgonh4z+KLEKth6yNl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0cv6OXf8gZddrNncOSIUBisgTiNf2pnXVrMmC8IobEesOH7aEftsm5s8bxRL?=
 =?us-ascii?Q?GwXcqXD/rHotLiUArqHxM8H90bwS1f8SIKK2at9DRZUmA1P/NWj2hGjmFLYz?=
 =?us-ascii?Q?znzi9H4MTPlUYK/v2MULXPjNd15qCcos47kNTFk8hPRVCzTethdtiNEosC/p?=
 =?us-ascii?Q?tF8nJOyriCnorNBJnqEeFZ5gZJiVC+NRcRmMCA8le95BxPxGfGj9PH/rOTAz?=
 =?us-ascii?Q?ivoY47XXkAaItxx6AiBM6iFr6PAhHEYQEqNKH33hLmlarYc6yZuCNbt39rKg?=
 =?us-ascii?Q?xyWMYtgd5eHFJFTvKI0KwbGdlVK95ik+nGzbEZxrYDzMrew8sgPQAVn33MBH?=
 =?us-ascii?Q?VkGd2Ospdq1XaWE9pmr+jQxadLhwM4JfxvdPsAPuQD7RhrWPYBQxrTchdH3j?=
 =?us-ascii?Q?29s07AZ6mpGvP4Hbo4e6Z69zZSuW+0xdLpe8EYtuSyd3bCcMUxadu4wgXKyX?=
 =?us-ascii?Q?BP2XUDn97LGbPwhnI7VFYnTWwJeJrqBft98J/U3ZIYa7WAfWBaG6a8oHOEhG?=
 =?us-ascii?Q?16Gs2JmAWaiKixXIU+KkUJT2OVWSSw1XSFAQH3G+WJMiqBychCDC8ucKzmiG?=
 =?us-ascii?Q?BaxLw+W2xcXol02MMS0nSSOEdli1wgkhFcTdQSATRuI8vniR8rVQSaKPxS6t?=
 =?us-ascii?Q?NO4QWtMUBoa6PfnwgmbW4oySitB71gNEUYcBGT4PDudZtFhsnMtF+ZIgZ8wa?=
 =?us-ascii?Q?NFCKuJPYFazrold4Vp1Wc6tegqW1Xzfev4Gmg4QEcCW4BZJwnwjnqxw5g0Aq?=
 =?us-ascii?Q?IU6TrJqzOXZBb3DI9SpJqADOVvR4wVXhpfdLRsFNP0zZ6uT6avu6XdyctuGW?=
 =?us-ascii?Q?TFb0N4bPjc39nSHAlsvrr+5/GTTbJg8/ovWYEm6QhIkxBDqfdFrN3EVLj/uc?=
 =?us-ascii?Q?MhLPRd3h2V2zFqvijrhSOskkql8Qc9lhRTCD4uNGlj/4e5QP9HpBFY/LaAhQ?=
 =?us-ascii?Q?HP8RlihEOZuSR9WFIK1gaVI7Oh9+5nQ9wKo+Pzu2P0oAXnPi8scL9fewtftb?=
 =?us-ascii?Q?IL8vKPUSymi8ReWClKGWr+cbyOPi8rDXIlkmIDkvYKGE0Jnyp6wWnylCgjhx?=
 =?us-ascii?Q?A71QFxM7AVBjpSS2FNgm/PrYjSkKF0KaIXAxHvW7dlig9Sr+Wg6YlRu1troJ?=
 =?us-ascii?Q?AHbmy4dIM9mZKTYs31EQPtJz7HxH9LQw/3hioI+Z4yPCARyfkSOQ1u9VsSNQ?=
 =?us-ascii?Q?WBKcr1oCs9E66SQM7fpftTRMu5YtA+YCXNlKqUz+PNQikNrB3xpuWy9ryGJ3?=
 =?us-ascii?Q?SqY2boYMGV6tEzYbsHri4dG2p9KUG6qzxsf3PxvypHu0FLSUN1kR0jUcD69/?=
 =?us-ascii?Q?pnLX1zLAQeFZI+UXAYQdnm+tHo7eQVcWECqQ5r0OSTSIn2bYW9WJoKwRX1DG?=
 =?us-ascii?Q?4WvC57f+eD31f/fG1URFnenWQL0f1sVVxW2MA7DQX5LE9ti2lEb20IiwTWI2?=
 =?us-ascii?Q?/TftPpW0Z/pu7LHI4t53V7aLBu99uu6PDVcrC6S0HHpL9MODWDmtsJyDH5Oj?=
 =?us-ascii?Q?SnlER9YXVUCUMwytX40Bgi8zqIeyTLpovpxpdVcc89CrM8ov/A8fb+JjS3rs?=
 =?us-ascii?Q?GIKdlHI88o+5gTTnCVCUf82bbbuOef3/cescNPGFDxclV2aJuF0bCidb1Ztb?=
 =?us-ascii?Q?cB5lNsmpXm3OIp/5ZtD6hr4MLlQqh9SCb1ofGYorL+zyNU7xJxhn0yp+hJxi?=
 =?us-ascii?Q?CCcgw4rJAmhB6cv/T5/YU4Icf9QQOXLnXge4NDTGYWf64Lo3D6rXRjNyB+Jw?=
 =?us-ascii?Q?+IPxkfvTPBV/PgRBmBvJdh56V/b08b5n0B82/MFnbz8ev+dCuj9L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8641b8df-5d5d-4b74-a11a-08dec60c69c8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:49:35.1275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjV5sK2Kx5/iQKgpt6omihSiC202y5qSkhtsYuks3CBoly/P3HxO1On8Yy73dVnZLi/wB8tA5/V9O0RBybNyzimdYL00KrTMc0UxO0Xx4BmksVVoiUrNKiGb+pBitAD7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

From: Carlos Song <carlos.song@nxp.com>

Reset I2C controller in probe stage to avoid unexpected LPI2C controller
state left from previous stages and hang system boot.

Per the LPI2C reference manual, section 7.1.4 "Controller Control (MCR)"
and 7.1.20 Target Control (SCR), the RST bit (bit 1) description states:

  "The reset takes effect immediately and remains asserted until negated
  by software. There is no minimum delay required before clearing the
  software reset."

Therefore, it is safe to write 0 to MCR and SCR immediately after
asserting the RST bit without any additional delay.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 33 ++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index fbb9c0b0a99c..93f263bf27b2 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1510,17 +1510,12 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	if (ret)
 		lpi2c_imx->bitrate = I2C_MAX_STANDARD_MODE_FREQ;
 
-	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
-			       pdev->name, lpi2c_imx);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "can't claim irq %d\n", lpi2c_imx->irq);
-
 	i2c_set_adapdata(&lpi2c_imx->adapter, lpi2c_imx);
 	platform_set_drvdata(pdev, lpi2c_imx);
 
 	ret = clk_bulk_prepare_enable(lpi2c_imx->num_clks, lpi2c_imx->clks);
 	if (ret)
-		goto free_irq;
+		return dev_err_probe(&pdev->dev, ret, "can't get LPI2C clock\n");
 
 	/*
 	 * Lock the parent clock rate to avoid getting parent clock upon
@@ -1550,6 +1545,22 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	/*
+	 * Reset all internal controller registers of both Master and Target
+	 * to avoid effects of previous status.
+	 */
+	writel(MCR_RST, lpi2c_imx->base + LPI2C_MCR);
+	writel(SCR_RST, lpi2c_imx->base + LPI2C_SCR);
+	writel(0, lpi2c_imx->base + LPI2C_MCR);
+	writel(0, lpi2c_imx->base + LPI2C_SCR);
+
+	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
+			       pdev->name, lpi2c_imx);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "can't claim irq %d\n", lpi2c_imx->irq);
+		goto rpm_disable;
+	}
+
 	temp = readl(lpi2c_imx->base + LPI2C_PARAM);
 	lpi2c_imx->txfifosize = 1 << (temp & 0x0f);
 	lpi2c_imx->rxfifosize = 1 << ((temp >> 8) & 0x0f);
@@ -1558,19 +1569,19 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	ret = lpi2c_imx_init_recovery_info(lpi2c_imx, pdev);
 	/* Give it another chance if pinctrl used is not ready yet */
 	if (ret == -EPROBE_DEFER)
-		goto rpm_disable;
+		goto free_irq;
 
 	/* Init DMA */
 	ret = lpi2c_dma_init(&pdev->dev, phy_addr);
 	if (ret) {
 		if (ret == -EPROBE_DEFER)
-			goto rpm_disable;
+			goto free_irq;
 		dev_info(&pdev->dev, "use pio mode\n");
 	}
 
 	ret = i2c_add_adapter(&lpi2c_imx->adapter);
 	if (ret)
-		goto rpm_disable;
+		goto free_irq;
 
 	pm_runtime_put_autosuspend(&pdev->dev);
 
@@ -1578,6 +1589,8 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 
 	return 0;
 
+free_irq:
+	devm_free_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx);
 rpm_disable:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -1585,8 +1598,6 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 clk_disable:
 	clk_bulk_disable_unprepare(lpi2c_imx->num_clks, lpi2c_imx->clks);
-free_irq:
-	devm_free_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx);
 
 	return ret;
 }
-- 
2.43.0

