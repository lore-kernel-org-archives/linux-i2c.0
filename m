Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012071.outbound.protection.outlook.com [52.103.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4FB479862
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814033; cv=fail; b=l0j1M8m77Jf9qywPCGWX3sJXjlclaOTBSGtQkeoAHB4O3J3eLam/3ldQtfbRbgfn8hwdAmYmUZQGnJF0ZOL5TbRg1zwzlpk+fcmA/zAL/5O56LLyi3i9Ip+rMCnVRoUQr4+3O4kTLB1qHzHV0xeaLoRIfmJC6lZCygkPgooHAcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814033; c=relaxed/simple;
	bh=rGCZfkh2k14LmIRFcHjtoUYgKXmH/RZ+C7ryMlloCIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fFuvUQHQcK4cr4/qRGrCT9Mao5DFqsFfeTH3M7LXM46kNMWmex/hvVLr7PJHZdsn95XmEtSFIz0wLT7lVZ53Jt10BPq6d5P5dDddJFT4/7sIwsBYiiTanLxLasi20oEhJD1sk2bPtQfQXfO3ojomv0roZ56osmnUDHFEBc6zfKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=adZ76l/L; arc=fail smtp.client-ip=52.103.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="adZ76l/L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZZeiklzShQQdCUNQZHMu6Wsmlc3evx3AL0D8KLNYC3wCh8pAvuvUNoxgwbbNZ5NfpJdylbF7XnuR17fAlPTcLuIOR62QWdJvY4t1ynvNMZ5QdjttjIavqICoT//uPUzva+DOQUboIvtZo4yH466YCXklzI32yEp48loLvqxxcrJE4AkefUFMyaYIXPNAm0B0ju8+SzjKbj7ePKdySNVjgbDWEVwBo5u5MwB5g53+nWGvjMG0357TVQlRaQ0FOReuGZecG/IT45mXSTPHLRrvhkXNdXG1XCYL+gkaKcRtzuIfK0ejVsXgrJ1A6TEE/HmaQIXJos2eXdexOP4RpKspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGCZfkh2k14LmIRFcHjtoUYgKXmH/RZ+C7ryMlloCIw=;
 b=Ya93Kpobfi+p53x3G62owSkCzNDyvKpMOJ6yF3NxbmNWLJ1EelHv7MhsOd+KUwRmyowkPCXdLLmOyuOraVF2SVhcsU/lAlDO6qsp6mmoudgICG09O6MTVbYqclPSkZTJ8QXwsdHvFEfz1JZhJmvYnopZzy4+ityz/bqGc3BF3tLMznBwLaTg/McqAk+7wp3YASyVb5+020cwMFaDwCc91fBzOtSauDTY5YXO/b8JjF8/aQMtkcfk2tMssKBIL6baNMsK1uLpvOLTn/Ib+af8qKy1Pk0hccDXYbq/7rid+AMlhOMSAB8pdQGy2myP2w2q4W4HJyZHQht16I4t0C+K6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGCZfkh2k14LmIRFcHjtoUYgKXmH/RZ+C7ryMlloCIw=;
 b=adZ76l/LnkYXcWxLw5+eExqLRTUzxkzffYw//fUwPqtJ33yJb46/bsvzL67loha8yTb0oPrmBw9koZMSw0F1Diru6qr43TDxaA5xkNwWf2xuNQhKxx59I1yrlzm//lSZFn0SaECJvPEj7J7UxOeUFu6Mj7flVYT1UXAad9UFVxsLXKB9EEAZo0o91o9MTIqYrf0E6bqAnlVkRNbipUn9TKQ11pMoQE/trBL94Bj3CEL3NagL0U29cMapp81aKL3AyUT2cXwQ9WEjWTS0OVp/eDVKdiiMBg4Qk62mWMZFIqSMbGp9jR1klEFGNZoeYS9jG/X3rG11KvlumvmRwUn0Sg==
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
Subject: [PATCH i2c-tools v4 4/8] decode-dimms: Decode DDR5 common module
 information
Thread-Topic: [PATCH i2c-tools v4 4/8] decode-dimms: Decode DDR5 common module
 information
Thread-Index: AQHdGqjKZIAHRyd+lkuM9wgDhxQqHA==
Date: Thu, 23 Jul 2026 13:40:14 +0000
Message-ID: <20260723-ddr5-v4-4-d7cf78ebbbaf@outlook.com.au>
References: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
In-Reply-To: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|MEYPR01MB7183:EE_
x-ms-office365-filtering-correlation-id: 2dc1876e-eecf-46e2-f512-08dee8bfecd0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|38102599003|15080799012|37011999003|25010399006|24021099003|8060799015|31061999003|19110799012|8062599012|440099028|3412199025|102099032|3071699003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0tVNjZ0Ky9wZWg4aWlEMmJ5ZThkZzFVTHZ3Rk5ISTh1TGNzZ0VSOElGNmxw?=
 =?utf-8?B?T3Z4dk9DMW1OK1I1TENKSncyZllHS2lwK1cwb3I5ZTU3bkhubjVyWmdSN2FR?=
 =?utf-8?B?SVlrTE56QTJrclpBb213NnFMR01oZjRUWEN1bHppVDNiU01xUjA3SnRma2hr?=
 =?utf-8?B?WC9YMDRBaURwb3hzd0h5bVVrVUtXOW5Td2kxQVh3SFdBcWVrWXZaQldPSmxR?=
 =?utf-8?B?ek91UEJaZUN3MGwrQ0dnU2t5Zzh3aU9XVzkyNGorREsyenJUVkhzQm9LaWFn?=
 =?utf-8?B?MHUxMktYdUNCUzRhSU9xRUd2VlZncXBlSXdJU3R1NDVCaG5CYmRuT3pTMnNt?=
 =?utf-8?B?MlFKSThycjVTc2FkVnBHZnUzWmhiWXFCQ1RUMW03MGxxWDlIQW1nNi81eWtS?=
 =?utf-8?B?TVlKU0NmQkZJZkVWNU0zejM3SFdnaU16bk5mREdjOW5tM01Za1p6SGVkKzQ0?=
 =?utf-8?B?Mm9LNHRVdGNwei91U2pqaU9qWExWSTNjUVlVOTczUmN2UWZCTlNmT3ZpSCtw?=
 =?utf-8?B?VEdVZlFRNjNsRzQ3L0VHblUyUjBtbVI0UFVZYlExemtyUWVvTnh5bG9TRkJr?=
 =?utf-8?B?Sjh4QkhkRi9mZ3YvRk1ObTlsc0hvZTFORG53aXg0Q3g3OG9yQzRIQkFpQUVs?=
 =?utf-8?B?YmhUTUpMVzRjYkdUekJDVWZ5UWt2ZWx3RTNmdXcyd2pnNm9jUDBSWlE2ZkRM?=
 =?utf-8?B?bnFrZ3UxSXZyd2MvenAxb1d1ZW1IZHpXUWh0ZjVibExKZ2dzWW9BV01yVHRp?=
 =?utf-8?B?akc4MjhMVE5WSzFLL0RSMFNIdTdnMHRnVmZjbzNxUCtUazRJdDVnYlJZL2NK?=
 =?utf-8?B?THVyc1F4N3E2STUvL2xDMnJrK3pyRWc2WW9aMHVPbHcrNW85UHU1Yitab3NF?=
 =?utf-8?B?blA5c2RFS1UvQ2pUb0NNUDhiSVVMMDJCcitkMEpyWGZsZlR1c3UxM1JWQ3gz?=
 =?utf-8?B?Tkw4RnpRdEgya3g5NjR5U2xWZTlnckxoQWM3YllnVFhJVC9oZkpGeDgzV0Fm?=
 =?utf-8?B?RFZMTjMyVDJ3QWMvbGJEYmxERXpONGQ5NCtIaTI0aUdvUnYwVDRVcUtYR05y?=
 =?utf-8?B?SCtSWlh6VkFIMDNkeXpFUGFKY0xOd3pvemNzOUcveHErQTAraTJ0aTdlbEZm?=
 =?utf-8?B?V3VBeUZQcVRWWDFFZ1J2clV1Ky85Q3FJR2paem1RRWtBU0J5SDU1RFowUHJQ?=
 =?utf-8?B?Unc4ZGxtNnZkZFpTUmZmMHNydm8yakdmNGljNUhLTU9lVDNBYlIvSFBKbnM2?=
 =?utf-8?B?OWcwaXhFMy94YXJhVERQUXZ5dVJ1eVlYK1dzMVp0VkVTVDJob011M2M1eFJk?=
 =?utf-8?B?dUVMWWVNSWpIR3JmNGVMaDM2ZkpKNktzbG5TUGtpWlJDOGNXcjYrUjRaKzFw?=
 =?utf-8?B?RUxvY0g4bzRHbHc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkRCZTU2TGhINkFBeDA5WG1JbFo5U0YybVJwSlJCMG4zV3dMLzhwL2VwdWJQ?=
 =?utf-8?B?Z1V0T25KV1BFeVBmR2hhdDVWQWZsdWlvN2NKNE00TURCems5TVczVzN5ZEhE?=
 =?utf-8?B?dklLS2YrVVh5NStkM2ZYbzI1dlBBSnVMcHNBZURDMW9QSE1UUDN2OUlWTFRh?=
 =?utf-8?B?YXIybjV0M05jQlFvSU5VdklwcnFKUFJiZlRZY2VwdldUZlNtNElOWGszSlc0?=
 =?utf-8?B?Z2d3NEhueG9icUY2VnZRU2RYUERaZW91clVJajhtdFl1b091bmJDbFJ1ckVu?=
 =?utf-8?B?ZitjTmllTWViWG1tSGJaak9JcGk2TlE0c0dnVCtvRkorOUVvNklXbEtrNTZC?=
 =?utf-8?B?b0c2TmtSZlRJWHcxaUpFaUdCM0c1Qmdla2JqbEl6VUVJSVJXWmFTSnZTY1NF?=
 =?utf-8?B?UnE0NEhDU1hoUmFLYWlQMEZmU3lCbWJXMWFPZ01OYlJvc0pTY1kyTUMydXdv?=
 =?utf-8?B?UzlhY21ZZzF5ZDBrOFZFTm5lbzVWcGc2NnkwZ0ZDdFV2RjZNODdzRTBuZ1Z4?=
 =?utf-8?B?RkduNnduZUIzaVl2ajRFVHZtdXVZbGw1cGtpNXdMb24zQm9NWHQxUnE0ejd2?=
 =?utf-8?B?RUxhY1R6WmhkaFl0bS9zcVhFMFlHR1J1NnpwMVFNTGMrWEZURStFcTNWT0Ny?=
 =?utf-8?B?bFBYZDI3elozZ3dHT3FldlZjbkp6YVQ3QnRCWndzenJZVnNSWFJqdU1zem5m?=
 =?utf-8?B?ejFpZFUwQTZCVHB6dWF5UDFqQUJZVGo1MkU2YTY5bXVCSDY2V3VTS3Z5YWRl?=
 =?utf-8?B?WGR4M20rN0dsZnZTcTRaNGtwRzNidFJVZVY0WGd3YXBuekVnZ2dWRTV3S3lN?=
 =?utf-8?B?ek5KZUZiV3IyU1I5aEthTWY3NXNpWlF3WFVCemVlK1Zzb21pQnJkRElqdUpU?=
 =?utf-8?B?OXRmR0xHK1k1OEVXdHNDdzNvR0Yyd0dWeXhNckpYeE1xaG5reHdqVXF5Z2g2?=
 =?utf-8?B?UFBqcW50VVdIYnV6NlZKWkJTUEZoSzRlL0JFMHRGNU41d21rWTVpWG85K3Yr?=
 =?utf-8?B?Z1ZRZWEzL0FnaXFrbWxRVHlrWHlRZDRleEllVGcyaE5qRHJTVGFKajFXVnBz?=
 =?utf-8?B?ZTRoTGlscnRVMkxHK1huYzVUNnVTc09Ycy9YWHRHbWtMTG9DdGhDUElnK0xS?=
 =?utf-8?B?eCtMbG1kOE9BNnZZN2Jzekd1UHU0L0ovclA3K2EyRXk0Yzk5QkozSjJDVXFT?=
 =?utf-8?B?bCs4UkZZcDVaQTJVZWVkR090cmc2WG5VeFJZcTAyTktKVlo0cWdrQm9wQW9a?=
 =?utf-8?B?N3NBWjZuMSszRVZtcytIVCtCdXhKb0NTUjlobzJ2cjVnajN0dlRUeWFRSjBK?=
 =?utf-8?B?QWdZa0lleHEvaHY4VWdBZzhzYVdwTGN0RCsvV1FSL3pvOW5TdXA1QkpJYnF6?=
 =?utf-8?B?MTc2cGdod2R1Z2xTNXRpUHg4UFVLc3RFMjdGZ2lyaWVYUHgwbmxTTUtST3V3?=
 =?utf-8?B?c29PMEJBcUhCN3N3LzRGK3pzV0kreWVZdGx3UXpMRUNLVk9jRDh3ZG8wQVBo?=
 =?utf-8?B?enpUUC9EMTVDeEdGUU00WnR1Q0pLK3MrNzE1Q0pqdGUyb1VQNElBMWpWWHM3?=
 =?utf-8?B?enRKczhrcHlwMmNFQkpqejIrQWtzVkNERmtuaWdHZzRYN29sZlZRaGZaMGdO?=
 =?utf-8?B?blhFOENFRHVkeWFZSGg1SHgwWGYxMUt6NHdIK0xDdVgyRjJ0WldCc0V0c2k4?=
 =?utf-8?B?cFB0Sk8reVprdkthcDVCN1dRWnpIMzE4a2JTMy8ySjhXc25zYjNKTk5IUkdK?=
 =?utf-8?B?R1lFaXYycmhNMmhpbjZIeW15aXFWOU41TU81bjV4UnZJZWhVUU1EWHdGT01w?=
 =?utf-8?B?UHIzQmhhZnFJVUQ4K05JcXQ4OXNzczM5WXQyeDF2QkZDTWJuc01FdEFOeFFG?=
 =?utf-8?Q?HMAxr95ZVbruq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D912558E075E1D4EB8F7EABD5D57246E@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc1876e-eecf-46e2-f512-08dee8bfecd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 13:40:14.2395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB7183

RGVjb2RlIHRoZSBleHRyYSBtYW51ZmFjdHVyZXIgaW5mb3JtYXRpb24gdGhhdCB3YXMgbWVudGlv
bmVkIGluIGEKcHJldmlvdXMgcGF0Y2gsIGJ1dCBvbmx5IHRoZSBpbmZvIHRoYXQgaXMgY29tbW9u
IGJldHdlZW4gYWxsIEREUjUgbWVtb3J5Cm1vZHVsZXMuCgpUaGUgcGh5c2ljYWwgc2l6ZSBpcyBu
b3cgaW1wbGVtZW50ZWQgdG9vLgoKU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIb3J2YXRoIDxzLmhv
cnZhdGhAb3V0bG9vay5jb20uYXU+Ci0tLQogZWVwcm9tL2RlY29kZS1kaW1tcyB8IDM2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDM2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9lZXByb20vZGVjb2RlLWRpbW1zIGIvZWVwcm9tL2RlY29k
ZS1kaW1tcwppbmRleCBjZDBlMmZkLi5kNDU1M2Y1IDEwMDc1NQotLS0gYS9lZXByb20vZGVjb2Rl
LWRpbW1zCisrKyBiL2VlcHJvbS9kZWNvZGUtZGltbXMKQEAgLTI0MDIsNiArMjQwMiw0MiBAQCBz
dWIgZGVjb2RlX2RkcjVfc2RyYW0oJCkKIAogCXByaW50bCgiVGhlcm1hbCBTZW5zb3IiLAogCSAg
ICAgICAkYnl0ZXMtPlsxNF0gJiAweDA4ID8gIlN1cHBvcnRlZCIgOiAiTm8iKTsKKworIyBjb21t
b24gbW9kdWxlIGluZm9ybWF0aW9uCisJcHJpbnRzKCJDb21tb24gSW5mb3JtYXRpb24iKTsKKwor
CW15ICRzcGRfaW5mb19yZXYgPSAkYnl0ZXMtPlsxOTJdOworCXByaW50bCgiU1BEIE1vZHVsZSBJ
bmZvIFJldmlzaW9uIiwgKCRzcGRfaW5mb19yZXYgPj4gNCkgLiAiLiIgLiAoJHNwZF9pbmZvX3Jl
diAmIDB4ZikpOworCisJcHJpbnRsX2NvbmQoJGJ5dGVzLT5bMTk2XSAmIDB4ODAsCisJCSAgICAi
U1BEIE1hbnVmYWN0dXJlciIsCisJCSAgICBtYW51ZmFjdHVyZXJfZGRyMygkYnl0ZXMtPlsxOTRd
LCAkYnl0ZXMtPlsxOTVdKSk7CisJcHJpbnRsX2NvbmQoJGJ5dGVzLT5bMjAwXSAmIDB4ODAsCisJ
CSAgICAiUE1JQzAgTWFudWZhY3R1cmVyIiwKKwkJICAgIG1hbnVmYWN0dXJlcl9kZHIzKCRieXRl
cy0+WzE5OF0sICRieXRlcy0+WzE5OV0pKTsKKwlwcmludGxfY29uZCgkYnl0ZXMtPlsyMDRdICYg
MHg4MCwKKwkJICAgICJQTUlDMSBNYW51ZmFjdHVyZXIiLAorCQkgICAgbWFudWZhY3R1cmVyX2Rk
cjMoJGJ5dGVzLT5bMjAyXSwgJGJ5dGVzLT5bMjAzXSkpOworCXByaW50bF9jb25kKCRieXRlcy0+
WzIwOF0gJiAweDgwLAorCQkgICAgIlBNSUMyIE1hbnVmYWN0dXJlciIsCisJCSAgICBtYW51ZmFj
dHVyZXJfZGRyMygkYnl0ZXMtPlsyMDZdLCAkYnl0ZXMtPlsyMDddKSk7CisJcHJpbnRsX2NvbmQo
JGJ5dGVzLT5bMjEyXSAmIDB4QzAsCisJCSAgICAiVGhlcm1hbCBTZW5zb3JzIE1hbnVmYWN0dXJl
ciIsCisJCSAgICBtYW51ZmFjdHVyZXJfZGRyMygkYnl0ZXMtPlsyMTBdLCAkYnl0ZXMtPlsyMTFd
KSk7CisKKwlwcmludHMoIlBoeXNpY2FsIENoYXJhY3RlcmlzdGljcyIpOworCisJbXkgJGhlaWdo
dCA9ICRieXRlcy0+WzIzMF0gJiAweDFmOworCXByaW50bCgiTW9kdWxlIEhlaWdodCIsCisJCSRo
ZWlnaHQgPT0gMHgwMCA/ICIxNSBtbSBvciBsZXNzIiA6CisJCSRoZWlnaHQgPT0gMHgxZiA/ICJt
b3JlIHRoYW4gNDUgbW0iIDoKKwkJc3ByaW50ZigiJXUgbW0iLCAkaGVpZ2h0ICsgMTUpKTsKKwlw
cmludGwoIk1vZHVsZSBUaGlja25lc3MiLAorCQlzcHJpbnRmKCIlZCBtbSBmcm9udCwgJWQgbW0g
YmFjayIsCisJCQkoJGJ5dGVzLT5bMjMxXSAmIDB4MGYpICsgMSwKKwkJCSgoJGJ5dGVzLT5bMjMx
XSA+PiA0KSAmIDE1KSArIDEpKTsKKwlwcmludGwoIk1vZHVsZSBSZWZlcmVuY2UgQ2FyZCIsCisJ
CWRkcjNfcmVmZXJlbmNlX2NhcmQoJGJ5dGVzLT5bMjMyXSwgJGJ5dGVzLT5bMjMyXSkpOwogfQog
CiAjIFBhcmFtZXRlcjogRUVQUk9NIGJ5dGVzIDAtMTI3ICh1c2luZyA0LTUpCgotLSAKMi41My4w
Cgo=
