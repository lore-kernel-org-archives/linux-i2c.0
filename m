Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012071.outbound.protection.outlook.com [52.103.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A213390CB2
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814025; cv=fail; b=b6mYSmmCloIM2ena6bVeTX4jwOiKg96aDPdVQn3PMw+SngVa0hJOY6Mtn+tRcbp9fwtTetqjwUQe8OdF1V3tuuuSpSwH45F8BjfoaDawxm5yyifgwNWGh4Y4n2YLCCdoFZ+1+TWI3K3TEBTazBIX2yKthq9wFcQANJrR6aY6TjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814025; c=relaxed/simple;
	bh=8uJ6B51TTLDOeUvteTbqqr0/bIWfAQQ+pXphef6klcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BRMJ3Fv/K6cNz51QLgOCwtKvbd2tJPCQ62EEyDxZpESgvdGfKwtHf4wq3YJ7iNybM+tzer1CkZnbKKptHYq/OrxvVq6efozsn7Vag3zKOuXMB7cqH9xF2VrUfUzuSPKErelwUTujMbrSM1F19oNL+9FjmokJgFCx7NEVECrheb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=CPEiltqN; arc=fail smtp.client-ip=52.103.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="CPEiltqN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVdX0vGT6Y8F7gELdIrb5UFiHsVQ9u8KI+ZeNRtUBhVj+9z0LSrugtPk1lCPi9hv5N8PtuezW2bqGdGv38yHKEljEKjUihGjBUfkEic+pG2yFXRVgy2Y2uVLlET+uPQmqD3Gnd14uWKbKhHAPY/fyO1eUH+3fBYO9NyVKWiwyPCqqfbuFSAxxNDpxNNp+8pbofQ02tEk6Ia1WQ4YfUi5BsuILVfnkzDZ4l2A4xLd3VNLUNvtFK8CmQOp7aRsKeVvFMN/QMQvz4gso1speHWM/FxzMGUXmc5+cXVqiGQ+KZk/+LW1kh0gnFYFaWw2FyR13xj05eVoQk63Q23kUniE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uJ6B51TTLDOeUvteTbqqr0/bIWfAQQ+pXphef6klcM=;
 b=rF48rv4szdcdqWs369gnfW0/Y1GD5g7t1k7BO+P8FPZtVIUXcvpw+17pfAofoNnIviSzhcDWR/QnSmBQP3tvAc2E+t5XB9Ui3n+BR+wikhe0VEArErMPGgXgScSBGs4j1hPOf7t6Eu2MX0z1vBe4gmls/GXjVBkGvGzsCzOz1fjkJvPUXcqSldxU1ioCHHiDYj8hwSii12ntgtNEITHEwk1KZossToeYbJb492c6Di7zh593Z3MOzZzSJ2LGEEtSC3Q83TaOjhPlQF3nZvhpxj1QUdpfGkLfDh/mD9zENnNjIGRPdHibY2Dq3yh1hH72EM/Qhntpjtr+M7d/bHgoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uJ6B51TTLDOeUvteTbqqr0/bIWfAQQ+pXphef6klcM=;
 b=CPEiltqN6RegKoKhtKhKK+AKGLGxx5lk9Py9VJ2wlEvTFORwAKGkk1q5F1HGloqfX0riPO05WjL/Y0HUTmjX9bGqVhOwh9e4C7mjLzSrlY5dLsaP925hdLAnXSPmq/KO5d/ge6EPj2aYHFEg8Yq9jVMO+ywx8yAnBmeFstMbge+L9vNXvAkvfwcoSka6Og54W3u4LMwK1TCtQPxh8TPmEKvRNPvV2wm/ej22N+DakaA3uQj4btJEd8eWTjzxqPnIWuXUQrlaJXLO6jTDMaB+x0IjWFX/UZeJz3tUcXJbgghaNTPRXdpW81sY6TYZJ0qTFUrJK6kuj/MtEETpK/vnaw==
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
Subject: [PATCH i2c-tools v4 1/8] decode-dimms: Implement DDR5 checksum
 parsing
Thread-Topic: [PATCH i2c-tools v4 1/8] decode-dimms: Implement DDR5 checksum
 parsing
Thread-Index: AQHdGqjJG5wy5OrhPU6KMwWh3lJ5dg==
Date: Thu, 23 Jul 2026 13:40:12 +0000
Message-ID: <20260723-ddr5-v4-1-d7cf78ebbbaf@outlook.com.au>
References: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
In-Reply-To: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|MEYPR01MB7183:EE_
x-ms-office365-filtering-correlation-id: 94461c57-8d7c-47d6-9b57-08dee8bfebad
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|38102599003|15080799012|37011999003|25010399006|12121999013|41001999006|24021099003|8060799015|31061999003|19110799012|8062599012|440099028|4302099013|3412199025|102099032|10035399007|3071699003|1602099012|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHNJNXpmbXhWazFscXV5K0diVXJDeG5mRWt3YXNDSEtLdkgzN2lnbGRtK0dy?=
 =?utf-8?B?dzRSOVcrYzZidStFaDgxTmQ0ZDYvbGQ0Tml4RVpWK0RaaHpOM3NUbkMraXVO?=
 =?utf-8?B?QXU3VVdFOENhMFBSbmZmbWlubE05MG9uVEh4Vm0xa0ZYUnMwelRBZFJYcDdi?=
 =?utf-8?B?cnlPQkp5UW9RVlhjZFNQSCsyWTI0YjJyYS90U0JxTS9maHFneVJuK2w3eTl1?=
 =?utf-8?B?TFlibGtubXMzdjdPWWh6NFpObFRoL3NNdjllMXBQalVxT1RYS2FGaWxQcC8w?=
 =?utf-8?B?MzRNZTRYVHBxWTlLNE9Sb0JGUmxHZXdrT1hmcTRFWDBBY0w0N0JJanoxZUJD?=
 =?utf-8?B?R2FvVE5RYXI1MGIvSVo3THZKcEVrMmdTTXlkNmJNbDdCUlg3WVFveEJKbGM1?=
 =?utf-8?B?OW9uem90YlU1Q3FwYXVFV2RSbnFRTy9BRWZGNkZpUklTVlVkS0E2aDhNNlBQ?=
 =?utf-8?B?c1BkbUk4bG84ZW1Rb3NLYjlFUmZFdHBjWGNWdngzWGZEMUNqdS9qd3pZbXdR?=
 =?utf-8?B?VnRtUkV1R0dkTWhkakpRL3AwMU1nNld0SC9lU1hEdEZwMDF2ZDhCTjNNY3ky?=
 =?utf-8?B?dWdaa2x1dERJSzdwSU9sdXFlRW1jNm95ZTZFVzBRM3h2Z1NoK1Z2eVpzUy9h?=
 =?utf-8?B?dndabGZ0eitBcGVLR0gyQlBHWUFaeTdwMzlQZ0NQYmVRb3RpUlNqRjBZSXpS?=
 =?utf-8?B?RFhNSFZtbitBTjhxY3hMaVpZSXRORFU2TkllNUE2UnJoc0NGaUtxbzVDSWVO?=
 =?utf-8?B?ZkxrSWpCRTVqZVc4WGZYL0g3Q0lJTUVXVUcvZzZLU1NFcHdwbDVnYkpVUWY4?=
 =?utf-8?B?bmc1ZDQySnJ4ZzBPek53RXVIVkFYT0dTYlRCQ3NJekdlZ24rMGpISGFvNy9N?=
 =?utf-8?B?Z2NBSG15UjZvbHdMQmsrYzBMaTBJQjN0UDVRb3VHV1ZmOTBiOEQ0NnVTMEV2?=
 =?utf-8?B?b3VOL1VYcVVqQzZtMHJ0bUJXczJrdmZjM3REdFFpSHpIYzR1VkNoS0VPbFlw?=
 =?utf-8?B?cmFmN1dJWk9oaHowKzdWK2tnKzZkcysrT1RDTVNDZThrUzZSNkZyMHd2ODgv?=
 =?utf-8?B?eDhzb1BneTBxZXpKRnRQQURydS9uOEhhejh3S0lqWXZYMzd6SXpCcWxQMXBW?=
 =?utf-8?B?a0czU0dNWlh6ZUZLNzN1QlFPbTQvRU50UXhnQ2NVZ1ZSNDFBK1paWm1EMlRQ?=
 =?utf-8?B?UGpGWFgrZEowaUNHYzM2RlJVaTVQTEU3eVZqc1hqdGtDVFRGeG1pM1M3aUhx?=
 =?utf-8?B?anF5eWVmRFM2YVZrM1RDQi8yaExqS2tFcHE2L3FaQmxSb0tLYytMUUtqejg3?=
 =?utf-8?B?M0ZCYS91MzBzcjJLcGgvMEVlZzlmYzRtR0tPamtkaGxwK3FGTlloYmtobEJj?=
 =?utf-8?B?aVMyWnBGMXl3bGN5d1c0ekF2Vk5NS1d1Mno5d2FTVThTS3krZnl5MjNlYXov?=
 =?utf-8?B?NE9GMjdVcHZDSU41UTJPTSsyNUttNkpxUlM4RDRHK2VNa3J5TjlOeENyOHFN?=
 =?utf-8?B?THhpRU10cFF5a3FKODBaNEk1MGZVa0F6WmFzT0F6WXpaNW5TQk5IWmFnSU5i?=
 =?utf-8?Q?ZAHp3sWvOurQZeHKR6I0P5aU0wVNJDo9QexVvyYBTUXi26?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmVLRGtJZTlkdFgrYm1hellUajgwckIxZUtHVFJpZWlQc3pubXdRMFJSU1No?=
 =?utf-8?B?ZkRiQnhaZVZFZFJPQ0txQ1hqdS95MWpBckV4ZEVhTWt2UkdNUkg1MjJHRU1z?=
 =?utf-8?B?dU5ZODUxTWZQdHlHYTIwWU1Ed3RVUUNaUHRQM1JlTzRxSUVkbHJxUDRzbnhC?=
 =?utf-8?B?R29VY2pKZWc3RnZiQUg0ZStxbG5TakhoRGVSc05QTi9WTVdXR0NIWG1oSEdk?=
 =?utf-8?B?VHkvMElud1FZQWhFWHJraVBHeWdWWXNXY25HeXAzcml6KytqcVdubnE4bzZ4?=
 =?utf-8?B?dklubjcrbmZIeElvcGtzZklVWVlmYXFzemFLeGhoRXBWZ3BmWGg3alIyMTVP?=
 =?utf-8?B?bFV6c0xySFNyMmpDdTlGZXI2SnJITzdXL2dPYWY4M3pwNUg5UFBJQTIwcEho?=
 =?utf-8?B?SC9FSVUzSW1NWWdUTW9IblA2Q0ovSnlyaDkwOVdYVnEvdmV6SEpsVDY2ZnVr?=
 =?utf-8?B?ZWJFYlpKSTJ0ZStvVGl4amcreXFSNWVYU3hRVHVkVXpMcmR2NnpmZWppQkZy?=
 =?utf-8?B?a1VEdEFFZHRBeXNTNW01R3ZyYURzVm5aY3FML3JMUkF3cWVHOCtmNU1ZWjNG?=
 =?utf-8?B?L3FRcnFvK05TaFgxYi9JZ0FoNVZpWUhzSHNVT1A5dFgrdnE3TmhpeHZ1Yjgz?=
 =?utf-8?B?bEZ3UFBiVFVQVVFCMnFNTVcvNlVFZjJvUjFwU0twcldtYW9PVFVoNjZMdEJp?=
 =?utf-8?B?MTlxNk14ODBjRlQ4M0xGZUwzdHUvcGtIYUxaM0lCZ29qOGl1enlnN3NucGRY?=
 =?utf-8?B?bG5WOG1TZVd0YTF3Ym1NanhHYTRnNmJNZnpiRmMvZHh3MEl1eldKT09ML2Ir?=
 =?utf-8?B?L2c4am83WWVvL2RYVzBrVHZ6UDBVV2lMRm5KVlFORFNBM0xkVm81d3BjcU11?=
 =?utf-8?B?WnpldkNEWnRUSWE5UFQxTzdoMExaSzVKeXJlVFZTNnF6Kzk1UkRjeWZ2RHpQ?=
 =?utf-8?B?bDdXbkFyaVhtS0FpRzBxVVBQdnlKNkJ2UVJER2ZIdG0wWXlVMjU5blJ1SW4z?=
 =?utf-8?B?K2dMUU1iVzhmWWJ2ekNqWnRac24wQ0ZTNGdCN2FHMXFpTE9ZRFVIcnRrRTJv?=
 =?utf-8?B?a1kxdGV4UzBNYjEvcmF6S09ON1hPUGpKczRkS3Foai9za1A1OWJvNCtZaHBQ?=
 =?utf-8?B?MnRseGtCL1I1ZVQreUNPMkRyMHZIVlpWQ3JPK1FzUlp3NnhlR0VHUS8rWW80?=
 =?utf-8?B?Vy9lWGh2T0tyMGFnU3NGRStzTnphajRlOEk0dTlCQXB2aFg2MkFIbTljQTF3?=
 =?utf-8?B?LzVwanZCQ056NThDNGp2czlGQkUwS3dLU3B1R0d3UkoybzJuRklaNWw1cE1L?=
 =?utf-8?B?ZVhWK0RRSlpVZ2JpUHF5SDlPVWM2aW13K2l3MkwvWjY1TTJSY25VamtnbTNs?=
 =?utf-8?B?Z0R5bCtLQ1d0MFRRd3I5aE1yWm56VTdXdDRnVkYxMUp6bFUwWVl0NVpxMjVy?=
 =?utf-8?B?cTNCWFp0SG9GTHNzS3JTQ29OMS9SU25sUXdHMGpjbWlhL0xWQ29HZmhXTHFO?=
 =?utf-8?B?UmJKT0tLRGhRNCthdUZ5K2tBSEZKdk96QXhYMEc5Qms5SXJGcE9NMSs5eVNP?=
 =?utf-8?B?ZFNwb3FzaUtQdzVibVhZaWMwWEFLS0lNQUxVTkkyQkVBU1JqaENadmV3MDJU?=
 =?utf-8?B?Zk5ORjVFaUZFcllHSnZDeUtpcWZXOWRUcGtWZ0ducER1akxxVkl1NjdaR0x1?=
 =?utf-8?B?OFg4a2RweDNjU3RKRnNDYTg4WEtNVHozUmFHL3U2VlkwbXRZT3lVOTd1NUVY?=
 =?utf-8?B?Sk1mMVlFRVhYR1ppMThjSnc2N3JRWkZVS1VUcVNDUERaTmdOUnNVd3ErQ0dF?=
 =?utf-8?B?OG5vcmtHNStPd3JnK09FQ1RNemhkN2E1SXk0Q1BUZFhvV0tUV1lpZTFldXJN?=
 =?utf-8?Q?Zrrnj5BEl5c/5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98CB5C519564EE40A3A63BB955359F70@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94461c57-8d7c-47d6-9b57-08dee8bfebad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 13:40:12.1921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB7183

VGhlIENSQyBmb3IgdGhlIEREUjUgU1BEIGlzIGxvY2F0ZWQgYXQgYnl0ZXMgNTEwLTUxMSBvZiB0
aGUgU1BEIGRhdGEuClRoZXJlIGlzIG5vdyBmdW5jdGlvbmFsaXR5IHRvIHJlYWQgdXB0byBieXRl
IDUxMiBhbmQgY2FsY3VsYXRlIHRoZSBDUkMxNgppZiBieXRlIDIgaW5kaWNhdGVzIEREUjUgbWVt
b3J5IGFuZCBieXRlIDAgaW5kaWNhdGVzIGF0IGxlYXN0IDUxMiBieXRlcy4KClRoaXMgcGF0Y2gg
aXMgYmFzZWQgb2ZmIG9mIGEgcGF0Y2ggYnkgR3VlbnRlciBSb2VjaywgbGlua2VkIGJlbG93LgoK
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaHdtb24vZWZiNzdiMzctMzBlNS00
OGE4LWI0YWYtZWI5OTk1YTI4ODJiQHJvZWNrLXVzLm5ldC8KQ2M6IEd1ZW50ZXIgUm9lY2sgPGxp
bnV4QHJvZWNrLXVzLm5ldD4KU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIb3J2YXRoIDxzLmhvcnZh
dGhAb3V0bG9vay5jb20uYXU+Ci0tLQogZWVwcm9tL2RlY29kZS1kaW1tcyB8IDMxICsrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2VlcHJvbS9kZWNvZGUtZGltbXMgYi9lZXBy
b20vZGVjb2RlLWRpbW1zCmluZGV4IDc2ODIzNDUuLjE0OTE3OGYgMTAwNzU1Ci0tLSBhL2VlcHJv
bS9kZWNvZGUtZGltbXMKKysrIGIvZWVwcm9tL2RlY29kZS1kaW1tcwpAQCAtMjIsNyArMjIsOCBA
QAogIyB0aGUgbGVnYWN5IGVlcHJvbSBkcml2ZXIgKGluIHRoZSBrZXJuZWwgdHJlZSBzaW5jZSB2
Mi42LjApLiBGb3Iga2VybmVscwogIyBvbGRlciB0aGFuIDIuNi4wLCB0aGUgZWVwcm9tIGRyaXZl
ciBjYW4gYmUgZm91bmQgaW4gdGhlIGxtLXNlbnNvcnMgMgogIyBwYWNrYWdlLiBGb3IgRERSNCwg
eW91IG5lZWQgdGhlIGVlMTAwNCBkcml2ZXIgKGluIHRoZSBrZXJuZWwgdHJlZSBzaW5jZQotIyBr
ZXJuZWwgdjQuMjApLgorIyBrZXJuZWwgdjQuMjApLiBGb3IgRERSNSwgeW91IG5lZWQgdGhlIHNw
ZDUxMTggZHJpdmVyIChpbiB0aGUga2VybmVsIHRyZWUKKyMgc2luY2UgdjYuMTEpLgogIwogIyBS
ZWZlcmVuY2VzOgogIyBQQyBTRFJBTSBTZXJpYWwgUHJlc2VuY2UKQEAgLTI0MDIsNyArMjQwMywx
MiBAQCBzdWIgc3BkX3NpemVzKCQpCiAJbXkgJGJ5dGVzID0gc2hpZnQ7CiAJbXkgJHR5cGUgPSAk
Ynl0ZXMtPlsyXTsKIAotCWlmICgkdHlwZSA9PSAxMiB8fCAkdHlwZSA9PSAxNCB8fCAkdHlwZSA9
PSAxNiB8fCAkdHlwZSA9PSAxNykgeworCWlmICgkdHlwZSA9PSAxOCB8fCAkdHlwZSA9PSAxOSB8
fCAkdHlwZSA9PSAyMCB8fCAkdHlwZSA9PSAyMSkgeworCQkjIEREUjUKKwkJbXkgJHNwZF9sZW4g
PSAyICoqICg3ICsgKCgkYnl0ZXMtPlswXSA+PiA0KSAmIDcpKTsKKwkJbXkgJHVzZWQgPSAkc3Bk
X2xlbjsKKwkJcmV0dXJuICgkc3BkX2xlbiwgJHVzZWQpOworCX0gZWxzaWYgKCR0eXBlID09IDEy
IHx8ICR0eXBlID09IDE0IHx8ICR0eXBlID09IDE2IHx8ICR0eXBlID09IDE3KSB7CiAJCSMgRERS
NAogCQlteSAkc3BkX2xlbiA9IDI1NiAqICgoJGJ5dGVzLT5bMF0gPj4gNCkgJiA3KTsKIAkJbXkg
JHVzZWQgPSAxMjggKiAoJGJ5dGVzLT5bMF0gJiAxNSk7CkBAIC0yNTExLDEwICsyNTE3LDE2IEBA
IHN1YiBjYWxjdWxhdGVfY3JjKCQkJCkKIHN1YiBjaGVja19jcmMoJCkKIHsKIAlteSAkYnl0ZXMg
PSBzaGlmdDsKKwlteSAkaXNfZGRyNSA9ICgkYnl0ZXMtPlswXSAmIDB4NzApID09IDB4MzA7CiAJ
bXkgJGNyY19jb3ZlciA9ICRieXRlcy0+WzBdICYgMHg4MCA/IDExNiA6IDEyNTsKKwlteSAkY3Jj
X3N0YXJ0ID0gMTI2OworCWlmICgkaXNfZGRyNSkgeworCSAgICAkY3JjX2NvdmVyID0gNTA5Owor
CSAgICAkY3JjX3N0YXJ0ID0gNTEwOworCX0KIAlteSAkY3JjID0gY2FsY3VsYXRlX2NyYygkYnl0
ZXMsIDAsICRjcmNfY292ZXIgKyAxKTsKIAotCW15ICRkaW1tX2NyYyA9ICgkYnl0ZXMtPlsxMjdd
IDw8IDgpIHwgJGJ5dGVzLT5bMTI2XTsKKwlteSAkZGltbV9jcmMgPSAoJGJ5dGVzLT5bJGNyY19z
dGFydCArIDFdIDw8IDgpIHwgJGJ5dGVzLT5bJGNyY19zdGFydF07CiAJcmV0dXJuICgiRUVQUk9N
IENSQyBvZiBieXRlcyAwLSRjcmNfY292ZXIiLAogCQkoJGRpbW1fY3JjID09ICRjcmMpID8gMSA6
IDAsCiAJCXNwcmludGYoIjB4JTA0WCIsICRkaW1tX2NyYyksCkBAIC0yNjE3LDcgKzI2MjksOCBA
QCBzdWIgZ2V0X2RpbW1fbGlzdAogCWlmICgkdXNlX3N5c2ZzKSB7CiAJCUBkcml2ZXJzID0gKCdl
ZXByb20nLAogCQkJICAgICdhdDI0JywKLQkJCSAgICAnZWUxMDA0Jyk7CSMgRERSNAorCQkJICAg
ICdlZTEwMDQnLAkjIEREUjQKKwkJCSAgICAnc3BkNTExOCcpOwkjIEREUjUKIAl9IGVsc2Ugewog
CQlAZHJpdmVycyA9ICgnZWVwcm9tJyk7CiAJCSRkaXIgPSAnL3Byb2Mvc3lzL2Rldi9zZW5zb3Jz
JzsKQEAgLTI2NDIsNyArMjY1NSw4IEBAIHN1YiBnZXRfZGltbV9saXN0CiAJCQkJbmV4dCB1bmxl
c3MgZGVmaW5lZCAkYXR0ciAmJgogCQkJCQkgICAgKCRhdHRyIGVxICJlZXByb20iIHx8CiAJCQkJ
CSAgICAgJGF0dHIgZXEgInNwZCIgfHwKLQkJCQkJICAgICAkYXR0ciBlcSAiZWUxMDA0Iik7CSMg
RERSNAorCQkJCQkgICAgICRhdHRyIGVxICJlZTEwMDQiIHx8CSMgRERSNAorCQkJCQkgICAgICRh
dHRyIGVxICJzcGQ1MTE4Iik7CSMgRERSNQogCQkJfSBlbHNlIHsKIAkJCQluZXh0IHVubGVzcyAk
ZmlsZSA9fiAvXmVlcHJvbS0vOwogCQkJfQpAQCAtMjY1NCw3ICsyNjY4LDcgQEAgc3ViIGdldF9k
aW1tX2xpc3QKIAl9CiAKIAlpZiAoISRvcGVuZWQpIHsKLQkJcHJpbnQgU1RERVJSICJObyBFRVBS
T00gZm91bmQsIHRyeSBsb2FkaW5nIHRoZSBlZXByb20sIGF0MjQgb3IgZWUxMDA0IG1vZHVsZVxu
IjsKKwkJcHJpbnQgU1RERVJSICJObyBFRVBST00gZm91bmQsIHRyeSBsb2FkaW5nIHRoZSBlZXBy
b20sIGF0MjQsIGVlMTAwNCBvciBzcGQ1MTE4IG1vZHVsZVxuIjsKIAkJZXhpdDsKIAl9CiAKQEAg
LTI2ODQsNiArMjY5OCwxMSBAQCBmb3IgbXkgJGkgKDAgLi4gJCNkaW1tKSB7CiAJCSAkZGltbVsk
aV0tPntjaGtfc3BkfSwgJGRpbW1bJGldLT57Y2hrX2NhbGN9KSA9CiAJCQljaGVja3N1bShcQGJ5
dGVzKTsKIAl9IGVsc2UgeworCQkjIENoZWNrIGZvciBERFI1IHByb3RvY29sIHR5cGUgMTgsIDE5
LCAyMCwgMjEgYW5kIHNpemUgPj0gNTEyCisJCWlmICgkYnl0ZXNbMl0gPj0gMTggJiYgJGJ5dGVz
WzJdIDw9IDIxICYmICgkYnl0ZXNbMF0gJiAweDcwKSA+PSAweDMwKSB7CisJCQkjIEREUjUncyBj
aGVja3N1bSBpcyBhdCA1MTAtNTExCisJCQlwdXNoKEBieXRlcywgcmVhZHNwZChAYnl0ZXMsIDUx
MiwgJGRpbW1bJGldLT57ZmlsZX0pKTsKKwkJfQogCQkoJGRpbW1bJGldLT57Y2hrX2xhYmVsfSwg
JGRpbW1bJGldLT57Y2hrX3ZhbGlkfSwKIAkJICRkaW1tWyRpXS0+e2Noa19zcGR9LCAkZGltbVsk
aV0tPntjaGtfY2FsY30pID0KIAkJCWNoZWNrX2NyYyhcQGJ5dGVzKTsKCi0tIAoyLjUzLjAKCg==
