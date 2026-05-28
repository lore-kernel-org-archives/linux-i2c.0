Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0909937757F;
	Thu, 28 May 2026 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957034; cv=fail; b=FQJlE+Q1VijbO7TGNIa5K3RablwAcovfBVjOK6LECAJEXqzD5StQNezr//l1GC6hQbE09ehpKYEAsK5Nmkn//GGpApguH6iT3tScIptHtsKNLPwmhogY1Xgvorib8VIh56I4B8Mb2YwwX+4D6d3bNZ/vPNS3sLBDgzX2o6uQp1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957034; c=relaxed/simple;
	bh=/YWulHwBepRJdU12rBd67vfPMfduBRVmQ9QCJ+nzyGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuY4aAJD/WAFyaCQP02J92zARo7eg6ZXiEdf2D4DPMFPNpSWZeMWEXyS3hHXZhkuft0oN57h2MS09jouvZPuj2dpQ7hbs8pHyJgCS7HCYz9OxiDBRCfzixPhUtaEsak9N6Mv9QrxQ1RW0RY+j/jSlWVVOn+ZsJuEfkAnN+nt5RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+9oERj02lnPeHQY+bLZy+t9U3ebPhtdGuFshAaYJlUOrROgN6lBfTyA2djNn8mzdywxfeJzZ/HMr22ueIlC3U7KcPdJUZmmZbWVohdDA3p58lDzviHh8t+4p1G9oK6UTU5MEAGjSQaLogqJmpM2ijndl1x9YqprpJ+cgen4GkU78ShvBPqr9Xb0VXZnOJB8JQqNpurh3cI4ucn66wBZWs8lox157h3sDXipO8y1uLPPiJHwdkn7mw29qSsKVjLv3Ma3+fgeRqsw9Rgc2jbpbOATIGcwVddjcMSjZFQWt0WpC2azvtyoeSDt0eZQE7QpEZkYMJSUdeQMd1xt/Pu7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YWulHwBepRJdU12rBd67vfPMfduBRVmQ9QCJ+nzyGY=;
 b=Hg3DL1LXpbgEk5i0d+ZH139gYO2QsVcvZFNfdvFKueizxImUb3QmY3g8WiDrYKpEoEwHs9IX7ScBR0SfLx0sktHKg5knA8sdnTHUgzfOLc1E+XnHZfPzTPIv2ZOXKTMOTTsGXCN/qEGW+BnKMQMn34tU73zYUDvb6Cb8RKkhdYirJQjPkLGRB6oATfeTOBOK//Xkg1SLDe+X3pFIaG/bagoGhPu4q6a+ZPq3eKSEkeMRQDsuw2Ph1SEfiUXQhvgTB9jCQ8r+BXzvkGMu5JkNNI8n20EtQDtMKwUu9JqW4fmmHS2Qew7gy24WORv/4N0TVJCuJ+feFkQ41zYbafSAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1095.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:30:18 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:30:18 +0000
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
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MiAxLzNdIGR0LWJpbmRpbmdzOiBp?=
 =?utf-8?Q?2c:_Add_StarFive_JHB100_I2C?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMS8zXSBkdC1iaW5kaW5nczogaTJjOiBBZGQg?=
 =?utf-8?Q?StarFive_JHB100_I2C?=
Thread-Index: AQHc7bXpMbmKTQ8zB0KEK6Q2V5IIXbYh12MAgAEq42CAAA7igIAAC3mg
Date: Thu, 28 May 2026 08:30:18 +0000
Message-ID:
 <ZQ0PR01MB126967631C31091673C8058882092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <20260527085039.44435-2-lianfeng.ouyang@starfivetech.com>
 <0e3bae26-3bc3-43ff-8d66-aba84a6f6677@kernel.org>
 <ZQ0PR01MB12696D9B1AB14D4A3BEAEC2982092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
 <5e68aa84-7ce8-4405-9575-173e0a5834ca@kernel.org>
In-Reply-To: <5e68aa84-7ce8-4405-9575-173e0a5834ca@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1095:EE_
x-ms-office365-filtering-correlation-id: d7e7576a-e823-4ddd-a755-08debc9359c6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|3023799007|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 eprPih9eiu1jPOgH3HqNhiU4S24GLw9QdsEZuGlW/vegugas9ZDOU65PgjhKIQj/s7o3h/9eNypic028pe5BVNLGPXv9lbDuHXlrMLyprY+CuW788KCdCH37gw9qdeHZOwx6IZM+QX7AktufSDYp0JsyAP1jXDwqwk2TDlSsFuJwzWl1PNw5a1eKO18oxu+aYo+uUxawzleGWBDiNXQpBjEel+OcyCmmk77KrbsdkIhtej1ZRtL7GCfKGoMV/BDkzc9hcm1CywNdLUM179AYKuDyYq359JpR9L7mq4gy7bQVROZqk/AE5G4mjmHORWfRJnVrUVW4mdcBAs1WealjyA4ky3XxaGYCU/F+Z7cymvp5hALsRUSBE03pnmJclWRqoLn0r7Shft2C2yspCqq4upLa3rKXtarOfbB3ptTFNXfey6EXSXavjDlnpSBwZ2j7T7sIdQhmY4eQ2FTrVmkpa81va+kCz6AdJNiXCDT4MkH7tlP9tmiTxhT+5hk4ba7Ht4UEGVdt814tUJ01v7rYTX+r9MyA9LBtm6+HTqVwA+CBdq1Ay6sdBfyxX+m7TCUf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnd3UmszYjdnQ2NiaEUwZUJBOFgwRUpLUnVsUTZWQXI4ejhydTFBWkZXSHpl?=
 =?utf-8?B?aU5uWm1jdlYwekNaS1kvbitZS3NZWjl0eXkzMWQ3UDVTVTMrak1WdmZYUk92?=
 =?utf-8?B?bmlEZGpET3dWdFcrTm1vRnc1TWt5ekdGRGRzRTJpT1gzN2dUamRtWThhK1V2?=
 =?utf-8?B?VnB2OFhwT3hNeGtzYkgrV0JXQkFwdWlHQzhNZ0xXNEUrOWZVSnRVVWtPNHUx?=
 =?utf-8?B?N2VDZ0JBYWJsN21GaDBTVlMrSlJFZEQvTm5hYmlGR0ZhVTlUYzF0RzZJL01r?=
 =?utf-8?B?S0YwaXNJM1dHZjg2elg0ZXd6Z3Npb3R2OWhiWHJuY2FReDB1T0lGNUtWMkVW?=
 =?utf-8?B?ais2RFBweGNab00wQzBCZWRTVlpZUTIxb3JBdWhvMDFSWFJNT0FMdmtCY2M0?=
 =?utf-8?B?TEZGWjk1ZmEyMDhVUE9idjB6RW9xMDVML0lsTWdyY2h6WlROOTdsMWxmSmJi?=
 =?utf-8?B?QjdXNkgzQUoyNEVNZFdPZXFVOTQ1QVMxcm9oMnd4MjR4eGhlNmQwZkprYTVE?=
 =?utf-8?B?Tm1YWm1VWUtMOGRHWXRUektKNjRFVXd2MndlQmw5eEhxVXRKaVNweGRqNUlj?=
 =?utf-8?B?RHhDVVg2TWNKRW1BQW1kbHE0RUZSQmhhSnQ0R2hUVmVST2RxZzhLSVpVNkpo?=
 =?utf-8?B?ckpQa0dvT0xtc3MwUSs4cTBESmhyNUFId09tMEF0S3V3ZmovSDVLMUpabE9j?=
 =?utf-8?B?RTNrMmhxWGZCUWQ2R0tSRi9CTmg4ZWhvK2xnUkpGaGtMK2lhUEU0RlFIWjQy?=
 =?utf-8?B?UkJRMmJwcXpadlRHN21xRjFHU241QkFWSXZGQkRib0lpekVoUHM2Zm0xd3BH?=
 =?utf-8?B?eTNBaHh4RFdJYk14RE16SnpiVUNSRUNnVUtmVGpPQnlhR3F3dzFqc3pUNEl2?=
 =?utf-8?B?NTcyMzc0d0ZaYy9Xb1lkWEo0ZXVsMU42TjdkckZwRHB2N0NESlpkOHFvU1pB?=
 =?utf-8?B?RDFaTzRZSld1OXljTlo2WnRQN1Evam9CcFZQRzdPMHZ2dGUzdzFxM21rUlQy?=
 =?utf-8?B?a0UrcG5hK0J6R1IxdGpXMmVtV09NWk8wMTRnYit2R2tlUkNvVTUxbXBFOWd3?=
 =?utf-8?B?TGVCUkY2cllGaWZMRkxLak1rZlBNb29ZKy9HYXdURG9xYnFLanVFcUlCbmxP?=
 =?utf-8?B?S1FhZ04xUlp3cWJkL2NMNU11ZjkvRmZNMi9IREdjNHc5Zk9haFliZ2M2VERw?=
 =?utf-8?B?Z1V0TWZWTkt5WUhWb25pUjNTS0RnQ2VZWEhQYzFOMW1QOXdqaFVpWDZ1RkJy?=
 =?utf-8?B?OUdwSnhEcmtnZW5xTCtvUStnSXBWckdYRWtZV28vRHh2b3dnejVGclM0Z05m?=
 =?utf-8?B?Qm1uNCtCakgwb3h0RS9SMGRlelVUSVdiMHBncUpMamM0cm1icHkrWFg3VUl2?=
 =?utf-8?B?KzNCN1Faa3BlWkRXSXFNalhuWWJWRjhFdUpEVi8wd1A5VVBlbmdpRitMNVp5?=
 =?utf-8?B?K3NhaXFuVk9NVmRkMzllZUtrbDNvNEFJc1d2TEppaWVINUF3L1F5QmR2QzZF?=
 =?utf-8?B?b1pBbDFEMnJCSEErTDNzL2NNd0dGNnYrQTBOOTJOZkJGSW5RY29GOWJmQnVw?=
 =?utf-8?B?S1dyR2x5ODZPQXFISkZwc0dKMTJaVmZRMFVaeGcvSW9OekRDNktWajFOTDBS?=
 =?utf-8?B?V0Q4Y1RQcWpUdk9oSlVUYjV5bS9NeHRSYmJaRkVidTlEZUN6cVI3U3c1MHdR?=
 =?utf-8?B?TmZ4L3N5R0JnL01sOGhmL3JJVWppNVhkSUJseFJSK2MzaW9ZeUxkeHZyeVpH?=
 =?utf-8?B?TVc2azJTVVR0NE94Q2YrN0RVUTdZdUYzbDlYV0lZZnpieWR6NFlwZjBkUWdC?=
 =?utf-8?B?VGVRczJ2Y3d5TkV3WGtjb0RSZnorTmlXM1NWVDRaWFZVL0s5Q2FiLzQ4WTh1?=
 =?utf-8?B?TVRnYjViKytxR2hjbkdNTEtOS1UvWjZQWEtLaHpxME5wRXZUbDMxUGJPdjQ1?=
 =?utf-8?B?UTIveGdseHJ0c3Y2NUdOUXhROU45K3dObTNlMk9XKzJWTVlBckdTajgyeldm?=
 =?utf-8?B?ZVVMNmNXdk52TXJGa2h1aDdCYVBSU2RPczN0MWFaSW9XRGFDSEJQQXdBSUxk?=
 =?utf-8?B?OUZRN2s5WS9IYmk3M3AvZ3d1S3VmUzY4R254VzV0WmRaWFNFYUJFWmIvblhO?=
 =?utf-8?B?MjY4L0ZOcGhkYVRiY05xYS9vODZta0pzd2lWT0ZqbndQTFZXeU5GRGVPdVp4?=
 =?utf-8?B?dVc5NTluRTZCeHpJWW1tbmhIZ0RzVzMvc0VjOC9FbjZCTm9YUjlxbkhEQnB2?=
 =?utf-8?B?dmZIZlMxeFhoZkdiSzF3eFVTakpjdjJlZGxMbVN0MnZMWFhrbllzRThJbjhn?=
 =?utf-8?B?VGt5b0FaVUVpZlJISUFpeWIvenlsaktCVzRXNmFXKytiQTYvb0NkZGZBZXNa?=
 =?utf-8?Q?JOzKgL+TgLSYJwgY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e7576a-e823-4ddd-a755-08debc9359c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 08:30:18.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ho5vCnwkV9Vn7EB8CZT/PrshXSzWVV1Pon9DANyx9buw6Ytj7H+7W4R4zp8Oj02moZ34xI289hUci90Z1xC7xrGnLH/+iAHWlX75ZqcuTaUpuGWKq3iYdpyH1BUw+yTh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1095

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0NeaciDI45pel
IDE1OjQ4DQo+IOaUtuS7tuS6ujogTGlhbmZlbmcgT3V5YW5nIDxsaWFuZmVuZy5vdXlhbmdAc3Rh
cmZpdmV0ZWNoLmNvbT47IEFuZGkgU2h5dGkNCj4gPGFuZGkuc2h5dGlAa2VybmVsLm9yZz47IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnpr
K2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBNaWth
DQo+IFdlc3RlcmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+OyBBbmR5IFNo
ZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4g5oqE6YCB
OiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiDlm57lpI06IFtQ
QVRDSCB2MiAxLzNdIGR0LWJpbmRpbmdzOiBpMmM6IEFkZCBTdGFyRml2ZSBKSEIxMDAgSTJDDQo+
IA0KPiBPbiAyOC8wNS8yMDI2IDA4OjU3LCBMaWFuZmVuZyBPdXlhbmcgd3JvdGU6DQo+ID4+PiAr
ICAgIGRlZmF1bHQ6IDQwMDAwMA0KPiA+Pj4gKw0KPiA+Pj4gKyAgaTJjLXNkYS1ob2xkLXRpbWUt
bnM6DQo+ID4+DQo+ID4+IFNvIHlvdSBhZGRlZCBhIGdlbmVyaWMgcHJvcGVydHkgLSB3aGVyZSBp
cyBpdCBkb2N1bWVudGVkPyBHZW5lcmljDQo+ID4+IHByb3BlcnRpZXMgbXVzdCBiZSBpbiBjb21t
b24gc2NoZW1hIG9yIGR0c2NoZW1hLg0KPiA+Pg0KPiA+PiBBbmQgcGxlYXNlIHByb3ZlIHRoYXQg
bm9uZSBvZiB0aGUgZ2VuZXJpYyBwcm9wZXJ0aWVzIGFyZSBzdWl0YWJsZS4NCj4gPj4NCj4gPj4+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4+
DQo+ID4+IEkgZG9uJ3QgdGhpbmsgeW91IHRlc3RlZCBpdC4gQW5kIHRoaXMgY29uY2x1ZGVzIG15
IHJldmlldy4gSSBmaW5pc2hlZA0KPiA+PiBoZXJlLiBQbGVhc2UgZG8gbm90IHNlbmQgdW50ZXN0
ZWQgYmluZGluZ3MuDQo+ID4+DQo+ID4+DQo+ID4+IEJlc3QgcmVnYXJkcywNCj4gPj4gS3J6eXN6
dG9mDQo+ID4NCj4gPiBTb3JyeSwgSSBkaWRuJ3Qga25vdyBJIG5lZWRlZCB0byBydW4gZHQtYmlu
ZGluZ19jaGVjayBiZWZvcmUsIGJ1dCBub3cgSSBoYXZlDQo+IA0KPiBFdmVyeSBkb2MgYXNrcyB0
aGF0LiBEVFMxMDEgc2xpZGVzIG9yIG15IGVhcmxpZXIgdGFsa3MgYXMgd2VsbC4uLiBPdGhlcg0K
PiBwZW9wbGUgdGFsa3MgYXMgd2VsbC4uLiBhbmQgeW91IHJlY2VpdmVkIHRoYXQgcmVxdWVzdCBs
YXN0IHRpbWUgYXQgdjEuDQo+IFBsZWFzZSBkbyBub3QgcmVwZWF0IHRoZSBzYW1lIG1pc3Rha2Vz
IGJlY2F1c2UgdGhlbiB3ZSBmZWVsIGxpa2Ugb3VyDQo+IGZlZWRiYWNrIGlzIHdhc3RlZC4NCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCkknbSB2ZXJ5IHNvcnJ5LCBJIGtub3cg
dGhhdCBsYW5ndWFnZSBpcyBub3Qgc3Ryb25nIGF0IHRoaXMgbW9tZW50LiBJbiBvcmRlciB0byAN
CnByZXZlbnQgeW91ciBmZWVkYmFjayBmcm9tIGJlaW5nIHdhc3RlZCwgSSB3aWxsIGNvcnJlY3Qg
dGhlIHJlbGV2YW50IGVycm9ycyANCmFuZCBydW4gdGVzdHMgaW4gdGhlIG5leHQgdmVyc2lvbi4g
VGhhbmsgeW91DQoNCkJlc3QgUmVnYXJkcywNCkxpYW5mZW5nIE91eWFuZw0KDQo=
