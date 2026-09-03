Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6B47F2D6;
	Thu,  3 Sep 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430350; cv=fail; b=SC60sYhD+Q7fLBSW1XIYOusNNDm1NRN8YVsv2NkchZYiDFWYjx+2I8MzwQg0Tp5rWrH+RpgoTUQnUp8Rz3Elnz5gS4diYcMWGAkurMnYFE4ZISV4S7edk1RV4TZIR8UYk5ou+kjRZIw/8R4+F3zKQhkZfyOA7TOn7FLIBrh6D5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430350; c=relaxed/simple;
	bh=fKn8Ms9/R7Nyf9l/db/dImA9an9ZdljaAfhQAqe0eiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eFvbRkQCsFr+HW4ZKy6fKLqbo5x3/c5ZDlEGXqMS8DwQmZef+lFs51t8oj9I22WtKszaq9PgC3BRlFqlr/norEmWCdmfA7CWY+Dqpu/dTdbYIAH4m7qscBFtXzX21nYWfMwvrQ7FwYyTrgVUKjmHj8vhF2TjuIYbjufrHSbjtGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=okoqlMyD; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="okoqlMyD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9cWgcVOITgkyI3N7YpAEOFrFHK0ThyWzKyt1aef3mZtYcc175N3Ft4z3O5zXcZrDqBg8AUGh4wMCQOrfD0nrPANgF6W7fo8mSYVZ8dVuYRFsoIKFHosQcrSEFonQ1guCSttdvAFo629sIt82kuBPsLeLouU3hdzIX993LdBgrV688E6Wbv5XFh3UIG279d5V1aEoeCaNQV/OU+Qf82rZVuQDuL44E+6gtXzTy1JOjN3RdFjqWhyomFiSkzR2AEl+uZcthTxfgQjNErLIT9HY5Ly+zJU4NYQvVMwMo+G2IxIwwmVOftcWw72QkRyllAQBrRQyeuOAjJoxc6gZffbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mruC/tb6xufPJfylux4N726+EjSGj0kGutfetJhU2H0=;
 b=LeOgF49T8WAuqlMt84lyzrsfrRdBQYPGe7EzRfO4ODFruYp7SwiLUCGfe/GVRdQMWl7UxIl63Z+RmNzGFc5+ZBiCDgwGOPZhvFICSgVp2ZM75JOGZ2oFCNoHMNwFyrsCK/z4+UIgJ7jCrbBGbuk0bmnWVCM+hfBRWBu8nM0bp2GHQwRLmVJlkY4OocRziTpcPjCAiCSOqh+JXEbuMomz69lLMJPT9cZIQl48iVacwNXDiN7I3WwxZQSkmCsgaLCCoxLLLXDqdGH9XDyG8IK65vzQlUaKevH8jF3QD3jc+tooYTxOg7WU+YYUOfa8P6URlMp3UiugRpUlqruvfo+4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mruC/tb6xufPJfylux4N726+EjSGj0kGutfetJhU2H0=;
 b=okoqlMyDgb9V4SmwskjLjwBWiEr0JYd1c15QxMYTKa8ZhAtCJTI963Mvj8r5uaNbpm4c3fg9uEVZFg7m5AhfsVkDaJpOaj62mLKU9mcy1UnRMViU4u0nsHnQ3cJhhnJxWBah+vsj5/OZb+Wf+2PWqhdtU7wHEZD5atZdzah5NMpwSHD1lClmawcolvvvQ9kUAFpN5Qwxypp2VvpesWlo6Hok04t3+uDxcrCj+y+6h9DUf+dB7pe2GhKDWrjIFR1mRo2qJzGKUWuuBlG9csOEwBHYX3RVEGQxBHtwji3CsNRmYaQIUCV3tl3CIA80ouuHFnq/mcVfwU+x5E5TtIdKsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DU2PR04MB8517.eurprd04.prod.outlook.com (2603:10a6:10:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:12:17 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%3]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 10:12:17 +0000
Message-ID: <51425573-3687-486e-876d-f94d57844894@oss.nxp.com>
Date: Thu, 3 Sep 2026 18:12:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: imx: honour I2C_M_IGNORE_NAK
To: Haobin Jiang <lemonoutput@foxmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andi Shyti
 <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <tencent_E6A52FBBB25132C90B8E296FEB96E2C8CA07@qq.com>
From: Carlos Song <carlos.song@oss.nxp.com>
In-Reply-To: <tencent_E6A52FBBB25132C90B8E296FEB96E2C8CA07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0168.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::10) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|DU2PR04MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: c54e1a3a-a48f-487e-e979-08df09a3d4b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|7416014|10067099003|3023799007|5023799004|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	z2LiH1HANNVdVEgVBPN5WqL0kLW7DO4tClonKlJJ9ucGiVzbLRfMSVVzQWqSxejlwNr/QZaWCQBUSzKMlPqhDzjx+ZQeCv5edlJ1bwu7IuJF1BBRoa8+yh/PRQ1s/GzVtjsw0X5u3vHGqBmVaLO9InlBDd0rPpAr2TxK3hHL1g0rNJ7oB+LRGalinPqgzy9tAbBlzomB+xWpUTzZqEIBevtajGkbA7G8sApO2oy7VEyJ1evnvN4TG2F5NAhOYGg9y9NaEdng8NKmYxanREcfyq7FPNpL0fqLIvKHISHgxhRi8ivcp+TK9n1m2mGnSeWvbnbCpoXsoMveqfM9StW7xN0k0NKdSBI+OR2/7XeCvV9eEEShJsCZxxEEPYyEKiyGzE+9PpV++/rT+MZ96cxGIYKFmSH/UJS+9AjiaFadtEFKFHJCbmIoR2XycYc8Zvhx9r/CWoCUlNJlZhWK+HPZ2mRmjXovXpHYUxpufNFD7XrSjJpZTYh2yGXsIugSo7WhRhoCP4F8oZjCDf2g2yenqUQxvE36wHrZA++Bz95mXFe4ByFOIOZ4t/1pDB42RGQKDNe64qRA8hU2GFr13yMsbTwefmo/k0c3g0dLR27Kbbs3UCFiwEA/gKZoCJAKwqug
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(7416014)(10067099003)(3023799007)(5023799004)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDMyTmlpVWJyRFo4MHdUU0MvM0VvNUF4U2trUytRUGdSSGdXcXg2KzZUL3F2?=
 =?utf-8?B?alpNaTBKZjJDaGZrM2hrSTh4SkZtVittZURZVi9QRnFqb2xNRjJZWkVITm9r?=
 =?utf-8?B?WCt5a2h2ZDhaL3hSM0Z0RnpYLzZ1Z3Q4dEVZcHJMUzFCWGljQW9rZi8vd2w4?=
 =?utf-8?B?U1lQYlBTcnd4aGZjRm5HUmc2WitqK3VBYTJTVkgxRkpzMkZ0TmxjRlhpbGNi?=
 =?utf-8?B?Umt6R0sraEtEcEIvNnBNNXQvbmQ3RDE5TGJjYTBjWlR1N1YweW04VXRibWhm?=
 =?utf-8?B?RU1JWnp5WmtpbHJLZ1RMR1poTURZMHJPTE5JMzdlME8yK242cmdhQ3hLTmFh?=
 =?utf-8?B?di9OKy84K3owQ29KeWxJbHZKa05DemIvdE9JT0l5RHdiVkcwSnNvbVhrV2lS?=
 =?utf-8?B?cG1aZ1oxNk4zcTJVQlZDWEVBSFhncmI4WUZzcHhzOTVIV0V1UlM4aGlqR2d5?=
 =?utf-8?B?ZXZYTUhWc0NmQzU1cUVjZ1FvekFjQmdRMkdGWk1GcWtRTzVTTWtmMXFucFlR?=
 =?utf-8?B?L1BqRkYvS0RSZWpDeVBLdnNyaGI2NmE5aFZmeUZCcWZHUEI0cHFPRlpFYnhl?=
 =?utf-8?B?dzRMaXIrV3R5WHFoTXg0eTkxd3lDcjdwTXBBaVVJdUJxSjFJbkxiakJqRzJx?=
 =?utf-8?B?djU0UERhT1lnZU1IU0RHOEMyQm1MUkp1SUgvOVdOa1l2SlRjQVFLR3dJcUNk?=
 =?utf-8?B?bVdNUE8xZkF0cWhpQ2F4czBsZHp4MTdBWmdmQ0FZSlpWemVueWEyTWZML3NE?=
 =?utf-8?B?ZmR5RmJTbWJkb3Vxd0RtWXJ4VzlyQzhDNzZNZnc5czlqYnI5K2YwaDhsUnV5?=
 =?utf-8?B?dEMyWHlDaTMwVmRJL094dm16bStYK1kxa2h6UE1ZNWgwd251Vk91clhzZHJW?=
 =?utf-8?B?VHFwM3NDS2JvUkw0ZExRcnBrMUF3UXJqdFNzQTgrTFdjcXlDQ1ZwS1F6dGY0?=
 =?utf-8?B?dHFrTUFmWHpIT2UyZUpQakJYd0EwM1NSaHNzM2w2bkI4S2c3T2pvNlJaTlU3?=
 =?utf-8?B?YkxQNTZKSjRvSTFrVEMvTXY0NitNWGZLbXdUZWsxU3NHZHYxZzZvTFR6Nmtr?=
 =?utf-8?B?ZUVSdGw2SHdObUpWR25DS3FRcXNIRXJBc2dNQjJJeFNSaUVXMFpPb1JDdjV6?=
 =?utf-8?B?M2UvMGZaa2g3YnFGaGRhNkVUdk9CTTJ1TkkwQVVtMzB0Qy9Cdml0Mzc2amZJ?=
 =?utf-8?B?dERWOHhnL3RUZ2ZIWU9lT1FNcXlHWmpFYTgwbXpaTmhDcG8rSm1pWlRzUC9l?=
 =?utf-8?B?WHRZM1lvTktpdzJGeFJxRlVhU1psTGJqd0NDbFE5RG9TclhxRVRERUU1d0pN?=
 =?utf-8?B?VW0rNGFLeHVpaFpYbHlyZVBxOEpDYVFGYjRTVFcxMmQ0Y2xsUk9BMk1ib29r?=
 =?utf-8?B?R3poTjRyOURDNUhOUHlLZ3FvQkVjbFVMd01mT0ljaUVYODhLNm9MQWdGRy9V?=
 =?utf-8?B?WVhTL2xXQllwbVFQeE9UNjUzekl3cEc1M3pnN2syUld3TitUTDFkTDFiYUEz?=
 =?utf-8?B?RnVIQUxLdTNVaGRqZE15elUwZkJIb2RWZVdiY3pmZGQwOGlmUUpWekZ0WnJh?=
 =?utf-8?B?cnJDbXJCUmhNZk5BZWt5QmdHSGRDdjlxeWRza3hGVWdLc1ZmRE5KRDN3M0FB?=
 =?utf-8?B?ZXJlQ2xFMWN2TDArZW9Wc2x3MFVlRVJVaXlEeTJDSlVIT1JXeGVyaVlIbkJj?=
 =?utf-8?B?bmZrRTN0N3cvbHZIRENuWjBvZUJKaFNvQzZnQTl5QjRWTy9FeVU1Z0NBVVpT?=
 =?utf-8?B?cGEzKzR5elBBcWdPc2pLYldwTHoyUHM0L0FYejJ1M2dXaGhidmZkR0hDNzFr?=
 =?utf-8?B?MjNSNDhaODVIajR1KzdjdjY3bzBWMFlzbUNCQ1BJejkwc3RrdUhXMW1nMzQz?=
 =?utf-8?B?VlVhL3kxa1dhaW42NkptWE9LTFU5Z3IwcHU4eHI4NW9DTUIzZWpwU2MzOEQ5?=
 =?utf-8?B?bjU2eHBhakhlQWw1Z1pPQ0hBSDdiYUlSS3FOQWJGRlFYWGFjVm5ialBhcGxr?=
 =?utf-8?B?VzhUbDdhcHZOYXN2WFMxdE5kbFhIRjNzSFo0b3M4WTJ2bDZzZ2dDR2JvdVJu?=
 =?utf-8?B?bXZtKzErcXJsREdUdWJYRWpBaGVMa3M5emhhaDFjNmRPVEQ1bDJlQ0svWC9t?=
 =?utf-8?B?b3lFemdFSXdzMytiVno3NTNMMXAyNGNtKzlBa3haN1k2UGpRZVlONEdNZ0s4?=
 =?utf-8?B?UHFvcDZ5WXE0czVaZzFPSXc1bXE4NlZ3V1p2dnFtQ3VKeVRzQXFlL2h5TTRO?=
 =?utf-8?B?NzJlckF2aVFScUdUS0dZaGszZVJtRGtWSmhoVEk4by9QbityMmZYdkY5TVUv?=
 =?utf-8?B?TjZSV3BaNUU4SW90MUNDS21aNEpCN29QLzlWU2NwY1FkRnVxeHU0Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54e1a3a-a48f-487e-e979-08df09a3d4b6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:12:17.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeSsVPKTobXLz7pdtnb7HE3FtRYFRInui1Wnsap3BHE/2CUNR5PYQAeaAj079UBmbRrK3fUQxRfM0sHWJCh5dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8517

Hi, Haobin

Are you using AI to make this patch?
You can refer the Linux doc:Documentation/process/generated-content.rst.

Please adjust all commit log also code comment,there are two spaces after every period.
Before V3, I have some questions about this patch.

> The i.MX controller has no hardware "ignore NAK" enable bit and checks
> each byte in software after transmitting it: i2c_imx_acked() on the
> atomic paths, i2c_imx_isr_acked() on the ISR path.  Any NAK is
> therefore treated as a fatal error and aborts the transfer with -ENXIO.
>
> There are legitimate cases where a target NAKs on purpose and the
> transfer must continue anyway.  The standard way to express this is
> I2C_M_IGNORE_NAK, which the core passes through to the bus driver
> unchanged: i2c_transfer_buffer_flags() performs no validation of the
> message flags, and the i.MX driver has never advertised
> I2C_FUNC_PROTOCOL_MANGLING.  Today such a transfer transmits bytes
> until the first NAK and then fails with -ENXIO, silently dropping the
> flag.  One in-tree caller that hits this on i.MX buses is the wake
> sequence of the Atmel crypto drivers (drivers/crypto/atmel-i2c.c, used
> by atmel-ecc.c for the ATECC508A/608A): the sleeping device NAKs the
> wake token and the write must complete anyway; the ATECC508A is wired
> to an i.MX I2C controller e.g. on the Gateworks GW5904.

Have you meet one issue on one real platform? Can you share the detail about your
devices and platform?

> Advertise I2C_FUNC_PROTOCOL_MANGLING and honour I2C_M_IGNORE_NAK at
> every software ACK check: on the PIO write paths, which check the ACK
> of the address and of every data byte, and on the PIO read paths, which
> check the target's ACK of the address byte, mirroring i2c-img-scb.
> With the flag set a NAK no longer aborts the transfer and the byte loop
> continues so the remaining bytes are still transmitted.  Every transfer
> without the flag keeps the previous behaviour unchanged.
>
> A NAK'd byte does not generate a further DMA request, so a DMA write to
> a deliberately-NAKing target would stall until DMA_TIMEOUT instead of
> completing.  Force the PIO path for every message carrying
> I2C_M_IGNORE_NAK, again mirroring i2c-img-scb, which implements the
> flag in atomic mode only.  The DMA write path therefore never sees the
> flag, but it passes the flag through at the final ACK check like the
> other paths.
>
> I2C_FUNC_PROTOCOL_MANGLING is a blanket capability bit, so advertising
> it while implementing only I2C_M_IGNORE_NAK would silently ignore the
> other mangling flags.  Reject I2C_M_NO_RD_ACK and I2C_M_REV_DIR_ADDR in
> xfer_common() instead; no in-tree user of these flags transfers through
> i2c-imx.  I2C_M_NO_RD_ACK is not implementable at all on this
> controller: it always clocks the ninth acknowledge bit and I2CR[TXAK]
> only selects ACK versus NAK.  I2C_M_STOP is deliberately not rejected:
> the controller already terminates every transfer with a STOP and
> separates messages with repeated STARTs, so leaving the flag unhandled
> changes nothing on the bus, while rejecting it would break the ov2659
> camera on imx6qdl-ds: I2C_CLIENT_SCCB is I2C_M_STOP | I2C_M_IGNORE_NAK
> and the driver stamps client->flags on every message, including the
> chip-ID reads done at probe time.

You don't really support theI2C_M_STOP in the code and intentionallyignore I2C_M_STOP check to avoid breaking the imx6qdl-ds,right? Do you work on this platform?

> No retry is introduced: the meaning of a NAK is device-specific [1], so
> it stays a device-driver decision.  I2C_M_IGNORE_NAK is only honoured
> when the device driver explicitly sets it, which is exactly how the
> flag is meant to be used.
>
> Link: https://patchwork.ozlabs.org/project/linux-i2c/patch/1467900229-5262-1-git-send-email-tharvey@gateworks.com/ # [1]
> Link: https://lore.kernel.org/linux-i2c/4D46D571.5010907@armadeus.com/ # [2]
> Link: https://patchwork.ozlabs.org/project/linux-i2c/patch/1378857490-30968-1-git-send-email-luka@openwrt.org/ # [3]
> Signed-off-by: Haobin Jiang <lemonoutput@foxmail.com>

Because there is a similar patch[4] in upstream thread. It is to add I2C_M_REV_DIR_ADDR and
I2C_M_NOSTART flags. So your patch will confict with this patch[4].

So can you please rebase your patch on patch[4]?

[4] https://lore.kernel.org/linux-i2c/apcYp0Zc7CrJMiOh@lizhi-Precision-Tower-5810/T/#t

>
> ---
> v1 -> v2:
>          - Honour I2C_M_IGNORE_NAK on the read path as well, at the checks
>            of the target's ACK of the address byte (i2c_imx_isr_read(),
>            i2c_imx_prepare_read()), mirroring i2c-img-scb, instead of
>            silently dropping the flag there.  Read requests carrying the
>            flag cannot be rejected, because in-tree SCCB sensors such as
>            ov2659 set I2C_CLIENT_SCCB, i.e. I2C_M_STOP |
>            I2C_M_IGNORE_NAK, on their read messages too.
>          - Force the PIO path for every message with I2C_M_IGNORE_NAK: a
>            NAK'd byte does not generate a further DMA request, so a DMA
>            write to a deliberately-NAKing target would stall until
>            DMA_TIMEOUT (mirrors i2c-img-scb).  i2c_imx_dma_write() can
>            therefore never see the flag, though it still passes it
>            through at the final ACK check like the other paths.
>          - Reject I2C_M_NO_RD_ACK and I2C_M_REV_DIR_ADDR in
>            xfer_common() instead of advertising blanket support and
>            silently ignoring them.  I2C_M_STOP is not rejected: the
>            controller already emits a STOP after the final message and
>            repeated STARTs between messages, and rejecting it would break
>            the ov2659 camera on imx6qdl-ds.
>          - Correct the description of the status quo: the core does not
>            reject I2C_M_IGNORE_NAK; i2c_transfer_buffer_flags() passes the
>            message flags through unchanged, so the current driver sends
>            bytes until the first NAK and then fails with -ENXIO.
> ---
>   drivers/i2c/busses/i2c-imx.c | 44 ++++++++++++++++++++++++++++--------
>   1 file changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 28313d0fad37..5b22a497a791 100644
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

After meet NACK, can i2c-imx controller continue to write or read data from FIFO,
after NACK normally stop or repeat start, so I am not sure the i2c-imx controller HW
will work normally, do you test this?

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
> @@ -1002,7 +1009,7 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
>          int result;
>          unsigned int temp;
>
> -       result = i2c_imx_isr_acked(i2c_imx);
> +       result = i2c_imx_isr_acked(i2c_imx, i2c_imx->msg->flags & I2C_M_IGNORE_NAK);
>          if (result)
>                  return result;
>
> @@ -1213,7 +1220,8 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
>          if (result)
>                  return result;
>
> -       return i2c_imx_acked(i2c_imx);

Always goto the PIO path with I2C_M_IGNORE_NAK flag,
it is better "return i2c_imx_acked(i2c_imx, false);"?

> +       /* I2C_M_IGNORE_NAK messages always take the PIO path. */
> +       return i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
>   }
>
>   static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
> @@ -1227,7 +1235,7 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
>          result = i2c_imx_trx_complete(i2c_imx, !use_dma);
>          if (result)
>                  return result;
> -       result = i2c_imx_acked(i2c_imx);
> +       result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
>          if (result)
>                  return result;
>
> @@ -1358,7 +1366,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
>          result = i2c_imx_trx_complete(i2c_imx, true);
>          if (result)
>                  return result;
> -       result = i2c_imx_acked(i2c_imx);
> +       result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
>          if (result)
>                  return result;
>          dev_dbg(&i2c_imx->adapter.dev, "<%s> write data\n", __func__);
> @@ -1372,7 +1380,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
>                  result = i2c_imx_trx_complete(i2c_imx, true);
>                  if (result)
>                          return result;
> -               result = i2c_imx_acked(i2c_imx);
> +               result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
>                  if (result)
>                          return result;
>          }
> @@ -1549,6 +1557,16 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>          bool is_lastmsg = false;
>          struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
>          int use_dma = 0;

This code can be simple if rebase on patch[4] I think.

Regards,
Carlos

> +       u16 mangling = I2C_M_NO_RD_ACK | I2C_M_REV_DIR_ADDR;
> +
> +       /*
> +        * Only I2C_M_IGNORE_NAK is implemented; reject the unsupported
> +        * mangling flags.  I2C_M_STOP is the controller's native
> +        * behaviour and must not be rejected.
> +        */
> +       for (i = 0; i < num; i++)
> +               if (msgs[i].flags & mangling)
> +                       return -EOPNOTSUPP;
>
>          /* Start I2C transfer */
>          result = i2c_imx_start(i2c_imx, atomic);
> @@ -1604,6 +1622,14 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>
>                  use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
>                          msgs[i].flags & I2C_M_DMA_SAFE;
> +
> +               /*
> +                * I2C_M_IGNORE_NAK is honoured on the PIO paths only; a
> +                * NAK'd byte does not generate a further DMA request
> +                * (mirrors i2c-img-scb).
> +                */
> +               if (msgs[i].flags & I2C_M_IGNORE_NAK)
> +                       use_dma = false;
>                  if (msgs[i].flags & I2C_M_RD) {
>                          int block_data = msgs->flags & I2C_M_RECV_LEN;
>
> @@ -1697,7 +1723,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
>   static u32 i2c_imx_func(struct i2c_adapter *adapter)
>   {
>          return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
> -               | I2C_FUNC_SMBUS_READ_BLOCK_DATA;
> +               | I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_FUNC_PROTOCOL_MANGLING;
>   }
>
>   static const struct i2c_algorithm i2c_imx_algo = {
>
> base-commit: 04e9bf1648f846976b543e91c1838a712433772a
> --
> 2.34.1

-- 
Best Regards,
Carlos

