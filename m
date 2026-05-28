Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2117.outbound.protection.partner.outlook.cn [139.219.146.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1C3254A2;
	Thu, 28 May 2026 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956949; cv=fail; b=s/orFW24Dl59jpvsh5KVhVB38IS8WKX3zythZ/xg7x420tjVS17lzhRxUzx+71pFHzPctuvAwxCZA7IjoFLe8waHkTkCZ9n4VQnEpP3uNrpgShtHCaAyv+vfWp+M1TM+7+VS9sIswj2SDc0pUYfP+h7krM7frdwFo1Q+Pf1caSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956949; c=relaxed/simple;
	bh=uk5Yh0avL1sXc1lUsg7yhi3mrl/3PIrPG9IWu6+gHyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ir2nf9n7J0zPvQ3tjhQTrsWFQ/w8pNhlDwSDLq7Gv/h8AB1hXGdGt2H9FLxwcP9g6HOp4HwLbAqyfy60B4EJKkBOPNVku+0u10+8o3Bf4FJbwkrMoaYCahyLARtT338BEz4knNGvdlbPefeN3vp3cecqgYeyKmtIjxdWsoWRcpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyHWwZs4Uos16r+mJaXJOhNbY4GofkTHgFoXHvUmdXJBr3A3Af1LxVvYPvMbPjF0ckJWMKXLa8HOI9xqe/Ng/1vtKlVmWRBcKWBQSaqPZ3bOP0/laB1IDGej4twtGUbCD5655t4cEXSGoES9xZ/kzECO9VEGPh2FSKnr1msQbv+6ij2CCKf388Z2u4gVIwP4jCeRnjS67kOr0iqGZaig3+muOvtqBnBgj663MIyNMh2iFfp52XWGgM+tsEdIVr/wGjM6AQjLJlEmg79qN0pSIbOOLSzr7XuYY8v3CSnuYLHvLBpNLDz6d5UNeCDLLLJNEA3T8CY7uK4lwW0SCo9c3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk5Yh0avL1sXc1lUsg7yhi3mrl/3PIrPG9IWu6+gHyE=;
 b=d2Gc3CcUsri6uklAKE0rqQaWWNmIFWYHuqhtqiJ7TYxMtPM/Uo3tZOmGUEUn55G54NmbFx1FPpZSAUqzEIfYJ846UG+aZQj+yZsuA9Vdtx1irdwj2K812wTtYyy2fH8Rsx3bXFuZgu//+L94/o44pXkhD0swLXd0j8AOzDpwPV/FNdRx+4G4vFCKXSPqUk10fXKiBOneIizsVrM7ju1CaChMG6RTi2f02D1J+yehbmYVHuK1HYJtFMtU07BnZLhJ7yXhjon+L35a7P4KoiHab2wBmAbIJD+RSAjShksPLX/LkffhYIF7omverNiho+QLFt312scj+czkbyp5CazP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1270.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 08:28:53 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:28:52 +0000
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
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MiAyLzNdIGkyYzogZGVzaWdud2Fy?=
 =?utf-8?B?ZTogRXhwb3J0IHN5bWJvbHMgYW5kIGFkZCBfX3dlYWsgZm9yIFN0YXJmaXZl?=
 =?utf-8?Q?_I2C_driver?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMi8zXSBpMmM6IGRlc2lnbndhcmU6IEV4cG9y?=
 =?utf-8?B?dCBzeW1ib2xzIGFuZCBhZGQgX193ZWFrIGZvciBTdGFyZml2ZSBJMkMgZHJp?=
 =?utf-8?Q?ver?=
Thread-Index: AQHc7bXp6VO2JmCcUEmfYvPfWjRk3LYh2BOAgADhMoCAAFd8gIAACjQA
Date: Thu, 28 May 2026 08:28:52 +0000
Message-ID:
 <ZQ0PR01MB1269926D984F86CB9B87E3F182092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <20260527085039.44435-3-lianfeng.ouyang@starfivetech.com>
 <c1ae50ab-1228-45a3-b910-4564774f4198@kernel.org>
 <ZQ0PR01MB1269B87604C6DE7FC2E6ACCC82092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
 <d138759d-ec07-4d94-bbce-d34d5bd4fe61@kernel.org>
In-Reply-To: <d138759d-ec07-4d94-bbce-d34d5bd4fe61@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1270:EE_
x-ms-office365-filtering-correlation-id: f1897f00-0e92-48b2-7603-08debc9326b8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|4143699003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 Yc0O5Rxqpo7xov9xyuJYfor7PyaMEC+ZzUwIthVhb3zGuktvt28NOFpxzf080+rBgeTKADy0sbtlfPPcw6WEpsnMR4Q39vjBsiEKbD2ahKxgsg/5LuI3tSA9PDBkUemyiKjsY1qSj1Vgsbq6UH/NtegvOz2oT48W3YJstXHBnKydxbcW4iiizj0c0kNNKaMSV81THldVR0Qzkiq1oTkeKOm8vGOwDJRTMzKIyLi3aoOW36DR21lPLqUQl0cA3/wDojL0mjjw7q9+FMwPaA4M+IIiObWgsowMiJ8d5Vof9WCMyHshz5k7Qhp6fI+OMgns615EeiX9J+MOytM6HHSq5IOU6eayZ+7zdvjAYsDKbuyTT4BC7nnTFg1momZb3n9/YhVCLjNjgDuOW7M5qTjYpzj1Y/VhMeS4BJ1EvgQ7B/YW5Hgx/ImrZ8EASopjO0anoykzx2bPPKFCzjtX4ZK6IwhVHR+v+i8LmHpoT04IIpFAh6zsmModuxqkIeBjszsgrisxXri5fW+J5okOsZLuK4D9iJPDX9vPHJ5h68pdw5bl9nDq/YSG4jIMuW8e0I1l
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uk5LaUc2WStXdUlqYlBuRDJRVmEvZml4WGk1cFIzRGsvaFZic2svSzFYaS9K?=
 =?utf-8?B?WUlBMGV5Vzl4TXlUdUdSakJ3ajhQMnhpTXQrWmdIMTlLbFlhSzFGQUpEWklq?=
 =?utf-8?B?bjhXdURJall2WmFJeTJGa2dRSFRwNGN1bEpLd1hkTEZ4Z2tSaGl0YXE0a3Fn?=
 =?utf-8?B?U1V5a2FEMjh2Mzg5UzhSaFc1M2RLY1N1YkpqSGZRTUx6N3pLRVBTRWNXa21K?=
 =?utf-8?B?Mnp6bkVsL3dUL1EvUHgybFlzN0Zyd1pCTW0ya3N0Snh5N0JsSWVzTU1ZT1RE?=
 =?utf-8?B?NU9LTHFLbkFkK0xIbnpockxRM2NDZkJrRGJiNEo3SHFjQzFLdTUxaDczeTR3?=
 =?utf-8?B?UjhhM1o0dFdsOFg5bDV3STVOUUY1YVMvSWNPQ2hCVTNTYmV5eDFZdS9iODRi?=
 =?utf-8?B?VG02dVpTbHZPU0wwSHdscC9oNS9TZXJJcUxudnRFWG1XWHlEblZ6aDFaZnh4?=
 =?utf-8?B?cnNUZmlMdGZLTHJ6bVhIOXhaZVlKY1daTjQ2Tkx2ejBERmc4T1J4bmRSb3Vr?=
 =?utf-8?B?Z1lOWE9lUVE1S2ZQT0JFZ3NFU0dlZk5xenpNczRUZW8vc051R0grdEdsL0FV?=
 =?utf-8?B?Z1RXdnRVSnE4RFVybXB3UG5PbkZSTXBVZnkwNERFT1lRUUJjbkljaXdnSHUw?=
 =?utf-8?B?eldHeHZmYU5uVzUxY1o3MzJtRjhUUXhnWlM1TFFUZUh0Q0E5OTRWZ3VoM3B4?=
 =?utf-8?B?bTBVMEZPR280NVk2L0FremZvamFjVy9DMkFVWS8wem9TTzZaOS8zWjUranRQ?=
 =?utf-8?B?ZHN2M0NHdUltOFVwY3owT3dRZGZHUTJSQVA1bjVkNDVtL2d1RnIyNit5RHYr?=
 =?utf-8?B?aFRyc1JxUkx3S25WWEJwZGo5KzVrdzl4UGZtdEJaM0RNTThYTDlNWTQyaVUv?=
 =?utf-8?B?SHM5SWt5dkg1dE9MWGx0RjRLZnZDL0JBWWpQRWgvbUVpQVpqek1SWXo2d0F5?=
 =?utf-8?B?Mjh3aHNpcjFSeE1kaVphR2RkWVBzcW5uY3lwY1haSGE3SWcxMjJ3VHhTY0tL?=
 =?utf-8?B?Tzk5STJIL29pejEzVGhmdzJjRmN1STVBcWdHc0lZYmtuV2FqREdrQ0duMThR?=
 =?utf-8?B?b0RHS0hUZEw5WHVyMDR6K25VU0ZZRlNJWmRQc1dRK001Y2w2ZFhuYkl4RlV6?=
 =?utf-8?B?bzVmd3RicnJCZjZEZldoZTloWkJMQ1Z3N3ZWMHdmYmpTL2RDU1VhcnhBd2w1?=
 =?utf-8?B?c29WT2F0bjlmb1FlYlZiYjg3Unkrbms3Szg3K3RtUWZsY08xZFdRbW9ETnoy?=
 =?utf-8?B?WkxJT0ZxZUwrTmJGTERMVUFvaXZUQTk3QjFTbnhJSGtqNFpndFVheWR0VjRQ?=
 =?utf-8?B?dWtBYU4zeGZOTGhkY21XRHlQWUdXK3BYbWN2NzBBU0N4eUpnUTREVTlCUit2?=
 =?utf-8?B?aU9NdCsvODNlaDY4QlR2VzVod0RkN2U4YlQ3czVsSEhrc2tYb2wvYVVlNUhl?=
 =?utf-8?B?MUR0MzNzVkNPRGltR1RMU252ekU3ZzZKdERyMFNucTZrTE9vblI3S2Q1cmVy?=
 =?utf-8?B?eVZ3SGRYSFp3WlI0VDB3L1JDM1ZBTGd5bFg0cDZoQTBFSVd6bitUV2lVYlZ2?=
 =?utf-8?B?MEF2OXFyTCtCbUVFU0hORXB3dGdYRTZCb29KdTJqTlRwdGNwUHpGZk1Ka1lo?=
 =?utf-8?B?ZXhEL0QycmNsUTJDM3NkdVRUVGpsN2lrRWkrSi80OUJTVlVpdDhrQWpyYmcx?=
 =?utf-8?B?RjFoMk82Y3NONHAyTThkYTVRcXBIVjd1UXh3N2NoWU5TUGNyUURXSTBDME9J?=
 =?utf-8?B?UEJCYUNkRXZqbFp1eEVmRjlFUUFTdXFPaUQxWHRLWW8yYUtpYzFRNkE5amZE?=
 =?utf-8?B?d294bTNJcGJEVjZZYUZ1Y1lDcldNcHlPdko0QnhPaTdvaUx5YkFQOGhtNHhM?=
 =?utf-8?B?cmJKaVhnOEFNRHNwN3E3dkVkOVcxa1YxTHZxQUZDcjk0SUNmTHIvYUdJaTJP?=
 =?utf-8?B?ZXZWS0x1YmJLVjRBb3AvZG9MZVY3QVcxUVRuMEJCMHljZDZHc0g0ejRMRjdz?=
 =?utf-8?B?d0xYTzhuUTR6M3dhZjUxU1JzRTQrZk9hak52aElKcUFERVZORTNWclNybUp6?=
 =?utf-8?B?QUFLUW1OOVhOMnJKdnhXdFcrRHZZZzdzQU1hT0w2MTNDekZGY1A4WGRpc05k?=
 =?utf-8?B?NkVTWEdDWnRTS2t3aXZwZTMwTHd2M2xUdkt1YmdnVVkwN2p6TjBUcFcyRU9i?=
 =?utf-8?B?NTFFQ3JILzhNQUlIYWF3dHp6OW53RFpwbmFiYk9OZWZTMEtPd2NEKzU0TWth?=
 =?utf-8?B?aTIvMUVMRmcvTkQ4UWJXTWtGZXJ3KzYwNWpyTjl4NXlnejIyR25CNkw0YlNB?=
 =?utf-8?B?engxRGhnSll0VUZ0ZndOeVZWRjN6Tm1ESncxMURPZEphSGtJVEg0OUt3WWJx?=
 =?utf-8?Q?8bI2V7G15zxqspsw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f1897f00-0e92-48b2-7603-08debc9326b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 08:28:52.8896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2BbUsTxQ0AYdiw/0UxNMAtQKWyiKHgutphbTfSt0wmm7pxXLanwD1F2zCQVOBMCkjMkgpk2YDDqvKebwanP+hERNq/qi0BIcinTDkDlZsgItL2BRcSBlU66NUwNZQcK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1270

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0NeaciDI45pel
IDE1OjQ2DQo+IOaUtuS7tuS6ujogTGlhbmZlbmcgT3V5YW5nIDxsaWFuZmVuZy5vdXlhbmdAc3Rh
cmZpdmV0ZWNoLmNvbT47IEFuZGkgU2h5dGkNCj4gPGFuZGkuc2h5dGlAa2VybmVsLm9yZz47IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnpr
K2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBNaWth
DQo+IFdlc3RlcmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+OyBBbmR5IFNo
ZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4g5oqE6YCB
OiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiDlm57lpI06IFtQ
QVRDSCB2MiAyLzNdIGkyYzogZGVzaWdud2FyZTogRXhwb3J0IHN5bWJvbHMgYW5kIGFkZA0KPiBf
X3dlYWsgZm9yIFN0YXJmaXZlIEkyQyBkcml2ZXINCj4gDQo+IE9uIDI4LzA1LzIwMjYgMDQ6MzYs
IExpYW5mZW5nIE91eWFuZyB3cm90ZToNCj4gPj4+ICAJeyAuY29tcGF0aWJsZSA9ICJtb2JpbGV5
ZSxleWVxNmxwbHVzLWkyYyIgfSwNCj4gPj4+ICAJeyAuY29tcGF0aWJsZSA9ICJtc2NjLG9jZWxv
dC1pMmMiIH0sDQo+ID4+PiAgCXsgLmNvbXBhdGlibGUgPSAic25wcyxkZXNpZ253YXJlLWkyYyIg
fSwNCj4gPj4+ICsJeyAuY29tcGF0aWJsZSA9ICJzdGFyZml2ZSxqaGIxMDAtaTJjLW1hc3RlciIg
fSwNCj4gPj4+ICsJeyAuY29tcGF0aWJsZSA9ICJzdGFyZml2ZSxqaGIxMDAtaTJjLXNsYXZlIiB9
LA0KPiA+Pg0KPiA+PiBTbyBib3RoIGRldmljZXMgYXJlIHRoZSBzYW1lLi4uIE9yIHlvdSBtaXNz
IHByb3BlciBlbnRyeSBpbiBJRCB0YWJsZS4NCj4gPj4gRG9uJ3Qgc3ByaW5rbGUgY29tcGF0aWJs
ZXMgYXJvdW5kIHRoZSBjb2RlIC0gSUQgdGFibGUgbWF0Y2ggZGF0YSBpcyBmb3INCj4gPj4gdmFy
aWFudCBjdXN0b21pemF0aW9uLg0KPiA+Pg0KPiA+PiBCZXN0IHJlZ2FyZHMsDQo+ID4+IEtyenlz
enRvZg0KPiA+DQo+ID4gT2ssIE1hc3RlciBhbmQgc2xhdmUgaGF2ZSBkaWZmZXJlbnQgYmFzZSBh
ZGRyZXNzZXMgYW5kIGludGVycnVwdCBudW1iZXJzLCBidXQNCj4gPiB0aGUgcmVnaXN0ZXIgbGF5
b3V0IGlzIHRoZSBzYW1lLCBzbyBpbiB0aGUgbmV4dCB2ZXJzaW9uLCBJIHdpbGwgb25seSB1c2Ug
dGhlIHNhbWUNCj4gPiBjb21wYXRpYmxlIOKAnXN0YXJmaXZlLCBqaGIxMDAtaTJj4oCcLCBhbmQg
dGhlbiBhZGQgc3RhcmZpdmUsIGkyYy1zbGF2ZSB0byB0aGUgZHRzDQo+IG5vZGUNCj4gPiBvZiB0
aGUgc2xhdmUgdG8gZGlzdGluZ3Vpc2ggdGhlbQ0KPiANCj4gWW91IGRvIG5vdCBuZWVkIHRvIGRp
c3Rpbmd1aXNoIHNhbWUgZGV2aWNlcyB1c3VhbGx5LCBidXQgSSBzdGlsbCBkbyBub3QNCj4gdW5k
ZXJzdGFuZCB3aHkgZG8geW91IG5lZWQgYWxsIHRoZXNlIGRpZmZlcmVudCBjb21wYXRpYmxlcyBh
bmQgeW91cg0KPiBjb21taXQgbXNncyBvciBiaW5kaW5nIHRleHQgZG8gbm90IGhlbHAsIHNvIEkg
ZG9uJ3Qga25vdyB3aGF0IHRvIGFkdmlzZS4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KDQpUaGUgSVAgY29ycmVzcG9uZGluZyB0byB0aGUgaTJjIGRyaXZlciBzdWJtaXR0
ZWQgdGhpcyB0aW1lIGlzIHF1aXRlIHVuaXF1ZSwgDQpzbyBpdCBzaG91bGQgYmUgZGlzdGluZ3Vp
c2hlZC4gVGhlIG1hc3Rlci1zbGF2ZSBvZiBpMmMgZGVzaWdud2FyZSBhcmUgYXQgdGhlDQpzYW1l
IGJhc2UgYWRkcmVzcyBhbmQgc3dpdGNoIGFjY29yZGluZyB0byB0aGUgc2NlbmUsIHNvIG9ubHkg
b25lIGlzIGluaXRpYWxpemVkDQppbiBwcm9iZSgpLiBCdXQgaTJjIHN0YXJmaXZlIGhhcyBtYXN0
ZXItc2xhdmUgYXQgZGlmZmVyZW50IGJhc2UgYWRkcmVzc2VzLA0KYW5kIGl0IGNhbiB3b3JrIHNp
bXVsdGFuZW91c2x5LiBUaGVyZWZvcmUsIGJvdGggcm9sZXMgbmVlZCB0byBiZSBpbml0aWFsaXpl
ZCBpbiANCnRoZWlyIHJlc3BlY3RpdmUgcHJvYmVzLiBJZiB3ZSBkb24ndCBkaXN0aW5ndWlzaCwg
d2UgZG9uJ3Qga25vdyBpZiB0aGlzIHByb2JlIGlzIA0KaW5pdGlhbGl6aW5nIHRoZSBtYXN0ZXIg
b3IgdGhlIHNsYXZlDQoNCkJlc3QgUmVnYXJkcywNCkxpYW5mZW5nIE91eWFuZw0KDQoNCg==
