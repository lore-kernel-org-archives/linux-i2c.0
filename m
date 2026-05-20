Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2BB370D44;
	Wed, 20 May 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268502; cv=fail; b=LNNYczlEYdmghYIOyLuHXI6gzzoko/Xo9DnXkqC475COVxLkqIPwUHoGYyGoJ3eL09Guw7/scRhzFnjfFtrKbW1/RKktWg0kY2JbZBAEU8jUoNl/qED9p1fKW+S7lAKylxIkVipY1NSk2eCJLTxs4NK/o+19IlzSUCFAEU4MNgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268502; c=relaxed/simple;
	bh=xYkSLUCTqY0nC/unrf2T3sagdGFXTzuV3zIo90VwzQk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IVjNsnHxTOjRhNg4JJ5GwF3BRG6F65U91yFpvnvHdSGpPkoena21gJLBUOvle6afl+XO1G7HEV0ZYG+qo4PK6ev1N6Gcp6GDeJvqNIfCQASKYYuh7KWwwTY8k3yfKLfihsc2Hskgy4+QSUG8dJffsgg4UN7V/HYmhbi9rNCz4LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=e0HS2T4x; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e0HS2T4x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWdS4YdOKdMTuHwnHZJzMKtTDe5sdtKhmqyUOYiG6PlpkvBw/9K5g1JR1jn9rUe2We5qq6AQM0hqfyP6CYBYYt1mKf9qn/HLXcObMTt+X3vuOSyIy/xBvGjD5qUeoVQk9SgsYqV6iFQiLM5j6pwiw6tlKznEO/vhMNzIxAlrXkxBIZ7XsBAMHjseCjH4i43WnRM0GDTGfzTFQlNNxKSwEXZqOxok9Dq4q3PN7FcXGPungdMfC/drAIH4XMhESkxvk6gD21PNeCE614UQ+kqC0Rc/WaUPZZ81OEvbOePAA0CVY5dF6s2zcrLoGOUeWIGv0AnENo3z8s1nk3eVz5o3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TAnnbkU6v/FIMFN+agEfcUFITZ0lNJKAerEhwwjMl0=;
 b=d+Ml1TGHH+KBGWeZC3PJ5Z680bTqYmFNSvssux5mODjAQn8EI7A5aSfhze2TmZfeeO/kKjdgWRLsvFcTh181zPdGaxj4aHOi2dfqz3if/Z0Sj6DLziZPlEDQZmRwa7AO3HBolasMOOxksBV5xqyjuMKzbhnX/JvNHDrxd3NSHaq6g3fjBoOw+thRXTIGKMLFVD+TQ7LvO3aOsAhgtlBUXQZBQN+M94hiG07/YV6X8ZAtX+ibksVJ70DEAKEGaLQC1FrDtpADgIUQ1YE6ycid7Qg+hY90XckU4ZpBg+O+I2p8Oh5na0uJrL2p3ak50fEpochWvqFHjdHFAPkpuM2aMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TAnnbkU6v/FIMFN+agEfcUFITZ0lNJKAerEhwwjMl0=;
 b=e0HS2T4xmx3GhRcyu4Qvdut/0FMfLiVmTCWNP2ZrS3ubzwp4FNzoWLUArLq4CG7vkaMhbgB2sZCDAX3TGqtU7tZvgLx+5NH3xu2aUGRZthEpYa5TXquF0OwPpYWZPI16V8YJGw/FQdnawGBVCuPExwtvbc4Mq7woZ36xBG3Bk/U+hLkqqMt9c+HLp6UYyJn2V+0t6lOfFDDyeeUXlQvVXuBZWbOOK/0qK5jtf8SJI2fRBPPe9fyzkYmb3WesnirbHbm6a7+caZgf/7uPwcEF2UbtifjA2uPxdw7AoyfTAEKFph14nmtjthrqajBfwF6zFKICXBywlmcOYp6H41oekg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by FRZPR04MB12432.eurprd04.prod.outlook.com (2603:10a6:d10:1ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 09:14:58 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:14:57 +0000
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
Subject: [PATCH v2] i2c: imx-lpi2c: reset controller in probe stage
Date: Wed, 20 May 2026 17:16:57 +0800
Message-ID: <20260520091658.2879993-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::31)
 To AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|FRZPR04MB12432:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b693ff7-3739-4920-2be3-08deb6504351
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|11063799006|18002099003|56012099003|5023799004|38350700014;
X-Microsoft-Antispam-Message-Info:
	zXf3xjqN2CHNsVPZHjt9OVOUl8mgL0C3tAr7+njvnxqNhQlK99f8TTCihFqtFiR6rOe3FZkIsS95tHmutR5Mzwu3ZJEcJmN7AgeO4JtbbGPWOKO0EtOMHapkzPlOyn4l3tTvZK73s9alqme7ly3qLQ1GXbPMxfb5ZHRSe8Bxj5AlGntj9VL4SnstzQrFUYeWkdQa6tYrf5jy1tPc9j533iZ79RFIr623XtFVck6tkCZ280zXzRWqhd+tDuqxxbfKMRUUgedFjVy69tEJdB1v2Z7XD5w/+/1+eCH/MhbrKOoSYBhqEOdm1HzG1uDaMgr1Pd004vtUAMxOdNgrXLsNi4x3cDz4azkpsIm6cHa2OpRLqqgzi2Bb10iVzBY90t9ydIvlEnB2A1hT0rLQ8/G/5Ek90VabvNJVOOfVm4z2+eHEOy7w0sewSzGTyQeSJpN+ijlcsefTE2FbcibYrNcbwyVr2aZFbqJ1L2M00K/XCEFqjB/yDrz0+WwO4Yzi/HG3EriOQTy3VJ9SVrFyp+oQNdlKBTi7h7jzpRelFSWnIOT9rHW32/erievKLbWU891z7lqS+FGq1L2/+uKC4refCIB4E1HM4QlqtNmMC3tsaIBf/yj/CuNBKDA5sAHC5PXHvu4Kqwx6ECt7ugzfP5slBd3yYmMLOxaWRb1tNqm63EvDlCCFn5ZYPYn5Hz1dqouutMY1ZDFP6l0TyOlBuqiZ/vsKbqHbsTWgKOw2M+0eKGsPo6lhU2cjmYRR3+isw2Kr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(11063799006)(18002099003)(56012099003)(5023799004)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CuieKSzhnXICc8nNQ1SLEPSiTlCPYsh3GtA9kBPqotXlRuSfHf5GIVbzaMBT?=
 =?us-ascii?Q?SJxR+Bk4zJpfzjXq2X9KS4kHXQZxaaqW54UOj7RIk2hVUJtwCYBNnoN87L1j?=
 =?us-ascii?Q?3+WZCwidwkqHEi9FR1QjJGLy/IaJZ5OViZt0HzLUPQvZP5zzEkS51bU0hDnU?=
 =?us-ascii?Q?3ETWr1VgKU1fA5c0745NylZTkIncT74qxvNoMgf2nFy62e/Nz9BdD74q8u/4?=
 =?us-ascii?Q?5OVZwrOmN0YdCCuPnRhU/t7EhgXoKLaC/HoEr4pgLUYJpzF3WNeIR1csMZhQ?=
 =?us-ascii?Q?YKHZElKubtf5+r0H3l9/LjFcfarH+UHj6oykvy8tpHbQJNpfkWORg6e+Ao/2?=
 =?us-ascii?Q?+UASKQ4djQThtTtEba7Sn55vCJ1HDQ/lwm2buPiMRHIHVbmCjNmjG7m210bU?=
 =?us-ascii?Q?uXRM3NlTpn43EBx8n1TJGJC9LdpGECmbNV431rb/ITCf/G4lONjAHc5EQMHc?=
 =?us-ascii?Q?5WqvPdueAraV0CyemkgW/8oTTjXG2gB1LzUOwuSfSdCHX6lLsiwldecquwM2?=
 =?us-ascii?Q?M8D3wf1R5H8VoLF1f/xJjF787ygWdjrkOX6P+9PZMAyWfGA8XX8g2xeZouqn?=
 =?us-ascii?Q?POkgF7Y1Vlzk8cymT9MbUxeE2oGvEJWeFFzxOiQpr0c4D2cT0f5QEs96I1R3?=
 =?us-ascii?Q?Ec05aRGKixZYc7k5s/ktsWXqKZY/COhDimCubGOPXO5eM6Ohw8q3vo4eEPfG?=
 =?us-ascii?Q?ti5/k68sfj1dDJTyXmU5qfTfmMkVrXRd7x7PTSsY4R9/+uKIb6FWK+jqBtb0?=
 =?us-ascii?Q?8ccpjiJMR21tzPs07oGckOXYbh5Q8vbriaLwLM+RV6abqV6GJinImj5ELGeq?=
 =?us-ascii?Q?V84rReVa2EfMWBs2tjfEIY2ALLaX1WKaexQxixviwSjU0aDo0aEoYxwMQ0fX?=
 =?us-ascii?Q?z2DFg895dAt54r/H5FqdvwwHZdYlwcnFeOlf2/v2HlxEBI54PgO6ZWzBOuji?=
 =?us-ascii?Q?odjpnRqbzrXn2nY0IWvrWoU9pldeXru/fIpeiMu9MoogoOudrd9jyHwHiWxW?=
 =?us-ascii?Q?QAeqNn1myBkTyxZOHFeNx0c2C67+uhlRu9zHC2CyTKFbumsZwj+2oWBdVstL?=
 =?us-ascii?Q?FTIMJz5Y3TF7CzUoJMqtUyAZgF7XHlmUNJAKbJ67+eCGhE3VBja7LfZYdDhm?=
 =?us-ascii?Q?oVsxXj37xp3k8gklUcpKPvd6vT7QtuaN1YKK6SltD5BzsvnS89AIRqXYGI3I?=
 =?us-ascii?Q?QSVjHW+gSuc7LFaFoBIPImo0CrkIhO/90xfZF5+OJwwxg1D+SUmCgl4USIb9?=
 =?us-ascii?Q?rLPPf+mfiALP0DJ6kCpMY8kTkkqXgsNhl2efY6KyDidu1VhCQIMm0EMPGEfH?=
 =?us-ascii?Q?kQWtl+jiTc1gHqJOMJrB0DZQlfYoe6k4dERYVVV/03veoGUjSUNdh4e4S0KD?=
 =?us-ascii?Q?DgLFKv1PFkARZuQcGhRRJM7dDRbqkQbJ9105fbGOVaGLK6Yksp4Xs5P/Cvpv?=
 =?us-ascii?Q?P0bxd7PbG+FpIy4f12G8iSiquOZllSn0+DCzYsVsmYfvmI4Fe/q9784mECUx?=
 =?us-ascii?Q?IRofdEEhWI322Gq37S8rlUICtFPPPZ8Fji635xqtCkwKKFZOuW2Hcqw0dWo+?=
 =?us-ascii?Q?UExoQAqBirdiNcG65javO9Y9Pvcs9sJmOEhjsPUBIupOIhOfqV7o4e+HJyk0?=
 =?us-ascii?Q?X40k4RgDHe+lKHcKTniYbtsLKuySWrDY6FyN6o3llp4m2DcPwtnNdtvMyCeN?=
 =?us-ascii?Q?NuY1sAT8oRju/L1jnyUWXqM0fz6c44mv4xhXPww5m1+QzLj2FLiG7FpZtrVc?=
 =?us-ascii?Q?FE0Jkle/wQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b693ff7-3739-4920-2be3-08deb6504351
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:14:57.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQ+tzYHWTEYthHgCp1LslKmyOkIRCOHmjxJ6qQWq6jvHUS3HMt93cSlnn4ZIAWAMwfsYn3M3KXL/YLCTb0COiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR04MB12432

From: Carlos Song <carlos.song@nxp.com>

Reset I2C controller in probe stage to avoid unexpected LPI2C controller
state left from previous stages and hang system boot.

Per the LPI2C reference manual, section 7.1.4 "Controller Control (MCR)",
the RST bit (bit 1) description states:

  "The reset takes effect immediately and remains asserted until negated
  by software. There is no minimum delay required before clearing the
  software reset."

Therefore, it is safe to write 0 to MCR immediately after asserting the
RST bit without any additional delay.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for v2:
  - Jump to rpm_disable instread of returning directly if the IRQ request
    fails
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 01ee38131ef2..6e298424de5e 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1499,11 +1499,6 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	if (ret)
 		lpi2c_imx->bitrate = I2C_MAX_STANDARD_MODE_FREQ;
 
-	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
-			       pdev->name, lpi2c_imx);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "can't claim irq %d\n", lpi2c_imx->irq);
-
 	i2c_set_adapdata(&lpi2c_imx->adapter, lpi2c_imx);
 	platform_set_drvdata(pdev, lpi2c_imx);
 
@@ -1535,10 +1530,25 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	/*
+	 * Reset all internal controller logic and registers to avoid effects of previous status
+	 * The reset takes effect immediately and there is no minimum delay required before
+	 * clearing the software reset.
+	 */
+	writel(MCR_RST, lpi2c_imx->base + LPI2C_MCR);
+	writel(0, lpi2c_imx->base + LPI2C_MCR);
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
-- 
2.43.0

