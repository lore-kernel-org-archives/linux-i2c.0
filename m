Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E10396567;
	Fri,  7 Aug 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130691; cv=fail; b=ePKjMw3eBSlhsg6cDMy7RIc6UD/onSeXIZZimB+ksIOELoVsO1lhGvOBc2jp/9fBtNsuzMb2tk+msfTdBzSkZSfjA86MroX/rizATFQVxzw/ADlorgvuHufzsn30nrWlDmaYBCJgUB+OtPS6YwuzDetkltWEqvdLKpdd6+GRnoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130691; c=relaxed/simple;
	bh=RMBAJdXu2WqZzxcGkqazHxTWihgcWkl1OkFXTrzz6cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QVNP39/m+/fpcso9wRjVbYZIVUsSlHDtGv33Tx+PdCLlwPfBzKcWwGCQiPDuzcumqLYoi/0gJYNorS1EUzbADfEXCIlLYZm2jnz+mVuCBnH3zpZLDtrPigKPWbKlGE/As8Ry5azk2idkF93RCAq2GDBeko6of12UEhQ4DRIKaxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KFPjEClD; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KFPjEClD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsD4NBD9oOesnC6vVlFMLpoci6+1M1kxxLnnEXGB96kar5U0kzcnkC0uONA0r2ISKQrSEYYfeyHQ3Yvyhni8azzpwF+7C+KqgDEcPkeW4IUhua4nEu/+9IY+6uYGDKgdMU9PsXnclUE8bjFiveufKZu9PAvF2ZQ2Sac0Z1NAA8FKO077ItEXY4anl/uFje8Gh4eTmHBPrbIXgEWjv780INs4r9ZNZNoKmvYdwbWRjT/ZnegybZnRAdZEM62yvl/DzVk7GUUl5ntXWitzJTbE8zQ+7Q9SG1pvbj3u6WvY5LuNprqAPdKnsJ8+Uzv5YL92c6Icg6xJDevuFtt6yRATQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6wf+tCNe8Ds0tCr4QqTWkOkMNxo7IRlrCk7zhiLNfA=;
 b=gqHW5D5QyCZCBFsp2YxiIvLSJjbZdsy/qZiD7yAs2qjfjrbp0TqxUy7bqXIxgcBLKyMoFRTeWmz6vKeg9U6koQgLHQnzEbfCdUFWBMtEMePUnLQ8ldAemWcsvG0EBOA4OPBu6YQ0tsuZ1Ov2/x6/dK46hqloLjZhqJx8W6BrXiCR6Blyznjt5uRYKqXB5RO9jEuJo/v/RJjbZBlqe7KjjkNN/eDvqGEktc7yaV49topavHHQGKA4z4iKIqQBOdcMIiVUo2Mn5P18v2BBsnTwe183T9DhV1TQdFm+IxiWMWuHpClf47PQxTcVXXAZkZb1W8rHEERTymQSqzcWE8SMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6wf+tCNe8Ds0tCr4QqTWkOkMNxo7IRlrCk7zhiLNfA=;
 b=KFPjEClD+jnoA/i0swolaqF1q+j5j8Fj6durbKt5MfCqK/Sk06/AuVuebVrwxF9uhRV9vcqpvs2Fw7IVYuhyaMmVzlEGHSK3HEZlNVODcMNzf628KgyPZCWFETbilGguiUw+N7aE1dW3XKNevB3eskeJpcRTWVVY4J8iLLto+Bu0L+FAB73BEvY6BUP3xfZAM1BoXwtotiINSwzsD1d/fsGEH9pJuM46JJ1poef92CLbNehsdeXI3gLeFhh3vcYdURe9aOJpH+VZI5BvIiH44EVXFtW35wVA58GqjMw92xaLnGOjXOAuqFslwGO63wWLdjErDnZl7JhmFp5bCTIf3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 19:24:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 19:24:45 +0000
Date: Fri, 7 Aug 2026 14:24:37 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: carlos.song@oss.nxp.com
Cc: aisheng.dong@nxp.com, andi.shyti@kernel.org, Frank.Li@nxp.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	carlos.song@nxp.com, linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: imx-lpi2c: avoid accessing target registers on
 master-only controllers
Message-ID: <anYw9d3s2mONCkfx@SMW015318>
References: <20260803032705.2250373-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803032705.2250373-1-carlos.song@oss.nxp.com>
X-ClientProxiedBy: SA9PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:806:20::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c43d02f-5b5d-4a03-a3ce-08def4b98a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|19092799006|18002099003|22082099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	mUCU7JlMiuSVbvel7zjXNVDomRw4GeU32K7m86NJsyH9saeJ/brJRY7xUdQtcGDkmLi+DXWpHe2/ZgtSGkTvKN1UOXgmfmM5tt1LB9m3B0nshc8JonGwzkGhOpT+82LGFQ2LISV3zaV7AbVqmDzdLdB0u904SqJd6iU/+ANg4u4BHbs9KPAzcrQcjJD4G9JmtIW9bPxz4RDYVkEMx4h/etno852YxZ6frndmJkoX60oXP8DulIAglhp37jOvRDu3OF0LsfPviavVp4MUd2V0/54nCKCYkm7KJjrjSnHU2FUnLvdrs3zoRsaMSA6E5qmxMDsGMc24sxsydPNMbgWXcAU3Ag26p5OCg0H93BbBPinDs9UyI2mB10NT+kTunlrTTQHijDK3HxqQNWtxdVE98iodJW6mYd7IgRZcbzcHk98aS0+N4VgcFvY2EXzGtQk3NcjssN9VDCWq/YNa+7RlCDDKxWM9tNMbgLd/4hIMbsPJ7MYDPhM9nyJ9OxvCkcJGXuM0G9WIsSWQf+a1jyFLxMUIPMHcAkr920x6Mv2hFKTaedfhmzywjzcnGvCBiNkZKtefXt2Dx0Wh0Lz6XSWI38jucRPWlNEKcF9+UTpjjB+C4ShLVMUrZL5WQsYa0+74OBK888YC2+AtxJGqcSgwPfg7yw/ztErvGy0aqslmvJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4LqdhvoHvWI8ENOCg1kbEB1BeyB8vNz6B0lfzOKVg87QAUAmedkesQbTE+NP?=
 =?us-ascii?Q?MGMY9Ty95j2mS25jIm6hsQFOIl9Se0DR2bR/DJB7QCYdIp+B9UHU1Q8JVOaP?=
 =?us-ascii?Q?lYSZvmgQnEUnUnapHSTEQ5umtfnqapcr3qwDeyFZl/2ipzFjImurd+NVOdTp?=
 =?us-ascii?Q?HTTeTpR2Z3qTfmG/gLG+aJhHup4pzHsZFNm+25lOS9hFBDPWPp7no4zVbKFS?=
 =?us-ascii?Q?436p7Me2fyX203FxrUt56bMjdduK5gdSK/dNEoJ1IefFbv5pMPtlUwEEXq0M?=
 =?us-ascii?Q?UdEaRf8LUdbxk/W/0WRmeh1p0+L/ZnN1CG8kjZH9SmJs+k3WanxND/r4Tl+7?=
 =?us-ascii?Q?fQ/RI0hLbHWe2b6P5luoiwr53CH1pZJenSLFtloQhk4gsUYEaMwp3khDawjP?=
 =?us-ascii?Q?Ezc5jOGqc0xsAKdNUg2mmeW6cSIR4yXRLabg+0oACoD4t+3yaB1n1TRalT65?=
 =?us-ascii?Q?KgtUmSH9t4VvuySyhzx/0UUAsQzGi3VDcKTxcISB56Brn5S+z8LcrgIzHOqF?=
 =?us-ascii?Q?dTn1BjlE95V0PdNPXblYxn3zQXszsXWrPWOOpd/S8RqzvxWqgrAr0YF+CAhF?=
 =?us-ascii?Q?4ASfQqWHeR426Ixvz2QTztUcKrfRlm5ZiqJdkPzXJ0c1K8et+gZ1dPsvFIG6?=
 =?us-ascii?Q?K6+Q7iJLxhDx3skUGdf/53PwTlHVCEXOl1Mcyb03eSM8cY+Q2rWWf1KTBahM?=
 =?us-ascii?Q?oEkq2wKtaYlqb0O0TjGGIS87+z7Rhdz6hQFS3PYlfkN0+sTozWOcZtH8nUV3?=
 =?us-ascii?Q?ikiHoW4sxhk93sRV8NwV/alID6008g4MQuMx5VTJWLluuuoKD0kN/tENICWN?=
 =?us-ascii?Q?6B9eOIpaswsa3mj81frk8DjBqK57rl5lBZK3O9UHaeAg0l78qQDGTR1yulj8?=
 =?us-ascii?Q?w3htjR9sPakp9u+lR8tcsMT161islxzRja6bzfToJ5vmFtZVYYcOq58i3vA2?=
 =?us-ascii?Q?NIMoEox7df4k7kbbT6ESMv5hkeGkm8JDMjWfyuwToIrXDWBhFFpRYMEi+kOy?=
 =?us-ascii?Q?ekiODMMUVBmwdZ58kzGPp8beOytk/c2/PSgUD7Osr2msG0QkgnBDMWAkHr4q?=
 =?us-ascii?Q?ehnais1LH/CGQX0gzFTAXfwkql4T9vaiWQYVjs56jpTZ6hZ+hXDJRJ8cPIBG?=
 =?us-ascii?Q?aa0i9dfwWHjhk7V6WyuWelZWTQj0rDpcvCD2T+tZnnzT0sgXe3zH8pjomI2w?=
 =?us-ascii?Q?9NtHS71s7q+SSdR214eqDTD+y9bEpg5drOPM1Zd0ta1gjwxZ8JUg2SrHEwWM?=
 =?us-ascii?Q?XnYymYsaI79WYa3SVNmAvKgL7SxSMM8ZzO9gP1LEC7LLdcJ4Zdi7y07iQI9N?=
 =?us-ascii?Q?oPK3d4B5ymOjKqLbLUlD6tOJRK2jriKLwh/AqhWmvFQ25LE4KC25YINTh21B?=
 =?us-ascii?Q?0W2zcUQcGSOHrpi9qAOT73Eki43AQE7JqQGU0EylQHZPO/iZ3tTCDo8l0p9d?=
 =?us-ascii?Q?K3NvblioqfHyKbDJ8sRUu6vANDfYg9iTqT0dLqcahLa0rmkc09IJ0E94VUIo?=
 =?us-ascii?Q?d00wdi96vgnnj9wPonKULB0Grn1RE+GAv+1nLbBtE/DZdT+hW4VtulLgsFCO?=
 =?us-ascii?Q?ctRVw0OgRrEucytyGlzIOhLNJOs6JYZLUe9TayPjUJIXC6t+2SKxPoQMxZmF?=
 =?us-ascii?Q?VDMlTeX9sdRAr3BaPPa8R8jeS9yNtd2cBbksQEfOk4IE60Pz6XP8NL0Zu9OW?=
 =?us-ascii?Q?1nvkBN8VOVAMtz8s8yos+zwFX2pE7eviBUWsKnl0Nm7bnxuktyQZfmuVxkT5?=
 =?us-ascii?Q?h1+gmcax7tNpbSatLYB7uMdd+ON9lXTPzqYSF2t5xub62WV37iDO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c43d02f-5b5d-4a03-a3ce-08def4b98a09
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 19:24:45.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42zp1YZkcqc823CLDj8CmsY/UmROE1cv6Wsmzhhj6cWBOWRyETenOHpgEoIi/LOm/F8R4e8YnrPDXPy2KkyzqY9lb34vBCNgnYnqOynudv9SwQXNJYKr4QBlT907IINM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653

On Mon, Aug 03, 2026 at 11:27:05AM +0800, carlos.song@oss.nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> Not all LPI2C controller instances implement the Target block.
> Since commit 90311787f483 ("i2c: imx-lpi2c: reset controller in
> probe stage"), the driver unconditionally resets both the Master
> and Target blocks during probe.
>
> On controllers that do not support target mode, accessing the
> Target registers triggers an asynchronous SError and prevents the
> driver from probing successfully. For example on i.MX8QM:
>
>   SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
>   Hardware name: Freescale i.MX8QM MEK (DT)
>   pc : lpi2c_imx_probe+0x280/0x594
>   lr : lpi2c_imx_probe+0x224/0x594
>   Kernel panic - not syncing: Asynchronous SError Interrupt
>
> The VERID register is implemented in the Master block and can be
> safely accessed on all controller variants. Its FEATURE field
> indicates whether target mode is supported.
>
> Read VERID during probe and use it to determine whether the
> Target block is present. Only access Target registers when target
> mode is supported and reject target registration requests with
> -EOPNOTSUPP otherwise.
>
> Fixes: 90311787f483 ("i2c: imx-lpi2c: reset controller in probe stage")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/i2c/busses/i2c-imx-lpi2c.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index e1a4338bc51e..1cfd7a4c8237 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -29,6 +29,7 @@
>
>  #define DRIVER_NAME "imx-lpi2c"
>
> +#define LPI2C_VERID	0x00	/* i2c version ID */
>  #define LPI2C_PARAM	0x04	/* i2c RX/TX FIFO size */
>  #define LPI2C_MCR	0x10	/* i2c contrl register */
>  #define LPI2C_MSR	0x14	/* i2c status register */
> @@ -136,6 +137,9 @@
>  #define I2C_PM_LONG_TIMEOUT_MS	1000 /* Avoid dead lock caused by big clock prepare lock */
>  #define I2C_DMA_THRESHOLD	8 /* bytes */
>
> +/* Bit 0 indicates the presence of the target feature */
> +#define VERID_FEATURE_TARGET_PRESENT	BIT(0)
> +
>  enum lpi2c_imx_mode {
>  	STANDARD,	/* 100+Kbps */
>  	FAST,		/* 400+Kbps */
> @@ -194,6 +198,7 @@ struct lpi2c_imx_struct {
>  	bool			can_use_dma;
>  	struct lpi2c_imx_dma	*dma;
>  	struct i2c_client	*target;
> +	bool			target_supported;
>  	int			irq;
>  	const struct imx_lpi2c_hwdata *hwdata;
>  };
> @@ -1330,6 +1335,10 @@ static int lpi2c_imx_register_target(struct i2c_client *client)
>  	struct lpi2c_imx_struct *lpi2c_imx = i2c_get_adapdata(client->adapter);
>  	int ret;
>
> +	/* Reject target-mode registration on controllers that don't support it. */
> +	if (!lpi2c_imx->target_supported)
> +		return -EOPNOTSUPP;
> +
>  	if (lpi2c_imx->target)
>  		return -EBUSY;
>
> @@ -1546,13 +1555,23 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>
>  	/*
> -	 * Reset all internal controller registers of both Master and Target
> -	 * to avoid effects of previous status.
> +	 * Reset all internal controller registers to avoid effects of any
> +	 * state left over from a previous stage (e.g. the bootloader).
> +	 *
> +	 * The Master block (MCR) is present on every controller, so reset it
> +	 * unconditionally. VERID shows whether the target feature is supported.
> +	 * Do not touch the Target block (SCR) on a master-only controller to
> +	 * avoid an asynchronous SError.
>  	 */
>  	writel(MCR_RST, lpi2c_imx->base + LPI2C_MCR);
> -	writel(SCR_RST, lpi2c_imx->base + LPI2C_SCR);
>  	writel(0, lpi2c_imx->base + LPI2C_MCR);
> -	writel(0, lpi2c_imx->base + LPI2C_SCR);
> +
> +	lpi2c_imx->target_supported = !!(readl(lpi2c_imx->base + LPI2C_VERID) &
> +					 VERID_FEATURE_TARGET_PRESENT);
> +	if (lpi2c_imx->target_supported) {
> +		writel(SCR_RST, lpi2c_imx->base + LPI2C_SCR);
> +		writel(0, lpi2c_imx->base + LPI2C_SCR);
> +	}
>
>  	ret = devm_request_irq(&pdev->dev, lpi2c_imx->irq, lpi2c_imx_isr, IRQF_NO_SUSPEND,
>  			       pdev->name, lpi2c_imx);
> --
> 2.43.0
>
>
