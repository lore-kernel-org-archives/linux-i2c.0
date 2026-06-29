Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010013.outbound.protection.outlook.com [52.103.73.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1523ABA7
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717014; cv=fail; b=brUJKZfUYXc6kdYhxal2zTd1HAozafKnxppZTz6/qPow801O08iK9xYVLxLAFAqMADZm2465y/CHheew1xZ6i0a680XYUKAIp6ZYMEaNBCMmQbpRnSOjtEYXCP3hxUQcu5oBYiiKRTt5EsFlrfM/F+1//ZYUc+2wrefSs7FEp6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717014; c=relaxed/simple;
	bh=+aFwgT0emLFy7R+tjQMhHCFAwRyP/YhzpJ5TbPKmTH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t2938FKhIiFmWjdOkg0MvOzIv/IxpYU29rvP82VguTse2uafNybygdYScrRMBCVSwWCn7nyPkTkmAAyC0BZaGCWl8Zy1gjxC0evsWGba+QEbpFcQ+K5mR8i0aLzL4bMtkgBvZ17PVCh2VbQbuSQJBEw64bxl1+m38+3yH7M7CNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=tR0dtHj7; arc=fail smtp.client-ip=52.103.73.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="tR0dtHj7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpRHWofzerFOin0odwzjgismfG/On3OIq0iG/MiQ3FzIbHkKBZk60/oD6IyRr8jhB62l3R+EEeUjQbYqtWew8a/rqL79Vg2LqWrrczTGWDJs308Up6+rJ8Yv4XCTWJku0Tl4MSpCcUfi0L2Fr8IdzyLjL1Yg95YOgfHZIyZAGckzHOImm8s9pqArzJk6rWHVnfiKQhPZEweDGTRJZlZvht8ABVSmh8CYBL7okc3lhtxsmn8Pr1CoI4f3EIldHIAzH+rau3i5pY5U+1zYq14ofRt3v85sGKXOdI2C2TFJ9deYP526yUjnb3LT07Wwp+CF9s6scFKZMR2KbqeKPp0ioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aFwgT0emLFy7R+tjQMhHCFAwRyP/YhzpJ5TbPKmTH8=;
 b=J3Tr47ysfaNGa6+q12rlMNrWnXUtlE2zefPcTRKqUH/ahNak+54h54Ojv587Hp1dgFOoBOBiga3B1MNMCKZM4pF64IgsdpAL9BwAa9jNHKM0XglsXzjGigO5hn6DqIk+1iQ9tWh6unaphQDhxnlilxVhwxv9dbwPdCj+3h3dqWUYsOwy6nDk4MTcsGyy4lKSjtVfDETDmiG5iNZ1GIL43zITqVKRaE2hLVi/bwJxS+OxHF4H7+kd5oGbdjt7pbGswsrj/XUQ1NQyqw70r5vUTngCH6GH5w4QSKbW6NtK1VGSBvpohZCFIWi2KV8qLDhYk9Mbc1AnvMiZZNVG3sOyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aFwgT0emLFy7R+tjQMhHCFAwRyP/YhzpJ5TbPKmTH8=;
 b=tR0dtHj7PYdkdzy6xPIW2iSXS7ky04xic5eJme73/G1bWl+X4snwl6z9ej74nIfGE2NdAfhMsB3k9P+CU8MHmRXCbSmBZTkzO8yQjmjIikj5g6CmOuar4JzJh1jJeulahp/+2+JNYkebPzxF5NANjIZkJb8tX5bpPrUfcpSX+AC2mSd5YA8vwJyCl1iwwJiFUiIGaEFAWiPA1UcWl/9q4K0NfSjWdII6BYmpBmRsyqRIhfp/TMC29ny5PEjRBvHa8kUu223m1/S9XxiIGqCsUXerpu5iUL+NcsXLx+gYRbHFjkIXCLb7i5hihOFMzC62A+dFLhRYKuRf302b5CIRDw==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by SY6PR01MB7509.ausprd01.prod.outlook.com (2603:10c6:10:170::20) with
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
Subject: [PATCH i2c-tools v3 5/8] decode-dimms: Add basic decoding of type
 specific information for DDR5
Thread-Topic: [PATCH i2c-tools v3 5/8] decode-dimms: Add basic decoding of
 type specific information for DDR5
Thread-Index: AQHdB5ZRVVdtlGRLH0mliLx13zl4Gw==
Date: Mon, 29 Jun 2026 07:10:08 +0000
Message-ID: <20260629-ddr5-v3-5-07f45075a51a@outlook.com.au>
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
In-Reply-To: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|SY6PR01MB7509:EE_
x-ms-office365-filtering-correlation-id: e23fc5c0-b0c9-459c-756c-08ded5ad742d
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/Ozpvw7JRWsQ0tExWEP0EfCdnYo8mIzotD0KQzdW8GB8bLnIk5q4wCvYsqSpQmE9nTgWJcV+u4hDKA9tSUxZDmAi9cVK6zKw08NPa93qsndMpPUD/qt0ZACoONMYJoPJb0cy9geW4F8ARpBGvqqxGUmk07/HURE/bzRXd4dKDU4gEA49NsoxXRNgskS7fR9d3UeEg+B0zIANFPfv6K1yVey6kh0szDfNOP3+qOOZl6y1azww03XDdbeqdBsY1cg/e+l6hMfyPxmlTt+7RSrY+u4ptJHraDbGzOwriEtJ0UrZu8iNZGl2mJkJa/SVS4nToONi3PhJxITJ88U68neTDXi5e40Rov+xOnSSsdlO53g6VyYcdPMhLF0zxzMcfm90cMHkh0wjEmtRz1Y5qtClkicJkEORzVTSwYrZw4BLxYds+t7ZrtpO8SJDHlbFn2P7mVu81TVu3UHI/LKIEUfMgfvOicVYWNS/Z7vIhgaPZ5aVyGGCpRuW3UPmycNFrw/BjtIZdzcOs56UJQf/OaMPFYll6b7UCfxoBhknDrSw12FwlAqdvFomlWVzwO5CVQH95jrN1zMen/v2MGThkOnWjV8ufNgkqopoSXqovEJkZ238VWjqmcOWgusWL3lp7INeF28yRRwN123QP8tt+yc/cTgnsf6MWT4uC57t21sqK2FKDrz7Y8RNYbJfYFgoJrsmTWwwpb4UiYyvV2bRyZCUf5x1t0kdRBF2S
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|24021099003|31061999003|8060799015|51005399006|15080799012|19110799012|38102599003|37011999003|25010399006|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZElpQWUxQ0tRM2dWYkNvVmthUjRPTitweHZoa2h6NDVsUGNVRitGNmd2T0Nr?=
 =?utf-8?B?d1ZjVUpOV2R5T2Nucm9FZnducHRCKzZhajJVdkhka3F4SGpMbUJ2THM4eEtv?=
 =?utf-8?B?b3pUOTV6ZkhUVTd1OEg2NXE4WnJjYkJGQi9mbXdwQkJheDJLVVgrNzFTMTRO?=
 =?utf-8?B?aEJadnQ0YmgxSC9zY0FlZVo3eTBPOWVPcWgrdlR1RzZVRkcrdld4MHpVVllE?=
 =?utf-8?B?NE9qeWtocUxHVGxlT3FJZmE5WUpQKzYwb0Z3N0lwTDlhamw2NDJNY3RYdlhn?=
 =?utf-8?B?QWU4RHJEN0l6aUVtQXpCSnhYWGZuQXVHcmNuNVh0cXd1L2tub3VMUVNpR21B?=
 =?utf-8?B?VThmV3g1U01vS1djQ04xZTc2dDVDaEM4dnNPakZJYnFKQ1RoVVZrZVZSVmNG?=
 =?utf-8?B?aGY0WmRGK2VGYVozTC9jalZaQTNhN0ZrN0dCT3orRzRlQ3lBZ1BTZVExQUFn?=
 =?utf-8?B?NElBbUF2QjUzMGQyYWg0ME5LeHBYMTFsNy9TVnRoaDVvdjBDU0x6R0FoOUJ0?=
 =?utf-8?B?QlJLV09KSjVFODkyZUs5V2ppUDIxWHA3blQzRFlVbEcwK2JnMjJRcTFtaFVj?=
 =?utf-8?B?V3RYVjVFR1dmT0c1NmxNcjNBR3VTY3N3dFF0RndsYVZOc0d3UStzSGh5OU5T?=
 =?utf-8?B?Ujl2VjhuUWlRQmJ6UGF4NTNoUjVTZ0IvbHBwdllqM3owK2F2L0J3RGs3S0V1?=
 =?utf-8?B?WG1JQlhkb3hFVWROREJ3ckl6c2d0b29vaTllTksrK0Z0TmVyWmd1OHRCUnor?=
 =?utf-8?B?L3BtZzUzTTJkU29KRE5kUDBLTGQyNXdEN1lmZGFDS1dGa29zQnhwdWkyVUVm?=
 =?utf-8?B?eGdObkNwNkVQY0NZOWtoMElmcTc0OVQvSmZ4MGVENElKRWNwaWkyYkhwQnk2?=
 =?utf-8?B?c1dsaE9lMk9seE5YQlJCSnM3Q3c3VXJIODRXdjBYeWZhb1dRTzMrNWlodDBI?=
 =?utf-8?B?MCt5amVJMWpUekdHTXYxRkJlMnA4R1VETFlkTXgrazMwQXJlakovSmlNSzRj?=
 =?utf-8?B?YjF0YzJWeUZscWlIaUZtTFNTTkVoZG9KZ3poL2FEV0YyaXhveTJGQTJ5emdQ?=
 =?utf-8?B?VlpZUUNzL3NsZHhJSFE2Yk1SVVRUNkFVYk53ZTFscTdsNVZwYUc1Y1NGdFBh?=
 =?utf-8?B?VWJFK1JpbTlnNWVyZWhhL3Z2MnVsRi85dHRnMzZHYWhkems5RnFhWUZaemVV?=
 =?utf-8?B?Y0R2VnJDZlRKR0QwdHdMTVlyNFBYYkp1dGZuWDBUZDhCaDJUTWhIUE50OGMy?=
 =?utf-8?B?UjNhbkw1a1V0aG5hZ1JXd0xzc0luMFBISm45NzEvcXVvcVpoajVQYStrUzZQ?=
 =?utf-8?B?OCtYUVZhYnNMS0ZocC9DNjBLZm45dk1PYTd0SmxXUnZsQkpIdC8yMFpHUkhE?=
 =?utf-8?B?a1puMThHZ0Y3Y2c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWZvWkRiQTNOTmczenhDTXZoUnZvUTlwQ3NVZlVEaTBrZWZjMXJuaGpwYmFx?=
 =?utf-8?B?bDhtVVZYK3liZW5ETlIzRFNPTnJtYStYR3ZYVW1aTVArbGoxcWJRemM5amlm?=
 =?utf-8?B?b1dhZjFWMW1PcVU2TnFKYmVFbXpLZHZVeVBmbW1yTitxWERraXczN2YxRTZh?=
 =?utf-8?B?blgzWFVsS29yR1lIKzMwbzNBVzBmRnpOdzBveUlVa0hDTUx2K3QwN2g0UkxK?=
 =?utf-8?B?a1BrS0RlbGFuY0VEVm9IWWk2VEZBbmQwV001YndBZ1dXUWYwZ1dQSXB1dC9C?=
 =?utf-8?B?bnluNCs2OHNtOUh0TE9jdkJCKzE0ZkdTek1lWnA1Q1FFNURmVVMrSGxLQWFC?=
 =?utf-8?B?TnJPWkp5WU56OTdySUdCb0JIQnptb1VlQVpwTXI5bXdPdGFtNlBGc1puQ3RB?=
 =?utf-8?B?TmZ0TWx1WE9yS0h4KzMxTVoxOEg3ZGpNVSsrQ3NyNGoxZkRuVExzWXhPNlpq?=
 =?utf-8?B?d3dMdUc3N3loK3Z0STNiamM2RURwcHNneXo3Qzd2bktXUTBna3UyK0owVVA3?=
 =?utf-8?B?MTlxd1Y3ZFpHMDFsTXMzRHh1NjBQb21zYlljeFZvcWxMQzdZZnhFSk5kYWxN?=
 =?utf-8?B?bXk1TFhFc1huRDZFUG12NlhJTmNsVkZ4TGgrcXZ6L0dXZVVuTk9rZ0dQUC9N?=
 =?utf-8?B?ektFSjRqVkxqeHNtZFhWaHBUdCtXT1Z0VTE1MTBIUVNlRC9oWjdzaFpXTzRG?=
 =?utf-8?B?QTlKK3ZtL2NQdUpUanBOakNxWHlLTWhvWVdHS2x3Z29MT0ZsVjFacm0vcE1p?=
 =?utf-8?B?aEVJVzJrZ3BFSEhmSUFob092MTl1UFZxS1JxYVlZTmoycjZ1N05YTnpqcEh2?=
 =?utf-8?B?ZCt4MDMyQ1FONFJ6RkRXS1AyMUY3RXNmOUhoQ3lIVWJPaGM3cFV1Rkl0ZkhT?=
 =?utf-8?B?NnNTaFpEb3RwUXFVQzg4UzJubDVtOHJ5RmFUdkYyekNPWEJlTDRQT2l4Qmwy?=
 =?utf-8?B?cFlZZDFIUXo4ZlQ3ZGFyN3FPaWU0SjlBZGhGcEZuWTNZWGdpcnVlZlk1MGNM?=
 =?utf-8?B?NDFrK2c2NW1lOHY5TUhVSXQwckxJV25MUk1Xa3JuazhTdnJJZU5LMm83VGpk?=
 =?utf-8?B?aFAyUEw4cWUxQ3VRTmVTalloWjR6TDFBZXpNTG9XZk1rdTJKTVFpZ3gvckU1?=
 =?utf-8?B?TlBzRnBtdHNUb282SUZaTVNIRFVvSExxeVhtMUZtMzdIVDJNOWJqNGhKTmMv?=
 =?utf-8?B?OVJNTkpDTjhSL2UxaktHTTNyekw3TG1UOEV5TnZWWXhWcnRaRmhMSUwwa3dp?=
 =?utf-8?B?M2JsdVhWY084ZTN6RTR4WEhNenl6WCtzYnpvbTVDL0RiMzhRd1Y3QWYzeTFF?=
 =?utf-8?B?N24yNktzKzRrdHpLTHF1K0NOMlhQV2NTbHBRdmx1QTJhSThITncyNFRKeTd6?=
 =?utf-8?B?d3RYaGhON2IwNXJjSHNFZDYwTHZrNG9IRXFMQUlMT09nUEFzSHVPeXovam14?=
 =?utf-8?B?TVhQQVpLRi84blVCYTFUTkRBaUlteXdOcTNLT3NsMHdjZUdoSXVrcHlORmtw?=
 =?utf-8?B?T01kN3puMk96TlRuWUFFMVRhNUNLYjFOOFgrZ2E3c1U2YWJFVUc2TFVUYzlq?=
 =?utf-8?B?OHNmT3U1M0lvZ1FHQzNXU2Jnb0JLM0N4ZlNYVWJPcFJmZU9tWXR3M1lQa1JE?=
 =?utf-8?B?bkNWRWNBSFdkRnFRUTNyT1hVeVIxUWswUEg3OGJZOWdsbDE5S0NjOHlXVlR2?=
 =?utf-8?B?cEpOMitGOHBCU1F4YU9zOVVjWEYyMi9pc3lpQkd6YmQrRktKNnBxTEwxODl4?=
 =?utf-8?B?SVJDUjU4NjlKVm8vWllLanJaUlVUNE5UK3A4cHFNR092OUVTbjE1QW5Oa1JZ?=
 =?utf-8?B?a1V4LzFzalZyRmZwSzNDQWZwT1dSRHI0dWIwY21CMkdhVi80U3VxUUkzTFJQ?=
 =?utf-8?Q?YxLXCRKIC0iOS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <625166A45429D145961B36A879F809EB@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e23fc5c0-b0c9-459c-756c-08ded5ad742d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 07:10:08.8332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6PR01MB7509

RGVjb2RlIG1vcmUgbWFudWZhY3R1cmVyIGluZm9ybWF0aW9uLCBidXQgb25seSB0aGUgaW5mbyB0
aGF0IGlzIHNwZWNpZmljCnRvIGNlcnRhaW4gdHlwZXMgb2YgRERSNSBtZW1vcnkgbW9kdWxlcywg
YW5kIG5vdCBjb21tb24gdG8gYWxsIEREUjUKbW9kdWxlcy4KClRoaXMgaXMgY29tcGxldGVseSB1
bnRlc3RlZCBzaW5jZSBteSBtb2R1bGVzIGFyZSBTUEQgcmV2aXNpb24gMS4wIGZvcgptb2R1bGUg
aW5mb3JtYXRpb24gYW5kIGRvbid0IGV4cG9zZSB0aGlzLiBJIGFsc28gb25seSBoYXZlIFVESU1N
cy4KClNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gSG9ydmF0aCA8cy5ob3J2YXRoQG91dGxvb2suY29t
LmF1PgotLS0KIGVlcHJvbS9kZWNvZGUtZGltbXMgfCA3MSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcxIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9lZXByb20vZGVjb2RlLWRpbW1zIGIvZWVwcm9tL2RlY29k
ZS1kaW1tcwppbmRleCAyNTBmZjg0Li5kYmFlYzk3IDEwMDc1NQotLS0gYS9lZXByb20vZGVjb2Rl
LWRpbW1zCisrKyBiL2VlcHJvbS9kZWNvZGUtZGltbXMKQEAgLTI0MzYsNiArMjQzNiw3NyBAQCBz
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
