Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022142.outbound.protection.outlook.com [40.107.75.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8520633262F;
	Wed, 18 Mar 2026 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814503; cv=fail; b=aXAK5rNGv6pLeG7iwQhJElm1abKr8FznnQSQfLVhJTfU5R3d3OOhuosu75Y0inqb/otmSsyHMWmX3Ssnz4PCH02afHgOfNXtU8oP5I6lpVYj7BTVak9+Ix94s/rWl9qa3pBE1H+lirhRc0CHCGTVywxeuoc9fb9rzYgJJIGZ+YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814503; c=relaxed/simple;
	bh=rasBWiqLY0JM5g+l1VdXLb9cNbAwC32ZclyCN46Jv4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iDFGatFacqZiepZgdgwGojTRnwLSmfUM9omx4/0UElJOkst5ptjUGkF6K/ZLkvLjANYzeJcgaZQ3YIg3enieytMxKcj+gaw5kAKpPnpjaFJbADj7JcN4IlSSxnNoLvS7Urzw7CbH0aV/lixM8yMXaA8AT9Vln+sK/c/koSYC0sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=czWm5j9x; arc=fail smtp.client-ip=40.107.75.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="czWm5j9x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBzubnv1R8k9L2g1hIdW8yXiiyhaY9OVRJjy24dUA6T4L/ilbf/+xVIIf3FQAHqYSN1IQgp5HhjCKSY8PIDv1DswNV6+o0BSidRuXhgNSbmCjzDZ1f1TLQTDRinb4VJ/mTjUlnXEor98c9vXC6gbaZL4fRVsHRC/iVBv3Y3qI0KUeAct31LA+0vXWQlNRhAg83+iS7ckEea+RlJiALPdzch5iANErV/QfjBxmPkWDsrWUKoA0bmPHXJszu16lU4EYNmgdErunajSjdHXN4NYaryR1l+yK6xpREfiz9yqjc27VWPoMEkH+qYIQ1XCnjIL42Nb6WmIHez0zrmezYTKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rasBWiqLY0JM5g+l1VdXLb9cNbAwC32ZclyCN46Jv4o=;
 b=uDRbk570onWFyvZWsBkMYQoIbBEDI+xUiyfZO+AY0VA4gad3Ci+OTpM+VKNWiKPOYzF+m+W+K5XAkfto9xa19QHuIynbwsiPfTpoG8zFQgC4rjtg+6ffsWapdVAdEGLbEyiLOerxnCmQcYuPwD5vPKAp7BSjSCjdsVbeNxPjRT9iw9lU0Tt1qzIwIb6MlCaWKB/7z0H1dJt19w5ICPpVNsrjRVyZqQvJm+7EWNujUnUht3K9Put2hC8DGdZLL6w9e9yGAYlFbd6qvz70xJytPhkUU2qxEMkIMikIPtb7z5oliovpRrLu4KLtxdCoOUHa9dGzSgPpawZstJm/mIHgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rasBWiqLY0JM5g+l1VdXLb9cNbAwC32ZclyCN46Jv4o=;
 b=czWm5j9x3GX131RqEH1+Ih/U5ZrRk4Fn/PXgB8UpwVbhcNqNsd7GEJVKrQXIY2ZmKyanjw0c0dgTJ2jIUkI/aBlTMNlSEiGwUvbbV0y9PgMtSNXQVmqnBz6eK4jvex33/r/wn1jDEM6j+w3HKIzM1g9J4cvnmLbNWr3SkObXBRZiFTh/Y5/BX4zsCeRzDTXkjDLbyHLEeG2UmCyxrCpuY2NlpfN7/eXsSyjwK9kg0ZeC+be3jcLT70d2THweogXS7oXYKZtpyjMJUoA1151T7d8R7BmuoE43FIH5Us9+webSJSZ4iZSEwOS0MSV5DMacLWME+hfzxgetzGbyoJVNUw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SI3PR06MB8706.apcprd06.prod.outlook.com (2603:1096:4:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:14:58 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Wed, 18 Mar 2026
 06:14:57 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Rob Herring <robh@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Topic: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Index:
 AQHcr5GE+hDVSyX/WkC7T78e6kO8trWtIRWAgAAQdrCAAz2mgIAA+smAgACHbICAAAQtoIABn/CAgAAK66CAABaQgIAAAQIAgAAlPQA=
Date: Wed, 18 Mar 2026 06:14:57 +0000
Message-ID:
 <TY2PPF5CB9A1BE6057839BCA0003DE7FC4EF24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
	 <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
	 <eeac1db0a5692ae45b5528a85ed1510b8b1cf771.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EAA73D3AD6F75F1ABD53F241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <071adc5f76b71b3e8d2691945e7b178602b285f9.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE67264C727ACBEBE4642C7F24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <d5ae7e63dd5a39ffa26002a3a5988eb0d74cb189.camel@codeconstruct.com.au>
 <20ed3dc6f6841435a2c9f8b3cc51a3ca12a9ce63.camel@codeconstruct.com.au>
In-Reply-To:
 <20ed3dc6f6841435a2c9f8b3cc51a3ca12a9ce63.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SI3PR06MB8706:EE_
x-ms-office365-filtering-correlation-id: 99edfacd-6487-4ef5-140a-08de84b5ae06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 OlWRJzlhsGeHMWyayu3u/klYhF1+2Tal95aPyG4vGfIKtg4EstHXgwCkwM9KT0iRDpDf3WgngSHujOBrV/MMFEJ0dAEDf6u8nACRgB1vOGeQ4pOLvc2PYBm/JUWrGsxkytSczxNsUXqaRzRDkgm7/NcHNrFQM/bAI7kiNxPI6lk/RmVPSz6u4qRUCDBLeGNigKf6btynA+xEOEkqcYyex5r+1J2z3xAnY7lfWKfBZMM2bqDUJMext/bn75OlgfSm+KLHuSWroblv6G1EnRdWezAYhPX3KbAyilklr4/rLxyeYIlgTW2+NBfn2/dZKJGVNtNmCwG/GQ/jTSX29smSLZGPAUS2qqB9e++4LTFtYNmhWiFLbClF0igRzn7TRAYCxzeTFEMAdTArXx9y/2G3u3unhSfLE6PoEUW4IPSt9DoZZuYv1VBU2hBSHV9Pl/Q4EHjXr8sHEZskHPrlnWnkWOeTXiZsuLQr5dTbEUid3oQPKFhnQsulytKKJzidAdM86zWCMFWxGMmg4oiC/yTnQFoWhsja+apQiq5/3onoTAxs5wW3xPFW5LApwLWq42uH3vm8QSkt1MqKy825bvvCz3X5cGsaqMImJcDMoDCB9SWAfO5ogK7p0NkPoHiYMSns+FLRLeAWUYLfdaIuoepNeuS7G4Y5+ELK3FtWxVYr7045JtN74bfr6tJ+NPzSkpLiL7VEQ3FETNLg/I/aEAcgU7u2FAHns4aWG1mLA0fn2+cFT3kuQfDJ2gOrvg6Qz/rntLc+36/Pt6C8/gv2zjG5wr8EKmC92nCH30a19BcB6GE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFFQcWlJTjZRZE9xL0pnZUFaVVlVSnJ2ZktkR082Z1pTeEJ6dHFJZzY1bTZE?=
 =?utf-8?B?bGs4SXFBODNjSWM2czVKWkpvWHg3RGJ0a1ZFcG8yVDRpS1BxK1owakxucGE5?=
 =?utf-8?B?YVNmYlZKN2tRVzNlZkJMZWdqMEs4bjQydFNmSHdHcDJCd3J5Y1U3NTljWU5D?=
 =?utf-8?B?bjdyM1VCcXlhRFdwY3VReXdqdUpWU2YxK05DMFNzb0F6dzhNRXdwMUlkeFNm?=
 =?utf-8?B?eUlJZ3ZxSDBnd2MxVXkzQXovMHo0MnhTZDZyWElTNXJIRU1ic1k2NHhFNnkw?=
 =?utf-8?B?MHlhTCtQa0xhTXZrNC9VY25ZbDdiM0ZNQ2FSaUZMY3hvSDBJcENzRmcrWVVn?=
 =?utf-8?B?emRwWi9WNTMvV0syTlRDVS9Sd29tSC9WWlBuMUQ1K1JjREE2NGtYancyUzk0?=
 =?utf-8?B?QmxYRTEwUlZYc0Irdmh3YVRLRlgzOWRhaHhNRThzSkErK3B1UVZZK2JYOFN2?=
 =?utf-8?B?RjBDbTBOQzQyWk1XVzJrUHZQT3g5a2VkTjZDQThiaHR2K2FmbnRFNnBCVm9P?=
 =?utf-8?B?NE1ncnNVd2pqU0w5R1gzUEtzV2pUd1VyM1luUHhPR2VXd2JJbFJSalZvNEU5?=
 =?utf-8?B?R2RjV2dSSzEyY21Bb1JBclZKQnM2VkxLWkpmWGFQeGxyMlhZWmt0eEgvYmFm?=
 =?utf-8?B?WGF2MzNNeHJYRnptRXlSdnUrZldKQXhnRTlZcWxrTmVaVnZDVFliTkl5S2M0?=
 =?utf-8?B?bWpHL2NaT3plakNOMmtJbFU4elVJNVZLYjNQR1RpcmI4SVFwWnlBL1V0ekZT?=
 =?utf-8?B?ejNkbTZyMDdWNkJBdWZKR0hZTWdiemYvb3U0UXB3R3dpZkJCc0ZGY0hJOHVQ?=
 =?utf-8?B?NllpS01CcmNFdktUbjdPTjlzakVFaDdUM3l4U21MamFSa3NXRXZONTkwbUYy?=
 =?utf-8?B?czdxaFRaRXpOM3lvbnpONE4rbURMckc4aHhGZVdFL1o3ZUJKNllkZVZmdW5L?=
 =?utf-8?B?anBmMTlyQW5FWVJpeG1ZQkpwUVhQQ3hGRk5TTGdNQ0lIUTdKSmlrTVlRQjRz?=
 =?utf-8?B?SjV2TVljdVFCUVkvNmhlVFlPaUJZN2gwM1U2UWRHeEMvNWU5TmhZOGRMbUhK?=
 =?utf-8?B?czhOcWQxVitneUxpK2IyYnkyRnVOaFg2djV1R1ZUWlpmSTZLUzNKT2E1TUJl?=
 =?utf-8?B?QTFOWmgvcVNYclBSWFJ2SXoxYXZEZDNwNUdwUEdxMHhjSHpyNHI4SFNJOURJ?=
 =?utf-8?B?Sml5U2tFR0IrQTAweHFIdnRsVS92ays3MTZnbWFySk1PSllwL2ZTVXIrNXVW?=
 =?utf-8?B?T0hyRlZlVGg0U0tSU0VreEZFcm9DQ21tWGFTdE1hWEF5S05iaU1IT2JJOTZ0?=
 =?utf-8?B?M2U1NmFHSWFlNlVYMXJ3REtkOVJEZ0UvRWJaYjVMS041dVU1ZXVXSittOXBZ?=
 =?utf-8?B?dGs3d25NaU91UGNNdkFlc1kzdGkwWjhkaHhxbjA0eDc2TjdOUkpkQmllYUZM?=
 =?utf-8?B?Y0ZrUzZCbWF3UUxiSlZDRVFHV0NyVjJweXRSSWZJTWlKSDIxemxneDlmcTdn?=
 =?utf-8?B?aUJnbnNYbTJLOVlxbm1kS1h6VVpETzhkbjM1M0hpZXR1bHdHTENBVDZUM0dQ?=
 =?utf-8?B?ZmMyT3cyN2MrMTlWcmVFTStTWjNKWTZFNFRRcFhZS3poRlVQY3VtTTEycUE0?=
 =?utf-8?B?YStxbmliUFJjaEx0b3ZxMlpuN3dabnVpOUxPQVJJcS9ZRG53dlpwR0Z5YXY5?=
 =?utf-8?B?SUFmdW4vejR4UXVkb3hqZGJicjJRZkN4bVk5UFI5SWJFU1FmWUhnaXY4ZDZs?=
 =?utf-8?B?ME1ybE1Qc3E4VGpHeGtRRTNsTmxxUk01WVZuME84OC9hYld1L2xKNWY5Q0Vs?=
 =?utf-8?B?TytTMTZmeHVOQXUrM05oRC9lbUdkQ2FucUVkcU9BbmhkYlNYSEMrdmVBZUlq?=
 =?utf-8?B?SUp3ZHdpZUpwTjNRY1lGbWRKQytKZ1RxQzA3UTNyMVk1b0Jkd0c0aHVDOTJ1?=
 =?utf-8?B?S1grRm51a1ZTRlhyc3FCYVpEd1pWWGZQejhtYTE0eVhKNnNBeVpueEdjZnJF?=
 =?utf-8?B?WEppcXBXSkNvU3Fhai9yekdoRlgvSi9HaFNEM3JvMnkvTHpqU2JwTEtkUFZM?=
 =?utf-8?B?S3RBOVZrN0xodEhIMVYzNXljZ0gzQUtFa0pnMFVJZzF2b0N4TGFibjBPR2Jv?=
 =?utf-8?B?dXo5QjJpMFkzMUZEM25RbHJRZFFGNFhNYVJyZ21ERFl0TWluT09Jb2xoYW5W?=
 =?utf-8?B?Q1QyeUJxRkJYVncyZlEvOVpyYmU3SkhRTUlndHRqeWh1NDQxRHRlMmJUakJr?=
 =?utf-8?B?VmlldHhLNFU4WmkwdE03SzhVZTF6TUUzOUhKSjRuSUdmZmszL05IQmo3RHFK?=
 =?utf-8?B?b2dMK2RKQnFHTlRDeDhIcUdkNXFrWlhTMHRmaXZMZDNjMXFva3ZYUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99edfacd-6487-4ef5-140a-08de84b5ae06
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 06:14:57.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuCeCC4caEchBmeKMJr2H4xuud7lrRrZZAQoNaQyl2EWyxW/2dr8TDKJkvoePNBv5gNEIHUMcIKF+GLeQ4HJh7L9UpSBslNgRexb3ycdmic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8706

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyNiAyLzRdIGR0LWJpbmRpbmdzOiBpMmM6IGFzdDI2MDAt
aTJjLnlhbWw6IEFkZCBnbG9iYWwtcmVncw0KPiBhbmQgdHJhbnNmZXItbW9kZSBwcm9wZXJ0aWVz
DQo+IA0KPiBIaSBSeWFuLA0KPiANCj4gPiA+IERvIHlvdSBtZWFuIHN5c2ZzIHNlbGVjdCBzdXBw
b3J0IG1vZGUgc2VsZWN0aW9uKGJ5dGUsIGJ1ZmZlciwgZG1hKQ0KPiA+ID4gT3IganVzdCBmb3Jj
ZSBieXRlIG1vZGU/DQo+ID4NCj4gPiBJIHdvdWxkIHRoaW5rIHRoYXQgdGhlIGJlc3QgYXBwcm9h
Y2ggd291bGQgYmUgYSBtZWNoYW5pc20gdG8gc3BlY2lmeQ0KPiA+IHRoZSBtb2RlIC0gZWl0aGVy
IGJ5dGUsIGJ1ZmZlciwgb3IgRE1BIC0gaWYgRE1BIGlzIGluZGljYXRlZCBhcw0KPiA+IGF2YWls
YWJsZSB0byB0aGUgY29udHJvbGxlci4NCj4gDQo+IC4uLiB3aXRoIGEgc2Vuc2libGUgZGVmYXVs
dCBtb2RlIChETUEgaWYgaXQgaXMgYXZhaWxhYmxlLCBidWZmZXIgaWYgbm90KS4NCj4gDQo+IEJ1
dCBub25lIG9mIHRoYXQgbG9naWMgcmVsYXRlcyB0byB0aGUgYmluZGluZywgaXQncyBhbGwgZHJp
dmVyIGltcGxlbWVudGF0aW9uDQo+IGRldGFpbC4NCg0KSSB3aWxsIGFkZCBuZXcgZG1hX2F2YWls
YWJsZSBpbiBzdHJ1Y3QgYXN0MjYwMF9pMmNfYnVzLCBhbGlnbiB3aXRoIGRtYSBwcm9wZXJ0eS4N
CmkyY19idXMtPmRtYV9hdmFpbGFibGUgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwg
ImFzcGVlZCxlbmFibGUtZG1hIik7DQpBbmQgYWRkIHN5c2ZzIGZvciB4ZmVyX21vZGUgDQpzdGF0
aWMgc3NpemVfdCB4ZmVyX21vZGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQpzdGF0aWMgc3NpemVfdCB4ZmVyX21vZGVf
c3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KCQkJICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLA0KCQkJICAgICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQ0K
