Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012071.outbound.protection.outlook.com [52.103.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC7374A1B
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814038; cv=fail; b=I5AE5wKF9aXF2bynER+bUWT/jVX5mYOAiTOWXtsuoJIE9ugz4l8dHFGbOZJo24J0kfqKFl3Qj+7Ffl9ArRlRfjMXsGsJb96QpjOEp9JIe720ENCs/HYxJXi8E3X5PhCInslpA4/ckCVMrxOu5eBCAxOIAbiOl42ukeDfumFYGWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814038; c=relaxed/simple;
	bh=5sF3Smp/ogYgnwkRnbW0BAMKQFkO2AmOXSsMODMcE9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aPK67RLYfeYGvGvTw6sJwjvpP32yaARC/67Ea3lVIexDTQLLxrW3AZTrv8jkATHlwE58fI/TwxuEj4MCexfF3Q9bv3Ga7K1RNrT1WrGSHuXMySOpOpOu3NhMSSVlYVA/7kNBhnbppW68dRQwlTptrIjlOjTyUWXXZh9TTL2oltE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=B65WMkfJ; arc=fail smtp.client-ip=52.103.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="B65WMkfJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNpHW89JXs7V9xHALOcAICLqDuvN4Guw307Z6Nv/5zeYciuUvEnnbWu+CDGWqcQU8c/u9sGcDy8bL+uxuinrpfVWfiU+d9bFG9nr3JfLDocw8ra638swnm5iOTZVfHqWSpeQBbmPCXVMMcNqyP7VuuRslsBeWv+zZ1nH0h3E3QbVr0qtQBKuTbm7YLhkG26nHFNBVSjbT4GSnJtVlvwQJ8x6OSg1cwzPnncHzW8W/8zB5G5SFwqd84quZSbe60dMch2n0aVWFLiXumw4c4FytS05F+64ZVAS9Qd7FxkCZir4D7haC6Y9iFWDxFsuIH6z/mn3F4EY1gmKT5nh0AwEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sF3Smp/ogYgnwkRnbW0BAMKQFkO2AmOXSsMODMcE9g=;
 b=UF+P2OLa/ILAbLPMZo5mkyva6lMTgJFtDWsb8Ei3EMwHHxugMSJ8lSj/AAXTvrRmoZ37HOqHIAibktHLoXQLkAG3H62BU2tjT0X6nTxDSJ/DMtVInbE+TWkp3KdhUldY+8kdjCXX1xGqwx8thqG7vm6unYcCmSZ5LfOsaAjAVCnv/GT7Urg+i4LlsWEGyIsQzcsGy3/1l3FhpCGNNBnUNGAxpvFE+/2L3+K5bHP4O01XGOPcp0Ktn7fdFh/2YEB2ClxolZYKIXefPlzJGroHhRkL58hvpwUKepjlDTVNmpHptGP0dvfBtZAbNyAYmNS/MrjAvjCu1p4Ce+HrfizVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sF3Smp/ogYgnwkRnbW0BAMKQFkO2AmOXSsMODMcE9g=;
 b=B65WMkfJ7jtZnYSwD9KTHdAfxwGQbJ+CDtAcyhXNSiXGHhYet3ssc6Y5obJQ0Nwtjk3cfwdfXJOdNpekPg1DldcNEOiQ4bDcUrEIz4b6005hGynwyzRNxQ+4N1wviNvokJaM2Hk5Cd+3vZiQE9ko0/aZcLOX3ivE6a8vYgK0wppcOIzbqFYx0M5nRprX5eUD38SObinSBixsrdOZCcB6TR5ls8IYgYkUClD9iF7xsRkc0ehsBFJV5E1fBNEeTwAiTk7COiqXFsjgKVLDXvKT7yorBARO02ATw+tOdIkPSdltCCQLIfS3ufB5XbsKiLxTswnFD0PAZKuS2AIUJWhrXg==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by MEYPR01MB7183.ausprd01.prod.outlook.com (2603:10c6:220:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:40:14 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:40:14 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare
	<jdelvare@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>, Guenter Roeck
	<linux@roeck-us.net>, Kamil Aronowski <kamil.aronowski@3mdeb.com>, Darsey
 Litzenberger <dlitz@dlitz.net>, Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH i2c-tools v4 5/8] decode-dimms: Add basic decoding of type
 specific information for DDR5
Thread-Topic: [PATCH i2c-tools v4 5/8] decode-dimms: Add basic decoding of
 type specific information for DDR5
Thread-Index: AQHdGqjK2EQ5lg4Gy0OODawAFs7Y0w==
Date: Thu, 23 Jul 2026 13:40:14 +0000
Message-ID: <20260723-ddr5-v4-5-d7cf78ebbbaf@outlook.com.au>
References: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
In-Reply-To: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|MEYPR01MB7183:EE_
x-ms-office365-filtering-correlation-id: a18f24f9-c50f-438e-ef58-08dee8bfed37
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|38102599003|15080799012|37011999003|25010399006|24021099003|8060799015|31061999003|19110799012|8062599012|440099028|3412199025|102099032|3071699003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEUvOURSQUlWT0EvcG9ydkJycVVRUC9BRkdpRklIS2dJQjAzN253TThUMzZV?=
 =?utf-8?B?M2NJZmdFRm1KT296K1QzcGFSQlg0S1FBZlRRM0U5bXpxd1FSL0l6Q1ZuekNT?=
 =?utf-8?B?QzdGL0RTTXNuZkV3UDBnSzRSUzRtQ1ZZR0tNc3RUamRLM1RBbUkvUWRhOHU1?=
 =?utf-8?B?elFzZzNIVWZjblFkRC9FS2sxbS95Tjh5bVNONzlCakxnNEpRU294OFc2L09j?=
 =?utf-8?B?WGk2TEhhZFhJWnNlRCtNMXJiaTBGQ3dPa0NFOU5palBzZmdweHRaUWllRG1x?=
 =?utf-8?B?YzE4NGhneVMzMVJPbEtWSVpZTFZtaFYvYmFVeDNFTitiT1RmMjVwYnBrSFN6?=
 =?utf-8?B?Ly9WTnVwQWtBbDRUMTljM1B0TnVTNStNZTdwV01Zak1jR01rOGQvdFE4UXBi?=
 =?utf-8?B?UndkZlozTHgyV0F4c2hiN1FNcWt6dGdSR0dMbmtteUtvTW1RQUhCSTZMMHZq?=
 =?utf-8?B?RW8zMktiOTVtUTJpeEJJTTFlNWxaSmxwMDB1YTRUNzJWMkUydEtoeUl0RjRw?=
 =?utf-8?B?cC81a0crMVJSV3Ywd3NaWUhPU2tUbTRncGZ1VmFVQy9TMmdwcVA5MWFSZHlZ?=
 =?utf-8?B?OFR4eUFnYnE0MkNHMTlvR1lkK2h2Mk5INUR6YUtSbkhMejgxTm8rLzlXNThF?=
 =?utf-8?B?cGRkVDVPbUQ4RW5VMm4rbGd0NEtvNm9qMkVvSzM2TGdMMVJKS2Q5MXBkY3ZP?=
 =?utf-8?B?aXd5bzM0alAxdG9sd2RlMHR0WW02S01WUjQ4UTZnemZQVGhya3VIeE0yUFpl?=
 =?utf-8?B?RUV3OTNGTDAxRGkrYzdDU2l5RDVmMlFLa1dYZCsxaEQ0NTBFYUczSlJYVjlp?=
 =?utf-8?B?bGxyVGF3S2Mwa2FYTFlkK1N4R1FzWFFQZW5nWVQ0aUowMGRXRUU4aDVCSUpK?=
 =?utf-8?B?ZmtjMUNsKzREY3hmUGVTQk1YM2tXMURvMks2NVI2VXkxSnFqSzFnS2N6Z0h1?=
 =?utf-8?B?MzMrWjN4UkgyOEFlU0pwTmtzVkkzaXBNakdyd0NLWm51Q2l0YkMxajdYd0o5?=
 =?utf-8?B?L1V3YnpoVGV2S1hFbFJKbklDMkhFUmFYdXJjeW9id3o2a1d4U20xNjNLb09K?=
 =?utf-8?B?b211YnpocGxwS3k3R0xnZmNiQ1pjNmY0M0lQOXp0TXQwSCtSVVZjUjI1d244?=
 =?utf-8?B?UmpjbVh4R0x3TkhIYzYyb3VmMDNnTmtISzFzWTZSK3FCM2plM2puT0JIcHBY?=
 =?utf-8?B?SFIrQURjWitSMHdZMFZIRHdERVUxaElJaTM2Y1krNEpqbW5SaXBjMXJxUGxR?=
 =?utf-8?B?WWJIMTY3UlJxLzM2VnYwR2ZqaWNtSlgvczZlVjFuZ1hiOGY5OFdpcmNWU2NJ?=
 =?utf-8?B?VWxnT1lBYStnUVBGcm41c2N1VWJOdjZ2NmJMSGZHTG9YdmhONlk1TmxhMUxn?=
 =?utf-8?B?WHlOQTRiT2gvMHc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFBiOG1HVHN5WHFnSzhibDFmT3YxQTk1UVpxWXJEd0gwVzcycGV0WUQzQ1ZU?=
 =?utf-8?B?amh6WWpKMTlDV2xMUHRRQitRdjJqSXJVc3JSNElaM3dKNmtoZlpxWHdOY2ZH?=
 =?utf-8?B?djhzT2E4QkZJNVZmenkxcDREUEtPY2hCV0FLN3RYdm9yYkVRMWY5dG9nVG9N?=
 =?utf-8?B?NnFSVjlscGtZWmt2SkV5OWZOcWpQSVVDMjl0Z1g5MDN1YjZ6cEE5djdwaEEv?=
 =?utf-8?B?L1BMYllaOTM1VVRDK3FvWXJPRzBXUnYxa3dGN3FiaWh3MHFnQmRSVHo0elZZ?=
 =?utf-8?B?TnI4eXBGMHdpenVKMmM3b1hDRFppYy8wTm9XSXRHRDFVVDFvVzhsSkEzejho?=
 =?utf-8?B?eWJYQjVPOGR1d3B0Zzc1UnczODFTT0ZtTkJGbURxdjRUdVRBUVBFUkU5NFo4?=
 =?utf-8?B?K1pHQUlTUWZwcjNncEhYcGhPbC92NDNrRk1kM1NSQ1Z3N2xwSFhFMmQ1cDFY?=
 =?utf-8?B?S2podkJmeVVJeWNBbnFnakRkSmE1eW5rcytUZUxqMkVRVjhiR0FpemU1ZkpJ?=
 =?utf-8?B?Z21PQk04NDJrSjRDRTY2Vk5pV1pmYVptQkVreVMwMFFBS0RWME1ZNktrZDBz?=
 =?utf-8?B?TFNMVklTSWI2aDRlSkE0VmVKdDY2bVE2YSs3WjJaWXh0WDkvVWQ3cDcyNGpy?=
 =?utf-8?B?L29kNWJQNHpvaG5vcFhPV3BQdGlaam05S2dFTjk5NXNKVU1qVER4eEVhUjJU?=
 =?utf-8?B?UlpFaXVyY2JPaUluTzAwekdySGhnRWxmUDQwcC8yYzNSWnZjRE1zUFViWnpx?=
 =?utf-8?B?OUdHbE5vR0NtcUZLenN2SjBYM3phUXRuOGZ6SDBIZjFTeGpFZEc3a3IyWHIw?=
 =?utf-8?B?dG8zK1VSVEJRQ1JjSmltMk1XN3Z5WFVCUDNxRUxuVVcxWUVIZTR5NWtPWFZt?=
 =?utf-8?B?ckFsNERHdWYzV3hMcm9pY2JjWmtDR2lUbjFWZCtMSUs1eUtRVXliUktuNlZS?=
 =?utf-8?B?ZjFHR2gyVlNwbHJhYVFtYzdCK3Rxd1lNNkp4K0QxNlRPQ29xRTExcXVuNEJO?=
 =?utf-8?B?bHl3VVVXR2wyWFcyK3pNQU0xSGxVQUlGSS9RUUJKL0dPc1Jnb0Z2c3hIQnNr?=
 =?utf-8?B?ZWpZaUlqRjVaVjZGZG02SndsTVlYVHNremVBRGtPdDk1QWJMMjY3d3ZXRlly?=
 =?utf-8?B?Vkt1QmszYVY2aDdNb2lKcHlxaEVrYmRMY3pJc0dWWktTc21XM2duVU1UZ2Zu?=
 =?utf-8?B?VGdyMkxMWXkxNzZ6TTl4VDlpL01hSGRvOVpXeGhtQnNRMEhaUW1mQ0dJOVNp?=
 =?utf-8?B?bm5xRnNFRU9YTnBDOW8xRVRldWoxSmlqTCtMUFhTdmVrUk9CU1MrcUFJU25o?=
 =?utf-8?B?bUNIb0ZzZ1B0a1c3TXJaRjdGeVhWcnExRFlMQ2FzbTk1YVl2MU1Wek9GTzRV?=
 =?utf-8?B?QnYrbGNaS2dQOVBiMG5qZ3dXRG10NVdSUDcyYmppbDJrT2xLTlNKOEV5SGNr?=
 =?utf-8?B?dzNBNGo3K3JvNkQvQXpvVEhPTC9NQmR1ODRlckxUSjUwak1mUTFtV2dwek0v?=
 =?utf-8?B?SmtQUWp0SVB0eS9SUkl0dzZORC80SFVVTGtpeEFPWUxNNmdLRU5tVXpXci9U?=
 =?utf-8?B?cmdsTE1RdmJ2cmFmc2lacGJFRldLRUFqM1dPSWZYeXVJRm1ablNkYVl2aHJv?=
 =?utf-8?B?NlcyQmU4ZWxsNlZwZUdhZld4UWNmbFRBVmlVQmhKa3dHMzQwaFQ1WlZleDNE?=
 =?utf-8?B?RU5kK0RSbWNaazAwYVpHMGxuaHJjRHVaZUdXUEQwWCtxbkxNV05qWENmWURp?=
 =?utf-8?B?elJPYlFiNWgzNUNreU9lLzhsWXBvSE5UMGpGNEJZZTMzK2FXZmdGa0V4dzBU?=
 =?utf-8?B?Q0g1di84YWhsNFhUbnh3WTA0S3NkdzlydVhONTR4byt1YW9rNlJhazFLdzc4?=
 =?utf-8?Q?2eYylZbGWwPcg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <551B248D13F9AD44B596BBEF32AFEDD3@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a18f24f9-c50f-438e-ef58-08dee8bfed37
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 13:40:14.9079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB7183

RGVjb2RlIG1vcmUgbWFudWZhY3R1cmVyIGluZm9ybWF0aW9uLCBidXQgb25seSB0aGUgaW5mbyB0
aGF0IGlzIHNwZWNpZmljCnRvIGNlcnRhaW4gdHlwZXMgb2YgRERSNSBtZW1vcnkgbW9kdWxlcywg
YW5kIG5vdCBjb21tb24gdG8gYWxsIEREUjUKbW9kdWxlcy4KClRoaXMgaXMgY29tcGxldGVseSB1
bnRlc3RlZCBzaW5jZSBteSBtb2R1bGVzIGFyZSBTUEQgcmV2aXNpb24gMS4wIGZvcgptb2R1bGUg
aW5mb3JtYXRpb24gYW5kIGRvbid0IGV4cG9zZSB0aGlzLiBJIGFsc28gb25seSBoYXZlIFVESU1N
cy4KClNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gSG9ydmF0aCA8cy5ob3J2YXRoQG91dGxvb2suY29t
LmF1PgotLS0KIGVlcHJvbS9kZWNvZGUtZGltbXMgfCA3MSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcxIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9lZXByb20vZGVjb2RlLWRpbW1zIGIvZWVwcm9tL2RlY29k
ZS1kaW1tcwppbmRleCBkNDU1M2Y1Li43ZjUxNjQyIDEwMDc1NQotLS0gYS9lZXByb20vZGVjb2Rl
LWRpbW1zCisrKyBiL2VlcHJvbS9kZWNvZGUtZGltbXMKQEAgLTI0MzgsNiArMjQzOCw3NyBAQCBz
dWIgZGVjb2RlX2RkcjVfc2RyYW0oJCkKIAkJCSgoJGJ5dGVzLT5bMjMxXSA+PiA0KSAmIDE1KSAr
IDEpKTsKIAlwcmludGwoIk1vZHVsZSBSZWZlcmVuY2UgQ2FyZCIsCiAJCWRkcjNfcmVmZXJlbmNl
X2NhcmQoJGJ5dGVzLT5bMjMyXSwgJGJ5dGVzLT5bMjMyXSkpOworCisjIHR5cGUtc3BlY2lmaWMg
c2V0dGluZ3MKKwlpZiAoJHNwZF9pbmZvX3JldiA9PSAweDExICYmCisJICAgICgkdHlwZSA9PSAw
eDAyIHx8ICMgVURJTU0KKwkgICAgJHR5cGUgPT0gMHgwMyB8fCAjIFNPRElNTQorCSAgICAkdHlw
ZSA9PSAweDA1IHx8ICMgQ1VESU1NCisJICAgICR0eXBlID09IDB4MDYpKSB7ICMgQ1NPRElNTQor
CQlwcmludHMoIlVuYnVmZmVyZWQgTWVtb3J5IE1vZHVsZSIpOworCisJCXByaW50bCgiQ2xvY2sg
ZHJpdmVyIG1hbnVmYWN0dXJlciIsCisJCQltYW51ZmFjdHVyZXJfZGRyMygkYnl0ZXMtPlsyNDBd
LCAkYnl0ZXMtPlsyNDFdKSk7CisJfQorCisJaWYgKCRzcGRfaW5mb19yZXYgPT0gMHgxMSAmJgor
CSAgICAoJHR5cGUgPT0gMHgwMSB8fCAjIFJESU1NCisJICAgICR0eXBlID09IDB4MDQpKSB7ICMg
TFJESU1NCisJCXByaW50cygiUmVnaXN0ZXJlZCBNZW1vcnkgTW9kdWxlIik7CisKKwkJcHJpbnRs
KCJDbG9jayBkcml2ZXIgbWFudWZhY3R1cmVyIiwKKwkJCW1hbnVmYWN0dXJlcl9kZHIzKCRieXRl
cy0+WzI0MF0sICRieXRlcy0+WzI0MV0pKTsKKwkJcHJpbnRsKCJEYXRhIGJ1ZmZlciBtYW51ZmFj
dHVyZXIiLAorCQkJbWFudWZhY3R1cmVyX2RkcjMoJGJ5dGVzLT5bMjQ0XSwgJGJ5dGVzLT5bMjQ1
XSkpOworCX0KKworCWlmICgkc3BkX2luZm9fcmV2ID09IDB4MTEgJiYKKwkgICAgKCR0eXBlID09
IDB4MDcpKSB7ICMgTVJESU1NCisJCXByaW50cygiTXVsdGlwbGV4ZWQgUmFuayBNZW1vcnkgTW9k
dWxlIik7CisKKwkJcHJpbnRsKCJDbG9jayBkcml2ZXIgbWFudWZhY3R1cmVyIiwKKwkJCW1hbnVm
YWN0dXJlcl9kZHIzKCRieXRlcy0+WzI0MF0sICRieXRlcy0+WzI0MV0pKTsKKwkJcHJpbnRsKCJE
YXRhIGJ1ZmZlciBtYW51ZmFjdHVyZXIiLAorCQkJbWFudWZhY3R1cmVyX2RkcjMoJGJ5dGVzLT5b
MjQ0XSwgJGJ5dGVzLT5bMjQ1XSkpOworCX0KKworCWlmICgkc3BkX2luZm9fcmV2ID09IDB4MTAg
JiYKKwkgICAgKCR0eXBlID09IDB4MEEpKSB7ICMgRERJTU0KKwkJcHJpbnRzKCJEaWZmZXJlbnRp
YWwgTWVtb3J5IE1vZHVsZSIpOworCisJCXByaW50bCgiTWVtb3J5IGJ1ZmZlciBtYW51ZmFjdHVy
ZXIiLAorCQkJbWFudWZhY3R1cmVyX2RkcjMoJGJ5dGVzLT5bMjQwXSwgJGJ5dGVzLT5bMjQxXSkp
OworCX0KKworCWlmICgkc3BkX2luZm9fcmV2ID09IDB4MDEgJiYKKwkgICAgKCRyYXdfdHlwZSAm
IDB4ZjAgPT0gMHg5MCkpIHsgIyBOVkRJTU0tTgorCQlwcmludHMoIk5vbi1Wb2xhdGlsZSBNZW1v
cnkgTW9kdWxlIik7CisKKwkJcHJpbnRsKCJDbG9jayBkcml2ZXIgbWFudWZhY3R1cmVyIiwKKwkJ
CW1hbnVmYWN0dXJlcl9kZHIzKCRieXRlcy0+WzI0MF0sICRieXRlcy0+WzI0MV0pKTsKKwkJcHJp
bnRsKCJEYXRhIGJ1ZmZlciBtYW51ZmFjdHVyZXIiLAorCQkJbWFudWZhY3R1cmVyX2RkcjMoJGJ5
dGVzLT5bMjQ0XSwgJGJ5dGVzLT5bMjQ1XSkpOworCX0KKworCWlmICgkc3BkX2luZm9fcmV2ID09
IDB4MTAgJiYKKwkgICAgKCRyYXdfdHlwZSAmIDB4ZjAgPT0gMHhBMCkpIHsgIyBOVkRJTU0tUAor
CQlwcmludHMoIk5vbi1Wb2xhdGlsZSBNZW1vcnkgTW9kdWxlIik7CisKKwkJcHJpbnRsKCJDbG9j
ayBkcml2ZXIgbWFudWZhY3R1cmVyIiwKKwkJCW1hbnVmYWN0dXJlcl9kZHIzKCRieXRlcy0+WzI0
MF0sICRieXRlcy0+WzI0MV0pKTsKKwkJcHJpbnRsKCJEYXRhIGJ1ZmZlciBtYW51ZmFjdHVyZXIi
LAorCQkJbWFudWZhY3R1cmVyX2RkcjMoJGJ5dGVzLT5bMjQ0XSwgJGJ5dGVzLT5bMjQ1XSkpOwor
CX0KKworCWlmICgkc3BkX2luZm9fcmV2ID09IDB4MTAgJiYKKwkgICAgKCR0eXBlID09IDB4MDgp
KSB7ICMgQ0FNTTIKKwkJcHJpbnRzKCJDb21wcmVzc2lvbiBBdHRhY2hlZCBNZW1vcnkgTW9kdWxl
Iik7CisKKwkJcHJpbnRsKCJDbG9jayBkcml2ZXIgMCBtYW51ZmFjdHVyZXIiLAorCQkJbWFudWZh
Y3R1cmVyX2RkcjMoJGJ5dGVzLT5bMjQwXSwgJGJ5dGVzLT5bMjQxXSkpOworCQlwcmludGwoIkNs
b2NrIGRyaXZlciAxIG1hbnVmYWN0dXJlciIsCisJCQltYW51ZmFjdHVyZXJfZGRyMygkYnl0ZXMt
PlsyNDRdLCAkYnl0ZXMtPlsyNDVdKSk7CisJfQogfQogCiAjIFBhcmFtZXRlcjogRUVQUk9NIGJ5
dGVzIDAtMTI3ICh1c2luZyA0LTUpCgotLSAKMi41My4wCgo=
