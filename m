Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB440802B;
	Thu,  8 Oct 2026 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446513; cv=fail; b=OT8sWSawKP+8dhicu5Kz488yl+6pudwBIJLcmRN5LI6uyAhD4WH0C31QFo91yUPCKQgAI2+CUKkgk9PDwxnA0JfcaS2hSxxp9VcyeNRJs2CS3GnwKnMiDXdi0JgGUqW7d8GXmPkuHnfRgMzJFljpfdv7PYNFrcZXSlSUTYIdBWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446513; c=relaxed/simple;
	bh=N5UPwzR6hHAMpzTxi+p1HrKyR0Uo+wfvOBrpWMFTock=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DHuzC0odqIelHP0o0qWjpFFAPplSVGCmk9x3nRD2xVKUZgaBfM/pQQrVJcovcz3tb6axDZUtTBSUeN3Ul0UVT7JQEjo65IIBKjQYmC9UEcFf6BN2aKRUHpT46q5gq3FwP3YQe8eA3LW2FULypTOkYoebfgwkIkWHBaUCr/Dk728=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ol25KbKQ; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ol25KbKQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaLhtSq2yfAjRad9C9n+kxQm1JylXFdXivXcB+Zlnj8qHuCu42NulYn0lagNMuak8OVMVnFGsI/TM258s7NFSGuAlZ+fGUQvaIbMMGrD7sat5PHiu3k7sqm6q+8repX1NZHl9vrrUX0KMUNoylnSO2o1OQBPsnZMSKBDUYvRGHV2WeksCrGEQz54rlQjBktS7NZzoEoOwvGlAfX3DzOzuFdxtyLqsOF+9f3d0IhkELoeFlhl0lqBsev6QzrZgtYOCMkzE7qeJ6xqwe2BBUcyTUu8iIV19zG3jvqtUcd0s0p6P6Rimpz8RdqzAN00jNAE+BarVxy3FjMKT24Bc56n2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EwcPvXGvSyj4LC3SSnpdu6ptkj3W5CWHm4jAzdz+e0=;
 b=Ra+quvYw4g9fXwG4G50UKXsgfPrn9/Og8GLKC7nZgqroIY/ZbreiY6sTxWbi9j4d+SGFAvNkdydUd/2wjDM7/OSU6y2jNtLIRv17nawAtGWcaQhTneYptOkvqruPPPCCmFiOxo+DNb7x+lfon/EhWTarLXDGt/uWX6+Vztw739qOQG+0W7gTpqpXzsnw7tdA/1R/lLw8EJgT4IX76Mev8RZwdNQlgOScj+IOEJ7Li2q8XVhtYuBvtmiQCXmbNNXMWWlywAJWeqkPBR5amODeqNUtOILAQbN1cQtr1cyaQdaVgMsK6oYQ3I1devME5u34q6EgYLQyWL7g65/HnSiaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EwcPvXGvSyj4LC3SSnpdu6ptkj3W5CWHm4jAzdz+e0=;
 b=Ol25KbKQZ7Tvas4AYUx7IoYYa8oepatha01Om7Q/teSicCrbs9K3w/qQKmwCvTWwPA06XGQASY8OWGHgt9oZuL1SDxFpOm0raPcxfdekIl90GYZ/2Qspr12EYvpwC9Y6C2j8/P+r/WRX1PNo1vZFSDKabdrLdLwIjiysumtdRpz0VU2XiVKOmNQ5gwB4Jjpw2u/31ufuAQdLTCQdcq3Tkzn/60WbYXVhVuLaDZYxnFu5eMaAr87djmiHepoiFSyP+YWHE9J9O0dalPECIyxLQP5nT6KT2JA6/Ai+kqyq3jAesTGyQd+L/IiIxzwhucyflpWxAq1pQ6ENkhPGlezAjQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by GV1PR04MB764379.eurprd04.prod.outlook.com (2603:10a6:150:3bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 08:01:46 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 08:01:45 +0000
Message-ID: <c72e3cfa-26f3-4557-858a-2a919bf68986@oss.nxp.com>
Date: Thu, 8 Oct 2026 16:01:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
To: Vincent Jardin <vjardin@free.fr>, Haobin Jiang <lemonoutput@foxmail.com>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Carlos Song <carlos.song@nxp.com>,
 linux-i2c@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr>
 <apcYp0Zc7CrJMiOh@lizhi-Precision-Tower-5810>
 <aqO9SMvI89rqoEGb@L23803.iliad.fr> <arMUxCW5ZTzLT3VN@L30177.local>
 <arw0mVbacAXv_1H7@L30177.local> <asaElUqBu5ht6amB@L30177.local>
From: Carlos Song <carlos.song@oss.nxp.com>
In-Reply-To: <asaElUqBu5ht6amB@L30177.local>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|GV1PR04MB764379:EE_
X-MS-Office365-Filtering-Correlation-Id: b75f0381-ea5e-43ba-21ec-08df251265ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	rJuRIDDoE69HbgfafprRBvvJMhARZYZGQpZsxWLKNyoagRecqwKIldjdcyU2qw1rQwhsp1gwc2tSzij5sJC2tZwdDvuJ5p3dBP+QW9UOg6dkU+lK4RGtxVGD4CV5YznH3OY1/eMJebNoOjaFIB8dfaEdTaYnMt5V/Xem7nmcC6BNCcU7+V42FKQ8Ys/D0e+qxy6VYDuapNchq00gddCPCtLcYscemXJA+HJXUnDnYDd6gnYR0HxegGGQm+ox93L0E4lpBuhkBzE3rnaoSx9Ldvth8dKzMXYVbm4J8mrx8jbSQdqU0xyiPPST20gutHMyqL8hWkaH8ARADwBO9Ecb+SeK2Q0faWZHmF8x9Lj6YTk8kpJcB6/NGC95G92s2ye9deu73r2L0s+oxwA0GI5OLmsyPgHUBU2pH46sXrc8rSKFyvKsOa/Ws/eajHsxklNHUv6q+tmHRgg0bOhIIy8jjbyL89rXsX6MHwc0P55s7njVNPhN3dgSsa6Md2LW83rXXLPQiAQVyAIvXMhA1j6cVRVE2PCGKrMhDhdbfaBS+HGBFtTxEkSeg8fmmbXiDCXUg3Zd8T/1z804Gzbk3dypjxOD3feHh9gaTuZbxGipO2Wq8lUbaUqEiDwfPsuVN7rLTqemybUJDbRE3k/aN1chR3lOH+EMvBAjw7V9dZvu5AuJGcDztCLmxEVtNOUskLVqp5/75K5hIlvvScC49NMbH75Wq8DaxobtO2WT5cDbxgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUFhSFB4ampvSjFxYzVHUkl4R1hFQkxEY2h0bk5OU1NDaFc4d3pzQVcxbFNW?=
 =?utf-8?B?ZHZ0K3d0b254Q0x5dDZHOXcrdVlja3VKUUNUVDZ4U2lWd0lVWVlqZkN3UjVm?=
 =?utf-8?B?emV4N095TFVSaGwxdlcwQlM4M0o4K0JtejMxTkFZVmVDQjZ3Wm53Vmt1NlFr?=
 =?utf-8?B?Z1JBNjhRckl1RXNSazJiMnY3TFVTak42VWJMaEpEaEFqUlgrdUVnVENMUEIx?=
 =?utf-8?B?cDVCTlQ1OEdSdVRZZGRFdHBXd2h5ZFFRR2xpbEVlcExQLzJZa0RsTjNjSWZn?=
 =?utf-8?B?STFsZTB6U2hpdG5YTGVwL0hCOExUWU1tV3JnLzNuaVlLVk9NV2FQZjJJazZk?=
 =?utf-8?B?bjk3MTdiUmVsOG9oU0NuOXk3bm1CWHFmTG8wV28vZFFBQ3RWK0hhSGVqN1hX?=
 =?utf-8?B?SVBEV2dSRlBDSXpzSUViSzJxdWZGNmRNdTRaSE1INkdSVEJCRmRuQXp6ZXlk?=
 =?utf-8?B?bytmUUxtMlFtMy8zZks0T0M3MTU4bllVVzBod1RhY1dZMkRSc0FFTll4dC8w?=
 =?utf-8?B?WUsrRUFGZElmZXdQYTVVVFpXRTJjTVFYa1lDMEJ1dHVHQ2V5RzVnb0t2SGt2?=
 =?utf-8?B?dkwrRXp4am93MXl6QXFEODlGQy9yMkU5bzFGOFlKZEJTZXVXWHRJTGIwZGhN?=
 =?utf-8?B?a2JvL1pyZnZMNExsT3hNUmw3OWlwYnlxQmxvUFJWSU9ORGtaWkxHY3hDMVNj?=
 =?utf-8?B?bC91RU1wMU1uR0JCVG5idXFMYXlxSUpnOGYxK2JPbHllODBaVDhsNk82WEJq?=
 =?utf-8?B?SVBoUGJJaEtJanlFUWh3UHBNQ0RXVVEwNG5hU0VSRUlIWE5XSEdLcm5BVGww?=
 =?utf-8?B?bnIrNnJPVEhaM3RQQzBDQ2JuY1NWazVRNGJmYSt0bHlYNmdhUTAwQmVQaEdp?=
 =?utf-8?B?dVVzenlBQ2dlRnd1dWVWSGFtR0tHc0xNTktlYmRJY3JsclJQMkVQZkZyaWI2?=
 =?utf-8?B?bW0zNU1MVGVYeTRRaUIxamlwd2NXRE5QaHdsQ1JOTitDN3NuU1dKbGlPUmdF?=
 =?utf-8?B?enZ4SVhJb2VXZEhxcDRMT2FwaWZoSmxRdGR1b3ZCdnA2WUIybmlEeE1tb3Zr?=
 =?utf-8?B?emtnemlrTGNuRUg0VE4vd2gvSDQ1S1VwNEFRb0ZhNlc2MEFpdHVMcTIxTXhl?=
 =?utf-8?B?bE1hZWh0S3BuQnhGVDJqTTgrc0FFRnQwTTZnOEthMm1MUHhCNkhKZG9FeStK?=
 =?utf-8?B?TmpKOExQSlA3bW9MWUVkNWdxL1JqdytibmlYNkY3bVlzaGRSR0lpY2J5SUIv?=
 =?utf-8?B?cnM5c2hjVW5tcFMwZXJYS1lMdW9ycWhPNDY0UXFoNENNRW5tQUo0MXFXRGlB?=
 =?utf-8?B?cmNWb1o2Mk5qem1uSzY4eVFJbXRoWGdGczZMeURST1FGdWFjbXJHZnJBdnc1?=
 =?utf-8?B?QlpOUktyWlFpWkpEVGtDWTN5K1puWEtTZnZrUGhOYldPbTFjVlBPYnEzaG9Y?=
 =?utf-8?B?djVLbDQ2VXNoZEVBd0Nwc2pnWHpxV1AyR2lON250amZDcWlqL1duUlJtV2pz?=
 =?utf-8?B?b29nRkJKdjhaeng0aG1NVGNEVU9SNi9vQXBYV1F2WVpxSnJuMFRLbDhiU1Fi?=
 =?utf-8?B?R2dRNXdrQ1VVaDdwem5Dd05wWUxaaytjcSsyUEgzalFaS1VEb2VQSENyUGw3?=
 =?utf-8?B?TEZYR0lhZXJuRHJncGVURjVsWkovbkN3YVovTTdPb0FwamczanpTeHhtd215?=
 =?utf-8?B?bEpWVWN2RjU5Wm81ZHExZE5uRE13S1lqeUpsM0JkNzVRMnRPZnpkREQ3TWNN?=
 =?utf-8?B?VmhZTkFjS1VKZVFPKzZjeXhPUndCcHNVakFoU0hIeS84TUVNM2FhaUM3NEw0?=
 =?utf-8?B?TW9EcWc4TjhzS3RiYjhaQzFCQkVzeUlKL3B5VDVoV1lTdnpjYjM3YmZpTnRC?=
 =?utf-8?B?T2dPcHZLVzVTUVd6V3BibHJ4V1VIazMrUE1qY042b1pzODhEamhsNjlLVmFj?=
 =?utf-8?B?bGMwb1ZiZU54S3RqdzRZZGRiaDgyNTRrL1RNYzVxSW0zeWxzVEFtRE5nS3BY?=
 =?utf-8?B?dlYxT3lObVgxZkJXb1A2cGZGODRtYWpZWEd2c0l0ZUlIZkdGT3Fiek5iZ2c3?=
 =?utf-8?B?NElLVGQxeXZ4Ti9sa1NJQUVTcW1sTUhLbk0zZGQ2dDhEOW9uWkVGRUtqeW1i?=
 =?utf-8?B?cmZUOEIxbXZRdVBGTk1kYktZSWxVMktUS0ZMRi9zNE9HT2lCQ3ZUa3IyT2ww?=
 =?utf-8?B?bXh4bkdOVmZ5ZzhGTThDTEFGeWppcHV5TGJQQlAzSEd5cEM5bTloYWF3Rnlm?=
 =?utf-8?B?bHBYNnp3NlY4cFl3VzNIckp4NDFta1lKa0phOWJzZzAwNDNVckoyK1dDb0Rv?=
 =?utf-8?B?OUZlZFNDYkt3SVZCa3dVdGFQVHJEdUNMRUZvdjF6VDdseE9qYTN3dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75f0381-ea5e-43ba-21ec-08df251265ab
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 08:01:45.8735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XHbD2ga5ZvmPta4xBmWc1lq8VZl3UMNTPs3rIyDF7HtoCcie8c47eUnhncL8hk18IdDB7ahc9M6AE0CW0SebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB764379


> Hi Andi,
> 
> Sorry for the noise and resending again: with v7.3-rc7 due this Sunday if
> I am correct, could you take this patch into i2c/i2c-next for v7.4 ?
> 
> It carries Carlos Song's Acked-by and Frank Li's Reviewed-by and it
> still applies cleanly on today's i2c/i2c-next.
> 
> Haobin Jiang's "i2c: imx: honour I2C_M_IGNORE_NAK" v3 still depends on it.
> 
> If anything needs to change, tell me and I will send a v3 right away.
> 
> Best regards,
Hi, Vincent

This patch is a new feature, so I think it will be merged until v7.4 at
least.

Also haobin, can start working after this patch merged.

-- 
Best Regards,
Carlos

