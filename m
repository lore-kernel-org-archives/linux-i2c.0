Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2122.outbound.protection.partner.outlook.cn [139.219.146.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFAB355F49;
	Thu,  4 Jun 2026 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539965; cv=fail; b=H+C6yZGn6O790urkpjWqHV3W7me9AQqwHQdwssBuCv9zaiIMeW4FJcMEJU6ZdPr7AAAmgyLKtIEkjL3VArC7iOeyCHNtLdZyrRhzP+GI3FZ6eudEuDgfJXJAUfB6EbhB//lNHsSTXM2TbN8onOav5KJirLPsG0d3RIBAhuPQocA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539965; c=relaxed/simple;
	bh=4UR7p08Z49PcgjRcTwFU5I0j8XoviR4YRxtAi5RPPW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YsWW05A/B7PYqd8p27u1ywrDwjdNFvGYTn9Yr11PhOO1Dn91bycAx3lmV35B8pQM7CSzqkwenRBERD5khxNtoH6iHYQ7P8QnOXUFh+QKKfiaIx1ChEWIwxWHSGWUuh600Sb+IV52iOnK9KuvLtQocknfVWnQgpPNfYpIsYzyrFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T40R4xbRqM+9zoxfpadTQ5Kbv2mULlLjMUGo/c+0qg70+KF1CQqXUtHgTeuTG61D+Pl1EHGC2cGxNHZnyryxIwr8+qvt+4rGCNKsVxa7S/6u1lYqm/dzWIlf3QYZoeIUXNNUfOD3ceuVYFar/ZY9HuzbCXpdhTvesNTObWhMgcXPBhXbIMKte3AhafeatNJixYjhlHQGjVX3x4ojTfzljdyMZmUOBqg+hLu4gtCHiWyw69FpRIXrKcmszJ8Fwto/H1aHzFPRITfdAq7v8v5fUcbNGOZe2VAPhZTi8qASYyQY+vg0egzvHZy9Q1bo3KoKk8w2YOfv8t1zn43mV4MM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UR7p08Z49PcgjRcTwFU5I0j8XoviR4YRxtAi5RPPW0=;
 b=gaV5iZ0k6poGRJDnLbns1jU8ny4XpDA4V+CghGgjxl/mcnaN73dnWXya8nFYxKgUFO79ZNND4EGqvFnfAjov08iUc1dGuIMY7orknjWeY0YqdnaW7mzSCmPp6TTgKOv6RrHUUAzj/uGLUufJqhhMne69wT2Aup5DLM4CTt+6Uge6OjJUJ7LDTrx+o3RXElEo6SsIMrANDyXPDjX8mXof8hG3icwvmsr4c/FUc8QEL39mnzZBM8kZ1FloPVhr0VH722F5vj6sLTElNvcy6hHxDxr5o7IhcZiY6NQuk7m5rLvqi3I17ikNLsoMri8r5WavkE00tT3OHNl0BxXq2I/xuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1064.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 02:11:35 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 02:11:34 +0000
From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW1BBVENIIHYyIDIvM10gaTJjOiBk?=
 =?utf-8?B?ZXNpZ253YXJlOiBFeHBvcnQgc3ltYm9scyBhbmQgYWRkIF9fd2VhayBmb3Ig?=
 =?utf-8?Q?Starfive_I2C_driver?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MiAyLzNdIGkyYzogZGVzaWdud2Fy?=
 =?utf-8?B?ZTogRXhwb3J0IHN5bWJvbHMgYW5kIGFkZCBfX3dlYWsgZm9yIFN0YXJmaXZl?=
 =?utf-8?Q?_I2C_driver?=
Thread-Index:
 AQHc7bXp6VO2JmCcUEmfYvPfWjRk3LYh2BOAgADhMoCAAFd8gIAACjQAgAnVsICAAMIzQA==
Date: Thu, 4 Jun 2026 02:11:34 +0000
Message-ID:
 <ZQ0PR01MB1269F2B1F913B63456E0DADD82102@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <20260527085039.44435-3-lianfeng.ouyang@starfivetech.com>
 <c1ae50ab-1228-45a3-b910-4564774f4198@kernel.org>
 <ZQ0PR01MB1269B87604C6DE7FC2E6ACCC82092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
 <d138759d-ec07-4d94-bbce-d34d5bd4fe61@kernel.org>
 <ZQ0PR01MB1269926D984F86CB9B87E3F182092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
 <be917331-820d-4bd6-b877-77471af5b3b8@kernel.org>
In-Reply-To: <be917331-820d-4bd6-b877-77471af5b3b8@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1064:EE_
x-ms-office365-filtering-correlation-id: ebf9bb79-2a5e-4037-32ec-08dec1de9a55
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099006|4143699003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 rECSSSq8ZbqwlWRaoYkADuTctyfNVIVnUD+8wDC82S8VwLD5+aHKzdS8P9pvbiafgr1fkg3V1XLwYywX1fzZwmfBGUC6mNy8wxXYHd28cb1Io3X9q8zGxBTT8noCLNXYdlG/E9HZA8INCZfflSM1pu4Wi5ndaxtFMta8n6P+aHIxhosllnY35vqSGO7wQAiymQqR3uxdUyIK9hwaism2dJYJPkEtwIOFRBQnZigUf3RXQlquVkP3v3Nfr0LGdhI9fuTgR4qfGm11JHKersrxdMIdEm7KZ7nzp76TFdO8dr28h3yFlgXW3oajGIMGsT/xSzk1mZESLe02bnDulOaLFnfDAd+6yKD7PAEnYLgWXoyNuyaLo5Ui4HF9bPHd4GBcVHIQJ8RfUxXkQSGgYBBQgD4M6NZeFdKrGPQIXK5RJJkTJFYQP1Vvzh0bRfb+pMdj37MsJMLvSK8P7nXFxIpdyEkI4qY/DpkzV7ist4cOh1ed70VF+YzcbP3UlLM9uoTHHVUO+dh+I15xQhCzEJPn6Uu5ENbdZc8bd4Y2JC01zH2z/QrTYYs41cAhHydvgeTO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099006)(4143699003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkpLUVFVd1ZVeEhlUHU5MWYwSnFiTzBFVkorMjVCZmsreDAxcTFuRUZVeXMx?=
 =?utf-8?B?UlBraEhqUFgrWlhiR1VLZ0RzTG9lVEY1MlhtcnZUM1p1WHc3eVZHaGVXQTBQ?=
 =?utf-8?B?VDN2aGFGdE5XNkJTbEtTSXc0N3owVlYwZGFFb1ZyMW9qSFYwek91cEtWZlYw?=
 =?utf-8?B?Qi85elJQTHhLRnJHSDFNSnJ5bWtsRTdtV2R6ZlZQQlRVdDJ0eDRHbCt6L1hO?=
 =?utf-8?B?QnlTQktSZVlGZDhIOFdXbnIrZGxhMmRxMjVyRUt5ZjVVM0tacUdPR2JIc2VF?=
 =?utf-8?B?ZTI2NWhTR3lpOHF1czByR1JXMVV6ZktiVjd3SURTVEEvd211V3doblFpak1W?=
 =?utf-8?B?MnMxTmtsSzZFT0tjZyt1b1FxR1FURW9lRmc0a0Yxbnc4akNveVFvc3IyeHR2?=
 =?utf-8?B?QWIvRVc2VVBPcjVYeWlKeFdGUkEzZTFoUlJCZndLelpzcVVpR3ovSzFwUjZK?=
 =?utf-8?B?SnRDUjl2VnFPK1hPUUl4N3BOa3JudGk5SDNRUlBwUm95NC9iZnhrK3BoVTJD?=
 =?utf-8?B?VVNwY3lBVTIyV01SSVBaVEN2cGp2TzIzLzdZU3hYY3BjTDdBQ1Z0R1d6UFBu?=
 =?utf-8?B?UlJTVzJBempEVGhmdXFBa2hMellra3AvRUZMV0dnR1pXNzVkNUdmK3JNcGFZ?=
 =?utf-8?B?eVJLQmxRTzEwbFhnOXR0cVdFVVdKYVZsT2k2T2pXTTJUU1FkdlhXUnZsM1Z2?=
 =?utf-8?B?VTN2TmNvM29zWlRaSTZYTkhCWnVKaFRqenNtT2hOVkxCZ3pWbmdZN2NFcnhu?=
 =?utf-8?B?MGRMYk4rQzVkV1NyWlNrc2pVOURwYWRTS3gxZyszTko3NndPb2dOWHRJNjY2?=
 =?utf-8?B?a0pEZENZamgvM2tGNThMRXN0OTNNbnR0bXRwYTk5WldIU2VhRUVvUE01dWIy?=
 =?utf-8?B?ZTJycjJua3JaTmxLanF1STFtTkN1SjJWcitBUmJLUGZhSmdyTk9oeWpnU0Vn?=
 =?utf-8?B?S2l1c2lyQVNMV1o3Q2kvSlgyU204VlJLWDRVQSt3ZHo2RXorc0l2b1RWemdv?=
 =?utf-8?B?WFU2djdGWC81TVFGZUxUK2VoeTZEd09IVm5SSytDQXZMNkhGYW1kdWJra2Zm?=
 =?utf-8?B?YXJIRXNZdW1KeG9yYjNJQXZlWko1cEo4Yjl1cXFIb0NvTE1oTithbEtzaEk1?=
 =?utf-8?B?bm5HNkJGZmc4RklRWVhSTG5vY3BtQnlBWlJoUzNqcmQ0akhjSndNL0JjL1pG?=
 =?utf-8?B?NmhJMUNUbkFZTUFaVEgwYmtoTWphYmlLOGJqUTVsdzJNcVFrY3FLS2FJdWZm?=
 =?utf-8?B?RHZFZjgwT1k5aUREanBPT1BXTTlTTE5WSXdUc2dJN2VZdWtpeGlsT25XNkEr?=
 =?utf-8?B?QVVHcy85SjgzWUsrdnRnK3MxdjYvNy9wYkdieFJzalQyOUpGUFBRMk5Ba3lX?=
 =?utf-8?B?S1FkTkdrL0R2amFEVkhNdmFFTW1aZmhWRkUzSG5rZU1kV2Z6YzIwZStxYTF0?=
 =?utf-8?B?ajN5MVJvM0RQZXE5VXMvUDNGWVkrUXp0bXJGWTJTYURCRVNYaFV2d0dJWGUz?=
 =?utf-8?B?ZjZSTkI2RjZtQkdsaUJsRlc5RytuVnZzM1NGY2cxYU1IYm5SZFFmRUNBdlhD?=
 =?utf-8?B?elVINGI3Z1Fnd1ZOalBjSTVYTVhnbHpJcmtkZVhJVkNTYXJPRHpIYUxDUlFE?=
 =?utf-8?B?UC9XdUp3VklWSEljZ3JlcmVwZEtPWE9QaS9lMzhGa1hvL29pR002eXdjdG9H?=
 =?utf-8?B?KzBBU2o4WWJSeG1rQmh5YUw2Wk4wVHNFRjJKbENsbkMxL0NQdUx4RE1GcTdw?=
 =?utf-8?B?R1hUNzZDaDk1RG1iRlJiZE0yRXJHbTJKMktoQWQrQnl5Nnoxc21iQUhxeHBq?=
 =?utf-8?B?b3VWZURoK29LKzM1YThoME1oT0RKOFlZLzQ3VWRrOFcyQ3pxZ0pib1J3VnJk?=
 =?utf-8?B?NU9ocEdYWExjQit6YUpWMU10eityV3FNS1A4cW1PbXRJRVRiOC8yL2VENjhZ?=
 =?utf-8?B?TGg5c1QrQ2FiRS84bEUyVG1PMk1rRzBYaG9xNWt6VmcyS3NsSGhHVkpKd2VX?=
 =?utf-8?B?WVRkOEZYWWQ2QlJBenhTdFZ1YktDZXZmK3lFRjA1SGxDaWlZYWc3RW5wWC9t?=
 =?utf-8?B?dDgvRi9WM3FxRHpFbkZJTVNBdm0xbzZJQ0dLSGJ2bHlQdXRtTnhIRzZITlE1?=
 =?utf-8?B?ZnJzaGVXSUJNUGhzQmhDcURjbGZybGFITWxwQTlEUERGeXh1bkRyWDN1cEZV?=
 =?utf-8?B?a2tGUEowWVRwR3ZmcjBXRGJLQ3RpSTNqMEtCSWNuV09nb0w0T0NyL1hRSFRw?=
 =?utf-8?B?c2tiYW1OeUMzYkdBTU9UVnlLSFlTNVIrOGVMd2I4cVdjYWZzVExhOE9Tai9T?=
 =?utf-8?B?NDhOdHYxT3l3cXVSTGdyQk8vcXZESjB4ODZyL3M2ZzlnVDVHN2FOeFNraXNo?=
 =?utf-8?Q?KknOH4JOmSJbF8D8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf9bb79-2a5e-4037-32ec-08dec1de9a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 02:11:34.8803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/bDgo/r9+Lfo1O3bs2Lsoyu9EgHXYCI0ishcWfj79UgTfCFppDvb3I2EGrZrBVjTrq2dYU8y4qcvxWU8p2EOJccfGTYkS+wCDnrekl/dnIk+2WvcUK8m40F6pEU5a+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1064

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0NuaciDPml6Ug
MjI6MzQNCj4g5pS25Lu25Lq6OiBMaWFuZmVuZyBPdXlhbmcgPGxpYW5mZW5nLm91eWFuZ0BzdGFy
Zml2ZXRlY2guY29tPjsgQW5kaSBTaHl0aQ0KPiA8YW5kaS5zaHl0aUBrZXJuZWwub3JnPjsgUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyemsr
ZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IE1pa2EN
Cj4gV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT47IEFuZHkgU2hl
dmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiDmioTpgIE6
IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IOS4u+mimDogUmU6IOWbnuWkjTog5Zue
5aSNOiBbUEFUQ0ggdjIgMi8zXSBpMmM6IGRlc2lnbndhcmU6IEV4cG9ydCBzeW1ib2xzIGFuZCBh
ZGQNCj4gX193ZWFrIGZvciBTdGFyZml2ZSBJMkMgZHJpdmVyDQo+IA0KPiBPbiAyOC8wNS8yMDI2
IDEwOjI4LCBMaWFuZmVuZyBPdXlhbmcgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLemCruS7
tuWOn+S7ti0tLS0tDQo+ID4+IOWPkeS7tuS6ujogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0Br
ZXJuZWwub3JnPg0KPiA+PiDlj5HpgIHml7bpl7Q6IDIwMjblubQ15pyIMjjml6UgMTU6NDYNCj4g
Pj4g5pS25Lu25Lq6OiBMaWFuZmVuZyBPdXlhbmcgPGxpYW5mZW5nLm91eWFuZ0BzdGFyZml2ZXRl
Y2guY29tPjsgQW5kaSBTaHl0aQ0KPiA+PiA8YW5kaS5zaHl0aUBrZXJuZWwub3JnPjsgUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiBLb3psb3dza2kNCj4gPj4gPGty
emsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IE1p
a2ENCj4gPj4gV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT47IEFu
ZHkgU2hldmNoZW5rbw0KPiA+PiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0K
PiA+PiDmioTpgIE6IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOw0KPiA+PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+IOS4u+mi
mDogUmU6IOWbnuWkjTogW1BBVENIIHYyIDIvM10gaTJjOiBkZXNpZ253YXJlOiBFeHBvcnQgc3lt
Ym9scyBhbmQgYWRkDQo+ID4+IF9fd2VhayBmb3IgU3RhcmZpdmUgSTJDIGRyaXZlcg0KPiA+Pg0K
PiA+PiBPbiAyOC8wNS8yMDI2IDA0OjM2LCBMaWFuZmVuZyBPdXlhbmcgd3JvdGU6DQo+ID4+Pj4+
ICAJeyAuY29tcGF0aWJsZSA9ICJtb2JpbGV5ZSxleWVxNmxwbHVzLWkyYyIgfSwNCj4gPj4+Pj4g
IAl7IC5jb21wYXRpYmxlID0gIm1zY2Msb2NlbG90LWkyYyIgfSwNCj4gPj4+Pj4gIAl7IC5jb21w
YXRpYmxlID0gInNucHMsZGVzaWdud2FyZS1pMmMiIH0sDQo+ID4+Pj4+ICsJeyAuY29tcGF0aWJs
ZSA9ICJzdGFyZml2ZSxqaGIxMDAtaTJjLW1hc3RlciIgfSwNCj4gPj4+Pj4gKwl7IC5jb21wYXRp
YmxlID0gInN0YXJmaXZlLGpoYjEwMC1pMmMtc2xhdmUiIH0sDQo+ID4+Pj4NCj4gPj4+PiBTbyBi
b3RoIGRldmljZXMgYXJlIHRoZSBzYW1lLi4uIE9yIHlvdSBtaXNzIHByb3BlciBlbnRyeSBpbiBJ
RCB0YWJsZS4NCj4gPj4+PiBEb24ndCBzcHJpbmtsZSBjb21wYXRpYmxlcyBhcm91bmQgdGhlIGNv
ZGUgLSBJRCB0YWJsZSBtYXRjaCBkYXRhIGlzIGZvcg0KPiA+Pj4+IHZhcmlhbnQgY3VzdG9taXph
dGlvbi4NCj4gPj4+Pg0KPiA+Pj4+IEJlc3QgcmVnYXJkcywNCj4gPj4+PiBLcnp5c3p0b2YNCj4g
Pj4+DQo+ID4+PiBPaywgTWFzdGVyIGFuZCBzbGF2ZSBoYXZlIGRpZmZlcmVudCBiYXNlIGFkZHJl
c3NlcyBhbmQgaW50ZXJydXB0IG51bWJlcnMsDQo+IGJ1dA0KPiA+Pj4gdGhlIHJlZ2lzdGVyIGxh
eW91dCBpcyB0aGUgc2FtZSwgc28gaW4gdGhlIG5leHQgdmVyc2lvbiwgSSB3aWxsIG9ubHkgdXNl
IHRoZQ0KPiBzYW1lDQo+ID4+PiBjb21wYXRpYmxlIOKAnXN0YXJmaXZlLCBqaGIxMDAtaTJj4oCc
LCBhbmQgdGhlbiBhZGQgc3RhcmZpdmUsIGkyYy1zbGF2ZSB0byB0aGUgZHRzDQo+ID4+IG5vZGUN
Cj4gPj4+IG9mIHRoZSBzbGF2ZSB0byBkaXN0aW5ndWlzaCB0aGVtDQo+ID4+DQo+ID4+IFlvdSBk
byBub3QgbmVlZCB0byBkaXN0aW5ndWlzaCBzYW1lIGRldmljZXMgdXN1YWxseSwgYnV0IEkgc3Rp
bGwgZG8gbm90DQo+ID4+IHVuZGVyc3RhbmQgd2h5IGRvIHlvdSBuZWVkIGFsbCB0aGVzZSBkaWZm
ZXJlbnQgY29tcGF0aWJsZXMgYW5kIHlvdXINCj4gPj4gY29tbWl0IG1zZ3Mgb3IgYmluZGluZyB0
ZXh0IGRvIG5vdCBoZWxwLCBzbyBJIGRvbid0IGtub3cgd2hhdCB0byBhZHZpc2UuDQo+ID4+DQo+
ID4+DQo+ID4+IEJlc3QgcmVnYXJkcywNCj4gPj4gS3J6eXN6dG9mDQo+ID4NCj4gPiBUaGUgSVAg
Y29ycmVzcG9uZGluZyB0byB0aGUgaTJjIGRyaXZlciBzdWJtaXR0ZWQgdGhpcyB0aW1lIGlzIHF1
aXRlIHVuaXF1ZSwNCj4gPiBzbyBpdCBzaG91bGQgYmUgZGlzdGluZ3Vpc2hlZC4gVGhlIG1hc3Rl
ci1zbGF2ZSBvZiBpMmMgZGVzaWdud2FyZSBhcmUgYXQgdGhlDQo+ID4gc2FtZSBiYXNlIGFkZHJl
c3MgYW5kIHN3aXRjaCBhY2NvcmRpbmcgdG8gdGhlIHNjZW5lLCBzbyBvbmx5IG9uZSBpcyBpbml0
aWFsaXplZA0KPiA+IGluIHByb2JlKCkuIEJ1dCBpMmMgc3RhcmZpdmUgaGFzIG1hc3Rlci1zbGF2
ZSBhdCBkaWZmZXJlbnQgYmFzZSBhZGRyZXNzZXMsDQo+ID4gYW5kIGl0IGNhbiB3b3JrIHNpbXVs
dGFuZW91c2x5LiBUaGVyZWZvcmUsIGJvdGggcm9sZXMgbmVlZCB0byBiZSBpbml0aWFsaXplZCBp
bg0KPiA+IHRoZWlyIHJlc3BlY3RpdmUgcHJvYmVzLiBJZiB3ZSBkb24ndCBkaXN0aW5ndWlzaCwg
d2UgZG9uJ3Qga25vdyBpZiB0aGlzIHByb2JlIGlzDQo+ID4gaW5pdGlhbGl6aW5nIHRoZSBtYXN0
ZXIgb3IgdGhlIHNsYXZlDQo+ID4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgeW91IHJlYWQgdGhlIGNv
bW1lbnRzLiBBZ2FpbiwgeW91IGNsYWltIGRldmljZXMgYXJlDQo+IGluY29tcGF0aWJsZSBidXQg
aGF2ZSBleGFjdGx5IHRoZSBzYW1lIHByb2dyYW1taW5nIGludGVyZmFjZS4NCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCkhpIEtyenlzenRvZiAsIA0KVGhhbmtzIGZvciB5b3Vy
IHJldmlldy4NCg0KTm93IGkyYyBoYXMgYmVlbiBjaGFuZ2VkIHRvIHVzZSB0aGUgc2FtZSBjb21w
YXRpYmxlIGFuZCB1c2UgDQouZGF0YSB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIG1hc3RlciBhbmQg
c2xhdmUNCg0KQmVzdCBSZWdhcmRzLA0KTGlhbmZlbmcgT3V5YW5nDQoNCg==
