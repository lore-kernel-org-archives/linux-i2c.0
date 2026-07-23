Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010007.outbound.protection.outlook.com [52.103.73.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358424137AD
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814027; cv=fail; b=ro0UpTRBABc8l3TiGHXaG5EgPal/yJPvyDwrY4ep1pKLOQ6xWxpRyx0wOuDCV8TQaOIRHBUNGmLB73NAXLz9pSq5WEbu6wdxwNVwUZuQmthzP66nWKC9Ux2yU/3kjGhlpLES30b6hAJylPKbq2PpUsbs4VMMTLjOR6PL1N+10Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814027; c=relaxed/simple;
	bh=u7w7gLBj92zywfnGXSFRoiXARzlMC7k8wqlPuLjgx5Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y/PdOlFL1LDYjCnJZCcFlElKJJQaKSK3Z82PTmcqG+6U3OXquyK9+smHTySpuvTedXy4Hz3jiOVhZAE7lIHQhioWCEj84za3j31GrLK/LdIhXMAJp+qc2LpjZQ3PQgPBptDUzQhyPvwwVfc9dGO7ptClGmVu/dVJMfWGR5VNPao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=sTqMmMIz; arc=fail smtp.client-ip=52.103.73.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="sTqMmMIz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP8AE0bkPSlJuvxwVTqNA85hjCk0IyUHEPAh3ZTGb9fsLeuYsyxKbl8dFSYGJ9NkKxGXPHG12kVfjlpIjSxGLMLYYvOb6qFKwEqTdjg8Q3vdZaJ4Y/pvs/MM1TZBsBfIDzz6tr2AEBmnb+dFBmHGkhGSdgh6uYlzxInaJCWGHD5rnCpCbb63HprM5Oy53sP1arbuRdtTYVYu7saOO0b7N3ZFTuPE51Ce+eKkf7r0/JiYU8oO8yunhEwgcMvgkrcTQk/JUQP1gEYR5YyyJ583VEFcQpDUoppSYpHxv1/+Emw6WHAwd1oXoflpmB3sOhvF15qsyls2Esf0leCxMfj92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7w7gLBj92zywfnGXSFRoiXARzlMC7k8wqlPuLjgx5Q=;
 b=Xc4XB4KdNAn9I4bzhLhjW1tFgdfS56k20p9zQ4HrIlPCY8iPewObWFDs+FP/uLfKojJm3L8/t6ly2eyMX5eJ6MDYQ1bchQvsltJAgKNDjRVtI7UE2eHNo47T7WnCYzEhWfbKsB3dqUCor4FERCXR47pzcxexsfinhqpAXrIMZJk0FMroFB+fbIsgn96tsxJQbBSSpRGnZP/tHaasCsVB30IM6jICqDcPkg5srHEX6vaTX2db3AiNYaw1hFKa+N+m/SBLtn3KECIv506KvoaGViQosCx1gCWDY9k99+dFtia3qW4PAuT2d1oYqfA4UCTOGVMte1SQvR0Ay/1WLy5Htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7w7gLBj92zywfnGXSFRoiXARzlMC7k8wqlPuLjgx5Q=;
 b=sTqMmMIzFS3lTltXVEiQSMuxHLaw+T1SG3ItRTyGHzD3E/RRoUEIrq/+EYS5TA0vGAZGkEUUrMvFVFf8AyJ6y5d85SERllDn8ioRarsOo396w035F/FFZ8qjOBw1WAs/8dM1mV6W1VPmlUdZ9yXXJAw6vblJoS2aMSIPRxdLGHezpUBut81gYH2XQCX6ojJA0fZg3gvQ4Gh1Zk+JyMCdTE/3C8wn1vTYap3lwDX3N4aKHkLujGkdIgpvAHhTrAb0i+B/RPkU1sVYhztcTz6Vtvxf6q/kh3fEHn2FiV4qggFZHh1kDd1MuaV5Ys5ZA3cX++ZERJjBY2diEW7kdh9hOA==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by MEYPR01MB7183.ausprd01.prod.outlook.com (2603:10c6:220:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:40:11 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:40:11 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare
	<jdelvare@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>, Guenter Roeck
	<linux@roeck-us.net>, Kamil Aronowski <kamil.aronowski@3mdeb.com>, Darsey
 Litzenberger <dlitz@dlitz.net>, Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH i2c-tools v4 0/8] decode-dimms: Implement DDR5 decoding
Thread-Topic: [PATCH i2c-tools v4 0/8] decode-dimms: Implement DDR5 decoding
Thread-Index: AQHdGqjIExvprzrgOUKwQb233qN3iA==
Date: Thu, 23 Jul 2026 13:40:11 +0000
Message-ID: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|MEYPR01MB7183:EE_
x-ms-office365-filtering-correlation-id: d11051c7-0d93-4be4-0a97-08dee8bfeb40
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|38102599003|15080799012|37011999003|25010399006|12121999013|41001999006|24021099003|8060799015|31061999003|5062599005|19110799012|8062599012|440099028|4302099013|3412199025|102099032|10035399007|3071699003|1602099012|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUhSY21nQjZrVXAzMmFrWlNuNmtGNi9xMVpYdFB5OHpGU3h1T05UM3BBS3hP?=
 =?utf-8?B?WWE3cFFXU1poL1pIR24rWnAybFZpV3hyZTRMOTJSSUpGRWhpZEFvL3VnT3p3?=
 =?utf-8?B?RHdrZ2VxS25qekllV2YzRnFYM05pRloxNkpJS3NIL1djek5UeHNRZElNNGc3?=
 =?utf-8?B?a0xHa3VIM2wyek5BQXhiRmZOcGJxS1AwOXR6WHdLb1VWMnQ3aGR0YUVmZFp2?=
 =?utf-8?B?Q0pTMGxwMTNFSWlDZVgxUXl1cXRSSVhHblhNRmlta0FFeWdrYkJ1dlhVL25E?=
 =?utf-8?B?WTA3TkxtaVdnRENaUW0yb0xjeUNSWEVsNTFLMXlPcjkwQVdmZHgvejZZY1A5?=
 =?utf-8?B?blFWUkRwQncyQVU4cjVRUGFaZ1FhRXZKSkVYVmNYTEROSXYvckVzR1RENENZ?=
 =?utf-8?B?dXBORTRHanpFcnFDSnZkZk5SQ0Q4bkcxb3FPb2M1SXp5Tk9IMmQrM3BrTjFS?=
 =?utf-8?B?UkhxcFJVclVJUGM1N29SL3pocDhEMC9CaWlKZXViK3RIdkZUQmF0M2E0a3ZI?=
 =?utf-8?B?cGE0TythODVNTUc1R1BoNHNaYTErUER5bmJ1d0xrcGZnMXBXMXJFb2VSMjhk?=
 =?utf-8?B?RVhiMHBxd1NxY0tVMk1TWElRdWNaWURYeTdYQkxwS2VmSDR4MnpWajFkeG11?=
 =?utf-8?B?MEIrTU40QUpyRlFhQ3ozUXMxNzlqM3JlMHA0OGhTSk96TWJ5a3I0MVovTm4v?=
 =?utf-8?B?Y1F6b3h2YnNrSERydjVEbUZZdFNHay9mNERpYnVSbUJiUHZlUU1XTThBZDZY?=
 =?utf-8?B?bGRFRjFoalRZdmZqRkJPTEF3RG9CYkdYK0dQb0x4WC9lTWt0NWZuTWQ1MURk?=
 =?utf-8?B?NzdYRElKNGx6MDRYQU9jeDkzNjdjbk8vUnhraDhoYWczN0VWK0psalJWOU55?=
 =?utf-8?B?WkFLcG42YWlCbHN1ejRNUTMxWFdEQ09EaUs3TUh3QzhldlBPYkVBMm5tTmxa?=
 =?utf-8?B?cTlLcUsyWUhYM2ltOFdsaHVJczF4TFRqaEwxaHMxdmFBVkxmYjNYc00rSmVW?=
 =?utf-8?B?SVZ5SHFhbzF4a0E2aElDT0lEaitZMjFxRjZYeUNmRnlNSnZyQzBMZGNSbzA5?=
 =?utf-8?B?MlJobHNYSHVBZlZ6RXppelIzeTFCeUxuS2VmU0tLcURyTkx4bXAwQWVXS2RG?=
 =?utf-8?B?cjE0QW44ZFpZcmVoaklkaHV3cjQyRUhNc1F6R3N1SFZrc1FpdEttOW1kdlE0?=
 =?utf-8?B?TzNMeHIzaGxZeGRaajF2NUd0Mmw0MGdRb2JRU1NGR3haYWVsRGdpTSt2NXA2?=
 =?utf-8?B?djhMVTB5Nkw3bWZrb3RJVElzNkpEVDZ5NDJmSHg0ZDhEcDdsWVZXdEJiM2kx?=
 =?utf-8?B?ZnM2TmVFUDI4UGxuV1hSTTFzd3U5S2tiNWswaGk4d3UyenBJdEFZQkY0ZDlq?=
 =?utf-8?B?Wlo1VVlVTWFhTHp4WEdQcFNJRkVTNTlvUlRYQm9pVi85UldaVXh4ZXg0bjha?=
 =?utf-8?B?TEcxMjEybWtjZ2cyT2FJUHRDK1M2TnFWaVdVaVBNeWZQMlJaUXE0Rk9NYUNo?=
 =?utf-8?B?bmR0cThHUXQvMTVXUjk4cGprMmI2R21qRkRCbjRtYy9NOTgwZW1MSHNqWGpX?=
 =?utf-8?Q?XlePMprWJODefF0dApNZQG+A4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TExiWTJuUGJaTGVxYWlKSnc5RkpTd3g3M0ppdC9uejREZmZ1Z0VXZDArczdm?=
 =?utf-8?B?SGNESVRxME10ZWlxZDVkbXI1RjQzU0RQY29sTDVLYzJsa3JhTVZaVUJwek1H?=
 =?utf-8?B?clpWY3RBeGdGNk52THdaZFNtSE5mQlRob3MzRDdKZnR4eFNWVnFYVkhab3N0?=
 =?utf-8?B?MjFsVGJiZ1lwRWNRV0ZkQVUzSDFTdlBuZ0d2REw3dTVkOFJueXpzT0VUV0RS?=
 =?utf-8?B?ZUcvZjRuZWc2WWlJZ2dVT2ZycUY0d2lPbzFPRjY2WFczTkF5R0EveFFzd0gw?=
 =?utf-8?B?bGl6K1hIUW1LZ1YzT1NtamdFeWtMMGI4SGw0WnEwRnpRT1AyYjExbUJGSSs1?=
 =?utf-8?B?enlBZit5Sk5HajlCeU9sWHYxWDVRT3ZNeFBST1lycFNISXVlVmFlaWVoaHZ5?=
 =?utf-8?B?YUV0cHU0SlR3NzRjaXFCM1BrODVRZm1qNXlkWG9DZ2k0cHhmdkZpVFdTVVBn?=
 =?utf-8?B?a1ZMakIxS2pSL3BLRzJFM2FkVEhBMVNkZzJ6QjVnVzh4UjZDNVVmaGI2Si9r?=
 =?utf-8?B?dWlsblNubklIeHBaMi9CWTQrRjU1Q05abGNpdVo1ZlVaOXVnRVdxQ1Uvdlo2?=
 =?utf-8?B?djJ3SXVLOERKZ3lKRnlyYW9jL2h4eThMandIMFBVdFlpUjcwempyeThzQlcx?=
 =?utf-8?B?TmhRS1FraUVFOVc5OVFhN2ZQRzlUcEEwZzc3SHZ4cG1RSmFBK3FTU2lXZzll?=
 =?utf-8?B?enVkQk9mUVpaWDBNMDdkZVNxSzR3cWVacW9jdzRWb21XckFsTnh4SFkvQ0o4?=
 =?utf-8?B?QlhKVU1EMWlzRDF2bC9sYnFCSVhaM0Q5a09RZEdHWUNvcVZXbHRWL1JOK0tY?=
 =?utf-8?B?a0tCejI4cGlUSVBCKzNqU3hqL3lMK3hrd3hxMUFSMm9sMDd2OHNWNkxaN1Bn?=
 =?utf-8?B?UDkrOUpyL2xFaGM4NjhKU1VzMVNvSlRmckhONTFUalZmd1JNSzc1VUJyK2w4?=
 =?utf-8?B?MUVXTEFRSFdMdFVlRTZqc1YxKzFxSEt2NWRURmhBbitqU09ZN0RKYTRwbFBs?=
 =?utf-8?B?d3pjMzBnNUZ1WFpFelhjUUN2WThralBCWGpmeHdtc3F1THJqRWRxTEpFaEhI?=
 =?utf-8?B?TklKU0J4U1J2dGU1SE5Bd2czYWNXN3U3WGFmSUpXVURFZm4wbGZEelNwbXNt?=
 =?utf-8?B?NGVUZVo1a1RtKzArV0hNc2FHSDhyUDZUVXkvbVNhcTBKU2IvbUVPN2xRUUg5?=
 =?utf-8?B?SWZQdkVtcWRrb0JCZmpjNzd3c1RiMFdqUzlrb0srZ1luUVRRdTFZdW9LMXo3?=
 =?utf-8?B?SXdoR0VPUzZ1RFBUa0lUOVF6TnJPSkl3TzFmRk83L3BVaFRWdXJQams5ZXJD?=
 =?utf-8?B?MTdmU3A1a2UwcWg5RlFRbGQzZWxEWmlCQVZ1SU5oanNnYTZWOGI3VzdRVFFJ?=
 =?utf-8?B?VjVyY0ptNFgydm1uQUJCajI5QlhTb2tPTmVrUGk1NDl1amZWMHV0TEE0OW9Y?=
 =?utf-8?B?Z3ZKNHhMci9rYWJnaEV5RHUxcDNGSWUyZzRsTUlWQUpqMU14TXlxZTVRYi9t?=
 =?utf-8?B?SUUxNnhzU0RmMFR0a1laUUxIL3FwL3FOOUNnN3VvNzQrOEorRmRJOTZEeERD?=
 =?utf-8?B?UlNqUDJOR2FFRk00dUNOSkJVaTNlaG5EK3poTnhUTFFsVk43TGp6L1piaTV2?=
 =?utf-8?B?MTR0V0h4MldEem53VWR0djRSaWhMd0kzV0ZpWm5rSVhTTXQ2NklVRmRPbjdH?=
 =?utf-8?B?NDlIYTAxcjg5aGRqVUEvUlY0SjRLc2M5SXd1NTdpRXV4R2xPbHN2R0ZxUUpD?=
 =?utf-8?B?bVdCMHlVcXFsVFdNU255RDZkUHhtMFRnSDBudzIveVFwQzVEcVBYNkpuRGk2?=
 =?utf-8?B?bjVQc1JjUkY2ZUxDMGNrVlB0ZTYwUHBENFA2ODA3bTdRaW9sRXR0K3ZFMlRh?=
 =?utf-8?Q?VXaeSuL2qAtU2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE350EA3325B89439E08E6F041BFA686@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d11051c7-0d93-4be4-0a97-08dee8bfeb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 13:40:11.5566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB7183

SGksIHRoaXMgc2VyaWVzIG9mIHBhdGNoZXMgYWRkcyBERFI1IHN1cHBvcnQgdG8gZGVjb2RlLWRp
bW1zLgoKSSdtIG5vdCB0b28gZXhwZXJpZW5jZWQgd2l0aCBwZXJsIG9yIHRoZSBKRURFQyBzcGVj
cywgc28gdGhlcmUncwpwcm9iYWJseSBnb2luZyB0byBiZSBzb21lIHF1ZXN0aW9uYWJsZSBjaG9p
Y2VzIGhlcmUsIGJ1dCBJJ2QgbG92ZSB0bwpoZWFyIGZlZWRiYWNrLgoKVGhlIGZpcnN0IDQgcGF0
Y2hlcyAoMSwgMiwgMywgNCkgYWRkIHRoZSBlc3NlbnRpYWwgRERSNSBpbmZvcm1hdGlvbiB0bwpk
ZWNvZGUtZGltbXMuCgpUaGUgcGF0Y2hlcyA1ICYgNyBoYXZlbid0IGJlZW4gdGVzdGVkIG9uIGhh
cmR3YXJlIGltcGxlbWVudGF0aW9ucyBzbyBJJ20KaGFwcHkgZm9yIHRoZW0gdG8gYmUgZHJvcHBl
ZCBpZiB0aGV5J3JlIG5vdCB1c2VmdWwuIEhvd2V2ZXIgdGhleSBhZGQKdHlwZSBzcGVjaWZpYyBp
bmZvcm1hdGlvbiBhbmQgZXJyb3IgbG9nIHN1cHBvcnQuCgpQYXRjaCA4IGFkZHMgWE1QIGFuZCBF
WFBPIHN1cHBvcnQgZm9yIEREUjUsIHRob3VnaCBJIGRvbid0IGhhdmUgYWNjZXNzCnRvIHRoZSBk
YXRhc2hlZXQgZm9yIGVpdGhlciwgc28gSSdtIGZpbmUgaWYgdGhleSBnZXQgZHJvcHBlZCBhcyB3
ZWxsLgpUaG91Z2ggSSBtYXkgYWxzbyBpbXBsZW1lbnQgWE1QIGZvciBERFIzIGFuZCBERFI0IGlu
IGFub3RoZXIgc2VyaWVzIGlmCnRoZXNlIGFyZSB3ZWxsIHJlY2VpdmVkLgoKUGF0Y2ggNiBqdXN0
IGFkZHMgYSBuZXcgZnVuY3Rpb24gYHByaW50czJgLCB0byBwcmludCBhIHN1YmhlYWRpbmcsCnVz
ZWQgZm9yIHRoZSBlcnJvciBsb2dzLCBYTVAgYW5kIEVYUE8uCgpTaWduZWQtb2ZmLWJ5OiBTdGVw
aGVuIEhvcnZhdGggPHMuaG9ydmF0aEBvdXRsb29rLmNvbS5hdT4KLS0tCkNoYW5nZXMgaW4gdjQ6
Ci0gQ2hhbmdlIHRoZSBub21pbmFsIFZQUCB0byAxLjhWCi0gRml4IFNQRCBsZW5ndGggY2FsY3Vs
YXRpb24KLSBBZGQgdHJ1bmNhdGlvbiB0byB0aGUgcm91bmRpbmcgY2FsY3VsYXRpb24KLSBTaW1w
bGlmeSBgZGRyNV9yb3VuZF90d3JgIGZ1bmN0aW9uCi0gVXNlIEREUjUgcm91bmRpbmcgYWxnb3Jp
dGhtIGZvciAiVGltaW5ncyBhdCBTdGFuZGFyZCBTcGVlZHMiCi0gUmVtb3ZlIHNvbWUgdW5uZWNl
c3NhcnkgbmFub3NlY29uZCBjb252ZXJzaW9ucwotIFJlZm9ybWF0IHRoZSBjb3ZlciBsZXR0ZXIg
d2l0aCBiNCdzIGNoYW5nZSBzdHlsZQotIExpbmsgdG8gdjM6IGh0dHBzOi8vcGF0Y2gubXNnaWQu
bGluay8yMDI2MDYyOS1kZHI1LXYzLTAtMDdmNDUwNzVhNTFhQG91dGxvb2suY29tLmF1CgpDaGFu
Z2VzIGluIHYzOgpWMyBoYXMgYWdhaW4gYmVlbiByZWJhc2VkIG9udG8gbWFzdGVyLCBhcyB3ZWxs
IGFzOgotIFRoZSBkZW5zaXR5IGNhbGN1bGF0aW9uIGhhcyBiZWVuIGZpeGVkIHNvIGl0IG5vIGxv
bmdlciBwcm92aWRlcwppbmNvcnJlY3QgcmVzdWx0cyBmb3IgPjQ4R0IgbW9kdWxlcwotIHRDQ0Rf
TF9XUiwgdENDRF9MX1dSMiwgdFJUUCwgdENDRF9NLCB0Q0NEX01fV1IsIHRDQ0RfTV9XVFIgdGlt
aW5ncwpoYXZlIGJlZW4gYWRkZWQKLSBWRERRIGFuZCBWUFAgdm9sdGFnZXMgYWRkZWQKLSBVc2Fn
ZXMgb2YgRERSNCByb3VuZGluZyBoYXMgYmVlbiByZXBsYWNlZCB3aXRoIGNvcnJlY3QgRERSNSBy
b3VuZGluZwotIEFkZGVkIGEgc3RhbmRhcmQgc3BlZWQgKDkyMDApIGZvdW5kIGluIEpFU0Q0MDAt
NUQuMDEKLSBUaGUgdGltaW5ncyBoYXZlIGJlZW4gcmVhcnJhbmdlZCBpbiBvcmRlciBvZiBhZGRy
ZXNzCi0gVGhlIHRleHQgZm9yIHRoZSB0aW1pbmdzIGhhcyBiZWVuIHVwZGF0ZWQgdG8gbW9yZSBh
Y2N1cmF0ZWx5IHJlZmxlY3QKdGhlIEpFREVDIHNwZWMKLSBQYXRjaGVzIDYgYW5kIDggaGF2ZSBi
ZWVuIGFkZGVkIChgcHJpbnRzMmAgKyBYTVAvRVhQTyBzdXBwb3J0KQotIEVycm9yIGxvZyBzdXBw
b3J0IChwcmV2aW91c2x5IHBhdGNoIDYsIG5vdyA3KSBoYXMgYmVlbiBpbXByb3ZlZAotIENvbW1l
bnRzIGluIHBhdGNoIDEgaGF2ZSBiZWVuIHVwZGF0ZWQgd2l0aCBERFI1IGluZm8KLSBTb21lIHBh
dGNoIG1lc3NhZ2VzIGhhdmUgYmVlbiBjaGFuZ2VkIHNsaWdodGx5Ci0gTGluayB0byB2MjogaHR0
cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjUxMTA2MDIxMzU2LjIwODk4Ni0xLXMuaG9ydmF0aEBv
dXRsb29rLmNvbS5hdQoKQ2hhbmdlcyBpbiB2MjoKVjIgaGFzIGJlZW4gcmViYXNlZCBvbnRvIG1h
c3RlciwgYW5kIHBhdGNoIDEgaGFzIGJlZW4gdXBkYXRlZCB0byBjaGVjawpieXRlIDIgZm9yIERE
UjUgaWRlbnRpZmljYXRpb24sIG5vdCBqdXN0IGJ5dGUgMCwgYW5kIHRoZSBjb21taXQKbWVzc2Fn
ZXMgaGF2ZSBiZWVuIG1hZGUgbW9yZSBmb3JtYWwuCi0gTGluayB0byB2MTogaHR0cHM6Ly9wYXRj
aC5tc2dpZC5saW5rLzIwMjQxMTE0LWRlY29kZS1kZHI1LXYxLTAtMGVkMmRiOGVmMzBmQG91dGxv
b2suY29tLmF1CgotLS0KU3RlcGhlbiBIb3J2YXRoICg4KToKICAgICAgZGVjb2RlLWRpbW1zOiBJ
bXBsZW1lbnQgRERSNSBjaGVja3N1bSBwYXJzaW5nCiAgICAgIGRlY29kZS1kaW1tczogRGVjb2Rl
IEREUjUgTWFudWZhY3R1cmVyIERhdGEKICAgICAgZGVjb2RlLWRpbW1zOiBEZWNvZGUgdGltaW5n
cyBhbmQgb3RoZXIgZGF0YSBmb3IgRERSNQogICAgICBkZWNvZGUtZGltbXM6IERlY29kZSBERFI1
IGNvbW1vbiBtb2R1bGUgaW5mb3JtYXRpb24KICAgICAgZGVjb2RlLWRpbW1zOiBBZGQgYmFzaWMg
ZGVjb2Rpbmcgb2YgdHlwZSBzcGVjaWZpYyBpbmZvcm1hdGlvbiBmb3IgRERSNQogICAgICBkZWNv
ZGUtZGltbXM6IEFkZCBzZWNvbmQgbGV2ZWwgc2VwYXJhdG9yCiAgICAgIGRlY29kZS1kaW1tczog
RGVjb2RlIEREUjUgZXJyb3IgbG9nCiAgICAgIGRlY29kZS1kaW1tczogQWRkIEREUjUgWE1QIDMu
MCBhbmQgRVhQTyBkZWNvZGluZwoKIGVlcHJvbS9kZWNvZGUtZGltbXMgfCA4NDAgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5n
ZWQsIDgzNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQotLS0KYmFzZS1jb21taXQ6IDU4
NTJmNTM3NWVlYTZjYTlkYWJmMzFmNDc3MmNiOGI4ZWNjOTA1ZDgKY2hhbmdlLWlkOiAyMDI2MDYy
NC1kZHI1LThmMzU3MDBhNmE1MAoKQmVzdCByZWdhcmRzLAotLSAgClN0ZXBoZW4gSG9ydmF0aCA8
cy5ob3J2YXRoQG91dGxvb2suY29tLmF1PgoK
