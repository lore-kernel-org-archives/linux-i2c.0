Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F936A017;
	Tue,  2 Jun 2026 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435851; cv=fail; b=NEOp2Tsa5Azl9hRleS9TxGABzuUzy82HpjAqMVxQbTNcgMQKy4iHAV0K/jMUI+dtSRznmcGSSLU/l2GRkUxsm87WL2sG92Zdf7IdgsbMn/mz6Xz5WVTJ+Nq+Ca+7svQPTIX250mrK6x9gKgm14KhbnU2zsPaap5txj/Klh5f8U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435851; c=relaxed/simple;
	bh=k8uKEBN2pKp8x8edyy9rSDAc9WZGJ7wSBHxroffHR/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RidCbfNKKLREIjdSglax3O51fMg5xBxQ/k7B2sRRrWf50PzXKUCNYHOwFYn6J/sIYraqVP+ytxQEE3C0PDc33BViq215XfrSEygiOpxebHVREw85Z+P4nn5fo4HnA5v9lExQ3fI1bgn9JgkON87mc6pQkJXsAI/2iVAWnQ8PYtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aur8Varu; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aur8Varu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InIVeZedDjXfo31+yMH7//K2oQ9RVejq3+1tCaDxgbfm1d70LVkfydZi0Iy8nwZYNPLz/JIYEZSDznMBN08f7N1ESYSeKgGXtQWZ69hAl28KDHLPmbN3hrWyAsYzREgaP2z4hICaZQaLOrphb5h5j612lEZTvQD58mlBo9A3DUT747IQITIhY3Plzm2fUmvymhlZ7idYvfINJLNMXoc23+IvnehYwLv85ZqeVPv7hHOny3cbPl6FS0+7ZOjU0uASlWaknY1gC7cMmmfBgLh+9s/IN5vXsIFvSgBEeFFabwr15b3n/90hXL0X2LaAwz3Dapv13lRLqv9JcmLT/L4Nmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYVpYlI1Ds2TmRULjV9jF3RCcVpAJOhIes5qsrdqEk8=;
 b=noeP74dTv3h2j/+KcDK93LIReaKNInYvAECxbft0PsMveNi5HoA3qphIXZQ8V0MervmhlK7y5H1vCVAadOy1hjS5mrhFF5liCdbxhMqvxWRj9dRhN4ulKWTF1cZiRibe3f4ZQb39yVtbvjim4N7nqVIzB93zvKvuc1UEj3bGnbmQfn9N+zHH9UXNbVqpXm6RlZKglYsiuTqbZZNsJ7dXf8t/BkwxWeGP6WZGspoMlcaqZO17+UP7SUdhPsvc51bRW1mS2aCRdXPK4+00fck8lBxtKMyCXGRpadDxu4rMc+VBwxbOz2WmFv5wIDlUYbh2aRjSxtdieJqlUEiUESw3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYVpYlI1Ds2TmRULjV9jF3RCcVpAJOhIes5qsrdqEk8=;
 b=aur8VarueS+hUaxCJAV5je34tqlaH/B0P7xlWlbGvX2pUd1GvV6m/q4+II/10WB6F7q9VGu/HcFXnDIAw91VqOgt37Wc1qCFyjc5Y3cypieU8WF1gi0DA7fQBjfqoE0nGPcIoSJCkAibetKt16WgB+jidDs2G24wdG+XWqSdj8Ma1OZgE+Y5gHpv2EKf+Nx/sdwjHAeysJLzraDD6h/zQgNsisfzkP9Eh5vPnfxK66o+0UkycpnkPNbYmu1ZgJNFC6/iicgsI0IJh2KgxvO3OnfH6fb5bOVxryzFMKyAiaTj9o8nmLEkiS40RYzz0rU2RmTwb0c9faxIlIYWXwBlQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8131.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 21:30:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 21:30:47 +0000
Date: Tue, 2 Jun 2026 17:30:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mxs: add missing kernel-doc for struct mxs_i2c_dev
 members
Message-ID: <ah9LgLKcriw4qFlc@lizhi-Precision-Tower-5810>
References: <20260530200554.8415-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530200554.8415-1-rosenp@gmail.com>
X-ClientProxiedBy: PH7PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:510:23d::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5ba44f-1291-4b30-b05a-08dec0ee35d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|19092799006|56012099006|11063799006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	jAzJ2c8aRJho6OqO+pN7hCINLay1mQuK1bPYPML9Drg1XMJGkuudjy3LIm018qRfL4TJ/GCbhwPA1mV3yDwhDkj4A+SMeE2spV2AX2s1BLpLjAkE8fIMIzcoJezZAyHR+k6Gn1HwUr/A9d0bI1yyp/+XleiMHIH+SQOHRlyYo+5w6utR9omOizAYGpkyImMPpe/5Em4xYzrdT4aOlhX6TnD4+gtfyl3DT/MhkggCMsaBCnpEjA3dsQ4x1LRVKIgZzhj64KCtecGh8BZ4+izsSah8+/hymYhG5RtUaG7LIcihtLGSqQkJ87c3zIgASRgmJ0CYQAGjXlZjojPES6/3DITiCt5hwJHcP8t5t9LvkWn+YTndcNYNouB1IAXm2fjEDT2y2QaCEAN1Ygt8riXhY3hN1rc01EMNQEESQ5+xlAmn8T3jIXoXuWrUTaKAMWK7KM7oNTsltKAcoSEc+xfuzmRZ77B+ihyrJsAGNBWeeoHpvT3v6UzrOl2hRHUXec5HOBQenaNEbkWi23VEKJZzbK6kmndiuyRbGB/2YfEsgWyJInEgESt+X6IpX8PqA3xuD3Aef/RQlxFepoZJ4XvaD+gxKz/LmJi8pOkEVYXN8z3cyZVDW3xuQHnu0gm30vBPVhv1VyERhKitLJq3IZttR0Li6j9cvrdTCw/qo1R/O+KYkDzDC4d4D88/7pdErNZZfcswm6xZmpn75++QTh469wQ3y+8jfHQL/psSgVPvh7wIJRBHcxuqcHk10m+BT+sl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(19092799006)(56012099006)(11063799006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?npzBfc770EZPjT7cxVNCaHCDQm1IgViM4a0CcSuoDYNkQVT0xO2ifd8xoDxF?=
 =?us-ascii?Q?JSROOVYq74g2mUTsDepCSvQRFsP5SAeEEHS12OcxBYexAEKunf/aAW2GleTi?=
 =?us-ascii?Q?9klJYKIIlWa4tSlJhsoorat6DjggkJ0bb1t9v96dOHdgY7CTudKzSXGQ9EK2?=
 =?us-ascii?Q?vlWqNiTFPvwOU9NRYUga3KLRQfV/Tlra2el7r20roQ74IskRPxrel3ktp94V?=
 =?us-ascii?Q?ib1/8qpPVgtFcuwm6PPXhL8ygMdfuTM89/qp5UqkXTE9F7UzTeyE3NJ68mm4?=
 =?us-ascii?Q?hjgKx07yDehse1xa6yy1TaJF6IJBAuszHTpmsVfVyIZBTFTKPPxKOH1566B5?=
 =?us-ascii?Q?cdKkUkxwW/54PjtyNg0GT8GY+dTdj7l86dJBFQY3/LhzUhFiJAwb9qwtUAet?=
 =?us-ascii?Q?c0ZASgPULKmmAi+WMdEYsLd5gyn3DkOs/v1btPpYDTehO8fT1l7l6HFz4gPO?=
 =?us-ascii?Q?BmYi1nIyyyYk9UXKg/Y6eJRBR1UHgkKT+U6hG5UlceOp0t/gSNBE/zz7BZF0?=
 =?us-ascii?Q?w69ZaxDOE2cT784ld90WeBzg00lO/N3wWE/VE5wFN2UvINjbaU7nojldg2M5?=
 =?us-ascii?Q?7+98m/v9+dQTKeLFRNyZbZpiBllWUepc0UMvpfyYkZYVjBBr3q4qY3zpgKAU?=
 =?us-ascii?Q?EVrDtxb7EDIn1+0Aia3B0rxFVsEXai2KOVvuCfDE8X2cQt/WrCh0OXmrBzL+?=
 =?us-ascii?Q?hrfzjKdE1cstRariTc1vz5rtSk6K9GkqVYo3jUGtmyPN4AzSM5xF45B/RVrC?=
 =?us-ascii?Q?4wuaCPVGWjZUiHZ1+35jHFop9J53UmGKQ36rZXm1suO3ze9CDLqSErN5HRLM?=
 =?us-ascii?Q?aRsTIH/ymr5d1qRCE9AyhDt7VEqnnX7qBcEOhQ/Jaj1DjctTy91982bRR1s1?=
 =?us-ascii?Q?QOSd8OoycW9qJU3e8qG78w3+uCngCwwnE/Kfpub5959UrWLy4/Pdh5KzJNOs?=
 =?us-ascii?Q?PhRfZC3UZuGxOebtK4eobxYMqMjrChfCozE3OCSHpQRD/Q89qTJqH/bqJSVe?=
 =?us-ascii?Q?Ewg3iryVet5nzTH2frtvXgcFLkbXoNxc9D4yhoizQvd0Ad2ujaot8fZ3wIYz?=
 =?us-ascii?Q?TDX4kVkIY9m2hSkiRZxg4HTNcxmNe8zn8rh0+SRQ/huIrOhSQ0IfJX/263rr?=
 =?us-ascii?Q?ofrRu4maU26THjXbIDbC4yYG1+KRgsZNAL5drfP0KQjTvBGMsLLxmaD1srwy?=
 =?us-ascii?Q?mnmVNVmUzUcLDGAR/Mc7Y/GIHHstFQmaZAN8Duw6NCapIxMMlDIfe6aOXtuC?=
 =?us-ascii?Q?78mt6P67CS4fIQlGF/5dDtPRabVRIByjkeId9S+QzSrfK4WOZNa7fRk6D8j+?=
 =?us-ascii?Q?gvlWn7DiLPyUKET4WKUTtnc3KV4zTNP3sQGoG1pBgQHCkIe6Bo42NXYYKV/v?=
 =?us-ascii?Q?xdBn+tv1K7tKmsVfrbL6VvH82dXU29uDBfg8Dhs4XOvMHsUiQtxE827n/b5b?=
 =?us-ascii?Q?kadZIDfJSmuiMZU64WAADYTjEl3FzgxYInsvLzjEX8vxNDOAx3UVDLlV9fPV?=
 =?us-ascii?Q?mfuMvSZ5HU3rMcmJngJSwZ4P9LdTqmrnvB604MuB5nDVtGQwlve5CvnMCQOy?=
 =?us-ascii?Q?tvwy8ztlQb7myUenKszBTVJ7+XOZuCwIkThp7M7rANP65r8c7VuXvkXM4DvZ?=
 =?us-ascii?Q?rcU/QRa1XapWUeRhVAMWY2LINAN4UUbuLWbL4JzumjWLbSsNEN1btJZbniGT?=
 =?us-ascii?Q?Hrs46AYzlpO6R3DsSqy1MPeuYcHt6TC2jdycjEgJNhqjbQNe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5ba44f-1291-4b30-b05a-08dec0ee35d7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 21:30:47.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0J3W0E4PCpP3DSSjDMRK4/HA1IPhUYpk5y96cGR6FLxHx+UldnVl38KchJ9DX9N5pchyQqk++tz/lqFtorx+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8131

On Sat, May 30, 2026 at 01:05:54PM -0700, Rosen Penev wrote:
> Add kernel-doc documentation for the struct members that were previously
> undocumented. This fixes warnings when building with W=1 and ensures
> the struct is fully documented per kernel-doc conventions.
>
> Assisted-by: Opencode:Big-pickle
> Signed-off-by: Rosen Penev &lt;rosenp@gmail.com&gt;

&lt; is html tags. Please fix it.

Frank

> ---
>  drivers/i2c/busses/i2c-mxs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 08c9091a1e35..4e07babea9c3 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -108,6 +108,14 @@ enum mxs_i2c_devtype {
>   * @cmd_complete: completion object for transaction wait
>   * @cmd_err: error code for last transaction
>   * @adapter: i2c subsystem adapter node
> + * @timing0: I2C TIMING0 register value
> + * @timing1: I2C TIMING1 register value
> + * @timing2: I2C TIMING2 register value
> + * @dmach: DMA channel
> + * @pio_data: PIO data for DMA
> + * @addr_data: address data for DMA
> + * @sg_io: scatterlist for I/O
> + * @dma_read: flag indicating DMA read
>   */
>  struct mxs_i2c_dev {
>  	struct device *dev;
> --
> 2.54.0
>
