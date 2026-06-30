Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3BA3CBE84;
	Tue, 30 Jun 2026 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816635; cv=fail; b=K661c1AnLGvj0cMjs39OhIMAlpp2I2tfx7sdb0j8LaMzbflPtQZFnwDDQS0TI9biZ2K0LRiKw2zoiLY0gHfHV/z4W4nMC8L0sAM2zy9O8+buy+K3Mb+3FkTfm+2JkFB+nSV/1lW4G7IOnsDXmc3cyFHtokV3VR6K9OLUxP2elP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816635; c=relaxed/simple;
	bh=0UO4LZ7MjoNCrpIT0Mbnd5teuGxuB9cSdYEPCpzTBUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKNMLNjRVMh1V66yf6dGLQbwMaTF/P5LRZNcrkQUnkFQ99vV5KniTxcqRX+dPc0Ozv5/kBap4gP3bNEGh4J3ne2hCT/3Nd8lmD0y4qn1LcjOFt9KGRk7Ugxn6Es/0xosyToBTb/28RB4tucY91GCZm+YVc5v11UNolKRmIlRhUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B2v/GwW+; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B2v/GwW+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPilNTCmWwtCzJSMVeF8YokN+jKMtuNbxaSLImI6ACWf1Nup0kLHEiCxTRNCWaTISdc9bV8O7n474v2RaOgbDl4WpR3jmRytwSvq5hdH5b6YJbKtHntP6+J1dDYbSSpvzHdxi34fQ6w5o5vIwlwQMLuYkKrmW6oI+g9gwGa8Xq1J1taODd2jjsH+uMvzrm+ZllDCX6nFTa5m+vHISCOTtphsaZS3FrFRwDtTNpj8JE7Kjxp3Mitm+WyFjSUDJFBYYt88rPhNGkQbM9OOPfhX8EVWb+3BmiEhNOEl2VEVulCddUZZsTkO0pNPNk04NlQ5bK/OXKeq0TKHyIm7I2Obfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJCHHtekRHIDcGHchMAEk1Y8ctAS2Ke+lNpoo4q+Jvs=;
 b=fsdR3QNPU3Y38DCPEfVuM0HDJtqhzCvrsksk5aS9IIQf4PcnoR/hQ628eQp08h5sTIDsjnkERDTrrfTEiuiPhX1bCT1RMfRMWxASvOur/KB3pd0UdYNF5yDgMl9cE/7TfxykrcLQQd+sbBnj/L342KoG+j84Rk2V31eSMeHfP4KaaPQEvgls/BWpcC4uAqjN8lSQP5WkhKcaEaybS6IeizE5+j3kQi/SJG7HH6skPaMyxpCozTa50mx+nZGJ4i6WuctR+GWIX8ZcoZGn0kVu7dO1CJynUJnfcPCVV5BknVwPnsQjASKXG37WgQe0veFz14ANQ42G9m7DvOyt9NGjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJCHHtekRHIDcGHchMAEk1Y8ctAS2Ke+lNpoo4q+Jvs=;
 b=B2v/GwW+FVuHQoY0Kjxh/aMEJmQr8rFrc+LRAwW31Qf1UNvs4dgcc7fGtG/Pfq6WfoZBOrH96aq+xOHSsfGHtx/evgbuMEhB7FWVVBjh9kmcBEBwcBUJMXXnb7ZLrGKIRkQ6MWmiM8t208qqaHXu0EbRWHbdBGbZxBdxtAztCC+lArf678qEElk2ODBdSizUTi8DnZLLVQOAJfxfXzXvSq74rDzjxYdDsoI+Bw/ko/k7z84yysJY6VErPijz+V1oB6S0HsZANHfLK1QXwoUTdpAMBykT8CtskPb+TcQG2Yi8hI8Vch1lQdgNJ0NV3I6fM+YyhTH48Dlp/jrFmJM6ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6)
 by PR3PR04MB7225.eurprd04.prod.outlook.com (2603:10a6:102:83::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:50:24 +0000
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c]) by DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:50:24 +0000
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
Subject: [PATCH v5 1/2] i2c: imx-lpi2c: properly unwind resources on probe failure
Date: Tue, 30 Jun 2026 18:52:22 +0800
Message-ID: <20260630105223.3687516-2-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630105223.3687516-1-carlos.song@oss.nxp.com>
References: <20260630105223.3687516-1-carlos.song@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0011.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::13) To DU0PR04MB9466.eurprd04.prod.outlook.com
 (2603:10a6:10:35a::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9466:EE_|PR3PR04MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4ef906-8969-4250-2b60-08ded695634b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|1800799024|366016|6133799003|5023799004|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zpSLDX/kKSBrhVQI97VuYv45wRnAdKxkUivn/7BugCe8fq9LpYMEY07Vzt7GfzV8pIe/kC9P9sX7Crl+YyRLBnSMCS1JizszfQ1VrqykKi0ZUxH0mVj59q0DwpEVCPP3O0If9oi3k0oDwGX7YNv8YdwwyH/qzhjweSBfcIO2pepCi/Ft6ucaN3jPPEMZqkruexhm9VC+deFYMBQDlGIHuRkve35nsZbmB5WPxxG1lLE1bq1VqzAhTep1eJqpRWz6Bf/SvG/JIIVY8sx8x+NOx9v8JRVPkhBdxgMTXdlCTo+PCVk1Jg5qGvVk+UmFhV8UiNEfDIjPJgDND2Uu1rL6cSfJY1cB5jauCiyBeo8GFsALp0OcQiGZJmpKeuwYgJ1Nb3wDnS0Su24KxNAZoHnefaet34F7jWwLl2Jhex5UrxhWbyhp8//F9cP307O9XvcmnHwhqrJSU/N5wArW4I6MVFPv2rukWPfIAiYeU+omyUUHBEZqJ+2CHFIa8U1GQWSg3xj4+nlemqhV6cLq+fVDR5jT8Xyt1pzWIORwaSr0je6jFy6Z1NhSjXIe4GxW9eJQVz+QtcIPwhrs0nAceAsqlv/kcAQYv/ORUgJzRmsUZTcuWMAcKMLsLiPx+SSvpUkEXb96SKCczHtQ1l6piZ4jxsMFThWG+U917+Jr2RFIa5c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(6133799003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oi5OEYCMQ09caHtl6OjkE8hhltEDDyarWAOJolBZV6c/gaUAqu1KfXJuBrgf?=
 =?us-ascii?Q?5RYNlVNVD+CH6M3nPQc4attkQi15p0QupaK9xXsP8pxt61SKSEV3i4MZckWQ?=
 =?us-ascii?Q?Gbtdr5kYwSXuP2Xqe/tU/qgQ5kA79nKJ26XOlx2d2Rqp53ToIyuYdNBb+4lU?=
 =?us-ascii?Q?VTF7bVYFDYbFSTE00g2R64KSfVDTev+7/C0dVPAyXpUw1+3xMW6qjvr2RHXN?=
 =?us-ascii?Q?KmwKtrRN9cYYnRGhCxdNfMwqi2ZI90Y8RL704urlRnA0OrjuLIKO3uH0Z8ZG?=
 =?us-ascii?Q?BsC8NIvNNz3hJuA7+1m5L64IDmFj7Kr/49s15MMQwvSw8fVK+8xII7oKflSQ?=
 =?us-ascii?Q?0J4GtN7ti9R/3FoaW1Z76IJhcPloCGsLjzxLLrbfn9HDi7W0tx/d5qgXRA0c?=
 =?us-ascii?Q?3LBPn8USwCY17WvfGgkTO7UAkvr4yY2dthZpPSOQ2k5/uPtRR7CnYQJDR/zB?=
 =?us-ascii?Q?dozq/Yj6E1NslbvttH8jl1pPiB8R8JxXwwDcP3xXltNOlibQka95uHT124B6?=
 =?us-ascii?Q?GzeddFq4c98OUWb/BFLVu4ZLh/MjkY0Fqp0jL4UgcDr1ePoarO7dYg9TK1g1?=
 =?us-ascii?Q?lb7VoLCTcIINWSvzG0ItW0ZbW1WDWrJsS6nlQtD30agE+U1IQpauJZjyixle?=
 =?us-ascii?Q?3pqG2noeWl9sfMCwc5Vr9hYGmmCBFMp6/4zyTb3bOp/18rnr9Idgd/k+Rb8r?=
 =?us-ascii?Q?tItQi7MJ3hZRkl6aevZ5kJNHviSRHYIAoPAIl/1FwIYSKZpyYLjOZuV2TqU4?=
 =?us-ascii?Q?7krk1vfftPkehBlYzgCW2Q2L9IU9U3ERt8oBJvx4wFRegHwmTESQ7RaNdQlc?=
 =?us-ascii?Q?6NvtD1slL2I9E0Kh4Z+ZS+GQFjZt4zGl0jOhiqrcmqdmR7t0LP7hzFKbbqeH?=
 =?us-ascii?Q?GyyuZplw4RPz4fNDeekB5gXEa3KXmt/snJRlrgQ09FTVxnfztFa3M1f1Vh5u?=
 =?us-ascii?Q?2pxruAy9Ddw7xhg89mjZUMMycnOALLGDnV7IpaiKoAiT+DWPZ8BQZjshGt2O?=
 =?us-ascii?Q?+PbjWErJqw5d+my4EMU70Go3eWQvCf/kSJVWv1udIgq5DOYZs7LFQtQWdm5j?=
 =?us-ascii?Q?lD2UDW9H+vx/8bh3w0TE5RxBG20bntJIgjxDXjYTcx6gs5s61mKwS1rIQxhb?=
 =?us-ascii?Q?k2D+it3kMxcByrpMXwicmMC8a0s/C1gKS3yEYYxWq3jwnBMmZEucCkLoSgYb?=
 =?us-ascii?Q?Q4Apo6yYXoI6zpjbOVizlej0iP2NXOb94iBJeEmERbDSrm7E5n//Jevv744O?=
 =?us-ascii?Q?6KO7jbMsckm7DrOTOqFsPHgaid4dSvY5gbzVezOQ3U0AlZX6JVbINQ4rFLD3?=
 =?us-ascii?Q?9iAWMfl1s0jXon3HJGe6z8Sbtw1RX0Guvwjv1jXSuvLxNyMluX9c1JGwFnhj?=
 =?us-ascii?Q?vBsGpqLh+kU3Ntfw9trXeNgriWnOJHHg4q4hSxGdcBn4/QvqlItnDTN7NvBe?=
 =?us-ascii?Q?GdulBsnNWJvvZ7x3KI1JLyqd28lGULp+4Ct7ctx3CZLgddzp6ocuJlqjctIN?=
 =?us-ascii?Q?h+cw4JvyV/CNg23+J/PqnnQeOlRrkA5TqORSTUyKEBL8i+N5BHSMuub0bZUq?=
 =?us-ascii?Q?fwK30y2D/iGbkH0D7SoAEFcrH94mLELG98OdhRbYw3wkKt+iubTNtn3OuRPv?=
 =?us-ascii?Q?wARNhvhWna/wXnVriykKQguifaw2BVRtxeupY76s4MV3cyoFEoa0PGJ1k8BO?=
 =?us-ascii?Q?atl/gJJPMOHrIqNhY/Krm1nnIJkPqi7saTKcxjkFn20JLNVKEopwY3+hXxqz?=
 =?us-ascii?Q?FzCG3IdwsVaBL/Th1W6Q1XHZynoze1VFNF/eU2vP0U5ocTQ63jwr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4ef906-8969-4250-2b60-08ded695634b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:50:24.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEKSc1ejCoe1WLkkZD3lFqvzd5J4UCCQNhbbyNC+IplEZFO7L3uzO6VyJtQ6jvQr81ARGXnp6FTMciKj5X56wdKaJbKYjzmcIW9DBOGsEixczuLuhO79C/KTSOYFR89y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7225

From: Carlos Song <carlos.song@nxp.com>

When probe fails at devm_clk_rate_exclusive_get() or clk_get_rate(),
which occur before runtime PM is initialized, the clocks enabled by
clk_bulk_prepare_enable() are never disabled.

When probe fails after runtime PM is initialized, the previous error
path called pm_runtime_put_sync(), which triggers the runtime suspend
callback. However, due to different clock management strategies on
different SoCs[1] (to avoid deadlocks between the global prepare_lock
and runtime PM), the callback may only disable clocks without
unpreparing them, causing an incomplete unwind.

Introduce a new error label 'clk_disable' to explicitly invoke
clk_bulk_disable_unprepare(). Replace pm_runtime_put_sync() with the
sequence of pm_runtime_disable(), pm_runtime_set_suspended() and
pm_runtime_put_noidle() to bypass the runtime suspend callback during
error recovery. During the LPI2C driver probe phase, clock APIs are
used exclusively to manage clocks. Once probing succeeds, clock
management is handed over to the runtime PM core.

[1] https://lore.kernel.org/all/20251125084718.2156168-1-carlos.song@nxp.com/

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index e6c24a9d934d..2dc4331ed796 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1527,14 +1527,19 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
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
+		ret = -EINVAL;
+		dev_err_probe(&pdev->dev, ret,
+			      "can't get I2C peripheral clock rate\n");
+		goto clk_disable;
+	}
 
 	if (lpi2c_imx->hwdata->need_prepare_unprepare_clk)
 		pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_LONG_TIMEOUT_MS);
@@ -1576,8 +1581,11 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 
 rpm_disable:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+clk_disable:
+	clk_bulk_disable_unprepare(lpi2c_imx->num_clks, lpi2c_imx->clks);
 
 	return ret;
 }
-- 
2.43.0

