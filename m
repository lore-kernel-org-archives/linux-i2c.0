Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011024.outbound.protection.outlook.com [52.103.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC74964F
	for <linux-i2c@vger.kernel.org>; Sun, 21 Jun 2026 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021173; cv=fail; b=BYO9/AHNfyRXD6DtPs/4rYYmA9Dt0igwY6VHqhT+xTohrkM2+75YKi+Rx9aAKvAqxTUOPq7BkD8yPhB5uv0QhlvL+LSGWoC6OAAzBGtx6HxZNEg+uxQ4e6VugPdtLjZ9F32YQLhokZeIDbACuU3LGe3WtL/nE5D0x5umJ43XL64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021173; c=relaxed/simple;
	bh=fHnyFcgUU1JS+GJpu8ZlAcYhNaBKr47uT5CsRlNqmMM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GinCBA7b5oV5FQKEJTbzaNAlmErl98SRTpGcL8fCdrxI5el4b6RqpJBIJzXfip2So7HKYynXfT4jm1Q8lnAu/vz7FG+3NocTzJlP5YDxxplDuLFEC3ZXQ5sXtOlGRYDzLF6YWLhMbc4GnIFhEH8pgg/wjUPVSDLwWbJHSS2bobw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=PBtogsRa; arc=fail smtp.client-ip=52.103.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="PBtogsRa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYEcvbQrWo9GrgFqH+KehRRuiV+C8TpnxKfq86RVbqhn2MeN7LHVKPFQYVfMoLrSurvJs/Eg4Gp96lLleQo5qMsHAVL/6q53BlDYrDaceFlqgVykBQany+R30ZNQlmpgIm/38sKZU99gTwlyhMXHR1enX3TSEFdLLqX9GDj9a6rCHME+TWr+Y/fZgLaZlsUjeH1CF7+5XmmbUPjV0uAmo7OToqTQ9C1lT7CNSIgw4k9HGsJJqkhmD4vv9H7HjzScTnW6wdlUSIvCJPpADfDhtIuc6IqwcTjpwrF9PGqJ6qmMnsP5SNb/AnKkCRBrm/qiCB+RCE5ahksTUQwON+llKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzqBHcMjI6rYKvqSlx8pbMDYvR95qxPFGOiJ5ANAXSc=;
 b=vD1yi/S/yPEPxzM2dxwEkS0DGBkIBNkARdxhZxr+l/La+pDxiYAYDVldmk63nS0wcaN58Y3Kdh0nmntRRhb3SRbFyDjydRkjOc1LlfOyZ7v22kEakKHA9JH42KU20rUShakoiPWS1PPqJkggDLceC+ISe3gzDt9qnGRtw4JjpgGouhMgz0nGBOhNDrzdCFPgo7fAYaleBPwG0TrUDRsPkD+HuxFkVQuZZzRCTENAjP1o3tp6Yu9EQOtPiHRM6AmnctFPT1nFavYCUHGCAfqmAJTY4bPOFjBK9DCmLDaVFgCI1yDt8PRxLaWWJc7jdyLJvJFEN0m8UJQ9ZMJQ1LwYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzqBHcMjI6rYKvqSlx8pbMDYvR95qxPFGOiJ5ANAXSc=;
 b=PBtogsRaz/hI4Y4Mj+gpkgC4EZN9pED3yjuc9x6mmWfoVBapohN7qTCfz26jl9tbX898O9RaTzA9okvYB5MVGAipA6jgiTjYOzyA8HipJ0anpnk84UzDNPEEO9Ky2phVU38uzr/vmMwBv5SDAwnjIJrAD6WKiPwl6BSO5UXAELlBzKnrhZKckOrYUCIBeD+5Aac/GO1VHqFOZiLRUlPvaNgjasOTaaft/Yc5gPX5Ir3kETOHBNDgNP/1gRlmn6LViTXCp5HSOal7wOHVzLS8QyVKGwqyIzuWx3M1LMrBiviEccxbtS3QKkT1FQIOvMbIpQSgGTFztns4H218PIL6Pw==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by SY7PR01MB8980.ausprd01.prod.outlook.com (2603:10c6:10:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 05:52:47 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 05:52:47 +0000
Message-ID:
 <SYBPR01MB4586E27116CAFBB44B16C493C5E02@SYBPR01MB4586.ausprd01.prod.outlook.com>
Date: Sun, 21 Jun 2026 15:52:42 +1000
User-Agent: Mozilla Thunderbird
From: Stephen Horvath <s.horvath@outlook.com.au>
Subject: Re: [PATCH v2 0/6] decode-dimms: Implement DDR5 decoding
To: "dlitz@dlitz.net" <dlitz@dlitz.net>
Cc: Jean Delvare <jdelvare@suse.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Kamil Aronowski <kamil.aronowski@3mdeb.com>
References: <20251106021356.208986-1-s.horvath@outlook.com.au>
 <aXq19uxerWI5SvcX@syra.dlitz.net>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <aXq19uxerWI5SvcX@syra.dlitz.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P300CA0027.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::17) To SYBPR01MB4586.ausprd01.prod.outlook.com
 (2603:10c6:10:59::12)
X-Microsoft-Original-Message-ID:
 <f58fa5a9-6e21-4dd7-a627-35cd03798e78@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB4586:EE_|SY7PR01MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 73dbee9c-9b09-444c-21fb-08decf5950c2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8022599003|15080799012|25010399006|8060799015|19110799012|5072599009|37011999003|24021099003|23021999003|6090799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enptNGlaMWg5QjMzdFpyc1dvSC9SamNCZUJVSjBlOFk4U3FMTllNZ0lBYjl2?=
 =?utf-8?B?Tnl3VnBXcU5uMFlBWWZES3hOMEFDZ1RDRlkzc3JTL0RiTkg2bkdzQ21tU0xJ?=
 =?utf-8?B?N1NIdTJFMXphcGJxYjQ0K1ZrOXhuK2YrM3Vac2pyQjFhdER4bEY5dDFxSnFk?=
 =?utf-8?B?WTJOVUF1RzE5QjhNMlpzQys3MEFoN2NuSU1WajVqb0RhNitMSU14Rk1XUzJF?=
 =?utf-8?B?Y1dUUkY3ZndEK2RRdjRid2wvT1Izd3NoTEt4OTVheTFwdWZmWGVlL3llZ2Z2?=
 =?utf-8?B?T0NucW5QVkd1Wkg0YzFlaFBKU25OU0RTSHBqNHlpYzFxUkZGdDhpZUN2Nllq?=
 =?utf-8?B?dGMrUlVESXJGWFVTY0dzTXF4dGJxbnlVdGZMNHp6S0ROdlprWDNIbHpuZWhY?=
 =?utf-8?B?WXU4RGNkckZoQ05xeXEyQjRPRVVkcG5nT1JuTVRoQzBzT1NGME9yK29RNjg5?=
 =?utf-8?B?dWljcDcrbEJYNWlKM1ZkWjlXS3IvRFJoWGttY0xld1dFc1FWajdHaktOOTJN?=
 =?utf-8?B?MkJsUVhsOXFYVFcyMVZlcUFtZU42MDNHckswQmRSc1dtVi9aVlF4bEZySzBD?=
 =?utf-8?B?bmh3MlV2c2ZRR0R0TjZtM3NOTmROQU1wYTZCcFNKM0ZpTVVCMUhLSVJRN0tG?=
 =?utf-8?B?Ymd5eGhTbDdPK0pwM2JLNWlubjRGYjI5VlBGRTlYUlFmMndTTmRxeDNRN0N1?=
 =?utf-8?B?SGh4dnRzMFpNWm1wMHlnV0VKdHFkMWtxUXZUcFlCQ0s2NXpyb1ZjR1B6a2s2?=
 =?utf-8?B?THJqNnlxZlczemt2QU91NzZNd1dmTWdyMkQzb2cvSFplOEphaWcvbW1WM3Nl?=
 =?utf-8?B?ZmFXa0FhK1hFZlhTT2NzMlBiSUNjTHZPcUNrbGhZd0pva1VjYjFsVFM3UnBM?=
 =?utf-8?B?VnkzVzQ0S21mN1NQbCtEbHhOZjg4VGtUL1k2SHdlUjg3TlZEeHlHb0Q0bmpn?=
 =?utf-8?B?amRSdStHeURPVzNmWjhRNDZTMm4reUJMdFVFNjg4S01uR2VnYUJ4S0xYWXM2?=
 =?utf-8?B?NnZIVHFRQzBjbkJyaFBiM2dZTFBGT0hWU2c2M3ZLeWZOMHk0V29XcVI4ZUhm?=
 =?utf-8?B?K0tIU3JNdUo3TmVNMU95K0Q4YW9GUFBxMzcxc09QRUVZUStGazRYTnFnVlRB?=
 =?utf-8?B?KzhmZ3BWcStrQVlRc2lNY0dOTTZaWUNtd1FlSUh0WjBCNGlLYjZBUHlLS2RU?=
 =?utf-8?B?aFpmTWxHdytGWTM5NG5kQzNYM1l3RUN3U1E1Q2VwMTBqV3hLY0hBS2E5SUNl?=
 =?utf-8?B?THBSWVhGbUNOcWNsNlI4MlZIQ0o2bnFBSXBLUFFTZ2FjLzMrZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnFRanhtanlRVERFdnhSRm1aYVRNZ3pobUVKbEJLcGY2MncrT282M0doSXlh?=
 =?utf-8?B?ajNKZWRCdHVLUThzZmJmNmR0eW5SRDNxUThlYVFSbG03UWoySGtuSTVCNXZC?=
 =?utf-8?B?VUFwdnVMdDdiekRKR1ZDeEh3TVFKYUFoL1duU1p2N1lRWHQzOHZkL1BUanZQ?=
 =?utf-8?B?MVBMY3hpUkVOU3U5MzNkNEsxcEs1djc0N0MvbktjRjVIaHZBNWg3MEw5RW1t?=
 =?utf-8?B?anN5c0JsNzlBRUJKbk95d2NSMUM4NFZFak1hL3ovMFNFZEtXaVdoeEZNTVNP?=
 =?utf-8?B?aHB5bUVmdjlyV1BHQlNVWU1ROFB5ZmFyQytHKzFiU1U1Z1F6ZnZOYnVPM2tl?=
 =?utf-8?B?cEJaRTgvMHZZR2l0N0gxdVdxbEtubDlKaWlhSjN3Q21kbnVUQmNYaDU1cjRK?=
 =?utf-8?B?Z0cyMUhTTTVEWEI0ZGtpcGhrRmgwQXpZenByNC85UXZMdlZuWDZKVm10V21D?=
 =?utf-8?B?ZVpSdVZrTDM1Mnk1SC9aMWJycFNQeC9XajZ3dWJRU1VoemZhMTZIeVZVTHhn?=
 =?utf-8?B?SGZHWG02bm5ObVgrTXR2MVVrMisvOEVid1lBSTZMZHBuLy9LUHRmVzdoVFlo?=
 =?utf-8?B?bmt4alhUNmJiYUYxZlgyTnBqUjVjd3B1bk5scThZaTYxK0xPNVV3VUlrc0hU?=
 =?utf-8?B?MFVVODJSckFPZEJpQzJqbGlSMllLTldvblY3Y2VUS25QdFNXV2MwQ1BkQjQr?=
 =?utf-8?B?RlNzY3h4WUtiSDJYVnNYYkJ4V0NkNTQ5V25mV3dpRnUza3NpVks3TFQ1aHBJ?=
 =?utf-8?B?aWdNZ2FzMGJ2NUhySU44RU5mTThLbU1hMDEvQTlzT0FnSUxsSU1MdU9wQVk0?=
 =?utf-8?B?VUFabU1zV0cwYVRnQ1A5WU0zM0g5MkZXTGVHazYrMTVya3U1TjViNVMzK1BP?=
 =?utf-8?B?SUZ1TWlJVU9JeTVDT1BPeWtmelVrUUEybnpreFA0dVZnaHozVTBOV1drRGhi?=
 =?utf-8?B?UGF0aDZXSGl1R20zQ05DeXZqeWdRR1phU2ZyVnc0Z3h3MS9NM3dTVjFlL3JH?=
 =?utf-8?B?SFBzYW5Yc0tQWnZvbmZFNVcycjV5dzAyVnF0OEpkY1Z3UUdCREJnSlNmdE5C?=
 =?utf-8?B?SVJzckFXdlVqUFBEakl5YUdJaHFLOFFuSW55aEZHT01EMnAyVFc0MWtyYkVr?=
 =?utf-8?B?ZHBQeUlOR2dJc0lwakRDaGIwenBUcG1JaXlGTkx0eTE0ZUwyaENUSldOd2J6?=
 =?utf-8?B?TFJrRE5kVTZ5YnZYeXhQSUxVcWZxT3lRZTJSdUdtRGZOeExEeFpXbWIyYm90?=
 =?utf-8?B?RnE2Rm5yckYvUFJvUlgvVVUwYkZSSnNvVVg5OEZBU2d2R3FRSmpZQ0ZBQXlF?=
 =?utf-8?B?UU0rNGJPemlRVDFIbUpXNlFVTnVBdmhYbDFKc1RiUmJtWEliYlNPNWsxUGsw?=
 =?utf-8?B?VHRmb09LY2llVitXSVJLdGdlSWU2d3BOcm1VQWVkQjFpUlVuSkVYWWdGZzB0?=
 =?utf-8?B?M2NsbzFtbldnWVR1dW5PcU9nbnZ0cDVUZGpnOGRvSUpETUFpZkVMbzErUFdR?=
 =?utf-8?B?WnVPN0JMeDl1anpNL3pXQTRhWHorSUxoM2Q4RFY2c21kZDVpUzdPQjYzK0Q0?=
 =?utf-8?B?T282OUtNQkpsR3VadyttUDBKK3FjWnpSSjQzZ1lSM0dxS1ZDTFZFNFhPUGRR?=
 =?utf-8?B?cWRncjhjMENpNkpySnhSTFQ0NmRpQzFLN0djLzRJcThRZmU0N0RZMHlIUXky?=
 =?utf-8?B?Q0VrWE9lMEYzb2drdmJZZ1E5MWxZS1N1QmRnZitTNlhKeitvL3REZHNRYlkz?=
 =?utf-8?B?bHJHbjQ2U1ZXazIrdUUzMlVKZFNLb1pMeDBtc0M3WVlROVhySzlaUXE5bXJS?=
 =?utf-8?B?WFBPaG1IT2g4Z1dIWmlwMDFRb2EzaFNPeExoSC9UaTk2SW55UXU5N2pLN0VN?=
 =?utf-8?B?MGFUTUVnWlQya2ZuN2JFZHF1MGJLeTN6L2kzYklJZjNYd1hHcWQ2RStQdE9U?=
 =?utf-8?B?ZlhaWUJJRWxiZGpCSURLbDYwUEl0QnVSTEFDOEJoVEkrRVFVNlpTL3VQd1cr?=
 =?utf-8?B?bDFPUXdZVXVBPT0=?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dbee9c-9b09-444c-21fb-08decf5950c2
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 05:52:47.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB8980

Hi Darsey,

Firstly, I'm so sorry for the late reply, I never actually got your
email, I only just saw it on the mailing list archive.

On 29/1/26 11:58, Darsey Litzenberger wrote:
> I fed the eeprom for one of my RAM sticks into decode-dimms with your
> patches applied, and it seems to output a number of suspicious values
> (at least to me, as someone completely unfamiliar with the JEDEC specs).

>> Maximum module speed                             5600 MT/s (PC5-22400)
> 
> That should be PC5-44800, not PC5-22400.  Maybe you're forgetting to
> double the clock speed due to DDR doing two transfers per cycle?

Yeah it seems like it.

>> Size                                             40 GB
> 
> It should be 48 GiB, not 40.  dmidecode correctly shows it as "48 GB".

Ahh yeah, I must've thought the density value was going up in 4s, it wasn't.

>> ---=== Timing Parameters ===---
>> Minimum Cycle Time (tCKmin)                      0.357 ns
>> Maximum Cycle Time (tCKmax)                      1.000 ns
>> Minimum CAS Latency Time (tAA)                   16.000 ns
>> Minimum RAS to CAS Delay (tRCD)                  16.000 ns
>> Minimum Row Precharge Delay (tRP)                16.000 ns
>> Minimum Active to Precharge Delay (tRAS)         32.000 ns
>> Minimum Active to Auto-Refresh Delay (tRC)       48.000 ns
>> Minimum Recovery Delay (tRFC1)                   0.410 ns
>> Minimum Recovery Delay (tRFC2)                   0.220 ns
>> Minimum Recovery Delay (tRFCsb)                  0.190 ns
>> Minimum Four Activate Window Delay (tFAW)        11.428 ns (32 cycles)
>> Minimum Row Active to Row Active Delay (tRRD_L)  5.000 ns (8 cycles)
>> Minimum CAS to CAS Delay (tCCD_L)                5.000 ns (8 cycles)
>> Minimum Write Recovery Time (tWR)                30.000 ns
>> Minimum Write to Read Time (tWTR_S)              2.500 ns (4 cycles)
>> Minimum Write to Read Time (tWTR_L)              10.000 ns (16 cycles)
> 
> Are those sub-nanosecond timing values reasonable?  I'm not familiar
> with the JEDEC specs so I don't know if tRFC1/tRFC2/tRFCsb should be
> that much smaller than the specified tRFCmin, but the discrepancy looks
> suspicious to me.

You're correct, they aren't reasonable. Most of the other values were in
picoseconds requiring a /1000, but the tRFC values were already in
nanoseconds.

Here's a quick patch I just threw together, I'll probably also submit a v3
eventually.

Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>
---
 eeprom/decode-dimms | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/eeprom/decode-dimms b/eeprom/decode-dimms
index 6bb1b2d..506739b 100755
--- a/eeprom/decode-dimms
+++ b/eeprom/decode-dimms
@@ -2199,7 +2199,7 @@ sub decode_ddr5_sdram($)
 	my $tbits = 8 << ($bytes->[235] & 7);
 	my $pcclk = int ($ddrclk * $tbits / 8);
 	# Round down to comply with Jedec
-	$pcclk = $pcclk - ($pcclk % 100);
+	$pcclk = ($pcclk - ($pcclk % 100)) * 2;
 	$ddrclk = int ($ddrclk);
 	printl("Maximum module speed", "$ddrclk MT/s (PC5-${pcclk})");
 
@@ -2220,8 +2220,10 @@ sub decode_ddr5_sdram($)
 	if ($die_3ds1) { $die_count1 >>= 1; }
 
 	my $die_count = $die_count0 + $die_count1;
-	my $density0 = ($bytes->[4] & 0x1f) * 4;
-	my $density1 = ($bytes->[8] & 0x1f) * 4;
+
+	my @density_list = (0, 4, 8, 12, 16, 24, 32, 48, 64);
+	my $density0 = $density_list[$bytes->[4] & 0x1f];
+	my $density1 = $density_list[$bytes->[8] & 0x1f];
 
 	my $cap0 = $subchannels * ($bus_width / $sdram_width0) * $die_count0 * ($density0 / 8) * $ranks;
 	my $cap1 = $subchannels * ($bus_width / $sdram_width1) * $die_count1 * ($density1 / 8) * $ranks;
@@ -2309,9 +2311,9 @@ sub decode_ddr5_sdram($)
 	printl("Minimum Row Precharge Delay (tRP)", tns3($trp));
 	printl("Minimum Active to Precharge Delay (tRAS)", tns3($tras));
 	printl("Minimum Active to Auto-Refresh Delay (tRC)", tns3(ddr5_ns($bytes, 38)));
-	printl("Minimum Recovery Delay (tRFC1)", tns3(ddr5_ns($bytes, 42)));
-	printl("Minimum Recovery Delay (tRFC2)", tns3(ddr5_ns($bytes, 44)));
-	printl("Minimum Recovery Delay (tRFCsb)", tns3(ddr5_ns($bytes, 46)));
+	printl("Minimum Recovery Delay (tRFC1)", tns3(ddr5_ns($bytes, 42) * 1000));
+	printl("Minimum Recovery Delay (tRFC2)", tns3(ddr5_ns($bytes, 44) * 1000));
+	printl("Minimum Recovery Delay (tRFCsb)", tns3(ddr5_ns($bytes, 46) * 1000));
 	printl("Minimum Four Activate Window Delay (tFAW)", tns3(ddr5_ns($bytes, 82)) . " (" . $bytes->[84] . " cycles)");
 	printl("Minimum Row Active to Row Active Delay (tRRD_L)", tns3(ddr5_ns($bytes, 70)) . " (" . $bytes->[72] . " cycles)");
 	printl("Minimum CAS to CAS Delay (tCCD_L)", tns3(ddr5_ns($bytes, 73)) . " (" . $bytes->[75] . " cycles)");
-- 
2.53.0
