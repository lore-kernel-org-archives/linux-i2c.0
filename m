Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010074.outbound.protection.outlook.com [52.103.66.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97731077A
	for <linux-i2c@vger.kernel.org>; Sat, 27 Jun 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782580366; cv=fail; b=Ass3Hd2GXHiPf0pj3eZRxhhgRHLkBjp1zJvb8OsRurfLiia5HbEnFhOlq22w9xg7OXgisjRST7d3cV9Gr6eaNa1pxfwb2+JsfwIQODgvfLrdD6X0HVXtDriLLgzt3UqxiYAbhkn/erEKYhMoVpM0GXdi26gvQnZyATMzjbOCemY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782580366; c=relaxed/simple;
	bh=sFZy8Rd09bJfiIsKamf4bXSi/UIO3FLcG/JpQzXTRCo=;
	h=Message-ID:Date:To:Cc:Subject:From:Content-Type:MIME-Version; b=Y7fDJwxKc4RfkW4hGnVZWMgDDjuBBdXxX3ohQ1coWevJI4LmaBrrdXGgXexXUfOPdsbTja1Pqq1fYMWptE3WZRLE8omTJ0jasBMB0DcR4mK+dq+ne/HEyFafawcDr6eLjz+VFyH4JvEo00qv7pd9SREWDSFltywXKMx7EAof+wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Live.com; spf=pass smtp.mailfrom=Live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=KY4he2N1; arc=fail smtp.client-ip=52.103.66.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="KY4he2N1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvnSZjKjTYU1a9ztEGWCt0AnDKl+39n2qG9fBroBU8zkc5EEknm3JylyXxT2KsfUHSezrS3NZ0F5Ta6WtyGQumqa+Ta3zrFV+D/+tJ1U3XbOX2xfzfVA6JpwIVtxDk4C6t2z8BXMRG+Rd25d+mgDiOja7X8LrxvIjB7gGMHdGcPKGQhm4VTOiaepOsYJ4YElQUerq/SlyDtoLf0+zi2a0KCr0w7zMVQxjVzNazw1Eyf2yz5OKdGhHwJpTtVWOZVjfx+P7rOUlshSfbgzTZneKtV4gc2vLeQLYB9kl6WUVDq450qNEKwYiVln6JJkD5/DPbBTstIbo6hsmBlATPk5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MskIgLVzCK02jsyJS09kIRtAnUxt4QxBZYsZp8NWzM=;
 b=qy3N0LyBpDzOQoY66EDVX6QOQj+8+L6c0l0TQF0oW50276E9STWVzAR7toFTju6fENhIaMpVOsvZRBF3uxSqtKVy87nCif0q6gfzXEpO3/VFUVALVmn26bW4J7NM8/9G6gJljzaIXLZCOgOdP2m5dmmqrZhphPs4TaQDHH8cJbXRFwsqC9MWJFApY5SlKG3dCXYhhz9eXb7jmXRIuE6tCKIApvMHazTtg78YM/lJPIJ+3pNRTV5FKIeIE7Anbq7UkeJ/81bxF/4V7hwodmjD6O0coz2pMPmQrN92MYga1czqFu0KiMRLVn5mbj7ZGNZ4NcJinYR8M5V8kxV0GiVfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MskIgLVzCK02jsyJS09kIRtAnUxt4QxBZYsZp8NWzM=;
 b=KY4he2N1sxsdQJFu5eIGIMrR0AkN/XqYc8PqHexHMthW8aHp6NJJI3kJAqhiPRc2SLWOgOpWOuy8LYxGTZBgwWgK0bwFtXwK6HVRhNJnrCFeLq7nEgdwn9G1Ff3f7nYY7dlOxoxN9KDWyiu6HxB+WLKV6CwGwauT90L/Lu2BDTB6bsHbeOjjAOmSxTCPzQ8Jtbf74YPFdwhKgeA6OD3FlBauvR2ZCkRgUb8X4UhiQM16c5Opr94nc08nan4lYgdj1+Up20Cj4wW17C0gtUDczQrTi7xyJsqwk8ADd9Lp3gXxcQMdl8XJn8L/gL+hqBO8SdKXKYOmCJoElLw2QEOW0Q==
Received: from TYWPR01MB10868.jpnprd01.prod.outlook.com (2603:1096:400:2a8::6)
 by OSZPR01MB6890.jpnprd01.prod.outlook.com (2603:1096:604:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 17:12:40 +0000
Received: from TYWPR01MB10868.jpnprd01.prod.outlook.com
 ([fe80::6c84:dcea:865b:9290]) by TYWPR01MB10868.jpnprd01.prod.outlook.com
 ([fe80::6c84:dcea:865b:9290%5]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 17:12:40 +0000
Message-ID:
 <TYWPR01MB10868BDAE286FB92390F87DACBCEA2@TYWPR01MB10868.jpnprd01.prod.outlook.com>
Date: Sun, 28 Jun 2026 01:12:34 +0800
User-Agent: Mozilla Thunderbird
To: linux-i2c@vger.kernel.org
Cc: mika.westerberg@linux.intel.com
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work when
 idma64 is present in initramfs
Content-Language: en-US
From: "runzi.wang" <stripsss@Live.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0024.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::6)
 To TYWPR01MB10868.jpnprd01.prod.outlook.com (2603:1096:400:2a8::6)
X-Microsoft-Original-Message-ID:
 <54669027-fde9-4c79-8040-52c55cd8f76b@Live.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWPR01MB10868:EE_|OSZPR01MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6beeb1-64d2-403d-a38e-08ded46f4a21
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|19110799012|23021999003|15080799012|6090799003|8022599003|8060799015|5072599009|24021099003|25010399006|4295299021|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2ZhWDlrRnRTQU5pN3dxNDBMeS9hMEdhRjBDZ3h4OVozYyt5U2VkQjM2b1FW?=
 =?utf-8?B?eDFrbUEyTnE4bmUxcHRrb0xGWEp1dXlCVDVZUmEvSWFMWkJZa05PdU0ybSsx?=
 =?utf-8?B?bGpEbUJBMmZHeWJJVHVHMmZpQktrTW5WTG5MZVB3Q3RiczFYYmp2aXgvOUZ3?=
 =?utf-8?B?T3NoaVVkTnBTY29kYkFpbzBmWWUwUGlOZW5qdGkrMnI1TFlwbFhXRVQvM1ll?=
 =?utf-8?B?czJHZThKSzltazVXdGhNU2xSbXU4cG50MEVUcjhMN1V0MGh0TUwzYW9nVWwv?=
 =?utf-8?B?L2l2TzQ0Vjd2UWJhOVltQklGTi85c2dYMk4vRnhCWkY2dVRKNlRaM2dJQ2d3?=
 =?utf-8?B?ODg2K09aL0FWSHEvbGFMajlMZU11Uy9kdC9RRXR2dFlYZlBXUHY1KzlHQ0xk?=
 =?utf-8?B?K3JFaVRWS0ZWcUFkc0RnM0dGWURSRzVBY29oVXg5RDFzMjBPcjg5cm00TFJh?=
 =?utf-8?B?ZVNTZUdPQWt3enQydWt1eWpuMVFtZVVJYlN6aEdxRXJnanJ5bndzQU5SWldz?=
 =?utf-8?B?dXlXMndYQ1Y2ZnVLaXpnamliVnlFM2hRcWRsZmJ1SWpWTFF2TWJta1kyemM1?=
 =?utf-8?B?ZFY2aUhJaHEyVklWekRzN1hvRDVtdTVnQkM2NHd6b1NFQWpEMGE4MUI1a2dq?=
 =?utf-8?B?WHcxa052dUNTUFJPVkJMY3RhYzRZV1RWeEZsZktDZ2xPTkF5bXcyVTVSMlla?=
 =?utf-8?B?Sy83QlcvQWFwYWZXbm53aTh6b20xZXY4ZWlsMGNPbGJMZEZrbTVudHh0ZUJJ?=
 =?utf-8?B?K2hSNmpMamVUKzFlMmdVckp5RUJ6NXc4WTRVd3hydnozU1l1QnZJZkpxN1dH?=
 =?utf-8?B?NXBnbCttVUVOTzFGS3QxRFhUTmpTV3JmRUhyZTVRNGZCb0lqYUNTQVBkTWpF?=
 =?utf-8?B?WUZrSnBpR0ZMc2dGQ1RzaHYvbXNJZndUdUhPdEZ4WnhMUGxXVjRCM0lqS3pl?=
 =?utf-8?B?NzlKaWlsT1huc0FPcG55UUdjSHZOcml1TjNtNkJnU0IrRksxZmt6L1plWWNo?=
 =?utf-8?B?OXVTVEk0L2dLZExNNElBZWVVc09wVlZqc0dvaXBHazlSM0pnZll3NGY2QlRv?=
 =?utf-8?B?WFFlWVJiOGIxUGxGVVA3Z2REM3FQaWpsR2lSSmxKWHE4Y2d5aW5NN0VqMWhM?=
 =?utf-8?B?Y1J6SmwvQklNSWNwcGEydGN3QzhjNWl1UWZtRTAxUk5pWEtvbEZ1TXJ6bVpG?=
 =?utf-8?B?dFRwTWNmVGxtcVI0VGtHN1FFTTJJK2haNlY1UDRzR0NzTVBld0EzL3NtSGlk?=
 =?utf-8?B?MGJiU3dtTHBIQzlXa3RsVDh6a2NGSSs3WGhzc1Y2MGNIZmFSdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nkh2SHJOWS9FamxWRnFaTSs0UTJtSFVkbkFZb0ZxaXY2eWtHZmJiMzV3OUsw?=
 =?utf-8?B?SzBYTm8yYVF2NnZXNzJROGh4UFJCTVpCdGlqTUxpSE12QUZ5RUMxTmYvNmJS?=
 =?utf-8?B?TXpGWmJuTzFqWFBJRENXYjRSTWY2YlNRNXVtTzNXNWtpNmFkL1lnNUtiSGls?=
 =?utf-8?B?ZXBuQ29vQ2kyd2ZhS2FXNi9qZDNWUlZiTkJid0pkQW05UnIrS3NHeVZNNFly?=
 =?utf-8?B?Qm1yd3pxWUpmT2ZGZHo4S3JONThUMTNERXdkcUlUWWplNm9lNDJneGlCTmpt?=
 =?utf-8?B?dWRuZTc4Rnh4YmxDd1Q5L3Z4alhld3ZIMzE4OCtKOElxUWpMbXZjVmhrSU5L?=
 =?utf-8?B?OFpOM0p1WjJqZzJHaTBqTTFkNGRVaUxpbjVub2ZWV29idElHT2tCZGk3T2ps?=
 =?utf-8?B?NFB0MUhXK3QyY2hSL1lMbUZ4NHV0Si9Sby9XczBiYzNGdWxMY3dIRU9GSHZZ?=
 =?utf-8?B?OWtWYjRtazN6NXRCTzhad2pHM0kra1lXKzJyV3ZkaWZsWWdNQ0x6N1l1bEtw?=
 =?utf-8?B?WW9CaEFHRHh5SHBUdkk2SCtVK1QyN3NDa3Jmd1BjZ2xQTWdFSlVuSmxqOHZq?=
 =?utf-8?B?dTN5L2dWeFFscDlFZXJSckVqNTUvZjlDdDkvb2k4N1ExUVg5NE43alhNaDUy?=
 =?utf-8?B?cVRibHlUSnl1LzlFR1lYaWtpTVpYeEVxRFFKRm55NVpJNS8vMVZ1WFRHYit1?=
 =?utf-8?B?V3FRaHYzKzcxNkljTkRld0ZSNGZJRGg0dWJ3bmR1RTdwcklUZkFYREVwSllH?=
 =?utf-8?B?bXRDZHcrZjNDeW44dVBBdDRsZ0szeEg2dVcyWHErUjNQbDZKMFBXZUxqaFk2?=
 =?utf-8?B?d0dwellOVWZ6aHJMOUhOREtQYjNmSWRoUjAyNU9TUjlVUVdWOWg1TUdhb0M0?=
 =?utf-8?B?K3hYMGdTLzJrbHJYeFV1SFhtY0NXM0Zqd3NkenUyd3Z4ZnJZcHNMWS9KRHJy?=
 =?utf-8?B?UHA1amQvejh5ZVhJNVVFQUt4eS9FaHVvb05tM3NvK2FqZENBelV0WXIzVGJv?=
 =?utf-8?B?RzBSb2hzR2Q5NTRaei8wRm05T0IrUndITXJwY1F5cWJSVVljVTF4ektWUktO?=
 =?utf-8?B?bmI2a0NNYjc5dngyeDhBMWZncTJJSm55OGxxTGZCMnQyejV6TFBzdXE1YVBx?=
 =?utf-8?B?YmxDY1pSTURSNnJZczRQei9qWlNYSnowamFXZDlTK0xKSUdqRVYydmFmU1Zs?=
 =?utf-8?B?YXhmbCt0VEpPQUpQMTVTcTFmUXNtY2xrQklKK2Z1RGZ2Sk9EUGdyTzJqVEdH?=
 =?utf-8?B?K01ER0MxRE9wMEowU0dURFgwcFl2S045NEZwalRKaWxWbE1FeFQ5ZlNrem8r?=
 =?utf-8?B?cS9SYmdhU243MU9VcEtQdGtxelk3SWU2eWZTcUhaTXp1TFB1ZVhkNVF5ci9K?=
 =?utf-8?B?YXNkSWNubXhWbUNGTUxscHh4NmcxY2JCU0h1MGFTNElvZDVFVWdYb2Q2SVlN?=
 =?utf-8?B?TW5mY2dRNHAycWdqQXc5WW5DcWpuVFQrdVRSZnE5Y1dZc085R3NSN2phbjRj?=
 =?utf-8?B?WU9sMWM0WWpvdWhWOHE1Q0hoMGhUNHpWRVRPUnkvN0lQR243NU13TUJHeTZH?=
 =?utf-8?B?bHF4M0VhRjV6Snl1UVNOT3RmU1VCT3N6ZUpWT2g1WjZUcFhnYTdnQTR0RUFB?=
 =?utf-8?B?MVltOGtDbTMzQXRzNm9Mc3pKMXJXWWVkRFdHLzdsMElpa1V0bjZ2Ry9aQTNP?=
 =?utf-8?B?V09tUEQxTjh6dEpDU0xKS2xOT1B3MXZkWEM0WEs3TGlyemQ4Wmd0ZFphL1dE?=
 =?utf-8?B?cHFNSDljaW16QTlUR2JWakljM1BuR0ZsOXp1Rmg3VVJCKzh6dGdSeis3ZmJG?=
 =?utf-8?B?dktldGliSWRlSWRSTmNVTG8xRzlUUnpaYnFpdEFRNUtVMXZVQ1hKSlRuQlpI?=
 =?utf-8?B?T1I2UjMza3BDbnh5MFB1V3Y0RHJLWG91cWZ4eHJ6ek5HYW9KY0pWZGdLSDV5?=
 =?utf-8?Q?Vx+zQXHDh5qkf+F3ceAgTbcM9E9eMIpR?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6beeb1-64d2-403d-a38e-08ded46f4a21
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10868.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 17:12:40.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6890

Hi,

I'm experiencing the same ELAN06FA touchpad timeout issue on my Lenovo 
laptop,
using a self-compiled kernel. Here are the details.

Hardware:
Model: Lenovo XiaoXin 14 IAH8 (83BF)
BIOS: LACN42WW (2025-12-30)
Touchpad: ELAN06FA (04F3:327E) over I2C HID
I2C Controller: 8086:51e8 (Alder Lake-P Serial IO I2C #0)

Kernel (self-compiled):
Source: linux-7.1 + xanmod patchset
GCC: 16.1.1
CFLAGS: -march=native -O2 -pipe
Local version: "-wrz"
Key config changes from xanmod defaults:
CONFIG_PREEMPT_LAZY=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_HZ=250
CONFIG_X86_64_VERSION=3
CONFIG_I2C_DESIGNWARE_CORE=m (not built-in)
CONFIG_I2C_HID=m

Symptoms:
- i2c_designware.0 times out with -110 (ETIMEDOUT) during probe
- idma64.0 IRQ storm: ~100K interrupts on IRQ 27 while all other
i2c_designware controllers (1/2/3) show 0 interrupts
- Touchpad not detected at all in /proc/bus/input/devices
- Occurs on 100% of boots (cold and warm), never works by chance

Workaround:
Adding "acpi_osi=Linux" to kernel cmdline fixes the issue completely.
The touchpad initializes correctly (I2C HID v1.00) and both Mouse
and Touchpad input devices are properly registered.

This rules out any distribution-specific kernel configuration issues, as
the kernel is self-compiled with recent toolchain. The IRQ storm on the
first i2c_designware instance seems like the key clue.

Please let me know if I can provide additional debug info or test patches.

Thanks
