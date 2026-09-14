Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5AD3537FF;
	Mon, 14 Sep 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380926; cv=fail; b=m1R//IXiy9CgqGpkUfT7aAGssm7JB3zNQeN9H1Nrb4Cf+av9GBEVzIssVQFunExe/oMBhPJ7gs58+oJky+6jUSS1ZO3mMs+tyIiObw/GPPTD7KA4VPC24mKnzga1TmpPEsGpu3Iw6jhO2CjoYcBL2FSaf9eCIVQScHJOKVWsU2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380926; c=relaxed/simple;
	bh=8UYv8ChD6fs+tUb1JP0Njkcchf6wLeyvHoDeuDh3A9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JGTYm8OXOtEQYpNfC9XbrMR9MCtn4kwFvwYrzQeFqdG5AWmolGYSS9sCy1L1p3PLLaF6nYMaIoUXT/fI8rGjoex3sx6uVrOrEN9iME57NjJSCAJcKR/3QCr1wc6Q0PyDDpi28GL242peJ7u7+C0YHaGGFxjjB8gYBs2/n87mryM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGPD0qVpniFEotzbafrHTrcStk/rCthXKRo2xwUzeOejp9n/a4RRV/OUceoFVw99j1XND581/K6OtFxkP5KH7GqRiMmi62hVuHRxwQG1wOa3zxV71iKVSHQ+qR1taXw/FPrz9LwM2HCyW8MSKV7NGpAqGB9+4a+9MilQhTeTg3TWqkm2dk964C4M4gxxB5aNp2Ji9cwPp9oQlHzVGnlHW9TaEL64y9tWQEZihiL+l+RK2Mf8WOcNdvGcAb3PktIne7N9u3zQI/3yTyipQ3q5jLihAyv3rgAl2Ou2/hon7JvYb3PApUwRl1rFy7VN/l3thiDW3iD9tUQd8YfeZar+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UYv8ChD6fs+tUb1JP0Njkcchf6wLeyvHoDeuDh3A9g=;
 b=mRivcs15snSilrWFJT6ArgsomSYVImyru1ZgdOcWQxSQ6Nw9nsMNRiQW13z8T91uEXU6ZJG4gyL6IH7ZxgOvs4xUYMmyoBDTlm/m2t8Xmxiw+rosEhQXhgxzeyStMGu7oEAV1Lq5xVAeB1zN3JMdTu/IPv4uW+pYgT0tOVKa7uvCYnRx/OETMSUsWZJfTta+ajgH2K28h2aQoyIECE0KI0gev9uaYoFd8OWtHM+BrkAYzwcwi7/G+7xWYjQx1OkCA4MKP2nH/M+0DzNvO90AhlROhfwz1ILbwJSZHelQEkzecxXcVCn1O1PdKEHNCnoKXdZiqi1DyEJ92eAR+kvUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1094.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:15:02 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 10:15:02 +0000
From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
To: Ritwick Sharma <Ritwick.Sharma@arm.com>
CC: "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
	"andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mika.westerberg@intel.com" <mika.westerberg@intel.com>, "robh@kernel.org"
	<robh@kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMC8zXSBpMmM6IEFkZCBTdGFyZml2ZSBKSEIx?=
 =?utf-8?Q?00_I2C_master/slave_support?=
Thread-Topic: [PATCH v2 0/3] i2c: Add Starfive JHB100 I2C master/slave support
Thread-Index: Ad0/ipf1+jw87FKjTrCUGaA5OTV97ACEE76w
Date: Mon, 14 Sep 2026 10:15:02 +0000
Message-ID:
 <ZQ0PR01MB1269D5D02EF9150EC61B633482BB2@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
References:
 <AMBPR08MB11569B5AB70EBB53C3165BB3198B12@AMBPR08MB11569.eurprd08.prod.outlook.com>
In-Reply-To:
 <AMBPR08MB11569B5AB70EBB53C3165BB3198B12@AMBPR08MB11569.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1094:EE_
x-ms-office365-filtering-correlation-id: d06f5af8-d51d-4320-a69f-08df12490a71
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|56012099006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info:
 3G7GYSRzvScbxfg9zYaekPgz/WQL7vVmnrcAh7GYh+q81LtKtCdkg+Cm1IKhSw7hFIjJ4Twy3SFZrxOFj9ZbgS85a9Z5H17zyQ8jvn6XtykkY3TlAMRPBG13FYJSBu48Jij7HpEc4L7Jk5DlpOKPlUAPRcKB627wVs4DsZqMpQaQfHHxy4kxBefs27L2h/7HFB7Lpl65OnduITNYPJMYUBdzDT/P+7D8QTgruZaBLVJF649c+8LTMGeuSDIEAFomE+8q8dw7AancvOrEReFDwxqgfGyXVIRbLwNbeA9bHvmoqg/WAutNZyijrtRTviUux6BuKHo6Ed1JqI8qvqA8cnKLsC48977Kn+bBJvDV+WgNWi8UAjkLI8T0aDcEe4mT9zpLmC0BwHD1iGWXjwIS0UlaJFo5WFR533AMm4pjpsBKsFN31/dF1v68Y6KtDJ09ZRF2kWndZaHKHJKlv+mCiR0eU/lH5FqFOCqp2CrKAGbSiXA/YCSLCfkwd0lCGnr8VO8Wl1eY1GQe61Vmf/cCDq3IRGMDPpWmHZpGviewSY13tvH3MX5iFCNznoeQ/fPe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFlVQ2pzYVc1TzErb3RQQi9SdHJkTWJHMzlBSVROOWREZUxVWThWZlM0NVN3?=
 =?utf-8?B?REw4cUQwcVFqNTdVK2M4M2Rpd05VWnFpT0tQQ3JHUGZmV2FDTHdmVUVXd0J3?=
 =?utf-8?B?SkFtTlJPUjNiMHNXTzRubEhLZkppL2JjZEdoWmxCS05LRVJlY2ZCNUh1NEd0?=
 =?utf-8?B?YnZzWTJSTElWL1ErODcvVHdYZTBuZ2tIbmh6TUhBSGZhMXdvcmpCalpZbWtK?=
 =?utf-8?B?M01ncE81YWtsamRCNFBmbC90aEtmN0tiYkE2ZW5RRTQ3eEdxM09XVldEUHpV?=
 =?utf-8?B?UXEyQ3JNRFhENEwvcEhJSm9jelpNTThlR0h3NmlvN2lYaUJyNnNYM05oQWNB?=
 =?utf-8?B?N2trMkRzU3U5SWVnRDJmSlYrc0h6aDBSSnJOMmFwUk5yRER0ZlIxWEZEang2?=
 =?utf-8?B?bnBnbmQvVFF2a2FQbkhsRy9pQ3lLa1ZKOWV4YWZCRVhqTDBVVTlBREthVGdJ?=
 =?utf-8?B?U0lsNVhTNUFwYStXcFk4aFAxTzBlWmdZckJFVmdmM0h1bzU3Z0NoOFJPL2Iz?=
 =?utf-8?B?K0ljcGt0WmVVS2xnUEdXZXNJWjRtUHZ0NUhnYVJxcUFGL3ZVL2tZYXEvZDcx?=
 =?utf-8?B?ZFZ0VStTS2ZyclRyUnhJOEdPb29odHlDdUh4OUthemFyQWJ3QUg4c1VhU3VV?=
 =?utf-8?B?VHIvUUp0ZklLbkxveW9CeU1HYmowR2l2VGIrdThEZnpKNmZDTnlmUUZhWjB4?=
 =?utf-8?B?TjRiUVkvbGNoZTJyT3AwUkFvdDl2L2U5WXJnN3BIZUpHazR5NUFuOUMyUXBB?=
 =?utf-8?B?eHNxWi9IZ0Y4TXNBSnlZOEpma0tGQkpPS0hYZHp3Q3QvKy9BenpBMzdXMXVB?=
 =?utf-8?B?bjNQNFFUUG15dFFuMWdNR0lHak9yLzJCV0Y4dzBIYXJzNi9OZWk0R3V1TEVP?=
 =?utf-8?B?S0JVSkpHdGlHaTF0ejNya1JiNjJYVVJiazgwdlNkSTN2NHFjZFdGVXV0d3E4?=
 =?utf-8?B?eGtkWUg2Sk1zTGt4OVcrOTFVMHpORTJEbFNLdWxibFN3Vy9hWGtnWmc4S3pa?=
 =?utf-8?B?NXhiek56VThjREZ0MWFiVmRjdVNJTGlqaXRxYnk4OVJNeTdwbmEyTWNGcFZp?=
 =?utf-8?B?REFaTVAweG1UM2VNWjIxajVMVlNvdSsyeG5ISTBWblZrb0lWNXVoVGFHU2hy?=
 =?utf-8?B?eEJ4Ui8weldQcERPWlRFWlFmUzJnaU91YXhTa0hoaFUzT1ZENm44RGlvQVRT?=
 =?utf-8?B?b2VjRlpKUmhUc2d0ZFM0TElENUFMVkRrVGJPSHM1aG5hK3g2d25mU3pESFly?=
 =?utf-8?B?aUxVVXNmdVJGcWdlcStaRE1rN0dYOWU3OWNxTWlpbjBMSUYxUnN1QW9KUHc2?=
 =?utf-8?B?LzZoREMydVM5N0VvSzYwL3ZNVzBJRXhTNmZZN0J2UVJhMjk2Z1lNditCelRM?=
 =?utf-8?B?TEliOHBid1ZxZ1Y2Z21oQmh0NmtlNzJrVEtZYXJzQTA0cndsb1UyaGt1dVhQ?=
 =?utf-8?B?UVRRY2dtcWFDUXlWY0JVSUl0VlRJc2IrcmR6c3dBTVk2NzJ0Qk5JeEM4YTF4?=
 =?utf-8?B?MFhqRHdyVjdxemJSaGJxR1JuK0Q3OTVwa3BycTdwRnB5SUVZZXFBMXlPa1E3?=
 =?utf-8?B?MHg4Rk5MZHVJRmVVbW5kS0pXcFlDSWt0Rm0xaTdDMHhoZ052Nk8vamtqa3hs?=
 =?utf-8?B?emRjZVdWTjZYWTJ5QlNkd0NSZkJWRTFGWVJsNlhrN1F1RVlDc0puRXB3MGta?=
 =?utf-8?B?NjFsMlZhdUFzY3BENlNZZktHTVo1ZDB0UTlYaUY0Q2dpQXJtREt1ZVdJb3NK?=
 =?utf-8?B?R011MHdRRlFwZEFDVmZHNlFxR21xc0VnbWQvbU9WZFdVbTloTFIzaFl5cDVv?=
 =?utf-8?B?eHY1c3A2dnUwUXNzcEZBcjJFMlU5RmtIWkpIeFZDY3AxTTlqc29WUjR4cjl5?=
 =?utf-8?B?OTBoR1BISXRoczJ4U2FaanJqN0VkU1BtWnRwZENFWXJLTEZsTnVEWDlHcWxP?=
 =?utf-8?B?dUh3QjYrWVVrQllIUGF6V1NUQ3U2OVdBMHBra0ZXVnRCSDNER0F2aEFTc1Aw?=
 =?utf-8?B?SFJWdzJoNXpYU1Zodi8wcWJ4RlBuRzZ4UElvMy9UVWN1SUIxYUxjV1pMV1Ba?=
 =?utf-8?B?TVJjLzNGUXpRYWR4dE1HaUpSNDZTd1hpMjBQS25VakxKMnpLaDdpTmtvQis1?=
 =?utf-8?B?RDRTTWJxeUV5bFJFdndGQU9zdEQvQzdxbkpvOUtaSlpRM1lmWHlJNFltbFNx?=
 =?utf-8?B?VXRSeUVqSHArMG9pRVF0SjVMU1M0aC8xdnhVc09BR0t3enVNRWFMREkxdm5H?=
 =?utf-8?B?NGdyT0JWd3ZZQXJXenYrWjFvMXZwZndKWUYrNzFCUVlUTHluc1hSWHpvYzJU?=
 =?utf-8?B?d2M2T3RIeUtIQzlHRENyTjdLM0w2WDdRYVJSazJOSjBHUVhtN3BNckRvTklC?=
 =?utf-8?Q?tKbgMZDCvMVs+atI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d06f5af8-d51d-4320-a69f-08df12490a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 10:15:02.6897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeTytAnOtGWGupcX56OHkTHgsxiZw7I0/HGOTQG8jG7hd3eoV0A4U5oH9Fy2hx9O1qYkG0avihpxzi2sIvejczME0BrbPvybObS+4V5ou8UOFAylEjHfVHbk6twFkSiE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1094

YWENCg0KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogUml0d2ljayBTaGFy
bWEgPFJpdHdpY2suU2hhcm1hQGFybS5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyNuW5tDnmnIg4
5pelIDIwOjQ0DQo+IOaUtuS7tuS6ujogTGlhbmZlbmcgT3V5YW5nIDxsaWFuZmVuZy5vdXlhbmdA
c3RhcmZpdmV0ZWNoLmNvbT4NCj4g5oqE6YCBOiBhbmRpLnNoeXRpQGtlcm5lbC5vcmc7IGFuZHJp
eS5zaGV2Y2hlbmtvQGludGVsLmNvbTsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gbGludXgtaTJjQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbWlrYS53ZXN0ZXJi
ZXJnQGludGVsLmNvbTsgcm9iaEBrZXJuZWwub3JnDQo+IOS4u+mimDogUmU6IFtQQVRDSCB2MiAw
LzNdIGkyYzogQWRkIFN0YXJmaXZlIEpIQjEwMCBJMkMgbWFzdGVyL3NsYXZlIHN1cHBvcnQNCj4g
DQo+IE9uIE1vbiwgSnVuIDA4LCAyMDI2IGF0IDA5OjQ4IEFNLCBMaWFuZmVuZyBPdXlhbmcgd3Jv
dGU6DQo+ID4gVGhhbmsgeW91IGZvciB5b3VyIGlkZWEuIEkgd2lsbCBtb2RpZnkgbXkgY29kZSBp
biB0aGlzIGRpcmVjdGlvbi4NCj4gDQo+IEhpIExpYW5mZW5nLA0KPiANCj4gSSB3YW50ZWQgdG8g
Y2hlY2sgaWYgdGhlcmUgaGFzIGJlZW4gYW55IHByb2dyZXNzIG9uIHRoaXMgcGF0Y2ggc2VyaWVz
LA0KPiBvciBpZiB5b3UgaGF2ZSBhIHRpbWVsaW5lIGZvciBwb3N0aW5nIGEgdjMgd2l0aCB0aGUg
cHJvcG9zZWQgcmVmYWN0b3JpbmcuDQo+IA0KPiBUaGFua3MsDQo+IFJpdHdpY2sNCg0KVGhhbmtz
IGZvciB5b3VyIGZvbGxvdy11cCBhbmQgZm9yIHlvdXIgcGF0aWVuY2Ugb24gdGhpcy4NCu+7vw0K
SSBhcG9sb2dpemUgZm9yIG5vdCBnZXR0aW5nIGJhY2sgdG8geW91IHNvb25lci4gDQpJIGhhdmUg
YWxyZWFkeSBzdGFydGVkIHRoZSBjaGFuZ2VzIHdlIGRpc2N1c3NlZCwgYnV0IHRoZSBwcm9ncmVz
cyANCmlzIHNsb3dlciB0aGFuIEkgb3JpZ2luYWxseSBwbGFubmVkLA0K77u/DQpiZWNhdXNlIEni
gJl2ZSBiZWVuIG9jY3VwaWVkIHdpdGggYSBudW1iZXIgb2YgdXJnZW50IGN1c3RvbWVyIGlzc3Vl
cyByZWNlbnRseSwgDQp3aGljaCBoYXMgbGVmdCBtZSBsZXNzIHRpbWUgdGhhbiBleHBlY3RlZCB0
byB3b3JrIG9uIHRoZSByZWZhY3RvcmluZy4gSeKAmW0gYWZyYWlkIEkgDQp3b27igJl0IGJlIGFi
bGUgdG8gcmV0dXJuIHRvIHRoZSByZWZhY3RvcmluZyB3b3JrIGZvciBhYm91dCB0aHJlZSBtb250
aHMuIEkgdW5kZXJzdGFuZCANCnRoaXMgaXMgYSBsb25nIGRlbGF5LCBhbmQgSeKAmW0gc29ycnkg
Zm9yIHRoZSBpbmNvbnZlbmllbmNlIGl0IG1heSBjYXVzZSB0byB5b3UgYW5kIHRoZSANCnVwc3Ry
ZWFtIHJldmlldyBwcm9jZXNzLiANCu+7vw0KSSBwbGFuIHRvIGNvbnRpbnVlIHdpdGggaXQgb25j
ZSBteSBzY2hlZHVsZSBmcmVlcyB1cC4gSeKAmWxsIGFsc28gZ2l2ZSB5b3UgYSBoZWFkcy11cCAN
CmJlZm9yZSBJIHN0YXJ0IHNvIHlvdSBrbm93IHRoZSB0aW1lbGluZSBpcyBhY3RpdmUgYWdhaW4u
DQrvu78NCkFnYWluLCBzb3JyeSBmb3IgdGhlIGRlbGF5LCBhbmQgdGhhbmsgeW91IGZvciB5b3Vy
IHVuZGVyc3RhbmRpbmcuDQrvu78NCkJlc3QgcmVnYXJkcywNCkxpYW5mZW5nDQrvu78NCg==
