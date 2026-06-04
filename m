Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2D3BE156;
	Thu,  4 Jun 2026 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599541; cv=fail; b=YyKQDnsajaTgzGlMstSrc581q4riRSsdnEQDytXqsY/Kc93x7A63Lbdger5jAvK6qpjPJjAzSiR6aQpdmbhlS2MsP43/Q7n6K60GOrF1+q0/bxPhVENVZ+XufLZ1/Wh5u8PjtRcM0Pi0RLoIbXKapE3t1PriQ2QV24KWDoi7aJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599541; c=relaxed/simple;
	bh=+n3Y+1vmDx42K+MOo3VSTKUicF08pUqiObUqo0Z6qtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U3FYfaoUUb6gyUAA/oYMTnQvhqEhdmmgtWS+yQf9eDZaqG2P9CSvhZWzanahMX7bbaJFIRV7AuzD765LrpxCEsAP3peRac8zTAQaAiGptQK33RR5MhYxlgHykxAkDQaeyCN5dIHkXHrFKn0pp8aiAYvKgipKYt7lSvIHZft9KHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BG4Qajke; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BG4Qajke"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zF5B3t/aCP5/jBJvgbgwzcda2Q2vwlRQuEovdLs28mpahygltItJpVcDdbS4T5qChvMpfIAGIaJMYlR4l/NHUc/RKbumzIawBsYNJD6xfiHJxRAw/YR1E9p86Jmo/hiTlKPHwowqVOpXbzraNrkUloB35DxuY/XioPTtmxwTy+TFksWPzW3ThJhxV8TvKj1G7vK+f6J574RvNXPcwtkpBNJA3Je4rQfDr7j/0ZUcRwfhbpuVPDA0PwTAtintDHXMEC+fs9wZPOZkVILbquXPh6kGmyxsjdy2p+URKcZd2o8+9NHCXqGZGEK3ERbE9XLwInEkmexJJEFA8eTzBJmxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nxZhuI9m92X4En/xmLCtLYVI9uyTWIrt+4EBcLlmNE=;
 b=bZ8BpLOeZo7Yt0YIZQzoFqNb+MPzUDJbcIKCVumnHslHE9b8iNmre9aAO+Ma/bJT6ldM7zpAOs2th+8oLa0eQmmYAxRpGjt7pD9Hy9hDajtFm0vzj1i15gwp7tLXDopGRO+W3XgEvvy+JI1GBRrrS9tG2vqXyRBBj+qdtl8jVo/tAR6O6j7ezQD+nSACdrQJ05ww+zlFpmKUDEdyedq3WwDvPXQM0CJ2QOMhlAMSNIioM2+lrDKuvHGptZSd+Sa/0qPJ8sSpJnnl70Dp5r1bIJdCjKqMvamkD2waXQBxON08trTAzKGJExW+iGZFVY3VLYa0YnTrJr8ss5LIOHFvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nxZhuI9m92X4En/xmLCtLYVI9uyTWIrt+4EBcLlmNE=;
 b=BG4QajkeybHXSpK8FYcuCWxyoyBzVqKYAXt9CuyfEoxjNDnK0Te5WXxBsB35uNgpAti99qTyYSW6ZkRL1MgokNKA01yngJ2zuvrjGc3pMFH2KqKaMwxNI7tGHz1kcASmCJv11rLTPMiJv9GXF6oKkGDHI6lEM9imW4K/MVjvAwqqMT7VAkDHUwDdHUtpp5HCDRn3VAeFM2Aw+/uxhANIUV8IViSLH9SWX5iU+Sg1VD+lWGt+bAvadfiVFL6bCzcYxI8/qPwBPCrIF6amM96iBkryplO6lq0V7+5FEikLL07J3U/qoq1b8CLYE71oz8A4/2jcxo3Gq9KsEBwvg3crgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB12055.eurprd04.prod.outlook.com (2603:10a6:800:325::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 18:58:56 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 18:58:56 +0000
Date: Thu, 4 Jun 2026 14:58:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: aisheng.dong@nxp.com, andi.shyti@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v3] i2c: imx-lpi2c: reset controller in probe stage
Message-ID: <aiHK6I2SIze726kM@lizhi-Precision-Tower-5810>
References: <20260521103530.2988866-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521103530.2988866-1-carlos.song@oss.nxp.com>
X-ClientProxiedBy: PH7PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:510:323::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB12055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f35da67-719f-4726-1587-08dec26b5413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|38350700014|6133799003|56012099006|11063799006|22082099003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	VRjMb0pIBe2Fs2+r5VjD+sqIWzXyvZuxzAXu1Gvz1t3tbncydnRYBMT+aPNMiTAIoGWA0oVEtIG6j036P42IXlw/u6FCUhkBXeEBztcPymLMtYLXxUozo/1aUzeU9ZNVVGAgflm98iGn/+s0DuJpw/twJKTuN9mmuzELlSAh7G4mv/hZ08gMxf7RUgRDU7SbURmZlwMls73w2lm511/eMcsEuWCygCn1xPdodc+l5upwBSATrfE2bQ84ttVtPBJhtn0y4F6u4uGr9201C1d/YfrWigmlJ9fMxh8Erpqsk47njoS2znaFB0dmYtkw+9b7KrUW6iJsvTWWazAc0KVxKAAi6Q0puj+zDcswhviAwtrMHUr6Q+dOzyvCmYWWkBFWoKCnWvKLZRxsFhT0Qu+Jp8JrpicR6lbDUCtE2gRTzVQqCMjPA+pL8ouxbSZT+DFxs7eBrkRFzkRpuIKj4J80F8eJevU3E39el1d/hUkkU/r2NRj5B0SnaarMQRYamMrBxVUx4Pmqi0HkfpbNHrvoOCkgVZTNxIm2WaiCekf/xl8AhXamEMLNxXrgSCoN90iVHSKLs7jcIXrbgDlvkqsWBqApw5upungUyFvGCT++yy3330DNqeK2So+Z+w5ufy/O7OH+c4t1BU2Fdp8RF8sicgw6XnioJWtkOCA7xQy9RXIjmwoN2S6uAGhupMTUDE/1nI9y+ORTjfdEsZF7LsA5uHZWkRAJgQc/pDkayZYjWy63mvGoryR4dyKzrGYl8TBb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CUhuCNbRcXfvFEKpOfy+VOZJq670KmBQ7KbfGpCKzraXW6dFACc35IVLFthR?=
 =?us-ascii?Q?9a4c9c89gGKW1dKSMIo86G/db0H3oWkAZ/YXF35xS3WoO86AenNhMDDUu8C9?=
 =?us-ascii?Q?TEVLdXfm3Fwd7QpxNb7VA9sgi50Bb8avkGtQ/SQzThr3k/gjQh0ZF3yKAs6L?=
 =?us-ascii?Q?1UeH168OQKUOthxD1xIG9hzDWke8AzaNBYllNYEmNJpD9hzdUedM2tCo/A/1?=
 =?us-ascii?Q?QI+G9w57t6WYUTfyHGdM/bxFmwB+f50j3v3zcvL7K6bHuTZkxQHsbqUL6JFg?=
 =?us-ascii?Q?+wlyr89pfE41GEmBqoe/3Asg2Rqyt9vvzxdzWk3qRvnsIiP+stLKj00FHeLn?=
 =?us-ascii?Q?4T6Mu4EZPIoW7vyLfvI/LK9mXzwlfMrJXJ5+mq7q+QC9J9mTitM9rGhaEC0y?=
 =?us-ascii?Q?isy8hqfPVzwMK+jQ1RDxUX0hZI74x6dQrjD+WnTVlg/AhV8KIk4EZv3lRG/Q?=
 =?us-ascii?Q?1/IFppCGcMoCGl1ExuDaOZ7DRSWySS7XLCw2L/SBvYp8MYUJM0gju2Dfwj5z?=
 =?us-ascii?Q?LDmTzVf3bVRPHVEZj+3TF1GdErZblMW/0MOfoBXDfDwN8mBFjyrmaZYqfTPj?=
 =?us-ascii?Q?MEn9La6Or395qBPm1c472EfrerjAog1FkWvupsbaMz/IhNF6+1RT7uajfjDa?=
 =?us-ascii?Q?AJlxDi6rt0s+NdOB7CuK7avCRNULmef4mcCF1OzOSnL9deW/AbXYs7Z9Ul5G?=
 =?us-ascii?Q?qrh1w+iV6PvudNRga5TS8jy/ukyJdL0Bp01xY50orTU1+HUNKErB3e0dmvGV?=
 =?us-ascii?Q?kEU2SGeb3wbwnkcFw6LqD98ytDfthVCSFR8qEGEmn2cuyH1LvwfkDhKJbt0X?=
 =?us-ascii?Q?XoCxPj24/oN5r9nc9AWsi8oXHdM16NEOq0KKB1nIstjDPZDsJlvQlWSK2ssd?=
 =?us-ascii?Q?kYZthXKyC7/1E0RfR/hkhoE5KOOCYj2McpcG6bEnhWc689Z8nA3y/RwIzqo6?=
 =?us-ascii?Q?L0WD0aCXO5vGrvgOSI6ZGZ9kZWapYXFbF2A5XzYc4y3rpBuluzOasuG0iRLH?=
 =?us-ascii?Q?NlrFUahb9FOoVnb0Qd7g4fZo5hYE2HuLDE0MRZZAP8dWO0TTRv00Qb0SvhOd?=
 =?us-ascii?Q?5hdvZhhgRgTJ36+gz2Gd8KqptYVz80VUKnl4FEMVq7Yen5d3S2lHLtTgwHBx?=
 =?us-ascii?Q?IIiNItpMxoY3HON8wFVW6TvAedu0VAIStdlaiMgZ/9DS4UUnZjp4QcTG/Hqn?=
 =?us-ascii?Q?vZJ2Vd6U5tpox4ZxfLG1X8A7v2jVMZZOsrzfJrh0WjYHwDNGIqYxA455Pxh0?=
 =?us-ascii?Q?5o90K5GE2rbuZ/YORLMxLJP3KCFwAdqQgaDC8yoBvquuFqs32sqX/DBBwbZS?=
 =?us-ascii?Q?Fz/zj+NfZnPWlGZJhhMm8LJOtVqzhvO3D7jlGW6Ee43Khdj53qvrk9fM+3V8?=
 =?us-ascii?Q?plnMFkxf5+U4z6iT+LsSWeWtrnwtBT/0mh73uWhPHtouTQAxJQJQyU0SRE6X?=
 =?us-ascii?Q?7yaSo29+AsDjALfW1uHOysajDJtZTc4v2KGNf+SC64x+HFUA5rOdBqoKNwIw?=
 =?us-ascii?Q?bZCN2dlcvXzoGHyX5n3NXLeodedLCMV8c2jiupYum1p3DUVbypyAF2znV2vE?=
 =?us-ascii?Q?Vr/myfjzd6JXsxF/dCpppcAzb66N4xNI/KVNbWnhGHSyRN36qalPhPBPKDCY?=
 =?us-ascii?Q?B17gNxvHQ2O5oTq+jdKhAeJT8UemofUbIAIuhZ7tv+yl/biololc7JBGi4HC?=
 =?us-ascii?Q?0yvCP6WfePrRv0a4tIk9QU7HyhAfvElHgi9SV0/0EVRYWHXSEkqNwNb1s/vD?=
 =?us-ascii?Q?pFreCTAf4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f35da67-719f-4726-1587-08dec26b5413
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 18:58:56.4738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMj6ETAAbkKkvw/GGljmok4hLEVg+pYiQkcnB4IWAqqvoyj4Jck+EpGfFMbIKRIJPiXkYNt/X/XUZb2mh//g7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12055

On Thu, May 21, 2026 at 06:35:30PM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> Reset I2C controller in probe stage to avoid unexpected LPI2C controller
> state left from previous stages and hang system boot.
>
> Per the LPI2C reference manual, section 7.1.4 "Controller Control (MCR)"
> and 7.1.20 Target Control (SCR), the RST bit (bit 1) description states:
>
>   "The reset takes effect immediately and remains asserted until negated
>   by software. There is no minimum delay required before clearing the
>   software reset."
>
> Therefore, it is safe to write 0 to MCR and SCR immediately after
> asserting the RST bit without any additional delay.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
> Change for v3:
>   - Reset the Target logic via LPI2C_SCR.
>   - Replacing pm_runtime_put_sync() with pm_runtime_disable() +
>     pm_runtime_set_suspended() + pm_runtime_put_noidle() to avoid
>     triggering the suspend callback, and explicitly calling
>     clk_bulk_disable_unprepare() for clock cleanup.
>   - Add new error path free_irq and clk_disable to cover more
>     complete error recovery.
>   - Remake commit log adding SCR RST section.
> Change for v2:
>   - Jump to rpm_disable instread of returning directly if the IRQ request
>     fails
> ---
>  drivers/i2c/busses/i2c-imx-lpi2c.c | 52 +++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index e6c24a9d934d..4929f85ab485 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -1510,11 +1510,6 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>  	if (ret)
>  		lpi2c_imx->bitrate = I2C_MAX_STANDARD_MODE_FREQ;
>
> -	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
> -			       pdev->name, lpi2c_imx);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret, "can't claim irq %d\n", lpi2c_imx->irq);
> -
>  	i2c_set_adapdata(&lpi2c_imx->adapter, lpi2c_imx);
>  	platform_set_drvdata(pdev, lpi2c_imx);
>
> @@ -1527,14 +1522,18 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>  	 * each transfer
>  	 */
>  	ret = devm_clk_rate_exclusive_get(&pdev->dev, lpi2c_imx->clks[0].clk);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "can't lock I2C peripheral clock rate\n");
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret,
> +			      "can't lock I2C peripheral clock rate\n");
> +		goto clk_disable;
> +	}
>
>  	lpi2c_imx->rate_per = clk_get_rate(lpi2c_imx->clks[0].clk);
> -	if (!lpi2c_imx->rate_per)
> -		return dev_err_probe(&pdev->dev, -EINVAL,
> -				     "can't get I2C peripheral clock rate\n");
> +	if (!lpi2c_imx->rate_per) {
> +		ret = dev_err_probe(&pdev->dev, -EINVAL,
> +				    "can't get I2C peripheral clock rate\n");
> +		goto clk_disable;
> +	}
>
>  	if (lpi2c_imx->hwdata->need_prepare_unprepare_clk)
>  		pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_LONG_TIMEOUT_MS);
> @@ -1546,27 +1545,43 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>
> +	/*
> +	 * Reset all internal controller logic and registers to avoid effects of previous status
> +	 * Reset both Master and Target logic to prevent interrupt storms
> +	 */
> +	writel(MCR_RST, lpi2c_imx->base + LPI2C_MCR);
> +	writel(SCR_RST, lpi2c_imx->base + LPI2C_SCR);
> +	writel(0, lpi2c_imx->base + LPI2C_MCR);
> +	writel(0, lpi2c_imx->base + LPI2C_SCR);
> +

This patch should only include this part. other adjust should be new patch

>  	temp = readl(lpi2c_imx->base + LPI2C_PARAM);
>  	lpi2c_imx->txfifosize = 1 << (temp & 0x0f);
>  	lpi2c_imx->rxfifosize = 1 << ((temp >> 8) & 0x0f);
>
> +	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
> +			       pdev->name, lpi2c_imx);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "can't claim irq %d\n", lpi2c_imx->irq);
> +		goto rpm_disable;
> +	}
> +
>  	/* Init optional bus recovery function */
>  	ret = lpi2c_imx_init_recovery_info(lpi2c_imx, pdev);
>  	/* Give it another chance if pinctrl used is not ready yet */
>  	if (ret == -EPROBE_DEFER)
> -		goto rpm_disable;
> +		goto free_irq;
>
>  	/* Init DMA */
>  	ret = lpi2c_dma_init(&pdev->dev, phy_addr);
>  	if (ret) {
>  		if (ret == -EPROBE_DEFER)
> -			goto rpm_disable;
> +			goto free_irq;
>  		dev_info(&pdev->dev, "use pio mode\n");
>  	}
>
>  	ret = i2c_add_adapter(&lpi2c_imx->adapter);
>  	if (ret)
> -		goto rpm_disable;
> +		goto free_irq;
>
>  	pm_runtime_put_autosuspend(&pdev->dev);
>
> @@ -1574,10 +1589,17 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>
>  	return 0;
>
> +free_irq:
> +	devm_free_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx);
> +

if use devm_(), need devm_free_irq() here.

Frank
>  rpm_disable:
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> -	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
> +clk_disable:
> +	clk_bulk_disable_unprepare(lpi2c_imx->num_clks, lpi2c_imx->clks);
>
>  	return ret;
>  }
> --
> 2.43.0
>
