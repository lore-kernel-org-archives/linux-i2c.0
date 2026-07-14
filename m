Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD533644C9;
	Tue, 14 Jul 2026 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036987; cv=fail; b=O4Xpal9iN72gMrL3LcXxpMA6Q8G5P0RwZB4MeDVJPpVU42SYycr+I7bZwTLHrFCWqboXMuffNYWQMkm3OFrkweoXpdHo8a3NCCff+zjRPwQuEZLdTJ8o7ymtNeI6VFRk77qRE7ReDFLKAI1cTvbpCMvvPrlcj78OA81SJBUbgV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036987; c=relaxed/simple;
	bh=r1bNHze5SjRDNpq181HjprzNFkii/VJ+9Cj/kbFxhVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=deXrQyycrgE9HibpRfH7fYKv0PB6PXD9voRbyvCsVQHK9c9nkmNlA8gkL9FLj2EleioRdKrpos3C9hpYaf1rz+s7nD1qUIjZhr7uOeKoLjfsnO6V4kZMVmSMelx5cud9TBvqs5wcCfOEezgfQLHTbqu0g5p2EbSZbfiYGzVihK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qhFsyZ8H; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qhFsyZ8H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxU6gcEL3ONHcu4ybT41nBqMGt6Wi/Ix4wG5VsbiI8lAIyim6EJmiWaEm08Dv/lcgdhf/Ng3rYro/9n0v1BNjhxSDLQFLcOy5wfnyyZNa3OLNzimrMF1okbfWFYugRKQaDeMVw/eGk2EjNOivFPt2jrT5sSkXgE1KhZ2PTahaxvzaVxbb1bHNhSqae+4DgKkkXA9GZbsuryLmW7dRHst3+3uSnFgLiudb5scZ89/RwXdegjnkDKI83CTXWuk13Y/I2lft41BDjUShjH1tIQUC+FXtvY6PJyndZoLvcxiIZ/JF2bveaB7m+PH0BiF1SOqOzkek9dApAbxi6RjP4zLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkD7kWBBHrLLSnp+lu95SDIf5IdK0OOwKRq7zP2JPf0=;
 b=eeHSOnapylLf3nBTh8vEydwxDZsDX+p6MgfEN1iiHElzgn7Y23MfIdwJAM/bzzln92CoUHfKRBTRHy7XVRukIUr64UPKOsW0VHcNMSJaYwOCKKCFQbWgkKUyt0d5kunEAKrxAEM0yzArjGH4RuDokpv9cZybm7AUNGP6aSvHK1VyDgd2fy4N2+ZzhJe6C3MxgHQ7Af5p06gJjZPUH017e3VEhKMnG2J/C4bBwg/R7IWTQgP9223wgm8ngBbtyptL5MxmcScrqkbWgmXF/eOAFxln70kN3aEYpy1grZa2XulNNSQvZet8pcBeepD8CaIVljA+03g9sCyMmWHUTNdc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkD7kWBBHrLLSnp+lu95SDIf5IdK0OOwKRq7zP2JPf0=;
 b=qhFsyZ8HcKWdW/JKFkhRRoWw7OOlYuMTcxLv1417FVX1Pti1kjGl/Qkh7khL13StuAzvEUVS368O5r8Sr7tiG2BZ3uTLIK9cRPM8HUmaFPK8FNo3AZkyAUcfdaxGvRm8veqC5BtS/7zONhSv0lPC8GStNUJZ66brn1dL+9NkrwRzNZmLuXFpEPZ2o9VeW9OhN+X0nr7AKERl+gUL2g4iDvgJ8pkSQm44g0iQW2NY4JMoO8BlU7MJmLqpVnlT7cFDjuEhmEh+Yx2gUbJtsIozXBzVK549IsmEYnvw/h26Jb4sCf43tGWXTJNGcqdj92ufrbxLE3BUkHUC2O7E2fbLRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS5PR04MB9753.eurprd04.prod.outlook.com (2603:10a6:20b:679::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 13:49:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:49:41 +0000
Date: Tue, 14 Jul 2026 09:49:34 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: carlos.song@oss.nxp.com
Cc: Frank.Li@nxp.com, aisheng.dong@nxp.com, andi.shyti@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v5 2/2] i2c: imx-lpi2c: reset controller in probe stage
Message-ID: <alY-bu07tTHE9bHu@lizhi-Precision-Tower-5810>
References: <20260630105223.3687516-1-carlos.song@oss.nxp.com>
 <20260630105223.3687516-3-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105223.3687516-3-carlos.song@oss.nxp.com>
X-ClientProxiedBy: SA1PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS5PR04MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adb21bd-fa60-42da-838a-08dee1aec14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|376014|22082099003|18002099003|11063799006|4143699003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	hIWYYoM024S6ylAYNSXcsh5xZjCCE0t96UqrVefKm/DuLPnSABG6yKF1aP8EEz1Xhor+qVTMd8jUnC+JzTKy2gvy20El+9gkz4B+Eik64GfxY4G3pSYBG6SzOtdeiJaWntC1+8vP4Y1ZqSuWNiLbWJlleE2ObLBF4v1x0k7kC5waI8EweiAr9AUfw+kVKSKJuJIQNk4IOUMYqDfslhBqYhN/LDICPUJO1CEFK1Poli2QlXOMbpOLHhn1QUkWaMZtXbbvUG5Qv4tT52ITKn1GePm5kDH5LiB+Sz49vHkpQY16PEpN+St2ZTGfWyeOu3cQxswXeqKFyvPzZoM9KBgjpPqzwZnA/WyDuWNau8L3IyIRgs4kKfqN/Kllh6CSLhWQloE/lHLAVyHliQAexyjvWdBQlEuZVlqaSDFwF91aMYkt4s0dgcYMeZLBnAB0uCLrQKtOoyRI7lWRZa+UbIfxLrN6I1G4Xpmg6QBVf0aErcL0f0LdAmd5k0L8NIZl/h9uEiWvESmVfwnHgAEIwyIpFfFMkic48MksW2ftE9k3yzThWyDxNvBolLkn8xFYz0hOVxpCu0a6A4N4MfenpE64s03/u/yXZ31Gbo8h/Q73Kf4gwelLbE8zwLHqyKGxpZKJOXrmYrc38jWKXIVkxVU15aCJrkkyGa8qJ5uk/Fpukn8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eIPa7z2xzxuXb5wpeaJV1BMdQhlY8QQihVzDvLg3vuOTf8mrYCsgRT9sd8M/?=
 =?us-ascii?Q?uUqOIgWH5jFncgJk5w937JF+Tc2VICejxKl2NC0yeY9tt+tlw3Esiug8Bh0w?=
 =?us-ascii?Q?vGtQ3kufpFuGZGCtCbIlKprBTWzfXTOuCjrd5vZPakw6wZNcOU1t/xdEF8g4?=
 =?us-ascii?Q?51l3GnlUiC7L5emAEeuYwlYplHGUTV7du08klTfVA6SsiMPdRazui7jn7SC7?=
 =?us-ascii?Q?jqkyocoN4rm/iQ/LgbyVLjNbUcu1ctoCcA8vyY1aQnMRQOEpNmofmzapvtVE?=
 =?us-ascii?Q?j+p19HecC3eE2qbjTsD0n1jSED9JTiAlX5g8cYtXbXnZRWBIQn5d60qAFuku?=
 =?us-ascii?Q?cGWsbaShdsA+EhIZ+AoYzugONOitO5/sS/16KsfvXGJIzRtPq9yMfsEB0bKC?=
 =?us-ascii?Q?h+2/0+/oXJPHBCJksdSQbRTO6/6a71k8uNFD5VjTreN1hlNHJiA3R00anKw1?=
 =?us-ascii?Q?8H9vWlMQsKfmnjFqb91bHIbUWHq+9oeVIKgIWlS6adnqWG7bYkD4HGyvHmya?=
 =?us-ascii?Q?KydgQ/xNtFxcTUVrccJ2a4RgoFkhgGyJbzGL7ztm3t43j9PnFahXhyx+iks1?=
 =?us-ascii?Q?aCj/lwRhbdQCNKGYH94vttGMz9R9KfATK6KZjp89qven6EluZDios2yGbLvF?=
 =?us-ascii?Q?oC+lqzahpRFRQVvctuLwLtsZKVUSb1tfcUKpGnTfzTMvM/OmRr1Lx2j4vj+f?=
 =?us-ascii?Q?bt2hsu/6TAjrBe0agHD8iKM3FrQbFDa8wxwyuEzH/VSsAOPdW7Hw46FPp8jg?=
 =?us-ascii?Q?elaDuRR9ceC4ouWc+XLJi4bPNOnC+HmfNgtF3thYkZQptrQdNc9GTqN5lE95?=
 =?us-ascii?Q?ehIqjl+wZHPo61G8cslMgj2yrwRECnzeRBv0JR2JTcSoQd/3gpb2639IR7ZP?=
 =?us-ascii?Q?nQSRH66ddZAfSvtTBrfqdvB7YzstYUiZhXOp0pC8jAvom6uQORmsajn/jAVg?=
 =?us-ascii?Q?h86ZSN1FQo9JfMNvMyzGSTFs+eUMR6Tm/hCXmw1rRhG/M0bPhgkhWUOmOr0l?=
 =?us-ascii?Q?FAXYIafk9dKUlD6u4lNi+0yNCxQ2k83RU6LdFUczV4eZJ9WLEZMBGx38hFxc?=
 =?us-ascii?Q?Wynvft4mCLX5+ggmpzZu5OT8wz9QQ8tDuj9Dm3n/+3u4lidz/xFchEuvd2jL?=
 =?us-ascii?Q?BZhmWEwFpsyr0et8fJmtw9J1GTqled2dzz5qDYyqItYtUadG5RLFjnUR/jFg?=
 =?us-ascii?Q?vxxeJNZaoLHX87uJ5HSAJo8Ho0kDzsTOPJrxzuOtnuXC/l/VAsK9R/dygtGw?=
 =?us-ascii?Q?ueFRqBOPmRmXAdLqMThOxjK2AW7U/RCsE0fPxH7sZ9XeCfUDNyQ+cDwuzPUp?=
 =?us-ascii?Q?eUyO97Pb86CC79E7mAY1ChVp5QgA3F1TiQksrXvQqamHIO0gkaeHcEzRIHN3?=
 =?us-ascii?Q?eGr2Rny+2Rw/mJtxbDMtrUNlBL6oHFuZ+DS0Ye/ab0EqFlwZ6vfNNGJztAgb?=
 =?us-ascii?Q?zXDIcB2pXrwgIn/Sb+FB1F/s8b2vuTn2BL6OzSHD9DX0p4EhDXyo97KDS79I?=
 =?us-ascii?Q?ycgeNq5P+hPUn8Rcg8H40wQw0fx49QQFD6Nb4aAs6BMGVBlh+Hhl1S5SmHsu?=
 =?us-ascii?Q?52aQXMoigFXZQHo7QSe8XLHDUHIn7mjsIMi8x7IL7zf8184NeME6Lvm0Mx4a?=
 =?us-ascii?Q?upGiuR0EjvS9H+Ajazu8Q/Mq1OIXYstdgAnSxKB1iM52CnS6gFc06xUAc2Xw?=
 =?us-ascii?Q?ha2UHzit/u56xgYcxEqfXfkevl5rwbwzF1E9Pm7c4EqUMb6y/qbIafdZC2zv?=
 =?us-ascii?Q?Sat3pZ94ekx+TSz8BuRt+VUFF0Whd21S4/czJKzvVsTMkh9CTg07?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb21bd-fa60-42da-838a-08dee1aec14c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:49:41.8743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKdrQhY0ikaPmlW+cQQxO5OwhFZ69Sm39eH70XGwMkwDRP/WHkX1l/Pbi904cpk6Cq37bmOtFjAWQCjyodhT14N8hVvGM/piEyk1QTRVoB8ln7aEMapvHA7sffkesXtv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9753

On Tue, Jun 30, 2026 at 06:52:23PM +0800, carlos.song@oss.nxp.com wrote:
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/i2c/busses/i2c-imx-lpi2c.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index 2dc4331ed796..9fbdce85d7ca 100644
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
> @@ -1551,6 +1546,22 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>
> +	/*
> +	 * Reset all internal controller registers of both Master and Target
> +	 * to avoid effects of previous status.
> +	 */
> +	writel(MCR_RST, lpi2c_imx->base + LPI2C_MCR);
> +	writel(SCR_RST, lpi2c_imx->base + LPI2C_SCR);
> +	writel(0, lpi2c_imx->base + LPI2C_MCR);
> +	writel(0, lpi2c_imx->base + LPI2C_SCR);
> +
> +	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
> +			       pdev->name, lpi2c_imx);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "can't claim irq %d\n", lpi2c_imx->irq);
> +		goto rpm_disable;
> +	}
> +
>  	temp = readl(lpi2c_imx->base + LPI2C_PARAM);
>  	lpi2c_imx->txfifosize = 1 << (temp & 0x0f);
>  	lpi2c_imx->rxfifosize = 1 << ((temp >> 8) & 0x0f);
> --
> 2.43.0
>
