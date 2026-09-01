Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383A20DD51;
	Tue,  1 Sep 2026 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247841; cv=fail; b=GDZCt0fUtM+9rkvX+7YWSKJqXWPsURk1wWTUvsWZb18xGZZTvD5prD+Z3sICMcgczzzkW6TwVbLkjtszul8rBpOQNbUgkQW0BouYAzot0+0it0GyQatJmBiga32VXh88pDviGh9Loz3VWzjdq65lWz7hJsaDzgybIT0IWIUIrgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247841; c=relaxed/simple;
	bh=a9FIGQjxljXpgSKB/hpUwu8cL57zl154ZDUF2jts3BQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k/b+5cDnfKdr9ouRqvoISy8GoI5YVAqoAPA8F0EA0BU/WsnwW8eMjrhmx5OrWYm3mkpzo3W/xWrfOLTpSIRfYjnrzp5xBNygmN73gHbLPgohasKoJ11rfuGp9afBYDYWtujgXgEWYTXcwwm+kLnoSAttMAppwmnQJWBKJfdzCK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=o8OS5Yf9; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o8OS5Yf9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMufI3XdhRwwglY1M7FVmxXuZNUYVfIuqPkRRst00r957wx8ZG0puwJrzlacc2oAgKaB3GlOmo/NjzTSwyLOg7NyHNoqFFdrUXRpZ0t89NiMts4/U1mvDX8sEURaXgA/1r2jTnA9JoMU4qA4EJce5gXFlVl7AxtVNtP6Jwpc8ZoH3FFapgPgXWz79F75sGzikY+cFjBj3b4J5wOnYsOm9y3+mTNcMwKzG7MDPnKxbHU+37alKPYG5bj7tOdhK7EqhXlNfNXEUghcjVldfVihUtmNflwhDb1DBieUuIdtaV0kmALrtx4Ov/vb+Rswj6KHFim36KbxeCtUiL0/QIK48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBMiIV5LLYBQUX5h1N7iAs8P2UO30k5ckud1/y1WbCo=;
 b=D3WSIVTraOZdMY+1CPa3372rgQqzpnkapVwDLsyrLvS99PppKSIADCTQ0UHAn5n4bliDhkpBa9ATL7K351t4RoL2qvxKjglKBCIcLFZGiWDolmSsYkQtOTO79EJc+hmhB9ZKMKjZiOZA42j6A/hT2Gp8GqrxhJrvJk5LCG5EDMeKY+zQijRBltssqdDOBOJpFUw+aAtgYAeZi7SsEpGS92k6OHEXGbsf8iFzKSacBgUZpR9BNz9c+jRZeU9GlwFkIugV8qBlHgSNpiXYym0koC+zQsbdljUwGRefJn6h98ao897a4wuq4tio6jlH4tp+hbfGn6C29SCX7gww9qMtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBMiIV5LLYBQUX5h1N7iAs8P2UO30k5ckud1/y1WbCo=;
 b=o8OS5Yf9vQYGdcQS5HOR56Rx8uR1cqHQXFmw9fxvSIWmgZwxQT2KaFpTkV5xQtb7rzkF4RNj3MFESp7iJ6wAyNMDsCn8o0e3KLwhnLELj0lWyQTUq6tBXrIq0SeoELy3caRiarR5Ok4zKpC1rqV0vi3GGzwmZddanMUS57LsG2Xk4cIF2z1raFg6y1My045CCwLI6X+cBKZtVhxKvFO1c/gT1ahfvzJB+9SEZbrPl+e69wqKAYHO+eA9AepbhU4yx82yvLgdQwm9qODg4Ea7p9BV/bY9LPLC7upAsJv/NzqSGGHgTjVLUsakPmzLxGDMlockyKKzmD5CHCZOq7mTlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:30:33 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%3]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 07:30:33 +0000
Message-ID: <301567b9-464a-45b4-9bf7-eac426b9aaf8@oss.nxp.com>
Date: Tue, 1 Sep 2026 15:30:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] i2c: imx: honour I2C_M_IGNORE_NAK for write messages
To: Haobin Jiang <lemonoutput@foxmail.com>, andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260829142148.10536-1-lemonoutput@foxmail.com>
 <tencent_0D2E46A782AC418BC52A1BBF04CA1AC98E09@qq.com>
From: Carlos Song <carlos.song@oss.nxp.com>
In-Reply-To: <tencent_0D2E46A782AC418BC52A1BBF04CA1AC98E09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AS4PR04MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7484d8-d607-43b0-a062-08df07fae86f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|19092799006|376014|56012099006|10067099003|11063799006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zUmyX+ArUfIKL+DntYSzfQnUPo8q7iO6cCb0rGjpIkxeFLPLgPuiUf5kXJTulMqG70YzMqhPlhKEOluHh6/bIiUJB33vCFbgQlLJvS+yaCNr1Q2AncSUgJpVYR7obB6XXyb7Am5B1TtJqTo0T6Euo5ZsVfcNtXqc/1QTLENg0IAkpy/o1GlhRmIfkeu2J+Dh/mwGd+D5MylI6insZr4k9eV64QS5mI9uFP8wrNPLxoRJHmnSI37Do539jcnR55VuycUIQ3HD+MlekvPbeWMQEzFPwpIbvGjo7flfF/+RGK2duUTDB1ZtKa8hMlxD3eudgzg4MTVK/MTtF2m98Np2wbwd06nrWHFqFouINlWEDklFGBHtCTr0c27bUOUivKO1AyeoSxF6NrFPn9M7I4DRSct3vSJnbKA6edVxx+yuulgXes2edfjGJ8Dvt7cgS/8LmTaN+nPj4IOdOtI/S3hAWc61GZFNgfQFWV+T0txCda8zLlyB2lq7zz9bzGtXfkx8xQlnSuOpD1ONjHuFJ73WY96pt1aftAhqsp4iIlOBcDbwUl+NUdUUPxDcBr8aYejcDieuZs5DPLB7ex7GD/lVDyT3pB5bEVB1la7IWO3Tzls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(19092799006)(376014)(56012099006)(10067099003)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWZ2d08xRExlRXFqWVl3K1MzbGp5c0hpQm9mZnVnQmJPWCtMajBtbHBHSXN6?=
 =?utf-8?B?YVVFRENiS3ZzSXl1bGxHWHlKQ3ZsWUtKZ3Zna2JVMWZHeGRLeWREazJJcVBN?=
 =?utf-8?B?aGVVZ3JPcG15Y2dMNVpLc09IZlQ0SUtoODlnZTk0UnQwZ2VoTTZIK3d5amg3?=
 =?utf-8?B?VUcxckxycklOMEtCWjZxNEkxSXBQU1NIbTdadHpXR1Mwd2RlUDcyOFY3Ui9p?=
 =?utf-8?B?Z1p4VUJFUHBmMmxXcUlBTmozdjNheEdYV2VuZW9Qc2d1cmN1c2NPaG0zTGhN?=
 =?utf-8?B?UGFtNTd5cjE5QmZJMExTaUV5Ky8zZ3RLeVNSMHYrZ2xDQkkvT1dCRmI0dExa?=
 =?utf-8?B?SEZaZ21RQStiT1Y3Q3JyNUlUcE1oSVBjWjlkTStZbEJ5Rm1KVjc4SnQ2R0R3?=
 =?utf-8?B?enpid0s1QnFJZWtqZEl1bUlONWpCY1FPV3Nsbk1naXJEckNuZ0JvZFVTSDRk?=
 =?utf-8?B?cjU3ZEE1Wm1kQVUrQjI1TEt4b25ZZTNrQWxUOUorUW4ydlRuUG5ITU1IaG93?=
 =?utf-8?B?Z2txK2xQNGxzbWlRekg4V3N5RW5CRlQ0Vkc4SGZPRjBrUnE0RlZ5TkNIRnFC?=
 =?utf-8?B?QmZPb1FVKzFMekJtM2lIL2lYS0IrQWZZeDVxME9MQ2RjMUF2Rk1YRStaZ0c0?=
 =?utf-8?B?dVc3bGpEMzl3amlNYzNlbG50RURORFNKYTY0VEU2SmxtaDNSMEFIbk9TZk5Y?=
 =?utf-8?B?L0FXcUk4NFVxLzVRZVF0TW9jNjN3SkhHOVpOMUk1ZEVTVEhOR0V4M0NTSHZD?=
 =?utf-8?B?eVpmSUZIRFdpOEdEWUJ0Zk11dGc5NnJMYXRGL25KbWxFOW9NMFlQdXJsbzBN?=
 =?utf-8?B?ZXRzRGZpVVFkeUpMc0xBQkdpdDlWTG5FSXRjRDc3MUErMUtQNWRxcWFGbE9a?=
 =?utf-8?B?OFIreU9XaENKNkI1WTV1K1djeHBLa2drK21JLzhFcVJuRjVJeTR0b1Npd0lI?=
 =?utf-8?B?K0pLUmJmVEJxd1p4bjZXeTM2SGROYmpTQkNZWWZvV281aHgyVEFwdXN4VjV0?=
 =?utf-8?B?S3Z6cUFobFJaSXl6TXRGeDdVOE9FRDNBMHpLcmJRVWkrdFVPNkpCa3NaN2JD?=
 =?utf-8?B?ZlQ1VnJQOGQxdXQxbE5pRzlJei9SdGR6MHN1bk9UMnlObVU5UTlZWG5rdHRw?=
 =?utf-8?B?WElsSkxidWpVeVVabGxYbFJoc0R3WUg3TWNyWDd1UU0zVmNEREpkYWJNVlhI?=
 =?utf-8?B?L3EwSmR4aGdsM2g2TzNyaXBIdGJ3N1MrYlA4YTBtOGtLQ1NoaVFUdDZ3M0lC?=
 =?utf-8?B?UTlUUHR2VzQzb1p4MHZ3NUtBTXpWSTRWRndEeWpQdHI0NXdGQ1l5NE9HTmJw?=
 =?utf-8?B?LzN4ZnZMTkNJdW9WcUpRNXJ6Y2ovUzJyU0tWUWs5S1QvOUErcGdNRFU3b0NQ?=
 =?utf-8?B?L0hWa2YwTklvTnNkWUZ4cDRnTzFpSzZSSXppamh1L1ZScnhaQ0s5Ly9hMGxR?=
 =?utf-8?B?N3dRVHRDNTUxOHE1U0VzaGJNb3hUeC9BQXFTd09SaHh1RndhQkRGdVNIS0lm?=
 =?utf-8?B?aFNyWFRPMmZFQ2cxdCtISzNiaDJYcUlEdjR3OXVsVWR5cW9Qd1ZJK2NleGhD?=
 =?utf-8?B?VlowamxKSGdPVWhsOXN1U2RTQ2MxbEhRZm1CM3luNExXOS8vL3VRNkZIa1Ni?=
 =?utf-8?B?a3BBK1BoczRkK2ZSSndJR2hvRlZaQWI2dmRJVlhMeUhXenR1cnpYTHFvTWRt?=
 =?utf-8?B?N2xVMmJzTDNvYUlHd1NCS0hneFJhSFBmZTBON1VkM1IxcEJGN3ZIdGJnd1Zy?=
 =?utf-8?B?SUcxWnRVaHB6cDBUcVNnQkE0V0R5dDhWNjhoQ0dtZmZCZGd3VjFZMnYwV292?=
 =?utf-8?B?NFRiaGIzTHdLVDNkZFdYaWhUbStTdy9KMVhMcGdnR0UvSkFjQ1lSN2U3N0Ur?=
 =?utf-8?B?amhXVkpobTN4TFJnZ1l6ek1IRndxaXpIVlpxSFRFQ2pGWW5DTVd4MWFCWVZx?=
 =?utf-8?B?YkpRSWdZOVptSDFSYkV6cE5ja2lrM2hpdkQxTGxOUlBBQW1wcWZyWmV1SUYz?=
 =?utf-8?B?QTl5eWtUbmF6NHpTTjFDN05yTGtwd3hFR0dRMGpZN1VvclN5alB5Rm1Va1NU?=
 =?utf-8?B?Y3VkNHpjMzRuMGdoK2tsWDIrWE1wc1ZDM09HVzBpbnhhL05pQWNUYmxKWWtX?=
 =?utf-8?B?Qnd4cy80Sy95eDVackU4ekdJdzdsWCtSNWdZZ3N1ZW0wYkNOVU1Ydk12NkZ4?=
 =?utf-8?B?YnVTYzNuaVppTVg5SENScWkxMzFXYWF0dTBrR0loN1JKNTlVUVhvYXBOOXFL?=
 =?utf-8?B?UUZ2bktWeDVpS3NiWE9ENm1JbUNCZXhuUlVScDI2Q05WdXVvMlEzWHp5bGJR?=
 =?utf-8?B?d3QrV3hnbm16VGZkOW1OZWYxV002UHFxNTU4UjJ0S3M4Q1QwVDY3QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7484d8-d607-43b0-a062-08df07fae86f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:30:33.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m16eeNd0ma9eyANwhsuuE0zrvmgLJ/FCJEu20xFOvxiEu+0tXnUXHthMerGDG3v3MInDhQTLm5SEfRh+LvLGdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364

Hi, Haobin

Thank you for your fix.

1. Please use ./scripts/checkpatch.pl to get all maintrainer and 
reviewer and send your patch to every one and cc all subsystem.
2. Notice sashiko has reported some issue about this fix[1]. I reviewed 
the comments, they looks real, so you can try to fix in V2.

[1] 
https://sashiko.dev/#/patchset/tencent_0D2E46A782AC418BC52A1BBF04CA1AC98E09%40qq.com

Best Regards,
Carlos Song
> The i.MX controller has no hardware "ignore NAK" enable bit and checks
> each byte in software after transmitting it: i2c_imx_acked() on the
> atomic and DMA paths, i2c_imx_isr_acked() on the non-DMA ISR path.  Any
> NAK is treated as a fatal error and aborts the transfer with -ENXIO.
>
> There are legitimate use cases where a target NAKs a write on purpose,
> and when it does, the transfer needs to continue rather than abort.  The
> standard way to express this is the I2C_M_IGNORE_NAK flag, which the
> core honours through i2c_transfer_buffer_flags() only when the adapter
> advertises I2C_FUNC_PROTOCOL_MANGLING.  The i.MX driver never advertised
> it, so callers using the flag are rejected by the core before any byte
> is sent.  One such caller is the in-tree crypto driver atmel-i2c.c,
> whose wake sequence for the ATECC508A/608A requires exactly this: the
> still-asleep device NAKs every byte of the wake token, and the write
> must complete anyway.
>
> Advertise I2C_FUNC_PROTOCOL_MANGLING and honour I2C_M_IGNORE_NAK on the
> write path by passing it through to both ACK checks.  With the flag set a
> NAK no longer aborts the transfer and the byte loop continues so the
> remaining bytes are still transmitted.  The read path always passes
> false, and every transfer without the flag keeps the previous behaviour
> bit-for-bit unchanged.
>
> No retry is introduced: the meaning of a NAK is device-specific [1], so
> it stays a device-driver decision.  I2C_M_IGNORE_NAK is only honoured
> when the device driver explicitly sets it, which is exactly how the flag
> is meant to be used.
>
> Link: https://patchwork.ozlabs.org/project/linux-i2c/patch/1467900229-5262-1-git-send-email-tharvey@gateworks.com/ # [1]
> Link: https://lore.kernel.org/linux-i2c/4D46D571.5010907@armadeus.com/ # [2]
> Link: https://patchwork.ozlabs.org/project/linux-i2c/patch/1378857490-30968-1-git-send-email-luka@openwrt.org/ # [3]
> Signed-off-by: Haobin Jiang <lemonoutput@foxmail.com>
> ---
>   drivers/i2c/busses/i2c-imx.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 28313d0fad37..737c19688ecc 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -612,9 +612,12 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx, bool atomic)
>          return 0;
>   }
>
> -static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
> +static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx, bool ignore_nak)
>   {
>          if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
> +               if (ignore_nak)
> +                       return 0;
> +
>                  dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
>                  return -ENXIO;  /* No ACK */
>          }
> @@ -968,11 +971,15 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
>          return ret;
>   }
>
> -static inline int i2c_imx_isr_acked(struct imx_i2c_struct *i2c_imx)
> +static inline int i2c_imx_isr_acked(struct imx_i2c_struct *i2c_imx,
> +                                   bool ignore_nak)
>   {
>          i2c_imx->isr_result = 0;
>
>          if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
> +               if (ignore_nak)
> +                       return 0;
> +
>                  i2c_imx->state = IMX_I2C_STATE_FAILED;
>                  i2c_imx->isr_result = -ENXIO;
>                  wake_up(&i2c_imx->queue);
> @@ -985,7 +992,7 @@ static inline int i2c_imx_isr_write(struct imx_i2c_struct *i2c_imx)
>   {
>          int result;
>
> -       result = i2c_imx_isr_acked(i2c_imx);
> +       result = i2c_imx_isr_acked(i2c_imx, i2c_imx->msg->flags & I2C_M_IGNORE_NAK);
>          if (result)
>                  return result;
>
> @@ -1002,7 +1009,8 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
>          int result;
>          unsigned int temp;
>
> -       result = i2c_imx_isr_acked(i2c_imx);
> +       /* Read path always checks NAK; I2C_M_IGNORE_NAK is write-only. */
> +       result = i2c_imx_isr_acked(i2c_imx, false);
>          if (result)
>                  return result;
>
> @@ -1213,7 +1221,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
>          if (result)
>                  return result;
>
> -       return i2c_imx_acked(i2c_imx);
> +       return i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
>   }
>
>   static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
> @@ -1227,7 +1235,8 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
>          result = i2c_imx_trx_complete(i2c_imx, !use_dma);
>          if (result)
>                  return result;
> -       result = i2c_imx_acked(i2c_imx);
> +       /* Read address NAK must always be reported; I2C_M_IGNORE_NAK is write-only. */
> +       result = i2c_imx_acked(i2c_imx, false);
>          if (result)
>                  return result;
>
> @@ -1358,7 +1367,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
>          result = i2c_imx_trx_complete(i2c_imx, true);
>          if (result)
>                  return result;
> -       result = i2c_imx_acked(i2c_imx);
> +       result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
>          if (result)
>                  return result;
>          dev_dbg(&i2c_imx->adapter.dev, "<%s> write data\n", __func__);
> @@ -1372,7 +1381,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
>                  result = i2c_imx_trx_complete(i2c_imx, true);
>                  if (result)
>                          return result;
> -               result = i2c_imx_acked(i2c_imx);
> +               result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
>                  if (result)
>                          return result;
>          }
> @@ -1697,7 +1706,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
>   static u32 i2c_imx_func(struct i2c_adapter *adapter)
>   {
>          return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
> -               | I2C_FUNC_SMBUS_READ_BLOCK_DATA;
> +               | I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_FUNC_PROTOCOL_MANGLING;
>   }
>
>   static const struct i2c_algorithm i2c_imx_algo = {
> --
> 2.34.1
