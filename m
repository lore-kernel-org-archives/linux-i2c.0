Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010003.outbound.protection.outlook.com [52.103.73.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF563BCD00
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716998; cv=fail; b=rjoHbFWYQZg6CAgVZmmzlSX3YW86HHaeNnu+BeW27RQiukS5p3BCaQPinIytb0jJW1YrKT05DsZnVjB3Vbz2wwmGSnBscIBOoKMDGtSwIsOKYiGmrHCtZGXfOHxnH3+25emhrvFhYCuQqv5ayqAVDCGQZmUI6ABTQ3tAoE8Z0NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716998; c=relaxed/simple;
	bh=mWPD9nD6V5Pmi+xhpfbdPLftt6iTAHBhv9McqbTauHs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V2AunYEBsllFLinXvpP/ULsXJu9ophkxNkbyxAop7WjxtM4mTCxcNL0Rw7R4VJxhgdLQ2R+CuAJ9I22lbPK2Y61eDeDHEcfBZRe8sBAAX8N3/wehrj/tVhLyOFsicdvInoPjSRK1YOo3roMurNAeO10vgAc9DrxinZgjGEhoNMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=mRI+GLuF; arc=fail smtp.client-ip=52.103.73.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="mRI+GLuF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDH1vH1hamrMKX+tycn82MczQ6qaY3uutwIDPLTaMYjx2UrmPh4qLkIQriyA0X/RSU3vMijVLNI12hMqLkPbonj3lBoA83mt0/wyhslS6iplwUwAJth/IwqKIya34qtF/Uf2yeUEc3+ZrYWUnmeR+D5D2UmpxHXOT32CuMtxKUO1lc73bWCrYVyYNrj2awJejy8RhV/J/XszvkOv0GKD688tVEGvcvZvAd2fIy93iwg/8j7kAfI5YjhjCBS7kv4cPqC51m1FyliwuZM5Tk6Z+RJNWXOfN+PNm1AMQZsutHNcgsqkhWsLWC7YhwDlgeal35SVzv7CBSFrm/9mxlbeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWPD9nD6V5Pmi+xhpfbdPLftt6iTAHBhv9McqbTauHs=;
 b=aspKyx7vseQvC0OdMLDniI9mnLmi4KuhOjqLReVvj3bGEkgWbLkfmi56Wen+HxUUhB5lPmWIKpE4+HMhqa3jsvhYYDYngfjSA8URcr6c+eiWdE+UTNkwd1ZqSrrUoNP2tyZRiaX39Lm5rjl/iaMRR6qpS32lRWbdWfch9L9u7dOQ+BcV9l4ISyZaYsrEnrdRvbvGZaVI+0MeM1TFAK8kyPoGybnNIglcX+wjHwvEqiREK57IVVB+kMjsAZnTKAxil3BaI+0aWs1VboJRoOyK/0XhsI5AkgCiQJ/kfzmB3BxAh2uJ5WKVrhNw0tGQCNn+MACZKp5KDdenvv9w0ocrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWPD9nD6V5Pmi+xhpfbdPLftt6iTAHBhv9McqbTauHs=;
 b=mRI+GLuFo60AcqqKdq+ZtghVPmjbNzXLJXG7XcQVUSfAQdEl7JqowVs9EmvSnAcLKfOBJeIq41mCbEyzNfiyvySTDwYsG1Ew77DllMWLNxvG/P4rNqxHhUnoMDC9rOz9KGzolnk9ukZxd4VwZXrLQ9PpInywyfy+i0rWf0rGw1aZQxDzkjLUjRNQHQHtgkUBJtwB6KYOKXanGf+fD6z+Ain6s3AkfKZcVokVuIFjgMqfoopcJ1rj10qamlh3rm71uWMgCDiPwl8pqC+rAqXiC631rLdL0C4UrBkAahMkCyYK22UFYY9qnYJ+ndcM1E026yjlujYPTrYjA+JV929c2A==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by SY4PR01MB7169.ausprd01.prod.outlook.com (2603:10c6:10:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:09:52 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:09:52 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare
	<jdelvare@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>, Guenter Roeck
	<linux@roeck-us.net>, Kamil Aronowski <kamil.aronowski@3mdeb.com>
Subject: [PATCH i2c-tools v3 0/8] decode-dimms: Implement DDR5 decoding
Thread-Topic: [PATCH i2c-tools v3 0/8] decode-dimms: Implement DDR5 decoding
Thread-Index: AQHdB5ZHGZRtuI3gXU2kwumprUWakw==
Date: Mon, 29 Jun 2026 07:09:52 +0000
Message-ID: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|SY4PR01MB7169:EE_
x-ms-office365-filtering-correlation-id: f0ae0ac0-5515-4e71-4dc0-08ded5ad6aac
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|24021099003|31061999003|8060799015|8022599003|41001999006|15080799012|19110799012|38102599003|12121999013|37011999003|25010399006|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUVNM1ZuUkpEYkJSTjY2aUJPZXRIa2l4S3RHM3JBUS9SaE9TVjFHUWh3VlRq?=
 =?utf-8?B?ZEg2UWp6SVVqT0twQ21EWDRRdmRuYmhEemhoL2VvU1p6T05UKy9XOENsZjkx?=
 =?utf-8?B?UzIxVjlSaUxManJiV1NTTjNGNktQYmVQZTZhcDdma0R6aHk5ZDhGYWJxcmNr?=
 =?utf-8?B?RGlMMjJSM0tqZDgzV1hzemFtcnpHa0FIMXoyVHkwQ0lFVDhiSHdCdmMvWWx1?=
 =?utf-8?B?MlRRTm5LZ01QU25PT25pMVVRa3V0djBWKzVLbDcwZjFiL1JDYzFGUFVWRlBl?=
 =?utf-8?B?VVAyM2ZaelI1SzloWWhQRCswQVgzSlhSK0RUQkVhTS9Rcnp0eGRaOXBGaVc3?=
 =?utf-8?B?dnlVazRFOGJOZElwTzI0eDMwZ05VNVJzaVUxSFZReE4yT3ZnSkpZT20vRExv?=
 =?utf-8?B?Wnc1V0NPNm15RW8rQW5vbzJ2QyttTHQzaENRaE9Vd2lmTVF0SW1YOVJqWVJM?=
 =?utf-8?B?N2xDZGJZRC9UWmNuZGNFN1h4U2VzMHdKUVlQNWJCZDMveE9JdkJ4N1pTTDFq?=
 =?utf-8?B?U3JXa3F5elFvMVJzY1hrSmNaQ2pNK2hObXZaYzhkeGZrQnByeWtkVC85UzhK?=
 =?utf-8?B?WDU3cEFsR3cyZUh5SVQ2Q0ZNMy9NSVdZenczdTV5blFrZzQ2VnBIOS80NWhB?=
 =?utf-8?B?bnpSV0wyNmVNWUY3QkxHY3crMC9wMk5SWGo5NmZQWEdaMm9MZ1FuNkRHQkRU?=
 =?utf-8?B?YTJDUE9Vd1loUGJtM1Fjd2pIZXZEcjJPU1lGaEtvb2RPMTVUY0RxQ2MxRjZR?=
 =?utf-8?B?SVBWVUJXTnhMMmY4QTZUZHdrbitiRzRkSGczNDF0Y09pZ1I2Mmd4bWpqb0Rh?=
 =?utf-8?B?RFVHajVycVR6emJFdUpCS1ArazJxWnVHcStNZGRoc1VwYTFhampRaHFOUlJ3?=
 =?utf-8?B?bVNoQ29BMXJwOFhDV2UwUEZBWnlCeStaSnNDV1pJYWQ1b2NGeVA1dFM0aGNO?=
 =?utf-8?B?S0pQNzJnN2FIVWpSUFprbkFMNitJTm12VUp4YVYwM2ZtRVlON2pteHZ4Ujkw?=
 =?utf-8?B?Q284eEczYVhZSVZGY1AyeHVTckxrVzFFNFQwQ2xJdGd0YXhTVCtkZ3B1bFVu?=
 =?utf-8?B?bCtOdzl2SVFSbGd0dEFPVkZ6dTNkazRsbTVqcmdhanFOenRmU1dubEVqZEF6?=
 =?utf-8?B?TTJ3ZnptLzRNajdXMytUTWQ5Mmo0MjBlNWZiMDdmMTQxU2tvUjM2WGlueE9s?=
 =?utf-8?B?dnl4dmFWL3BzeDJZYXhSdExrWGV1VkJRaU1NcjQzbnQ0WUN2RSs2eEo5bGJX?=
 =?utf-8?B?aWp1MGhmbk1maDJESWdWdXJuRVJIOEtxblcwQ2ZnVDFQdnJpcXViRFkxRzAz?=
 =?utf-8?B?a1hTUEhuWURhV1NiRnh1azJkZU91OGpmbjc1SDdNb2Q4WmNTY1J4MzNGRWFC?=
 =?utf-8?B?MFJPcnFkcFplSlI1UXBhdEY5bUdNZGI0M2t3NEIxaFBtdnVhZSs4ekNZbE1k?=
 =?utf-8?Q?Vz/dZ5/D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXVudDFoais0SDdFcFZsUGthZGU3K3ZNSVdnRERwbnhZRkgxbklGZ2pINklw?=
 =?utf-8?B?VXFUeG1zck1ZNXhRbDNXQzFkMVJoY3NBUmZLTTh1YWlrRGhqU1lzTTgrTENT?=
 =?utf-8?B?eUU4Qm1MTysyOGdXT3A3cEs0V05hbWxMT1VxVWpadVRhem5TaEhqMlMwTFg5?=
 =?utf-8?B?bzdaZ0QvVUhaV3pNZk9hZFlTaE5XTzI4VGp5T2d1UENSM3hvQ2Jub2E2Nm5K?=
 =?utf-8?B?OEJMc09uMUg2RFY0bW4wbWtVZ3JzamlZZTJOWWNmRGpwamk3amxNNGRuaG9Q?=
 =?utf-8?B?cHg4OU10cmJwVjJzdWJ2T3FkUzB3aXFrZDdWeVorS1JFYkVHWmc4QndydE11?=
 =?utf-8?B?eCtFZTJQOVZpY1ZvRmd3R1NQOW5rd201RW5qWk5QbWdUcTNneFJZYTQyNnpD?=
 =?utf-8?B?K2JqUHlyd2hMMjZNZVkwdTNlL0lLL1ZnYmhPWVdTY2JpZXo3a3ZwM20rbWZx?=
 =?utf-8?B?QnVBZnEzQXROY2VDNzBqSFozR21KWWp2cXdRTFpiM05XdCtxVmNWbWdyMmFX?=
 =?utf-8?B?S2ZFU2JZWTVtNnk0QVgwbzdHSDNkQklWMExSOCsxcGpRTXZGMFNTUWtHTmlD?=
 =?utf-8?B?ZVN3UTZLTFdqK3Uwd1J2ekNJVVE1bE9MVWE1VmdiSmFkak1BdzkrM1pYTnl1?=
 =?utf-8?B?LzZwRXhlVnhNUHk0dktXenYzeGRqUkh6b1dialBqV21RM0VqL3lTSUxqcGtz?=
 =?utf-8?B?bXpWMUxVRktDWjM2dVB3WDVPdjNMZWhsOEdsMlE1T0RaQjRGbXk1V0padXhB?=
 =?utf-8?B?SUo2a0ljQjh0TVhHTFpSNWpMR0c0cXE1TGdSR01ZeHI4UHI1dEZnaGdoM0Fw?=
 =?utf-8?B?OVNSWjZsdVorTUllMUhIVGM4YzNhMHZiekR2Vk9Uak5scmc1KzU3N2J2UjhD?=
 =?utf-8?B?ZDJrbkd6WHdvMXFRSzhvNWZPNDJZRHVJMVcxeDN1YVJmcXAvWFJYM2RsaHpE?=
 =?utf-8?B?ME1MZmVJVzV4Vll1SmpISU5oMnRFYVphVDBFak9tREk2a0kvclZ5VGNHdERp?=
 =?utf-8?B?bENJZWVrcHNmMS9mb3N4a05yTDE2MzJJYm1HR2cvOTVDSE5GeEpuY0h4YW1B?=
 =?utf-8?B?TElVNkRhT1dCWDVaZXlwcTRGcHBvNXJKd1JrTi8wMFBUVzE4OWIwWUorTzZO?=
 =?utf-8?B?OE1HRm13UW1QYVZBTkZyb1J2bjA4bkNnVDU2b1h1Sm5kQSt0L2FKM0orSEps?=
 =?utf-8?B?NlRSRm04enVlRFBwODNJT0tiazVISjF4eDFLdGZZaTkxTVJ6WEd3RTVrN3Nv?=
 =?utf-8?B?eHdGVHpveUFZZ25wc05SbjlHajg3M3VUUitRZkR4SGo1SjFSaW1KWHNnd3lk?=
 =?utf-8?B?eGtKKzQrK0V2Sm0vV3RhaU42b1gwdmdSQ290OVlicmZVSERQdDNCTytHU0g1?=
 =?utf-8?B?MDdRZGVvK2k5NVBLNDlHUGg4S1lDbUhBMFFSY05TdDFBSk01QUp5anJGN3RV?=
 =?utf-8?B?dzU3SGZLY1ZMaDVUMG5WYU1XTk5pdGZ1QmoyS0U2M2JwemV1YzhadWhNYTFj?=
 =?utf-8?B?RXd5emxwaFIyRHVvYk5aZjNDdU8xYUhtU0Z3UUVSS2F4eHB1djRzK1ZmbjRu?=
 =?utf-8?B?ZXdWVUhCVFcyM1doVVhJTWRHbXBTTHhoWnpBOGcvZVY3Y2poRzhHaXBLUjBj?=
 =?utf-8?B?WitEU1l4SW1LWEpMTHZuakYyYWJqRkIwNUEwc21uc21HTkMzc0lDblFvaHZP?=
 =?utf-8?B?ZHRMTk81Z3k3UTZoNWhDUHBwN3h1TXlXelFjZlJDL3VJQ3A1V25XS2FEcnhl?=
 =?utf-8?B?aWJ6Q0Vha0w3ajN4VjJ5bkMyU0Q2UTBKMkZsblREQ3l2NyswVjhxaDA5Z21z?=
 =?utf-8?B?RklxZEQwWEo2NmJmUit1Lyt3SnRwOStUMUhJS2cvd0xmK3BnK29tTjZmWktj?=
 =?utf-8?Q?lDt/p7i72bkyW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2644CF282142F743B48D039656A73F91@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ae0ac0-5515-4e71-4dc0-08ded5ad6aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 07:09:52.8773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB7169

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
ZWQgZm9yIHRoZSBlcnJvciBsb2dzLCBYTVAgYW5kIEVYUE8uCgpWMiBoYXMgYmVlbiByZWJhc2Vk
IG9udG8gbWFzdGVyLCBhbmQgcGF0Y2ggMSBoYXMgYmVlbiB1cGRhdGVkIHRvIGNoZWNrCmJ5dGUg
MiBmb3IgRERSNSBpZGVudGlmaWNhdGlvbiwgbm90IGp1c3QgYnl0ZSAwLCBhbmQgdGhlIGNvbW1p
dAptZXNzYWdlcyBoYXZlIGJlZW4gbWFkZSBtb3JlIGZvcm1hbC4KClYzIGhhcyBhZ2FpbiBiZWVu
IHJlYmFzZWQgb250byBtYXN0ZXIsIGFzIHdlbGwgYXM6Ci0gVGhlIGRlbnNpdHkgY2FsY3VsYXRp
b24gaGFzIGJlZW4gZml4ZWQgc28gaXQgbm8gbG9uZ2VyIHByb3ZpZGVzCmluY29ycmVjdCByZXN1
bHRzIGZvciA+NDhHQiBtb2R1bGVzCi0gdENDRF9MX1dSLCB0Q0NEX0xfV1IyLCB0UlRQLCB0Q0NE
X00sIHRDQ0RfTV9XUiwgdENDRF9NX1dUUiB0aW1pbmdzCmhhdmUgYmVlbiBhZGRlZAotIFZERFEg
YW5kIFZQUCB2b2x0YWdlcyBhZGRlZAotIFVzYWdlcyBvZiBERFI0IHJvdW5kaW5nIGhhcyBiZWVu
IHJlcGxhY2VkIHdpdGggY29ycmVjdCBERFI1IHJvdW5kaW5nCi0gQWRkZWQgYSBzdGFuZGFyZCBz
cGVlZCAoOTIwMCkgZm91bmQgaW4gSkVTRDQwMC01RC4wMQotIFRoZSB0aW1pbmdzIGhhdmUgYmVl
biByZWFycmFuZ2VkIGluIG9yZGVyIG9mIGFkZHJlc3MKLSBUaGUgdGV4dCBmb3IgdGhlIHRpbWlu
Z3MgaGFzIGJlZW4gdXBkYXRlZCB0byBtb3JlIGFjY3VyYXRlbHkgcmVmbGVjdAp0aGUgSkVERUMg
c3BlYwotIFBhdGNoZXMgNiBhbmQgOCBoYXZlIGJlZW4gYWRkZWQgKGBwcmludHMyYCArIFhNUC9F
WFBPIHN1cHBvcnQpCi0gRXJyb3IgbG9nIHN1cHBvcnQgKHByZXZpb3VzbHkgcGF0Y2ggNiwgbm93
IDcpIGhhcyBiZWVuIGltcHJvdmVkCi0gQ29tbWVudHMgaW4gcGF0Y2ggMSBoYXZlIGJlZW4gdXBk
YXRlZCB3aXRoIEREUjUgaW5mbwotIFNvbWUgcGF0Y2ggbWVzc2FnZXMgaGF2ZSBiZWVuIGNoYW5n
ZWQgc2xpZ2h0bHkKClNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gSG9ydmF0aCA8cy5ob3J2YXRoQG91
dGxvb2suY29tLmF1PgotLS0KU3RlcGhlbiBIb3J2YXRoICg4KToKICAgICAgZGVjb2RlLWRpbW1z
OiBJbXBsZW1lbnQgRERSNSBjaGVja3N1bSBwYXJzaW5nCiAgICAgIGRlY29kZS1kaW1tczogRGVj
b2RlIEREUjUgTWFudWZhY3R1cmVyIERhdGEKICAgICAgZGVjb2RlLWRpbW1zOiBEZWNvZGUgdGlt
aW5ncyBhbmQgb3RoZXIgZGF0YSBmb3IgRERSNQogICAgICBkZWNvZGUtZGltbXM6IERlY29kZSBE
RFI1IGNvbW1vbiBtb2R1bGUgaW5mb3JtYXRpb24KICAgICAgZGVjb2RlLWRpbW1zOiBBZGQgYmFz
aWMgZGVjb2Rpbmcgb2YgdHlwZSBzcGVjaWZpYyBpbmZvcm1hdGlvbiBmb3IgRERSNQogICAgICBk
ZWNvZGUtZGltbXM6IEFkZCBzZWNvbmQgbGV2ZWwgc2VwYXJhdG9yCiAgICAgIGRlY29kZS1kaW1t
czogRGVjb2RlIEREUjUgZXJyb3IgbG9nCiAgICAgIGRlY29kZS1kaW1tczogQWRkIEREUjUgWE1Q
IDMuMCBhbmQgRVhQTyBkZWNvZGluZwoKIGVlcHJvbS9kZWNvZGUtZGltbXMgfCA4MzkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNo
YW5nZWQsIDgzMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQotLS0KYmFzZS1jb21taXQ6
IDU4NTJmNTM3NWVlYTZjYTlkYWJmMzFmNDc3MmNiOGI4ZWNjOTA1ZDgKY2hhbmdlLWlkOiAyMDI2
MDYyNC1kZHI1LThmMzU3MDBhNmE1MAoKQmVzdCByZWdhcmRzLAotLSAgClN0ZXBoZW4gSG9ydmF0
aCA8cy5ob3J2YXRoQG91dGxvb2suY29tLmF1PgoK
