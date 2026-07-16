Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A133909B5;
	Thu, 16 Jul 2026 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186300; cv=fail; b=Z28c33YGxCyB4t6FjDXFHZSYTvJj3hAgwa5cRA023dMyqxBu2/Ui8cTtrjTIEJpRn+yryP0Jfv1VfqamC4WrsCP4dIihitjKJuPsn5FeAMLlvYVR2VgJkZKm3nWBoRswD8pwrFHw+7nSDJp8EyYSjltFO+hk6s+9xwaiPcGHafg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186300; c=relaxed/simple;
	bh=VrwHavVDu7IMrVvIGeTlcm1XLy7En/BZ/OyuVMBFYVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCeUzjtlxd/LcwSuMyZP6x6gTAYOhE0AaUasP0N1LCm6QAsXFe4+EI4GEznsbnRNAC0F0pfD5yrusaAbfgIIMVSyTHoCnAbS7KwIvbCpHKkPm/2W/Bb/KOF/ztLSqnlEW+UMWT342P/U6yM8iM8tb94owguYfNC3wumI4lwFgWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ht5+qjfI; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ht5+qjfI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5/61NyW8ZPuh9EpQSRV1l3g7oZFadkBUTr0HV5AKAfomFEi16j4W4a+t/lkh8n7pOqftZ3Ak5+E1pu9Oh2fNkfP3os+XaPlU0248rfRDWR509pEGw6fKMRCt34BSGvcfBbKS1SmowlqnZ0v0ToKF/gT1cYAVHUGexTPwV3WqclT8D/NfibuSE9dRgsOgw7W2YnU7zvcuIj5cNk89BN81Z/6HG0olEKqsHO17KptO+GxaoLjPZTxVkAm10Or926VJ0Oez9XyecgqgY7NFi1phV9TgPG+gOuzvYwi8oLz5+elATn0UpJYOCvUqp4b5zT5pP0374Eikz67RM1g3BE7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk8mDjk2OOwnJN1V+9T06rk8raxOjnHeGmWCH4/JLuo=;
 b=QOWHBj9AXyyjlRiq7k6b7xyLH//YW/QUZoeElQeh5Sd81/YvYoeab6JaWBoHEvp/06wOucT3wg45pEyQY5+VXRRvhULY2tBomR+Epft3ltfID3+4m8rCtH5ac4CkEbXm8G+vMp1Jyzjt/qbvi/GhM9GvxP+Y9p2kJ86C1a2P07GTNrloK1lcJIPqwuA4ANhteKhl9EO9afuiHqSklpMx43YzXGjKp26XP0T718v/c4tAEkBd09mdcY4shuYUVJeSv1wxEDmJ4lT/hXS+CptQTlaZ2PW4bDkbp11f3o/4Y3EA7g32lxru74Z+CDEhL0j5OkKD+fn5wulNwuHZyERH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk8mDjk2OOwnJN1V+9T06rk8raxOjnHeGmWCH4/JLuo=;
 b=Ht5+qjfIqOqYMJUHNGJHmT+vxrX++Hw4ZbqQaRG8uGTSYy8NQ0T5DTluZjJgXohpvSLo5PJUSOBJdTZ3QgQsT51qIxzol+577kft8KH7jv4MKu4dbcjQnzzZdselCVm2/n8GLrlbxtztnGPx1nwvIWdOIZXDXe0Xt867eVFZmIv9AHY8fP3pr7l5oSF0joe/rVBmhtuO2XvY4GJVI2PMBzWlR2BMOzjshr/o3IGElClL5CLJnhwm7M5DYt7WkwmrfPjbF8klX8d6cUcqxMFu676jlcTfaGMaFQgr6COjBvEltPV0/azN34kaBf1I8LjY/ka7w9Po7QHswYCORq+EdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6)
 by AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Thu, 16 Jul
 2026 07:18:10 +0000
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c]) by DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 07:18:10 +0000
From: carlos.song@oss.nxp.com
To: Markus.Elfring@web.de,
	aisheng.dong@nxp.com,
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
Subject: [PATCH v6 2/2] i2c: imx-lpi2c: reset controller in probe stage
Date: Thu, 16 Jul 2026 15:19:57 +0800
Message-ID: <20260716071957.2670263-3-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716071957.2670263-1-carlos.song@oss.nxp.com>
References: <20260716071957.2670263-1-carlos.song@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To DU0PR04MB9466.eurprd04.prod.outlook.com
 (2603:10a6:10:35a::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9466:EE_|AMBPR04MB12334:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ed26eb-cf8a-403e-ea5a-08dee30a6446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|11063799006|5023799004|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Y1u8eLdZ50/mcyqjRG2d63PzFE4burXwJhWxw59H41dLoYfbBi8ZTuDygusP59mChwPeKrZrqZ0qpGyL/gLQ7w1oGBFdCNN86BMRfwjva41JWLMlks+3ySgMTnmLlk2QWwVMzVyl8RstRuQxYxruLailqu1dJHhuftERprjgbEylbpedosCAjKSwZg5Gf+M8c6GgOvPHvbnV/2KU9iidsDMaB2d7ajO9FVtOpkXpgs4CrLJryZi6jAYadvmMX5eSys/+Knlam0nCJcFEVWNW/aHHZifjNIcglNBkNiL8MypMk98rNN0cLppZ2rUGfVWrCiHjJ9/vYTYq6ErmtvIhDTFEtMWtmJR/8zN35Zz3IBArWNFWu5LE/M8kbO2pu1HJZh9l548pG/zPIel55iLFfNAQWirxPttyd0bLzJBWFfUKfwP8xkXKZeAK6kTUP5KiG0GIA3YYEJ2Ru8fbRGBZTB+AF65hVyqF6Ls8xwsRQgVSTGi2RiB2LvtLIYwZYpb2qemIwp78NoZzqF9pjNPuxjKTzz9hk7x2tZspgtMj9jqVAtFqNWCwtkDbH377RRhWDOhWjc4DRxWo9zDSXWCiKGF3IelgeQeJJNHDoprlaImtoURV04nAOHlrq11T4Ylz1APTsQTlIe67mRvflx2MdQ0oaBz8lEtf/vTOba2NrSk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1mKJwakYmbur0BhQzVELMYHvYOeH9/k2Br4DGgWmbY8YU84pWRJ1/YkU8rD5?=
 =?us-ascii?Q?yshMRCoznb0UqoyjMT35g9SSaPbB5UTIclBVQQqrLZO8IDvKw7AvZRQkZWRp?=
 =?us-ascii?Q?P240nog11mEmX8MTW2AhIGF90u27UOgP+9Iqy2I8rp7+Cawqr/sPUKESuVEV?=
 =?us-ascii?Q?DtlrYZ6FclYASdipQ1YWxA6qrF/rGEYfj53bUcl7f3RWinzCm7DQqD9mWB4I?=
 =?us-ascii?Q?iOLFLP+XWQgjn86p9ty5hS5wy8MjW4La+6P7OTFdK71K7DQ/NosFUSJNcOQR?=
 =?us-ascii?Q?9D90F+XQvfi9Z1aPV3IPF/j3HR7TsKnsc3Ch1sBN7rmpEC2S45wS06bHBt+t?=
 =?us-ascii?Q?4E3L3Z1JGghP5YLuTmLRu6k5VN/FiBpY38jQ6Ye22Y3hnO+4X7Lzjsps4Kn3?=
 =?us-ascii?Q?Z+oE38NISeVRxcTeI+ILXWu8DrWKhpjNAW4WN8OMPcDk3RDPPENubRozLJFt?=
 =?us-ascii?Q?iU7JtHlcbUxDW67FZ6a05zoLg6/erQTe2S/WpiWGezku27rRLXXGm4F/zLvl?=
 =?us-ascii?Q?ZhNKWq9O6XAsZJdZtRdJ0TOeccvP1V7iBX4psSAI9LAsu1lT6gtub7iSIBbc?=
 =?us-ascii?Q?i3wId6fP1N2HMAfaccIdMrmq6krrJEuCteOYjY8XCYfJQcooQKpvLiqGxLEX?=
 =?us-ascii?Q?3wIeCouE6joN/MXZPFi0PYzHJ9r3uVYIFGLCl7Kj5yGwuNKvVSzeVNvzmYJV?=
 =?us-ascii?Q?qy1Tz2ISot8gj0Oc3Tqlz4wGuZrFkrh0eA1F0ovZm93UgWz0Ab0vpTgb5CcV?=
 =?us-ascii?Q?I7YQFq+9B1nDZOiGN2Lpr1pisFq/yFF4T9e9H6Tpw9lhE5u8xbqSoUzK4N7J?=
 =?us-ascii?Q?XPnZ8xOqRERSNwBY/I2dwh0pD3fjYKEcAywOj82bafeDeurg9El+dLKAAqCX?=
 =?us-ascii?Q?75aSpm2KkMzCSLfdIDMWJ1r33sxGURttxV8YEICYGUjm+Zl+4QCxDLWQS3e4?=
 =?us-ascii?Q?G2x4i672mqGs0TSjkyhQWm+1IXLUi/eONRBNIDDVhJCS5Q0gwtWcmNZKSIee?=
 =?us-ascii?Q?kdPuDuOaTxWfcy9JeyikioZUawTWVESzuMpVfXAgj/qdIovuZ6WguV0GMUXk?=
 =?us-ascii?Q?lsi5Gz3HzvHtA3Llgju/M+tJ3pf18g87b0++E9cgDUJ9oXt0RckLn7UjVrZC?=
 =?us-ascii?Q?btpR7w+MXJqLOqmxG2nSKtf5lqcaahcg4sDnaCF2Uk19AwLqZ1cnEDVX+XZ/?=
 =?us-ascii?Q?1YnnVYRsARWIE27Zq8Z4CyQn/NZ63vD5ErEwarzxj4VxhohSi5YkjFT5jBDn?=
 =?us-ascii?Q?2fgUfl3JAIqRmi87RrEPDf42xw1gkWoQsD1QNkTPn3WM7EcZNwtx/D1Lj3+r?=
 =?us-ascii?Q?Sd4NIJQWCJ/pWIrDn2rxRhuD/BUadUuPn/ePb6xCvh9kMsBdJdBIo2+yxjHt?=
 =?us-ascii?Q?+2Z26RlgQ0FOQWRnGdaMbaBe4iBXLKZCVk+2EoaAgXOq8DcyyINs69SQb21b?=
 =?us-ascii?Q?DksETOfwTQsZvWbQrZ6J+8hHvJ/lnbtWuFNN1VTIiF5g77EiWAlh2DlQ1ftJ?=
 =?us-ascii?Q?ECUUeIoJNYzY4dhNmY8Bt5GUTfGOu6HTVFm7yFU/vaaWQTJrdtrmiKaWmaoq?=
 =?us-ascii?Q?MmCXGaub+h8Gvf5FkAOmT9JDoLqcYFENk3SJciybSvb5hfxZVffIGf+4NdL/?=
 =?us-ascii?Q?L+iJVgxMnaPIplxsaxMwGU4CI1w7GeQFIviXr7BauigdovYSHR8jDusvWTD4?=
 =?us-ascii?Q?b1sjq0+gRLjb2Z0vhf0sChdX2KT6qPVBuasZJ4KRjNRtyufKJv7GTmHPo7J8?=
 =?us-ascii?Q?GJeSlw9fNE4F2pfxgpsg/gf//z8U5QqUhDCOTBkIum01lCimy6iA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ed26eb-cf8a-403e-ea5a-08dee30a6446
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:18:10.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGvs/iZuNuW4obl4LEJZ25pWMX5j1S9uR56voEicFM/Iw8T8GHmVXhES6ssj20z/jlAxplxLVEbmhGd5sASWKq6HIriNyg1l34c85sTR0ciG5PJEtTFaYDZv42QVOIY8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12334

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 615d9f7f1147..cfc0d108d3c4 100644
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
-- 
2.43.0

