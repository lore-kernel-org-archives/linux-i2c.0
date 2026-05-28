Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368DE2DF6E9;
	Thu, 28 May 2026 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935818; cv=fail; b=Z/JxAEqeKF3kid8zRtoNDFS0JSxIvQNBe/56Wc7fLdKJ2eaxGkAIusd7WU+HBTX0FzWLuVsoKYJStN5MMqzNLr6hop3Dmpvw2Rb4lPtf88p7Uw5kUUq6GylKYixzcKJAAlG1C4tPFJ1fAfZCq7cdxH+RzZJU0xjG3UFk6sZ4Mdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935818; c=relaxed/simple;
	bh=lcWAH3UHXyZoEL5k7CZkrORUWzLXlDZRb/Kqya16sew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IlSXbExAVJurcq1P1/I/kfqHJ6lVd/TcRm9c/5ImSVIJLH7sonbSLANQ3TzFXHgapbEL2KHxfKAf9DhgQaOs0zPSDG9QZawHCFeaPUaOL3MsltJcp8dHcNjqzYBs/pP8DmGfnT1UwzWLcAIpqmD5gfyvffq9Cb+rEo+PyqR0HgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8JKKh/NqnSzNISGPfifgNL9A5/mCYgZDXNrOhZwCShzBmL+RfX63XZnm2ljkUROS2y648tX40w5mrHtg88X5ThTrkkjcSvvvjXOf61r9E52F0dXAEUr+9wYzd1eUawUikqruSusGQuni4Z3ta8hAHcYs4Y6mAa3TJypZvX8QWbBalEkHreUwGwwXJAPq4Tav5wToG7ruX70v1k7j8bL1zGf1yRosShCOaSsOAtekzBTxfMsGaTnTzeU9w4WzB7boxYHJ5H4SRX0d23n7LpeYaqpoATT4UuL+wIe1DIW4RLVlNci5kVE7Ffw9Pw5HIlo3jgG/TMhC9cYGNlNxmGS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcWAH3UHXyZoEL5k7CZkrORUWzLXlDZRb/Kqya16sew=;
 b=Zz7gnmpmo8gBHpQtzxkXkAvvILZ7CjBF3oiwYb587GbMfV3JTbSC0ngQ3LpO6N8MeNI5XnUB3MWeE2ZiHVcIYkb2aUCoBve/PDxWOGhaQRiXi5SjeEYMwCBKIGIJGA1iIe0juffKClMlsRCSnZir0xfAE+ed37FLOxXyzM6XpXiKF2eYDUuTSJU0wgOJGJXb0+71Kd/L62P5GsS6hMBPtrsBEbkip/QXEKJPpmz8zca29k+CbXQIS/aynmxPgtf3FjeQXHesBLzSUD+S2YSSMkNXco/212Szs4d6va1Uw2ejDrkXLRK4Fi4mLW3dXzWyaJH9meSXhPSOTSrlUXdwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 02:36:48 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 02:36:48 +0000
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
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMi8zXSBpMmM6IGRlc2lnbndhcmU6IEV4cG9y?=
 =?utf-8?B?dCBzeW1ib2xzIGFuZCBhZGQgX193ZWFrIGZvciBTdGFyZml2ZSBJMkMgZHJp?=
 =?utf-8?Q?ver?=
Thread-Topic: [PATCH v2 2/3] i2c: designware: Export symbols and add __weak
 for Starfive I2C driver
Thread-Index: AQHc7bXp6VO2JmCcUEmfYvPfWjRk3LYh2BOAgADhMoA=
Date: Thu, 28 May 2026 02:36:47 +0000
Message-ID:
 <ZQ0PR01MB1269B87604C6DE7FC2E6ACCC82092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <20260527085039.44435-3-lianfeng.ouyang@starfivetech.com>
 <c1ae50ab-1228-45a3-b910-4564774f4198@kernel.org>
In-Reply-To: <c1ae50ab-1228-45a3-b910-4564774f4198@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1048:EE_
x-ms-office365-filtering-correlation-id: 4e796675-1527-4bdb-4019-08debc61f73e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|4143699003|56012099006;
x-microsoft-antispam-message-info:
 m2GsQl/F+n/ccslDOLPdlu3CLO75eou5Lr1ue0n2/anijiWLF4BWkXxcuYrFSDhMlf2x7WhyWNzfIdiIf6oZ76/dL0/NxE/KOLBz6u2u9HkAnqGjRAhxEoEq9/QtGSkp/lLyyDaGIM5sKaWStKGRyn7wR5lNpw4gL4QFFsPRlp4JmAD8/ULe0M7OqVDq95w/fTktr6cvz7FTIUo/2lnUzMTVJyXt83fLCRx/F87uHiah4bQEOv3d/Cf+cXTwUjLJp1LQjXa6gbgbptA/8eyDpOb1cAr6Gqkvts3YQh7TkL9dRuIjSJYo/B2zSzlDWrXu7IQZetbG+sQviWRaH+745JWsW2dtmhITOZu8tZS7SzdtrUea3OnJbWglGUqVOak9x23tbizlzs/yfnjqyKN62Hqz50/8riFywYVjXvxqA4ABz9C8qqQ7L14MvGC5vBlW7XF6+Jz5HAEFd+/FLK/YSdIBfpAPLT04fjcvBzWM80hr0UJBxSx3mX0/OGfTiG9zN9VElmVtbhoAJ9k3SqSmG1Xuwz7nwphb5NE2oo5Bp/RNPbv+TSVI0K453edlgQdY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEpZQXNhdWpQZmdvUkt2YUV1ZnQyQnN0U3B1TFhsRU04aHdHMGtOSWdBTzFr?=
 =?utf-8?B?SFZ4aWdieUxzUXFkWGZ4d21yLzFIdVNVZmg5UGRzaVZ3cG5YOHc3VkpxODd5?=
 =?utf-8?B?VnN5RWFIR1FaNWFJRDJHVDMveGFRMERRaE5tWlhRYXQwLzhHNGZrcGpkcHo5?=
 =?utf-8?B?VlJNTDlndXNONDA4NUliNGRIRmtjTSsyMEtpUHd6Z2Rqc3BkRW0ycC9pbEYv?=
 =?utf-8?B?THNDTjBJUzdFZ0VZNzJNQzFEZ1hyS0tnYnAvN3kxRDgyNjJYNFlJNkNieWRU?=
 =?utf-8?B?TzcwQzdpU2RralhBbTdETEVqd3BsWDVJZng0djhqSnJiWDF2SHN5dVdTWkkz?=
 =?utf-8?B?Zm13WTR3VUQ1bi9lN29qSlo0c2dienlZREZlZngyMmRGOCttVEJHTVNwNFVo?=
 =?utf-8?B?U0tzbFc1eEVIQnhIYVlkUWVaNzRodEcyTTBkL0JRbzEvejJNOTNhbTFPczIr?=
 =?utf-8?B?OUlnWUF3WVRpYVJLUGIrZExRQ0V4ZjY5UktDSExVVGYzdUxPVEQ3dloxZGFr?=
 =?utf-8?B?WnB3bWx3NHRDS1pyd29xSFR1L2s1WGZQUWNTazBVc2JLQ1lZN21rVzFwQUFv?=
 =?utf-8?B?VFh3VThXanJmM0U2OXJOZmhlQWFsOGR3QkdoOWFJQmt4T1ZZY3ZFMVlZaU4r?=
 =?utf-8?B?ZkIxUURZYndlZkNVekMrMkNWaHdKZDlXaVlUKzk0YmJ4ekRXbTBNbk5zK0Ju?=
 =?utf-8?B?ZGcyelBZUHMxTjc4RWJMV2h5akJCVVcyTjh5djZxb21PbnptVktWT1RvT3RC?=
 =?utf-8?B?aVJjSDFoaFZ5ZUJJclNoZHlYbmxQSmZjYUR3MlNTWnpySWp0SXY3WkJESGdZ?=
 =?utf-8?B?Uy9XN25JZWpSZ1JWK2QxTVgyZHRRZmJBdWpjUFN1WE1pcnNTM2ZoRG96NU5z?=
 =?utf-8?B?TSs5b0E1cXBRUmQwTEhqQ2pNcjhZM0JxWnlhbVpmbUh6MmVLNXpBRndEMFhz?=
 =?utf-8?B?blNFRVA5YjZMYXRsOXZwank3b1VwT2FTVUdqUVN1T3BCSEZoMFZlMTlFVTFP?=
 =?utf-8?B?YVRzdFZITzRWSE10eDkvZWV5QVpHSDZodVd5SFlBck9sQndBWHVsUGtrMkFi?=
 =?utf-8?B?ZU5MWDkwZys1QnB4V2ZxR0lEbllOTzdtd1lKR2NNUEl3bW5QU1NNTXpWd0or?=
 =?utf-8?B?NjlvQW94UjBQZUxuSzN6SXlodlZVN0pycjB6TXQ3L2ZVeVZLcmxKSFd2T3l0?=
 =?utf-8?B?c2Q1c0wzMVQySVlGS3FJWHVSbGR3TG1iMVd6ejZCRWxDbk4xQ1AxY2hMWVlx?=
 =?utf-8?B?K2ZWVzdVOXpJakdqdXNyN2tqdjIrZm52RERmREt4R0dHSWJ6eHRtWS9hZWgv?=
 =?utf-8?B?bmlyOGg1L01xRTlRWjBNL2owOVFERWdGVFExdWdZRzFTeWU3MGhyUFN1UEhu?=
 =?utf-8?B?ek1IMEZPQ3dQM3ZTUXpnbWxtUjdUVTEreXhCQ1NSNnVURWNYRlRJcEhQblMv?=
 =?utf-8?B?VGhBbGp5L1lVbExFUnVuY1pZeG5DL0Mxc2RkZlQ3WDlXWEM4STdwYnFva1dB?=
 =?utf-8?B?Tlk3RVhvdEI2aW02VEJmeWprbXQyQzNoOUppTDltNy83b0ZYOHVBTURlNEwz?=
 =?utf-8?B?RkpvOTJWOTZqV0Zxc3lQeGRkU20yZGZZUjdMbkJpcFNneXBpWTFXUHQ4Wk5I?=
 =?utf-8?B?ajZxRHhBMlJVUG1nelFBcFcyWkJ2RnM0b25nMjVxcWx0MC9sb0JsNmVlRDQ2?=
 =?utf-8?B?Q2JwdW00eWVCVENTVkZObU1SZkF2QUw1VUJHZy9zczJEN3VxSEo1OGc0Vk15?=
 =?utf-8?B?cGt1REo5MUZPQTFqSTF0Uml1M1pxS3UxcnJOS1FNRmFVQ01oQjA1L0NnUFZP?=
 =?utf-8?B?TkNMcFFta2U5VUJjaVRQOTZTRTY4dEFhaE5sWS9NWHlBMW05QmxGcWd0SEIy?=
 =?utf-8?B?UTNmOGFIR0xLZUpneWk3NGVvQ2xJTERrNUNEeXVZNHNqSW5seEFNMTBNK2NI?=
 =?utf-8?B?VWkvOVlNdVZhUjR5OFNLK0NTV3NGQ0U2ejlTd2dRQlFDckc5ZDhIdGJBOUpE?=
 =?utf-8?B?S2pCYmcrRys5UlpMaDZWRzZJUnpWZDIyOUt0d3ZQYzhPekJ0WU1wU21rUlhV?=
 =?utf-8?B?L2FCVVpJVUpKVFVWK3lXSU5uT3BqMDRYTytlZ3dLeERsWVZEQ3BsTWdhZ3RR?=
 =?utf-8?B?RkVKYXlSWDBpVWVrUDJkcmdsdVdncW9EcXovaDdXb1FOdUZkUmljNUdmdU9L?=
 =?utf-8?B?L2h3Z2ZpYXlucHorNXh5Q3FnWHRaaG93ZHVNSDFiN0VQR3dkQzFEeXg5RnM2?=
 =?utf-8?B?WThkNDBNd0RXNWdQcDBER2RUbFhSSTRjMjdOOG5ndUVySDlLTlBZNFBBQmsw?=
 =?utf-8?B?VjFSRlhqeVZtWHhFWEhaZUxRQTJ3bTR3cElhTG1TUjlzaGM5UzNkc3RoVlhK?=
 =?utf-8?Q?KmrNawFKZKQ2mlJ8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e796675-1527-4bdb-4019-08debc61f73e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 02:36:47.8250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoKBkE+CoYAdBQdOw2jRX+v9Aosk/unCPuCX9Lyi38PlMXbIIZd9emo+a+S+aWaBOyukAmsqt4ZcnBn6Mcwcd2rJ4hfYGJx0vlH7t6yF4OTND1cHKFnRVTS/MaKnDGoU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1048

DQpIaSwgS3J6eXN6dG9mDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS3pgq7ku7bl
jp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVs
Lm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0NeaciDI35pelIDIxOjA3DQo+IOaUtuS7tuS6
ujogTGlhbmZlbmcgT3V5YW5nIDxsaWFuZmVuZy5vdXlhbmdAc3RhcmZpdmV0ZWNoLmNvbT47IEFu
ZGkgU2h5dGkNCj4gPGFuZGkuc2h5dGlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtlcm5lbC5vcmc+OyBD
b25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBNaWthDQo+IFdlc3RlcmJlcmcgPG1p
a2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHJp
eS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4g5oqE6YCBOiBsaW51eC1pMmNAdmdlci5r
ZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjIgMi8zXSBpMmM6IGRlc2lnbndh
cmU6IEV4cG9ydCBzeW1ib2xzIGFuZCBhZGQgX193ZWFrIGZvcg0KPiBTdGFyZml2ZSBJMkMgZHJp
dmVyDQo+IA0KPiBPbiAyNy8wNS8yMDI2IDEwOjUwLCBsaWFuZmVuZy5vdXlhbmcgd3JvdGU6DQo+
ID4gIAlkZXYtPmRldiA9IGRldmljZTsNCj4gPiAgCWRldi0+aXJxID0gaXJxOw0KPiA+ICAJZGV2
LT5mbGFncyA9IGZsYWdzOw0KPiA+IEBAIC0yNTUsNiArMjU5LDggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgZHdfaTJjX29mX21hdGNoW10gPQ0KPiB7DQo+ID4gIAl7IC5jb21w
YXRpYmxlID0gIm1vYmlsZXllLGV5ZXE2bHBsdXMtaTJjIiB9LA0KPiA+ICAJeyAuY29tcGF0aWJs
ZSA9ICJtc2NjLG9jZWxvdC1pMmMiIH0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0gInNucHMsZGVz
aWdud2FyZS1pMmMiIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gInN0YXJmaXZlLGpoYjEwMC1p
MmMtbWFzdGVyIiB9LA0KPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJzdGFyZml2ZSxqaGIxMDAtaTJj
LXNsYXZlIiB9LA0KPiANCj4gU28gYm90aCBkZXZpY2VzIGFyZSB0aGUgc2FtZS4uLiBPciB5b3Ug
bWlzcyBwcm9wZXIgZW50cnkgaW4gSUQgdGFibGUuDQo+IERvbid0IHNwcmlua2xlIGNvbXBhdGli
bGVzIGFyb3VuZCB0aGUgY29kZSAtIElEIHRhYmxlIG1hdGNoIGRhdGEgaXMgZm9yDQo+IHZhcmlh
bnQgY3VzdG9taXphdGlvbi4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCk9r
LCBNYXN0ZXIgYW5kIHNsYXZlIGhhdmUgZGlmZmVyZW50IGJhc2UgYWRkcmVzc2VzIGFuZCBpbnRl
cnJ1cHQgbnVtYmVycywgYnV0IA0KdGhlIHJlZ2lzdGVyIGxheW91dCBpcyB0aGUgc2FtZSwgc28g
aW4gdGhlIG5leHQgdmVyc2lvbiwgSSB3aWxsIG9ubHkgdXNlIHRoZSBzYW1lIA0KY29tcGF0aWJs
ZSDigJ1zdGFyZml2ZSwgamhiMTAwLWkyY+KAnCwgYW5kIHRoZW4gYWRkIHN0YXJmaXZlLCBpMmMt
c2xhdmUgdG8gdGhlIGR0cyBub2RlIA0Kb2YgdGhlIHNsYXZlIHRvIGRpc3Rpbmd1aXNoIHRoZW0N
Cg0KQmVzdCBSZWdhcmRzLA0KTGlhbmZlbmcgT3V5YW5nDQoNCg==
