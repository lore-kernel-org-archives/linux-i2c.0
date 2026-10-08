Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056443498D;
	Thu,  8 Oct 2026 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446967; cv=fail; b=b2I50s/Vr7/EtcWYIlNPP//h9R4TTd99kyjPiXpfExC0/m3fHeAB3CGSk552ib8DvdJRAtGcf8ORb5mJV0JNTxzFgZWYRn0qxC01SKgotweUXfy6CftgzHX0cMqp9y79CgwdJhrZKznahTG/KKUc6u/LeQG1eG2DZ2cLz0+MUuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446967; c=relaxed/simple;
	bh=OCI6Esl7NgZNk6qJB3kqDmiSGzy7StiVRcD9PoR9nC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MzgodhE2Phj/cXBJP741h3//j05dj69sT0fQ99besdYdZETQAR0oeaR2KXd63+ADLuifRDzBkHVRYTOHy6WHgy3khSkgFQUKkP+GkXQxEnTNZ7ScsiymYElmW4d0S0wCrPVwH9OlZXZyPAZ6Q4xVDpPYSvdc+LFm3sVAqlv4VVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PVEztD2B; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PVEztD2B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2PN4OPw0WjVRad607cOcLcBfe9rEeZtR4nggzM9Df0BO5P+pC/7eTQfkFksZNhWaoCAPStVspCExapAwKg5gUIQyu89dNhdOJOxjhUch6Qwz8+1mKAPU4FtfWoaEp1qBMy+nxDhetCGnKqjOrdnEujRDIZNcqjS6ODyvVGKMQFKbPRssYbcg5VHKEcxl+twBh9kSdi5XctnPKs3reqcgTtn2tVP4aDDJoipjSntBoeO13xVkA0cxn7Sw8vVoAN68BHzUp7GhWwQZK0hBO39mLP/JfupC6q/6njI24JShMNzrWji4fzYXiRo+vEWF7pRUa4S9WUlY8nJ+87cDhwXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fM/NbUuCcz+NgvMURmV1EbbFKSjz9HBGBfgCogf+hI=;
 b=WCmuInje1gKzwQpELLAHffmR3qGf6D8Y8DC/cGyNnGKb1HHLA1v+bFIK0bzXSm2+Z0Cw1ZH0676Y+jfCsJ5cPxnd3yfmCseld+xGWqp0dG9cxFx5PYKuLMGq/SGzTs7FZvo/V1TR1ZuJnEC649WPi8ZXd9CLhbc0YlShyTQyKiNZfY8FDPlFO5RqJ/QTd2Moot+iGc2ZCsFHcz8l+xBk14XEmxTZQjieQ8htXCEatTFs7XZJ3lRw3UvLePmZbHblAynGVbHyAmmSHvWhkuseKSL388TWTYSXlbj8o6vCKxdyWfgh2SkS3Whwe3y6d4odsZLJwI1xsFJCHmgfHNSsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fM/NbUuCcz+NgvMURmV1EbbFKSjz9HBGBfgCogf+hI=;
 b=PVEztD2BmPzvL3FVsQiaJF5WRUaXEHDAvjAYvF06G3DCo4qhFC2yTDi4B4pUd0rupRnwKYuSlm/lPPvjcmmd03kwkGhaFTzAbaDHB+Nr0ru3vvTJ0UsBY+s9NKaiuWoB3bJtNs1WNOA+eiCTBahC+lKaxKPdaw74ViBrA4RIDhv23FEl1gbYCpvcbZUARizrLhBongnxv3ProDml+VZ1USTdUahgVxwHrBSqDgdrT+5gDaysIyew1tFgnXPMRicoajb+8e+EJTUMYtYI8JvoCn3yH6KhO3p6ViY1jZpjY9Q9FF2lANlV6Sa5dc6VQK5nhL7czbE9oOJLKvJfhYiXvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by MI9PR04MB210814.eurprd04.prod.outlook.com (2603:10a6:290:c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 08:09:22 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 08:09:22 +0000
Message-ID: <ccde4ec9-ec40-4715-93a0-3801c57809ee@oss.nxp.com>
Date: Thu, 8 Oct 2026 16:09:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] i2c: imx-lpi2c: remove dmaengine_desc_free()
To: Frank.Li@oss.nxp.com, Dong Aisheng <aisheng.dong@nxp.com>,
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:FREESCALE IMX LPI2C DRIVER" <linux-i2c@vger.kernel.org>,
 "open list:FREESCALE IMX LPI2C DRIVER" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..."
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: vkoul@kernel.org
References: <20260929190605.3516147-1-Frank.Li@oss.nxp.com>
From: Carlos Song <carlos.song@oss.nxp.com>
In-Reply-To: <20260929190605.3516147-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::16) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|MI9PR04MB210814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba52355-3038-4ff2-8fdc-08df25137574
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|23010399003|366016|22082099003|18002099003|10067099003|921020|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	ncR3v0maBl0WZ/nvCPEGx2wWcCAN/vVTguemJo9fQNyY8fPYh5e/FqgrojFSkmtSN7G7LbSHuOqROVC0ADZVP2IFEThaTJeeugPSK5JnKhOXRa0uepwC3yQhVcKaFOXH87oRq+n+wu88A9Y3z4+vY+HSeic8enCowJ7XrVEmbWp0j/ZTU070K1n5Ccx7lqCNaAKHpyV0jQDRfpSadzG2kXT2aGmTseFeTntKWtujWXADt4K3w/px67Emiho6kmMCPcBfdM+BrzSwIoP0XIvxr6g8Y/X5GqxaRo6WzybkUdfKPm3dRYGdqvJdkNEA8TtOu1VkEy/t/tFf8DsTh8eGUTzJvM295SngpH+BqlgRYnBFMgHRzv7MRhfFwgmQAQWLPlCb4yiawlmug32cZE0R05FaJ8ySwo16YV5p40afgPN9whiwGFgiAFykusThNop18emsnWPqvPdSba5HK7oRTGYW/Mo7Don/7408cQg3NoISTTRc5R2sXnEgNfsRvzNpbSN2Rqk+xuIrDeDmeoMcTtYPT+xyxcXFVOa4NYWdBTCDwVqKbxVkBLY7jEXFzjjERxUBBppeNosqcGogF8yeCcQRyxnRwvVettdqM/cCPghWR06f2bn8gwk/OUSG+awLPmQxhOwO6O1nGJXN10MGglJ+HJpf7sWrkkmVXjGmtkhT/WRDvboLimYpQuxEAJkuy/ZnFahWSDY/l15/0c/XaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVB0RDduV1Bpeit5WTgwQytjaU05MlFxN0w3VThnRGN3U0JCcnJKZzVHNUI2?=
 =?utf-8?B?OURIVUVtdnluajBlL1RldTZaT3NiSjVEZ3E3bldJWDNwRXYvbHQrL3l4R3Ft?=
 =?utf-8?B?ZmJaa0ppVHZncStiek42ZGw2dzlXY0FUL3R0KzBhWFdxY3NTb1RMbzdWVW5R?=
 =?utf-8?B?NkpML2tZZlFEY0cxYVkzVUxEYXJ0cW1CUEJzMUNzaVFtUkxqdE5CSFNSUVdq?=
 =?utf-8?B?MmgrTGJ2d05HSDVKcWF3NDgzTEtCOGJ0SzBUc0sxQ0dBbkMxQ0U0dXJwU2Ex?=
 =?utf-8?B?d3E1dVY5eUFpWStNemlnek9BVzNXRENtZS90RDY3Z05KVVVKSERVUVg5N3R4?=
 =?utf-8?B?eC80SkdvYncwVkZEcFVZdHgxbE4yckJYV1JiRGY2bElxV0FtaGM0Zk5iSGRK?=
 =?utf-8?B?UXFsbnRhdXJzczJFTlptVXAraWsrVU9iWUxjNWRqT3EyRkVwV2JqTDJYR0c0?=
 =?utf-8?B?NHk2YTQ3OVVlNS9IM3BDc1BKUERGdnM5S2VycnBoU0lWek9zaG9vVlNpU0RF?=
 =?utf-8?B?aC84OGhlbExzY0RoYkNnbHpNTTV2am54aFdIaDBCVXc0T0ZqdUp6ODJKbnk4?=
 =?utf-8?B?dXJlTXlIREFaS1dockM0YzlvSnkwVm9DSmRiZG8xb1NIV2ZxVHZ3eFNDL0Uw?=
 =?utf-8?B?Q1AvSmJnUUVVU3B0cDRqdzdiUFJFdW5Ma0FuNXFteDkraTgrcU5PWk9iVWRJ?=
 =?utf-8?B?OHRMYnlvdlYvZTRlOEt2K2NHSHpRbS9uUjlwK0xVUUZ3MlEvekNsenowYlhY?=
 =?utf-8?B?SEtBa1YyYVRQdE1HZXFTWHE1bnZCVnpXRU16OGcrQjJJTE1PelJLWHlmbEVX?=
 =?utf-8?B?Tk5lVGFXTWFlUFBtb0hWU1lPRDh1TlFCMEVVZkJxeS91em5jRGhaM3JyUDc1?=
 =?utf-8?B?eXMyS2djZ0RlSDA4MmUyM0hhUUVtbmVJL2FhS2w2bUhlQ1Z3RUgrcDlxcyt1?=
 =?utf-8?B?MUdtN3dNRURuUjl1d0Y3S3g0MnI4TW96WFFCS1FsUllJY29FVGhHQjg0TDY4?=
 =?utf-8?B?d291Z0xXRDBQTklXTDlidmgvSEEzeS9KYUJRQTVlTlpsYXJSelJWc0FuajdQ?=
 =?utf-8?B?VkhlU1hTRGNvNWpEcUdlek1SaHBGMmtJKzNYMVlubDU5Q1dzYXNPdUlJb01p?=
 =?utf-8?B?L3dWV2F2L3JVR25ldUFFSFZPUzJEdmtnVEpXdFJlQkdIUWI2bHE4di9JYnBp?=
 =?utf-8?B?K01USkpqUnV1eFVWK0xacy9wRUNxY01nR2hCa0FGajJUUEZ6YjJoeUNFY2JD?=
 =?utf-8?B?ZEY5dm5CeVhCcUVBQ1FPM2crYzFlM2ZaUmJzTTJ4WFJiakkrQzBPK0NyTElU?=
 =?utf-8?B?blgrNzB0VGl0V2JpQ244S1MzWUcyWENZdldYV1ZGSWNCbmRvN2lQdk1vK1ll?=
 =?utf-8?B?Tmd6VEFwVk1NeDlHSmhkNndpelp1N0UyRU1oN2JYNGZZc1NzYUpQWVU2bUY0?=
 =?utf-8?B?dzZxeStRaktITnczY1h1emhxTDlvSlZLZ0R6RnZrOFVaanhvS2YybDFnTlZC?=
 =?utf-8?B?NHhiaHFFRUwvYWdnejNFRmRjZXF3VzlNNEx6ZVQza2tmWFZSZk5jTklDVzJQ?=
 =?utf-8?B?RmFZa0xhMndEU1hzcWRvMVpJb3JDUWx0dWlLTDRGL0UxdDlsdnNFZEdTci9s?=
 =?utf-8?B?eEtqKzR4NGMzYVBvVFY3M0xrZGJDcFZMeXZURWVaTG1WdzdTYlVxVC9YV0VE?=
 =?utf-8?B?VXJUaGNqRVdJUCswcFE1UlJIQVg0WTVyTURSc2Fhd1NuVmRNa0tiSVhSMDBx?=
 =?utf-8?B?OTBBeDY0dmU2cGFvczNuUFZiZUNuZ0gxODZEMlpLVlllWmNURHV5dk9aOEJB?=
 =?utf-8?B?NWlGeTdNbXo4Rm9pcnI5RjZ6YjJnSU9jaUpVK0x3ZHIvQ2xMOGx5anVuaFRF?=
 =?utf-8?B?RVJqNmtVcStuYkpzYlFPbFpmVkYxN2wzK01aa2dKOUpJWjJtN3h3TWpDS3o1?=
 =?utf-8?B?elJjQ1N1eUVYRnBtK3ozQm1BMmtnckFQTis0c3VWZ2hLVGgyWlpRUlExWnda?=
 =?utf-8?B?VmNLUFAzOW1zR1NLM1VaamlmclFwZUxNVk9hU2xOZW1IcHVsbnUxb2VQakhB?=
 =?utf-8?B?ODdHY0NwTjJFN0hvbWxNTG9MczRBaUUzY1p2SW80dDRLRWk5T3hyQ0RPbVh1?=
 =?utf-8?B?U0xkekFWN0luaEZXK3kwd3pvZWRMSzlTYUhLQWR6ODdvSDJyS2R6TktrQVVV?=
 =?utf-8?B?YTBlSjhGQ29jZ2dZeGNURHE2VG1XU1RReWNwdHYyQWg3Q1hoM0txWHlmeXZi?=
 =?utf-8?B?U1FXb3duN1ZUL0o0cC9TY0c1c3pma2V1SFM0S0xNUTY5clRPNUhnaUlkVVFz?=
 =?utf-8?B?YnRsY1hkakMwdkR2T0tqdWFvQjRyV0FyamNnQjd4OTdIeTZQVVVQQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba52355-3038-4ff2-8fdc-08df25137574
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 08:09:22.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSijm5TXbcHP8V8uAKucvlZVYI5yEET8oRbVsw/07rmenXmE4NCOmVaOe8vBYwiWtY1k1+hhR29lAreUDjUZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB210814







> From: Frank Li <Frank.Li@nxp.com>
> 
> dmaengine_desc_free() is designed for DMA_CTRL_REUSE. If DMA_CTRL_REUSE
> is not set, dmaengine_desc_free() will return -EPERM.
> 
> 	if (!dmaengine_desc_test_reuse(desc))
> 		return -EPERM;
> 
> So calling dmaengine_desc_free() does nothing. dmaengine_terminate_(a)sync()
> will free all already allocated descriptors.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx-lpi2c.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index 49aabef7f115c..d6f266e2d6bea 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -851,7 +851,6 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
>  submit_err_exit:
>  	dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
>  			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
> -	dmaengine_desc_free(rx_cmd_desc);
>  	return -EINVAL;
>  }
>  
> @@ -910,7 +909,6 @@ static int lpi2c_dma_submit(struct lpi2c_imx_struct *lpi2c_imx)
>  
>  submit_err_exit:
>  	lpi2c_dma_unmap(dma);
> -	dmaengine_desc_free(desc);
>  	return -EINVAL;
>  }
>  

Hi, Frank

LGTM.

Reviewed-by: Carlos Song <carlos.song@nxp.com>

-- 
Best Regards,
Carlos

