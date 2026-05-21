Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4463A48EF;
	Thu, 21 May 2026 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359609; cv=fail; b=quqDhfFcxRyXN305Wf94/uNlW/twXvc3bL0dM5NR0bL+B8W6kBoZY/Res7yr6W0+LccRj/tFMxlJSkTNEcX30TYLM0WzBYaolEhw3nh58HudkVmoKuA/qS7a6XhCIv7FqEfFQP/VvUR4eA0+/t4dWpmk+nnBtkW0zWP3f58REQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359609; c=relaxed/simple;
	bh=N4axBs2cOGetfxpqNTuhpDNTgEjxUeETSI3Hmlfk09I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VBk7NyiTk6uhcglW0Cdruskh80D0OHJV1QZBxUh89j7v3+EJjK4lzXF53HHv/HLYui9Wd1eIoFZtElJKlKb10Phmi6SPttIUsFQNdm88NZ3CG5N5JH82tF/NhPzmJEhbO/LAlcMjYiKSS8+VMiZ4ugoLLYUQ5mDk5LN2PmJxx0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=o6ZCzuCU; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o6ZCzuCU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrWNzkBTWxuM5HnOPruzaoQK16FTX73TDRcXnxGz7Z+DiNxazvSEM2C7mqsAgdzy2vuXgyHNS8NarMp1YYyMDY4qD9caWqMF+ciNBkAX9c0C1Zu8c2nfbicQ44HKwbdvotz67Hw9FHr0S0psjn/UCExTiRzFUdq2PQSwUhb/uybYv/Nk7Q7A0WSSu5qu4UKJyAMa6HFnDB0dg2sOeNiywK4RDFG24hpXXYApA+OP4Nng9rkSE6W5s4wP8CPCZf2u8HoPyd+kdEhyOqWT9WT+P6R7/gTG71+tEYLqfeb+8lfbrOnuJidbnuZgnLEhHD0Lsq7qBRsPt0OzIGoVoP2xkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOGE6zhRTTR14pvYDP87dc47s+UlFQNegSFiXp3IUE0=;
 b=qPP717DzcuWvWAux+vLU1IzNKaGjHeAhIU0exAViSss4rPJHOcKfUQH5RyZ0E5K2L8C4lzM1JUJWyKb8Y+N90bdS/p1V5PEYQLtinK3r6nGOVLEspUtIu5Cn3y7yTxmjCDBe/UTj09YknSWnAEyks20xa7R6M3lRGsSi9s8LdeG0wWvh6v9rSboJgO6vc8ygJ7tpqwA7gru2UcvwrIY4roOhHjedjxDHv5ZYOYQBlAZkgGtYwh6ojdPci039NIrAD2T1E75IN9huQVls/XSvJcXHKfaMRUJEgwFgxrQFEntcASDsJ9qeOLG6tS8+uYUXF/0QnqUEkuQOW/l29mKgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOGE6zhRTTR14pvYDP87dc47s+UlFQNegSFiXp3IUE0=;
 b=o6ZCzuCUk0TMd8icagEatZfcMpwvZ+m421BcOeSB4ENQ/w3U6k90DV7mJ3FjjTZUeKijkCqm1djN5+H1SdYuxEIbspk5vLicilMr48/yKKaCKSSXDC+nzDgvsjYSehQ/eufHpSn3oKCE7Y3X9c+XvM6Gi7dNZuV/YByW2AaGMaOqAPXCGMf40RF2OGSZCM3EdpUKVLsgxuxlZdHK0JmH+tYmMhZIS9t6Vmuz18Fatp1/Y7wxhbPK19AGchwLhdc0CeLMhMQ9VDfuXCvYfn3Q/A67+92eS4lz6eJK/Fwg4MAjnG8heT1PrYWQ/mGYbIVRHboWkARhTs/bxNVqSnet9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by GV4PR04MB11306.eurprd04.prod.outlook.com (2603:10a6:150:297::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 10:33:23 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 10:33:23 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
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
Subject: [PATCH v3] i2c: imx-lpi2c: reset controller in probe stage
Date: Thu, 21 May 2026 18:35:30 +0800
Message-ID: <20260521103530.2988866-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::7) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|GV4PR04MB11306:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aca6123-94f5-4154-c09d-08deb7246215
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|18002099003|56012099003|38350700014|11063799006|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info:
	craZcoHCvXROHPaEdGsknlNij3MRld5mLRMRgEaIyIXp8HKKr9L2fCzrChXJRFUmxz+Dvz9ovIEO2ztqeUqkd3gTSA/GIluNAzpSZ2F0xXtALU1wOL8cUhWakbeN/74Hcj3Kh2+tYLS/2aiix40bTNzzLOLeOjajCF7I73LJoQHKmdAECBKXKJ1xxxEIPLTN+dzidSqyHht8IcCwSxtyl/Rzb/2fCKfHlMbzzZPjvPYuYhd/0QELAS3+jgQorNnHx7uMQAzUGPOYE/UL5rPKjwm2IdWNTv9CnVYhWAQxlAI1UaKXJb4a4SIkhzqqnDbDazsAqBmhAVW5RD7cFpIZVL3Bakrp91hmCTpXTF8SRZ0axJ0QVDqPLg/an8PhXw4yHX1WNQkLGN23ntSAqPVx/Ts2p/eVltocrMVTqdM5whB+zGXauQuGx6dy94BQeYzLr225Jr/y/kciAPAIaGR5wkx0DpuvJXRcXD3KGmHcw4M/Bx0n8ptuQxh4U1A1MaYudk0LPNnbfAduPd/SD5CZ2N9b6HmiHenTVeqzffDP/CDsUU28YDy0C/YTwKGyXGfkoJxyV/fRuWGXTEGYKNUn20MsV+X3TVMr9a0n/Mf8vEizeOfl5UdL+zgf1FVPp9/rn1kMsOlEmtyHcaKY/F5iigBtus+qoAxaJR2+5Q0+Af7vd+PY33SxoBuhlRqz7ADQDFEi0s7pLHUv2D2An1MKCoTT1Bk5yzOZgTv+oF9i6NYHHL60mhUEcXpo4MPJBWp4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(18002099003)(56012099003)(38350700014)(11063799006)(6133799003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGVJy1pbd5YzMm6cHTwO6CUC7XwdNZ8tjOv3KYQjwDeVyicsdn2p1tW7YKW5?=
 =?us-ascii?Q?7xjlFd/ioT/L3fMJ/igq/Ic3o+Lc3GMpWrjvXq7/wr5nex+suewKE6d05RXQ?=
 =?us-ascii?Q?TiZ8wL7/QFQ1jMEF5OcLptTSeFEspQ2zKMyoqTmpLfP23Rlqx6jQkxHIYd0/?=
 =?us-ascii?Q?DOHp7I/U40n0eu6Vyj9H1/ZT935LaDe5L63VFzEAiQfnGN2ZH5FNB/Ol8m1Q?=
 =?us-ascii?Q?fTS6hapdS0sSE2KHDq7uJASOdo4FS3Hkovdvc6YvoGG8QSmz9/WASh8OFm37?=
 =?us-ascii?Q?BMMMHLd4ZPIFWHnBfQohVmtQUVCLvCiyacnZUGcw/0lUS65m9K0R3EEs9yev?=
 =?us-ascii?Q?rQID3d44lZeyp6lyWmkmzmjd5LnARgI0eHBOnVSEeSgGj5dFutajwzFVWnYX?=
 =?us-ascii?Q?+B5JGFxfFucDKNgoWluN1/7ZT7brBlQ9VjSQazWYPOKkdZNlK561bZPSsidy?=
 =?us-ascii?Q?rrRffckiiKngrSX2XFLvF+3tJso6aIaEF0dfWbPn4JmSuVmF/h7/uBs91AsS?=
 =?us-ascii?Q?1H7/JXz16ZjRxQwa4OsMeLT9zRqt4wlq6rebwwfu7fD2cDGKo48ps4pyXaLs?=
 =?us-ascii?Q?IKTnbZJBQQyBwMJH6qRr0zY223UYzJ/+nk25mFDTmc0grqi3OzZlvzUC0w+i?=
 =?us-ascii?Q?e+RlQra+TDSEMSxvE9AOPtwVK+3Z7gfiNvzMZXwxNPQxSXUyFwnE+pYL2m1j?=
 =?us-ascii?Q?FtVeaF54D6m7rXLCBITi9fE3nj/jkRgHCsQ3ijbT3ybOMoLdjw51Q0EHSPuv?=
 =?us-ascii?Q?eZtZ8IfyqmZ3Q7hNa8GXwTJ5tNs/fZC8MJ31SM5CvD6ckB0wL+FDeUTb2AOS?=
 =?us-ascii?Q?rhMZdQpZxMn3tL4MsZVmuNjHc9B4S5eq2pe+QeQRIIE52BDAV6O1xKj2QNDg?=
 =?us-ascii?Q?hYX9Diu2QtbgI9+txTnNkOknZGF7NoV6FDXjAHq1dOpRlW9cfmAP1rDteJ/m?=
 =?us-ascii?Q?NPdCTGe+PE82GSARQXH2v7BE59jJRoyYTsov98O3iTQ4e0ghMfzIh9rMxvxH?=
 =?us-ascii?Q?doO99wy+UzaC+RoJ624ROD32cmALElKOJSG4Eoj7SdkzO18W+8FIdAUorOZF?=
 =?us-ascii?Q?71S4qLigoD+eX0Xp6pRpIYSK0LMv0+GREufBcoOcLGnatNirmyjGL5UyVUEv?=
 =?us-ascii?Q?8SiByp5NNn0U0hqItGiglr9qxSU6/0cvL/ke4FA802Fc5rKHXaQ19mIdzzz5?=
 =?us-ascii?Q?uesrO7ODubSq/H8cGNdfdNgdL9R6bKNNjJ6jSJQ/xq2iyZoD5Dk2VarWRK/2?=
 =?us-ascii?Q?RwEKp69Y9O/ADVqpzhjn1kODYrh6vSOZk9Gut0np6YmDXSb2zZN05mL0q+kU?=
 =?us-ascii?Q?QOwGSaP2L/kjlznfLQc8Y2cUQCmTtz2AIz65sWdgesyOpvaoUQwxciD5oq5g?=
 =?us-ascii?Q?4AwlqoS56wfTKEqZz3OIx1tIzY/i518puOvoh+3v6W/pLQW72LjIRPRA0EZy?=
 =?us-ascii?Q?ngQ6+wblEZAP5qYBNUzqktyaLJqTD3/YecVr4mhrgvUbsbt3RibpmpgAORro?=
 =?us-ascii?Q?gHuXj81NJImZxfEb0RnO0X3iGLYaEpFh9OP4cYSOYcgb+dC2hRx/aku3dPLU?=
 =?us-ascii?Q?zFFpouL7PFcXTo5cDDo0h/fS8mViTvYen1pSj85w1V83uoGKWAlWbh1NkiNS?=
 =?us-ascii?Q?r9OZCCypMsdK4D+FpGGSN2AYTZrwSfKsgf5qKBRHeNjKJLvZcTLHnc7Tltop?=
 =?us-ascii?Q?pCkWdWIaepX1FNpZI5NY9Pd1ZTgppidjDWLzlFDvv3AfSp7rChb/qFmr6zKF?=
 =?us-ascii?Q?hHGXly98tQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aca6123-94f5-4154-c09d-08deb7246215
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 10:33:23.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH+Xi+dy209jWAbWIel0U1WanG/o0CEPIzCPQzIIRdAlhewdbpBYOnJixRrpOTkb2MxD+xvb1cT0PW8jw84qTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11306

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
Change for v3:
  - Reset the Target logic via LPI2C_SCR.
  - Replacing pm_runtime_put_sync() with pm_runtime_disable() +
    pm_runtime_set_suspended() + pm_runtime_put_noidle() to avoid
    triggering the suspend callback, and explicitly calling
    clk_bulk_disable_unprepare() for clock cleanup.
  - Add new error path free_irq and clk_disable to cover more
    complete error recovery.
  - Remake commit log adding SCR RST section.
Change for v2:
  - Jump to rpm_disable instread of returning directly if the IRQ request
    fails
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 52 +++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index e6c24a9d934d..4929f85ab485 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1510,11 +1510,6 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	if (ret)
 		lpi2c_imx->bitrate = I2C_MAX_STANDARD_MODE_FREQ;
 
-	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
-			       pdev->name, lpi2c_imx);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "can't claim irq %d\n", lpi2c_imx->irq);
-
 	i2c_set_adapdata(&lpi2c_imx->adapter, lpi2c_imx);
 	platform_set_drvdata(pdev, lpi2c_imx);
 
@@ -1527,14 +1522,18 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	 * each transfer
 	 */
 	ret = devm_clk_rate_exclusive_get(&pdev->dev, lpi2c_imx->clks[0].clk);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "can't lock I2C peripheral clock rate\n");
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret,
+			      "can't lock I2C peripheral clock rate\n");
+		goto clk_disable;
+	}
 
 	lpi2c_imx->rate_per = clk_get_rate(lpi2c_imx->clks[0].clk);
-	if (!lpi2c_imx->rate_per)
-		return dev_err_probe(&pdev->dev, -EINVAL,
-				     "can't get I2C peripheral clock rate\n");
+	if (!lpi2c_imx->rate_per) {
+		ret = dev_err_probe(&pdev->dev, -EINVAL,
+				    "can't get I2C peripheral clock rate\n");
+		goto clk_disable;
+	}
 
 	if (lpi2c_imx->hwdata->need_prepare_unprepare_clk)
 		pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_LONG_TIMEOUT_MS);
@@ -1546,27 +1545,43 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	/*
+	 * Reset all internal controller logic and registers to avoid effects of previous status
+	 * Reset both Master and Target logic to prevent interrupt storms
+	 */
+	writel(MCR_RST, lpi2c_imx->base + LPI2C_MCR);
+	writel(SCR_RST, lpi2c_imx->base + LPI2C_SCR);
+	writel(0, lpi2c_imx->base + LPI2C_MCR);
+	writel(0, lpi2c_imx->base + LPI2C_SCR);
+
 	temp = readl(lpi2c_imx->base + LPI2C_PARAM);
 	lpi2c_imx->txfifosize = 1 << (temp & 0x0f);
 	lpi2c_imx->rxfifosize = 1 << ((temp >> 8) & 0x0f);
 
+	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
+			       pdev->name, lpi2c_imx);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "can't claim irq %d\n", lpi2c_imx->irq);
+		goto rpm_disable;
+	}
+
 	/* Init optional bus recovery function */
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
 
@@ -1574,10 +1589,17 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 
 	return 0;
 
+free_irq:
+	devm_free_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx);
+
 rpm_disable:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+clk_disable:
+	clk_bulk_disable_unprepare(lpi2c_imx->num_clks, lpi2c_imx->clks);
 
 	return ret;
 }
-- 
2.43.0

