Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EC37A854;
	Mon,  3 Aug 2026 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727519; cv=fail; b=NCQxE/3W7R7ExY3MQOCyCP4FsnlAGwHgocJaIRLNza+7YZHGha1/mPNooDogrJRvg7HBoL4hd5PgaXZ17d02g+FVcXQT7opXVCfCJjb6a35q8GAYPJHw72aO4u7V727rLNwIHlilqLOSlomYCiSxqaWiUQY8iY991edeeo7JBAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727519; c=relaxed/simple;
	bh=lopcnmaHVG3hWiVohC9h+AHVKQasPeHWLzKTzd0/A8w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rb3RhMALV+MRcyLWXP7nJMnsK81M0/mxs0cl6jRUsGLbbwEnqL1tty+ZIGhE1tazFjGi2K3nCgD5fcuDY7WeZKV1Qv1mjFM0YM+AHXGi6ELBUEZiJLuZlbik27DnRY3UYUEa6UxiRgx0Vm9/D6wX46VkiIWdd0vAg2CpsUNQYjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=N5R7IcA8; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N5R7IcA8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL6ec8nxBlJ+ObpGviriJRG65yDgXsOvx/QK0KM4Kgbpi+ITz/hE3Bsm/HOJBP00X9OmIwClsnYr1pC79ybji+xTYTptrq1Mjbd4ZtouBGqyfNxNn9YxsiIW/f9b2Lz71ENiuJeRfj5rfQx1PBqLxNP2egG7oFY97fvdu3g/iSoQ9ca8v3QlU0w04Dvkkz7BiUMuXpOe4we6Ow045B0zUS0oFMaui+SEboHZxttSjHdTY9m0RvYVwQlG3bePwJnxkb6ScR9q3ztkWNswc2lxM0hqd+pL76Enm1HYxDBFo5M1YGALW5gTrzdNQk+pWRiHhi8JjHZMnHbgLIB+TGy/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEiwEuL4+GN4IRv7M5hZmeQdKXFVv2aifz7RscTTYpU=;
 b=ZvPcM6arH/G+T9gnXRTZ/obbwprUbaEeGXde5Hey3uG8QGtRIFFAB8UQmdaqjiNZjUS9g70uz26lPOuo5G8kec44pPtqMQ1s9V4L82X/yicSX9fzXLwCWjHrpI97TjjWOCbVMw3vObqy+0Pqu6l0IAZeHSNouKVkFRrsR8sjt+5lDkUADmAa3iT2C8R4pwRhCNQjzDMjgB9jj2i0p5r5pi0okCufAsTqW7++zYkpAwOOPPkMAMFWSFPQI0qJ5uWWnYXPvVaR4XhP7DRSSzTXm9hvK+/m3mlC7Y8Yjod98KzlvqDoSACye+5FGwYqmLMmZvdFbwvyo+MRXvPmmxq0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEiwEuL4+GN4IRv7M5hZmeQdKXFVv2aifz7RscTTYpU=;
 b=N5R7IcA8CQLFSq4WQALoyyuYBq/Ki1BMCb0ZvrMBlRBaDJJaQT/D0S987RK3WIu6hQsJGuKtj1XUd2sTrLtzQ5VydsD/aPqUQ5ogeEskPYwn6g6A33UXRRemZ8ZHFIBFTpN+LfqHGmbux6TXhMflBCZzJyN84selBSu2vjGSmU2Z9Jdrd8JZz35iuaweIkyfh7byFWB0JLJEoAhThM26CU7eQOa8EcSQzBiFEbR1/ZiZtuuPm2Td1GPjNyuqP0QYIPcWJuZL1vOFaXPcmaXrzzK46IJwDj5ZNMO4B6UjESHmpVWZ4dPSQODFK6w8GUvuqlD1NJgvE56UTA5nruPKDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9462.eurprd04.prod.outlook.com (2603:10a6:102:2aa::9)
 by GVXPR04MB10850.eurprd04.prod.outlook.com (2603:10a6:150:216::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 03:25:05 +0000
Received: from PA4PR04MB9462.eurprd04.prod.outlook.com
 ([fe80::9feb:f56:a1df:51fa]) by PA4PR04MB9462.eurprd04.prod.outlook.com
 ([fe80::9feb:f56:a1df:51fa%6]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 03:25:05 +0000
From: carlos.song@oss.nxp.com
To: aisheng.dong@nxp.com,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: imx-lpi2c: avoid accessing target registers on master-only controllers
Date: Mon,  3 Aug 2026 11:27:05 +0800
Message-ID: <20260803032705.2250373-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0028.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::13) To PA4PR04MB9462.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::9)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9462:EE_|GVXPR04MB10850:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf00c2e-5cc2-4687-b69d-08def10ecfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|376014|1800799024|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	vtV5z0wH1GgB2/gV8Bn8aa59xp9knp+e1s+46ajdh58NOwjSSWZZAl1dqSjaIZzZV6JeMucIf8PoB3hevns3uMcbTzQYLpLM4ZbxwVnyzKQOZmyAZezUuQbKd/xUauKkmWk+u4N1YIdAL9C51A9aETBmB1wkwS9lXVgdPUZN+N4IecOT3jW+hdlHIfpbbRvQJQ0MAfU24cv8dLJWxZOLw3W4Ku98LvNCVBq+SKe5+p525YY8vZYxrTVsI5zaf3aHyeJxbK7/ZuZk0hZ95XuuIGxCkUx8bok5afvIteOIc0hVDZdDyVR+dAtPcPA2+aRZY53f0F+C3pkXfvgBxry7p7QDLC3CCBEJg3PJD0iSGpdZGIvbxEwBQiHSvkY6XJjBYTV4tk1lALI5ystdkjJpFozzfSmaxfW7w8s4xzabXKGa/RFc+CfoN/z5dOOmW7tMQqVk/4/coxb8wC4aluMGYuVmvMgQGJH/257RSlTwcGw1/Wjp2VR7aL+B/hxOWI1rOlmId9/yk2rys5KTvFY3MMC91ewAqEKfoweetWTyqxrlYfPnEAeO2nrKMxI4u5AdzOf4PzhDuI3RTR2/i2jsBw+vGrj3yz6YC+dNzBYsGaUXbaWTbF26biEZXNvINr68o1T6pTY93GVMLWEEAvg53aOvBRHI/tPmkRm50BihZwU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9462.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NLzmpilqIQF674flrCMQHPcwydSnkUUtJRC5qJtEA9rvYmPnJvcjPPp3Yn7j?=
 =?us-ascii?Q?NayqoFnnqtzp2o0zUzrvFD6ORJWx6VzDFUeIydckKLUocjk+xYpCFMs7l8Ca?=
 =?us-ascii?Q?Ai0SFavW0xhLWI1VDpEsuChS6x0rA2Ju8FFlAlGbj4wxOfy0Ei5OE+cD2o5/?=
 =?us-ascii?Q?LCrnUaKavV2oP2N6Fh25wD1dTlsakXoF86NEizjrVm/pj1l83WO1ltHYklS0?=
 =?us-ascii?Q?TV9MESjD6pWEPPMsJLIsHJ7BqKVla9Wy1qc7PL0MfQy+382X2x6xtQ1ndRZh?=
 =?us-ascii?Q?u8CIQ0LC8KEnl/Tiw/PGCC2z0h/cUumMg0J1ivRh47oJpMIJauF3X5En63e0?=
 =?us-ascii?Q?bB7evdwikPQwkmNc4Soe57UyFCJIM+cPC+PxuP6W+SzJr4djOU8LQiMVlxQy?=
 =?us-ascii?Q?uFaagA7J82xanR9I+osMosOlSXviJgHc0mHzR86GgZhGvhGHRUMxxZC5kqwB?=
 =?us-ascii?Q?+nYjOKfFr6SbfHbUDoyKglsDJoe4dcSZu9WJXkJePINEOmx3F01laER3P/Wq?=
 =?us-ascii?Q?XcrR9f5aEjKRmdMj7zDpkG1sPAGDwwJ6N4GTGtzyQbvyfWaOpEcNATkNiK3V?=
 =?us-ascii?Q?aJw+Ju4uPFHDS+QE4ollJgM+uPbqfyws0R9VfNuAaJRFxc3XUpKMxMR7nDBd?=
 =?us-ascii?Q?GXoYO52YxLkgaa3X5DLfcmt4735tfUZ6+q2o0Gqvg+45tRmqiyvQSJT1Uuti?=
 =?us-ascii?Q?bEjPTgNriIrbjlUvK1QPIjMnWRshdWvlKMxVce3DBYNAORJe1MrRZ1/m/cOh?=
 =?us-ascii?Q?/xPHdC1zHXbtIhRbIK6srIqMdwI3EOq9nQv0xTnuhUOcmps7M5mL6oTeNh7Q?=
 =?us-ascii?Q?w6xeAqjkCR77FcvwnSN+MM+AR40VPX1FOmzhuSJODW456gRPVTynmEXL953K?=
 =?us-ascii?Q?LOxswRBMicd0q0dSfWmVDoNtL/MwqNmWlvuKvyNNASTSxxq28IC5VLGUC+ik?=
 =?us-ascii?Q?8V4dPlU/KWS7NATi1gGqvWWWhayr2j1rZp1Q8fegiQVFI0+pel3j58fimnDF?=
 =?us-ascii?Q?UhxjnM/FJliCONqowas7JchNsXq95tvuw1YIFx/sC+D9X9kRxBfBOe4/2Muw?=
 =?us-ascii?Q?cY6FgEdVz1ZppDBa1BReKPmOVmRjd+VnIWSb0aEesG3vpOaltttgPe2AHVH8?=
 =?us-ascii?Q?7iN1DhgkYYFTZPyICXf6k+gsDPN9QZ92cS1jmTZKh9YuDVvkkVyXLB4101Dc?=
 =?us-ascii?Q?IW+TS0bRzqQ6KL/5TF6Yk6OrC1ATCSjDZCnAkzn4QSPEMPF1tVRuPhha7Y+V?=
 =?us-ascii?Q?LWnJYT2ikXmevtAApkVBCrXK+HLhNmHrtSWfxJXYR4w9ng1lZAgnQTkj1QjY?=
 =?us-ascii?Q?1mWHeAAyY1IWfdgtj7YDgpsxzFy8daZZH1MqkDMHq/MiKxayGJnL41jcspxM?=
 =?us-ascii?Q?Rjvzs+hVon+DGO5HgpKSggisXTfySmGNM04bp59hJbUMoDx6t2B5SHlAuJj3?=
 =?us-ascii?Q?8/4jS9LOxcitbl/FWqEMXh35z3pgRpmPfLsJFcNk5YUcRD+Ygieq3PgEv4yf?=
 =?us-ascii?Q?iaUsayMBNBARAT2hfIT5exeD2fHuEAWfzQNql5TlNbAFQYvXw8ETgJnpGHWR?=
 =?us-ascii?Q?VD5ukrA/tJu+EkRsPJuQdjRGhq1lcizzFVWCfti4ZFlMPLO1PcanyMAf2Zlf?=
 =?us-ascii?Q?C5zwIfVqu6w14JesKoYTVGt895qIQC3y0uovFDv6cVUDoGbzv0MoiUgTpygU?=
 =?us-ascii?Q?qgs2VMkFPrDdE8+XgFGzfRFmG7trWGuMf8jjNjD4Fi1nTKD13775AdAnGX9b?=
 =?us-ascii?Q?Lk6naudjSNO/e5BoCWTCXFRYqkV2dGWdLnoXXabZ/TJpKeHb3okW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf00c2e-5cc2-4687-b69d-08def10ecfd2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9462.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 03:25:05.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7oNFZidbNj4GlaUMgdE4C7WAtW3zgduDfofK9AMOXk8YAwqNI7tHntAMnBYRnIi1PwwF/sRLb/RmzkSaMEtrlyEpUgWCgj2MzQTJC/6CJtZsbiffuN9XGrlqz3xaF31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10850

From: Carlos Song <carlos.song@nxp.com>

Not all LPI2C controller instances implement the Target block.
Since commit 90311787f483 ("i2c: imx-lpi2c: reset controller in
probe stage"), the driver unconditionally resets both the Master
and Target blocks during probe.

On controllers that do not support target mode, accessing the
Target registers triggers an asynchronous SError and prevents the
driver from probing successfully. For example on i.MX8QM:

  SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
  Hardware name: Freescale i.MX8QM MEK (DT)
  pc : lpi2c_imx_probe+0x280/0x594
  lr : lpi2c_imx_probe+0x224/0x594
  Kernel panic - not syncing: Asynchronous SError Interrupt

The VERID register is implemented in the Master block and can be
safely accessed on all controller variants. Its FEATURE field
indicates whether target mode is supported.

Read VERID during probe and use it to determine whether the
Target block is present. Only access Target registers when target
mode is supported and reject target registration requests with
-EOPNOTSUPP otherwise.

Fixes: 90311787f483 ("i2c: imx-lpi2c: reset controller in probe stage")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index e1a4338bc51e..1cfd7a4c8237 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -29,6 +29,7 @@
 
 #define DRIVER_NAME "imx-lpi2c"
 
+#define LPI2C_VERID	0x00	/* i2c version ID */
 #define LPI2C_PARAM	0x04	/* i2c RX/TX FIFO size */
 #define LPI2C_MCR	0x10	/* i2c contrl register */
 #define LPI2C_MSR	0x14	/* i2c status register */
@@ -136,6 +137,9 @@
 #define I2C_PM_LONG_TIMEOUT_MS	1000 /* Avoid dead lock caused by big clock prepare lock */
 #define I2C_DMA_THRESHOLD	8 /* bytes */
 
+/* Bit 0 indicates the presence of the target feature */
+#define VERID_FEATURE_TARGET_PRESENT	BIT(0)
+
 enum lpi2c_imx_mode {
 	STANDARD,	/* 100+Kbps */
 	FAST,		/* 400+Kbps */
@@ -194,6 +198,7 @@ struct lpi2c_imx_struct {
 	bool			can_use_dma;
 	struct lpi2c_imx_dma	*dma;
 	struct i2c_client	*target;
+	bool			target_supported;
 	int			irq;
 	const struct imx_lpi2c_hwdata *hwdata;
 };
@@ -1330,6 +1335,10 @@ static int lpi2c_imx_register_target(struct i2c_client *client)
 	struct lpi2c_imx_struct *lpi2c_imx = i2c_get_adapdata(client->adapter);
 	int ret;
 
+	/* Reject target-mode registration on controllers that don't support it. */
+	if (!lpi2c_imx->target_supported)
+		return -EOPNOTSUPP;
+
 	if (lpi2c_imx->target)
 		return -EBUSY;
 
@@ -1546,13 +1555,23 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	/*
-	 * Reset all internal controller registers of both Master and Target
-	 * to avoid effects of previous status.
+	 * Reset all internal controller registers to avoid effects of any
+	 * state left over from a previous stage (e.g. the bootloader).
+	 *
+	 * The Master block (MCR) is present on every controller, so reset it
+	 * unconditionally. VERID shows whether the target feature is supported.
+	 * Do not touch the Target block (SCR) on a master-only controller to
+	 * avoid an asynchronous SError.
 	 */
 	writel(MCR_RST, lpi2c_imx->base + LPI2C_MCR);
-	writel(SCR_RST, lpi2c_imx->base + LPI2C_SCR);
 	writel(0, lpi2c_imx->base + LPI2C_MCR);
-	writel(0, lpi2c_imx->base + LPI2C_SCR);
+
+	lpi2c_imx->target_supported = !!(readl(lpi2c_imx->base + LPI2C_VERID) &
+					 VERID_FEATURE_TARGET_PRESENT);
+	if (lpi2c_imx->target_supported) {
+		writel(SCR_RST, lpi2c_imx->base + LPI2C_SCR);
+		writel(0, lpi2c_imx->base + LPI2C_SCR);
+	}
 
 	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
 			       pdev->name, lpi2c_imx);
-- 
2.43.0

