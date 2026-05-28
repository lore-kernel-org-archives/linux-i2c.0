Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269C2F5498;
	Thu, 28 May 2026 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936116; cv=fail; b=JGIlpa+OO16IrUJ+kIDWDFqkorRZ9Yc5GMD9rB/bdb1ejVg7nSyysnjBR84BsDJ/BqaIR7gnMmKz+6b6eZSb88Zba577637XPkCdDTnFMpTwfawIv0Lgf/ke8hCFcheySYBreG4Jb3nFEA0qTEcGt25LAvbPZveiKi8gxyJbAWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936116; c=relaxed/simple;
	bh=xkeo8IBZEnjAMcisvmosSnxBAlYCROU1TSucW6EN4JU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ardENVseaHr+5LdAKXD2CIDO+m41GCzZPA/za7qv9FxXlE3Bo1mmlWdz8dqge7nF9RsMEsXoOv8nXSiGcAsbQYnpxLnk3Bw3Xliv5zdFO3A0hpYrBMeMWwLpT1dkWXxsyLoZBlHydVR4dlXsM0xoGO0ZfChXLKc42q/eE0Zz85o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQCwVORVIbIIHcuptk75Rnz7tcKjQ07P1hRbFEkm5PmBoGydqnX81v8K2+rKTGg1BXI6LLFgjDIgIPjwv4I6owmvVF596WJOQPETQUHtaiAT3SCeYMDC/5jmMyJZKsZPrqs4c0DNTuogtIegcI30vJ055F13DFKJkQzpBJK6bAXpw/w9itrZGq4/+INW2pkSxluishdvekL5Oy/9Eefbs+VtXSISqIdJG+i4y2n/KTGhITOiw1WMohhWQ3RNlCR6tfHBTmcM8nhZBO0MAR4beKM7wWj22c6BbPS4v/NxoRVB+U+XSM7WKPcckC9Xe8NQG7qPaHm0vMHqTD7AXi2GEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkeo8IBZEnjAMcisvmosSnxBAlYCROU1TSucW6EN4JU=;
 b=ingAW+nKuMjdg2IXPWQp0WMH3ecBrIdEVnaKMCkr20dlpZPCcGfRqEv96KENABalcMn/1DdMy92q5CfqqimVdqs3r0SLfdmwyV/HvbfcgudUKaU9u9GdVGPEGfZEccZZAjxNGIodN+mOVmFTbG6PPXAuzvcs+OzBISWBVbp9HmOW4shniwnJVS5eHwi4bnZ01covp1fqt42xv1FMisHNNOblCXK4izI20x4wmBYnrE8/K1JHWEAQ14gJbdfY1KK/1rXw6aBiDMZBEv+wfsYJV5Y9YCfcUVDibMlK+yKfHN7egOiGjg4j9BV78BaVyjLfz/KXRG0/xCpfJHvabOsP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB0984.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 02:41:49 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 02:41:49 +0000
From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMC8zXSBpMmM6IEFkZCBTdGFyZml2ZSBKSEIx?=
 =?utf-8?Q?00_I2C_master/slave_support?=
Thread-Topic: [PATCH v2 0/3] i2c: Add Starfive JHB100 I2C master/slave support
Thread-Index: AQHc7bXo+kP9ks3Lj0ixZJAu4nf4cLYhz2oAgADrd2A=
Date: Thu, 28 May 2026 02:41:49 +0000
Message-ID:
 <ZQ0PR01MB126901EAB86A7F1CE705DF1C82092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <20260527123620.GD3102@black.igk.intel.com>
In-Reply-To: <20260527123620.GD3102@black.igk.intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB0984:EE_
x-ms-office365-filtering-correlation-id: cdb43fca-d67a-44c1-2595-08debc62ab2a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|6133799003|4143699003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Q56TVsz1fv+cVToDhyB72pOiOPYcQ47RZN4A9LcDsTezBkRxYGn37C8AVfL0xOAt/tl80jeHqHnp5++ZDnyEM8aVZDLn49jw6we6pnenaf06s9wQo6CPZL7xjtgqHgPmHNjZ6bgTQYysyGkFJGt0R3rre+MBsrlOMQ1OkVVMKXqp4YMKbBDE8I7pBz3tyoTroQxe9xMrRAZaPAb/MT1iBo0Rc1D6jp0EGVhOhonhzC376G7UMMGW0U8lz6dixjN4TkHm43VsSVdt1s8J7COhOLNCzE99vmwaHOrEdv5HMAaSn28nDv1PJBqiOPCTx62VKfpXnBCrfJVI32qmPKf6ZcdsNl578RHy5GMiX2inbcyoM7uCxZbAMXPPLLfr/JpwUAhUMp6+GR6Qhbe9HGpUSLZ8a9IbCSCbE3NvW7lWR1h7E0ctawJsQA/Z6tXklxwVnxBode4fHsuZwM+K2bFkayXO/pPlN4A50qjTJFTDpoaQB1RfZcf8Wep+OR7H4BAZPnBOeY9LdJIR3hzzZOINxootJLIXWBLURS9/r6Uv6yIra3qmTaEx3o78+io/lzac
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(4143699003)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEdYV2JFUXl3a1k1eWZIRkQyY2JPbzNac1grVlRCZ3RkUFI2aWdtM1RHWFJv?=
 =?utf-8?B?akoyKzVJeGZISWV2NG1kSG84cmszZGo0YTZSeHRtOXplYmxWWGN0ODIxcHZz?=
 =?utf-8?B?bG8wWXNsVUlnSFQ4aTNpcDhuM2VnblB3bTE2eHN5YUxOWGw5VXFNQmc1bVI4?=
 =?utf-8?B?ZVFJSmdYNHhBdGJZRG5tNGlSZDFVaGtkZ0d0RjE4VzJDTmZkSGhjNHZIeG5q?=
 =?utf-8?B?T0NiQ0RKVXM5SUhrV1lsdzg0bENwSjhkKy8wZjQ5d3U5OENrUWoxSFRmOTVL?=
 =?utf-8?B?KzJRb0thTng1MU5LQmhacC9ab0pkNm1MK3NVTGh5UDN2RDk0Q2c1c29VSE52?=
 =?utf-8?B?YnhvZ0ZNSU5pUFhpY01xSm4xREYrZnZlNkVuUGVGUFo3MW9iT2VoTHZHS2hL?=
 =?utf-8?B?TUQrVlhxUHVTeGkrdGM3TTdNMFZoUFQzcjVGTit1c0lyTFliRFd6TUx4MC9T?=
 =?utf-8?B?NlNjK1kzWVJYN2lSYVZjOEhBQmZGU2ZPMFVBQW4zUURMVk1xWUk3NVdRS0Nk?=
 =?utf-8?B?VXBCT2t3QWlTcXhLWWtLVGM2TXdTaXJ3WW5VaEt1S0ViUjlEOWFHd2JBTENP?=
 =?utf-8?B?alhkdVQzc0E5c3dvYy9wYjNHeDgxd3VWRU8vRXVpTzhSVTM1UGhVMkpuMGU3?=
 =?utf-8?B?b3ZJbHRzU0NwbjBlN1BXeEEzZUMyUHVsalAxdVBoSkk5cnljcTVqK21WR2w1?=
 =?utf-8?B?TitERjRuMjlXU3lWRVUrMnM5MTNrSmUxSWVrcjZCREdYY3RqQmtUK1VZSmg1?=
 =?utf-8?B?TUZBMDNVY25LMVljZnFOaU0raWNLVE9LekdzY09xcWh3VkJVU1puRlJ1dnFI?=
 =?utf-8?B?ZDMwam5QRk1EczFUSDFRbC8ydmV0U0p0ZEtycDBncEIzdDR3Zk1TMkQvS3pv?=
 =?utf-8?B?OGZFdWRwM1UweW92YlkvdE4vcmQ4bDhJMVZZZkpNMFg0UnNNL3NhSGcvM2dL?=
 =?utf-8?B?dXcyTmc2TVhBSnVib2c2N05nS2xZRk5wdVlWdGJyVUx4WmdBUU8wMlNuNytt?=
 =?utf-8?B?STNHZU5ndkdBaDRnSVZzQUNQQjlKUW5QVXZBZGhFV0pzK3JIemYweFhXTDRh?=
 =?utf-8?B?T3RWOWx1Qm5VQ1ZpQ01RZ2RnRThWRjhRUXE5anRFWVR6NEtOWUNEc05SWHQ1?=
 =?utf-8?B?TmJFelR5NkE2N0FpWWF0aW5GaWszOUNCSlBUZGtxaTFFajE5cjYxSUZJY2Mv?=
 =?utf-8?B?L1N0R3RiR3RKaGp6ZWYyVFBjSjA5LzhiRFo1WXh6TUNaekMyU2h5aldHOTVx?=
 =?utf-8?B?ekU1NlZyZlpyM3lJcTNyWnVSS1Y3VWZSMXY3RDZmeUMra3BQNzdUTDZRSkxX?=
 =?utf-8?B?S0VDOVd0NWoxRldFZ3lJUElFbitzRllYUkZLWmxaRjFCNGtSRjRjV2prNlhu?=
 =?utf-8?B?VjdGNk9lUWFLdURWWElLZlhySmdQR0gyUmFnT2NjZ0p3VllxaXgvOFdtSXo5?=
 =?utf-8?B?SEhHMWwrdEVxUzJHMkNWVkFtK0hMYVkwSWQyb0VacjFiOER3a1hMcnlVT0px?=
 =?utf-8?B?cStlQWxGRHZySnZIVGh5czVxYnZWREt6d282bWVMcWxSdDk2SHQwVkNTVXZo?=
 =?utf-8?B?ZjZGY0ltTE9UdWR3UmJFS1RIdU0zZituak5SMFNRdG5oMmg5cFEyK3hoRSs2?=
 =?utf-8?B?Y01BMFVWYXBEMlM0Zmh4cFNvbVVVMTRsNEdyWStUaUJFWDBtRk0vWEY2alQ2?=
 =?utf-8?B?ekZYYitPRGppdnNENC9UZjZvKzMxY3ZDZFJyTzdkNFNKTTB0UUFhNndSWUh0?=
 =?utf-8?B?V04xS1Q2czdYYjllUW83SlpmNmVhOWs0OE5ZYVdxUWJWK09iR3NtdkZ1UEdt?=
 =?utf-8?B?SkFJQTh5bTM2ZW9iR1hZTTlaZy9iaW5qaWlySkNuRjNTK0F1QjdGdllRYlND?=
 =?utf-8?B?OFlteHVwa1dRZ2RlSW1tRWRxbmJ1bm1Pbk1VSVlRbFBrdDg1S2F2aUROLzFm?=
 =?utf-8?B?TjFzVDg1b3kxM2VZcFh3NTY2bnJHcVAwQ2Fyd0N4QXRPNG1NeUVDOE9TZHA3?=
 =?utf-8?B?QmhsblU4SkFOd2xRS3h4SllzSFVNQk1sNm9WSHROUGg0OWpSMmhCcnQrYVBH?=
 =?utf-8?B?VUk2NXc5V3l5S0c0SmN3SUVTS1JzaWt3OVhHT05OUWtUSUdvWXpodHN2NFUx?=
 =?utf-8?B?ZUlKb3dMVC9nSTk4TGhhUlQvOEdrSUk1TXoydUYvaENYdFZuc0lraStuOHl4?=
 =?utf-8?B?VHNRRzdvL3pLKzgzUEhRczcrWUFLMEtxc2ZOTW5HM0gxQ1UxdEZBcjd4dXJI?=
 =?utf-8?B?RzU0cUJSMDhETWY4dEtZWDBDQlFDRGlZeUkxNm53STI2ZGt2NGJLbDNyN2NS?=
 =?utf-8?B?TjlPT3FZT1B5ZEFPNHM3eUdUWWw2dkV4THZHZnZ3eUVwbWpIRWpnQlJaK0Nt?=
 =?utf-8?Q?QPzRBDjBM3yfF12o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb43fca-d67a-44c1-2595-08debc62ab2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 02:41:49.6867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OoKgbSMqx7tZFXfbnKb8XoD3qPBH38l79EGeFaOg05zHOAU4mpnjZPV3xonfxDwBBejWRR/kuGO4oyHqOClNvgsffVa1P192//yyqyRAW2QbrpYkkqaC8Rc9mH6jRHZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0984

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IE1pa2EgV2VzdGVyYmVy
ZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI2
5bm0NeaciDI35pelIDIwOjM2DQo+IOaUtuS7tuS6ujogTGlhbmZlbmcgT3V5YW5nIDxsaWFuZmVu
Zy5vdXlhbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4g5oqE6YCBOiBBbmRpIFNoeXRpIDxhbmRpLnNo
eXRpQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsNCj4gS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25v
citkdEBrZXJuZWwub3JnPjsgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20+OyBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6
IFJlOiBbUEFUQ0ggdjIgMC8zXSBpMmM6IEFkZCBTdGFyZml2ZSBKSEIxMDAgSTJDIG1hc3Rlci9z
bGF2ZSBzdXBwb3J0DQo+IA0KPiBIaSwNCj4gDQo+IE9uIFdlZCwgTWF5IDI3LCAyMDI2IGF0IDA0
OjUwOjM2UE0gKzA4MDAsIGxpYW5mZW5nLm91eWFuZyB3cm90ZToNCj4gPiBGcm9tOiBMaWFuZmVu
ZyBPdXlhbmcgPGxpYW5mZW5nLm91eWFuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+DQo+ID4gVGhl
IFN0YXJmaXZlIEpIQjEwMCBJMkMgY29udHJvbGxlciBpcyBhIHZhcmlhbnQgb2YgdGhlIHdpZGVs
eS11c2VkDQo+ID4gRGVzaWduV2FyZSBJMkMgSVAsIHdpdGggYSBkaXN0aW5jdCByZWdpc3RlciBs
YXlvdXQgYW5kIGVuaGFuY2VkIGZlYXR1cmVzDQo+ID4gc3VjaCBhcyBTTUJ1cyBBbGVydCBhbmQg
cHJvZ3JhbW1hYmxlIEZJRk8gZGVwdGhzLg0KPiA+DQo+ID4gVGhlIHNlcmllcyBpcyBzdHJ1Y3R1
cmVkIGFzIGZvbGxvd3M6DQo+ID4gMS4gIEFkZHMgdGhlIGRldmljZSB0cmVlIGJpbmRpbmcgZG9j
dW1lbnQgZm9yIHRoZSBzdGFyZml2ZSxqaGIxMDAtaTJjDQo+ID4gICAgICAgICBjb21wYXRpYmxl
Lg0KPiA+IDIuICBQcmVwYXJlcyB0aGUgZXhpc3RpbmcgaTJjLWRlc2lnbndhcmUtY29yZSBieSBl
eHBvcnRpbmcgYW5kIG1ha2luZw0KPiA+ICAgICAgICAgY2VydGFpbiBrZXkgZnVuY3Rpb25zIG92
ZXJyaWRhYmxlLCBhbGxvd2luZyBjb2RlIHJldXNlLg0KPiA+IDMuICBJbnRyb2R1Y2VzIHRoZSBu
ZXcgaTJjLXN0YXJmaXZlLSogZHJpdmVyLCB3aXRoIHNlcGFyYXRlIG1vZHVsZXMgZm9yDQo+ID4g
ICAgICAgICBtYXN0ZXIgYW5kIHNsYXZlIGZ1bmN0aW9uYWxpdHksIGJhc2VkIG9uIHRoZSAyMDIz
LTA3IHJldmlzaW9uIG9mDQo+ID4gCXRoZSBTeW5vcHN5cyBJUCBtYW51YWwuDQo+ID4NCj4gPiBD
dXJyZW50bHksIGR1ZSB0byB0aGUgZm9sbG93aW5nIGRpZmZlcmVuY2VzLCBpMmMgZGVzaWdud2Fy
ZSBjYW5ub3QgYmUNCj4gPiBmdWxseSByZXVzZWQNCj4gPiAxLiAgRm9yIGhpZ2ggYW5kIGxvdyBs
ZXZlbCBjb3VudGluZyBzZXR0aW5ncyBhdCBkaWZmZXJlbnQgcmF0ZXMsIGkyYw0KPiA+ICAgICAg
ICAgc3RhcmZpdmUgY2FuIHVzZSBJQ19TQ0wtSC9MQ05UIHRvIHNldCBTUywgRk0sIEZNKywgVUZN
DQo+ID4gMi4gIEludGVycnVwdCBjbGVhcmluZyBpcyBhY2hpZXZlZCBieSB3cml0aW5nIDEgdG8g
dGhlIGNvcnJlc3BvbmRpbmcNCj4gPiAgICAgICAgIGJpdCBvZiBJTlRSX0NMUiwgd2hpbGUgZGVz
aWdud2FyZSByZWFkcyBkaWZmZXJlbnQgY2xlYXJpbmcNCj4gPiAJcmVnaXN0ZXJzDQo+ID4gMy4g
IE1hc3RlciBhbmQgc2xhdmUgcmVxdWlyZSBzZXBhcmF0ZSBwcm9iZSBjYWxsYmFja3MgYW5kIGNh
bm5vdCByZWx5DQo+ID4gICAgICAgICBzb2xlbHkgb24gdGhlIHJ1bnRpbWUgbW9kZSBzd2l0Y2hp
bmcgcHJvdmlkZWQgYnkNCj4gaTJjX2R3X3NldF9tb2RlKCkNCj4gPiA0LiAgVGhlIHZhbHVlIG9m
IEZJRk8gZGVwdGggaXMgbm90IG9idGFpbmVkIHRocm91Z2ggcmVnaXN0ZXJzLCBidXQNCj4gPiAg
ICAgICAgIHdyaXR0ZW4gdGhyb3VnaCBEVFMNCj4gPg0KPiA+IEkgaGF2ZSB3cml0dGVuIHNvbWUg
cG9vcmx5IHN0eWxlZCBjb2RlIHRvIHJlZHVjZSBjaGFuZ2VzIHRvIGkyYyBkZXNpZ253YXJlDQo+
ID4gYW5kIHJldXNlIGl0cyBmdW5jdGlvbnMgYnkga2VlcGluZyBhYSBhbHdheXMgdHJ1ZSwgZm9y
IGV4YW1wbGUNCj4gPiAxLiAgdGhlIGltcGxlbWVudGF0aW9uIG9mIGkyYy1kIHdfcHJvYmVfbWFz
dGVyKCkgZGlmZmVycyBvbmx5IGZvciB0aGUgdHdvDQo+ID4gICAgICAgICBJUHMgaW4gaTJjX2R3
X3NldF90aW1pdHNfbWFzdGVyKCkuIEluIG9yZGVyIHRvIHJldXNlDQo+ID4gCWkyY19kd19wcm9i
ZV9tYXN0ZXIoKSwgaTJjX2R3X3NldF90aW1pdHNfbWFzdGVyIGlzIGRlY2xhcmVkIGFzDQo+ID4g
CV9fd2Vhay4gQSBiZXR0ZXIgYXBwcm9hY2ggaXMgdG8gdXNlIGEgY2FsbGJhY2sgZnVuY3Rpb24s
IGJ1dCB1c2luZw0KPiA+IAlhIGNhbGxiYWNrIGZ1bmN0aW9uIHJlcXVpcmVzIGNoYW5naW5nIG1v
cmUgaTJjIGRlc2lnbndhcmUgZmlsZXMuDQo+ID4gCUkgZG9uJ3Qga25vdyB3aGF0IHRoZSBhdHRp
dHVkZSBvZiB0aGUgY29tbXVuaXR5IGlzDQo+ID4gMi4gIEZvciB0aGUgb3BlcmF0aW9uIG9mIGNs
ZWFyaW5nIGludGVycnVwdCBmbGFncywgaTJjIGRlc2lnbndhcmUgcmVhZHMNCj4gPiAgICAgICAg
IGFuZCBpMmMgc3RhcmZpdmUgd3JpdGVzLiBUaGVyZWZvcmUsIGluIG9yZGVyIG5vdCB0byBtb2Rp
ZnkgdGhlDQo+ID4gCXJlbGV2YW50IGxvZ2ljIG9mIGkyYyBkZXNpZ253YXJlLCBJIGFkZGVkIGEg
d3JpdGUgb3BlcmF0aW9uIHRvDQo+ID4gCXNmX3JlZ19yZWFkKCkNCj4gPiBTbyBJIHRoaW5rIHRo
aXMgdmVyc2lvbiBvZiB0aGUgY29kZSBpcyBub3QgYWxsb3dlZCB0byBtZXJnZSwgYnV0IEkgZG9u
J3QNCj4gPiBrbm93IGhvdyB0byBoYW5kbGUgdGhpcyBzaXR1YXRpb24gYmVjYXVzZSBpZiBpMmMg
ZGVzaWdud2FyZSBpcyBub3QgY2hhbmdlZA0KPiA+ICBhdCBhbGwsIHdlIHdpbGwgaGF2ZSB0byB3
cml0ZSBjb2RlIHRoYXQgaXMgc2ltaWxhciB0byBpMmMgZGVzaWdud2FyZS4NCj4gPiAgV2lsbCB0
aGlzIHR5cGUgb2YgSVAgbm90IGJlIGFsbG93ZWQgdG8gbWVyZ2U/DQo+IA0KPiBJdCdzIG5vdCB0
aGF0IHlvdSBhcmUgbm90IGFsbG93ZWQgdG8gY2hhbmdlIHRoZSBleGlzdGluZyBkcml2ZXIuIEl0
IGlzDQo+IGRlZmluaXRlbHkgZW5jb3VyYWdlZCB0byBhdm9pZCB1bm5lY2Vzc2FyeSBkdXBsaWNh
dGlvbi4gSWYgcG9zc2libGUgdGhpbmsNCj4gb2YgdGhlIGNvcmUgcGFydHMgYXMgbGlicmFyeSB0
aGF0IHlvdXIgZ2x1ZSBkcml2ZXIgY2FuIGNhbGwgYW5kIGlmDQo+IHNvbWV0aGluZyBpcyBtaXNz
aW5nIHlvdSBjYW4gYWx3YXlzIGFkZCAob3IgbW9kaWZ5KS4NCj4gDQo+IEFsc28gd2hpbGUgdGhl
cmUsIGxldCdzIHN0YXJ0IGJ5IGFkZGluZyBzdXBwb3J0IGZvciB0aGUgbWFzdGVyIG9wZXJhdGlv
bnMNCj4gZmlyc3QgYW5kIHRoZW4gbGF0ZXIgb24geW91IGNhbiBhZGQgdGhlIHNsYXZlIGJpdHMu
DQo+IA0KPiBIb3BlIHRoaXMgaGVscHMuDQoNClRoYW5rcyBmb3IgeW91ciByZXBseS4gSSBoYXZl
IGEgZ2VuZXJhbCB1bmRlcnN0YW5kaW5nLiBGaXJzdCwgSSB3aWxsIGNvbXBsZXRlIHRoZSANCmky
YyBTdGFyZml2ZSBNYXN0ZXIgZHJpdmVyIGFuZCBhcHByb3ByaWF0ZWx5IG1vZGlmeSB0aGUgaTJj
IGRlc2lnbndhcmUgcmVsYXRlZCANCmZ1bmN0aW9ucyBpbnRvIGNhbGxiYWNrIGZvcm0NCg0KQmVz
dCBSZWdhcmRzLA0KTGlhbmZlbmcgT3V5YW5nDQoNCg==
