Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE74B4023;
	Wed, 16 Sep 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577029; cv=fail; b=F2I7gWD0VnpY8r4JcswtvFy6wVUK3NF+U93JdDx3D0DLK15fS8M2HYubmnx/gpCn1qLFqfD9/0sRGIFFiorXaeGj4UJy4LCr8kIuchFGWHkdPwoTXpiU4KnAMQwBUhkjuIWdQAwidiWeWo0mp156VoSmwSGF7KZyFruoDHHffFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577029; c=relaxed/simple;
	bh=lojdUx+oH6aBTmNQiitrAO4Lz1+ii2W2e8j0hZfzpT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PnfsZm9lZ7TF8yjIHCafpd4RBv0M3YADMAF+Moj4+VrD7e/uxXRSFfrD9U58IzuzxjcmUyHVIWyYKuyo4rWwp/Kk2v6j+amf9nA3rB0cgm9h2mXnVVQ9KIxZX5XeKGcrA5quGhgYj8uVDlH4+EsTjwW4EEIhLmxnDFqI96rjI8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Dd1OoXxU; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dd1OoXxU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd2ggFblsu9A8inp5DV1r53HT/3s+uALPfVXknFHUcqCF4JGJvzuSzMM8lN+TqdaFIgx4J9SZA1uKOy6EBvC3EBsLKGz8NL90XUxdX9NtPIM6t495BKjZcWBbpPXRrHi0/tdbyOFNsAJOatjjqoeJj4ncDNoB4v0+xmdQOYxQYGaTCG+iTpTmfQWdxNNDUDgfy0t6Zdt2eBxuCmbC2/ZzwToqSTUmKLwbs+oKCG1+of+nXW1+hwvFw18mORTmSsVl2jCH4svLZSvHIA04eAXoBZYWijJnnUIZeYqEASswTmMSRRa+lkc6gwUUCc3BEq1a0heiglE5Y9434Krh2zuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNMO8XLh/P//rTxtlnaw2Rxq/9bsyltTfRpwCoSjgSY=;
 b=StFsXaEnOn7u1ewY7oMNtgm1ItRTfwxJLpZhDFFz9sWcxzRON9CspdG/kidTRy1yfqA0ANuuD1YeqEwPXUc+glU0cYOeQNSrI2KLj9svmLNmdYwWinT+sKQOEB9RVN3ZzqRlXis66+c+2Y2PI7JWsYLDJgwdlfrwyF9b1cKvoMHPbFux3kY7aS6f10GH2Ti8+z2mPQ/E7RMmw5R1UEqn9/F0dH093EgGlU/8LQrPbR+mS+3DQNRzU+u3izzHB6AGymtOukNMFsqtOdtkwA+JdbI9ORDk0CaZ4zjLIEzmv/iWRtl8YteuhOPGm72W85a0BfxAiqKMAFZrfKIqgVGbwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNMO8XLh/P//rTxtlnaw2Rxq/9bsyltTfRpwCoSjgSY=;
 b=Dd1OoXxUrRyfwlmarXkuFnXxOTn67vwrQs3ImuVC7ZiYJiA4Tci9eGj9mwu6aLQVkBix0K0JAR3Vli72/01ecU2Vu0kBnQUiuhk67CXCiUn84pmC4WlykUdFcfXawD8zJ2ziSxnOhaMgYU/BK6TS7B5h6xVmqtV88yWjnzmXTwy429ZziMuraBuShe6Xm4uTwMQXqpCL76tcY77243hQswWmpMganehx6HQs7D8uBxd8pQaYK1IY8BdgwoBhtmAWN+e5Uzt0aj9PQZUpkLFRaSepRHA1esFcPaoDWzp6Q5jQN9B9YuyBRRLmcRJfTFuDX/BAELzSAygDagWWzTdPOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10446.eurprd04.prod.outlook.com (2603:10a6:102:415::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 16:43:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 16:43:28 +0000
Date: Wed, 16 Sep 2026 11:43:18 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] i2c: imx-lpi2c: use dmaengine_get_dma_device() for DMA
 mapping
Message-ID: <aqrHJsO5xYBO4WvB@SMW015318>
References: <20260916-i2c-dma-v1-1-6dd4f1916910@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-i2c-dma-v1-1-6dd4f1916910@nxp.com>
X-ClientProxiedBy: PH7P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10446:EE_
X-MS-Office365-Filtering-Correlation-Id: b07a7abc-e6b5-451c-2003-08df1411a267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|19092799006|376014|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	5Vkl830Y8AXCtdvhO9ehaL2/9bH7WteRrNWblPwcmCGX0cO2MG/bKDTzRhp0+BfoTm1Qjc+gUi+/40ecjuGmIVZI2gv9OSUT9UleD7Z2JdbdS5fQfbprbUFXyd9Fabpix5OjPEndLU5kOUg5UyeLYs7hUCb8zNFuhSwkspvxLhLsCBIZ+cuDpdn2nBXNnKWlqgTWWzDRScPAd0yxffB2vtpjsfDuBGi4VoybP0MUiN6N/kaMpaI6a+IjxGO1sFgVoB7o3msKoaqCGRQV8mjTZcij6JpII0qfbXfTohDBmg4aCzOT3oytmR7KC5t6GNpvverbAl7JWoFDwSvihxumyyJ012ADNjZiNaraL4XVjPhcjQKjy0oGXM+sIaKMguDw0240ILrWUFbVcFjNXR9HahBXCLkcTaoimROzLe6Ctuluh2dccUKmFWp07KNI80xxc6TS/2ccR5fmDcl3Qx0bhdKQ55JXIcIUktLBYxopUh2WC4Ye+2TJ+dqMKycNUkgijJx2WBhB9tS/g+UXLbz5pudnvrXM/e4HmzKOpxGbz9TWB2khORkCcCmIvaYQXFROmSCQiIy5H5PWaheU2Zpj9t9AnTcs7Y9mSJA1zPh2varT7HMnWwnoCKqGIWvnapzKIJDSUmK2ebzfEH8nOh6cwhgjnG98KAdzHSLF6UNTOrM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j1eJav19ht2sysMFHGvabuUc4NxmBsfpHGwczn4vyinhq4W/ipSHS+L3dwSD?=
 =?us-ascii?Q?CcgNlqWW7THabspVE07sp50QwXX4nSjuLxF7mrSRVfq9C6E7pbMEOyTwDPsK?=
 =?us-ascii?Q?xEftqDtuI8lPf3kuYKxGwUOEgHF9RUiYZwFLtXMjtcKmp0OJXpCsrgJZHK+E?=
 =?us-ascii?Q?aTTHCamZFPkDzcovhLC0lZiQzMfX2qQBQ8KCAsro9r4CJu039G+DL0gyRPOF?=
 =?us-ascii?Q?OITmNbahA4dyDJgGa5QF+Ma/ESlzRgXFtYjt/VXt1O5AuKpzJk6dgB/ImKWK?=
 =?us-ascii?Q?u3kaw0hwn+yhbg+ZsDPj42TLWpy+bZKg/DQxiOHyEtl9c9IQOGYY/0QQBkXd?=
 =?us-ascii?Q?fuG0FX1gZF8RKk4jvDejk1KB1rH9Z2n++Re18/oGon01mW1qTS9mwIZSRTln?=
 =?us-ascii?Q?26rdiluzP6SoUbyLG/JwqaRxwSz5z5aY6FGWfTPMCpgELqjllyhkeO7g6AIZ?=
 =?us-ascii?Q?emFngMc+nsOyC4igNYVWc6qDyVWwMC1mWxvsWT6SGfxaHit2qsOZJsdLkspl?=
 =?us-ascii?Q?X3jrgp/AxSehy8zEZ2xd3DsyZBUr4657EFQEFwb9eWgg126dwS7JtVUOxPNY?=
 =?us-ascii?Q?kQzwHODBPlGkLcX8NkzBpbigItwAv8iytkwzKDhAqK22phXfueRWl/8uQ9KK?=
 =?us-ascii?Q?t1NixECiZXhVbVE1+QdN+wTuwsQnTFEmPHllNnJOHnCBqKLDkj0fvq5g3vgM?=
 =?us-ascii?Q?QqYDt71bwwMh0xS8OKTDykA6V/DmWmNnEmcXZwEJ+hNzCSXohgnZ+mWCZbhj?=
 =?us-ascii?Q?C2V5thlWgxVH+VoHvp/ThwfTybRrVgarSQLjs9rIRN/f/ALur7zw42wqM1to?=
 =?us-ascii?Q?w/xDVZqU8Jl1vNIOVBs/Dnfv9SAKsWJGk2EKY1h73nhQSOmpbqYlkyevR+34?=
 =?us-ascii?Q?h9fyoYRJ0XpgZYmjkYUUldKHtQkBHGk/puXzLiXxbTx1o7yy93hqG1yBnXwR?=
 =?us-ascii?Q?mc7y+7hVxLU4d5PVvIiGG0wXWSSbY0YjqGjbe6ZDQOlcwmnIdnW0ap2u3QMM?=
 =?us-ascii?Q?ozd3MztvbBz+e6V0nhIIyRg1lZJF5qjK6gKw7jxKlsGh5u6mwjLi8uzm7Mo5?=
 =?us-ascii?Q?8uEHyAFhEh/CJ2aAGspj7ZCDzn4hWZWIp9Nbrx0IE+87U0yu3Jk4i7MBn8e4?=
 =?us-ascii?Q?9t9uhcwptxWUjopluSNL6DTMbmtYY4yUnOfLqQ2VG5G2c7fHttbPVjHcazs6?=
 =?us-ascii?Q?5Ej7/ENzTV+Jlv0w1kjTi5x9Zb4qzxGpoXTB0lQCJg6jLOguFVUS9axuqlaU?=
 =?us-ascii?Q?07Gmno8ADnv/YQfDQlC0PprTBqvUMwZORBVUcaDxpQM8R2hExDLPv92opokj?=
 =?us-ascii?Q?WZlLTrjU3sZg1pMRwU/DzouZd2rDa7ZyJVKkTIh+7ljLDDSiY6emkT2mA139?=
 =?us-ascii?Q?+wTOyaD74eEtGsFUA0ebIwPGlDWFL7h2t+3Q3V70aXUTgTjc8jg1TvkbyZqs?=
 =?us-ascii?Q?7L69ZEhLGIVFtnUOP9TGPIodOH3uSov4q6j1vcv7B/yQk4y4R/ninrNBWQ6V?=
 =?us-ascii?Q?+ryXy5k11/6lUupGQ/xY0i6vx/63okUYEPygeaP4XF7znFhX+/BGcQHJ3ewX?=
 =?us-ascii?Q?o1wr3TD8UVqEjBuKq3HG8ZZGQB26SaEZP8Sbcm8VzuOjvj+5jvEHL8MrZpiU?=
 =?us-ascii?Q?bQ4peVHn9VapW+s4GlUm+BFP7/gE05wyEle2Wfp+5dI4Ue9C99Wz3k5zliq4?=
 =?us-ascii?Q?wqP69Ksj7PEmc0VWX2iDzJm57jDioFl2c6r4KU+1bxLq6GPFnconFYBTgryT?=
 =?us-ascii?Q?l1fseC3G7y6/KlrF8itXBI6WvJ9m7lpvXXQJL3JPck0mFx5rL5zj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07a7abc-e6b5-451c-2003-08df1411a267
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 16:43:28.4628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkKp5NBu5ZrXXjaLRm+eT6ZsJ8wg7gikc01sjjjdk0PVNgdCNIikpEWDSEYEdjNAdSvmZEmEbuUclOqchbvqmBlx5YKpoPaC2wgwd1zY3gXGedX3cLjvHmQEkMlmYUMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10446

On Wed, Sep 16, 2026 at 11:25:26PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Replace all chan->device->dev references with
> dmaengine_get_dma_device(chan) so that DMA mapping goes through the
> correct device when the DMA controller has per-channel IOMMU domains
> (chan_dma_dev=true). Without this, DMA map/unmap bypasses the IOMMU
> context configured by the eDMA driver.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>


>  drivers/i2c/busses/i2c-imx-lpi2c.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index 49aabef7f115c..60547006f8b44 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -780,7 +780,7 @@ static void lpi2c_dma_unmap(struct lpi2c_imx_dma *dma)
>  	struct dma_chan *chan = dma->dma_data_dir == DMA_FROM_DEVICE
>  				? dma->chan_rx : dma->chan_tx;
>
> -	dma_unmap_single(chan->device->dev, dma->dma_addr,
> +	dma_unmap_single(dmaengine_get_dma_device(chan), dma->dma_addr,
>  			 dma->dma_len, dma->dma_data_dir);
>
>  	dma->dma_data_dir = DMA_NONE;
> @@ -789,7 +789,7 @@ static void lpi2c_dma_unmap(struct lpi2c_imx_dma *dma)
>  static void lpi2c_cleanup_rx_cmd_dma(struct lpi2c_imx_dma *dma)
>  {
>  	dmaengine_terminate_sync(dma->chan_tx);
> -	dma_unmap_single(dma->chan_tx->device->dev, dma->dma_tx_addr,
> +	dma_unmap_single(dmaengine_get_dma_device(dma->chan_tx), dma->dma_tx_addr,
>  			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
>  }
>
> @@ -817,10 +817,10 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
>  	struct dma_chan *txchan = dma->chan_tx;
>  	dma_cookie_t cookie;
>
> -	dma->dma_tx_addr = dma_map_single(txchan->device->dev,
> +	dma->dma_tx_addr = dma_map_single(dmaengine_get_dma_device(txchan),
>  					  dma->rx_cmd_buf, dma->rx_cmd_buf_len,
>  					  DMA_TO_DEVICE);
> -	if (dma_mapping_error(txchan->device->dev, dma->dma_tx_addr)) {
> +	if (dma_mapping_error(dmaengine_get_dma_device(txchan), dma->dma_tx_addr)) {
>  		dev_err(&lpi2c_imx->adapter.dev, "DMA map failed, use pio\n");
>  		return -EINVAL;
>  	}
> @@ -844,12 +844,12 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
>  	return 0;
>
>  desc_prepare_err_exit:
> -	dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
> +	dma_unmap_single(dmaengine_get_dma_device(txchan), dma->dma_tx_addr,
>  			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
>  	return -EINVAL;
>
>  submit_err_exit:
> -	dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
> +	dma_unmap_single(dmaengine_get_dma_device(txchan), dma->dma_tx_addr,
>  			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
>  	dmaengine_desc_free(rx_cmd_desc);
>  	return -EINVAL;
> @@ -872,9 +872,9 @@ static int lpi2c_dma_submit(struct lpi2c_imx_struct *lpi2c_imx)
>  		dma->dma_transfer_dir = DMA_MEM_TO_DEV;
>  	}
>
> -	dma->dma_addr = dma_map_single(chan->device->dev,
> +	dma->dma_addr = dma_map_single(dmaengine_get_dma_device(chan),
>  				       dma->dma_buf, dma->dma_len, dma->dma_data_dir);
> -	if (dma_mapping_error(chan->device->dev, dma->dma_addr)) {
> +	if (dma_mapping_error(dmaengine_get_dma_device(chan), dma->dma_addr)) {
>  		dev_err(&lpi2c_imx->adapter.dev, "DMA map failed, use pio\n");
>  		return -EINVAL;
>  	}
> @@ -1085,7 +1085,7 @@ static int lpi2c_imx_dma_xfer(struct lpi2c_imx_struct *lpi2c_imx,
>  	}
>
>  	if (dma->dma_msg_flag & I2C_M_RD)
> -		dma_unmap_single(dma->chan_tx->device->dev, dma->dma_tx_addr,
> +		dma_unmap_single(dmaengine_get_dma_device(dma->chan_tx), dma->dma_tx_addr,
>  				 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
>  	lpi2c_dma_unmap(dma);
>
>
> ---
> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
> change-id: 20260916-i2c-dma-e9cd42e4e7ff
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>
>
