Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010007.outbound.protection.outlook.com [52.103.73.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65659439F74
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814040; cv=fail; b=BJql7ah3egpnj7al+j4Bx1keg3MWxcls1v5FCzBOdXtC/+WiSC0Uy1AJjjphbD/ybq3QQZLu1mzcw5bcmfOsYBNx18aFC+AAMlcboqSVYNZbYHAi7FzwScYR+p4/KmTVwK7l25r0NpxFgrarENje8PnTGTM9CKxsoWLblKgiz/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814040; c=relaxed/simple;
	bh=TAGxOI9lIdX+OdaAPkD5KZQ99zxFTyMaNIITjr0uTPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jn+IbCaeEw9lLYaVdZUAUe59aMy5creBHSpYi8U3otbmnUf7v87ZvUhwsEAUnB/QB98TQINM6Q4gjXzHTEx8Amyh3Sdxlu3hZVQ3GI14rqhqWv7WKl94PUtZ4svoHN4UPYJHDgmrwSrQVmvrSJuBkdR45/XR6EyylewCeLKqlb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=CXfBOnLe; arc=fail smtp.client-ip=52.103.73.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="CXfBOnLe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlWxOpaLra+xeCA8wnB6TE8CI+yNgCtlsax4zqZpltcQhFtAt0KDRDWFM5TamxTTIqRS5k4B6XAoxb1ApWdB8HR33hjJVZGuhDx9SEmvtGFh3VC4JHwCDks9yCM8pvMUlS3ny98W++KHUsnTdhE8h0mSVTpRUhjE7qUWNilwOajCPYrfZ1V8wCIieNP31+fxZPbnmBqK94FCU2mLhpTS1kEuQnfFngAZ/VS6u74B94GpmpDC2QISdHoWUoB0c18NPTnsgiUvG89Mtut0LfEiPW2glVaFwb3hSOKGxKqyBXxfLc5BQz1U4wgv7G45k6o+14R+w/WzVK6MjBC7OfArEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAGxOI9lIdX+OdaAPkD5KZQ99zxFTyMaNIITjr0uTPQ=;
 b=qTgKDrS8g3LstsFaHQwjAH1BfgZvr/UiwzrC95YcAdVTGw4AMDNnDZYw4UWbYvwh1e8zF4fRsrzotgpS1fZ+qO2j5UiAM/cR4PdFoxuUWTKcidQQQDCQhrYBFFvq7OUjx23VcNPR/oYFEUBa57B+n7IXrsvH/BxDMzzgNWkxJ/yLu1o+IbDP1x+ahBDgkClYrCkAp00JHvWP7TSb5xJDxc4CUiAZ7iowK5HIDw0oiRfiahonwKWwEM5eDdti1zeJTZyV3Fg9EJu66c9aq8Vzs6EbJFriGq3zrV4/rzd7wDZ90Sl+/EMVVwFM26h1YxVSjj8zerDiTY5QkkEWp5JRYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAGxOI9lIdX+OdaAPkD5KZQ99zxFTyMaNIITjr0uTPQ=;
 b=CXfBOnLefLN88UrAcrWhSVho75Nb9sOlVVa/78ueDz9nZaqPXDwvX/qbUOhsk1EWYgJnNX2JX455JAaNTYYUIvf4X1OkoDPsKmLUUxnqhaUB9bvUiwnxKzqH/VW95Q92+LGZW2kq8+tqiDCidja2ougx+QbkfiQKlcjIa+zYSG6bSZsP4EEy0F71FpLMtk9FJUA1nPmtg1lxHhKerGlR9MSDgZYECjo3YCo+Z/Y/uQR1YuHCCPoWeq6iWTmMP4tXQE2m6dGAubyLExXrJln4eePT/SCH4SyBcRdk01NY03Hs570mYNJyl8B6JBAjHndA9qaP3OuTO0jg5WKTLNuskw==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by MEYPR01MB7183.ausprd01.prod.outlook.com (2603:10c6:220:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:40:15 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:40:15 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare
	<jdelvare@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>, Guenter Roeck
	<linux@roeck-us.net>, Kamil Aronowski <kamil.aronowski@3mdeb.com>, Darsey
 Litzenberger <dlitz@dlitz.net>, Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH i2c-tools v4 6/8] decode-dimms: Add second level separator
Thread-Topic: [PATCH i2c-tools v4 6/8] decode-dimms: Add second level
 separator
Thread-Index: AQHdGqjLs535V6qGLEaPHYsnNLxeXQ==
Date: Thu, 23 Jul 2026 13:40:15 +0000
Message-ID: <20260723-ddr5-v4-6-d7cf78ebbbaf@outlook.com.au>
References: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
In-Reply-To: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|MEYPR01MB7183:EE_
x-ms-office365-filtering-correlation-id: 5ccbd7b9-9b40-4160-53d0-08dee8bfed95
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|38102599003|15080799012|37011999003|25010399006|41001999006|24021099003|8060799015|31061999003|19110799012|8062599012|440099028|3412199025|102099032|3071699003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjJmSlhBTWpuUHd1SE03aXFwcmxTMjZHMGljaVRWV0lwZXV5TDFTUWljK2dH?=
 =?utf-8?B?by9qZFBpbEV2ZGpkbFBBUVkzZnNMbWpFaCtnUDVFOXR4cWYvRVNNQkJnWVY0?=
 =?utf-8?B?UHlmU3NhQlNCcTl4dmd5WXlZaFlOTWxRNWh4N2g5RlFacXhwZXg5clFObnFk?=
 =?utf-8?B?QnkrSnVUcGkvekFSeU1STW9NakpocE1vajdEaW5uQmRzdDRFamorckxnb1hQ?=
 =?utf-8?B?K2Y0TkhrcXNpR3c1bzQ0bWNSR0orOWNDbWRTaGhZUE4xeUhGT3RqT0RSLzVp?=
 =?utf-8?B?NkR2bmY1YUtrOGxnYmUwalV1RzJHbHJhTVpiN3RiMWRSR1U1OENnRDhNNWdK?=
 =?utf-8?B?QjR0MWhxdTF4bHBYcTdyM0EycytSVUIrOUx2cUE5SGhpU2taWTVESFpvNmI0?=
 =?utf-8?B?SmlSbXMzb0JLSDJPQU5WaXVTN2dsYXVUVU0zTmZXa0JRby9IUjJ4eFZuTzU2?=
 =?utf-8?B?ODliMnBZQW5ZaG1CV3Iza0RrS2h6QzRCeEJnL1JrUFV3TEM3M0lJbTdGdHZP?=
 =?utf-8?B?Q1EvWU9rZ0xSYUVMREdVYnVYVi9oL0ozdyt1Qnp3Zmh2elB2bm8xTHRweFRp?=
 =?utf-8?B?cGlCNmUrQTdxaCtqOEpBY2dJL0RxYkxFTjNXL3pQajlOK3R2cUgwM0QzNjA4?=
 =?utf-8?B?WW9yVFJUdksvYm9QeExRekF2aWpocXBnKytvMG9mVTdGRE9TQUNYYkFNVlk5?=
 =?utf-8?B?MEFudWZDTWJBZTR4ZnF6UWpUTnEzeEUxN255ZHd4VFFsSXZHZlJidklhMjIz?=
 =?utf-8?B?cU1lcWc3OWJTeW9IU1FtQkZhaGtJUThHaFNzK3JwbnZHSHZOTmRSMXVVc1VZ?=
 =?utf-8?B?OXpQT1Q5NXJSREl0WmpIMXVrUStnYldMSS9EbG9WV0tud3o3SGtwM1YzcjA2?=
 =?utf-8?B?Y1Jmc3ZtQTlpa3pvTUVjWW5hN1IrN056ejRJbmt2bzcvV1RFZm1RV0tKa2ww?=
 =?utf-8?B?SFNncEhMV0Z3ZHE3TGp0S004Tlo3L2lkSjlHejYybCtvbEhodWMycEtrZTBD?=
 =?utf-8?B?b0ZPNnVJQUhZMXhRN0owU01CdFBUdXcyU2NtQk85RDhYRnRYOCtkQ0NIVEdU?=
 =?utf-8?B?d2dIQy9pNlo0RG1Yc1FhS0lFOVhaRkdPZmNPQkJYLzZTSDNWYkZoMXBqSUR1?=
 =?utf-8?B?eDR1YmdHQ0lSb1pjV2w2aHZPQ2N5dUE5ZHh0cTVnTVNjWkFtMUZYbVhENlh3?=
 =?utf-8?B?UzFLYk5QUnNuQVJVcFdiQTBVS0RScE12STRlZGJ0NERTL3pvK282RjJibDRn?=
 =?utf-8?B?TUUxQk8wdW5KMkIya2Q1eC9jREtwdW5VM0xKSXh3b3EvZ3FsYk5OSTZZNlRU?=
 =?utf-8?B?QkpSeENaRU1JMDZNTGk2RUxTTXdBeDBNbG9WRDdmNE8rck5Dd0QxVXNJUThy?=
 =?utf-8?B?QUFVVVE4USsvMUtzbjE3OUN2ZVlJR1lVNHFpdWY3ZUN2TDJrc1pLZWMwSVJR?=
 =?utf-8?Q?hPLjvcgZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnpJNG5RZDJHenhBNXFabno2SFlZSGc3YW4vc1graWxXSTJxMkk1eDVEV3RT?=
 =?utf-8?B?YzVBSmMwWjl0cnJlbm5naEpEL2lSMHZ5aEE3cTZTQktIMFRra2dQclE4R0ZP?=
 =?utf-8?B?SUxyL09RUVl1TDJabVlMNmgzWjVod0JhbzFJdndJeHk2c01KUzR4d3pxTlNY?=
 =?utf-8?B?OVc4WFJOdUFaei90UkVBWmFSTU1WVDhLSlNTaFdqR0NVSHhqTWVKeGhYYzQx?=
 =?utf-8?B?cG1KWHhJd05LQUg1aUk0U2tKRm43dkNZNHcvSjVZQVBaSnlJeitRdWtUOFgv?=
 =?utf-8?B?NHpQZy9mMHp4ci9ldGxzK3A0YUp3MEwxM2pLdmtOVjFGc012NEswZ1R1bDZI?=
 =?utf-8?B?NDlGa1RFRk1CTExUaGNrVnp1TXBhOXFtMEpOWkVQd1J1aWdiWk9CaEZROUpD?=
 =?utf-8?B?dk8xRFQva1g3TE9iaEl6NGpmMnpVTlNwWHBnTi94dGwyYTM4VE9pdU5iTm0z?=
 =?utf-8?B?YVU1VFROVlZCb0xpZEFmdVJ2TkJHaHVzeXFTaDNhSVh3ZWpyVTNjY0pETnRS?=
 =?utf-8?B?ZHNaRmxCM0J1SU85cDlyRTl1UFp6Tzl5b0U3dDZoTUgwcjVXZFBXVmF1NUVZ?=
 =?utf-8?B?YXF0bDd0d3hpS3o3S016akcrMnMwOEFGcXZpM0xsYmVWNWxCMnV6bTAyZCty?=
 =?utf-8?B?M0JuaGtSd1hheFFCc1U1RmtOZ0NSZzJPRlMwVFZ2OXZ2dmFnY1dkSEtzazdJ?=
 =?utf-8?B?dEFlU1pHK0ZXcTNZQ3c0V2RlV2NxVmxBcHArTHdVaGkzVGZQUnN2SHNtK0V5?=
 =?utf-8?B?WDhPbDVvQzdWeFp4dTRzWWkySko4TmJSbm85T1BweVlCaDF0MFlJVVhFYm5T?=
 =?utf-8?B?ekN4Qzc2eW9hSHRvc0tNeDBzYkxuTlhsZWxwTDNYUW1zRDFFRTNQamxQNzlj?=
 =?utf-8?B?a05pblF6emtVWWV6ZThTTGJtaFk1TGNOQkpGaGZTd25zT2x3bXU2U3Zyc1ZU?=
 =?utf-8?B?T2tFU2Z5aGU0KzVmWTFHM1l4Nmc0OGYxZlJYaDFRWnlXc1RwL05BWjg1MGNo?=
 =?utf-8?B?SDhITks0NWVBQnAwQ1d4dlNFUkoxYjY4SHlxOXVXOVo0eThvRmV5OFV6dVVx?=
 =?utf-8?B?YmFVWDFXdVJHRzVQR05zNTFOMjV5UjFRQTRnekd0RHBPd1VIS0RwZlR0bU1q?=
 =?utf-8?B?b242WTlMd0JNMk16VTMxOHVaeTJJK1FIK1MwVW81eGVDSldMemM5Q2UzUisz?=
 =?utf-8?B?SzU3M21XR0dNWC9SVDVNMWNoWDZIRzdXaTdWK1I4SGYrRWRXVHlrSG0wbE5M?=
 =?utf-8?B?R1FpN0hIVVMyKzVxb2ZwYUlEd1dib0txQ29rZUFZanJnMWhQSjdUM2NjYndE?=
 =?utf-8?B?aXU5S1ZzaTNUMEl1NE03NklnYy9rTk5GdndVaG9Yc3NyZVBFNmQ4SDNSYXNY?=
 =?utf-8?B?Vnd1RDVjcDJYTkh1SEliLzBRTUFaSGpPL215eUZrcVlLbzREZlluWS9KeEdq?=
 =?utf-8?B?anFqSGlERjg2emtwbGtaU3RrQ0V5TTFyVXcvYUJqTFBSbXpuUHBzVTZ1c0xS?=
 =?utf-8?B?bWlpUGhqMk4zYktEVlRiT0NpQ3VyakxqaVlqVVZRaEdsOFVXWjhPMU9Qa05k?=
 =?utf-8?B?V1FnYXdwR2s0aWtFbHFxWlpucWFJZjc1RUc2ZlJOdk55YmZONjNGVG16bVJa?=
 =?utf-8?B?cXkveVd6ZzREOXpTRi9GNDNCcDhRVElTZmZJMjZ3d2ljTjdaa0ljbVVMMHBB?=
 =?utf-8?B?dzdBTkdMMDRpdythMTBSd2NDWWlwMzB0NFhTWE5Ub2ZrT1QyajYvYlY2RHhM?=
 =?utf-8?B?dWR6WUlvTEdpVzA2V1dMdmRvMnFNZE1jZHJBZXQ3UFFjSmhtNkVoUjNaU1N2?=
 =?utf-8?B?b3VTZmlXNUl6RTlWTFRIRHpheXRMa29YUm9kclpUOW5IeEhtcHpjZHBiS3VT?=
 =?utf-8?Q?FDrFpoWQytRyn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <100EFF627569744AA843267A6C983BD2@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccbd7b9-9b40-4160-53d0-08dee8bfed95
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 13:40:15.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB7183

QWRkcyBgcHJpbnRzMmAgZm9yIGEgc2Vjb25kIGxldmVsIG9mIHNlcGFyYXRpb24gdXNlZnVsIGZv
ciBsaXN0aW5nCnN1YnNlY3Rpb25zIGZvciBYTVAgJiBFWFBPIHByb2ZpbGVzLCBvciBlcnJvciBs
b2cgZW50cmllcy4KClNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gSG9ydmF0aCA8cy5ob3J2YXRoQG91
dGxvb2suY29tLmF1PgotLS0KIGVlcHJvbS9kZWNvZGUtZGltbXMgfCAxOCArKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZWVw
cm9tL2RlY29kZS1kaW1tcyBiL2VlcHJvbS9kZWNvZGUtZGltbXMKaW5kZXggN2Y1MTY0Mi4uN2I4
ZGJiOCAxMDA3NTUKLS0tIGEvZWVwcm9tL2RlY29kZS1kaW1tcworKysgYi9lZXByb20vZGVjb2Rl
LWRpbW1zCkBAIC03MTIsNiArNzEyLDE4IEBAIHN1YiByZWFsX3ByaW50cygkKSAjIHByaW50IHNl
cGFyYXRvciB3LyBnaXZlbiB0ZXh0CiAJfQogfQogCitzdWIgcmVhbF9wcmludHMyKCQpICMgcHJp
bnQgc2Vjb25kIGxldmVsIHNlcGFyYXRvciB3LyBnaXZlbiB0ZXh0Cit7CisJbXkgKCRsYWJlbCwg
JG5jb2wpID0gQF87CisJJG5jb2wgPSAxIHVubGVzcyAkbmNvbDsKKwlpZiAoJG9wdF9odG1sKSB7
CisJCSRsYWJlbCA9IGh0bWxfZW5jb2RlKCRsYWJlbCk7CisJCXByaW50ICI8dHI+PHRkIHN0eWxl
PVwiZm9udC13ZWlnaHQ6IG5vcm1hbDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGNvbHNwYW49XCIi
LigxKyRuY29sKS4iXCI+JGxhYmVsPC90ZD48L3RyPlxuIjsKKwl9IGVsc2UgeworCQlwcmludCAi
XG4tLT09ICRsYWJlbCA9PS0tXG4iOworCX0KK30KKwogc3ViIHByaW50aCgkJCkgIyBwcmludCBo
ZWFkZXIgdy8gZ2l2ZW4gdGV4dAogewogCW15ICgkaGVhZGVyLCAkc3ViKSA9IEBfOwpAQCAtNzU5
LDYgKzc3MSwxMiBAQCBzdWIgcHJpbnRzKCQpICMgcHJpbnQgc2VwYXJhdG9yIHcvIGdpdmVuIHRl
eHQKIAlwdXNoIEB7JGRpbW1bJGN1cnJlbnRdLT57b3V0cHV0fX0sIFxAb3V0cHV0OwogfQogCitz
dWIgcHJpbnRzMigkKSAjIHByaW50IHNlY29uZCBsZXZlbCBzZXBhcmF0b3Igdy8gZ2l2ZW4gdGV4
dAoreworCW15IEBvdXRwdXQgPSAoXCZyZWFsX3ByaW50czIsIEBfKTsKKwlwdXNoIEB7JGRpbW1b
JGN1cnJlbnRdLT57b3V0cHV0fX0sIFxAb3V0cHV0OworfQorCiAjIEhlbHBlciBmdW5jdGlvbnMK
IAogc3ViIHRuczEoJCkgIyBwcmludCBhIHRpbWUgaW4gbnMsIHdpdGggMSBkZWNpbWFsIGRpZ2l0
CgotLSAKMi41My4wCgo=
