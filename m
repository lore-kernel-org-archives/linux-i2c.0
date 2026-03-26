Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022102.outbound.protection.outlook.com [40.107.75.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4416F288;
	Thu, 26 Mar 2026 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490698; cv=fail; b=Epy+tKoB3koi0U755uCfyvCp6t47musP4yOCS+xOXfCjujbkgQaLYfAJiz0gx/yYMN6tdVNPMQ6aY0VuJXN4xJy2A70yfW5ZOKGDRrSwEvgPC8o7TDLg4Dpg/gyeat96iSY3RHD0IE0PhH7KVLS70d/39sAH1IP7YhLdKjl11fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490698; c=relaxed/simple;
	bh=+IufODNS7p7DPkPrEsyjPyf9/3xeG0Wqlt2lUfnY6WU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YaAkSUO2/R4GO6LlHPz12N4l+svYk2iWw07tRFX4RLMP82NQ/2jIxYviNTUazf1qq4StH43zGn80bNu/To6YjkJRd7LLofJLPJYywBK14lDZfil1Lgu2qXukOuCA+7QfKqBV9YGGaJ4L5SvTV0yJwFgUQEIGjDRshlSmLw6pyZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=OHM9uvI9; arc=fail smtp.client-ip=40.107.75.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="OHM9uvI9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vj5jsFmtT7CMNWgKtTkyuYlRlj0aicBDqnlAEz7p3QJ+aURx5HCuiy2jQ3cDidijZlCFvMA7XK+aoqpx3g/WNq6MK0aadndlWR/vIsCZruahXI29gcIX5kSBCwA9SMAvdQpVtxlbnTuF/MoQxK74fsC1X/e27DwwjZ4QKQqL5ElCaQCUGKhE8RWRnnbWuLIigkzSB6xVhHTj6OLaAi37Y6KVdoVl25sM4ay61LYP7gucjfIt3arBAiEa8Qr9pnJPve7feVWR+P34I8U3Qv8RSxz0cncaLo5/VrLL1Gpm9uJeMZzL41oczuNKOAQ8ruZoSpatu5JKgqjHjIRoZhbrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IufODNS7p7DPkPrEsyjPyf9/3xeG0Wqlt2lUfnY6WU=;
 b=Q6NyiwXKYYIgFiB8d3RHLtel20OMdp9N+0k2EAOT30Kb8M+qjxHO0Hvoo6NGkQjel01DySFi56wBOtQkRDQEUm6KAd0xsCuQSwLy2De2Q8a7bufi5GsPqiCPXOVSuB0brdRAngWfbN8c6HukLgEmbg+q3PveXe5JpUjjg/LbW0UHnGdgsFD5oFsxm/rKBaysUmTSuprI8lUVq2HiX9w1B1LZakcB+k7d/dNVqtxO63XABc2+9Q51ZxpR6Q580wBvRRp/HjH8xizbJB8kE6SJexktVLP8Ur65wWweszUPgLy9t5JBjDec2Y8630X1leTp2MCCdLkVjs0WklXP49uGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IufODNS7p7DPkPrEsyjPyf9/3xeG0Wqlt2lUfnY6WU=;
 b=OHM9uvI9lv2QNdyae8M6Als96NIWJav1nDRhLeOlMR1BJE4bM1/p9dqFUovozhGCTTdn0EVRqgW2O1qJHrQW+UTrR7u1B5FMBLNSYrr/LcEcrTwbEJOAZPHNj5GbEGtdrFsIAChhT1p+28Jrh7nY1jug49OhsDH3JOZyLx949FGh23iDGb+jgCQx/9sKgqwMqSr3OX9e+KTXLKLyXdvjDqCr3o3Qxkryw237RRjvK5GCceq5ZuA4DIxivuDBZ1niOMFrBx6U0W/pRT9FGydemP+H1tYk4eCIp+2a8Y9VwtlskmPTjlt1kx/DJljszdprn4PaYjflo/pnizS0V1/Dvw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TY0PR06MB5441.apcprd06.prod.outlook.com (2603:1096:400:32e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.21; Thu, 26 Mar
 2026 02:04:52 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9723.018; Thu, 26 Mar 2026
 02:04:51 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v27 3/4] i2c: ast2600: Add controller driver for AST2600
 new register set
Thread-Topic: [PATCH v27 3/4] i2c: ast2600: Add controller driver for AST2600
 new register set
Thread-Index: AQHcuzs6WXplkgruxkGBuUv9GH3m2LW9CJAAgAHhZjCAAA+KAIABFbbw
Date: Thu, 26 Mar 2026 02:04:51 +0000
Message-ID:
 <TY2PPF5CB9A1BE65A943F6ACF86A4D99DCEF256A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
	 <20260324-upstream_i2c-v27-3-f19b511c8c28@aspeedtech.com>
	 <db921d6b820a13d59d0ffb0ab042dc6c8c11897f.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6D451E8AFDBA03B81AFB4F249A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <28eee6d05ed1e1814f09ec907d56798a279f226d.camel@codeconstruct.com.au>
In-Reply-To:
 <28eee6d05ed1e1814f09ec907d56798a279f226d.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TY0PR06MB5441:EE_
x-ms-office365-filtering-correlation-id: 9edc204b-2f20-4f86-3a50-08de8adc1104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 ivUwu3rQ+BW/WBOh9W8LCmo1MOYY5LHLQx1ppre6xpI25qUedSq4E0BIYzBiDgR2D8AWIvGn8AOFb1I2CLu1++XKzuusdLBP/HtTmS3+/Z3h/XFuOGRJPDSyd1Cx1UjtwqXkE6/sruo/EpZfVEfRnUwrvBbDEoWkFiqEgS/6B4LEoq6GcQ96lxI907DSI9wDM3Ttl6s6CURDyDoX2lWi7Q3tkn1R2v/Y9L+TR+49lyUWXcSx0aRK0XKOsR8a4Py0nLm4AT+Rg9refd7hLtlEpAAcHPJaUivpUq8/Q4UCWhGJLOpyD48CAeGNl4Iwm4CE0j23rDNLn/NUy5UhXFBRtB5TwdnxigvOsu3cGR4Fr7P8zvQWU5JEenaesbfGJ9YVadsrVFqP4qiriR+thmlBu+HdKDlvg/pLZ1zq4hfcdNny7HypIdYlxfgRKrJA4l4Z5nGeiqZnueaOB+WFfcf5NHJumiGcV3PlHlpibOhWC5h6b4rrdkyipPpW1up237kxbqvI5QLWE+JkUMfL9z52gCE3X/KgPy1gh/2t1iV34jfag3fGIDe3ADUIoJHWDJqMP3za6lCzfzrTxr3Q16e/N8BivyhGLlHgPTF6H1p+WWh/kaTkMqkVG2ovXNBVlqqxfjd2cyB/1cUH5tqudv+pLQuypvT9gsnCZ+FHsPBFHA6o28jS12yOdeLV24ypT+igYvTIMdMEWd7pe9BcjzzuQqU3PGwKg7JsO35dxPIXjmy93C5OkWfQSTQI5P8wkJjXjDY1VWxVcxov35preN3wHaAS0daIsXAjVG98MUY3jj25qDYqMrCKz94bcS7ARWSI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHlSWDVTUFdQd01ZM1YrbjQwVlVhckNKbG4zd25TNTg1V1MyRlFPb2E3b3Az?=
 =?utf-8?B?U2tLNFpTcEd0L1oyUnFMZXNSWVB1cDJGNzYxQWJBbngrUys5ckppMmJTU2NT?=
 =?utf-8?B?OTU5WFgxeTJyZ1d2ZGF4WjdFWkZtZERENm93d0tqNW5hTUZHejBqMXUvSUhG?=
 =?utf-8?B?NEpOZ0tlQytIMVM1Y0hFUmt3UUdZYU9lbUIxMmxaWVIySTJ0VWg2MDRsekI3?=
 =?utf-8?B?ZnhJaGtIRzN4UmlXN0RZQWh6OU95MSsyYlM3ODdNZ1llT2V4R3Z3TlJ1MHpI?=
 =?utf-8?B?aGNsbWNJU2FsanhENXFkbFF2aDFZNnhtL08rRzhVK3RpL0dKMURHMnBIbmNV?=
 =?utf-8?B?VTlNS3BmTUFOY3dOazNqUFZLTVpMbDV6b2F2TVYydE82czE3M3BMa0JTNU9B?=
 =?utf-8?B?bU16cXk1R05Kdlo1bW5kcE14TmpsMTlTUEk3eHF6UU5yTVdvK25EZ1dBbTVP?=
 =?utf-8?B?cHRTYUxBMHB5SU9SWit0cm5ROUc3d3NYSWxzRDRKRjY2TXgzaWMyN3Zubjl4?=
 =?utf-8?B?aVo4dXdGMFh3U2VneDExanFLeTdqUXl3Z0oyMSt3bWdxNDJVQjNkQkJzYzZm?=
 =?utf-8?B?eld3OE1PSGI0Sm1DMlVHeXFFTDRrSE51NEtvUXJjak1GSE0wR0luSWlRazhZ?=
 =?utf-8?B?SGFFa3NRRThoTFBvY1FFamkzdXh6Ti8xalk1Wk1WaTBmMFl0TTgzdTRJdUsy?=
 =?utf-8?B?VmVoRjJzeHplQXladGVNQUVSQ3RiYUJCMUg2WHlkTEExdE5wMldRaDlORm0v?=
 =?utf-8?B?NFRvcXZQTHozNDJJUG5xd2hvZm9OK1FwaTZXT241OG9CZ2E1NGIxUjVCRSt1?=
 =?utf-8?B?dExpaVF2NFlTWXlwQWkxTDMzL29jRjcvbFIyQk5jZVBHUk5MVHBJemY2UHZs?=
 =?utf-8?B?L1ZmRzdDd2o1dG5yUEFDQVpBaVlpT0p4cVBYYmx4MDJsUGltMi8wbDl0L2JG?=
 =?utf-8?B?bFRjQTFDR2hiazJUODNlSGU4UlNmTEl3R1J3ZGdZQ2g0SHNNYmRmbVdXMi81?=
 =?utf-8?B?cUFqUEVuaFpXdDVQL3l1SE56Tm9oNlRjVElpYUNsMzByTk5BcTlzWU5ReHpt?=
 =?utf-8?B?VkkzR2tEbTFyZWdwcUxnTThpRHVYaS9GMjZxa2RkUmxkUGIzb2E5WGkyb0p1?=
 =?utf-8?B?NFI2azlVYlhLL0s5ZkV2M2JpZ3hyeThHRENZeWtvVnJPZWRiWmRuUkVaU3Nn?=
 =?utf-8?B?a0JXcjBScmVrMVFzMEVSVExPMjgrMHRFa09zV1lydXJVc0hiK0tPazV3YWc2?=
 =?utf-8?B?azBneWxwVnpkbi9XNkFKUElEZytwaEN0UUtaSk9KbjB3eFI1NXlrRWVGU1lC?=
 =?utf-8?B?SkF3MTRDWHdYeVpQYzJDNVhkaVJkUjdlNVdSZVlUc3Jqd0JvcmY1Z0oyVmZy?=
 =?utf-8?B?cTBneHc4L2hOUEFZNjFZcGVkZVZpbjI3YTBxREE0RitRaVQzOERZUjR3QS9r?=
 =?utf-8?B?dDFOR3MrTm5XQlU5RTZNSDFBUTlrNDZyNzZMcURtR00zZjlFK1pnR1FaZTM1?=
 =?utf-8?B?eFd5YWo2SGN2eHR5WGlndXVCby9FQTNuUUVRTzZ2OGpvVm0ydlJwRWxxNUhk?=
 =?utf-8?B?MEZOOFFCTXBaYlpSYzl6RklnaDM0KzhmMUxmTGZQeDk3elJzcTUwUFovc3N4?=
 =?utf-8?B?bGN0YnJ3a2owb0I3cTcveERGVUJuZnA4cXpxZTBUM1pwNkprVDIrbHBsZkR1?=
 =?utf-8?B?UDlReTRSTzl4V3V6NFBrbTJFUUluWmRCenczT3cvL2lnWVRpZ2RxY0g2UlhY?=
 =?utf-8?B?ampOVG5FOVAxOG9TdnVWeFpJL3lUZGhRK3dQQnVtUi84eDM0TTNZa2JkUXNF?=
 =?utf-8?B?WTNUNFV6ak1DTDdWRjZmN0hVMDl4RlhBenZ5bCt0NnFialMxVno3L1doRHND?=
 =?utf-8?B?RjZjcUFBT2gyTzNDcldZUjRUTjZ4NUhqKzFLd21nOHFCS1ppOE81bW5SRGEv?=
 =?utf-8?B?bGl3eVZTcVZGamhTa04rUk9pZWovUEJmV0tTVHMreEUyTkUycUdtd0dRcXln?=
 =?utf-8?B?T1VhWW1haE9OS2dYTEtTd1BFd1A1MkVHbjQrQlZzQmk5WmowV2djb2VRUG4w?=
 =?utf-8?B?WWp6T295RUlzZ0JnWlVUQ0RxdFk3Vk0vYk03N3VIbzBHVUFURTRkeS96Rjh1?=
 =?utf-8?B?NENhY1lZR0hPUnptOXVkZFdiaitWbHFGOCtydGpsVUpaTS84Z24rVEMveEps?=
 =?utf-8?B?Vy9yN2JkQ2tGeS9QL3psdTRRUTV1cDQ5R1VuWDRnbWU1NjlJQ2doN1BCMk9o?=
 =?utf-8?B?VGQ5bVdWbkpsL2Nwdlg3MXdsZ0NKT1B2cU1rTHcrYUVYOWhqZHZleXI4Q2RV?=
 =?utf-8?B?L0ttY1FhbEU3SllBWDl2c21EWTZSdkpvaTRHb0ROajdzd0RYWGZIQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edc204b-2f20-4f86-3a50-08de8adc1104
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 02:04:51.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFUjzEk0/QYxp+X9ViS8t/VPlVWoy80zWGoPutj1PWNSatiMqpJzjhNG7HawS+qHWRV4vRkzknFILNIRys/2dUpekqk5Vc9d8LhNtH8mih8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5441

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyNyAzLzRdIGkyYzogYXN0MjYwMDogQWRkIGNvbnRyb2xs
ZXIgZHJpdmVyIGZvciBBU1QyNjAwDQo+IG5ldyByZWdpc3RlciBzZXQNCj4gDQo+IEhpIFJ5YW4s
DQo+IA0KPiA+ID4gSSB3b3VsZCBzdWdnZXN0IHNlcGFyYXRpbmcgdGhlIHN0cmluZyBwYXJzaW5n
IGZyb20gdGhlICJpcyB0aGUgbW9kZQ0KPiBhdmFpbGFibGUiDQo+ID4gPiBsb2dpYywgbW9yZSBv
biB0aGF0IGJlbG93Lg0KPiA+ID4NCj4gPiBJIHdpbGwgc2VwYXJhdGUgd2l0aCBmb2xsb3dpbmcu
DQo+ID4NCj4gPiBzdGF0aWMgaW50IGFzdDI2MDBfaTJjX3hmZXJfbW9kZV9wYXJzZShjb25zdCBj
aGFyICpidWYsIGVudW0geGZlcl9tb2RlDQo+ID4gKm1vZGUpIHsNCj4gPiDCoMKgwqAgaWYgKHN5
c2ZzX3N0cmVxKGJ1ZiwgImJ5dGUiKSnCoMKgIHsgKm1vZGUgPSBCWVRFX01PREU7IHJldHVybiAw
OyB9DQo+ID4gwqDCoMKgIGlmIChzeXNmc19zdHJlcShidWYsICJidWZmZXIiKSkgeyAqbW9kZSA9
IEJVRkZfTU9ERTsgcmV0dXJuIDA7IH0NCj4gPiDCoMKgwqAgaWYgKHN5c2ZzX3N0cmVxKGJ1Ziwg
ImRtYSIpKcKgwqDCoCB7ICptb2RlID0gRE1BX01PREU7wqAgcmV0dXJuIDA7IH0NCj4gPiDCoMKg
wqAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gfQ0KPiANCj4gT0ssIGJ1dCB3aXRoIGtlcm5lbC1zdHls
ZSBmb3JtYXR0aW5nLg0KWWVzLCB3aWxsIHVwZGF0ZQ0Kc3RhdGljIGludCBhc3QyNjAwX2kyY194
ZmVyX21vZGVfcGFyc2UoY29uc3QgY2hhciAqYnVmLCBlbnVtIHhmZXJfbW9kZSAqbW9kZSkNCnsN
CglpZiAoc3lzZnNfc3RyZXEoYnVmLCAiYnl0ZSIpKSB7DQoJCSptb2RlID0gQllURV9NT0RFOw0K
CQlyZXR1cm4gMDsNCgl9DQoNCglpZiAoc3lzZnNfc3RyZXEoYnVmLCAiYnVmZmVyIikpIHsNCgkJ
Km1vZGUgPSBCVUZGX01PREU7DQoJCXJldHVybiAwOw0KCX0NCg0KCWlmIChzeXNmc19zdHJlcShi
dWYsICJkbWEiKSkgew0KCQkqbW9kZSA9IERNQV9NT0RFOw0KCQlyZXR1cm4gMDsNCgl9DQoNCgly
ZXR1cm4gLUVJTlZBTDsNCn0NCj4gDQo+ID4NCj4gPiBzdGF0aWMgaW50IGFzdDI2MDBfaTJjX3hm
ZXJfbW9kZV9jaGVjayhzdHJ1Y3QgYXN0MjYwMF9pMmNfYnVzDQo+ID4gKmkyY19idXMsDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtDQo+IHhmZXJfbW9kZSBtb2RlKSB7DQo+ID4gwqDCoMKg
IGlmIChtb2RlID09IEJVRkZfTU9ERSAmJiAhaTJjX2J1cy0+YnVmX2Jhc2UpDQo+ID4gwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gwqDCoMKgIGlmIChtb2RlID09IERNQV9NT0RF
ICYmICFpMmNfYnVzLT5kbWFfYXZhaWxhYmxlKQ0KPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAt
RUlOVkFMOw0KPiA+IMKgwqDCoCByZXR1cm4gMDsNCj4gPiB9DQo+ID4NCj4gPiA+ID4gKw0KPiA+
ID4gPiArc3RhdGljIGNvbnN0IGNoYXIgKmFzdDI2MDBfaTJjX3hmZXJfbW9kZV9uYW1lKGVudW0g
eGZlcl9tb2RlDQo+ID4gPiA+ICttb2RlKSB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHN3aXRj
aCAobW9kZSkgew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBjYXNlIEJZVEVfTU9ERToNCj4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAiYnl0ZSI7DQo+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoGNhc2UgRE1BX01PREU6DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gImRtYSI7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2Ug
QlVGRl9NT0RFOg0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBkZWZhdWx0Og0KPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuICJidWZmZXIiOw0KPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqB9DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBzc2l6
ZV90IHhmZXJfbW9kZV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+ID4gPiA+ICtk
ZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpIHsNCj4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgc3RydWN0IGFzdDI2MDBfaTJjX2J1cyAqaTJjX2J1cyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBzeXNmc19lbWl0KGJ1
ZiwgIiVzXG4iLA0KPiA+ID4gPiArYXN0MjYwMF9pMmNfeGZlcl9tb2RlX25hbWUoaTJjX2J1cy0+
bW9kZSkpOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMgc3NpemVfdCB4
ZmVyX21vZGVfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZQ0KPiAqYXR0ciwNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqYnVmLCBzaXpl
X3QNCj4gY291bnQpDQo+ID4gPiB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhc3Qy
NjAwX2kyY19idXMgKmkyY19idXMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgZW51bSB4ZmVyX21vZGUgbW9kZTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
aW50IHJldDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBhc3QyNjAw
X2kyY194ZmVyX21vZGVfcGFyc2UoaTJjX2J1cywgYnVmLCAmbW9kZSk7DQo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoGlmIChyZXQpDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGkyY19sb2Nr
X2J1cygmaTJjX2J1cy0+YWRhcCwgSTJDX0xPQ0tfUk9PVF9BREFQVEVSKTsNCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgYXN0MjYwMF9pMmNfc2V0X3hmZXJfbW9kZShpMmNfYnVzLCBtb2RlKTsNCj4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgaTJjX3VubG9ja19idXMoJmkyY19idXMtPmFkYXAsDQo+IEky
Q19MT0NLX1JPT1RfQURBUFRFUik7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
cmV0dXJuIGNvdW50Ow0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMgREVW
SUNFX0FUVFJfUlcoeGZlcl9tb2RlKTsNCj4gPiA+DQo+ID4gPiBUaGlzIHdpbGwgbmVlZCBzeXNm
cyBBQkkgZG9jdW1lbnRhdGlvbi4NCj4gPg0KPiA+IFNpbmNlIGl0IGlzIGluIHN5c2ZzIC9zeXMv
YnVzL3BsYXRmb3JtL2RyaXZlcnMvaTJjX2FzdDI2MDANCj4gPiBTbyBJIGFkZA0KPiA+IERvY3Vt
ZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLXBsYXRmb3JtLWRyaXZlcnMtaTJjLWFzdDI2
MDANCj4gPiBhbSBJIHJpZ2h0Pw0KPiANCj4gSSB3b3VsZCBzdWdnZXN0IERvY3VtZW50YXRpb24v
QUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWFzdDI2MDAtaTJjDQpUaGFua3MgIH4gd2lsbCB1cGRh
dGUuDQo+IA0KPiA+DQo+ID4gV2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9idXMvcGxh
dGZvcm0vZHJpdmVycy9pMmMtYXN0MjYwMC8uLi4veGZlcl9tb2RlDQo+ID4gRGF0ZTrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgTWFyY2ggMjAyNg0KPiA+IEtlcm5lbFZlcnNpb246wqDCoDYueA0KPiAN
Cj4gS2VybmVsVmVyc2lvbiBpcyBvcHRpb25hbCwgYnV0IGlmIHlvdSBpbmNsdWRlIGl0LCBpdCB3
b3VsZCBiZSA3LnguDQoNCldpbGwgdXBkYXRlIA0KPiANCj4gPiBDb250YWN0OsKgwqDCoMKgwqDC
oMKgwqBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBEZXNjcmlwdGlv
bjoNCj4gDQo+IEtlZXAgdGhlIGZpcnN0IGxpbmUgb2YgdGhlIGRlc2NyaXB0aW9uIG9uIHRoZSBz
YW1lIGxpbmUuDQoNCldpbGwgdXBkYXRlDQo+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgU2hvd3Mgb3Igc2V0cyB0aGUgdHJhbnNmZXIgbW9kZSBmb3IgdGhlIEFTUEVFRA0K
PiBBU1QyNjAwDQo+ID4gSTJDDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
b250cm9sbGVyLiBWYWxpZCB2YWx1ZXMgYXJlOg0KPiA+DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAtICJieXRlIjrCoMKgIFByb2dyYW1tZWQgSS9PLCBvbmUgYnl0ZSBhdCBh
IHRpbWUuDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAtICJidWZmZXIiOiBQ
cm9ncmFtbWVkIEkvTyB1c2luZyB0aGUgaGFyZHdhcmUNCj4gRklGTyBidWZmZXIuDQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAtICJkbWEiOsKgwqDCoCBETUEgdHJhbnNmZXIg
KG9ubHkgYXZhaWxhYmxlIGlmDQo+ID4gYXNwZWVkLGVuYWJsZS1kbWENCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXMgc2V0IGluIHRo
ZSBkZXZpY2UgdHJlZSkuDQo+IA0KPiBEZWNvdXBsZSB0aGlzIGZyb20gdGhlIGRldmljZSB0cmVl
IGNvbmZpZ3VyYXRpb24gbWVjaGFuaXNtOg0KV2lsbCByZW1vdmUuDQo+IA0KPiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAtICJkbWEiOsKgwqDCoCBETUEgdHJhbnNmZXIgKGlmIERN
QSBpcyBhdmFpbGFibGUgZm9yDQo+IHRoaXMNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb250cm9sbGVyKQ0KPiANCj4gPiBpMmNfYnVzLT5idWZfYmFzZSA9IGRldm1fcGxhdGZvcm1f
Z2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDEsDQo+ID4gJnJlcyk7IGlmICghSVNfRVJS
KGkyY19idXMtPmJ1Zl9iYXNlKSkNCj4gPiDCoMKgwqAgaTJjX2J1cy0+YnVmX3NpemUgPSByZXNv
dXJjZV9zaXplKHJlcykgLyAyOyBlbHNlDQo+ID4gwqDCoMKgIGkyY19idXMtPmJ1Zl9iYXNlID0g
TlVMTDsNCj4gDQo+IEkgd291bGQgc3VnZ2VzdCBhIHRlbXBvcmFyeSwgc28gdGhlcmUncyBubyBj
aGFuY2UgdGhhdCBmdXR1cmUgY2hhbmdlcyBjb3VsZA0KPiBzZWUgYW4gRVJSX1BUUiB2YWx1ZSBp
biBpMmNfYnVzLT5idWZfYmFzZToNCj4gDQo+ICAgICBidWZfYmFzZSA9IGRldm1fcGxhdGZvcm1f
Z2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDEsICZyZXMpOw0KPiAgICAgaWYgKCFJU19F
UlIoYnVmX2Jhc2UpKSB7DQo+ICAgICAgICAgaTJjX2J1cy0+YnVmX2Jhc2UgPSBidWZfYmFzZQ0K
PiAgICAgwqDCoMKgIGkyY19idXMtPmJ1Zl9zaXplID0gcmVzb3VyY2Vfc2l6ZShyZXMpIC8gMjsN
Cj4gICAgIH0NCj4gDQo+IGFuZCB5b3UgaGF2ZSBremFsbG9jKCllZCwgc28gbm8gbmVlZCBmb3Ig
dGhlIE5VTEwgaW5pdCBpbiB0aGUgZXJyb3IgcGF0aC4NClRoYW5rcyB3aWxsIHVwZGF0ZS4NCj4g
DQo+IENoZWVycywNCj4gDQo+IA0KPiBKZXJlbXkNCg==
