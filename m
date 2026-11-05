Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793867616;
	b=FMyMO5kbBJr+//m6nm4r2V7b1yFkOVzA+duzTn2XFPWk3AeSNqeh157GzjqeSMVby1vu
	 md3nUKlbwio8uneGI4KFdUqBfyO5N5vD1Ugi98dPK+/8TelL/xyLNi0vPPbSE5VMvG9L8
	 sBnHnYtZKx7x3MLiC38tnHTo7y52yrqFc5RL28+DrBQoK6ae4No4KG+lmg52Klc5pd3C8
	 4dozxRLFkU/VLLY7OsvdOB5L6XO2ToNz8X0P47EBgpWXWgAWlOnVTwNOJN1LqKISUK/ly
	 mSyD1nezslJEMXrnPsABn6qoBmx8RHtT000vj77NrzmJRzpuNo6UTvxYPSRl/eTPTPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867616;
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
	bh=wSooqy2lgDg08+BJ5KWjg19MGmedysf6SsH0A6O+b10=;
	b=z4G0Hm57kyjrmLShf7C6iG7/T9xjNNmfmefqtYGtXe/rT0HKFZ6TQqWvXqESPeglDERL
	 NDjIGGn9Fv8RXm4eWqQGAot6ZTf6yuREjTG2XL/TvMyufdY+lzwLmsWHRsL1aJmI0b9II
	 BTaDisyviNF7LS7DLuz3tVWvSE1xhdcjoBkYNV6jH0P35Y3QG1Z+z1/XlDvWoX2vG2rb3
	 1p+08094noeqiIWwSvgOLsNspXGIwS2LkcCLYMwIu1O2jbZbmwULViK7bcZP5Ac8xShql
	 uDuQohiqu1PkxZMxUhiVHAPRkuheipfsyGfFMUXcdoWLFUspu+QclAfb90/IopiAeKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=M6CDprrJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.30
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337FF606A326;
	Thu,  5 Nov 2026 08:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 337FF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=M6CDprrJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZDvQ0Q8ZB3k204Zd/x+oGj9+lvDdoGdE1ItxeJTb/kloL4u+oeGBBkhaq+cfksCtQnt/7cZcWPvo/WZkG2zX+qEY+w73fncvqEja7dhMhwrp7zj1N+IrJty0qMmiuehJHkaasei7id2q1M3DG+UCl2ujq1+uOS2GqGq9Du0dxV9ew5tXmR+K84flLfBei7znBFbF+/14Lb29b5xU7Ueazh9Go6eRAecBgd2/eauU9+XKicYjpNN5pGOggh0f0INb35XBCmn4sVUSZRhm3+9CKYw6md995pI3B6cL5oxkZcsaW01/TCys2QEnKV0zQvQXrJ6MWAYnQe3vqYMdC1xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSooqy2lgDg08+BJ5KWjg19MGmedysf6SsH0A6O+b10=;
 b=aIVVMMvZEWXOEzSgxzOGjA5aiwb072DZsD3zFoGKW/mbZDUlk6FDHrKh27hSr2jELDuWbIieUtq3wTVaeemTkvdKq441CYxJAxs7eDiE0oIJ4YGur1tLQ37O8mVYGMd1A5GJh/jsKtlJBexxhXdzbYyv0uO8ZwQq1hK3Nn1Vry2S+5WIdL22HUlX7LylbmlFhy6k28vjJLg86qnyrM9J7SSbKGkMUBqcMC8GNd0fqBQ2FXojPsS2GFgw6/OfbrnPXZlpHa+si2TmHF0A7Mf28LUkB4x3nQSnpQndROJEW7cLalFw7ha7KtRBZlSpuZO7do3UwlJTNx9AL/1nNMdrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSooqy2lgDg08+BJ5KWjg19MGmedysf6SsH0A6O+b10=;
 b=M6CDprrJMWOieHBkzqvHcwIJIZAJt0e98Vlv0DIbTaH2Cqi0fMJxbH6oQ9dE51w8b4Vyel9NgJUjkHCxgKMxYNx1pAjpq/Q/Y43xiSDWr2YKSiPrqHU8HkmFbK3uLLeFrFsP1ogSi058k82QWGOuELrlWmktvM1B00ehk2IJd7LzJkHIEadOHZWSMydPRskdrpXMIMYqjnugExv9xt90sifeqcE4+uJAIfEQ6ZGvFTKl1cteZCz7bhdQQGrrKiUResGH8zm80DAO33ixOCHrMKN2Hr/fWsirAitBKdrOH/CEs2qP2JOsnLDDJozFBBJEN2BIimsCF2QFSxmQ1rNKzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS8PR04MB9077.eurprd04.prod.outlook.com (2603:10a6:20b:444::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 08:33:32 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 08:33:32 +0000
Message-ID: <aa852e02-41f9-4d06-ba65-3a4145475628@oss.nxp.com>
Date: Thu, 5 Nov 2026 16:33:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i2c: imx-lpi2c: don't treat a NACK in SMBus block
 read as an error
To: Michael Walle <mwalle@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Carlos Song <carlos.song@nxp.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261104121108.659820-1-mwalle@kernel.org>
 <20261104121108.659820-2-mwalle@kernel.org>
From: Carlos Song <carlos.song@oss.nxp.com>
In-Reply-To: <20261104121108.659820-2-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM0PR04MB6802.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AS8PR04MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f93f437-5571-4752-5a2a-08df3b1779bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|23010399003|10067099003|22082099003|18002099003|56012099006|11063799006|261026140227099003|4143699003|261022105027099003|261028144727099003|261102123227099003|261009223027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	eHJwf22Rqne14/Qabyz0vgRxPeg6YoRKynEVovK+cnvocveTqGZEaUXAouOK+nlWwkSD1AdpYC4sFT6IuOge0UrprsGyHdz4EzKhzSRrB7n6UvAOHNozPQZSSOvemvcyS7ANedq2l3k4JKt4nceKMXGZEByywawvnNocFfaBDYjz2UaNFVHn2xGoJI0Rj/f6V9F3GgHmOlzqf2vXYVYrG5b7Dx8iwYVp8cV3pAbNEwZkkeXDVjm/xn7pdA+7G12VWdOcoHZBv+ndp957LIFSoeYuA9sV7/qZirtny6bEYAsCu0dMdHIHsFsYwhuvEezmsQCiXMKweDpc3Qw80xafPy+Va3fLU7A8VHkimNVvgm3cZoqdB/4Sg0OFYw6zDL196v2EcywwVK7RszYlzvjkbPT2BFLS2oJfUWmOdyWE9osQDM5FOZRf6XAFJOqSPvpBErFNR0ExaURsaBrSyn4wSEx2ZV2AWdZQt+KNs2+C+nJQlazzE/iA1U/AbknmXqI2YNXKg4a1WH7EqFrnfpsjLp1WB6Aq+JgcVgKl4Okhja4DSI9thxdVkMM08awoqJtPl4jqJY1m+daBc7Eg6AxAcDFM2Pcm6nSz8/IIga76XJ0ITtDJZhGiSAr/gp7MwgZ5RpzJqpiTEiuUUWGSH2T2tehaBInjaHL0arAmzvCzHc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(4143699003)(261022105027099003)(261028144727099003)(261102123227099003)(261009223027099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlY1L3ZNTXFOSXVmb1dacHpRM1FQVU0rODh6YXNRQUdteDFpUzNETEt5Tk5O?=
 =?utf-8?B?WWg4ZUFRN3Z6MmJwYmxibHEva0VneFBBeEFTK3V4NzVaeHJRMXVpdE5MNmxl?=
 =?utf-8?B?RnB1cU1SSW1uZmRGazRTQkFOOVZWZXQrUjVabzhnaGlEZ21rY0FXWDNlemx0?=
 =?utf-8?B?bmFKbW1zMmNyR3g5U2doczVkR2ovL3lFNUVmK0FON0VITGMzNjA4R0JyYVJ2?=
 =?utf-8?B?Q0pqYjNOQUxYK2RCZFBTcDA5azQvazlPUUZmRTRxbWNoQ1BrWkE4a3ZGTHBM?=
 =?utf-8?B?dEE0UU8yL2t6MlVIdE8veHlkamJpV0taSHBMSlRVb0ttMk1XM0F6Q1NpdzBJ?=
 =?utf-8?B?ZGxXd0Q5ZWhzU3IwMXJFM1RsUjd4OW5zMjNDNXZUOXBnQVNzcnVxN0xoU3ZV?=
 =?utf-8?B?Rm9zNGN4bjc0cUQ4UjhIUTQzODQrbTBqUUFmeSs4YTAxN2FJVHR1ZklsdS80?=
 =?utf-8?B?UnhNelNCVkFXYkc1OUZJbW95RXJOTmJnbFFFWlFOOWhSUnVhU3FQUXJJMjFw?=
 =?utf-8?B?T3NKMVUxSkZrRzBDRllpOW9LMWNhU1ZTZlN5TkorWlRCa1pYbkI5cFkyTC9x?=
 =?utf-8?B?dGhCajBNZ1NHZnZBNFpOdGloMWU5QnhBUVV4ZUwwMlN3Qks0TGxSRUczaDg0?=
 =?utf-8?B?NXdia0F3MFplVlNNbk9jMEgyTzhqWkRZcDhFejh4aEtVYWRUMnhSVmtJU1VB?=
 =?utf-8?B?Vnp4M0hOd05YL3NRV1kxTG8xMFBBUnJ2ZjdEVENoa0pPSUFrdHY3WnZnbXlr?=
 =?utf-8?B?RTNBbnpwN0JZdXcvSG5UOUN6SlNZRlB0TTVNMTM1WUIrSTUyRnRvYU1naE5j?=
 =?utf-8?B?UTEyQ0VDUzlPMUdtSjE5Vmdvb0tSRjhpMXZDQ0N4WXAzNnFaYjh4a2tvc0N3?=
 =?utf-8?B?eUhYTW1ReHpYVnpIejlKZ21xZ3dwbWJsdTlBbG5HVFRrbFJxVGxxNGZEblM5?=
 =?utf-8?B?emNULzFTWHlpNjN1eWMyMjFxWElVMTloaWlpWXY1MW5LZTMvc0RMWXBZeU1Q?=
 =?utf-8?B?VU40dUIreU01OXVPcnFtdVEyZzhWNzR0cnRIUVYwRk0zYjZKNHJvYmdpV05y?=
 =?utf-8?B?OEQ4YXZPaDB6T04rQkx6bElzZUp2eHV6b2N2NUFCMWtsUEFCN0hFK2lpSVdP?=
 =?utf-8?B?aXhSWmZOTm51ZktpS2ZvRWdwcy9vYzh3emtjM1FDY2pMdHBMMlBHOTdYeUly?=
 =?utf-8?B?Q0NqS2tOTU0zdVBZRXZkT3lvQ0g4bytnaVk0cXI1WXNHU1VWdUlzalRCVXkr?=
 =?utf-8?B?ZmhOMTBOSS9NTC94TlhWbjJ2VkFKQjJIRHR0NE5kVHpXNWYvanN1c09JdkRQ?=
 =?utf-8?B?VEZJc09NYjdYM2RGTUFPNjE0OVJmaExTd2svVnM2V2tibHBQZ3ppVE1XU09F?=
 =?utf-8?B?TTU3YW5hY0ZnMFN0eUk1dGJDVXg5T242YWQxOEQzY0U1dWpWNGx3L1A0aExI?=
 =?utf-8?B?MytOVU1ObHlvMURqdDJBL093VzcvZ054RzBVUTJRZHk4b29uY1p0TGlVV0gy?=
 =?utf-8?B?dUp6NUxsSVo1ajAwTUtiVHByK3gwYjlnaHNNMFB1QkhOcVV1Qi9sR3MyMUV6?=
 =?utf-8?B?a2EyNW5VODJ1dCtmYml3RGowek14WnVpZFBlSUdEeTlaYnQ5eFJZY1Jwd1hY?=
 =?utf-8?B?bG8xeUdXUnpOSWloVDRlTGtxVWpkeTJYMGpXekMxVmx4dU5FQThuci9sb1kz?=
 =?utf-8?B?NGlxbmp3VkpUR1l6ekJ4TFpKOHlQRUVrWExJSzA1L0I3UmlOSlloQ0NoemNM?=
 =?utf-8?B?cXJSL2YwbmlTcWM3Wjdpdm9KQ3RHT2xSZmN2Y3pPbG1qbFBFREFibXBmVUUr?=
 =?utf-8?B?Mm0xUURoMzZOclBHY0dtOGNza2ZObkZFNDlRdnJlTDdFbVBtNUJhZXpxMjRQ?=
 =?utf-8?B?R0RlanNQeGxUOElQcWJWVUdka0xWTVRFZ2FXQ2lwNW9QZnp5V2tnWnF1RWN5?=
 =?utf-8?B?c3NuTUdyNlNXa0ExZG1EMk9GeFpTNE9BWDh5ZWpNL3dUSmZ6NkhkZEQvVGdw?=
 =?utf-8?B?RUszT25Hcm0yNjhNQTFqOFFXckZaZlJlamlGdGd0RW05REVLVzdDNVhTOXp5?=
 =?utf-8?B?eWV4ek42aG51YmlyNTcrOUk2RXNXS0tOa3JJT3JqZEZkeC9SMS9JQjM2STJl?=
 =?utf-8?B?S05RbysrZnVVMHBDT1VRazl5MkRVZTEyS2xYU3owV0I1Zy9LbDVXejgrSnNW?=
 =?utf-8?B?eXd2ckVxSGtRN3dvN0hEVGxYaXhNUDJ0SmljT3VNcDkyZXprZ01UMDNuNmdt?=
 =?utf-8?B?MmxMb1YvcDRmNHpkMDY2ZjhCdU9wSFgxZEhhUDBMTlhab09CZ3R1RWc1dEJT?=
 =?utf-8?B?bk5xemFPampUTGFLbXBGWHRtZG5OQUxXQW1zZThJQ1dUYzFvMVVJdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f93f437-5571-4752-5a2a-08df3b1779bb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 08:33:32.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szhQsz7CDY84Ow/fiWUCxnTVvU103HiWcn+e42GTAOwWlWOzVsVhvQuvewkBq0XTfK1JS/m31ZeUzgHwt0z1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9077







> An SMBus device might indicate that a value isn't ready yet by asserting
> a NACK.
> This will lead to the following error message which will flood the
> kernel log for some device like an IPMI SSIF BMC:
> 
>    [    4.277005] i2c i2c-5: SMBus read count failed -110
> 
> Stop the polling if NDF is set and return -EIO, just like everywhere
> else. While at it, drop the MSR_RDF_ASSERTED() macro, it's just one bit,
> no need for FIELD_GET.
> 
> Fixes: efdc383d1cc2 ("i2c: imx-lpi2c: fix SMBus block read NACK after byte count")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/i2c/busses/i2c-imx-lpi2c.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index f57e800ac3b5..583155802e8a 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -92,7 +92,6 @@
>  #define MRDR_RXEMPTY	BIT(14)
>  #define MDER_TDDE	BIT(0)
>  #define MDER_RDDE	BIT(1)
> -#define MSR_RDF_ASSERTED(x) FIELD_GET(MSR_RDF, (x))
>  
>  #define SCR_SEN		BIT(0)
>  #define SCR_RST		BIT(1)
> @@ -594,7 +593,10 @@ static int lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
>  		writel((RECV_DATA << 8) | 0x01, lpi2c_imx->base + LPI2C_MTDR);
>  
>  		ret = readl_poll_timeout(lpi2c_imx->base + LPI2C_MSR, val,
> -					 MSR_RDF_ASSERTED(val), 1, 1000);
> +					 (val & (MSR_RDF | MSR_NDF)), 1, 1000);
> +		if (val & MSR_NDF)
> +			return -EIO;
> +
>  		if (ret) {
>  			dev_err(&lpi2c_imx->adapter.dev, "SMBus read count failed %d\n", ret);
>  			return ret;

LGTM,
Acked-by: Carlos Song <carlos.song@nxp.com>
-- 
Best Regards,
Carlos

