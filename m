Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013018.outbound.protection.outlook.com [52.101.72.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCEC449992;
	Mon, 17 Aug 2026 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982266; cv=fail; b=c7CorlS8lWqv23LykDF8mdL7TsC/AtpB/6zaZD4gxXZ1VtUHLwzt37XK08GqRZGJhIX16+gXv6owlOVP/lIxvLKWpUZM7cvEoADsZKgRIqIUnenUAWfm/OkPJWGJ/sFh6tkrXhmMsixURHmBK32fGFstPdp8T07k5vcOQ+giG4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982266; c=relaxed/simple;
	bh=pWqLsSmSpTVICTwD4xwstaO/CNzA0EpZhjVJFP8bth8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lsFs35ENYDehLSeFruW7QVlnxM7Tv3AzFIwUMa87DJ2eff/lSY1C/71l5Kyis8MaZudvyq5l9gCfc3t6KpvuRfd/Satz1s2Qs0eZErJz5pbWyAoPNlNBittYXSe52NF/hRjzg+QLJmImyUSgGDm4F0b9GprIw5LD4z0IQjnw5SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vdPByGpm; arc=fail smtp.client-ip=52.101.72.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vdPByGpm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHBR5DvEILoC4FEXa7Ll6Z+kTW4IyBeec1bB3ZVnxUh+HB8IkB6zKl2V03k8lIz4d08ph9Nhk3bHSNGISMaiN6gJ451Lu935A7RnxHZXDMZOs+ivOi3fg/7UIP+mHNy40EbuNCh/nu7iFX2/fLEWI+ak4DBWFeGpj/kBUUw2jcKkxAc9W/AdIV1dT0CZb/+UsINNNw8s77RzdrBgowAQ+JxYYlxTfEZO6Tjeh1HGnV+qaRUL6O5gqzpLbOFOfi9T4PAjFc2IWRsFErU9B+jrkeH/dNHwxgfD1x8e6ZusempXBmRymG8YjrjzdQeFRk21C186dAiJEubr21Eza6WiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt+Ubt1y8v8Oe1fn2Z+vG909GwXyfrZHPBcYZe4pdTE=;
 b=pE9c5Al3AIwaSkEU5vT7rIZPEvuWK27xIpFjPR/jJhEjcLbSDWrxxRv7zCqMN4MrLtppN7yeFjJsuGEoZANsaVce0YQbOf9emnB9PAmaymXYKf9GNTnEQUD4a82EstMxSzX+81v1bUEqtYYM8+3ZIbAa7Jiu5Fn7txUwwn9EuboORJVwDkZdkJji6F4RgXN+aj+f2AFFMbQvm+mWL91fpuONiMMwIZm2VAsJH7XrCPy1S0MIjWiv2SKNJxL+XmYzfyHYmYcwF90Zl94i4jXSbugc+qMZdp2nM1A3wiMt/OTCwAeRuF0zDjbBuzma/HcLrgIJ13aXlJGR1Vt23YvaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt+Ubt1y8v8Oe1fn2Z+vG909GwXyfrZHPBcYZe4pdTE=;
 b=vdPByGpmX7VDCXCfdgIAXs6Dgm0bdnbsbcA/Lm+mEbOamyfKwnNRddPDlT9CDMYMsVOQpi0nO3h4/ol2zSGEMMvDQd0bxu6k19D44bSECNmGSUXqWqTF1tz6SFDUoE3ZeHZ5pxi3rdrCOrw0JRtuJpVzTAJtRN3NlF57uBzorv1SH6/GRiXc9Eb/7fFNt+6FD/ZCVPlCAxYaKnifG6QrT6ze1HQY8YLdV9zkaYe/zlf80qiVSmeGVtwFDIFb3bHN3mu97UCuOLCaTmdhS6C9uEIfq5g7LFxb4lLqwjFPkQcfHFgWWUuswe33/5Tpm+WK10LjjZEHcNxpndGvCnC/jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8047.eurprd04.prod.outlook.com (2603:10a6:102:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:57:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 15:57:42 +0000
Date: Mon, 17 Aug 2026 10:57:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: mxs: fix DMA channel leak on probe error
Message-ID: <aoMvbNkUFZR8hzr5@SMW015318>
References: <20260815151720.3757460-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815151720.3757460-1-ruoyuw560@gmail.com>
X-ClientProxiedBy: SA1P222CA0140.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0aa72d-433b-4787-2603-08defc784533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|19092799006|366016|10067099003|11063799006|56012099006|5023799004|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ccVk56eFAohWP1W0hXOUVFfTgxVE2Re3EvOQ1MDYNrXsUQReRIYb1eRMErXcUgG/wLCrLTDNTwUwOuf7C8oWCSjOzODfv9/EG3fop3lkaZIDNdWIgsZ2AJjM1fXN9DXiRDn5lkdyj2PNwpgHNDinmG1b5+B9LeAXj46dr6MjIaPmgrbW9A5fFVhqbgaEelG4tEqaG2A/w8yo0lTvWTrpDggjDUcw4QRJsRgjczfyG77LQ5yC/XMWwY8ASL9UBh49C5sUlEhDmlThQNKs/AOL0DuMuS7iIF1G94RObEqUZ/OYFWIm7wp5Y4eW9yjZnBSZyWWAG24RYzOmNQb5e9CO+fh8L5ucIyIqVFB9y5mXeR/dMoCt4aA+K8ocyZ8WrQEWmnM0bqfqa+95VLIDuKKjyhBir1AcD7Hs7m147DcwyLih6TlfyeSZ5jvGADa2ubM0krhuKSHSmGzbgIpUpMIYEeJDxyouz+d2C8AFr7lCgGpfa0CUfI+R8jYRueJ8IOftB6bMSxW91vOwq9GytU+Ohf2OQBA3tNnG/j3drRsKxt/LDttXpoxoUO7s+DzxMl6GV0NfmR2yD7NZgrGy/7bhJFnz4iexPff3neaaHPdZixEXOw3NMb4ujqdTiyZer8TuJyuPDRDPyPnNoIRQqe8OG0D7Ho1W30O+PvOAvu5SfCI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(19092799006)(366016)(10067099003)(11063799006)(56012099006)(5023799004)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uQ64O2Uo8Q0K6aSIjW5X0aI8mmum+TZk9NzvbRkP7ht+5nLLlciIRKvsTRo?=
 =?us-ascii?Q?Z/1rDCe+l54o6uXE22RiW1RyIAlukQRvIxhJx99107wpPCblrC/HLw4kEbL0?=
 =?us-ascii?Q?zTAa+BfSWKnkLwUXlUCRCe74yP4O4iVQrUsF559ccoN4fevOlvGAz8E4z/X3?=
 =?us-ascii?Q?4nifpkxCZnP/3r06w4NyVR3LXC1xf6i3AcKweUabhfdVddxr5n7l+Cwe5SBR?=
 =?us-ascii?Q?+/scZC++bzwlA561SGA/zNbapicKEjj/xaS2uqXL6O9PDXHsv8pimP+add2R?=
 =?us-ascii?Q?zZy/LeIh4WkRnkR3hrKXhiVPMYoQP1qxvT82szenKrzEvr4ERWWcxLn0PXfy?=
 =?us-ascii?Q?fCNMOPrAbDjnvl0KBZxI+hb1ceDOKeYbUg5TBTdtb8UTRpVRrGt6K6bfOVWK?=
 =?us-ascii?Q?OMnjxHKWbUaBSC8+EBt+5Uen6Gjcc/RXXNfzX/FOB+nz6V75p0rZ7VB7FJvs?=
 =?us-ascii?Q?kmHI9wbjPVHbMdnUqFYxmj37Yg4+m6gNef4dgsR1iLCCzLg4LsJmcdXfke7A?=
 =?us-ascii?Q?Vo6qHCKACymfU7yC9xDgN+q+mAtLn74paSSBks3KwRncfcHpgObKWSKEArHZ?=
 =?us-ascii?Q?gwFq9qsqa3WuC3O230Z7GXZR7H99VqpS4f4V9uXYcbJ1G8QbHLqqDT8xFz2F?=
 =?us-ascii?Q?AgO2HXs2zhUQ+KMaYBxx4pcsXd/aBR2AtMrZRR1dobd/a+nAx6rD0wbSv/4H?=
 =?us-ascii?Q?pUmLCbIs2+GTZcithf2dvEISZ4z+rFr3vIeCWWmva94ccb+D+nOD9t2IU6U+?=
 =?us-ascii?Q?aHKz+ONMfVEC6R/vpIa15QHTNMjufkhL+0Vubmdb/M/sTE5fJmSH2RQ9/+uy?=
 =?us-ascii?Q?erjo2srtQ+JS6JzfxQtGxhbY1F9La0vjAjuG2IbqHLFkyB+KUujlrHGXuFJw?=
 =?us-ascii?Q?UfcngXurSs1PrejLKoY3eEB9VhiEcjIyv3O87EULQvL2uVqepLVY8YLRzzVn?=
 =?us-ascii?Q?8GubeQwxwZ/HPz+ggTghra8NsZd/M7SDr97HNbdxJYyTf77TXTLI3RFoI6c5?=
 =?us-ascii?Q?iaBjoSLoxoRHV8smcaPPw/jaH6D4JWdD13kk50wKSHeQOIqLZWpGmAu7AanJ?=
 =?us-ascii?Q?XmKrbnMyWMQIXCUSl7+Tsyz/WF8A4hZJZ1+pPS0aRMvuIjCyEvlhd9wyj4Ov?=
 =?us-ascii?Q?mLTgNmUGl6/VMABhmTyiPCdN4UqZPskFCI8zM7pSRb+ECxihEYfwspjypr3l?=
 =?us-ascii?Q?FBbdyRD+0N5UdEkD3sW2Sz+iZL1Z20e59Y5qEVm5XMi8/yo5z+Gb0r+X6y20?=
 =?us-ascii?Q?KbNwXFN5HwUQCelQBsjhdKAx7cGLTs3+wsVmZpN9yY+JTej9W1bMZFimUTKD?=
 =?us-ascii?Q?vlMm8PKE/aVAJIrNnfnlHKGzDK4/Yd/E+MitFmKEPjitQ+3oaP6pRes58hSC?=
 =?us-ascii?Q?dLJS3feH7EU62NTSzpgKbYXgx7cjLN/d4qeYUxtQRg7rU1V2C0ut0lPSQOd/?=
 =?us-ascii?Q?KJWPaK9azCaa2DUpmII+58lhyBP+kNGUFA2DZTWN7GIV8aBt7YibmZ3nZmcg?=
 =?us-ascii?Q?kScHgMtGfoHpqYHK+KF/6NmABOpUDgjb5L3+sE+ICoXqVx0YipVimtRsKgh+?=
 =?us-ascii?Q?l83nJkBH399SxuVQPFdFdWMfRKRL4jIvdWesan87vvUTF7jxJQXsa0q4X3qP?=
 =?us-ascii?Q?jQ+R4Whijrw4iLf8zXu0Gif2It8hVk1hmh4Jw+HmxpkQTGx2vsB2CkKeyCRu?=
 =?us-ascii?Q?dReG6MXmzfD3Pnat5WEv42WTFWiZlGmyEXtLtWH3gnQTxaleJkWGTRU460ud?=
 =?us-ascii?Q?BSe+f2alznDme37AGXu5BAb6QkILvN5fDhbtdXBIErK93P1OJotH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0aa72d-433b-4787-2603-08defc784533
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:57:42.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sqld+y2E+b1Vt4Bn9N+QeVBaOlrXUzElT67vb87sbKR3VSY8b8NwUUxRsW2Ah5mXBcVm0MWBNKAivQ2T4BWsjXK0KKtj6nj1XWHT0mAlbSN8hBSaFBFIQ/+7ANeCRMan
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8047

On Sat, Aug 15, 2026 at 11:17:20PM +0800, Ruoyu Wang wrote:
> mxs_i2c_probe() requests an exclusive DMA channel before resetting the
> controller and registering the I2C adapter. If either later operation
> fails, probe returns without releasing the channel because the remove
> callback is not invoked after a failed probe.
>
> Use devm_dma_request_chan() so the device core releases the channel on
> probe failure and driver detach. Remove the manual release from the
> remove callback because the channel is now device-managed.
>
> This issue was found by a static analysis checker and confirmed by
> manual source review.
>
> Fixes: 62885f59a261 ("MXS: Implement DMA support into mxs-i2c")
> Assisted-by: unnamed:claude-opus-4.8 typestate
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
> - Use devm_dma_request_chan() instead of explicit error unwinding.
> - Remove the now-redundant manual release in remove().
> - Add the Assisted-by tag.
>
> v1: https://lore.kernel.org/r/20260814134033.1386874-1-ruoyuw560@gmail.com/
> ---
>  drivers/i2c/busses/i2c-mxs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 4e07babea9c3f4..eee4fdcd9df31a 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -839,7 +839,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
>  	}
>
>  	/* Setup the DMA */
> -	i2c->dmach = dma_request_chan(dev, "rx-tx");
> +	i2c->dmach = devm_dma_request_chan(dev, "rx-tx");
>  	if (IS_ERR(i2c->dmach)) {
>  		return dev_err_probe(dev, PTR_ERR(i2c->dmach),
>  				     "Failed to request dma\n");
> @@ -877,9 +877,6 @@ static void mxs_i2c_remove(struct platform_device *pdev)
>
>  	i2c_del_adapter(&i2c->adapter);
>
> -	if (i2c->dmach)
> -		dma_release_channel(i2c->dmach);
> -
>  	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
>  }
>
> --
> 2.51.0
>
>
