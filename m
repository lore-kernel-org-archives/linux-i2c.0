Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793865619;
	b=1ot5j9tMX4WdF5S1e+/F/dJw4xgnxEjPIui4iRfUEP22nhF9+ACyXdtIdpc45TKiqmE2
	 f0T/dgbGZLtH/t/pawgYC12i1ap9KH09X8IBpcdYN192z/978vBcGb+4dI8oF/lLGzJ5b
	 QF9XvcskOUmo8UZVD8i96UNHxU+7gltMtjpiFNf2pSFoXGG0lBrHyjspAGB+CPa6iGX/L
	 0uQn/LQ+XUuAn53kf31sESRQe5qU5d+mYOM4V++hX1Ul0nm7dgP436qpwmOX9JZHjPlBj
	 u9FEnj6WwUh5NKCe/opTivJtSrKZbuAnxT723Bh9aBaI6dAdO6XYH098dPu5JoIXTaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865619;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=W8Z7YXD40AfhGC00Czb8SpL27TWFTuphFDJztwZ+Izo=;
	b=Tng5crStpOhe7l1RyzARbXEqh/HJgD+OG40+80zTbj++CkZXnzPBtSfPxSzSrCaSOgLm
	 x/7F3v1js13HHHu8vmHBHEuzutOfsxatd143+Ez5STi95WehGgCf/6bIUnJD9G9jMfk9q
	 2X2x+bcXsZDjw+TPrI4Ie2aEWbVzuCHfX1W6EJ3FL77E3LGCIAwhIY0bQEMrqVAMGvoNA
	 kFVHZzyTj8mJXYFbCURzVrlJtB1Vwo854MC3pJU9Mrb4FDgZ9oEoVZIAvgn7HlOJoJfPe
	 nE8VdZutc00Uc+EPBJ/w0mu1V3TkSTAxWn0O/aYctIJ1PxwGkWktzZdZaYNQbGT0qfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=od0i8JBS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.15
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04292606A328;
	Thu,  5 Nov 2026 08:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04292606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=od0i8JBS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlrRTgdgF/ls4cT7bdohAVUPikzVRG1Za+VclNPIUZHm0gqUgvpbW53ZQnSqoTz3ybOHgnPn5fRu4KNGXLPoCB5yhNhYJVOq0FC6wy5omX7dxQ8wcfCZM8uJfE7Q2uR39a6nIjUI28oku2wyoZIxJ7stBR6ipeaVXBsZGNA/v3fKIIz0DdWCsVxHe9M9uu5agh6vkRD+vobsViDZWrj1epTbqLQ8DJQiz7Jpl86qraAeIkHwBs3EalPXHOqnNZKJbFQTIyUo+XtMK8S104vVAwx0zbFEH2qRmIfz26YisRPTByVmhNbJQvX+wGnhIT9AEgok3o8n2QH0bSSTPuKWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8Z7YXD40AfhGC00Czb8SpL27TWFTuphFDJztwZ+Izo=;
 b=MfLsqbri8QGNee5EJjqfRBHK4cVesgVKW8oyhO3at94IIjK89Pm7yAN0Y+IqAm4zHbvoVmlZZaoT3LfdDarIFNJl0nIhKukOOGOfrsQ41cT6cSi2ng7H+6wYWJUwVIdg17io5aL7txY2AWClHLXbMrnWTCa+eCZjTjHBvQCa4JmBEcByTJ0DY8hafYYd49tDJIMizPsFh0lwjKpyCTws7ee/WeLl0kPK5X1XdRHoj8shinQ4X3i7eIsysPhvKyz1ORuE1Ew1IQPEbD+usEnGipkOnBWZo6x6DYJ+fSavGyzFi01PPXCUaSdV+MfP8rXib+mryxnKYw4Ilexfevcarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8Z7YXD40AfhGC00Czb8SpL27TWFTuphFDJztwZ+Izo=;
 b=od0i8JBSEmmgxddfiBMBpf7RgS4ekbI1xgrEmvUpRdUqzdQLnLcle4ut2lPqWJ2vGaSnGKepMST1d4CQrgEmULtwMQ9oTTIakZcUSiPi8I2vtIkuVYTXdJMkyNgLcDA7vKRtvRf2OQPazgyadjPaO2hpWynC8ujPVhcrdCpkU29zGGb7GWm3jbjJe7pgx04HagIk13N1JuBTTcCssP0ere9AOTbw3u2xpFMu2Oc2mxwRM9IrW3ei8D0jFlhohMal0sPfRGY14KWrSWt5utsoM+tuOD0jh7HmdmYrmXMpAerSXrOHS7g6P9v353IHYMV1VqMu7Pa0+YY15fQ0GIo0vQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by VI2PR04MB10593.eurprd04.prod.outlook.com (2603:10a6:800:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 08:00:06 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 08:00:06 +0000
Message-ID: <93667d47-794c-45d1-b72a-a463d5289a29@oss.nxp.com>
Date: Thu, 5 Nov 2026 15:59:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] i2c: imx: honour I2C_M_IGNORE_NAK
To: Haobin Jiang <lemonoutput@foxmail.com>, Andi Shyti
 <andi.shyti@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 linux-i2c@vger.kernel.org
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vincent Jardin <vjardin@free.fr>,
 dillon.minfei@gmail.com, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_E6D69775D91AD9FE45C994B3755CB1452506@qq.com>
From: Carlos Song <carlos.song@oss.nxp.com>
In-Reply-To: <tencent_E6D69775D91AD9FE45C994B3755CB1452506@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|VI2PR04MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c725a1b-d8c2-4f7a-6669-08df3b12cd85
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|23010399003|7416014|1800799024|18002099003|10067099003|22082099003|3023799007|56012099006|11063799006|261028144727099003|261026121527099003|261026140227099003|261022075727099003|261102123227099003|261009221227099003|261021121427099003|261009223027099003|261022105027099003|261021123027099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	SZ2kg7eXzXQK1T9P3ulnGpoYh+DNCCl2hax7PfGzmwrvnNg1vdLVbyqFBCusUqJkmYSaqX2UPUV61QDbHSw59/jtuyG6mZQAwWFcGMiobM+ToZ4FEgjLuQLWOIt9wPTja0AxHs+MtBJYSOndrpkqH3tOAl0L3SOptogft8EPpGMSsqLOx4Dug3drNRh+FeGakRd1uY2+q+2ccnSTZdZDNB1qgLk/BlkEaF2SDhzyKFHVYh1FZ5KvP1jKKIeYybeQq8ktHF4SKVL5SiwLDAxhZHlbNqqfMk2oso5IwrA4mJxFDdYIVIYHylGlbuOa7a0Qmt89413YAvSvoqYBIPHfJ9uZPpYlSBlcxLojNBQ/A+1DeOltFyqeaKKSaUftkYS8VUKC7ylVjt/yI1ETQ3Tfg+GuLNRuskdetqkiyD030D2a3GlT+jVkOs4qtAVDVYlNQ8WxlnGrmD4YFi/XDHUAbOYqg2smxHGNkURlrIILqGD8fo9YjRQLOT0GEyJOTvG2UplX3jkGFae/CDBEGJlr4SeLVtelBZ8YlRiCxPuiUGXGFpK8HXqnzeexYBG3NGbcUT9smP4pbqjY3561sVyaar4bgPq6p/S35k8Qzyom/6i6Vn0FPFGNHV2xffRek1Cg2NCTwR6BQ92rlMH/7zzp71vp2RSrNxWZLmjGH1asigk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(23010399003)(7416014)(1800799024)(18002099003)(10067099003)(22082099003)(3023799007)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261022075727099003)(261102123227099003)(261009221227099003)(261021121427099003)(261009223027099003)(261022105027099003)(261021123027099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elZCbEQ0b3NzSEc0a0VhaTl0ckNMcTFOa24zbFZ6Rlh1RHR6YU0yYVlPVTJB?=
 =?utf-8?B?MFFUdWNKV2NzYTg2cTNtbkVqdU1DRUdMVEVKUC81VkxWVGxCa3JvZXJ6Y0Jj?=
 =?utf-8?B?VDByNUtnWFpDNjRXUVJHTEdWZ1VqbUdMR3RGbE84ZkJnZ0lmdGpzMzg2THVO?=
 =?utf-8?B?WE9pT3AvdlVjY2R2UXlZNEFZdGtEaFZJa0JXRlpMQjhuL1kxajhzeGRzUVEr?=
 =?utf-8?B?dXdVbkxsMUU3WHliSkdLWmF5blY3c2J0cTlJTmVjQkF4Q0xBMUVGQnhpMFNN?=
 =?utf-8?B?d204SXNmUVdMKy9OalQrL3FJc0RMSVg0VEhCd3NBNndFclpzYkVvY3pXYWdM?=
 =?utf-8?B?M1c2N1pJaEE1S1MvRTg4T0UvdDU5WnNSK3hnOThGby80ajJ3NFFmZzRKZWli?=
 =?utf-8?B?UkNGZzBkVmJMdDJmbHkwNUdubmlwVUJ0VjQzOEh2SXdpZjhld295RGpaNzZP?=
 =?utf-8?B?N2NNK2pCSXB5QjV1ZWlMVm5FRG5VbUVVN2duMGMwOVhtSTNSMkpzZmZlQkZW?=
 =?utf-8?B?Wk1rakJSTW9ocUgycWhVYmFuSmdPZ09QVk9DL241R29tRWR5a2RTNEs3WkFi?=
 =?utf-8?B?KzhjNHYwd2NxN0d5TnBlWkJNQzdmUmZUV1lRVERsT3ZIalBPWk52K1luWTRp?=
 =?utf-8?B?Zlk0NU9kVWFIazlJYkxRc1c4aXVOZEpud3NOZDNqZVFZMnpkL0ltM1c3SEFD?=
 =?utf-8?B?dWUyK1ZUdnlyeGpyNWdUT25RQkVsdjBXUlBFa1lQWFpGT1htaU4vdkFLUS8r?=
 =?utf-8?B?WUJtOG9EVVRBMFExdTVrejRiRlgyYWxwMjZLK1dHVUdXRlZEc3lybkVLQlV0?=
 =?utf-8?B?SVJQMWM4eGV1U0lEWURFTXA1VkgzUlhmREFQbnlpdzNEYkVqbk5Eay9pWWgv?=
 =?utf-8?B?a3ZiTW9wKzlabVE1SHo5QUMyNmVVekF4TjlIWTkzQmhSam5ha1MzakNzUXZQ?=
 =?utf-8?B?cU8yZ0xoTVdqL0VLeEUyKzNLdGxFQjdrM3BQSnA1RGQxZ0dVdlJ3bmNDYUlP?=
 =?utf-8?B?aFVIeWxjR0hxZDNjekxLS1RqTmMxN1Z3Q2ZBQTVCWUxsVjNFT0tGSlRZM2FS?=
 =?utf-8?B?TmVsQUVxcnBzMXFqR21ycWFxeEJNc1JuNzZvQURjY3cwWC9rQUhwMi9lNE9k?=
 =?utf-8?B?M0pwRTNqVkliaVdqRWVOZE83L2tzOXp2WjZleDRVM25wUHFqbEZhMzBTNGhG?=
 =?utf-8?B?dCtSbFBPcUlqWGdMNW5TMjlPU1NwanJFbHhVNSs5Zit5Um5LOTJETTdHVE5U?=
 =?utf-8?B?eGh0bk0rSEZ4OEIzb3g1bllsMGY3WTJrZEViK2lENnZDWDVwRFYxQ2FQM01P?=
 =?utf-8?B?SVVURjMyNlZDaTAwRlpIOFZPVUtZK3o0eTM3U3BBcHpGM1hXMGJjcktld1RC?=
 =?utf-8?B?VmZmUUJhOUFJd1J1SGhiN3lkVUQrZC8vS0FKS0ZUZkpDZHdoVjZuZkovellF?=
 =?utf-8?B?dVRYN3JBS1lIaXVBekw3THl0czk2ZElBSEM0a1p4dlRSa3QvNlhidnVUdFZL?=
 =?utf-8?B?NmtCWEtkYzczclJ1bDEySXRKNmdGRlNuRHc5N0QzdW4vTm9VUEJtZlJSbXFa?=
 =?utf-8?B?bE40SUkwZ1JNUTBGQmhvWDlHbjZ5d3psZGhFNlFyZ2RZQjhDZm5NaHVZNWhi?=
 =?utf-8?B?Znh2OGp5bjFuSStaL1AwcXBLL0RGUThyRksrRG93NVJSRDJJQXZOR00yNUFi?=
 =?utf-8?B?US9BVW10QlVOZjVkeWI1NUM0Q2NsRmE0ZmxGRm52alFjR0N6cXNoRmhUS2I4?=
 =?utf-8?B?cE5JdUZPdjVlaXRCbmpoRjJFUEgvU3F1VTN6V3g3ZURObnRPZzVWWW5zS2Qw?=
 =?utf-8?B?VU5tcEVnQjFlMTEybkM4dGpScnNhSzV1VkIvakhDeFBTU24xQlovSVVtcWRN?=
 =?utf-8?B?R0lHR3NydjZnZEltK0VRQTR3cE5DQ2ZGalRaK0dZTDJQbENhTHZhSGZValBj?=
 =?utf-8?B?WERDbm14eFNKVEpzVjgxODc0WHNEMjZmWmMrOTd5K3FhRkFCeTQyMW0rTzZ2?=
 =?utf-8?B?RVJHTlJleU5IUDNFTU9KTklkVU11dGZIT2Y4M2tLZEFZWngxRjJHd2llYnVK?=
 =?utf-8?B?UmhXaDErS1pmcnJnT25tdTV3VHc4RTlFOTQ0b3RwdDREK1dKR09IWkhFbWxW?=
 =?utf-8?B?U2tvRHpzWWFlTFMwT2psWkFvSlNpSmhxWjl0Vk9ObFBFN1NaUWZONm55eDVS?=
 =?utf-8?B?bGJCTU40VUltNW8zaFp3aS8vdU5vT3JOckwrLzlnQTRwdjg2MFhTVHlKVEZC?=
 =?utf-8?B?azd5TWdJb0RpU0hNblpGbEhnNFdKbmhlQURaYmZXV295ODUzaHdkNElWYXhr?=
 =?utf-8?B?dEZNY3FESG9QZDE0bjlJU0VnY1dOMjExZHd1a0dGUmMxeWJPVTZvQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c725a1b-d8c2-4f7a-6669-08df3b12cd85
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 08:00:05.9983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xcp0WbYV0Hq3cFOIzIAaaRHiR5bDwlhfTT34FVNKBsa/Cor640W20qPseaH32bkq+aLDRpsuFjxkUhO7pC8Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10593

Hi,

Why not follow community rule to make patch...?

At higher version, better commit log and put change to commit log bottom
with extra lines like your V3 patch[2].

I think V5 patch commit log should be better with shorter and clearer
problem description, reproduction, resolution, verification based on V2
patch[1] and V3 patch[2].

But abviously, this patch is generated by AI, and it dropped most commit
and discussion details from previous patches. No one wants to review
such a haphazard submission.

AI-generated patches should be subject to more rigorous review and
testing. Remember that AI is a tool, the AI patches should has higher
Standards and greater Professionalism than patch created by humans.
Wharever humans must always remain in control in whole flow.

High quality over high speed!

[1]
https://lore.kernel.org/linux-i2c/tencent_E6A52FBBB25132C90B8E296FEB96E2C8CA07@qq.com/
[2]
https://lore.kernel.org/linux-i2c/tencent_342A87BFCECA70C9982E68A79AAD878B6909@qq.com/

Thanks,
Carlos Song


> Honour I2C_M_IGNORE_NAK for supported PIO transfers and keep flagged
> messages out of DMA.
> 
> Following Sashiko's review, reject zero-length reads carrying
> I2C_M_IGNORE_NAK before START. This prevents the newly supported flag
> from exposing an existing receive-path bug, without changing unflagged
> zero-length reads.
> 
> Link: https://lore.kernel.org/linux-i2c/tencent_877C99956190215D644EB959DF1663542A0A@qq.com/ # [1]
> 
> Signed-off-by: Haobin Jiang <lemonoutput@foxmail.com>
> 
> ---
> v4 -> v5:
> 	- Add a scoped zero-length read guard following Sashiko's review.
> 	- Previous version: [1].
> ---
>  drivers/i2c/busses/i2c-imx.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index ccf08cd63151f25581dd3059ee874b606d0dc94c..1e2fd699f4fc658f4a9298cd1852455966018e37 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -612,9 +612,12 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx, bool atomic)
>  	return 0;
>  }
>  
> -static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
> +static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx, bool ignore_nak)
>  {
>  	if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
> +		if (ignore_nak)
> +			return 0;
> +
>  		dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
>  		return -ENXIO;  /* No ACK */
>  	}
> @@ -971,11 +974,15 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
>  	return ret;
>  }
>  
> -static inline int i2c_imx_isr_acked(struct imx_i2c_struct *i2c_imx)
> +static inline int i2c_imx_isr_acked(struct imx_i2c_struct *i2c_imx,
> +				    bool ignore_nak)
>  {
>  	i2c_imx->isr_result = 0;
>  
>  	if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
> +		if (ignore_nak)
> +			return 0;
> +
>  		i2c_imx->state = IMX_I2C_STATE_FAILED;
>  		i2c_imx->isr_result = -ENXIO;
>  		wake_up(&i2c_imx->queue);
> @@ -988,7 +995,7 @@ static inline int i2c_imx_isr_write(struct imx_i2c_struct *i2c_imx)
>  {
>  	int result;
>  
> -	result = i2c_imx_isr_acked(i2c_imx);
> +	result = i2c_imx_isr_acked(i2c_imx, i2c_imx->msg->flags & I2C_M_IGNORE_NAK);
>  	if (result)
>  		return result;
>  
> @@ -1017,7 +1024,7 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
>  {
>  	int result;
>  
> -	result = i2c_imx_isr_acked(i2c_imx);
> +	result = i2c_imx_isr_acked(i2c_imx, i2c_imx->msg->flags & I2C_M_IGNORE_NAK);
>  	if (result)
>  		return result;
>  
> @@ -1249,7 +1256,8 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
>  	if (result)
>  		return result;
>  
> -	return i2c_imx_acked(i2c_imx);
> +	/* I2C_M_IGNORE_NAK messages never take the DMA path. */
> +	return i2c_imx_acked(i2c_imx, false);
>  }
>  
>  static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
> @@ -1268,7 +1276,7 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
>  		result = i2c_imx_trx_complete(i2c_imx, !use_dma);
>  		if (result)
>  			return result;
> -		result = i2c_imx_acked(i2c_imx);
> +		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
>  		if (result)
>  			return result;
>  	}
> @@ -1401,7 +1409,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
>  		result = i2c_imx_trx_complete(i2c_imx, true);
>  		if (result)
>  			return result;
> -		result = i2c_imx_acked(i2c_imx);
> +		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
>  		if (result)
>  			return result;
>  	}
> @@ -1416,7 +1424,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
>  		result = i2c_imx_trx_complete(i2c_imx, true);
>  		if (result)
>  			return result;
> -		result = i2c_imx_acked(i2c_imx);
> +		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
>  		if (result)
>  			return result;
>  	}
> @@ -1613,8 +1621,9 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
>  	return ret;
>  }
>  
> +/* I2C_M_STOP is the controller's native behaviour; don't reject it. */
>  #define I2C_IMX_UNSUPPORTED_PROTOCOL_MANGLING_FLAGS \
> -	(I2C_M_IGNORE_NAK | I2C_M_NO_RD_ACK | I2C_M_STOP)
> +	I2C_M_NO_RD_ACK
>  
>  static int i2c_imx_check_msgs(struct i2c_msg *msgs, int num)
>  {
> @@ -1625,6 +1634,12 @@ static int i2c_imx_check_msgs(struct i2c_msg *msgs, int num)
>  		if (msgs[i].flags & I2C_IMX_UNSUPPORTED_PROTOCOL_MANGLING_FLAGS)
>  			return -EOPNOTSUPP;
>  
> +		/* The receive path cannot handle zero-length reads. */
> +		if ((msgs[i].flags & I2C_M_RD) &&
> +		    (msgs[i].flags & I2C_M_IGNORE_NAK) &&
> +		    msgs[i].len == 0)
> +			return -EOPNOTSUPP;
> +
>  		if (msgs[i].flags & I2C_M_NOSTART) {
>  			/*
>  			 * NOSTART continues an already open frame. The first
> @@ -1712,6 +1727,10 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>  		use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
>  			msgs[i].flags & I2C_M_DMA_SAFE &&
>  			!(msgs[i].flags & I2C_M_NOSTART);
> +
> +		/* A NAK'd byte may not generate a further DMA request. */
> +		if (msgs[i].flags & I2C_M_IGNORE_NAK)
> +			use_dma = false;
>  		if (msgs[i].flags & I2C_M_RD) {
>  			int block_data = msgs->flags & I2C_M_RECV_LEN;
>  
> 
> base-commit: 123cffeca4a33d770c29ff8d3f22453a5fd59c32

-- 
Best Regards,
Carlos

