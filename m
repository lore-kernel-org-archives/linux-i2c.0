Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2128.outbound.protection.partner.outlook.cn [139.219.17.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594FD3E5EC3;
	Tue, 26 May 2026 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795659; cv=fail; b=kbEXeHOX4ZYX7NLDUMLytpoNseIFdIrscUZuQgAoGF8fNge2dtIk1a+j8jCR5W9IXvuHZMV5j6I6PWFfrVd2f8muwIbp8/sP/j+Yvejaf8iDDSvJgFPb7Yr0y9Z0JQtbO3ajYKmAR7HcbAZC3tBkiBgRAa5xBc7z3JQLOELfksw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795659; c=relaxed/simple;
	bh=p4uc4e1NbZ9SiJy5zXAtujdf/0Pi1x2pzvqz5jeliXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SZXRsyCpkhDLbDEIROMBCTj5h66kcpKLSp8GefiwGs0AMWdTp5DuDEa4z1Xy49oLW2h6wh7NeRX5Y/XeYp0WDvkGv4hg97ICqHGi52QvCairG7YmqbtVkeyjxfPfLdsREGYfUXFwgZmgSNwDAyQnVKxWO3uZkHmE2O5AUUromTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN4rPx1hXKg8e2UqrOybuRXQyHzxiyYHjEBrei/lRuvZa8ZzNEVEkvfjDdxZk5dziQEk2jM9b0NstfToWVXTI/sykFF1SzkDfHw2DB+yWTNvD8PbGL1+SUo/JQ9MwhQ+jYRARcs7Z+q8Cjd0iuhCCuK0bqCHzcb36YNawU5TxxYRVaxLVE8I8nMo3d9RidUy/n9AfhnEyYrGZU4SvRLzNBYh+uMir701PmfDW+j4igScIpp/Pvqc3lXtXOepPpi8at2Nj00EldU6sW7z/LZzAfK5UJpsC85iZ4FCGbok9n5RxmrngSBehX5aminB3yx4u1/kcuUX6k7ddcD/JQUJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4uc4e1NbZ9SiJy5zXAtujdf/0Pi1x2pzvqz5jeliXk=;
 b=dTlojXLcivQbdcUWd0Vd1AEE8qqwdOW9HMh8jBCN2NYY2Id0/PnuB90PGZUqQybaHHzFA+5ry9e1N8M5I34au0TJpVtfdRlmZYr/MLIuNXCuuU9MTB7//CkCiJ6RcY3rO3gVPksXvvQv1gUKWaHCg5Xa4lkQ36o8YRrjnyjxJGyim3h78QejCDD4BAPcHZlSFiihX1OohtgPdtpl/Hg8dQ7rkJhhx/X6hX6YNsv0CRq5UAuyJ7t7WkuZZA1z6rYSLRoc/E/QuR2V6vuu11tjr2LD4/omX6zSMndW9bgR1nFLFzz54wPmLyE5z3raktcYr/rqVkwFAqksy6xZLchxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1256.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 10:07:45 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 10:07:45 +0000
From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMS8zXSBkdC1iaW5kaW5nczogaTJjOiBzbnBz?=
 =?utf-8?Q?,dwc-i2c:_Add_StarFive_JHB100_bindings?=
Thread-Topic: [PATCH v1 1/3] dt-bindings: i2c: snps,dwc-i2c: Add StarFive
 JHB100 bindings
Thread-Index: AQHc6NQIO8gFL4A340+9gLOr9hGfsrYY8MeAgAcqjEA=
Date: Tue, 26 May 2026 10:07:45 +0000
Message-ID:
 <ZQ0PR01MB1269F0C3E81C191A716EAE72820B2@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
References: <20260521034340.27837-1-lianfeng.ouyang@starfivetech.com>
 <20260521034340.27837-2-lianfeng.ouyang@starfivetech.com>
 <eb1e7119-9d1c-4efb-9609-3c8f5265084c@kernel.org>
In-Reply-To: <eb1e7119-9d1c-4efb-9609-3c8f5265084c@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1256:EE_
x-ms-office365-filtering-correlation-id: 2cbe28b2-afdb-4e80-1527-08debb0ea1f0
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|4143699003|3023799007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 YayzYmcMoxg7GYwz6bMXRs4LQlpHKuODiUe+I5XgezSV32QyfcVO9AELXPuZbNxMTrOP/tHs99R6Du36PBpWIZ40TdAUiYkLKrGoE49Wiui4nAOxVfJ4jQ06dnzP/JixqwPOnEYMxWckxx4gF33x/j2F9ETv8Yx3cbe4t556C1c/u3/hbJjsoMpngKqoKVXKo4g+y+g/l8WNbL07zPScatp9cTB1j/aGfmUROoaUJj4ISKzyTwM0chCEeEwCOX+9oK3OZu5y6oKxpIWm1nSAcp/lsE5WlDvKzWTmRbICAwkr6183c+aewLfNf8TPVYM+3CG1lQMdJxzZD75nR02lbQAGkipZK8BkGtCzuvd8b2I/0Zyu16Dr1/YDSkhrcV+Cw+NgDHQpK7zKsO8dA0mrTGtK9uQirwQSFaWorzqFUnuqM87AgsFi9y/YjRhP/rabCMOngxmMUEs25yn4Wt7xKyjrD4u/HJJ4d15im50W6H4otN/1Qnr9J6FSkBv+ueKExFljSHZjyqHFYK1zCt6ecrnJPtaMM/eKjO1WoKbPGSN+wHOqsbriPRxsdKXE6CPk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(4143699003)(3023799007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjdLUDBFK3dycHZlaGtMdGRFaXVVSU9tMnFtMlFlZXdlLzM0c1pYTFphVmI2?=
 =?utf-8?B?OHZINVdmemd4akxCYUZJeU5uVVdNZm4yKy9kOWdic0RaZkJPZDZZQjV0NVlo?=
 =?utf-8?B?TzlmVENDWlRrbitiYWV0Uk54NWhvdEwyNy9jNmtPbWV3YnhEY0lwSUZMSk1m?=
 =?utf-8?B?N2hvSU5RNFNrRXllcGFUQys4dlFzVWVJVk85dHVZM09yWHVKS1Vpd3dlSSt2?=
 =?utf-8?B?OGJpVXowUWlxVHVuRWxkVVN5OS83QkdWK0wyRUthN080TWdXMGh6bXV6MU9P?=
 =?utf-8?B?Z3lVdFZJOG5PalZmeUhDQXBZandPSGdwUy9uYnFHcHhTN3pJYzVRN2ZEeWRn?=
 =?utf-8?B?aFBRL2JETStoWFpabVZkZjJ3MHNWRjVCN00wR3BPdTMvNEdENXZsZHYrTTMx?=
 =?utf-8?B?bTl4b3p2UlN4MWdXS0YyWHZvS2JsbU1tSXJUSStYRmVrS3NKVGh4blg0VjBs?=
 =?utf-8?B?VjhiVGQ0YVlUcXY3d0Q2ZzA5azAwaWdnMFY4SE5OL21IOVlCR1pjMnIwRXFz?=
 =?utf-8?B?NW5kMzFhZVFsOXE2eW0wZTd5MXM4NlM2d2ZyUzN4UlY2NkVoV1RhRFJIV2Ux?=
 =?utf-8?B?MXl0emlWeDN2WGx3RHlhK2R1LzJnaTNvYWJCUkkySUF4NzE1UHRPZWdSQmdP?=
 =?utf-8?B?Mk5lK0x6VzZPVzJIVk12dXhPMDVLV1ZKcFpHR1BLVjFsZENtK1k4K3Y0MDlT?=
 =?utf-8?B?ZkRxbGx1YURZN1pZQXRacWlVVXErbW0wUUl1amJTK0RodDNEZlRkMkpDVldt?=
 =?utf-8?B?ZncrQzcyUWJ6VUMzUm55c1FYS1hxWU9qUThVeTdEWU1CSFpmODlpVTVlM21r?=
 =?utf-8?B?NEVyUjFQbE1ac004NU54ajFIN01Oc3lMU0wyK2JTaXFKeVkrTnFhQVJFN2cx?=
 =?utf-8?B?WGlKTjZsQWRNMUhSbzd5dDhPTWs0V0IySkdLc1ZDY3hGaHoySjRTVGo5UEFi?=
 =?utf-8?B?WmdiRFZoYWlvZ1IybkZSTUE0NDRnRDlEVWMzaW12bngyQTBnc3JqMjN0VjZq?=
 =?utf-8?B?TUludjhCazFJVTY1czc5K253cm5tRis4c0NMRkhTRmlrSmdhczJRemxCZUFl?=
 =?utf-8?B?dkt6Wm1TSitLalFOMXlmMG9NeVRnSWRKU3NxTEt0RXZjdThPM1ZUVHN3b3pX?=
 =?utf-8?B?T2ZWMmd6VE9HWmRkVFIxR28xcGZzeW5LeWZ5YjlURDBBUmVncFRnSHJRWGJQ?=
 =?utf-8?B?bU1oalVqa2JIYXZ5bzZRWkhBTjI3TklsNHZhWHZ3VFN6REk2bWNlbnViYXBF?=
 =?utf-8?B?cTU2SEt6SmE5OHlSMUZ0aHNTbTBNNk9JeUNMdHQ1Z2l3aTJ2V0xwOGpwWC96?=
 =?utf-8?B?RzNxMGxENWRvSHUrbGhiMTloY0k5K3BpYit2Tkh3dEpybWJ2VEJrZ0todlM3?=
 =?utf-8?B?bG4yOWhoK1pqMW4rSkh2Q25qYXdEUG5wd3ppa0ZPY2VMVUhDNmdZMytQNXVM?=
 =?utf-8?B?SVpIQVVZTHdCWFBlMTQxUTJ4T1kwM3ZuYlo1cFdMVlI0Nk4yU2VqWTFXQmpQ?=
 =?utf-8?B?Z08vM0pKNTVld0VhdmtCcU1BVEQ0bU1nRnZZejQrQ05GOEtwTkQyWWZHWlNG?=
 =?utf-8?B?UlpMMWJBaUIrVWhGQkI2TGY0T2ZUcGpveHJEeW55VWVKbWJ2SnJ3cTV1U2Mr?=
 =?utf-8?B?c0IrWVdlSG9DaWs0aFBUejNTMVhEeVhJU3RxSDNmQVZFNDlCRm84V3hIVTdv?=
 =?utf-8?B?SDd6L09sYWZwc1dPMkdzMGFnRnVjMUNDS3plbTQ5VWpXS2xWeTJPWlBsVmw5?=
 =?utf-8?B?Kzk3U1RtaWgzVnZRTUZlZk0wRFdzWm5CSmdGV1RwczcrOFV1SnZHTVFQcXpz?=
 =?utf-8?B?dGR5SUNnVUR0eVJ3cnpsNzZrWSsvcnhBclhWa0o5UTQ0enA1UDR4eFBjN0dh?=
 =?utf-8?B?aEc5aTliNjZwNzNsczdUMWIyMUJCZCtZT29XNWJNZHJVRVJEQXB3UFBKRFRK?=
 =?utf-8?B?bjdWQ2pPSTNGZjVrdTBLQlNBaklUekw0clRFSVRlZmRVMk9jcVE2NXcxbURz?=
 =?utf-8?B?Ui8wQ09pd0E3OFRRM3BOZ09lcngrK2ZpbjFScGVKL21WTVJxQXVVVHhFakRK?=
 =?utf-8?B?bk9NZFErTkRSYlBMQ2FUUk9FSTlXOW12SUxvRnlRVElYRWtDZ0tXYTl4Z3NO?=
 =?utf-8?B?MENNRkJnWnV1WndiclpMdDVSdUpWNDcxUHFkeS9CZnlHWXZDaS9GV2FDeFJX?=
 =?utf-8?B?RU1xSW1HcHNCcThpM0x6YlUyYnR6RFVkUlMyL2FOZnF2UGhzYlUvb1RWSnJM?=
 =?utf-8?B?SmZDV1Q0WnEyak9sTHJGZlIxUmF1RFRoVXo4dGJSd3VIZDJ2NjZnemNWbFY3?=
 =?utf-8?B?Y3hvNlgwUHI4ZkJEdDdhQ0xYQm1xYjRFTlR4RVoxV2x6SXRuT0lYTFJudmJl?=
 =?utf-8?Q?RY77xQa/AHidMmlQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbe28b2-afdb-4e80-1527-08debb0ea1f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 10:07:45.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yr4n4a3+PlePvtDsZAaKq660dxDNhwt/QDz4dLL2tEMgtnfpKHw+twJSLfi4iYJuNWwi7U1iV9myNzskLbV0d8wgeu6R1N0J+Mm9bRPoD1Ak2HRzqBwFXm5nZLIbnvc/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1256

DQpCZXN0IFJlZ2FyZHMsDQpMaWFuZmVuZyBPdXlhbmcNCg0KPiAtLS0tLemCruS7tuWOn+S7ti0t
LS0tDQo+IOWPkeS7tuS6ujogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0K
PiDlj5HpgIHml7bpl7Q6IDIwMjblubQ15pyIMjLml6UgNDozNA0KPiDmlLbku7bkuro6IExpYW5m
ZW5nIE91eWFuZyA8bGlhbmZlbmcub3V5YW5nQHN0YXJmaXZldGVjaC5jb20+OyBBbmRpIFNoeXRp
DQo+IDxhbmRpLnNoeXRpQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9v
bGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTWlrYQ0KPiBXZXN0ZXJiZXJnIDxtaWthLndlc3Rl
cmJlcmdAbGludXguaW50ZWwuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb20+OyBKYW4gRGFicm9zIDxqc2RAc2VtaWhhbGYuY29tPg0KPiDm
ioTpgIE6IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IOS4u+mimDogUmU6IFtQQVRD
SCB2MSAxLzNdIGR0LWJpbmRpbmdzOiBpMmM6IHNucHMsZHdjLWkyYzogQWRkIFN0YXJGaXZlIEpI
QjEwMA0KPiBiaW5kaW5ncw0KPiANCj4gT24gMjEvMDUvMjAyNiAwNTo0MywgbGlhbmZlbmcub3V5
YW5nIHdyb3RlOg0KPiA+ICsNCj4gPiArICBzdGFyZml2ZSxtY3RwLWkyYy1tczoNCj4gPiArICAg
IGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIFRoZSBwcm9wZXJ0eSBzaG91bGQgY29udGFpbiBy
ZWZlcmVuY2UgdG8gdGhlIG1hc3RlciBub2RlIGFzc29jaWF0ZWQNCj4gd2l0aCB0aGUgc2xhdmUu
DQo+IA0KPiBJdCdzIHJlZHVuZGFudCB0byBzYXkgdGhhdCBwcm9wZXJ0eSBpcyAidGhlIHByb3Bl
cnR5IC4uLiIuIEp1c3QgU0FZDQo+IGRlc2NyaWJlIHRoYXQuDQo+IA0KPiBBbHNvLCB3cmFwIGFj
Y29yZGluZyB0byBMaW51eCBjb2Rpbmcgc3R5bGUuDQoNCk9rYXksIEkgd2lsbCBvcHRpbWl6ZSB0
aGlzIHR5cGUgb2YgZGVzY3JpcHRpb24gaW4gdGhlIG5leHQgdmVyc2lvbg0KDQo+IA0KPiA+ICsg
ICAgICBUaGlzIHZhbHVlIGlzIG9ubHkgdXNlZCBpbiBzbGF2ZSBtb2RlLCBlc3BlY2lhbGx5IGZv
ciBNQ1RQIGFwcGxpY2F0aW9uLg0KPiA+ICsNCj4gPiArICBkd2MtaTJjLXR4LWZpZm8tZGVwdGg6
DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzIN
Cj4gPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIFRoZSBwcm9wZXJ0eSBkZXNjcmli
ZXMgdGhlIHR4IGZpZm8gZGVwdGguDQo+ID4gKyAgICBkZWZhdWx0OiA4DQo+ID4gKw0KPiA+ICsg
IGR3Yy1pMmMtcngtZmlmby1kZXB0aDoNCj4gV3JvbmcgbmFtZS4gR2VuZXJpYyBwcm9wZXJ0aWVz
IERPIE5PVCB1c2UgImR3YyIgbmFtZS4gUGxlYXNlIHVzZQ0KPiBleGlzdGluZyBzdGFuZGFyZCBw
cm9wZXJ0aWVzIGZyb20gZHRzY2hlbWEsIG90aGVyIGNvbW1vbiBzY2hlbWFzIG9yIGp1c3QNCj4g
bG9vayBhcm91bmQuDQo+IA0KPiBEbyBub3QgaW52ZW50IHlvdXIgb3duIHN0dWZmIGFuZCB1bmZv
cnR1bmF0ZWx5IGhhbGYgb2YgdGhpcyBiaW5kaW5nIGlzDQo+IHN1Y2ggaW52ZW50aW9uIC0gZG9u
ZSBjb21wbGV0ZWx5IGRpZmZlcmVudCB0aGFuIGV2ZXJ5dGhpbmcgZWxzZS4gVGhhdCdzDQo+IGEg
c2lnbiBvZiBkb3duc3RyZWFtIGNvZGUgYW5kIHdlIHJlYWxseSBkbyBub3QgbGlrZSBzdWNoIGNv
ZGUuDQoNCkkgY291bGRuJ3QgZmluZCBhIHByb3BlcnR5IHNpbWlsYXIgdG8gZmlmdHkgZGVwdGgg
aW4gdGhlIG90aGVyIEkyQyBkcml2ZXIuIEkgcGxhbiB0byANCnVzZSBTdGFyZml2ZSxJMkMtdHgt
Zmlmby1kZXB0aCBpbiB0aGUgbmV4dCB2ZXJzaW9uDQoNCj4gDQo+IEEgbml0LCBzdWJqZWN0OiBk
cm9wIHNlY29uZC9sYXN0LCByZWR1bmRhbnQgImJpbmRpbmdzIi4gVGhlDQo+ICJkdC1iaW5kaW5n
cyIgcHJlZml4IGlzIGFscmVhZHkgc3RhdGluZyB0aGF0IHRoZXNlIGFyZSBiaW5kaW5ncy4NCj4g
U2VlIGFsc286DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE3LXJjMy9z
b3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jpbg0KPiBkaW5ncy9zdWJtaXR0aW5nLXBh
dGNoZXMucnN0I0wxOA0KPiANCj4gUGxlYXNlIHJlYWQgY2FyZWZ1bGx5IHdyaXRpbmctYmluZGlu
Z3MgZG9jdW1lbnQgYW5kIHN1Ym1pdHRpbmctcGF0Y2hlcw0KPiBpbiBEVCBkaXIuDQoNClRoYW5r
IHlvdSBmb3IgdGhlIHJlY29tbWVuZGF0aW9uLiBJIHdpbGwgY2FyZWZ1bGx5IHJlYWQgdGhpcyBk
b2N1bWVudA0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
