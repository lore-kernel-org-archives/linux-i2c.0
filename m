Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B873A16B8;
	Thu, 16 Jul 2026 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186294; cv=fail; b=AzjOpQwNexhxEOQjJWj2MA1f8Pxs3CQ4TXQ9qsrJ7d71/EuFwOFcw7OKICUpMBYzpTKKRqWs7jO5Svma6YtVhm4p8x0VBIZk37VfM7RkPRkCGiXe5/WwqUiv2vzx17ItGCjmMzK/B2IHx0sH43pU2gm1QFfIHsB+s5dN91Io6n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186294; c=relaxed/simple;
	bh=knPJ5d6cDqC+4RFXdbGHgvzaqe999H5Lwy9EepCqP0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lCdeyw1BffegVBT125hBiffSI+gLOUxMOOKceEmA3rxexWgyHAs7lxCfRy8YbMZ/Di2RXLvSDidUiTr0blDMzpAp2IHgNi05mzCTyFbLvuwZPn+4D0aMPI2ajHXMZDcEh1FjXRYq/lvdfFOGzBUPaavr5JJkLBvK6vKarbhb9GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=E3O24bj1; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E3O24bj1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXYLm+D51Vn9aeD7RcKBJ8bW7j+5g0WV0l6yWFcqJe+Yf0W0feDFAbcPr5693OplbvCQc0JUYbOKRtbeTRaUMNnzk8+Cnfw9mCRNyMrHcytATbYec/HpqL6LZSSn31oa0R8I51FQrYIqd7G5Y/mHsL6rQo4TFYa/AL9YfWW7z+JiBq7VN//f6fZc2aO5G3fB3MGsxlYrFAs0C6qviF+TYFnNRFXywc9cwCBRv46LJaCMcbKkEwq1E4TXGaUdveV5Cqoskyxn9YId+fEJOWfjmTWU8so1/k+wChZ4kojMhHsQLlKqQFHUket+/W0ThXeGG9Jf9xCzY/It8rrZiru71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3IMA4gAJDifDakNhKXAKWwVmtDT/gaaNA+P9x3nGB0=;
 b=EUwYYWQ7XZ2Urv86sG9wmgyrPzZG+XuVqvNmYK0t4L45T7hfCGyr4ZVYgax8xEHj1wNte46/eh+4X6egVKjY1F12Yg5QEALk1dbGOSLxISFQViILXCoY0tPmS2tP+vwY5CRaBP7Q6REjJSAo1W0dp9rd4Vai7bsEyLKfgsiEQ3FHGSlE8c+H5e5PH8ZySPryqBOuGa/xdeUT96V4F5UEXA67UWTEACrCq+WEBomHb5ayFXVTpBvATWC25yVYEPMLCc9EtUig9AQh0UHyfobmjQFU/OolQQmrIdyCZVHMYpW9fO3aE9sdJRF6S1yI8+70Mz9L1cKQCTg3B43hcvBsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3IMA4gAJDifDakNhKXAKWwVmtDT/gaaNA+P9x3nGB0=;
 b=E3O24bj1Dkpocnh5eatX7PD61WFj7uWHjuH2bW9ulj0Z6EoSQYhvhLIIQosu55pqe3KPCKHRM7NBng1laaV99KL1offJalA+l522qpHpHa6fV5G80rBVBdXSgYIB7Z49BpMnIs3xtNqBD7z/tQkyBXsN1JfHAxxpdtVFU5FL7z2aOVAMwEQwaj5j0/MIdeyPhInK6uWt1tPQWiv7fT/HpLH1u/EIV09oTPxD6HSgtzn3+xvnY21yKrClnBXOvWNbuyiNCVvefhbUbfM7ycsMpPn9t1pK0VTqJZXrjSrPjCbZ6fkmiYBOKfBcbgOK5O7fUsIWWFtrlZAq5a89LtzhSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6)
 by AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Thu, 16 Jul
 2026 07:18:03 +0000
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c]) by DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 07:18:03 +0000
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
Subject: [PATCH v6 1/2] i2c: imx-lpi2c: properly unwind resources on probe failure
Date: Thu, 16 Jul 2026 15:19:56 +0800
Message-ID: <20260716071957.2670263-2-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716071957.2670263-1-carlos.song@oss.nxp.com>
References: <20260716071957.2670263-1-carlos.song@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9466.eurprd04.prod.outlook.com
 (2603:10a6:10:35a::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9466:EE_|AMBPR04MB12334:EE_
X-MS-Office365-Filtering-Correlation-Id: e25a540c-499d-4be3-1c7b-08dee30a5fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|6133799003|11063799006|5023799004|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GoUtK6sKk7QEi9ksoQ0lT4p1frZiDShYZCJxZu3/43jcAH/4js0h8m0ZLRinDC6A29LiX2BPfyOJzDgrW91rsXhTyEGO0HajKfsjReeib9JLx/Gyjcx5KiC1GSbGhJJMCMox76/I/bIqb4XtZEOTr2I+iVrdU1AQIp3ecAl9PwZb62K23akbL5xerXOUJPBDffVIcJ2bRB4vSeRtczZgOqoyfB/eyPX1CJQiEpnjNDrfXmq0bMvm3wWe2wN12dGG4R9GsWcCXpAEdgvcKXmrVfRKlnIo/1X+MkfXAC7ilM9kQ08vnwitDiGOuYNBpsrL2bwdthsji3G5F5WUimlcDMM5RKU55Ropwa2XCJJOLz+5RAEKnoCj/+CqB0iIjaIVZg3YyZG9s7iYWjA23cz/uV0qQvkYkeq9VowGBp2bqeY/QtcHFw1KYLxsmx788JNJPpsJ2RWgNGBjBmGQfZfTlRXIpMRhSawlmj82bB3UFuWFNiTNO6NhIgYlUoOEmeikhuoH+Kf6id2TXd1T1tOd9NIGFZH7634Fra/kdEKwV71nBLpaHGU5FnDZolog7wVyo2yZR9Yv6PDGGKgCLwN6T3w7A0moIIQSWo3udL48gN4xpkzu7j4GGdJJZ/j6t+UQA75nrwNJTXAQnNHecBe/SKum/EYbTt779YCtvmV1O74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(6133799003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O989SAWQkYj3wMVR31kk/PIlk+yQhid99QVf1Jc9DNDnHp2OmCWBqHlqBzow?=
 =?us-ascii?Q?fjULCsMrRKw1b1PlT/yEVxdNvZWE8siREKmUSshDIi/cu3hNdX6sQz76jYjS?=
 =?us-ascii?Q?KoSUruYpCHtYPhR0z2Ps5iwln5lLU1nSQkX50YwmU6sVHUqTMQT2uXoYib/X?=
 =?us-ascii?Q?Alril+RJPZ63YiELPyXdVu+CaoYmKV4C6ga7e8/0OsmuELRnziRZn9dlI/MT?=
 =?us-ascii?Q?P2AGasQrfk8gwRjvtciDHoDhRRnaai/NNdmWuuxkRZVuyXja+bB2/6SB5qOZ?=
 =?us-ascii?Q?fSlEa2357W9mJUlE6wX2yWOnTM8EtI0Jht7tSmLGkzmhNO7tlLWgaRCJkImW?=
 =?us-ascii?Q?KLgFSM9ZnIqqf9OjBmP7PQB3KmYr08ewx8NA9UIEtSuXdCT9soQbvxkVb8W3?=
 =?us-ascii?Q?VI8q5Wyfzmk4nbi0uy8he1V+ld2JLsuRMQHgeNfsdNxTs+vkt39sfXNc/1lP?=
 =?us-ascii?Q?LfvdLf0OyoiZUaCtxMFlnoy2gDuHpWCkFZ013dvW1DaF1eOLOH+Jh1ULQAmq?=
 =?us-ascii?Q?QY30bsuAvyULlnC04hx1EjXs9HK+5vxPo7YiKBU2hVWGDUFgHFSnxieev36R?=
 =?us-ascii?Q?B1SyK3IdYRodfeMzGMCIIGiGFdMWBQMgilr77ngO9/bTtGyHFjv9B112kPW1?=
 =?us-ascii?Q?3h0fXBK0rrJ6E4MasoWvGIz7u10C0iIX50Nqjs5LCVvmSSuylESdKTIFyJza?=
 =?us-ascii?Q?BbJEjskaGFiGetoGY6NYHSD3GwsAyZBS2ScYOkcOgOfeiM2qn4Ei6RHVtvI2?=
 =?us-ascii?Q?PW59aYT+BV0UTII7hMTpJ4TRPyTHWaq37/UnSpf19vHVC0mAXo3NBeLChm7b?=
 =?us-ascii?Q?1U+/KV+JrYz7SXbDnobm6fz6D49MLCaQdZcggD+T/ahrygOQaY1vKaeg8TfS?=
 =?us-ascii?Q?F6/b6YBlzMNG3trgYe/ymVUxoMlk1p3tNvZCIgEGSlYLybmqqZIym9K0JbRT?=
 =?us-ascii?Q?LC4gbs4jUbXo0HLX7xwktFaaGl8o4YBASxpcybIDDtto7+HHxx/SZTikTlVj?=
 =?us-ascii?Q?U/NnSBVr8sBFERqFSys6IQJ+jHrCy2hwMVfL8hPxz98mPAPtYxG6vO+MNL4K?=
 =?us-ascii?Q?L5S3ZYnqGB/i60AfJeDvJ/uhyoz0aUs0fyXpEViqQXbem/pNSR+VvmM50RBx?=
 =?us-ascii?Q?sj9bb0iETiWCie+ECYA/L5JOpEZAqTO57u3zb4eD/CecMt5p9bW/+qGzbv87?=
 =?us-ascii?Q?x32oFhfsnQ+VMu0eyyYJBe5AnxXUl3OzBhsazCGVrPr3R7CBQ/0YOIsHYYNs?=
 =?us-ascii?Q?RiGGvxTALjw3cHffpFR+pYFmFUuK0FXai6UzgmYa+v6fF4KfLIgXp8Bhq++/?=
 =?us-ascii?Q?HNiuf/Khfl1X60thxlcLHHkYubwIKwZ/0pdanNusM5cGFIpRS2eP28SvWAbf?=
 =?us-ascii?Q?5wT6kErr2V3oekDbT/SeIe1fTvRYespBG6mypR83qLqm0dxWbZfdvMpqys9R?=
 =?us-ascii?Q?6knWvdE/sCJsXHdsbhj7eMQtPXTQCuMD26CBem4iZbS9D4fU8fON7P9bGn2P?=
 =?us-ascii?Q?ik11kkkmEFuyQ0KeDaFCAI67v/Od7b/gzLsJCb9MZh9331cqX+/Bd/d7dI0l?=
 =?us-ascii?Q?/ZpHSVO5GcuBpns1J1kFvOuc4/eUFdGmHf3Tig4n2E+kjqWieEf5yS9KRlgp?=
 =?us-ascii?Q?P2iKdY3yYJehMBJvY6sRF0sSJ7tXLc5SDHLPOuHGmPgPbHb8+69CqoBhDXez?=
 =?us-ascii?Q?dJtRznnvs8S2MEW24ojJI8J1b/Etf7fZu1MBpcIRvA2h4z2f7Fb56xbxmIjv?=
 =?us-ascii?Q?RZjNbbdvOZQuwcPJw/rbOLbaaycha+gg/sDZpD0ApcLlMm0vcDWW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25a540c-499d-4be3-1c7b-08dee30a5fd8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:18:03.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6zFhBvZbK1uWvhkfMWQMUxR7uOrXrcidb4gcjg0mACcwfJUf5dWtzMQFI+qwuh6IJktxkbZRnM3NaFaKOPgMoMaUFLyNnHs+ngStR9dEqrnfzqVmT+CmESKhjSPS9gQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12334

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index e6c24a9d934d..615d9f7f1147 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1527,14 +1527,18 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	 * each transfer
 	 */
 	ret = devm_clk_rate_exclusive_get(&pdev->dev, lpi2c_imx->clks[0].clk);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "can't lock I2C peripheral clock rate\n");
+	if (ret) {
+		ret = dev_err_probe(&pdev->dev, ret,
+				    "can't lock I2C peripheral clock rate\n");
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
@@ -1576,8 +1580,11 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 
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

