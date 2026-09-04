Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEA442391;
	Fri,  4 Sep 2026 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514282; cv=fail; b=ovwNXBhb0p0ElfGdwhAR0314K/wNiEmGfZl1lhifoBjoCv1G053D0jD5evwdND9IMBEr3+MG5yYjwLfosPewPrkTxHtI4CckSXDgXXjpzOyOVdaZUC2jDqjDeeQ7iDZwm2mRJhOx+S3LbMkR89xu1JvcbXOkkpL0w9GSu0wU3EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514282; c=relaxed/simple;
	bh=C7uEFXBi58JYhwUlhl/ahNu/VZsRJ/OAI6r2AJYyY28=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C4lDlycCw/2Mi/bF0X7RRREcQXTM9p6RSSom7TlPOsawIirkizhQ1fipR/mvQwCYoI/+tZmh2Dpqod1nd/3FPQR4iy0sQAcfuzv8fWlEajpka5vwnMLli0zcyb814QYKec0/0C6NYAt0r9lPmQVdoeGvaE0tsJy3AjChh5w4BsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=crwEMF9r; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="crwEMF9r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I863TIiQXdUJRVuMnhwACpWRfbpG4lwfYusHM4TF3J3avNS17aHo3Chra3fS0r3Ohq+Nae/7rEDI5oDXHrHwZXO6D5igRmmWXmq8eAHMEYEowflHlGChkbNSrEByW2MRF2ZM86XagFv6LF5TWp2G5K0wo8X+w9TRy7V4Uk5cyGXzG7x9eQDFD+HwTCWpnh67vUXOj8nVqvTUkVIcBTCp/FwOje4KWZO5mftX1D22hoRau4CHacxkusT58PdwZx8OAsSaUwuUDQHyHgnK9d7v8nDHLU7Fvmp2//9dM16XpaN7IkbHcKufk4vnvFucA7xasvrX0Cjpw28RIJih6Wz7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KKGK/oFhEquay1VvWOUNQWuavqkzjNDdibbpfGeML0=;
 b=KAFH5g93FkyIrdBhikBMEs/jjUWjZMxCgCWqdGiKB1RjSkHkQ6PZHi9sxqR8FNCjvDf3QPEXlW4feB5qYyRX3HM8QQbPVx0KhEroFaGvIVZU2dMNkAOS8bZ2bcerGjW3z1+neBBkfXiiPr4iKW3yziwi8CSs7UrMri/lu336nhFeBW11DTNwpTbv91CuU3FfcLN34TUsztQyA4uaB8HPR9rLI2a+BTMRbPDy1wPgvQfxL/EtzgRSiDAYn+VyFzBfF2WNl/vaG9C0kiDZhB4Wg/BOi68u1VH6v+ocB2e+3BQ1EvpejzBiOxWl4tKLfFaNSI3J1a/qt8YEMeJJiPJZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KKGK/oFhEquay1VvWOUNQWuavqkzjNDdibbpfGeML0=;
 b=crwEMF9rWQDXf1oxnQXsCsk3vtjYBxLJ+q65ygVgMd19dpH2DDt51giHaaoR6KXMTJYoW7DgXLuEeQvS+yekZYRKRnSSiv/WDthFsAbWYEr0cjHh4lxalT8AF36LAHCppy0R/wq5NwPuVwhwl5HSMyO4krsiGyaK+h7K9ugyzs76CSD4IqieNz6AuejalT0+LgbQzwTY0gWTrvTeZN4pKWC27qT40EDbzx3cWrms/ao0d4mwUimq+N4jNyXcA5xZRcJF94p0q+1MYpLuiugwrAMRWWfuBLLflH0r9PvR9YCIyj9zctNyOKoDNqlj9RvJiRjY11XMK3pNwtAFeKrvxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DU4PR04MB11900.eurprd04.prod.outlook.com (2603:10a6:10:61a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 09:31:13 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%3]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 09:31:13 +0000
Message-ID: <392c76a6-1ba5-4bc1-bfba-524025359042@oss.nxp.com>
Date: Fri, 4 Sep 2026 17:31:05 +0800
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|DU4PR04MB11900:EE_
X-MS-Office365-Filtering-Correlation-Id: f6065bc2-206f-4c03-ca7c-08df0a67431a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|7416014|366016|22082099003|18002099003|10067099003|5023799004|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZbZgBbVbAveKJJAJQ40dn68M85XrK8X5T0b7L1wENqSSaJK8tGzJkkIEke/FBoNY//9g6LWGjNliyC88EemloLqPSkk6gWwbHI+we2lT2h4DQS8u9IHMd+PZdakoZD/TsPvphpdaxXlb/F+mwWms6hm988JOFpbjrGr0mF3EH26MoMJBNg/hXlmjZTi250/US+5rm5ZugsXCRXRALZptrvGEmFJfA6by/lDobPUquolt76Y3zppL9cO/Tkyypt1zonr28ay3ByvOYGFz11D+0IzbDLDRLfq7k8UzPWzjSYXa/Mb2DL59lhvUkbfbwtJdO5pIVzKuPGp3pqeVJk+eEfh9LhEgXSqyW9nbxpBFuzU/OxI4vga8TAW/BLKRc3hjcT1azzwICQlQUVaw6C5kbVVNQ+axOxxsm6X3O6dY8x5Qphij3Sb15h3OV0Qx78krNQIxNAOTxG6mXIbhYw8zCw2yhK94FtGASHITJYkhvahEv6eYIJsOp+lbzNsnN24uPgP03F/+iD9RdFodltLDhjOZlXqoDxseJ+EhffRllhwgfG7w0i0xGd+xXe3jF8IMBeIzujOTVqMukcQ87PSHuM5CcAfbLtW44HH/Ay60w4gicTNl1TQEACXnsDMJFpNlbk8TEdzDH3a0yIPxSLMtRjBBeSaLrvxOsdV4w6WWx5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(10067099003)(5023799004)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elpXKzhlbUxBdEkzTUpVSXZQV1NOVFZNZSsrMnROczRRa1JzSHcwTEZKUytS?=
 =?utf-8?B?ME5QSFJ6eVcrQTFTc1ltakp2WDgwRy9maUdGSFphalpvbjNXbWlBdjBiczdF?=
 =?utf-8?B?L0Z3UWNMTU4waU9OMHpTTExhcmdGYTN6aTlLd05VbU0vU20zeUZwa2lsTGlQ?=
 =?utf-8?B?WGdzVS83QVpRZ21CeTIraHdPTm16NjF5MFNuWStGTkk0LzJuUVdxQzQwdmNk?=
 =?utf-8?B?bEYwdi9YSG5EQTFaMHE4ZU5LR2QxbE4xc1E4emZ6NXRaZGJqQzZ5YndGZ3ha?=
 =?utf-8?B?OXl5YWd5ck5pVUo2YVFPbmlVbk9Ib2MwblBwM3V6ZnBSYXJFUkY1Zk93UjMy?=
 =?utf-8?B?M3lRemg3YkttQjJnMU0zem41dkFHekk5YXEzVW5UN1R3VExpbFJzMTFpU1Rj?=
 =?utf-8?B?TUNhRGRuTDZ3czlnc2FsUjk2R0hVZzd1WVEzUjNtbmxvSUZnalgrTTI4VWtG?=
 =?utf-8?B?U2h1VUhBa0VLUkZndk84VmtOV1FGb2Q2MmZnSVpGc0owOUd4NC9UQ29rc3kx?=
 =?utf-8?B?c29UK09YOVdSL09lOGV5ZHRpdDdLYmRHaXIyS0FsUUt6L1RvZk1jVy9JWUxK?=
 =?utf-8?B?OGNxUkZpaFhwMllzVHh5S1oxV0hhU3lUcHJndzVKK1VZZERqaHJ5cHJvc3Jl?=
 =?utf-8?B?QWgxQ3d1MnFDbzBpUURkczFuN21KaGtHNXhhOUdVb25hLy9uRi9MU3krSHRY?=
 =?utf-8?B?dUZ3WEJ5Y0hDNVU0SHorMS9iZ3N1eGxrZmRTSWVxbEVLeG5xaGdFd0JiSDND?=
 =?utf-8?B?aTdwYXZOZXB0RmRMUDMyTFNKT0tacExBY3VuWFpnQ05lN0dLTWlVRk5lYXNr?=
 =?utf-8?B?NzNsWkVhNjJOczlGZ09GSUxUODRSNzNBUTAxTUpFOCtmcmxjSTlPcmUvZjl4?=
 =?utf-8?B?ZnJ2V3BQQTZsaGI5UkhxajZKaktrT3ZGbXdPUnpGTGl5RkFMMS9YU2NDeVpa?=
 =?utf-8?B?Wnl4TjZMbGVjQzNqN0cza0RqYVpIdVY2aGpSWVRNY1lYV3VYMDhtYUFTUk8z?=
 =?utf-8?B?dkNhNnZubE9XRDUrZ3loZjJXU0t5dHRka3l3dXo2ZlpKQlVhTURNMUhVdHhR?=
 =?utf-8?B?YStUMkJuYzc2WmM2dENIRzJyTVZ5NU9zRFM4bXpFN2RQaS90eEVTVHpqZ3dM?=
 =?utf-8?B?Um5TeEVCRklOeldESW1yaHhYS2tCcC8vQytGdmVWVldNQnBNZmJ2L3NmT09q?=
 =?utf-8?B?K1BnYzhWcVBnM3JaMXN6N2dBN29RSUQ4a1Q2aTZQT1ZjVFhPTTYzYzl1SzBk?=
 =?utf-8?B?V1ptMlh1NlNZbWJGS2RUWVVDclVyYkRBZTlKaUs3SXRtRTZXZUQyRkVHNnZn?=
 =?utf-8?B?Z00xWHBzakdMY2tJNnZxQjZ1cDNuRzIyVVkwS01JT0ZQVS9iT2RPOVZUSkdN?=
 =?utf-8?B?K2tQMDB5b0ViNXlqVTBtd0h3L1B4aHZsYUl6c2w2K0JtQm90dmk4eEoyVXYy?=
 =?utf-8?B?SkhqMWdqOTZQMnhLQjBaOE5rLzNiQmt3MElOTzAzZDVmUC9SbDRhNUJnZkFT?=
 =?utf-8?B?WEF4eEU3N21icVJpbTYwblQ2QW9CU2FDamM4Mkl0YTc0V2srUnJab28rSjVQ?=
 =?utf-8?B?Y0NkUDdHTitsaHRkOUZ3bmtXaFVtNHA3UmZkWU9MeVVYUkVTelJ2M3ZJMnFr?=
 =?utf-8?B?RXdLY0NPSzUzdUZ0NW8rZlV6eStXNVYxa2RRME8rM2NYRVo5TUdnbkp5VG1s?=
 =?utf-8?B?cVlHNDI4R2JvMUZERStpdFZiNTJRdUF4blZBVGVxdTVvYmlIazExeUJiaDNi?=
 =?utf-8?B?WGttWnh3TVF4enE0d21ZUGhQNng1ZzNnNTBGNVBoZHJKREhTN1k1SU05d1Zr?=
 =?utf-8?B?Qm1sbSsyVytZWm1QUE4rY3FYdXVuOWtJUGhicDNMcW5rcjNxWTZhVUN2Y1Rq?=
 =?utf-8?B?c0pvYktEZHRKbU5JVmJHSm5mUDZlRWZ6QWhzVkt0K21EZm5DeG9rOFlRQ1JK?=
 =?utf-8?B?VjhFemJ4Sjd1VlBQZkNnVnE5SzdabVhqMXZtdGJ5R3VmblZ6bDZMKzYwN0ox?=
 =?utf-8?B?ZlVZVjhwNUZWb3NFUEdGRWFmdlBBbThTMDBQU1lPamhnMXUrTzlWakM3bWdK?=
 =?utf-8?B?RUJ0NnJYZUZrNnk5VHFhZEF2SVBBQXJxMEJ5SnhqWlVVL1h2aEQ4NWRWM1dI?=
 =?utf-8?B?VlR0NUxUeWlJYnhLU2tmcVN6Z1R0RVVZcmFDVEh6MWxWWDVISUFiQnNnU1dW?=
 =?utf-8?B?M1hnTllGZ3RvUzI3WHpDY3VrQWpTSnFvRkluRUJBc3RyVDVmbGQ3V1BOc3Jn?=
 =?utf-8?B?RHE4azAwd1JGazlkUUxUbjJFT2NqeGpaSEFjdUlLSVRSUEFVZTRQZmIzNW1C?=
 =?utf-8?B?SDAzVWtyMXd3TXF1VEZ6UWhIbkE3YW8xLzdScUp5dDNGNmZZQnN4UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6065bc2-206f-4c03-ca7c-08df0a67431a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 09:31:13.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBfxI9gM3ffXgkeY+sI0LeRupTQcEhvqJh6dG4uTm9qfpDrEbx/yt2Ic6UIYklqZPfU8dlfLnNBC/sYU1zB+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900


Just change one new email app. Sorry for wrong format in previous email.

Let us continue discussing here!
> Hi Carlos,
> 
> Thanks for the review, and sorry for the confusion my v2 caused on
> several points. Let me answer your questions.
> 
>> Are you using AI to make this patch?
> 
> Yes, I did use an AI tool while preparing this patch, and I
> apologise for not stating that upfront. I will describe how it was
> used in the v3 changelog, as described in
> Documentation/process/generated-content.rst.
> 

Hi, Haobin

It's okay, don't worry about it.

>> Have you meet one issue on one real platform? Can you share the
>> detail about your devices and platform?
> 
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
> 

In fact, you just need to support this I2C_M_IGNORE_NAK single flag.
Happy to see this. If you can help provide some strong evidence, it will
help a lot.

>> After meet NACK, can i2c-imx controller continue to write or read
>> data from FIFO, after NACK normally stop or repeat start, so I am
>> not sure the i2c-imx controller HW will work normally, do you test
>> this?
> 
> I will cover this with the tests attached to v3.
> 
>> Always goto the PIO path with I2C_M_IGNORE_NAK flag, it is better
>> "return i2c_imx_acked(i2c_imx, false);"?
> 
> Agreed, v3 will do that.
> 
>> You don't really support the I2C_M_STOP in the code and
>> intentionally ignore I2C_M_STOP check to avoid breaking the
>> imx6qdl-ds,right? Do you work on this platform?
> 
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
> 

This point actually concerns me as well.

From my perspective, I agree with the V2 approach of skipping the
"I2C_M_STOP" check by default. When adding new features, we should avoid
breaking existing platforms.

Historically, "i2c-imx.c" did not validate these flags, so ov2659/SCCB
may have been running in a state that was not fully compliant with the
intended driver design, but nevertheless worked in practice.

Rejecting transfers with "I2C_M_STOP" could therefore break the existing
ov2659/SCCB use case on imx6qdl-ds. While the code would continue to
silently ignore "I2C_M_STOP" during multi-message transfers, this is not
a new behavior.

In fact, allowing "I2C_M_STOP" to pass through is intended to preserve
existing behavior and maintain backward compatibility.

What is your view on this?

>> So can you please rebase your patch on patch[4]?
> 
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

