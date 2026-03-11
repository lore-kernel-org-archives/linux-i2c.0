Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102913E0254
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243852; cv=fail; b=p1q835pDqE9G4sZUAIK8UyjnjV0rr4ZpxEY18yoeF8Ctdam3MOYBNOROuAqwToQNUHDcDKQzBSjPmDMzu/Ok0bJerePII4ZXHhW+s0BgowsauTIN+3SwMq0Zu8Bcis+KmGL7m4e186CA3lRshK51r0x/SKnVTPccJX5E35n7zko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243852; c=relaxed/simple;
	bh=dhZCXktmcU9a5WkyqfDrkKumMOAyUYUmkgBSR2hmSVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CMz43shJ1KnQQGXEMcbHzjpt0kuSXeKMrRS56LX9pphQy6s3t6XwEdIxy3smi1vWKbN2VKUrdG2XYjJNNpXu5fAilO1yDqdlRLn4PImkwGMxKltUul5Vkef42Ftf2An8gvA4igUJbPXm9me83Q8uM+qF9MUecKjpx17KHF9nWsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lUjUbccj; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lUjUbccj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpQQXeXY+XWwqZz8SHpojihhHNhSlYaapbflZ+8NjxmnYutt4bLhnbAtDOTxmWRx5F/8YlNGCZ52iFWs4iqZIJ2raqq9EX1wKvJ3KVE12XLF06itcWOvkh81obnvFw77rWoRE8LaEYdgn2w7NsthGV/nSvc3UFLnUSyPtPcflNBLvHgH2baFQNfUcEM3V9ELUeBj0sd5Nt99ZxRM3aOENMUqpnS5bu5cAFlmgUf2WijOFJvBsMsQI9Bq6hui2tQ4FII25Pr9595eZCJAn7HE8ZoRLURHAJcjh+jadRVjmgkeGuwzgFVhwqr/IjZRkxcqo1av+WjCmDw2RngdbiS4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQfzkWHXkZP6BJIJW8fCoMbcgPTkyZw4QZ9OfySAv44=;
 b=XlOMGVAmHE9dQQJm6364XeRC8GD0s20R4UL2jN0rFMaOkULSMpc3f9yrqsnrVC6SY3MGpJ6wigRlSRLhv4DzhX0hVXdeXSA4HVcnXfh7xlLHc6s39efVuovypbqIcsa43w44Mn9BFst4qR4yNX8Lnr3VAHy4+3hsC79h9ArNZiprtWGzg0jy4UHAHTN7BZjB0bMG4UOUq0A7w+91AXfjQlNfMTgLNpp6SHPnDExfQlcxg3YCOA+4VBti9Unk/Xb+zkxNpMS+kArGe32f2wu2iufC0K5W5jcPtKWrs7NVPWT1GR06bw55mokqdA8gDcQUtAQKGL+YeEeq8kINpKtscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQfzkWHXkZP6BJIJW8fCoMbcgPTkyZw4QZ9OfySAv44=;
 b=lUjUbccjiEmGe4Ejz282Neqk8GtygCtd5h+EJOJd0WocbOllA/uPby9ND98tGa0AJaQEJY3w+0pjLR1bkrZ43e6mdaNw6JtJ/wLF9pWH2VGjdcxtzUI5m/9C3WX7mVByvx7+Zg4E8iDhLIL0FOgrPojuX5BoshsHDnOd5cv9x8qboOmuTmcwonNAuPOkggta7CpQ9qJsO39jtyoDiG4rZC/p5giX39g2AQl6cmEMYENwbYW3FsHeqh9iEflrcXewwbTV0TzPUNHxR2PTgqNJU5+50GPZXJykafHs4xNTa3sr9Y+IGazhVgsVhFWVefsMP60iBASlU+5//gPTCsFyJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB11664.eurprd04.prod.outlook.com (2603:10a6:10:60c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 15:44:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Wed, 11 Mar 2026
 15:44:07 +0000
Date: Wed, 11 Mar 2026 11:43:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Scally <dan.scally@ideasonboard.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] i2c: imx: Retry failed transfers 3 times
Message-ID: <abGNv0zHWlJK5mcW@lizhi-Precision-Tower-5810>
References: <20260311-i2c-imx-fixes-v1-0-e625034d8202@ideasonboard.com>
 <20260311-i2c-imx-fixes-v1-2-e625034d8202@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-i2c-imx-fixes-v1-2-e625034d8202@ideasonboard.com>
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB11664:EE_
X-MS-Office365-Filtering-Correlation-Id: 786440cc-66ac-4996-dea5-08de7f8507d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	nKAZ/XzJKBEJd+Wq1lhi1U3menblHx74KEj3PsjKfsfkI7k6WJoF2nlp6iwkyUFVXLta8JkTwlymbzqw9eXFgvwQOFWmpKsWbIh8YS/12YgGx8a42guH10oZxQCjt/pFOt2hRRFF3W3F7nfY8lQt1/amqBflLeSPameRyLr8lE3W1yUdQLLQfEa4lkFgses8KqTW4qRG3Gqff04IZGZDqytohQfy1TDW+0iTEZ+8yhW5eJpwZjsJzbYjjLdgHXJeZ1XyT8I3HcMUKUMpej6Xoo92Y5Y5MRov9AH1GkkpOjkr6MixqU580cp6k7fDeUDFFs7rStRWSxgMAEzqtYoMvWR+Ure+v+KYKw2G2Vva6iPaqY04bZJr7HaiEWs45ioStCxOcw/KUml9VF9DzHQbRLad3t/srgSr+m9OBZs5RcwO/uKmku40W+eXDGRdiMsxSwNlHwS7Y9Ft6ZI24mtnDfFWzUW94kMeymdti9dCf07yWqceyHR0L8oZezDN8/ExrL+51Hdd8yUg5jZq2xXg1BZDxqqwIr069IDEStEOusG5XGpNVLefNEq5JbbK4AXZHw95ZNvThFxyBjuiffYdMBbEuaty2MOB5f9MW7F7yIfjt17SmiWMuDsLKJ9YONZ3rOt42x+ZrhHRWeSsxoRNtOstgR4a0Oj618rCklhFHDHPuX8t+s8lTk5Sr+3/e8knVtGjux4iXeEOwugcMO+5UeQ7giewlTMlaAn05t+ops6eR+zOPeWHuUeNdmsiHEbCtnVjXPeJ0S0puqf/PhzbW8WspM2qvriTyHUUNKIvwWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jQpGgZ52P5P595t3+6I2DjPfT6Y2R8AOPEJEQ7/r5eZ0EifRedWOPO3c1Z8k?=
 =?us-ascii?Q?yXGlspZSQTyHWyv/SM5bhFROZPEntKghcbfafc5xWcA5t8cUZqZDgAGzfhIF?=
 =?us-ascii?Q?Q7AK+SD5EoLwuK5VW1P5dfCoIi5sGnr+ggyLIgNN+aSoxMEl9RBhqoB/Ikww?=
 =?us-ascii?Q?FKAZvXLOIduSTTnkbIKT0Iyx9acyg/kfdTjhcOlsyyy99jio0BBIwwZbJA3s?=
 =?us-ascii?Q?ofxejvG4L5eZlARdXHXAHA9vZCcvSdNEDI2yUV/HBt6+UcpSmDux/Ex3HGCo?=
 =?us-ascii?Q?5CaBlUBcEKguQwhOGaVmwdyUCG2YqYgNx+hNlpXvP7vw1CMgBU+er8QIKcA9?=
 =?us-ascii?Q?XsLyAbPcF35rCJGxG8TVCEHvr2Zv54zhJPiQjp7qrH0+rIaimTI6GM8mfrde?=
 =?us-ascii?Q?ZRuioknEc/J9Yg3IuP6p2zNuc9UwZi1z0AxPBMcbukFXkC+wzhzPqr5YA+pg?=
 =?us-ascii?Q?JGMlLhK1yvBMmCxU9Yi+L9if4HAMzUPYRxMgpCTBi2ZiEP82UF873gUxbhqT?=
 =?us-ascii?Q?AO9MMbh9hna7Yu52NQneDkqQ7fdv4PfEVjRfGdE1LpzyvrW1iR8ZW2mjoKhm?=
 =?us-ascii?Q?gHrDkQoXbnGCNhzX+YS16EwDhKkga+GAlVP91zPtiysuUFhz6LUYYZmzykmR?=
 =?us-ascii?Q?c1kZLIc6xDK9zp2y8dGKCrgsU6lyt/VHqkSIJQlOyQdNNTBJW8EcYnj4diVx?=
 =?us-ascii?Q?/SUIlVp/Q4QexkBD1vQccvSzyiWJX+yvKL3l+KivU7YfgbPrLqkG9jO64Axu?=
 =?us-ascii?Q?JAm2XOPP1RO0RRw2GDWw7Eq4YQLkGPijG/xM21WgNz4V3C1emPvOxXqmt/n/?=
 =?us-ascii?Q?wdhqp6rVtTdhuJ5GMPAcvaFfdfpUNMIBbbTrEqLGrSBe2nKGk2s4ZqwjuIWb?=
 =?us-ascii?Q?cHwOsWLLtqb35nZ6uKKrPwzr0GIzm4UT3t/7b0a+qz4T3ai1+4XrdkwaVxyE?=
 =?us-ascii?Q?wk1BncB10rgn7yr4l8Y+Tjtd0bpoaBVVnIjIRBf3hgL//ajOyarQ3AXi44Ow?=
 =?us-ascii?Q?M5PgKbtNKhcd2m15dd66gAmEk7tf+l54OfOXBydx0keCpNF6/bbP4qvnOzHM?=
 =?us-ascii?Q?oyDiE/fnkfY9qe9L/Bar0NM6RiyM7IHSAL/OzuKbSi7CUb4ruQB0HoFyztPi?=
 =?us-ascii?Q?Nv6xWDd6QzhkFtPNZTt8VDFlFMkbxX8sesDr3FFDamcWQqt/GVsZlWxLzvfB?=
 =?us-ascii?Q?75AeCMQjOb+qpTTOyRiZ6WQmBe4/6vuPT2uZCkiiUtoOMlla8drR87QCRgDz?=
 =?us-ascii?Q?B+AmeXxolEt7jgYoPh2QN2GdSfpgLZOlFSSyJjjer/V7zODafnTrVDQrv5hY?=
 =?us-ascii?Q?7GAChHcUT2nFBsI9vLX0UY7DCfRLLuXJUZSxGjEOPfVgCJ9EzPzlyV2O2cuT?=
 =?us-ascii?Q?roUmyFm6FyeVptFQBGZ0Lqp9wQWMrkcSBkdtbV6WdPY9BDdUhcq9+fNb4HRV?=
 =?us-ascii?Q?aRqNx78v1blLtyVbUTLtYr5OBWdAHv4TCiAm6KLx+NDH51j925MJpRX5RZB0?=
 =?us-ascii?Q?M2JMMm3RUTwAb3O1Wdxs1a1/lGWnZjdBKQFuiCtEOE6dP0WQ6jjd8xd1D81n?=
 =?us-ascii?Q?IPnEyhsKDeO+pXLg+v5aw8fFDhWL9/rtnGCvbhumbexFwwHuRibcCXDBr4CF?=
 =?us-ascii?Q?GzWgtV0niszrN4zsj4cFA2YltSKQt9AjoaxH+gZkD0QDVeV4bk6BV9AZY1z6?=
 =?us-ascii?Q?Plggo5S8lW9nYyBrBP+XcruHmt//ALPITJNGIsDDzM1uJUM8EkodpRc6gZxr?=
 =?us-ascii?Q?QwHt14iSAA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786440cc-66ac-4996-dea5-08de7f8507d1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:44:07.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rp5vCBVpHxm7zTaEVDtEmthgWuEA0dsZFqIr6AQ+9SeMOkxa0UvUNGIoDX0V5rlGL+fKWcRgG36ygIn3k0Y+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11664

On Wed, Mar 11, 2026 at 11:47:44AM +0000, Daniel Scally wrote:
> Set the retries member of the i2c_adapter to 3, which will cause the
> i2c-core code to retry transfers that lose arbitration 3 times before
> giving up.
>
> Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/i2c/busses/i2c-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index ed2316ab1ba8b6261dabe8af4377136a002e2f0b..fc807b4c19137b9451796d009094b26da59e8799 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1736,6 +1736,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	i2c_imx->adapter.dev.parent	= &pdev->dev;
>  	i2c_imx->adapter.nr		= pdev->id;
>  	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
> +	i2c_imx->adapter.retries	= 3;
>  	i2c_imx->base			= base;
>  	ACPI_COMPANION_SET(&i2c_imx->adapter.dev, ACPI_COMPANION(&pdev->dev));
>
>
> --
> 2.43.0
>
