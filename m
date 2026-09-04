Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A783DD873;
	Fri,  4 Sep 2026 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511226; cv=fail; b=U7kzLkGnttSTu9TMA8Dg4vXB/kA+B6gjym9t5XUFukPvErdCLzpYUheXSOQCgVGCWTrHGHI9oYt3bpTgxPa6eopV2sH9xvWTAJwWa+Z7AonX8OXx/q6GVitWeTnUbpRTmr7dzzd5K7uQeNxTxZkkKP8WnM0gimeruXVcc8tJReE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511226; c=relaxed/simple;
	bh=8RlKJRX5049wq+MXcuGXd1/gSvNDSqsN+ls7s4oc8mc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZyVNaV2eQm+MuJdPtaoc39cBZQi+5d6/rYlUQz0wAUC3vcG8sygxN1D2oDvPoMckYdbnom110ruTBYCqYuw5+M5v/SSNTjCegUmOQhPKeyfn/RtdeAQTs/aawRlcqiK0JaWpoXI8LCZcA+jF8GbYnFjPTHy0d3fnKh3yXmO+yfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=shhGinkk; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="shhGinkk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ly1NFnXei/RnPvd8rhmnMArcEFS9FN5zLuowKU9L3H5Ch/x+xRHaLM/n5a703uJGzmwTx9TdB/o2ZYnxfR+N6KRgGr+q92GRW48Pb0RFf9W/U8aNYFPVYhu7BlcJy0nAZrojosqzk/r2MEYYtm8ccnOh8KkAUbPY3/1zRqr/NuSeSfdVU4uve1cRlEQ30PDd03aqj3v18UfUcfH0HXWAuXGNk4SNaD7nUGelIE93Vt1jKj0GLTmUP1PbfUbAAE2I6CZkBYjAfkMwk7rI8Ssq6pJMkJg2/96L5hplSxY1MQR2YTOgE2CY0MCAmwMZhmVjeHWuW5JsAEI85KvlLYzrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkYiYQEmsKUKMldVvgru1nQDZEkS5hGNscE+JYaTVU8=;
 b=A+AUmrY8sP3PR7yLwZYx84psVbeu1It9nwj+RHv0uACuh85xOYYbtMhumfLIByNrpuIm9cmeHSWafcrN20SA/qOWLcQrqnNnyb7KQW2qbyCUnPtERNUjfe/oaw8klvuFgNbcjj7n0FElPBdfcoz8CrbhFaoSArTUua8yeJrkPYYSeksHppFJBz14uSPzaU77KMheEA1ZrX9q/Jv84HIGCuOlXcU7+7iyLwze6xm9Js/8mVOGnks7PCSVcOj1lD/0+kwgYtlIgfnn3wWS4XM5j/5kWQBqJZVkTma9O9PXz6h+hbSamsD2J8XJKT57VsJ3ntVTfJgk06pbrHj/nfG0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkYiYQEmsKUKMldVvgru1nQDZEkS5hGNscE+JYaTVU8=;
 b=shhGinkk6R8BFp62Gdb5xefinJt3yqWXZTrT+ssPNP4BFstagvzI6Fom5ClxqcE68M8o2zrcE0P6tJ/G5AopoM3Ae0IM5WSe2tE0SuJDaGOaI24QJm8uJ7CkEQ+C5xlEiXhFyAMS5eo/VLpXUhSoqdjMTRSuYiqv/sU8cnKood1BmrgkLURVUYcDLGIfBsQBvWlSG0EkohJwxviy09pab7JTChkS2460J2V5RXgP2arp6M5n8GKhRO++ccnsM4gTjn2siVIItLerf3RP5XZF8ZI7sdhVpucJghPIcQxnhrYUECyJKH0uRtlvAOI/NtZUfGQ8tqDeCQaGDXl3Ymra7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by PAXPR04MB9471.eurprd04.prod.outlook.com (2603:10a6:102:2b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:40:20 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%3]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 08:40:20 +0000
Message-ID: <ed9e17f4-e43c-4851-a9c4-73f94c57a2d5@oss.nxp.com>
Date: Fri, 4 Sep 2026 16:40:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: imx: honour I2C_M_IGNORE_NAK
To: Haobin Jiang <lemonoutput@foxmail.com>, dillon.minfei@gmail.com
Cc: Frank.Li@nxp.com, andi.shyti@kernel.org, festevam@gmail.com,
 imx@lists.linux.dev, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, s.hauer@pengutronix.de
References: <51425573-3687-486e-876d-f94d57844894@oss.nxp.com>
 <tencent_578ACB00C8862E1EA60EAC378A712B69BE09@qq.com>
From: Carlos Song <carlos.song@oss.nxp.com>
In-Reply-To: <tencent_578ACB00C8862E1EA60EAC378A712B69BE09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0115.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::15) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|PAXPR04MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: eb981f3b-4ff0-4385-ab41-08df0a602740
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|1800799024|7416014|5023799004|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	11Pah9QsBwvsTU5kITkhcwDEo4xb+1nlMbpdl1BxiU36qrZ6YSneoNXvUZi/CfP6iHv2Tc2titYsjrphxAjsZRq7udmdpauCsJ39HsOKtLy5lk896UN2gMM4YiY249zumgGxXoTjCrGO2nk8E+h/TJiWqo5rux+K7KBWvBhE00J2irjbN2c92kPXWYLhTPBhguLRsv4+gmvjKO9Lw7zn6NJ8ti82lTDDx4rmlAL/GScEoiHHpukF/TgxVPcdy370LgIyjgVRzYKpu9pCWCdzMigJ3+hfDKDXp5A9Ywi8cxIo92cqKtNKGkqB0X9ONhBdw1kW7Ef+X/jqVypbUv72Jjwb2jCJjvYZVqoDoMBdQ9Z8jXBdYiSjOy8AS2LCaosTP32oYrtTkmwXLEgEOwdqOdiIq0zsOwCKplZJ48jMAHV+6pdtyv2M5nn7GEdcFM9B9WOI+GiFTLBUUzRljKuAbv7Ry5AP1FkU8B39cZ9iApYTMyFYQ6+u/zQC+1aTewbwk89oe7CPRmVYv5UY2sTlwQxfQZgmJnaaYgnQEP+Hi38xcMc9A4hMfplocAn9xSCI5hyDzye5jxgLmCh7wi812+kxLzRZiaLWzwFbtO+EINx+lLY1lwOho0uxSCzfdusGeUXacYtrNB4cBYYCcMyE+gPyXaVmxf2cDIocieNKH0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(7416014)(5023799004)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enNKRkdtQkh6OWd3TG5VMWI0Q2FCeTBMTEcvSi9vR0E2Vjdzd0NwNjVjUVM3?=
 =?utf-8?B?d3FFQ1hIbjJ3ekZXQ05MVVZwQ0FNaTlPT0Y0ajRJTFhvY2Z4a3Q3UzkxZDMr?=
 =?utf-8?B?cmpSM0puVmZvT3ExelB1cEoxWjNoYUNRTUxQZDAxZ21STGx3VEI4VVcyUTQ4?=
 =?utf-8?B?S0IyT21aRmN1VmtDVWVRd2hmczRyOFB4bTFsS1FsbDNVYnNkVTl1MjZUNmFU?=
 =?utf-8?B?d2k1RUREV1VEYWc5aEQ5bnR3NFk0ejV3VU1HbjBWWk9xNzhSMW4xekNlT3Zi?=
 =?utf-8?B?Zk1EWnpaUnlyZVFKUkh5VjRDOW5kRE8yRnYrQ1R3ZWR3RmNOL3V5QlZSR1FQ?=
 =?utf-8?B?a1YyLzkrWXJ4c1hIU3VkQjRTWlQ4VUtJaVRxaUlwVjByS3BQWDZxN3VDQ0lH?=
 =?utf-8?B?S0oyYXZJWFJZZk9vQmxtY3VISjR5QWswTmNlcnhWVW4rMUQvcXlHRHMvcWJu?=
 =?utf-8?B?ZEFjSk9OU0lwdlZXYkoxdDhUZG43V1JzOHhOQWhjYlZidERiTzZUa0ZLbWRX?=
 =?utf-8?B?clNMZ1lGV2ROeC9wTTFHM3VyVFptekgwM1NvOXRJbEN5bUJpcC9XUTczQ1VY?=
 =?utf-8?B?UUNNQnZoamhGWWZzRmY2UG56Sk0wMUFabnBFQTAvdWxtaE14bVM3eHRpbmF1?=
 =?utf-8?B?NFZ2ekJHYzdTMGIrcXcwYWw4Q2FMcFhNQnVwblFiWmd4RWQ1QXRPMEFCSVox?=
 =?utf-8?B?aFNnQ3hkVy9KWEpaL2hpU0ZML09EMTJVaU91aTREcWErTlpIOHg4MUg5Rjgz?=
 =?utf-8?B?SzRsT25temJFVmF2bDNCb2MwckZyM0djM040SHg0aldVdUo3MitmUjU2Sm0y?=
 =?utf-8?B?dWRtbEYxUHE5WERsYy95MXRzd2RUTjhHNTdvRkpHYlZyYUxrK3o0VUY3aUZn?=
 =?utf-8?B?REEvd0tFaE5La3dST0UzdVpYVDYzSGlZcmdMa2dkZC9DRmwrSW5uVE1sQmtx?=
 =?utf-8?B?bWhBSVhHaHNzUEg0TWk2b2ZpU0dQS0lwWWNleitsTU53OERrOThseWMwTVdo?=
 =?utf-8?B?eittMWdJN3REbTM1UTBlOFo4dWVLT0pzTXZyUXBJUHg2Z1JBcGdJZ1pGSFdk?=
 =?utf-8?B?TlUwVjNjS2cybnRrVnpFeU1MSnAzSUMxVGcyM3RlUjdMczhQZ25nZzcxcEc1?=
 =?utf-8?B?Z2pRTEp4YzNUK2pzVUsrT0R4ZXljZXpHQnhZWUY4K3o4bWVkUUt0anUrRDN2?=
 =?utf-8?B?Y1FPcjJQNVd0VTBvMmJQQWw0NEluQU9ybmo2RkRoRzl5Mm11Qnc4MGRhUDlp?=
 =?utf-8?B?dlRpNERCU3pqUmRxbEJKMi9ROEZlYURRbk1WbWlMMXpxY1V6OWdiNGp2NVNB?=
 =?utf-8?B?QmtSYitPU0sxc3lnWTkybE1Qa1R3SWN6WkJPZWlXVklPWmFwQ1dJekJyVHhr?=
 =?utf-8?B?ZzV0STNXUG9TYjRTK2VTaUNCaGlkTFpCcVFQeUZ6SkJZcTQ1bEZIMlBPOXU4?=
 =?utf-8?B?R1RxRHhjd3U5bzU3Wi90bFZ4WGdhMU1tSHBISkVlNms0NDVTRktSZWsxam00?=
 =?utf-8?B?MHd2S0V2dWFuYXVaazFHZ2xOMGdjUC9uTnlNSzFYRGF5Uk00djJGUm5ma2tI?=
 =?utf-8?B?cFp6emkzY2l0ZFhOYTVZenFaU3R6UzlQNjVicm9oT3pHb3BpZXozemhkTmJT?=
 =?utf-8?B?dXVkZi8vV0ZHNXFaNW1XQmxlakx4eHU0czcvV2FORm1kK3d4aU1DM2JyTVph?=
 =?utf-8?B?ekI5SEwyL2JrdGIzRWgwdWZWMjNKcWtpclFrZHhwN0dKdENqNUdHem5QbVpP?=
 =?utf-8?B?MjRYMzd6eWlqRi9hU2dDT0hkRG5zVE1zcWFNY0NDTDArbGpGMXpaVkptMHNU?=
 =?utf-8?B?NkErL3Z6WFJ1RDc1b2RFUmJ1aEkzNld6aG9FSW9sbkxvNXVROTBDUnVnRG1p?=
 =?utf-8?B?eFVHcWpIcFkreWZkWVMvMWZtSVRERy9aVWtzUzZWcU1rRHhqRWhMNzJIM3Fl?=
 =?utf-8?B?UGF6QTlRV2t5ai9NYmJuWnNLOGN0QmRmcEJLYUZ0RERWWHJoUk1ZZkxiOEpp?=
 =?utf-8?B?aXlSQU5taWp3OWg1U2NLb21KdEZzdVNKczZrUThxVC9MdVA1Yi9nRUpLay9y?=
 =?utf-8?B?NjdrZUpQYWZLemFvL3hBcHByZTk5TXZFTzlIbldIbElmR00waGFaK1lxUHZC?=
 =?utf-8?B?Mms1REN5WXNKRWNEOUYxNTlwVXNJRnd5UlZoZjN6b0EyREVvU3F6ZHFCaGE1?=
 =?utf-8?B?L25VZDJYS1JsajdpY3RKRUxxWUNtWGlqNS9IZFBKd29RekhoSU1GWXNWc3pQ?=
 =?utf-8?B?eFZzVC82em5KN1cyKzI4b1ZyTUZiS01ubXAyUEo2Zk5BYStxYlNnSnUxY2d1?=
 =?utf-8?B?MkpvdkVxTzJReFlQZHpkNTh6L2R6eFNPRlN6bnVMMU5kRTlDRG5odz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb981f3b-4ff0-4385-ab41-08df0a602740
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:40:20.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiygcwH1busHDhlCtC7uoYfarKEt26qz7YAH0rnH9xckWe+SJzX4S0oYbinyLEYrubiBQeRfAnrwhCFzyB/ICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9471

> Hi Carlos,
>
> Thanks for the review, and sorry for the confusion my v2 caused on
> several points. Let me answer your questions.
>
>> Are you using AI to make this patch?
> Yes, I did use an AI tool while preparing this patch, and I
> apologise for not stating that upfront. I will describe how it was
> used in the v3 changelog, as described in
> Documentation/process/generated-content.rst.

Hi, haobin

It's okay, don't worry about it.

>> Have you meet one issue on one real platform? Can you share the
>> detail about your devices and platform?
> Yes, an i.MX6ULL on an ALIENTEK i.MX6ULL mini board, with an
> ATECC608A at 0x60 on I2C1. I am writing an out-of-tree ECDSA driver
> for it that reuses the wake pattern of the upstream atmel-i2c
> helper (drivers/crypto/atmel-i2c.c): a wake token sent with
> I2C_M_IGNORE_NAK through i2c_transfer_buffer_flags(). On i2c-imx
> the transfer aborts with -ENXIO at the first, expected NAK because
> the flag is silently dropped, so my driver had to fall back to
> bit-banging SDA over GPIO to wake the chip. I will verify the bus
> behaviour on that board with a logic analyzer and include the
> results and captures with v3.

In fact, you just need to support this I2C_M_IGNORE_NAK single flag.
Happy to see this. If you can help provide some strong evidence, it will
help a lot.

>> After meet NACK, can i2c-imx controller continue to write or read
>> data from FIFO, after NACK normally stop or repeat start, so I am
>> not sure the i2c-imx controller HW will work normally, do you test
>> this?
> I will cover this with the tests attached to v3.
>
>> Always goto the PIO path with I2C_M_IGNORE_NAK flag, it is better
>> "return i2c_imx_acked(i2c_imx, false);"?
> Agreed, v3 will do that.
>
>> You don't really support the I2C_M_STOP in the code and
>> intentionally ignore I2C_M_STOP check to avoid breaking the
>> imx6qdl-ds,right? Do you work on this platform?
> No, I don't have an imx6qdl-ds. The ov2659/SCCB reasoning in the v2
> changelog came from reading the DT and driver code, not from
> hardware, and it will be removed from v3. I2C_M_STOP will stay
> rejected, as in patch [4].
>
> While checking the code I found that patch [4] rejects
> I2C_M_STOP, and in-tree ov2659 on imx6qdl-ds sets I2C_CLIENT_SCCB
> (I2C_M_IGNORE_NAK | I2C_M_STOP) on every message, including the
> chip-ID read at probe, so after [4] lands that probe might fail
> with -EOPNOTSUPP. This is only from reading the code and I might be
> wrong. Similarly, rejecting I2C_M_IGNORE_NAK might affect the
> ATECC508A wake token on imx6qdl-gw5904.

This point actually concerns me as well. From my perspective, I agree 
with the V2 approach of skipping the |I2C_M_STOP| check by default. When 
adding new features, we should avoid breaking existing platforms. 
Historically, |i2c-imx.c| did not validate these flags, so ov2659/SCCB 
may have been running in a state that was not fully compliant with the 
intended driver design, but nevertheless worked in practice. Rejecting 
transfers with |I2C_M_STOP| could therefore break the existing 
ov2659/SCCB use case on |imx6qdl-ds|. While the code would continue to 
silently ignore |I2C_M_STOP| during multi-message transfers, this is not 
a new behavior. In fact, allowing |I2C_M_STOP| to pass through is 
intended to preserve existing behavior and maintain backward 
compatibility. What is your view on this? Regards, Carlos

>> So can you please rebase your patch on patch[4]?
> Yes, v3 will be rebased on top of [4].
>
> I will also fix the sentence spacing in the changelog and comments
> as you asked.
>
> Regards,
> Haobin

-- 
Best Regards,
Carlos

