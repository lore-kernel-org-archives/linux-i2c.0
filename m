Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010072.outbound.protection.outlook.com [52.103.72.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7E304BB2
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717013; cv=fail; b=fWntievDq8pca0XIkpRuEBemJPIuDXhgEBvP1TwpGbAL4Y/pAMT1HdesSiGuBoMWnTZHhqpaGtMLpex2rpVSMl0VDt/2hQD/xWj7BgjXkmqwqKuFDSS3XUM1I07rYnvjo1UOpfVUKgqGyBhQl7OEBOC0c6bLpbKyjlZCwsd54T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717013; c=relaxed/simple;
	bh=16dSKw7/EJpVhUVmI700TfMGcHJgKW+YH30Y7UgtZS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tMSFEJ0hniieWIqSnDdnjrfJQr5h6vvXCNcqbetQVCfePGpMzKRnOmsRTKvi+/Xo6jwL/82qxRQmsVcAMGCtPd3xznccqmN8XfEKvNndTzk4PIjUO+Zu3of2ZJqW3oetNsJdpvDwFOVDUyQLM6tuAfsjYZrfEWmpkxZiV1/lb/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=HCU0esqO; arc=fail smtp.client-ip=52.103.72.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="HCU0esqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmOJyKnJMyHZ8cI0cHBvof7G28zn6W7B8EQ68/3Zanc6gzQJ9G62uo2Hkfpube1lPPUa9sKJTlaqT+zBC0To4mDd0PzW0RJ3XibcWzy8saI9xY1jeG5VhYUKTwVosNHar/10db0JjhKTIVkAd5rBWJP2anh2ajr5qkt5yCRGVdJDgE0V2z2SSRTU2H/iy9uqab8eY/sJVHyntpWf5lsPocelPYbryqwS65qYcqe4tAw17jDpmCQvWtvdr9OPGuVo84Q+LNlJYsl4CBYsQW/Xc/YHdVBpXqrNZzJJ+h+QQ+jPy6OZkvWwdWauN81g1F7QyPX1zDGt7x5Zg1Q9ldss0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16dSKw7/EJpVhUVmI700TfMGcHJgKW+YH30Y7UgtZS0=;
 b=H/S5xwIy5yWKqkA941kzsMtuEjGDCuanA9FDQxLmb2si9UD6cL2rv+0Nr41SIO6LUrYqkx2hPqjNSUgKy+DG4X02zqI8fHkPZUYMgT1XLDAq0bxiHVnXHHN4dsySWZD+OioQqAwWfTnbqFGJabCbTU/b0r/In+CEiJGkhJoKoMH8vj+0qvSabw71egzaQ/Y8wUWB0V+S0MA/yF2YLX1xVLFX75IFawDysV/6aO/lZLJ6EnHqa9P1fYyaTbVDnh3kdjsPUrq2PksrHviaXPMhvNMCiLdA8Z4oQ9RWCkoR8Bd8+lORZ/vf8k43XnHaRehXWmAQL5pjkf8nV9PwqfSwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16dSKw7/EJpVhUVmI700TfMGcHJgKW+YH30Y7UgtZS0=;
 b=HCU0esqOrD4yrgqsV5XZCMBeTooyu6jQklTq0pvwi8Owbv4/KGIqLgcR/jiMvknhFqcDOBWJe2aqgg4mXWzdNNjoPM+Dq/KSNL1qeFI7l0Jm15kD8K9CtY8ZiGxz6bsKgVF6i/GRLGJ6RmmuGC8PDmijwR3371PPRu433/izQFHM82r0NN1jEgwdlQLb4Y1juLg7uQ69wyw0wQ4O/mZQ+K2R/2MBfYdI96CF++84TKB/zjpRIn/6oyDCigbne1aSKTNDDXJmxm6dT2jaExPvVY7r3jEgqvm8qh6ZgNj3AzH2USckmiw2d5jfntE5PaepsnqNfyyI2g8vbdA2wzD2Lg==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by SY4PR01MB7169.ausprd01.prod.outlook.com (2603:10c6:10:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:10:06 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:10:06 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare
	<jdelvare@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>, Guenter Roeck
	<linux@roeck-us.net>, Kamil Aronowski <kamil.aronowski@3mdeb.com>
Subject: [PATCH i2c-tools v3 2/8] decode-dimms: Decode DDR5 Manufacturer Data
Thread-Topic: [PATCH i2c-tools v3 2/8] decode-dimms: Decode DDR5 Manufacturer
 Data
Thread-Index: AQHdB5ZQfOVamAW2+UGpnBiKfava1A==
Date: Mon, 29 Jun 2026 07:10:06 +0000
Message-ID: <20260629-ddr5-v3-2-07f45075a51a@outlook.com.au>
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
In-Reply-To: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|SY4PR01MB7169:EE_
x-ms-office365-filtering-correlation-id: 3a4da533-3c6e-4a45-e353-08ded5ad7303
x-ms-exchange-slblob-mailprops:
 5fu/r660v9Mj6U6kz+12O9pZy2TuKGHDrXW51uPcRHSXFRiezDTZ4MGNGTtLkXQ5ZyrfL2P/5WgKmLohdzg2LBygRLfIKrCgOdqQljUHV4HQkvXPA70wlvsWXhz6AgqltXXtEcn/YbLXbmI3vD5BuZ+oWdFFbd+93iS8ny4qDu/VRWglXjGWT05GFHKuDZUZE5dxM8LazmF7ShjpI6pFx7dp/cttBREoYW6+ZPyBeygayGDE7FxFkKxM72wxpR2RCGgbnFHdjzLI1ZlBc3zmZ02fLcyu0ICANpp6DQwM06LYzV7Gnoj2YmN1XLrfoGgTZoeA2FoyYEP3KQqizqHpAmECW7XzbXkFok1aRavC3lRAYGt6YbvTRiAND6JvYFgPKZKeUon8BkvzsM8t2dIQ1BIXENMsCV5azw03XxnGgyWFH/iehEDp0Y5PxYiHmFTH9GkepUjZIRuymGAK1dQ8D/U+6CqnnQiPxcgMGPhBbiclSbI6jFD6FE7zr161oKg8cNX3+eHIU48jDv3senAe2Bd0Kby72JtsqK0Mt5TKWPTFn+HvxQ92D9rGSpRFgKVq8qhPEsf4xQyyvAGhWaca6TXGagU+Gg83rUEFDlJCBoK5/8DEWtIWnIMYhhAYuhuiJ4Vg6LDXrX16+iwFz40abQMtt6uMEx0CDVb8g5ziziOqGOZGb8QAbP1yEY7DNmDQx45LmaALAI1P4+5d3Orgy7SxWh7ZKzr2AJF6Pto2nnM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|24021099003|31061999003|8060799015|51005399006|15080799012|19110799012|38102599003|37011999003|25010399006|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?cm1wMjduQUI3eTdlWXFHK0VMM0d0czZSUjBMVklmTTI0WVhKdVRtOHNSWHlR?=
 =?utf-8?B?S0VkVEx1TDZ6WUZBTW9uOVltUmdmemt3U0h6UVk3a2w0aWtiSFZpRms5MzFC?=
 =?utf-8?B?dXcxS3VJUW1zSXhSbnE0aDcxNWViRTJ4M0tjRkVLSmFSTWVLY2s0bzdMZlF6?=
 =?utf-8?B?R3NiT3JtejFCUmhkZE5sTlgvaFV6ZDFLM1hOZ0RCSmk4Rk9zRDIyTU1kaDdC?=
 =?utf-8?B?VFRzc2xMV2prdWJQNkV1Q0dOVENnM1ptODNCdGE4bS92T3FDL1JmQXYwMDZQ?=
 =?utf-8?B?bVRoWUhuUXVtL202WHBoSmh0L0NCZ2pYbmVocUtlNitNZUdXak5BdEU4V0xD?=
 =?utf-8?B?Vy9kU2x0cW9INnZGMC93amtUVUNNcWRiOCtwM2xZS04ramFJbU5XWUQrQUVq?=
 =?utf-8?B?bGZuRWU0WXB2L21YRmRvYi9sa3FLNXZERi9JL3JuYVN2Q2xrV05KdkNLT21J?=
 =?utf-8?B?b3dKNEVTQmUrRVM5V0tHWmlNZ0VDNnFNNnhJSnBTWGwwUCsyZk5wNlRzMHdY?=
 =?utf-8?B?NFpoa1ZBZ2toeGNWNzNkZHNxOXdaaWQyS0pmSW5wdG5uQ1oxNldPTDV6K0lZ?=
 =?utf-8?B?cWlIT3pvT3FXWG1DTGFGK3JtWWNKbmg4SlRlem0xMlRxSFRPdmUzSG1zQTQ0?=
 =?utf-8?B?L3B1L0RCb2llcHdlSE0rTzVHSnBSaG03NTZ2YzJHb1ljbXE1a25TY1JRYlJE?=
 =?utf-8?B?dGk1ZnpRRXVjUnRWZmlONTNMbnpwU3J3bHYvbG1zekZyOXM0c2M3MkNhaXZO?=
 =?utf-8?B?azJEdWUxWDE4LzYyWUNmZ3FtMDRneGE3RVgxcDJQdm51VmVJSWVERmtMRkRG?=
 =?utf-8?B?azR3R2tIYUM2OXV3TGRuREdtZ0FESXR5NWFMc293S1NyeWpTWFNycy9jY2ln?=
 =?utf-8?B?TWZtd04yY29iY2lWeWlmb3FmZ1JNa0JhQjBzRk1lUzhienRiOUJySUVwU1Rr?=
 =?utf-8?B?ZktJRkFxTUlmcnp0N1BOR29wa0lLV3F1VWdMeEs0U3JPSXFvdWFIZTVGY2k1?=
 =?utf-8?B?QUZNZ3g1d3QyZEJHR0FCZXpOSkNueTZDSVZWWEovbzlFaVVUb0FldTJKaC9W?=
 =?utf-8?B?SzArTnZTeTlqWThyblJrSDlhak5FNGpYN25sOXpjdlpFczVObTB6QUFwTGVN?=
 =?utf-8?B?Y0lwazV6VitJOUV5N1kyZXN0T2h0Qk5qY2pHSmRFSzdBT1BrVWxXMXM3cDMz?=
 =?utf-8?B?VGhkN29yLzY1SjE4M1pDbG1TbzEzNU1nZnZmd0l3MHI4cldUQ3crMmZzWlR2?=
 =?utf-8?B?R1Vzam1RTHduMWI5aXBYZjZ4VzZDeGRnVXVaKzFVemxQemp2RHpiQXlnWHFq?=
 =?utf-8?B?QTVjOXpPOFB5MUM0T0pIZTNFYnIwKzh4TzV3ckNCeVlreXpyYUNKeDFOdDVL?=
 =?utf-8?B?V3FtbU4xdFo3dFE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEtOeVJRQ1MyajJ1enVLMHB5bUxPY2pWY2xsbmxNcnI1T3lxWFRLMzhUQkFa?=
 =?utf-8?B?VEw3NkcrTUJ0MlVIVis2aUFQQmppWHpzVWpjUTZYWWlNQitqZi9IdldSTFY3?=
 =?utf-8?B?YXFJWUh6Rk9xK3Iyd0J1QlF5U29ta21JaHhlZVZwUlBZMVZFMFRCZ1FiUXky?=
 =?utf-8?B?Ui9LVjJVQy8rR3JFL0hTdUtPamR4YzQ5d0NrWmcxS1p3SHhYMDE0RnZsRkFP?=
 =?utf-8?B?WlZqd3FwM2xtRDBGMG1OcVpEYlFSTjdSWUdzZnRkTTdmWHA3ZCtrZERMNlMw?=
 =?utf-8?B?ZGFpcVYrck9EalRvMnl0eVRUVmFma0MvL0tyWU95cm1ZZWNSb01wOGQvSkFQ?=
 =?utf-8?B?MHprZ1M2b24yd0EyZDR4RG13eVR2U0YwNUtUOFZNWDdMQ09OUXZnMWI5UzFm?=
 =?utf-8?B?K2Zpd3ZWT0hCQS80UTdTK25KTUNEUHNHcngrcmpaZ1VHSVZaNXJTYXpTNFls?=
 =?utf-8?B?TkgrOUJUUGhBdWs1ZSsxNU5KRkYzbTFuSmpqVUdhTEZjTWZMenlOQWFNc0hX?=
 =?utf-8?B?T3FXL1Y3aEdRS3lMVkV3K3FYMStEbGlpNmdabm82MDVaeGlES2RsTmNuZVd4?=
 =?utf-8?B?ZVpGbGF1WGtGSCthNGozR1RrUVZMQlNESWM1MjkyYU9rZ09QWm44OE5ac2Zw?=
 =?utf-8?B?czlyaGxpZ3Y3QlU1Z29Sajd0ZzNkaTdjU1NqT3hTQkJYdGl4NzNNU2o5L2pD?=
 =?utf-8?B?UFRmRjVnaGZtaFdSeEVCUUZTcDQ5VEdJT2pWdTVnZkxTTWtkL0xEN0w0aGFv?=
 =?utf-8?B?ZEdyUVBPL0dHeE5VMGl5UllKbzdiYWdTVkdyOWR5ajF6RTZlOE1reDhGWTFz?=
 =?utf-8?B?ZS9rQ3MrNklMU1ZLOHNjZFRSM2VuVnYzVHhXYlEvN1lYckd0aUIzUTRyeG1n?=
 =?utf-8?B?ZkJmb2EyZVBFbFZTOVlJZG5UYU1Gc080NWwxQnJSNjU1U2U5RmUvb2xSUE5B?=
 =?utf-8?B?YXVBR1pJdVgvMUoxR2ZwamQyVXNlRTEzWk9XWlNBWDhwbEVnTEdUUnVFVEV4?=
 =?utf-8?B?dDVMdTJQVDIrNVo0QnZDWTQyRCs0UEx5SUxCRHZBWGQzQzREbVBzSmR6UHl0?=
 =?utf-8?B?T3ovVDFITjJtNnFLemtvL0JXbkhTTHR6N1NaQk9qWVFuTUMwc0pEUWVUdXlr?=
 =?utf-8?B?eHExR29KZGNvcG9KbkN4U29sYUJLQWdxTW5QS2Rhc3FPU2Y0amkrcDdWcGs1?=
 =?utf-8?B?WWZyT2FPNlRhUDdPd2VMMTA0OEVmZEo1eVExaUM3anNiWno1ZDgxS2JFNzls?=
 =?utf-8?B?MlpnVGpEcEtVamRVUnZjNjJzSWRTTkFUSkRWY010cHNSRjZBWTN1Zm04Q1Nt?=
 =?utf-8?B?OUkvUjluZCt4QmxBc3orNndhblZ4dkRqUk9BQklVKzV3dXJuUDJYUGwzZy9t?=
 =?utf-8?B?QjR3RkRwMXByMElnd3dscHpTcEpsY2ZKWmMxM2NtZit4ZFRrQmZvR2U5MHNF?=
 =?utf-8?B?QmYwVGp3T3JLNk9CT2xJVUs0d2pibTV1TTZwemoxeUtpeXdTenUySmVQVHZz?=
 =?utf-8?B?ejhEQU1ldlJWZjhqRnRtUmljdFNwM0VnNUpqMzRYaDlrRTBDRzVhQU9GZnpJ?=
 =?utf-8?B?MmVWaEtXQ0NLdFhYVUdBd2lrTmJWV1RQK1hzVjhrRTBwMFh0STJJdVlGaFVW?=
 =?utf-8?B?Ynh0dkZybzhkSUdxb2xKU09MdEp4RlZnK3luNFlRZXU3N1ZpMXNEL2RtQTE0?=
 =?utf-8?B?NUpnVnR1c2tNcjg3TEwrVHFReGRKVWJRNHlhY0M0TDZqQ0o0VlI3WFdHQXNP?=
 =?utf-8?B?a0UzbXdZaUNIVE5DeVJMWDFwTUVISHRPZkRrWkFnOVVSTCsxSUs5K3hXcjFa?=
 =?utf-8?B?K1BXWFVHZ000UUNiK2dERUZMcHNWUGtPM2R4REh4aUlTMURaOGhzWVplakFh?=
 =?utf-8?Q?WxrkwgTFjgyIl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47F870BFC286F44BBA574E19AC2595CB@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4da533-3c6e-4a45-e353-08ded5ad7303
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 07:10:06.8307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB7169

RGVjb2RlIHRoZSBEUkFNJ3MgbWFudWZhY3R1cmVyIGRhdGEgZm9yIEREUjUuClRoZXJlIGFyZSBt
b3JlIG1hbnVmYWN0dXJlcnMgaW4gdGhlIGNvbW1vbiBhbmQgdHlwZSBzcGVjaWZpYyBzZWN0aW9u
cywKYnV0IG9ubHkgdGhlICdNYW51ZmFjdHVyaW5nIEluZm9ybWF0aW9uJyBzZWN0aW9uIG9mIHRo
ZSBlZXByb20gaGFzIGJlZW4KaW1wbGVtZW50ZWQuCgpTaWduZWQtb2ZmLWJ5OiBTdGVwaGVuIEhv
cnZhdGggPHMuaG9ydmF0aEBvdXRsb29rLmNvbS5hdT4KLS0tCiBlZXByb20vZGVjb2RlLWRpbW1z
IHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2VlcHJvbS9k
ZWNvZGUtZGltbXMgYi9lZXByb20vZGVjb2RlLWRpbW1zCmluZGV4IGQ2OTRmNDEuLmRkMDNkMmMg
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
ZmFjdHVyaW5nX2luZm9ybWF0aW9uKCQpCiB7CkBAIC0yODMyLDYgKzI4NzQsMTUgQEAgZm9yICRj
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
