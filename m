Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082443FB074;
	Tue, 30 Jun 2026 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816640; cv=fail; b=VPO6u8SAkLFECwYazYR9GioajcuXOIiJYIcB/84bY/Vdx1Q0ob5LPGXm/L5fR4hxX3sMiOi+Q2vVHXTY6tEAU7rCAAb8PfOOxes+2KpU/xersDOA9sA/IT7xW9/6Q7zcz5xbTsBWjMH4RFvkUWEBOw1zJr3NjSMIZevVg71/dcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816640; c=relaxed/simple;
	bh=DO0Z4PrdqiTkMaBQ1OKoQP9pVmTBCxCVVV+3ymDyWdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AotQw6qswZvss8layQ20pqd+K0mgvB3ntXKhqwJrxupu/hr9Q9mH03c1NpVfXgWZaDBgOqT4+oN6E9bjrDyPMfRAhASku0QpPL/4RM0cHk7V0h4fHXVf9gWs4GLiUHSZEC4DmKUuL8Jcx5Te8WwVNbNXOYZOCWOtIlZeVJMBsu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kFjFIJLT; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kFjFIJLT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQIUB0NCj1Ih6VOVwt+tyqdUuuiYBxaZDDTnwViTKL3S9xELZUwOtJ6aqYPct341dK0s08nvdK0fVIX/leLdOxXPVdtSlIbOXBVNDK81xDX9mKz7hxbpeXb8lBx3Ggl9+NG41HtotgsK+PpizgDDN8pmxLawFDfM+2RxVnAiSrKTWvLDzSFkaWoUELI7NoGi1Q/Lo7PNqmECqXhi2IH8xIajuS2rd/VU12jN144dFWjxKTstk0cNGDWQHGA509E93tZRDNBMocqG8vg9KCaGtdqUocH/Yrimij29TvoS/DpLogD7ld00sdvYuzu9EOFaCKKKRzZwDzHPM6D0NCGu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b3gp3vBXytFCikQG61r0cwymY9KDju36heiIM2wsqE=;
 b=VSHXG2HHN/95/wVnV/9+g5FyGhP3xwW3HhQw5jmGAdF6m4vTPRofDKxAQ89EGRSbFEOElZk48twYNNVvy4EcilHeUD95jgSucn1/8qfqzbjCxYKJNnh/AN1vsUPwBa+IbcYZuxAt5tgCvAaUkUI5rGdZG2RYE+7M5aO9obrgNmgJZhfpuQkz3Blw1wphjHDjTaHdqVbTOsxCAZDtQ72KPos6aS8oNszxqppNDzeYrka6rn/Engl0XGt6bd2F6deecO/8AEsqnjZIBJnJrPIEn+SwQ9XVpETXQyfb6pjZTaTAeogdHLJ+0BxpY1St+QOsvusttL8JkyBA90665hRUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b3gp3vBXytFCikQG61r0cwymY9KDju36heiIM2wsqE=;
 b=kFjFIJLTx76W4cjiZVk07Ju/5vnhIavBrO8V5AEW8DO0AOL4ZhEnqAuS4Cu27fVIDZbLtb9MRvAfZc+JUiCLPGqqxwqvUC9tFLGsIJtT77lPvaqFNhx5iHKzo1ti75J9CF8pIBKzH1tKVUU1RM9IKOnLzEFJvHPNnyxtDmZ3ZLmtgmO9Sha4TchVM5SS/d0VMCm0Ydn4yi1ZfHMvIxPO3o420XKG9+46MZVpEBEfMP0dveRZu9kGDPpvKabQtP4zrEwBY/JxEqzL/DIglCbJJDd781gyajXeuJtSJrGTm6glV1jJ4jqSUUlQ8xCMsmoODL8nD7eGZ8fEZ4Rp1Z2zXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6)
 by GVXPR04MB9901.eurprd04.prod.outlook.com (2603:10a6:150:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:50:30 +0000
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c]) by DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:50:30 +0000
From: carlos.song@oss.nxp.com
To: Frank.Li@nxp.com,
	aisheng.dong@nxp.com,
	andi.shyti@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v5 2/2] i2c: imx-lpi2c: reset controller in probe stage
Date: Tue, 30 Jun 2026 18:52:23 +0800
Message-ID: <20260630105223.3687516-3-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630105223.3687516-1-carlos.song@oss.nxp.com>
References: <20260630105223.3687516-1-carlos.song@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0043.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::19) To DU0PR04MB9466.eurprd04.prod.outlook.com
 (2603:10a6:10:35a::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9466:EE_|GVXPR04MB9901:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c70d397-0905-4da7-bfdc-08ded6956719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|23010399003|366016|11063799006|22082099003|18002099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	rZbm7r+2+0o7aQoQ/PKc+WW7jKxbmIBOUlckp474fVBzeUqE8EBmQZ74e6lP84Leec5MhsPDbzTI3L8KcyWTSoZHo55AVVRhoQ3GgF4kr7xc1N4Qev39/pin2Mx+5qwqOlO40UTbNCnnN/Niy2pJJ0N0wej6FLgRQrDMQ4sI+QkfYWkV+k5a88jiIqa21gT3RKwgy0Z4VVsNadtRAUcnnigMfV0+jFKLhdZNTNaiMVeBmSPhNC4/8EXSUQv3i5C+fDYMEnXMq8B7NlSM0QGYpIdQ1z/yvuFXmo5W2CleqlZ6rlCIU3BvAZoNeUD4oGfE+TpPZKkWrvKaRQV6Zea3Ho7mkJ8KMolk3sTz1nqGkCFnB7sE3DJOh8xeazYfa9fBdpRjekPUqoNuqEDhMbJc7qYjh5MonDcdlClDqfkCGiPNbNwvDwYiNolwE310LTRL9B2ZsN5nXQe5NFHXlOKHUleFHs9gykr4mmcmmsw+z/J83rtopsbsRc6VLciswGOqY8vAljGckvp+dMI3EjfVMWcvs5pD3DulZ3Gqq6NQf0oHN5yz4yLkN8eFSFpx1FtYuq3UhmARu7n1PBvQDvYsSQHUo5xSqDqnosZmn0Fx8Riueh7+wvmAo3itCVAC+K7gSXPbgmMsLQmJyUElJ34JNXX3apBqUDCR7OuNEhn79IQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(23010399003)(366016)(11063799006)(22082099003)(18002099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJnphzDwkXNI/ad6fRT+XyDaSJYlDNAE6PkbX12Sa4qiSffgMsh5hwR2BeCf?=
 =?us-ascii?Q?M2qtTnRo6X/o6FyqpmrSc/sBIDDFQQHq55XKmPQZFpIESJ1hkK6/fN3Nums7?=
 =?us-ascii?Q?OcNgN2pCBRBFtH143BdnGsx+KJtoSLriNkO8lEGR4qCIzOyzL4ZM3ph9uXOj?=
 =?us-ascii?Q?aHd1pRzkwEkdcVljxTRlO9539FxGTqNRR+OQgpJwBNtAlJhKcj2eSj2vIhSD?=
 =?us-ascii?Q?zUn5/fSmPOA9pOkRyq99C1efIocQVfQjOgfibvGj7Bd9Iz9YOP5Emmi7HKsr?=
 =?us-ascii?Q?6UqtGAss/h9DCcqRxFf+kNCp+sSzEEyiA9RSdd1E1K8tYARAExtIAWJQXX5l?=
 =?us-ascii?Q?Qj/AS9LisHpFnnC86U7MWqJvV918QNQDLzRiKlPdC+0Oj9RxRDeuh/oBftbc?=
 =?us-ascii?Q?TkBmvpkgn+rwwK6NIE/HLfL61jrf9wu6PD3lV+BxwSuKQmf+fN5a1DzKbGxq?=
 =?us-ascii?Q?FvGNhWt/Pq9UuldZl2mzT1qR5YJ6WMZsD8T7x6/OTy3QB6pctOXfejaEuP6b?=
 =?us-ascii?Q?rDIjgza97vRwcRbBIh+6oAZRA3K3G7Af1UPr/v3qDzjAKeiWsXf6s8wi1jkx?=
 =?us-ascii?Q?vgtzHmpGw0xTXk6i16gURdiZj6MBzZ4lON7uxF9xy2FQKHRJ7jggACGkUxQ4?=
 =?us-ascii?Q?eH4BndnNZW00BsjWXOMnwy5h86o1sC9wrVGZCQcGWACpZot+6YGqt3J3/5dH?=
 =?us-ascii?Q?kNUvq3g7sZi27JRDlop6bNPANrSDrsumocsZBXJwVng8FJut76e5eE1qMWj4?=
 =?us-ascii?Q?/v5XlMqM1L79avVxbsG6o0AYHbrHMYTPAcowhaeNqV0/MO0s8JNO3hlCof5I?=
 =?us-ascii?Q?9pv4qYjKZfDYnLYBESndAc1iYm7cbFf+aGhicW9kTfXMftuws7EOZLKsgZZC?=
 =?us-ascii?Q?C8dSR2D6o8SGwnf8Bij5U9MO0x3RRn3aMctKeWUFAZBOolvzpzqVCY6cu3fJ?=
 =?us-ascii?Q?E4DII5MDtWqwB8KdVyMATp4Ci1jMbrzVb66HNvPsx57S7zm2NhKMg4cJ1IPS?=
 =?us-ascii?Q?twcwt6Q0AH/m1xDThMcCn1fGkyQVxOEk6JvPJWC765stNBkxwh9VIPKWoELd?=
 =?us-ascii?Q?T7lxKpNGeocGd/OBQoqKolGYmkuWX7GuWWYKwu/Id923HmqqDlZ2bhI4QMKF?=
 =?us-ascii?Q?2zBs4LFHYHIFO02DE0LTuFIldEg5fhFTTOahmVj9wHegaJuvvBueI2jrXM0j?=
 =?us-ascii?Q?utPmmSBZQeWMzeWIm+5+MLsLbxTCHbxUnP28H2zR5VREvOMaoiddAgP6GVcQ?=
 =?us-ascii?Q?Gwa3lpQMgKVKs7yCDV0eC8WW3FxqeWUchgOb+7MFTKabAfbEP/ROoT849/Iu?=
 =?us-ascii?Q?vs6aD/x8BYLduHrt02TzB5yhmYbLQBwjVbxv5INk44F3usn8yOPkJiVUxdzB?=
 =?us-ascii?Q?F4GH1NRHbkKF84bNqUG6KtCsTyLB2UObT2iCInuD7N6W4Vrzislhw0WlCIi/?=
 =?us-ascii?Q?oUE5dbSw9LqXA7YeWFkXke6vqogOuITsK4tzK2Ar97jke6eqyf53IXoglt1P?=
 =?us-ascii?Q?MwmOObyokA5w3i7DFQyib66KINp2xusWyjDVvK42xd8wpunPR3ntZW6TSGPm?=
 =?us-ascii?Q?G4A2k5rBoXW64otP5wLVLoSKyjq8rrSTkFmosM3oe9BC2s57mYL/5cw6ZCJi?=
 =?us-ascii?Q?nCbLEkQRGVY6ILAr0XBY7HnQxY2+vfzsNJhjTA8KRN53HTJkvThZo3AjEZYQ?=
 =?us-ascii?Q?8XbXOjqn196p/i9ZOheZEj3he9/pU4h+nGy1RCcTb+nFek4t8ONR+YNniRv3?=
 =?us-ascii?Q?n7MipD5R07H5MIk/Pe0FR81vj88tc3LRin5BuhuI14V3l2TEqju9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c70d397-0905-4da7-bfdc-08ded6956719
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:50:30.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqJZQZifegVlrvv1oH5zRmhOPP33yJmLtTc1xv6il6ArtH4i8tf2w6ygVW1goJ9gK2n/BIbA7nw1sP/1MDq/DXdM5tzi3JoeJ55mMCJoMGtpCzoJbRqNJq3aLBMCE4cJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9901

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
 drivers/i2c/busses/i2c-imx-lpi2c.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 2dc4331ed796..9fbdce85d7ca 100644
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
 
@@ -1551,6 +1546,22 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
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

