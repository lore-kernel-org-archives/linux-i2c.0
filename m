Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010072.outbound.protection.outlook.com [52.103.72.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C17304BB2
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717017; cv=fail; b=EawOcFtihQqopbAWGqKrzXdX1ZyIv3ug3FDS9wFBkPr9KAinV3B4aiRvNtzyhdUfN5N7d0V0Nd7xBvgKxGxyIICZgmfBajidHxNch+rUDi/A3wGiSOaT0n3FedkqGAVWcTCDTkgGSfhEYWf2w1GjExc1vNNPGL5i7sdrrWACvcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717017; c=relaxed/simple;
	bh=8V8MOjQ/XdGHv03bJ39qU7+U2yAVlx+FVnfFeVxq1CU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jLwLugvp6mSHf/lstCwjSfRyxpE7tzjF+hszs+y/VL+zSHPzl4i6yKlHwT6ztac5Epls9Q/1dqLd8JE1A4/Ic5E37nPp1GsTXP0iz804GJhc5qvlFtYMpjisZ3edrh4M7WAcoo7h7Scpky82RMc/VbkZLKNohMxp2acKhSA59F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=ghc57ytw; arc=fail smtp.client-ip=52.103.72.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="ghc57ytw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhfGs68EZ3m2d/tLeegq0/0dU7M8e9FNeyZldcBCUfWGMpUyCqp+54lNQbIHHo3R27n+iwUGWo9bbBThAmXXhqlqg/DQMmJitaDNjM+ZB4e9BqW/RHgwpwp+IgbHbYzWjfdbuuHOG/6sKrM85M5SPF1T4ODhSP/HecDdTromzpkQZ5NdEDxePstiUFPQA+Bzqk3xGBV6eJCgfwqnd5PzJyXjOVbybJDKxf4eW+pVclb+larLuTHNT5nmN8r41xuh8WDZqF+NRmHOrzkS4i3OVdHJheGqAQ2E63fZSkGoc2peh0DbgTz/oUFppIO9qvGKQNcO75MLXZtWsBy2+1M24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V8MOjQ/XdGHv03bJ39qU7+U2yAVlx+FVnfFeVxq1CU=;
 b=iajHlm7hhJJVIZ1tPy4DoCu6joKxzxdP1Qq/9gE0ZA1teq46BZxY8lzoic27wGMnJVEOZxCG7EZArU62G6nrS71IfrfkhuHALTFp6wat6zmT7cBVodyUJNjyC4BajepSO4h5BbN0+AYrKtnilEjv06z0mORmbeSf7yLGfkqCKzLH2MA32ydSvkPvWTv+DaNd+XqppM19vuM9rZ5BvgMkSAtSj0Qh6ddBJHETT8EPpn55Li/8Pzx9YVxFD+mnVesCYzPL0DGSca47FpTUnxjpI8eDF6ccdGvw4/gu1v3qGS/7pEGmbZojh5SXxpgA5RHQmtkrSqqbe8nGhPsqjG0aDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V8MOjQ/XdGHv03bJ39qU7+U2yAVlx+FVnfFeVxq1CU=;
 b=ghc57ytwf2sw+RwsVYqNPjzWV9ZDFcgVwndtAg3RdG6m7CO2vGkGESF2HlQRGSatPhn7Hajn79PnBOUQNh4Qg/k6uo46ntF+szuTezeAOPGZbjBbwjRQhIQHr/6qypNQfwa6JLKdBegP56/0fuKtlxnQ+P75Xy7rL+0WJPRpC2htrrXPLiywkaS3ZVF+W5ZS7Bfc7kjuZSdXzJVDOfwpUf7TTsr87TmFAYHqNY7tRU2ze+z1CQ8TxifKtsX8xoU3y36OzEBJRxusrt1VDP+rFk03pMgZm/q9ucO99ecf18MMgRcyma3KJgo8oe+b0cO/OEUFbunN1f/RYtZHqMm/Xg==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by SY4PR01MB7169.ausprd01.prod.outlook.com (2603:10c6:10:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:10:08 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:10:08 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare
	<jdelvare@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>, Guenter Roeck
	<linux@roeck-us.net>, Kamil Aronowski <kamil.aronowski@3mdeb.com>
Subject: [PATCH i2c-tools v3 4/8] decode-dimms: Decode DDR5 common module
 information
Thread-Topic: [PATCH i2c-tools v3 4/8] decode-dimms: Decode DDR5 common module
 information
Thread-Index: AQHdB5ZR+8W+IdDzPE+0Uu3ZWYQasA==
Date: Mon, 29 Jun 2026 07:10:08 +0000
Message-ID: <20260629-ddr5-v3-4-07f45075a51a@outlook.com.au>
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
In-Reply-To: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|SY4PR01MB7169:EE_
x-ms-office365-filtering-correlation-id: 017b34ca-557d-4ec3-78ce-08ded5ad73d1
x-ms-exchange-slblob-mailprops:
 5fu/r660v9Mj6U6kz+12O9pZy2TuKGHDAJ4dXxtC/ffc6AZssrH1yaoE8fFuDoykFF+ccExFyIRNmcpn4mtER1a1TGsinZk/RCvp3wkmFMUUJ9B4UbTmikBwd0bdCMUrOCkErYDdABYs6ES1lzjcEmbI/yuGLtCSKZbFDUVc0sE1/nkE+LpbIEMkbdtsckzLiTACh6mDBVGWPlX8qg4hm9qTSA26WhVZtZ1t0HJVbPrSN2DMUOQgbDwN/4kqD9epV4LhEifInjtLJDYImLsE7D6+cJ1XLyT7DDyp7l2nxDL06nVjXpe10EzhOtNz0eINzdg/Xut4/4COwacnupxC581Sgpxd7Z0esXX3MukWvrqji82QBXdOQ0WWSau2kRoyvJtpDc+EjaZgEJlr9xIYv+UFddXhb69qmTmljRXEoOs0D8yRg9OwzLDrr6fgyx5V65qgowit9OBT+S/LUevJMN3xSJKY0Z0rYquLErf4kmiiOaPxxewLhz3f0zM7uQbQbdQv8dIVT61t+unuFwc+r5SWWq5KvGjGL3Yjk8o3EqJcyykWChPSFcVe8dpLichQmjKXKUcitkdCbDzBBpq54TXh99szCp4sRscaNzEdF57A52PcD+n4z2iD+z2ztb0BH5khO16UAoR9CI7CzfOGSFhSJbAVyzV6nen5YtYza3SMujhhGF0FLNzdYuEwMfHHlQ/rfLrBSoB38LUs1ccllB0hRER41Fhy5p41Lo/oCgQ=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|24021099003|31061999003|8060799015|51005399006|15080799012|19110799012|38102599003|37011999003|25010399006|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWY1SFJLM0dGMHpTTmdYZzBqTXF5L0t3aHByYlVUS2FvSTdZNHlQZXlvSHNr?=
 =?utf-8?B?NFZSenZ6TlpOeGs0a0FnY0xrMTlLNTE4ZFc5Yml3aVpnemFKek5TbG1IRDJR?=
 =?utf-8?B?ZVBVdit2QkpXT2hDZWxOcHNFM042TDNjSDZ1b2ZLK3ZmdkhiWFZRS0Nrbnp1?=
 =?utf-8?B?d0hiVUtEbiszWVRPZXcvYnU4MkFmeGRsTmY0cEpaWmN0T2hNamtaNUpVUHpG?=
 =?utf-8?B?bXo2REhBZVROMS9vMHV3QWk5QUc3dTNRM3A3ZUdVZm9VTGR0anJaZTJicGdT?=
 =?utf-8?B?MUgyZ1U3dG92SExQZlE5VVZ0cnFnMU5ndnZiY1ZrUUVIOUw5Y0g1aHNoOXlw?=
 =?utf-8?B?b1JUSkJBVVdpRnBhRGxhRnVUeWt6Tm9ZMkZ0WHNvaHlHWHJUTVhqbG5UQ2dB?=
 =?utf-8?B?eHFLcTR1bWhzNE9LQjRVOWN5a2FKVFRCNU1qUHdwN1lWVHo2eDVzU2diUyth?=
 =?utf-8?B?VXhWcXQxanMyejloeUpRTXRaQXl0Ly9NL0pLMTJNb3JLY1REYmlRaDVZVHdV?=
 =?utf-8?B?b1k0cU5ubHlRdm44cytEQldCSS9ISXV0Y3pzUGs3T05Gei92MUR1WU16L0pJ?=
 =?utf-8?B?WGI3NS9RdWhaQkdoRWdBT0JIVGlNUXdIaHhDczd4SUh0NE42RDk3L3NwQzNB?=
 =?utf-8?B?NEtTUlNycFBUZDhNcEE4dUtJSEhLcXc4SExQTGJWMVJ6VkJLMytpUlI5TWp6?=
 =?utf-8?B?eWhtWnpINFlNTTZFdlY2WVh1S0dvdUFXRXBwYnc3ZXlKQWszNXlsQVBia2M0?=
 =?utf-8?B?Q0ZhakNhcmNCb1QzVTdwbEFnTXlpbEhLY1RYeGEvYVRLWDJBMHlRUEdibnRT?=
 =?utf-8?B?SWJCQ202RW5KRG1qek9uRW1uREpvQTlNM0tiT1h2bDk2KzR5dHZWT1ZyS1cv?=
 =?utf-8?B?STB6KzV0MzdTQnJUUzRoSVYvRXhRSkdRQlY3VHRsa1ExTUtOYUJPMlNZTEc1?=
 =?utf-8?B?bDIvM2FzZlNOcW9GRnhkSytCZFIrQnlpRVdyR1RHTGk1T1JodVVHajNRdyti?=
 =?utf-8?B?bGtNTzFTVEVPclRWMnFZeUJrQUdRSGovc3JSVU84UFUvaXYxT1VYZGxBYWx3?=
 =?utf-8?B?Y0lYY1JoZ3JIYjhiQjFDV2w2NDFHbmxoZ1krRVlackZjV0xzVzZpV25yYWJX?=
 =?utf-8?B?WVV0S2ZrbitCQlJ6R2xZaGU5M0lIU1NYZlRNQlY3Z1NWa0lCaVpib0xzWmRo?=
 =?utf-8?B?UFBWVDlSOTNOZnAzcE04alI0WUhtblQ3RVAzZW14dG5ORVBNU3dQSjRDY0JJ?=
 =?utf-8?B?QW5FdENjcjI0RE1mZlZCejhjcTVJUk9qZnRUZWIyczcwWVE1MjVhWElGNUxP?=
 =?utf-8?B?VFExUThWN01yZVg4N1lKdXprcHVwYStzcWFQQ3BIcy9OTDJDdEpZOGF5NFdj?=
 =?utf-8?B?d0VxY1lZSVZPTkE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGtwNS9JaGFSSWhmdGRMajB4aFJRVmdhRC9ZMFBCVHVHSDdaK2I2NWwxZ01G?=
 =?utf-8?B?Q0xzRU5Dc0tPUUNiNmFsa0JaM0d3R0doTFpFVy9rTTQ5d0dPUzltYWpEL3ZO?=
 =?utf-8?B?RUpEK3pVMThjWWN2d3NzeGlNM1FkaFJ5Z0N4L1BERVJIMm9CWTk1cTloVGhN?=
 =?utf-8?B?SEI1TlA4QVRySS9KemlpTm1aOHppZ2w0bk84S2xDRHZXa1k0bW93ZHJnNE8v?=
 =?utf-8?B?eENIQSsyMVljd2xvLzgwNG1YQ1FPeWFZYmV3VTU2MStYYjVITFN1VDZaWnI1?=
 =?utf-8?B?dGEwSmhaNVdaNThxUjlQS2d6cjdzcERHb3dZVGluQVpvWEZtNjMxVXRMOG1L?=
 =?utf-8?B?MVorYmMwMHU5cTFXS01WZzFjWFNiVTNjRnRsTjhLMzdOck1ZR0NhM0k5YWNw?=
 =?utf-8?B?eUl2eU1GWjFLZVQySDN6VVJJdVFKSU1aT01hbldPbU9sQVJxcUdJakpyM21Z?=
 =?utf-8?B?WmdLODVrZGRDRTZRLzF3c1gzWnB2RXdmS0wxMmxNeEwwRjhqY1JNejZNZXJE?=
 =?utf-8?B?QkdLeWk2Mmlqcmczdk81Z0RzOXZDTVJuTFdJcW9OVWNsVHNnUWpDakNNQ0NR?=
 =?utf-8?B?cy9vMEV6cXByRXdvV1IrYWc5blpqNVBSL0FnUFNhYXFNNUdjYUNmU2dtTlU2?=
 =?utf-8?B?WVQ3cDZPd3pEbEJiL1lOZFRlaEdsMkRGWTdvdmliZSttZzJmYjVDSXRua2o0?=
 =?utf-8?B?cm1wNEJnV0Zkc3dvMUlKQXBFWU9zejZ1K0ZrbzhIc1JrUUYrWU1memc5ZTBZ?=
 =?utf-8?B?YWdHVmV2ZzRyY3FvQ2pha2tSRWNVTFg4dm41eWVsd0xWZURoSTQyT05rQ09V?=
 =?utf-8?B?TjFPaFlDbS9lRUVNMHRhVWdOb0lDVk9vbmlIWGxsYklBRG00Z3JOdWxyWU5s?=
 =?utf-8?B?Y2pGYVFxVTVRSVFaWEZDWUFUcm5nU0FIK1pMTzVSdGpvV2pXZWtHTE8rNGNT?=
 =?utf-8?B?ZXFyaHRkMGlySytaa0xPYldIeWRwazBmeTVhRnMyV0Y1cE9TUVBWNXlQYjgv?=
 =?utf-8?B?UDgrQVJwNXlwaUo4Z0ZPcjRwNXNqT1FoeWRyWElKQWV3TFQxWXdGZk5PZWZj?=
 =?utf-8?B?WjhUbk44VWRGLzBKaHVFa3ZYZVdBY04vazVKL096S3dwUkxjbDRZS3BidVVY?=
 =?utf-8?B?L1JDL0JUZUliR3dHR0xEVzNBem5jNWdlMTY3S1NQZzFVTU4vNXJjUkc0Umxn?=
 =?utf-8?B?dGdnY0t2aTNBQnR2UHZ1Yjk0aVRwM1p2YnpFUTc1L0t6dERlYU9CSFBtc2JE?=
 =?utf-8?B?WWJJU1lHRVp4SnRtb1JqVCs2TGxwNk9FU0VOb0VNYlFKeHdScnFoRUhrWFpH?=
 =?utf-8?B?RnZGWVV2TVRpb2dESm9aQVJjaWd4YXpUQnFBampJQzZyTG1GdXQrenlJNlR2?=
 =?utf-8?B?OVRpMnllRkF1OVdUT3JONFY0dGh4dU9BMnNyY2xYUFczM0F3djNTenJEVlBi?=
 =?utf-8?B?RXRwMDR6QzhHQk02NE1JcXZOa214ejhOM3V3c2hacDRsUzltTGMyd2RLenVV?=
 =?utf-8?B?MWRVVUg3MUZkZWNjNmhSaDB1MCtZUEhkMUN6M1U0QUJMOTNyUEpGK2p1cUVK?=
 =?utf-8?B?V1dFUlpOMWdPSFBQTmF6Q01HbkYrak1QUEFFekV5Wm9zdUxCN3d5ell4TnZD?=
 =?utf-8?B?TVlYUklwTUMza3JuK1AyT2V3VERJQzlWK2wyM0lSMk1JbjdUeFRKTTBMWVlT?=
 =?utf-8?B?OVBDMG5CSEFISHpKQUdrZGRzSFlXM241U1VBRmZPWHhyaGNNdTJ0SHNtWHB5?=
 =?utf-8?B?N09lQTF2Q2RkdEZBOVYyWUIyTk5laWp0N1hiQVR5cmVidGtIZGNZYlhHSDdK?=
 =?utf-8?B?cUl3eDRzbndRSm93SGVCU20xM1RLbW1YTFdXK2tRbHdLcVU3TmhwMS9Jcjhp?=
 =?utf-8?Q?E2UsC9PjfOEM4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58DB88A52012F44C989984199F272EA8@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 017b34ca-557d-4ec3-78ce-08ded5ad73d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 07:10:08.1696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB7169

RGVjb2RlIHRoZSBleHRyYSBtYW51ZmFjdHVyZXIgaW5mb3JtYXRpb24gdGhhdCB3YXMgbWVudGlv
bmVkIGluIGEKcHJldmlvdXMgcGF0Y2gsIGJ1dCBvbmx5IHRoZSBpbmZvIHRoYXQgaXMgY29tbW9u
IGJldHdlZW4gYWxsIEREUjUgbWVtb3J5Cm1vZHVsZXMuCgpUaGUgcGh5c2ljYWwgc2l6ZSBpcyBu
b3cgaW1wbGVtZW50ZWQgdG9vLgoKU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIb3J2YXRoIDxzLmhv
cnZhdGhAb3V0bG9vay5jb20uYXU+Ci0tLQogZWVwcm9tL2RlY29kZS1kaW1tcyB8IDM2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDM2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9lZXByb20vZGVjb2RlLWRpbW1zIGIvZWVwcm9tL2RlY29k
ZS1kaW1tcwppbmRleCA0ZjljNGYwLi4yNTBmZjg0IDEwMDc1NQotLS0gYS9lZXByb20vZGVjb2Rl
LWRpbW1zCisrKyBiL2VlcHJvbS9kZWNvZGUtZGltbXMKQEAgLTI0MDAsNiArMjQwMCw0MiBAQCBz
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
