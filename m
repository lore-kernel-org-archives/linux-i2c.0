Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012071.outbound.protection.outlook.com [52.103.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1035439F74
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814028; cv=fail; b=qlnh6fAduumNojd/VcaUa1KXMhpzd/sdtxwvO9ddwgxdHGS9Ds17nV3yr55tkHJsutjOqkVGfx6yjJBS87iOxz+27o5ZQiwPvyyckGVCAbQnEav1L+Cg9TOsNcolsqLEQMfoG7ujESea9M6Mt9IoEV50GaCFnxBxzzXo5QtcwyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814028; c=relaxed/simple;
	bh=pl85on6eWbPPPfxygtSP3+Hx9GgQStRyeDMVSpBlRd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aGz8gCjPT/YNWCZZOcRd5wXEWEiQiNTxJMq8caKyvS5mNBsjxLRGJXgTsEJ1PBsZ0tAHVXb2JL3SDVK5NMwmBCcs2eZXxrhgtF8q0tNrXAuYfdbbMwcaeuRsnE3sxgjGhrKnvwVJeO8sldbUn4FkqlLG64eQA02nXaPe8pUAkJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=RLJuowj+; arc=fail smtp.client-ip=52.103.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="RLJuowj+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRVrJunGWUsXuDG9cXzSNnIGyQFL2tsE4s0CVVA2Eut+8s3ENvYnStWDo6EbvlFyuyvTO8ngRTrTvDuEQWHgQ3qGi42N6pZgoxUDZYeolooU03pS2KP0zuf42XT+k4ReUL60kBjhMvcWK9X3ipxBwksb2UtfYlvaV+K5hDS8/EynK2DqJcTt+xvMWXuPqgyueWGfBYO8vydwFjKT7jfzGaaRcfRZc8eY3SeYz4KRurRiqsUOfSHj4GMiM/daiVNoerMG1tRFFlk2xnOmQ22I1AaUGUBsIYByZILjrGDPEaz76Sd1DRi3lkyYgttgD/OlN7eI7qC8XwOOEox4sUbLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl85on6eWbPPPfxygtSP3+Hx9GgQStRyeDMVSpBlRd4=;
 b=BcvjWcqALfWUFk6fNFj7SrIM9faXjjRLyQUr84EOpf+K7d84nBDDEQcKn01G+jXd5CbZ2RiiKL6jFc+Ni+wjCloxeYtBB0hB2+RZBjSYxWjkeqywQWn0Jt16fApHQR9wEIoJRP73Nio+GGHbP5etm/af5f/zEZr5kku/X8zzA7Y/VxZs+lPtCvdtQOPMUGLCorDIuLAq8NJ2uTrDOiMe02Lzienl4W7mkLJZScjPFALSVrnngjGt6BJHAgwJqxeeiNWPUb7wu3IpmSzXuIWeQtZuNm6UPUO4hojIWTaW9OjuSnrNKJFS5Nj+duuI+cEWse6ycfV24DOtCH9qQqtGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl85on6eWbPPPfxygtSP3+Hx9GgQStRyeDMVSpBlRd4=;
 b=RLJuowj+9D0wykkTQO0/5QRjZK4PSrRbiKwKk5gYIeBZ4sfO9Ob2CXPOFsREQ33tAKIpi4rcGai8ve80z2QgU8KzNYthhD2I7Nq6cSUN5qv0rcwDOwQf2vnlN8mMwakUMS9J0tV/+sSCCi/ZYfjvoWgiXAk14dSTQuz5PjfUQALXtr9tpPCu6CVp0+Ek6UjMhcSNu0utDPNQXn71mowz4t7X1KCLJG3rtQSH7uT4NBqTZosGLQ1qMkFDtusLm5mkJf9JxkNuRpn81kydKEhSnlClOvINyGxsrJ/+u54f/nahXKSggvLWX51tpJq7a73maPv5PtoJKYvpTk3rJXH6OA==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by MEYPR01MB7183.ausprd01.prod.outlook.com (2603:10c6:220:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:40:12 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:40:12 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare
	<jdelvare@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>, Guenter Roeck
	<linux@roeck-us.net>, Kamil Aronowski <kamil.aronowski@3mdeb.com>, Darsey
 Litzenberger <dlitz@dlitz.net>, Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH i2c-tools v4 2/8] decode-dimms: Decode DDR5 Manufacturer Data
Thread-Topic: [PATCH i2c-tools v4 2/8] decode-dimms: Decode DDR5 Manufacturer
 Data
Thread-Index: AQHdGqjJ+w3gywxzfU6rXuChCNfkGg==
Date: Thu, 23 Jul 2026 13:40:12 +0000
Message-ID: <20260723-ddr5-v4-2-d7cf78ebbbaf@outlook.com.au>
References: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
In-Reply-To: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|MEYPR01MB7183:EE_
x-ms-office365-filtering-correlation-id: ad7b5da4-df41-47d4-c6ad-08dee8bfec09
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|38102599003|15080799012|37011999003|25010399006|24021099003|8060799015|31061999003|19110799012|8062599012|440099028|3412199025|102099032|3071699003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXUyRjRlVS9RbWdSYXZNNXJQSGh0bTZRbGtuWEdXeHpoL2NyS0NObzFhTUJz?=
 =?utf-8?B?SWZjL2FwL3BDNWdtRTdYU2FOQzU1cFFyenpvaUJ5eEhWemNucy93MW5tVEhj?=
 =?utf-8?B?V1kvMVo1NHA1V1RleDFrcytWSlc5ME9kV093TjB3UWZPQzFHTUkwemhpd1lL?=
 =?utf-8?B?RTI5Rmpuc0NndkhTWGVjaGVONTR4S1pnek05SkZtRmg4eW8yYXNzSkZXaXJw?=
 =?utf-8?B?V0Y0SjNEK2tHMnJ6bmNCR0xNbkR0TUp2T2hjVS8yTk1vZmt0TkVQU3ZkbEth?=
 =?utf-8?B?M0dRVVNrOGRBVDJJZFVoNmdKVHZMZXJOc3VnREZiSGZSTGk1d3lEMU5KZllv?=
 =?utf-8?B?cGhnZThMUUpubHNlZmFjT0UwTS9uRHNVbkthREx2TmkxWndJTnQ0WHdoMnRB?=
 =?utf-8?B?bWxEYTZmVHNYTUhpeTVZQStCdUI2Z3l6OWl6MWdRcklFejFGeVFkWFZrb2li?=
 =?utf-8?B?azF4amVJOXlKNlAwWEhhbGR0RUpFOGhFa1E1M3RxZkJDQk1aQVBnRzFkME5n?=
 =?utf-8?B?NTlZTytaVUtwNEhWNHRBTXgzMHFLemtiN0taTlhzcDBMa21ldG52bHNaYjli?=
 =?utf-8?B?UmxkcUxPSGJrTWEwaFNCV2VEcTJyT3owNEFDc3Q4a24wTEZjaW13Wk1qeFY0?=
 =?utf-8?B?Z3B2QW0zY0VUV3lPZTRVb21IK0ttQmJPWE1SVDNZT2lVeWJEbVAwR1A4dUZJ?=
 =?utf-8?B?ZXhlci9vYjd1R2RYS3ZLc3ZySkRsSnFQczJMNk9hQnVTRVRHSVdBYjBkdmFt?=
 =?utf-8?B?RUVEVERKNm1sMlZielpjcnk5QUFya2wxLzEyVjgvMTBSZCtjb09LZmFWdHhQ?=
 =?utf-8?B?WXJ4amRUN0tuek0xeHczTHJUSTNFejhOYTNsVjljWUoySHlHN0dHTW5LT3Np?=
 =?utf-8?B?MTVjdmFUUFBMc0tRVEU3Q3AvL2VjNWpwZ3JOWEl5cTBnSWl0Y3Z6OHFYZXVh?=
 =?utf-8?B?Wk5yVzRWSEVLVkhRNWg0VVBvcS95a0IrbGRGR2E0RzEzem4zSnpGcHJxU25R?=
 =?utf-8?B?RVZNZWIrQmp5V0pHWFloRXJad1V6azRUNTVmQ1lHUmRvYnBGTGtsMVZidDlP?=
 =?utf-8?B?bW42dG5LNEl2bWJpSGFSbXlHdnBXNHJEYUlzd1ExZjdVUktUdVArQ2dqVlQz?=
 =?utf-8?B?aE1SQS9XYndHL1h1Zkw3c08rWlFQVy8ra21BYldIRWRITGJSbTlvSGVGM3Uv?=
 =?utf-8?B?T1drbmxML0Y3RE90RVY5bUkrQ1Q3YUNjUjNQNnlielRxTDA1V2YrTnI1TFA2?=
 =?utf-8?B?bnJPZGxaUHZGRVhWR0hRbmpIVTN5Q0RsT2lkOGtrdHZkbFFiSXBNYmdzQ21k?=
 =?utf-8?B?enowNFF0MW9Qd2FhWWdPVDIxcFZqcnlTaFd6bnFEZjJhWGh5QkdZUlptZ1RP?=
 =?utf-8?B?MmoxcG1FeG5HMnc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFlhcjJ1b2FBaGhzSnZlVlJyZDV0dnpadHExMHdxbTdSVVprR3EyVjdUMXA1?=
 =?utf-8?B?TnR5RzdLa2o3bnhNVzR6RkZyWCtnTXZwcFdWSTFGazJFckRtekhqQ2E0dkJ2?=
 =?utf-8?B?b1A5aEFXTDJOTzdKa3R3T0t0eVBkazYwVmtPT2hEaVpHbW1VcGxVZlllTlNl?=
 =?utf-8?B?TTBiZ3JBZXRyRlBoUThWKzlxdVMwSTJ6dGZOSVRUTCtrNXRIMmJpREQ0MDM2?=
 =?utf-8?B?ZG5ic0dSMTBuOUNZNXQ2dm95UUR5NjhydWdTM091TmxxTDRBRTVsczJJckZr?=
 =?utf-8?B?bU1FRmpaalNjMHJpazgrREJta3RjVHQxdmkxOUFGZHFMUlJNa1RwUnYrT3VH?=
 =?utf-8?B?RW1xSmd6UGEwcXZOcVFZWXBYMXhoOUZuTGk0VTVmOEpqL0RNcWF5dUF5U3VK?=
 =?utf-8?B?KzNMUkpNcnAwZkZudDhlUWJic0xHSndhNkgxVVZtKzEyMDIzK3ZkditaKzhB?=
 =?utf-8?B?M2d2LzRYNkVuTDB1UFV0NTgyRERuUGpMOExFWEljMVR4azNFRkppTHNvaUtu?=
 =?utf-8?B?N3RFT3V3QXdTL1FDRUthM1E5YlRIZk96OGNjS09HVm5RZis4aU5iaHhUMlha?=
 =?utf-8?B?UDRtMHBnWGhyVU4vUGxtMlBxellTczdiWTRRMTA4R1FUK3g1VzFlendVRDJT?=
 =?utf-8?B?M0NaeTY2L0Z1eFdGKys2bXE3L1J0bDVGVXU5azg5VkVLbFpxaWtXT29uNXZJ?=
 =?utf-8?B?Q1FTTWlyT2UyUW9DT1AxaGVlVjhMdDJvOTFER3JwQmhNOW9NbW9STDRCVWhW?=
 =?utf-8?B?cHRzc21HK2hVN1FpRzI1ZWhHd01lYWY2cFVaVkNPTDJYRGYvSXpKT2JOS3Nv?=
 =?utf-8?B?TjRGZXBwZnppNlo5OFFKTXlDK09YSjJnNURSWWdRS3ZnRERDUzVPdnRHRTM0?=
 =?utf-8?B?UUhCZzlzZFZTVWJTUjZlbERjU3VZdi9ZK1hrT1ZsOGRsMXE2am94M0NmdDIy?=
 =?utf-8?B?dWhiTDZsOEp5bFRaRkY2Z0JwUW9xRVBtbm9wTDBCVU5EbmxGb05qbThCV2p5?=
 =?utf-8?B?TGdSajNsdWZlQWZDSElVQXFBZSs4SDhqYkJHKzVuUitSQUZhWW5yeEI2ckov?=
 =?utf-8?B?S2FUNDNoNExNeUlGWDRlaG53S3NjamxHdWc0dzFBOFg1bUxjSEFVOGo2N0Fy?=
 =?utf-8?B?MkVUVU05SFNab28rblBxL1Iycnc1c3Q5SGRyL0ZtaGxSd2x6NmpFT2Qwb2Zs?=
 =?utf-8?B?dmUxcmg5OEJUTzc4cktmTk9Qck5UNmpmamlFL1lkaWhncDU5VFNNY0l1S2tV?=
 =?utf-8?B?c2lBRXgzbklTdm52Ynk4OXhQNTVZTitoQ2Jqa1dNQ01xdFNEMUk0SDVjRDFQ?=
 =?utf-8?B?OXhYTkJkYy93U1RoSkl4ZVY5TDUycFRjWGZ6K3BvcUh5Wkk5TjB0YVAvc3V6?=
 =?utf-8?B?Vlg1VEp2eHdrWUljSUlVMG41c2FyVnVDalpoYnBseEx3bFpvOGsxdEN1dUlD?=
 =?utf-8?B?cXBHTXVpRVFkLzQ3UG5OTHNtb3BidVVNbENWN3JhNlE2ZzdJMXByWVN2YVhJ?=
 =?utf-8?B?VHFsQkUrbHZTdVRPUitYditXby9WRnRBSEV4SFNCUGNvb0phL0s2a2JPMDdv?=
 =?utf-8?B?SlRYdFRrTVFsVlRqK2krdGdDa0ZqZDdXeC9GV1N5eEM4Vkx4ZCtyVERwbGpX?=
 =?utf-8?B?SWcvQk83V3ZBS05JcTdiRE9MMjR0Tkovek1wRUs4ZmFrT1JYVmpETDNzWFVD?=
 =?utf-8?B?anF6aHZOK2QxWnJscmFlSGFjSW5GcTJRNmJhMmtzVVo4RDlneWRlbjlPOFRQ?=
 =?utf-8?B?NDlvLzFkd2ljQk1HMEp6ekx2Sk9UN3c0dlJiSkRlTUpRQUtFRThNem9ZL1gw?=
 =?utf-8?B?M21jSFVGK0FWSVZWWEp1YlhaYVVxT095eWF0MHJqRk1sV0c1U1hiNVdaM0o0?=
 =?utf-8?Q?+SWRIawp2MY5W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F48B5EE8610DC1408B0F761C73D451FE@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7b5da4-df41-47d4-c6ad-08dee8bfec09
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 13:40:12.9077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB7183

RGVjb2RlIHRoZSBEUkFNJ3MgbWFudWZhY3R1cmVyIGRhdGEgZm9yIEREUjUuClRoZXJlIGFyZSBt
b3JlIG1hbnVmYWN0dXJlcnMgaW4gdGhlIGNvbW1vbiBhbmQgdHlwZSBzcGVjaWZpYyBzZWN0aW9u
cywKYnV0IG9ubHkgdGhlICdNYW51ZmFjdHVyaW5nIEluZm9ybWF0aW9uJyBzZWN0aW9uIG9mIHRo
ZSBlZXByb20gaGFzIGJlZW4KaW1wbGVtZW50ZWQuCgpTaWduZWQtb2ZmLWJ5OiBTdGVwaGVuIEhv
cnZhdGggPHMuaG9ydmF0aEBvdXRsb29rLmNvbS5hdT4KLS0tCiBlZXByb20vZGVjb2RlLWRpbW1z
IHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2VlcHJvbS9k
ZWNvZGUtZGltbXMgYi9lZXByb20vZGVjb2RlLWRpbW1zCmluZGV4IDE0OTE3OGYuLjYxYmZkNTcg
MTAwNzU1Ci0tLSBhL2VlcHJvbS9kZWNvZGUtZGltbXMKKysrIGIvZWVwcm9tL2RlY29kZS1kaW1t
cwpAQCAtMjI3OSw2ICsyMjc5LDQ4IEBAIHN1YiBkZWNvZGVfZGRyNF9tZmdfZGF0YSgkKQogCQkg
ICAgc3ByaW50ZigiMHglMDJYIiwgJGJ5dGVzLT5bMzQ5XSkpOwogfQogCisjIFBhcmFtZXRlcjog
RUVQUk9NIGJ5dGVzIDAtNjM5ICh1c2luZyA1MTItNTU0KQorc3ViIGRlY29kZV9kZHI1X21mZ19k
YXRhKCQpCit7CisJbXkgJGJ5dGVzID0gc2hpZnQ7CisKKwlwcmludHMoIk1hbnVmYWN0dXJlciBE
YXRhIik7CisKKwlwcmludGwoIk1vZHVsZSBNYW51ZmFjdHVyZXIiLAorCSAgICAgICBtYW51ZmFj
dHVyZXJfZGRyMygkYnl0ZXMtPls1MTJdLCAkYnl0ZXMtPls1MTNdKSk7CisKKwlwcmludGxfY29u
ZChzcGRfd3JpdHRlbihAeyRieXRlc31bNTUyLi41NTNdKSwKKwkJICAgICJEUkFNIE1hbnVmYWN0
dXJlciIsCisJCSAgICBtYW51ZmFjdHVyZXJfZGRyMygkYnl0ZXMtPls1NTJdLCAkYnl0ZXMtPls1
NTNdKSk7CisKKwlwcmludGxfbWZnX2xvY2F0aW9uX2NvZGUoJGJ5dGVzLT5bNTE0XSk7CisKKwlw
cmludGxfY29uZChzcGRfd3JpdHRlbihAeyRieXRlc31bNTE1Li41MTZdKSwKKwkJICAgICJNYW51
ZmFjdHVyaW5nIERhdGUiLAorCQkgICAgbWFudWZhY3R1cmVfZGF0ZSgkYnl0ZXMtPls1MTVdLCAk
Ynl0ZXMtPls1MTZdKSk7CisKKwlwcmludGxfbWZnX2Fzc2VtYmx5X3NlcmlhbChAeyRieXRlc31b
NTE3Li41MjBdKTsKKworCXByaW50bCgiUGFydCBOdW1iZXIiLCBwYXJ0X251bWJlcihAeyRieXRl
c31bNTIxLi41NTBdKSk7CisKKwlwcmludGxfY29uZChzcGRfd3JpdHRlbihAeyRieXRlc31bNTUx
XSksCisJCSAgICAiUmV2aXNpb24gQ29kZSIsCisJCSAgICBzcHJpbnRmKCIweCUwMlgiLCAkYnl0
ZXMtPls1NTFdKSk7CisKKwlpZiAoJGJ5dGVzLT5bNTU0XSAhPSAweGZmKSB7CisJCSMgRFJBTSBT
dGVwcGluZyBtYXkgYmUgYSBudW1iZXIgb3IgYW4gdXBwZXJjYXNlIEFTQ0lJIGxldHRlcgorCQkj
IDB4MDAtMHhmZSBpcyB2YWxpZCwgMHhmZiBpcyBpbnZhbGlkCisJCW15ICRzdGVwcGluZyA9ICRi
eXRlcy0+WzU1NF07CisJCWlmICgkc3RlcHBpbmcgPCAweDQxIHx8ICRzdGVwcGluZyA+IDB4NWEp
IHsKKwkJCXByaW50bCgiRFJBTSBTdGVwcGluZyIsCisJCQkgICAgICAgc3ByaW50ZigiMHglMDJY
IiwgJHN0ZXBwaW5nKSk7CisJCX0gZWxzZSB7CisJCQlwcmludGwoIkRSQU0gU3RlcHBpbmciLAor
CQkJICAgICAgIHNwcmludGYoIiVjIiwgJHN0ZXBwaW5nKSk7CisJCX0KKwl9Cit9CisKICMgUGFy
YW1ldGVyOiBFRVBST00gYnl0ZXMgMC0xMjcgKHVzaW5nIDY0LTk4KQogc3ViIGRlY29kZV9tYW51
ZmFjdHVyaW5nX2luZm9ybWF0aW9uKCQpCiB7CkBAIC0yODMxLDYgKzI4NzMsMTUgQEAgZm9yICRj
dXJyZW50ICgwIC4uICQjZGltbSkgewogCQl9IGVsc2lmICghJHVzZV9oZXhkdW1wICYmICRkaW1t
WyRjdXJyZW50XS0+e2RyaXZlcn0gbmUgImVlMTAwNCIpIHsKIAkJCXByaW50IFNUREVSUiAiSElO
VDogWW91IHNob3VsZCBiZSB1c2luZyB0aGUgZWUxMDA0IGRyaXZlciBpbnN0ZWFkIG9mIHRoZSAk
ZGltbVskY3VycmVudF0tPntkcml2ZXJ9IGRyaXZlclxuIjsKIAkJfQorCX0gZWxzaWYgKCR0eXBl
IGVxICJERFI1IFNEUkFNIiB8fAorCQkgJHR5cGUgZXEgIkxQRERSNSBTRFJBTSIgfHwKKwkJICR0
eXBlIGVxICJERFI1IE5WRElNTS1QIiB8fAorCQkgJHR5cGUgZXEgIkxQRERSNVggU0RSQU0iKSB7
CisJCWlmIChAYnl0ZXMgPj0gNjQwKSB7CisJCQkjIERlY29kZSBERFI1LXNwZWNpZmljIG1hbnVm
YWN0dXJpbmcgZGF0YSBpbiBieXRlcworCQkJIyA1MTItNjM5CisJCQlkZWNvZGVfZGRyNV9tZmdf
ZGF0YShcQGJ5dGVzKTsKKwkJfQogCX0gZWxzZSB7CiAJCSMgRGVjb2RlIG5leHQgMzUgYnl0ZXMg
KDY0LTk4LCBjb21tb24gdG8gbW9zdAogCQkjIG1lbW9yeSB0eXBlcykKCi0tIAoyLjUzLjAKCg==
