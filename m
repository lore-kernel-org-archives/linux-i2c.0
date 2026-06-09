Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F51495506;
	Tue,  9 Jun 2026 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019341; cv=fail; b=NMm7Ve/MZit7qDkuKTCv2KpiRoDN3/d5F9CKI5iUq+EcBg2XVB2TyKsHt8noEjzYtj7Lx2ebePZtVjSrcGiRVVLN+cGPczYS3BxqA7RHoFbNgooi8B48PzWMBDkKINCtnLq3V6sH4HvylCgvt6LXdzSSwckq/IgkJaBiGdFRGGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019341; c=relaxed/simple;
	bh=cuBJLQbL+3kSfNmJqL8vwDiD5uS1+YYIKR+8dz7BT7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WHGYS2jyECv1FFSkk2Dgw5uLX1u45IGGrCzxH+acbu4lpuJTIe75sqxMSIZYXNY7arpcInTqV8SUGRnGXyxHGxqUjTEk4rusUtMUPScfrFR6UcrwN2o2S3dlPowdpL9PzYLHOenJceZJu9v09DA+MCFsBM9G+ALwhtOoXF0+10U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ByW4ICzw; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ByW4ICzw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9zt2BwfWO3/ja/zVwh0ubfDYvGTil9mh+E2dokltCrcN5ivOwwAeWY2Xb5g8w1irmx55r2hyx0NHMCaWYjANg17H458MErldDG2OA6VqSb43k2ioa9vTejPVBIqKUrvMxOlOrc5GPbRrMhOay1IjZFngC44hyvlBd5RxyNKDAXmHcNX2DMGjxe0QvUAMH6DzX1w3/wuMcB2efXSh/Mf/pQN/hDHMkkvraspOwoEo9DiSL9JIo0TsT0mCVE6g1RIdxJ8Gp9vOgwNb/GC8inpr2tV/P9qVFxMCz6gifju79io3+Neml23u1ZwWDW8bZBrI6d5Ud2YtxjjBKjMEu4wVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oCwJ3UsXVKjeIXDecx1YBlhFBEm2+Ds2zhJdoNlDsE=;
 b=txQcPcMuss+v1nx46jNmBpIImPN37pLe5TBJZtZhhBUdnwvucgpj7JH6JfGM5rFeF6rKWgNIX9/CjKnQWROojANtC8Lt9wGV+xWRu7tv9gAGdPKEjp9+fnIcmGumZ1kwto2vsmvMjLm8Uip8waxH1k05MbHQzN6eSQDo0e+BigE+XxU5W1asqV/Xs7U4VAY01TwJx9uVVsX/yfTJyj+KKbIvgRU3fTYnKaYhmjRh/NOdtrZlNtCxtGOfpVZQrOuv7w0u6OjLJfO5r61yoCgkdLtL02FlSpX0OOwbPVwGa7hPzYWzxPN4Tx3W1kYtQCQBZS+ObWn41xUYB93gxc4KXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oCwJ3UsXVKjeIXDecx1YBlhFBEm2+Ds2zhJdoNlDsE=;
 b=ByW4ICzwHXrEy81ocxfuNQ09AjL9QMmWM1W99F0Dq58vGdDuz/pJ4X+djLKWYeORdUhUfhRG/+fZKRmLLKrMNhwU2bM1yi9eHGSf/2g7aq0m2AtGgbgohL6LZFdoDuSjTDBjOkLV2Fn5Qngrr7vXj99bnJp9Ku+plzQ1ToNwj4j45s6IDbh9TQdN2PqhvYU++GlsRWRNm864ONN3MY6lajDmHL9DZZcFgXSrXUmQYm9EY0NDHWGfYmHPGAepUd7m28ThFDWICynC4+12J9MJ8qq3axVZP6VPmx47ZLGZHM7HxYIudZim1oGydnXE3zcunP/hJKkAYyZqx7yejbRwOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB7555.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 15:35:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:35:33 +0000
Date: Tue, 9 Jun 2026 10:35:24 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: carlos.song@oss.nxp.com
Cc: aisheng.dong@nxp.com, andi.shyti@kernel.org, Frank.Li@nxp.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v4 1/2] i2c: imx-lpi2c: properly unwind resources on
 probe failure
Message-ID: <aigyvJNKYAFNpHh3@SMW015318>
References: <20260609095119.924029-1-carlos.song@oss.nxp.com>
 <20260609095119.924029-2-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609095119.924029-2-carlos.song@oss.nxp.com>
X-ClientProxiedBy: PH0PR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:510:e::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c915b1f-e5a4-494e-12e9-08dec63cbe76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|56012099006|4143699003|5023799004|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5AnUYXx5uLAfH3sc+P2Y5GygOjfmxb8lPIBN0LsMrkvCCgtGFpIrgXq+lFpfXtFNjl1W6V1WgsuY6fz7vDsGLk04WfXGMCxRbcvcfnKUrBU2Ih0TP7wrI6mspobyC3aB/4ilplVWbZvgMA5a2DgCeDAw+2U7i2FntQLl6mv79bDWcpM5Vs8arKd3cN0g+KXVWcysR9AUKo79rPJXAP69XCM1UI/F22xYMJq0C+298MiBOF26KkQNADx6yuG67hGlD8Riqbm5cRw7XQ151mIRDJ95j9LRoj18XuOsgYwPFjRyUWhYHB+Ed3yz+MM1/c9PEB4SQU+a74HSf2EzOd7riJ35Sc0hgmuoh2Fhhde4I7b/QcQt8jyIhiBxurGCHcPBECF1Y5/cdtjWUSfdigvro1+ciqTEBuZEl5sGqNzyLIyW/nh09ns34SyAbC8U9pCtZnSD+UaAbc+J3VTIB+EYu2l4C2V7Tnwp77xrCoTOGJKg+pA/apqoffvCbtpZ3eyDY9BPBMZ2tocpDopaZv7v6U1CGSLh5ZQb6LbfIVmHLQKmdMdy20A8TyE0gx/MYWCzSiVwS4SHUtAzoP3P7H/v/bPoAup3wYfElt6bmbxthi8EvoyPH/mXuCjIFOS9/K40Af50g81UFzMMyScn9W8DUdo7Zdyi+5Sh0txsBQFYCbOGyIg2NjP/dBJdPZ7I3cBU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(56012099006)(4143699003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sXruUWshCkrzfHNDp1obL3J8wTqCCd7pZpRZHevz2g1oPuvhM3OX1HAvU1We?=
 =?us-ascii?Q?JEWWn0qOI3OC7ey5/bpSqPKGxG9xT+SuJDUbFsURNN0oaoxscJXDzvL6YC7J?=
 =?us-ascii?Q?cM55UO2Pwm/FabhFB7QRTSvQnQ3f2r1+BrxG06nCJRyJMfuCHjBZdRl3gfym?=
 =?us-ascii?Q?pHscxhtnAe4oL2aGf8Q0buffSBVOK7OjCAqucBspBi0k3w0DpzcZPbWtbc5k?=
 =?us-ascii?Q?rBLhGtjnNGBbyBZSGEcFMhP2WwFISC0Oj058eaCXGpyhYlfU6FbnySNuvx2y?=
 =?us-ascii?Q?9NoY10MR306c4aKhUDhNlk/CnXuCfsFs+k4+BlCNmUTORvoOGB6cBDmA5YfA?=
 =?us-ascii?Q?LmTcwYB0hzify1ofrDgAFTy1ItwdsfAVhdmM07dkJXSpxA5oKrXSO/bvW3ze?=
 =?us-ascii?Q?u/AGcsl6RECYURvjImFQYelJT/t7OHKhl1AnGtP17X0p0j6MakSWezoyz8VC?=
 =?us-ascii?Q?FwwTUZmDM1Hb0j9xHbBtygKvbF80bsQJLWgZQEhumTmDh8WtsX1Tu+7aXeKU?=
 =?us-ascii?Q?GE8emA7YDrkROtR4E6KenyMqpR4FWY8gaVWbJqwB7xk+jQxubaYlo5teC5AJ?=
 =?us-ascii?Q?t2LXNsuXlTsrvJCZJgpYassQB8d12nd5CYtLd2bHFSWZ683lE+knBPYp1cfz?=
 =?us-ascii?Q?01OZWxMrLt1/8buzPR5LSDG7ntNUtAQIbNb56jc+ha6Oa/jKXtHBxm9lSAny?=
 =?us-ascii?Q?cYnidwWqZRFCD6YE4c60igDfkT16kawyqkWzFYoUVhOoWhDwZnlbXqwd6wDg?=
 =?us-ascii?Q?lIQjnKcNpjVW5rnnBafh/fjToUfo9F071VhsedEA215a1ThDM2p2IBNCjaKw?=
 =?us-ascii?Q?dYvBYGmlPZcqE9yajH/CKWK6FlgvU4tiITdmR6iDOWtijNaVCy+fYROxhlv0?=
 =?us-ascii?Q?sIAB7B248Fk67sPbJ6x+RPIkpLe9HsSFEWigyxrKOqdvzOKKViP1fUlcre4G?=
 =?us-ascii?Q?VcAfMbh3z3v4D7imZcNW6YtOTIVu1y1Klpp6IKK6NZB1AhGKgKfkjVpisiUx?=
 =?us-ascii?Q?dvxxgRHw2pH4kN7iHVlw2XbFsJcyoQqNnk/0HvBxI6qWoT4TbANniGpYLU4k?=
 =?us-ascii?Q?NyYFY+P4E7sfgE1IZbd52shc/aJhIGlC9e1x5FCJvXiB9l2xNCgJyVEj10FE?=
 =?us-ascii?Q?uttps/Dp6nKpBAG4HZP6ydFrU15b7Kymp3+//yyfpYXNUct1duu3KSvdgZMs?=
 =?us-ascii?Q?3ohH1diII2f8aM8bh6jgklCdpap0sH+Fd7/NqAcm1RXKNNP8uptN5GkRZ+4V?=
 =?us-ascii?Q?McUVXsV3g+hU0YSxN/3TAu18DqNUb/UFShju4kvsG4jHfOHLiOPAmcBDC1S8?=
 =?us-ascii?Q?pffQ9SEme/UDXiAjiFvOhhSNGrIoSq7f04rjr4BoL+sJfHRg3iCamBiTTLSV?=
 =?us-ascii?Q?LqpwmVcY2xfvvWgL3nGUnAjCCNpvFGw9e5ONaNMj3XQhSX0gtQjmzVs5HkeM?=
 =?us-ascii?Q?naKigGw8Shd29KuaCUgQIDoAWY2rdDke0bUE//6Cd/2uoN1gulSewqnfcfdv?=
 =?us-ascii?Q?l1oeASr/d1o76r8wJlVza4TvU6HvYxz88YhVxmW7W1h/vOgD0PNcw3Oaxf42?=
 =?us-ascii?Q?KcSuofWDVfPISQGgbMFkOx8vT4HbMqgmbiE8oTp5I/bG+v4R2Qx7IPv1U+ty?=
 =?us-ascii?Q?yY0BIyWSsek64/zPrV25xxZufGkj9LRSp/CS6v9Qf7n6ajfUVJq0Ih27z3Rb?=
 =?us-ascii?Q?JZGXA/3T9LEEl5BnDP7e5I117j3YqY0Nzc+TfVpL5iXZ5Hu5mFXLPX6m21A9?=
 =?us-ascii?Q?hz4UChT16uOnL/eFTdpkTb+IZjhjLhGv9uuoPkHThX269l5VCsw8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c915b1f-e5a4-494e-12e9-08dec63cbe76
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:35:33.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88zr6RTMKFWp7QFyKBJkHklINIfagtzVYuXXxurKX+cA/vXp3x4UL0DvtRPGZZR1zlmSzGZoao/piNTyBSn1J2WExJciXxZusoptGX5oee1O5e3thoFeq5HS2w6d9feV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7555

On Tue, Jun 09, 2026 at 05:51:18PM +0800, carlos.song@oss.nxp.com wrote:
> [You don't often get email from carlos.song@oss.nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Carlos Song <carlos.song@nxp.com>
>
> When probe fails after clk_bulk_prepare_enable() succeeds but before
> runtime PM is initialized, the enabled clocks are never disabled.
> Additionally, calling pm_runtime_put_sync() in the error path can
> trigger the runtime suspend callback, which may attempt to disable
> clocks that have not been fully set up, leading to potential issues
> during error unwinding.
>
> Introduce two new error labels: clk_disable to explicitly invoke
> clk_bulk_disable_unprepare(), and free_irq to release the IRQ via
> devm_free_irq(). Replace pm_runtime_put_sync() with the sequence of
> pm_runtime_disable(), pm_runtime_set_suspended() and
> pm_runtime_put_noidle() to bypass the runtime suspend callback during
> error recovery. Update all goto targets so that each failure site
> releases only the resources acquired up to that point.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx-lpi2c.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index cd4da50c4dd9..fbb9c0b0a99c 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -1520,21 +1520,25 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>
>         ret = clk_bulk_prepare_enable(lpi2c_imx->num_clks, lpi2c_imx->clks);
>         if (ret)
> -               return ret;
> +               goto free_irq;

If you use runtime pm, you should not manually manange clock again.

generally method is

	devm_clk_get()
	devm_runtime_pm_enable()

	call runtime_pm_get_sync(), \\there are PM AQUIRE help macro to help
elimiate goto branch.
	... // if need clock enable to do some works.
	call runtime_pm_put()

	...

and needn't call devm_free_irq().

Frank


>
>         /*
>          * Lock the parent clock rate to avoid getting parent clock upon
>          * each transfer
>          */
>         ret = devm_clk_rate_exclusive_get(&pdev->dev, lpi2c_imx->clks[0].clk);
> -       if (ret)
> -               return dev_err_probe(&pdev->dev, ret,
> -                                    "can't lock I2C peripheral clock rate\n");
> +       if (ret) {
> +               dev_err_probe(&pdev->dev, ret,
> +                             "can't lock I2C peripheral clock rate\n");
> +               goto clk_disable;
> +       }
>
>         lpi2c_imx->rate_per = clk_get_rate(lpi2c_imx->clks[0].clk);
> -       if (!lpi2c_imx->rate_per)
> -               return dev_err_probe(&pdev->dev, -EINVAL,
> -                                    "can't get I2C peripheral clock rate\n");
> +       if (!lpi2c_imx->rate_per) {
> +               ret = dev_err_probe(&pdev->dev, -EINVAL,
> +                                   "can't get I2C peripheral clock rate\n");
> +               goto clk_disable;
> +       }
>
>         if (lpi2c_imx->hwdata->need_prepare_unprepare_clk)
>                 pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_LONG_TIMEOUT_MS);
> @@ -1576,8 +1580,13 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>
>  rpm_disable:
>         pm_runtime_dont_use_autosuspend(&pdev->dev);
> -       pm_runtime_put_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> +       pm_runtime_set_suspended(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +clk_disable:
> +       clk_bulk_disable_unprepare(lpi2c_imx->num_clks, lpi2c_imx->clks);
> +free_irq:
> +       devm_free_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx);
>
>         return ret;
>  }
> --
> 2.43.0
>
>
