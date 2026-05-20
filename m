Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023118.outbound.protection.outlook.com [52.101.72.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53923A257F;
	Wed, 20 May 2026 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270112; cv=fail; b=StoYqhUcCnumH13kcP2+pbbF6l8lIvbHYHwKzm1lbs3NLt8YTXRdr0Egbm7v6EHr7wjDBj+fsvba0PmXp+B1biH0wru/A8Xxe+Jj2L9H67iAEzYaHPnLLgU6kcr/Lxl5e1cezdb42EYDPlGlQIsmaFeviDT1fWRk4Yt+wqiZZSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270112; c=relaxed/simple;
	bh=1mjiAAXouLY2vCMpmEaf568y+dW+u7LyGM+TYr8Obos=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nsMUoIY8FNNUruw4W0bSFDmPY6QhuqeOKeAi4r6gTOC6iIV6gsjUSa/JECRYbWFB9ov5AbjCpzCJMNwBJl/GC5ehQjONZYv5zz1qf43VPcvwUO1SCmYBF62HKy/5540S9rVNzxXn6tXU54PtHB9BqEhIlBCWknosQ93TGikShKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=AjlnlBaQ; arc=fail smtp.client-ip=52.101.72.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="AjlnlBaQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHBK54OOAwWZ53ggtHDoqgcI1qiQrkYGOfyMm8uiREub1gudY25POd3xIxqnGxqaSRFxscgZlLUG0CiVhZDkCIkoTsdTY+Xt7aBvlcOX6r3cH7MCOTqlbJEIFY0ilDTeX2pH/p7LnQs2+UEyvfmd6E8w9R/WHPQxwuAvBl8mFckLnZenA90DwASnp984Pr9rvH60xJ7dcS1JvdZLdzBmjYgqBAn8IIRzVZfQv7hxLhpgnjPRJo7velqo5++xxUnp1+gubj2cqIzSlZMWpdVaQ29URJwhh3EYXs72EfMp8nSp6N+ZQGDk4cAjSzGUP8y1YuiLagoMTMhz+9QtKX9HKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuxMmB0HwKq0zRzcHXE/1ckDMXCtQMf/6aapUoEIJbc=;
 b=aZXMCSgdjEvq4bKOP8TCL9Sm9j1OqWVb+7afhDOlw8MpgUZPH/2C+lol260eVfxvNLeh4ZG9rTjyTX5eojQcNm9Uc8GWSTSJuTNSdFDzMD45L/EnACL4Yb1UPQ6/UW0iU1bfua5QRqIM8QFDI72zmxLfNWc8Np7UPmqUeF6jDhGyAw3t2E4zAW+VN+WfuX5g61msda08hKdtH3LuCaC5yGbsjH8xuO07iZQ3Ol1Bs1DFSIqX+mRfw0sj/7amemdUmVSU50SiZqa6CqbWipVWCcansX2gFzkj3tPy77RTDgm9VukKqQIYl2jYvj15j9EmojGOwSF956/2bv68SrKmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuxMmB0HwKq0zRzcHXE/1ckDMXCtQMf/6aapUoEIJbc=;
 b=AjlnlBaQGINgOlPNAkxNvNXiutNSguRYN4oycr1hyIZK6TjWSvMKw52wVWgC53WhPL+u64oTAPoLFiMNmhRimNJOVG0qT3Uzx/8J99SyCO3SWSGDQW6/upOVVBSbC/GaqktvxAge20ixB67W1wYS/sCPOUzgCRX4RbFwx4oXmqr83gZfzhkKs6LLJGLjtBt96ORGOnskLdf3Qr3vpkulabIpbN4ZAP7b61uMv2YMHfDsfpbI+1+CtDH9Y9i2Zynngm9RIa4DGZBR5LruZjfiujb6SxSh2FRW3HD6SfFZoSzaXSmw96PhvQhLSrgUlrCTS85KvwQ6fRB5wnXrspPL/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by GV2PR08MB9302.eurprd08.prod.outlook.com (2603:10a6:150:d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:41:34 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:41:34 +0000
Message-ID: <e797ea21-4874-4cd1-b9dd-61514d541f38@genexis.eu>
Date: Wed, 20 May 2026 11:41:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] i2c: mt7621: make device reset optional
To: Christian Marangi <ansuelsmth@gmail.com>, Stefan Roese <sr@denx.de>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260519223253.1093-1-ansuelsmth@gmail.com>
 <20260519223253.1093-6-ansuelsmth@gmail.com>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20260519223253.1093-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:26f::12) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|GV2PR08MB9302:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0ff36f-f03e-4828-6cf7-08deb653fae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|56012099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hm4lrmAThrloaAKXK9ppiTwDiO1bHrNKVDMPvxrd+/x0NQjFzATWWDyvfg9Txr/F7sHtsK5/nR14+N853SD8il894TETm5FcOrbhCO4JXeGsxQGUTnZN8+Lf1gfpkkDl4oKIum+AR7bySbJqS9XcaDY245tNUOXx98zqgb84n7KBFG1s8ARmLUHgGdufouQDy9uhSItM6CGOK61NFX6VUKVCEHovfCh0ACfIs5t9pq/1N90kPIB7EqC4LAI8DyfrsMP+HrCn17bf/TdhbL0M6p2QtC1fCIltNrbTJNnLkgRK89ZlPOdFoUDRiYVI1dYChOk8sF+t6SzkxdAYM9P4MquWKOkf8YBXO3MVWOa6U0KyzC//3MDzYCUoW137CzMsdmP/1xy8wPFSvmUZD/95Nhri3yXoKaOIDSfpFFbredUC3OF6Mjqv0yaT/ABYLrtV2bEKngZRYJ3cMVFGP+0BCE1M96s/gk2/VlVi7S1+B88XWvErlEzRXuU5/4OyCJjkFOIvD2SfT6TEZolBPpICv1Av0+2NKua9X0xbd2cMpt/sWwG02jPQWQINJOTQ6BtQstICnWHsB+zf4xoWWjaD3HnzO3n30i3zZF3V5IhT5mfYsvq7QY4urqe1fM0vxrChEfLqTZaugJqdvb5l3qgZvf7GOE4//zeQZ3ZZd8alfwmmseryhekLUMmYLAyZa9DDe2NRLPXbzTLG4mXkrC0qE/xv5Kj79ai77LYJZPG4wJl/JK5cTV2UcezugPMiSxjx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(56012099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2FsRjdOa0U3cXhjTnFtRG4xa2VRZkNFeWcxZ0R1RGJVTEdnMFhySndlRk90?=
 =?utf-8?B?d3ZOWTQrSWxjSDFWakVFTEpJWnVXb1NodXVjRHlJOVFKWnNJOWdOZis1dGVI?=
 =?utf-8?B?WmZqaG15TXdMWWh0dFgzVEtnQU9RZm5nQm8reHcyamFtZ1ZpL25WNHROT0RD?=
 =?utf-8?B?YWp0a0VxbGw0VWN6KzdaQWhtdWhSRm1HSng5ZmR6emswazAvYnRXODN6REgx?=
 =?utf-8?B?TldRcHplZUJxd1Zzb21WTVBjWUh4dFRPQXFPcUxMK1Vhck8zcFM1cS9iZW90?=
 =?utf-8?B?amNCZVFEUFJMcmtReExzaGtmU2FaTXJCOXh0YVVrUmlRU25OeVJ5YzhTemtu?=
 =?utf-8?B?U2llbmtqZjNDcXZTOVp5NFAvTkRlcHdGV2M2NTZaZVNsSGxnZnRIN29wL3Bv?=
 =?utf-8?B?eTVsZlpZUjkvdXh5dS9uMHNUVm9yaHhaRHU3TTI3OHhuUnRkYm1aZ0NwalB3?=
 =?utf-8?B?YXNtVmxBQ1krSkRoaENKam1WQ3VkZTZsKzluVFBHdlNSeTZQeWZiVFVBT09T?=
 =?utf-8?B?RXBISU1zb244YjJGdDlncHp3K01IWi9MY202Yi9QSEVOeFU4ZGpkVGExdFZa?=
 =?utf-8?B?VXJvcmR6N3RQaUg1RHdIUTY0UGtzQUVKOTYyL1o5OTJCR3JNRndBMzFEeDJh?=
 =?utf-8?B?bHN4RVRBYm5JZEVFM0Y2MC92RU9jZnVRVDVWOGtnK0l2Mll2MFlGejB5VDZ4?=
 =?utf-8?B?NEFqWmg3dngySTV5MGVGbU44eUJ0NS9pQVZRMUdvSW9CMTJ4bWxtUGlnZzBN?=
 =?utf-8?B?aTI0NktwRXE3a0oyZTlQQTcxME1zYXBIVUs4allCeS82RFhrYkxHL3pLQ2Rw?=
 =?utf-8?B?VjR4Mk45ekFGQndZSzhGN1ZVQmxCQ3BTa3krbmhpRkx5SG5XS0hCODlCSlps?=
 =?utf-8?B?VUQvVWNFS0xpcHkzMWVxRmx0QmFFS25WSE9WMmpvRkpWSURvQ0JXbTJXak9F?=
 =?utf-8?B?ek9IS0VmUThpdmlxRTVVM0FhbXd2Y1JLMUJqY1dIdVlNdVNZaE12SnBVcGN0?=
 =?utf-8?B?THluSmFzWmR4NUlpL0FRYkF0aTk4dVVRYmR0emJ2Z25IdUxncUVYSjhPL2x6?=
 =?utf-8?B?K1RtN3ZuU2xtRkw2RVVMT2IyNzdybVhNSXZUektSV3VhY0pPb1BHb2JXc2FN?=
 =?utf-8?B?Rm1rdFlzVGtIcFZNN3UwcTQwQjVLNTN0RTdIYU81aGVNd3BudU8wajRpTmxR?=
 =?utf-8?B?VVJvdXZTcWNwUXh3cFQ5aFZkbndYUkhocFVYdDNqRUsraDQ0d0RoOEF4T2VW?=
 =?utf-8?B?SDdYQ3BML2R6L3plMGNHMmxlOHlhTytSMktXSldkc20wb2NlbzRJMFYzZCtX?=
 =?utf-8?B?YytscjVPcm9sdlpOZ0tyWVNISy95VisxT1QyU1pxNnlNTUYrY3RDZDA0Q29a?=
 =?utf-8?B?YkRYTnd1dlF5b1ZJSmpzQkRMZlpzR2FPbHlVV3JKbTl4NWhsazRqN0NCZWZH?=
 =?utf-8?B?QXNpVVNKeUpXNy9OYzI3aldtUzZYRHdtUy9YZWIvNjdEWlFZRDVaWWNFNThT?=
 =?utf-8?B?UllIQ3p6SGNZSmdRMVhoWEZiRDRKa1lwZXphTEk3bGRUYW52SFgvNUZwWEU1?=
 =?utf-8?B?S094SVdsQ2wwVDIwWnkralpIUGRhY09mbVpCSGQ0bjZEbU1oVXhpbzNrUXpz?=
 =?utf-8?B?bTVETHV0V243aGhqRkk4L1pyZEdLU2s5YTNsaXNLVFh2cmNWRjMycUFOZERL?=
 =?utf-8?B?OWJhL0kyVi9zc1V3UnYvWEZIVjJpajRGQ210OTlTdDdXMVVuOXRFbENKcnFJ?=
 =?utf-8?B?bi9CQ3Ryd1NISERvK1V0ejBQdTVrbnZRRFVVcGNINitkU1AvL1k4a2huMy9y?=
 =?utf-8?B?bmhrNnFrTkpuZkVwcmcvQVh5UXU0cjZyQWRNOFkzeU1zcmN6WUk5MkR2cCtj?=
 =?utf-8?B?M1YzVS80OWdmbnVHK3RGWkoyWEhReVFWd0ZSNTQxVUxHWDZ1bVBVWXVIRmE5?=
 =?utf-8?B?OVIxY2JkWDh6NUZBSlAzVWxLOGxHUnBzbHUwZWE4dW5RV2prU0F5TllwZ1h4?=
 =?utf-8?B?Q044cmptTmQvQzVaLytOTEtWMnIzRk9DQjFydzFYbzZkQTJFVTluVEhlL2Yy?=
 =?utf-8?B?RzlkbWNiRTlJZVhWWEcyZlo2Wll6MXlhZHBTSFZqOWI4M2lSeldmU29jOTZD?=
 =?utf-8?B?eGwwU0ZCVEtJL1hab21MOHFvYVpYazB0NEhsN1RVVjg3bVg4NERydWYwV0hk?=
 =?utf-8?B?N2gxMWY0WGNpbUFYSmZhOHlLZnpwdElwYVl3L2xqK1diWEdyL1F5OVBiVVRn?=
 =?utf-8?B?WjdzdzBnRDBrNGJRZmlJd3hybUJuQzVhdUxwZURNT2pFTVB6TXV0V3NSakdr?=
 =?utf-8?B?VFBLSmk3WWU0UndjNnl1dG5LcXE5RjNiUmVQUVBvTEdvK2lUZHc2cTJDMnc5?=
 =?utf-8?Q?4Tyf8gaPHPyXOnPPm4/u1GbFgjZXpAY+I+3lUZjoWnjsk?=
X-MS-Exchange-AntiSpam-MessageData-1: 3vqfKWViPUcJxwcddcDSwvDFmaLN1z0aHuA=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0ff36f-f03e-4828-6cf7-08deb653fae1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:41:34.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6q3L/vwb+LIEHi8FM53uut4YUU23OHsHLW6GYwSZUxnGui7SOHfX5jCUf4XLm/AqJ/29ScBRj3ub+L6DoyfWnud/AZtcSJQRDN3akI5bDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9302

Hi.

On 5/20/26 00:32, Christian Marangi wrote:
> Airoha SoC that makes use of the same Mediatek I2C driver/logic doesn't
> have reset line for I2C so use optional device_reset variant.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/i2c/busses/i2c-mt7621.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
> index 3cde43c57a2b..fb9d9701bb10 100644
> --- a/drivers/i2c/busses/i2c-mt7621.c
> +++ b/drivers/i2c/busses/i2c-mt7621.c
> @@ -91,7 +91,7 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
>   	u32 reg;
>   	int ret;
>   
> -	ret = device_reset(i2c->adap.dev.parent);
> +	ret = device_reset_optional(i2c->adap.dev.parent);
>   	if (ret)
>   		dev_err(i2c->dev, "I2C reset failed!\n");
>   


Can you elaborate on this one? I get this:

root@XGX-B-00e092000160:~# devmem 0x1fbf8040
0x00C7800C
root@XGX-B-00e092000160:~# devmem 0x1FB00834 32 0x10000
root@XGX-B-00e092000160:~# devmem 0x1fbf8040
[  396.658742] pbus timeout interrupt ERR ADDR=1fbf8040
[  396.663845] CPU: 0 PID: 5622 Comm: sleep Tainted: P  O      5.4.55 #0
[  396.671117] Hardware name: XGX-B (DT)
[  396.674884] Call trace:
[  396.677394]  dump_backtrace+0x0/0x120
[  396.681111]  show_stack+0x14/0x20
[  396.684478]  dump_stack+0xac/0xec
[  396.687900]  bus_timeout_interrupt+0x54/0x70
[  396.692223]  __handle_irq_event_percpu+0x3c/0x140
[  396.696978]  handle_irq_event+0x4c/0xec
[  396.700920]  handle_fasteoi_irq+0xbc/0x21c
[  396.705069]  __handle_domain_irq+0x6c/0xd0
[  396.709218]  gic_handle_irq+0x8c/0x190
[  396.713019]  el1_irq+0xf0/0x1c0
[  396.716217]  __do_softirq+0x98/0x264
[  396.719847]  irq_exit+0x98/0xe0
[  396.723118]  __handle_domain_irq+0x74/0xd0
[  396.727268]  gic_handle_irq+0x8c/0x190
[  396.731070]  el1_irq+0xf0/0x1c0
[  396.734320]  tlb_flush+0xf8/0x260
[  396.737693]  tlb_finish_mmu+0x48/0xe0
[  396.741417]  exit_mmap+0xc0/0x170
[  396.744841]  mmput+0x44/0x120
[  396.747872]  do_exit+0x2b4/0x8ec
[  396.751161]  do_group_exit+0x34/0x9c
[  396.754794]  __wake_up_parent+0x0/0x2c
[  396.758651]  el0_svc_handler+0x8c/0x150
[  396.762545]  el0_svc+0x8/0x208
0xDEADBEEF
root@XGX-B-00e092000160:~# devmem 0x1FB00834 32 0x00000
root@XGX-B-00e092000160:~# devmem 0x1fbf8040
0x0000800C


and

root@XGX-B-00e092000160:~# devmem 0x1fbf8140
0x00318013
root@XGX-B-00e092000160:~# devmem 0x1FB00830 32 0x00040
root@XGX-B-00e092000160:~# devmem 0x1fbf8140
[  611.730070] pbus timeout interrupt ERR ADDR=1fbf8140
[  611.735197] CPU: 0 PID: 2651 Comm: ux-manager Tainted: P    O      
5.4.55 #0
[  611.742925] Hardware name: XGX-B (DT)
[  611.746697] Call trace:
[  611.749222]  dump_backtrace+0x0/0x120
[  611.752960]  show_stack+0x14/0x20
[  611.756424]  dump_stack+0xac/0xec
[  611.759801]  bus_timeout_interrupt+0x54/0x70
[  611.764145]  __handle_irq_event_percpu+0x3c/0x140
[  611.769001]  handle_irq_event+0x4c/0xec
[  611.772912]  handle_fasteoi_irq+0xbc/0x21c
[  611.777077]  __handle_domain_irq+0x6c/0xd0
[  611.781312]  gic_handle_irq+0x8c/0x190
[  611.785117]  el1_irq+0xf0/0x1c0
[  611.788335]  __do_softirq+0x98/0x264
[  611.792032]  irq_exit+0x98/0xe0
[  611.795249]  __handle_domain_irq+0x74/0xd0
[  611.799411]  gic_handle_irq+0x8c/0x190
[  611.803303]  el1_irq+0xf0/0x1c0
[  611.806518]  bgpio_read32+0x4/0x20
[  611.809995]  gpiod_get_value_cansleep+0x44/0x100
[  611.814742]  value_show+0x2c/0x64
[  611.818114]  dev_attr_show+0x1c/0x54
[  611.821760]  sysfs_kf_read+0x54/0xc0
[  611.825396]  kernfs_fop_read+0xac/0x300
[  611.829355]  __vfs_read+0x18/0x3c
[  611.832741]  vfs_read+0xc8/0x150
[  611.836028]  ksys_read+0x58/0xd4
[  611.839369]  __arm64_sys_read+0x18/0x20
[  611.843264]  el0_svc_handler+0x8c/0x150
[  611.847166]  el0_svc+0x8/0x208
0xDEADBEEF
root@XGX-B-00e092000160:~# devmem 0x1FB00830 32 0x00000
root@XGX-B-00e092000160:~# devmem 0x1fbf8140
0x00008000

When I look at the current dts:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/airoha/en7581.dtsi?h=v7.1-rc4#n322

it looks like the resets are just crossed with regards to the nodes.


MvH

Benjamin Larsson


