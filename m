Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2095.outbound.protection.partner.outlook.cn [139.219.146.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868C399CE6;
	Wed,  3 Jun 2026 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470345; cv=fail; b=jgk6zKQZpyAx9vhLndWn3A+2O/5kJCrOASBtvpvZkI6bh4UME37DlVXl4C9fMz7tLIKmWk9rlr/F6RD2csj/+WpNSW89EvSRKOt/+okDkzZc6Pxz+TDxhS6XQ50YpXlQWmH0QqXLOGCyWu6surZobszvVrPeY0+EZtyF+NAeg/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470345; c=relaxed/simple;
	bh=h/v85K9cbz/4EYbnA2gT8oHMlQxI3Df3iVBYX48SEQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aqmC9tS1u1o20YP58AD6laK7dz0d2xTnAhQO/2uPCjsnVOtH/TS+SSxzOkkKvtAjGJSR0xtBhQEfkwFPlufA7XsOi8aDbdmMFigMBxtA7t3JJ7Rm0izMJLLgg7RitdzrcBxGVmooHXn2qxvE/eh2Z3MOrSJ9SbdDEcCnZg2Xwqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqFqnSwLASkjxwW1KjXqsRJhmfkfu3M2w7w2J5Ajz1ZhLaIMfrXAWHVtMBrCzw/+u1vR8SX7IEdS0oyt5tvOuONj8KdWX/Y7JES3a0za0z1ssdgyWZ5xvOMflyHakk0eDBh2lJzOQC/uOwzVnASvhG55ELyjhsm/LEYH94PE1bjEEIVtkgW+CLq3WS80Rp7r3oi0eGb6Y5pYavkE4xA3MHMFngTdoqbKBUIhAuTMyODVVKjCeJ74dPcd34rmOUho7+iUPE2dOPkFKvoXXLWC1/MA0pa5Z7da0wQQ6vMptxO3LG6FaymbcO11RuVVNUsKEvC5mGUQ0oKYKKGZZxrVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/v85K9cbz/4EYbnA2gT8oHMlQxI3Df3iVBYX48SEQk=;
 b=hblv9NP6efiJH3G4FFGN74+PXTvxt7loNmXtYm31Igi/2nMikGyVM94tQay1OZaEviF5Xsu9Cvo9zyiOo1dWcditnW+cYT/1y0PQ9kLwAsuXTZfsSbQWA4Ez7j0Bqv/wQh/QAi7qxTNBhZyHDugYTmTPgtfDLTOs8kzOfyy8HOVgmPUFu55EPLUi1mGLWBvSeAvzS7J3JTaVIcRtXz0+uNloefvsWNjBqXY6hOp8RGlaTGMfVoVpqQjxPOYmpI6jeCofRy7c37kStenlQICgmErTVVkUiBmEemeALkYtYzR/PuHSbUT7yTEENO3spDELInI7D75XVuwPVzzEp5GfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 05:31:38 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 05:31:38 +0000
From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYyIDAvM10gaTJjOiBBZGQgU3RhcmZpdmUgSkhCMTAw?=
 =?gb2312?Q?_I2C_master/slave_support?=
Thread-Topic: [PATCH v2 0/3] i2c: Add Starfive JHB100 I2C master/slave support
Thread-Index: AQHc7bXo+kP9ks3Lj0ixZJAu4nf4cLYr4mgAgAB2cQA=
Date: Wed, 3 Jun 2026 05:31:38 +0000
Message-ID:
 <ZQ0PR01MB12690FA279708FD6A6DB063282132@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <ah9Yrt_gO8uGaPw_@ashevche-desk.local>
In-Reply-To: <ah9Yrt_gO8uGaPw_@ashevche-desk.local>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1176:EE_
x-ms-office365-filtering-correlation-id: 2fe31706-9b30-45b6-07b3-08dec13162b6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|6133799003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 1GKT4CVUaOr3g3uYcnmmZ7KndPyoSysWHn38KXNdkGyLawwL9w+W2DNQjtPYtlc0FstSBmbdAo+CZXUxo2gSBAwm/vAU2cSnTMPac0h1XZgGy5ySuQ5LcZcg8yydU+vQNfnV20+fF3rNlwyl3pyoiIjPUa+ZPbU2cl+r5ibD/xr6hN/2T4xOA2XZLNRC+i/jerjJO9vHi1Ycb/fq5xW1HTrvDsaKlGlmKAgi7tgsi/ZRtUwlf1WaeNxm23xBXgV8PxCq+8saJrfJfX3k6w6hFGeb6gYI41O33vrDJSuGcBrVnCdlyk0QIWFVvzcbT7H59l6v0zXX9UhJnnVqWeqyTQZOXWmjuY5KIF2uHcClER/+D7a8/v1ZvRbacBppWZU79orfnNMyi6Nh36nVWoYYfWIl/n+YvZD5BtbqGYQaaa7cZEAA99povWOFvdHahgMNdjAOwktsW5mucUCO7mdT5MVuPcyp50bia8gNVmXkANPOm4uNKDDS3UmQ0gCRiqRotjsB6sel3YNpTePVpNY9Ya+CXV66NeEjlNe1jvJYtgVf56nrzqrAMiVK27EL93Lm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eFRmT0NzSENqSFVBRTJCcnFDNGFDdUdLK2lGU21lWS9wRm5ZR1hBMnMzZFhI?=
 =?gb2312?B?RmNreDVOYjNDSUJRYWdFcllDTVNZTTJoM2FKVG9tWmNNVU9jbWo5TVZQSDBl?=
 =?gb2312?B?bWZUMzRNQnJ3M3R0d3o5c1p1L0g5Zk5vWDZOSmd2d2JEeVZaeWhwTFJIZDhj?=
 =?gb2312?B?dUsySy80dXZMbG1OVkRZeXdZcFM2S2lhbmNqSHg4WWtVemdZelo5dEhiQmFu?=
 =?gb2312?B?dS9WZ0lYSnVvVGt5T1lSeml6QzRHcWczVGVQNlQ5L0RZVjJaMWRxQ1MvejdT?=
 =?gb2312?B?NWtjaGJ1ZFJtbnpoMXhiOFRVeCttQjlob2VxdjBaY1pnSy9uS0p5WXZRWjNm?=
 =?gb2312?B?TmVMa2Y0ZTMrT3c5SFMvbkJFbVgyMWlIa3JwM0tycUZaQWpIclVpMDRxTERs?=
 =?gb2312?B?eXZwZ1JVWTJOeWNsVFNpaU9qRXNiL0p1bHFqVzRTMXFUbnQ4Q3hLNEtCcFBW?=
 =?gb2312?B?eHpjQTBGcUZGRWpYZ0V3VXlxT0RndnZHLzN6L21Ici9MSWtHVE4wNHhSOWlr?=
 =?gb2312?B?Qis2QUVqSE1DbDFqd3ZzNDBMWnNrUFhDRHNwbGJYUXBDa3l5WTdXUjNTOHRk?=
 =?gb2312?B?aFhhNVJ5dzBsR3Erc1JIOHhBcG5MbFJ4b2ZXbjVEYkpnYVFkY1pMNU1zMEhz?=
 =?gb2312?B?ZGx6V1RNalBDa1dqYjUzUTRyMnJra1hmYitUNklHanVpeE92Qkh4NGpadHBM?=
 =?gb2312?B?OGRtdm1KdDFTZ0lRVGF0QzIxeS9lMjU3a0ErOTZHbWhnRkdaRlpBczlNblA1?=
 =?gb2312?B?UTg4Nm0ydEJ2bllqMExrL0t2L3RqUW9KQ3NvWElZODNBc3pqc1F5M0VvWHE4?=
 =?gb2312?B?djdIcStRcjNSZTg5RGx0ajFtdEJYYlBKWE42bGR5UjhVTVUxWEtCSWdqcXVt?=
 =?gb2312?B?ek9ZUlJURTlaZENkajhscVhnazhpakZadlhHMUZoNUpnVG5DYldmVVJ1ZDV1?=
 =?gb2312?B?elZvam5HbWhlcmFUYnR1V0paQTVVSHVENm5zYktrRTFZdGlVaTRUcDdVd3RB?=
 =?gb2312?B?akFSL214QUJrRDVMUW5hL1hMa29jakVzejlzblNPbndxVFBESzJ4YXJnY0h5?=
 =?gb2312?B?REwwNVZuVmVaeTFPMndtSUFVQTZkM2xjdzZKUG1hemVHK1VULzJiZjJmZDVy?=
 =?gb2312?B?YmM4aW83SFlSWjZCZVBIbmJtOVEvNGljd21LeWxjUDVqazdaSnJDTVpXSUFZ?=
 =?gb2312?B?QkpwRmNaMVpPRzI4enpHRlArMjVWU2lEUnNuUDZ6ZzNRVW5MUnBieXBLQzly?=
 =?gb2312?B?eS9vTC9jdnpSTzBzd1BWV3FHTXRYWEV0bitUSnJ1WGZXWHVRd28yQkY5VSt4?=
 =?gb2312?B?RStGSFdNNGhvSVJFUytNSHZXR09BRVVzc2RkOHRjWG03SHV0ZWNrUTJzMmRi?=
 =?gb2312?B?QlVnZTZHaXc5RFdkbzloRGdXMnRTcUk1bUI2bXVDbk9wM241RE5CMFZseExk?=
 =?gb2312?B?N0szNUY4V1F4YnovMXRNd2dDMVNYNGQyY3pPUTZkbVprbGc1RnR6bUdubWYw?=
 =?gb2312?B?WWJ6Y2wzNTdYOGJ2RkcyQXhDQmdYZEwxV1lXVWkxYm5YdFlUYUYzbGFuc0VX?=
 =?gb2312?B?cndTa2l2eDBnTzRucHNRZHE2SG5welZPVGNLWHRUcTQ4a3VpSXJZRXJYNUhY?=
 =?gb2312?B?YjFPWmNWMFZaV2pNTENXQ1Fjcjd2djJSMWN1a295OVc3eUV0L1Y0a2lXUThx?=
 =?gb2312?B?Q1NuUkdUU3pHQXprOEsrRTFRTjh0MHpwZEk3ZExVajdpT2dIa0lWaVVTTVNl?=
 =?gb2312?B?ZGIrRk42ay9XZGYwZ0VVWnBpQ1d5UU94V3drUkxvTHRLeWxPajVBUlIweWlB?=
 =?gb2312?B?SHY3ZUlMZzI5bkQ3Vk0vY1NxTVJFYnFsdWRSd3VYV1daSUJzNWtoSnAyT0RG?=
 =?gb2312?B?M1dRdlVEbVJMRFU5V0RmWHdueUJCUjFVbklPamhXaG9CUGo1Zk02SkJaUGhp?=
 =?gb2312?B?cTBpUTFhejFLeld2eDRlSnhlMm9veW50OEQxVmdyZXJ3WEY3K1NJNHpKMmVU?=
 =?gb2312?B?MC9OcTUzeFVqTGdnbVhaQklwcWt1Z1h5N3BmSVdKS21pcTNHSHlIUitZSVJm?=
 =?gb2312?B?TU9aQ2U2UWk5dmdOaGpUMHFVeExvUmxDMENacDF5eE4wSjcvdk1iQy9GVDA2?=
 =?gb2312?B?QUFpdUhhMy9GN255K1Y5dUlGODI5WDdhUHV0bEV4Y2JVbmU4Z1RmSVM5dEc1?=
 =?gb2312?B?RlZPMlhHdGVnYkxGSS9aNDZNS0ZIcTZMb2N2MjdsNEczempySG82RVVUSk5V?=
 =?gb2312?B?RUhKZVlSZmhRdDFpVTdkUVVQTWkyeGo4T3Q0bnRZWlVjOE4zUDNGMVFLV0V2?=
 =?gb2312?B?czQ3c1llM2cveGZ4d2dSRllQVWd2dWNzZzA0a05SUmNvNVl5ZDZ0QVdkaVVw?=
 =?gb2312?Q?1a8kBgXOFBPUAPz0=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe31706-9b30-45b6-07b3-08dec13162b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 05:31:38.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9cwpwfykr7IARX9RfJJLaI9wVaN+VSt9SeIHxbci541qEjs9487wkyS12nM1vb97N6TVoLeTLAOnJG0zd5Zb4Hb0H/FcgeQG3cS3ix8dY6sndGqM62ExX0CIEuKksbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1176

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogQW5keSBTaGV2Y2hlbmtvIDxhbmRy
aXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+ILeiy83KsbzkOiAyMDI2xOo21MIzyNUg
NjoyNw0KPiDK1bz+yMs6IExpYW5mZW5nIE91eWFuZyA8bGlhbmZlbmcub3V5YW5nQHN0YXJmaXZl
dGVjaC5jb20+DQo+ILOty806IEFuZGkgU2h5dGkgPGFuZGkuc2h5dGlAa2VybmVsLm9yZz47IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnpr
K2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBN
aWthIFdlc3RlcmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51
eC1pMmNAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiDW98ziOiBSZTogW1BBVENIIHYyIDAvM10gaTJj
OiBBZGQgU3RhcmZpdmUgSkhCMTAwIEkyQyBtYXN0ZXIvc2xhdmUgc3VwcG9ydA0KPiANCj4gT24g
V2VkLCBNYXkgMjcsIDIwMjYgYXQgMDQ6NTA6MzZQTSArMDgwMCwgbGlhbmZlbmcub3V5YW5nIHdy
b3RlOg0KPiANCj4gPiBUaGUgU3RhcmZpdmUgSkhCMTAwIEkyQyBjb250cm9sbGVyIGlzIGEgdmFy
aWFudCBvZiB0aGUgd2lkZWx5LXVzZWQNCj4gPiBEZXNpZ25XYXJlIEkyQyBJUCwgd2l0aCBhIGRp
c3RpbmN0IHJlZ2lzdGVyIGxheW91dCBhbmQgZW5oYW5jZWQgZmVhdHVyZXMNCj4gPiBzdWNoIGFz
IFNNQnVzIEFsZXJ0IGFuZCBwcm9ncmFtbWFibGUgRklGTyBkZXB0aHMuDQo+ID4NCj4gPiBUaGUg
c2VyaWVzIGlzIHN0cnVjdHVyZWQgYXMgZm9sbG93czoNCj4gPiAxLiAgQWRkcyB0aGUgZGV2aWNl
IHRyZWUgYmluZGluZyBkb2N1bWVudCBmb3IgdGhlIHN0YXJmaXZlLGpoYjEwMC1pMmMNCj4gPiAg
ICAgICAgIGNvbXBhdGlibGUuDQo+ID4gMi4gIFByZXBhcmVzIHRoZSBleGlzdGluZyBpMmMtZGVz
aWdud2FyZS1jb3JlIGJ5IGV4cG9ydGluZyBhbmQgbWFraW5nDQo+ID4gICAgICAgICBjZXJ0YWlu
IGtleSBmdW5jdGlvbnMgb3ZlcnJpZGFibGUsIGFsbG93aW5nIGNvZGUgcmV1c2UuDQo+ID4gMy4g
IEludHJvZHVjZXMgdGhlIG5ldyBpMmMtc3RhcmZpdmUtKiBkcml2ZXIsIHdpdGggc2VwYXJhdGUg
bW9kdWxlcyBmb3INCj4gPiAgICAgICAgIG1hc3RlciBhbmQgc2xhdmUgZnVuY3Rpb25hbGl0eSwg
YmFzZWQgb24gdGhlIDIwMjMtMDcgcmV2aXNpb24gb2YNCj4gPiAJdGhlIFN5bm9wc3lzIElQIG1h
bnVhbC4NCj4gPg0KPiA+IEN1cnJlbnRseSwgZHVlIHRvIHRoZSBmb2xsb3dpbmcgZGlmZmVyZW5j
ZXMsIGkyYyBkZXNpZ253YXJlIGNhbm5vdCBiZQ0KPiA+IGZ1bGx5IHJldXNlZA0KPiA+IDEuICBG
b3IgaGlnaCBhbmQgbG93IGxldmVsIGNvdW50aW5nIHNldHRpbmdzIGF0IGRpZmZlcmVudCByYXRl
cywgaTJjDQo+ID4gICAgICAgICBzdGFyZml2ZSBjYW4gdXNlIElDX1NDTC1IL0xDTlQgdG8gc2V0
IFNTLCBGTSwgRk0rLCBVRk0NCj4gPiAyLiAgSW50ZXJydXB0IGNsZWFyaW5nIGlzIGFjaGlldmVk
IGJ5IHdyaXRpbmcgMSB0byB0aGUgY29ycmVzcG9uZGluZw0KPiA+ICAgICAgICAgYml0IG9mIElO
VFJfQ0xSLCB3aGlsZSBkZXNpZ253YXJlIHJlYWRzIGRpZmZlcmVudCBjbGVhcmluZw0KPiA+IAly
ZWdpc3RlcnMNCj4gPiAzLiAgTWFzdGVyIGFuZCBzbGF2ZSByZXF1aXJlIHNlcGFyYXRlIHByb2Jl
IGNhbGxiYWNrcyBhbmQgY2Fubm90IHJlbHkNCj4gPiAgICAgICAgIHNvbGVseSBvbiB0aGUgcnVu
dGltZSBtb2RlIHN3aXRjaGluZyBwcm92aWRlZCBieQ0KPiBpMmNfZHdfc2V0X21vZGUoKQ0KPiA+
IDQuICBUaGUgdmFsdWUgb2YgRklGTyBkZXB0aCBpcyBub3Qgb2J0YWluZWQgdGhyb3VnaCByZWdp
c3RlcnMsIGJ1dA0KPiA+ICAgICAgICAgd3JpdHRlbiB0aHJvdWdoIERUUw0KPiANCj4gTkFLIGlu
IHRoaXMgZm9ybS4gV2Ugd2VsbCBkaXNjb3VyYWdlIGNvZGUgZHVwbGljYXRpb24gYW5kIHVnbHkg
aWZkZWZmZXJ5IHdpdGgNCj4gZnVsbCBvZiBfX3dlYWsgYW5ub3RhdGlvbnMgdGhhdCBtYXkgbm90
IGJlIHByZXNlbnQgaW4gdGhlIHJlZ3VsYXIgZHJpdmVyLiBUaGVyZQ0KPiBpcyBub3QgZXZlbiBh
IHRpbnkgYml0IG9mIGp1c3RpZmljYXRpb24gZm9yIHRoaXMgbm9uc2Vuc2UuDQo+IA0KPiBUTDtE
UjogdGhpcyBzZXJpZXMgbmVlZHMgbXVjaCBtb3JlIHdvcmsuDQo+IA0KPiA+IEkgaGF2ZSB3cml0
dGVuIHNvbWUgcG9vcmx5IHN0eWxlZCBjb2RlIHRvIHJlZHVjZSBjaGFuZ2VzIHRvIGkyYyBkZXNp
Z253YXJlDQo+ID4gYW5kIHJldXNlIGl0cyBmdW5jdGlvbnMgYnkga2VlcGluZyBhYSBhbHdheXMg
dHJ1ZSwgZm9yIGV4YW1wbGUNCj4gPiAxLiAgdGhlIGltcGxlbWVudGF0aW9uIG9mIGkyYy1kIHdf
cHJvYmVfbWFzdGVyKCkgZGlmZmVycyBvbmx5IGZvciB0aGUgdHdvDQo+ID4gICAgICAgICBJUHMg
aW4gaTJjX2R3X3NldF90aW1pdHNfbWFzdGVyKCkuIEluIG9yZGVyIHRvIHJldXNlDQo+ID4gCWky
Y19kd19wcm9iZV9tYXN0ZXIoKSwgaTJjX2R3X3NldF90aW1pdHNfbWFzdGVyIGlzIGRlY2xhcmVk
IGFzDQo+ID4gCV9fd2Vhay4gQSBiZXR0ZXIgYXBwcm9hY2ggaXMgdG8gdXNlIGEgY2FsbGJhY2sg
ZnVuY3Rpb24sIGJ1dCB1c2luZw0KPiA+IAlhIGNhbGxiYWNrIGZ1bmN0aW9uIHJlcXVpcmVzIGNo
YW5naW5nIG1vcmUgaTJjIGRlc2lnbndhcmUgZmlsZXMuDQo+ID4gCUkgZG9uJ3Qga25vdyB3aGF0
IHRoZSBhdHRpdHVkZSBvZiB0aGUgY29tbXVuaXR5IGlzDQo+ID4gMi4gIEZvciB0aGUgb3BlcmF0
aW9uIG9mIGNsZWFyaW5nIGludGVycnVwdCBmbGFncywgaTJjIGRlc2lnbndhcmUgcmVhZHMNCj4g
PiAgICAgICAgIGFuZCBpMmMgc3RhcmZpdmUgd3JpdGVzLiBUaGVyZWZvcmUsIGluIG9yZGVyIG5v
dCB0byBtb2RpZnkgdGhlDQo+ID4gCXJlbGV2YW50IGxvZ2ljIG9mIGkyYyBkZXNpZ253YXJlLCBJ
IGFkZGVkIGEgd3JpdGUgb3BlcmF0aW9uIHRvDQo+ID4gCXNmX3JlZ19yZWFkKCkNCj4gPiBTbyBJ
IHRoaW5rIHRoaXMgdmVyc2lvbiBvZiB0aGUgY29kZSBpcyBub3QgYWxsb3dlZCB0byBtZXJnZSwg
YnV0IEkgZG9uJ3QNCj4gPiBrbm93IGhvdyB0byBoYW5kbGUgdGhpcyBzaXR1YXRpb24gYmVjYXVz
ZSBpZiBpMmMgZGVzaWdud2FyZSBpcyBub3QgY2hhbmdlZA0KPiA+ICBhdCBhbGwsIHdlIHdpbGwg
aGF2ZSB0byB3cml0ZSBjb2RlIHRoYXQgaXMgc2ltaWxhciB0byBpMmMgZGVzaWdud2FyZS4NCj4g
PiAgV2lsbCB0aGlzIHR5cGUgb2YgSVAgbm90IGJlIGFsbG93ZWQgdG8gbWVyZ2U/DQo+IA0KPiAt
LQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo+IA0KDQpUaGFua3Mg
Zm9yIHRoZSByZXZpZXcuDQoNCkluIHRoZSBmdXR1cmUsIHRoZSBkZXNpZ253YXJlIHdpbGwgYmUg
Y2hhbmdlZCB0byB0aGUgZm9ybSBvZiBjYWxsYmFjayBmdW5jdGlvbnMsIA0KYW5kIHRoZW4gY2Fs
bGJhY2sgZnVuY3Rpb25zIHdpbGwgYmUgcGFzc2VkIGluIGkyYyBzdGFycnkgLSAqIGFuZCBpbXBs
ZW1lbnRlZCANCnVzaW5nIGRlc2lnbndhcmUgYXMgYSBsaWJyYXJ5DQoNCkJlc3QgUmVnYXJkcywN
CkxpYW5mZW5nIE91eWFuZw0KDQoNCg==
