Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010008.outbound.protection.outlook.com [52.103.73.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87035DA41
	for <linux-i2c@vger.kernel.org>; Sun, 12 Jul 2026 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783826822; cv=fail; b=E9ikN/wNoOr/XLzQCxRaYpBq+t35Yx7wv7NjWxqap6Saq6tkyeESMOxAP+K2NXn8QwtkMjSKVnebcGeiILDTeGUYoVRbkKXtmmYedJWMHZljPBzLhJL8A9fWS+Koh9ylP+Bv3YoSht4i7dMHXgKCNhra2DKoWNeipFI7Euvg3HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783826822; c=relaxed/simple;
	bh=cYckYcLOZpLtv/cUC9uAEbfwdd2KddstSDSBJnjFOG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mbb3YmoIfCYN+UDn640ctpuwgebJavQBXEAK8Dq2+cVZqTYXxsVLw2nCfD9HgCveS1L+Wz+yXmff+RQNNVPSQO/6AVAFxSIhRCPskyQMtY6aeuxX58Yt5eVGPXlMzLJMM8Y3B5Lhbzyh5lGV0uiPwmwnmwz0NJBI32M83EOpZHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=ex1nPNTD; arc=fail smtp.client-ip=52.103.73.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="ex1nPNTD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhbmVD5xOiys5rta147sCylAi0RBkTxMuDaelbXFIvywEJ85F3wz9vV0vT05Ixq6H7lt222h2oV8kM9VCkN0Fjmihw6mxHHTcTHE9YvaIxqatPJn5TMOkt77Aitbyp+G2LMIji55J8ymO6gUF2Y6zW3Nt9LAEMWtgDDWddP7G5AGcTT2mRTSnW+GntkZ5dAqSRy7rEKGDRevFB00+x+dU5OYXZ6w7mCg+ci0AGhoufcfsWUembTonEDpYXNaHnYhzxbtnyAR+49n2lo7u0dxYicDS5TAvxFF+Hk0c4wsHqhrQk0Q81U63fUQ/O0U87sU4Y5DogySAAS2FZ4GfvAGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PfMd4qPZPc2qV57/QFP69qNE7ltQkLOxSYgwg23I20=;
 b=y+c2VHJR4oibi6sayGZJo2A1L6Kh95LJ6LQrj+T77cM6Jj9MQOK6E7KP8FtSPNf/IboZZgJ70BtTiCetAF1CLcLk6GDEOLMi5gQ28KDS5qR6anLnHj8yKXzxul8PUEa1M3mMAXKDzLQHE5Z2LfW6xpmlCGppWQQ9lXH9rMTJhTRyhTiRXpMvy81tSNNnWpytp3aAkkkfoFw8fE6Wj8cYxU0bdEcNKBVK0AaiTHyUfaheSVx7OJFqJLDWycd0/9R9Eey4W/RvlI902o0KQN3j+S1/ENMR+WhbGzWttPcbBoS0FDRdnqOkn5RFcFdtctqF8l0uvcniHdREaTy3BeufHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PfMd4qPZPc2qV57/QFP69qNE7ltQkLOxSYgwg23I20=;
 b=ex1nPNTDW1pbFGXVmDp0jSz+ik9GR+et409IzTcEdDec5nDRE0iiGklYoOM1N4zsOJIGeOc5uG6dOMEZSJTqdCciiqj7+FbnvICHzImPJ+knMIltbkFK5BVORtNNPSe+bBaaLMub5nhTRqdK32Ll+GWyjgyA90cdqfKnAbFgAF05ipdmHxpGqj2k6AZ7yoYiDr/SK/XeJjZhk51qqFfO3eo2ggCycyD8Xi1MkL6xD0RKNqjNWt0F/OaqNRODk/kIVelFwmmEuWKQU56kw0qkHLjkb+vqnQylz7ju1YUilP5ONi9/j4Wqzd9Gu5kD9Vl4sYMwcGDCoiMTsh8rS9PhIQ==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by ME7PR01MB11505.ausprd01.prod.outlook.com (2603:10c6:220:2a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Sun, 12 Jul
 2026 03:26:56 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 03:26:56 +0000
Message-ID:
 <SYBPR01MB45861F2728F6E60C5D2894C5C5FB2@SYBPR01MB4586.ausprd01.prod.outlook.com>
Date: Sun, 12 Jul 2026 13:26:50 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i2c-tools v3 3/8] decode-dimms: Decode timings and other
 data for DDR5
To: Brigham Campbell <me@brighamcampbell.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Jean Delvare <jdelvare@suse.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Kamil Aronowski <kamil.aronowski@3mdeb.com>
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
 <20260629-ddr5-v3-3-07f45075a51a@outlook.com.au>
 <DJU3EPM5DUEC.2QZ9MDI7NCDVT@brighamcampbell.com>
From: Stephen Horvath <s.horvath@outlook.com.au>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <DJU3EPM5DUEC.2QZ9MDI7NCDVT@brighamcampbell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::11) To SYBPR01MB4586.ausprd01.prod.outlook.com
 (2603:10c6:10:59::12)
X-Microsoft-Original-Message-ID:
 <0ffa001d-5966-41af-882d-c85d287573b5@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB4586:EE_|ME7PR01MB11505:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d63fbf-8404-44a6-e5b6-08dedfc56bde
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|24021099003|5072599009|25010399006|41001999006|8060799015|19110799012|6090799003|12121999013|23021999003|8022599003|15080799012|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFZwQTRhSDVleVNFOTQzUnhYS1JPK2ZIQVd4ckVPZG9zREdjTk5UYmpQNEFz?=
 =?utf-8?B?bTNObXhNcVYrUWV0Z0NoMmdKbGdwWjltVDVyZkV2T2RHcytKWDNKZ2c4c2FC?=
 =?utf-8?B?OGw5MFBLMkNBUmc5Q2E5RTVBaFhkSXdnVmxHcjc2REFiRmoyNDZMOHN2Ym1Y?=
 =?utf-8?B?TCtTL2tNa25MbVFYcllqWWQ2ZVJES1cvNWZzRGpycWdJaFdJZnhLdCs1WEhr?=
 =?utf-8?B?Ri9mWVJNZWNuZkNsRWF3dGxwT0dvbkRmb054L1AwVDFWUmUrc0hZZ3lTdFRs?=
 =?utf-8?B?UUdmYXJNNDZidkEwbUJPUUNhVFc3UUFNY2tNbVpmdWpadU5scjZKdG1kVTIw?=
 =?utf-8?B?UkMzTjh0SnBBOGtPWC9GSEE1VkRrL3l3S1NPejF6LzJDczkrdlFJQngxOElF?=
 =?utf-8?B?WWpPVjlXNFlSNGNSMmJoUUdKUXF1c2t6c1pPM0FKWm1xdkRPZHYvTitFZzVu?=
 =?utf-8?B?dWJlYzROdmVpZFhtZThaUzVBdHlNMW1jZ3NOS0loVjdnU2NwbE9xVEY5cGIy?=
 =?utf-8?B?cTIrUXFReWFON3k5dVNtaWlBTG04eW5NamRLcnUrS2VhTXJHcnlhSW1Ob3FV?=
 =?utf-8?B?bnZQZk5WbklEdVNaMEo1TS90Q0tXQ0JvOU9YRFdCUjBiZEhPbSt3UDdGaGRS?=
 =?utf-8?B?ZkpVT0UyREhRejkwNmRFMitHSXZQUXNMdUxWeit5UWloenpLbGRYcGFDOUZT?=
 =?utf-8?B?TkVUYk81NEpIOU5Lc3g1cS9IZ2pqUlpYYU5EWCt3SkhwcUNFOU01VGUxNDdO?=
 =?utf-8?B?MEFiQmI2ZFFxMzlQdURMcEVCSGNHUUNycC83M21iWWdIYWZaVDVXNndwSjJQ?=
 =?utf-8?B?WXdrQjV2ZHR0TURma0loMVFpaE9TekpDV2JJREM3V1pWdlVFV0tnMzZCU2tD?=
 =?utf-8?B?anovL2NvWUhtZzBFY1NxZUxMd0wxMzlIWE10akIrTHJrbVh1TVVZbFMrZ1Fu?=
 =?utf-8?B?YXM1TVovcU1HOHdXTCsyVnYvN1ZvV2U2NW5ObVhvS3lwMUNueFVnU2tJZGZO?=
 =?utf-8?B?aTV2VFdlblluQWN4K1oyTHdQK2FpaHM2QWYwazFrMFI0MVlSbW5PZmk0aHla?=
 =?utf-8?B?M0NpbWV3aWdtZzRFcmRYSGFBd3QySUh3SFFWZExTUXJZa2lYamJKamwzWXBC?=
 =?utf-8?B?dUhiN2ZoSnFDUjdTRi9seTRqVW1CWWYwRHNQWEhINXZlTDZZQk85dDltVEww?=
 =?utf-8?B?UXRaRHZrNjBOaGtQd0NnZlI5VzZEdWFpZ1g3aE85eHc4QmlwMy9wTUUyYW9L?=
 =?utf-8?B?SXZ5amNjRzNnZnZXSm1BdEZXMmJQRTk5eXMwenlKMGJFbnRqektianJNbVQ2?=
 =?utf-8?B?T1VxZVppQURhRUc0bDhha2ZSemtLU241NmsvRVJSdWVLMUNMTEpLc3l6cmc5?=
 =?utf-8?B?U2xqdzFNOE5wWkE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW5qYjVVVDZUR0psVWpKeXZSTXlCRVFlYlQrbU5TVld5WmNTZ0VNWDZKaW1R?=
 =?utf-8?B?dEx4OTlzTFVFaWQ0QjR2MjBPRnppTUxpYW1vbUxRUjFONFpXQUUxU1Z4MGxq?=
 =?utf-8?B?ZjZlUVpuWElESFFLWE13L0E5U1N1TkIvdXR0LzRFeEp5ZStuZVFWUHlnN2ZZ?=
 =?utf-8?B?MFJqeSt5ZkZEREFiallTOEo1dE9EcDczWFV6VVdYU2VKTVVNZDdyKzRJV0V6?=
 =?utf-8?B?VXpab3RPU0RCdmZpc1hNZStQUHc0MW5FYnNZZmJLbVV5WDR0SXlmalQxbXA0?=
 =?utf-8?B?Q25GbUtaS1pKNllUTVFDenk4K3ZXQzNKK0FuR25BSnVJd0RqL2tvS1d0LzFz?=
 =?utf-8?B?VUxGTGtXL082VWdNT1ROdTVXazlJY2N6TnhMRldLUVcwSmp4S2pxaTNRZUwr?=
 =?utf-8?B?UmFzMTBvTXFmNVRMaUt6c0NUQWJLMkRjM0tqNmJVWVJaZmt2dS9kdE0yaitK?=
 =?utf-8?B?VUhZd2ovcmNPR3l3eGViZCtBcnEzUkhEN0JKL0JnanYwbGFiMGpoYTBmdnRi?=
 =?utf-8?B?T09PenhnSGc1SlAzeHNOSkdzVW4zSU9EMlFFNTBDeWVTOCtFc0E5SnpDTHFt?=
 =?utf-8?B?NC9vZ2JabmVXa1JHWUtEVU9hNDNTRDVweERyRWJhVlB3N1RtV1pPTmVxVEk3?=
 =?utf-8?B?R3Rla3lNa3lqTjUxRDJZbzJLVGRwVVh4cEdraHRhbUg5UmRvSEplOFQ3ZWdp?=
 =?utf-8?B?WTBOSmlYcTJkZUpTRHFybkJLT1pFdDMxZVBMOFRYTUJWZ00zcWZ4ekdTM0pC?=
 =?utf-8?B?RjdLNDFsL1RhdGdLYWJNVk12dlF1VmQvS1RPMnQzalg0T2JVWVc5S1NQdnc0?=
 =?utf-8?B?VHM2RzJtZENKak93VUxlV3gxQUFuai9ONWZVMVBCcXVRZDdrNHJhU20xYWdT?=
 =?utf-8?B?cUxuSnkycXZlTXIvR1V3UFA4SERxZ2crZjhuK3Zpa2NMV2taVUdTRkNzaTRL?=
 =?utf-8?B?U2k4bmVaaXVJTzFsRjZrcTdKYXBjU0tmeU5ZdXl1clBlZHZ3UXMwZzZZMDY2?=
 =?utf-8?B?Y25SU0xsY2w2akpIUjREaHVRdmVQemlVTkcrM3h4a2k4VDRYYUlUWXBqaFlW?=
 =?utf-8?B?RzRoZkw0c29FcVZQQ2lBcGNGSjR0cVkrS1dqRFNxQVNYVmlGSlhqV3RKY1U0?=
 =?utf-8?B?NFU2QkI1YjBCSUdxdjFXbHpBUUJEek1SeHBTWWUrQUpRK0wybnUwSlZmNElT?=
 =?utf-8?B?WTMvS1ZlL0xIT2VvNmQxUUE3L3dlWDBOV2ZKUlRvc2ttNlBQRnRuTFllSjBO?=
 =?utf-8?B?dGpVT1BNbHVDTWltd25NYTNnRm5jS3hnSnd2V3VRZlV3MkVrMExBU2x6QUpN?=
 =?utf-8?B?MklPeUQ4eHRSbFY0ejZ6d1NtdE9wOUJTUWhaakVPaXptSk9yN2EvQ2N3VnI2?=
 =?utf-8?B?SWNVbUhvWTIzbUYvS3ZIWVBaQkZWeHl1U2RucWFYb0p4dEZXRzFUK1NsMitr?=
 =?utf-8?B?NEhrR0RWUlZZcWZJM2srRkFwZlo3RVdySTZ3dTJJSm1JZUZCdzZ2NVc0UHBN?=
 =?utf-8?B?ZFlORENrMWU2VmdOOEMyV0lhUnE5b2dDMjh6dktmVU5DWlJ6MXJ5ZElNMkxl?=
 =?utf-8?B?MER1QmlFMjdxREZQV0FscEx2L1JnZFArOXVESjRMVGxZSHlGeEs0N005YUFr?=
 =?utf-8?B?TmVIdWZOR3FRNTl3NytOK3gwTTRyNnA1R25qaCtZR3ZObGJ2dGpyV0FwWjZh?=
 =?utf-8?B?VDFoanAzMjdERlpZYkEyNTR3RDlKYjBzSWpjOFlrYUUzTFV6NzkzQjMvb3Np?=
 =?utf-8?B?NkYvWFRqdk53Sk96aVFXanNEcnQzVXhlK2Y2THhZOVN5alBHTDBHNnVHQzV3?=
 =?utf-8?B?WDkxcUdUVGQyMUFOZ1lFNkFpK1pJVEc1eGdDMWczNjlHT0x4MHZkZlNaa3Iw?=
 =?utf-8?B?eUozQUhlUUxxaWJNaGdXTUR2cHJHbzhsZ0ExdEZEV3BiaTFIVTB3TkdQeURR?=
 =?utf-8?B?dXVnb1ZrZUNXaXRCZGFNKzFPMFdTM0hxTWtZM2ZUQmQyWmp4aTFJZXJ2OG9R?=
 =?utf-8?B?bVlrMjhLMXZRPT0=?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d63fbf-8404-44a6-e5b6-08dedfc56bde
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 03:26:56.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME7PR01MB11505

Hi Brigham!

On 9/7/26 23:59, Brigham Campbell wrote:
> On Mon Jun 29, 2026 at 1:10 AM MDT, Stephen Horvath wrote:
>> Decode size, timings, and other data for DDR5 based on the JEDEC
>> JESD400-5B specification.
>>
>> @@ -2128,6 +2128,280 @@ sub decode_ddr4_sdram($)
>>  	}
>>  }
>>  
>> +# DDR5 Rounding Algorithms
>> +sub ddr5_min_round($$)
>> +{
>> +	my ($tck, $ps) = @_;
>> +	my $correction = 3;  # 0.30% per the rounding algorithm
>> +	return int(($ps * (1000 - $correction) / $tck + 1000) / 1000);
> 
> This subroutine seems to assume that $ps and $tck are passed in as whole
> numbers. In the datasheet, these quantities are wrapped in a trucation
> operation before they're used in the calculation.
> 
> Maybe it's worth wrapping $tck and $ps in int()? However, this is not a
> problem if the caller always makes sure the values are truncated.
> 
> See "Rounding Algorithms" below section 8.1.20.

Yeah that's fair enough. I think I didn't because the $tck values were
being converted to nanoseconds, making them potentially <1 and hard to
truncate, and then forgot about fixing it. I'll plan on not
unnecessarily converting values a bit more next revision though.

>> +}
>> +
>> +sub ddr5_round_twr($$)
>> +{
>> +	my ($tck, $twr) = @_;
>> +	my $correction = 3;  # 0.30% per the rounding algorithm
>> +	my $new_twr = $twr * (1000 - $correction);
>> +	$tck = ($new_twr / $tck) + 1000;
>> +
>> +	return $twr / int($tck / 1000);
> 
> Is the body of this function equivalent to the following?
> 
> 	return $twr / ddr5_min_round($tck, $twr);
> 
> No need to duplicate logic in ddr5_min_round, unless there's some reason
> that's not obvious.

Makes sense.

>> +# Return combined time in ns
>> +sub ddr5_ns($$)
>> +{
>> +	my ($bytes, $index) = @_;
>> +
>> +	return (($bytes->[$index + 1] << 8) | $bytes->[$index]) / 1000;
>> +}
>> +
>> +# speed
>> +	prints("Memory Characteristics");
>> +
>> +	$ctime = ddr5_ns($bytes, 20);
>> +	$ctime = ddr5_round_twr($ctime, $twr);
>> +	$ctime_max = ddr5_ns($bytes, 22);
>> +	$ctime_max = ddr5_round_twr($ctime_max, $twr);
> 
> The datasheet indicates that these quantities are in
> picoseconds, not nanoseconds.

So the `ddr5_ns` function reads a value in picoseconds and converts it
to nanoseconds. Perhaps I can document this a bit better next revision.

>> +	printl("Minimum Normal Recovery Delay (tRFC1)", tns3(ddr5_ns($bytes, 42) * 1000));
>> +	printl("Minimum Fine Recovery Delay (tRFC2)", tns3(ddr5_ns($bytes, 44) * 1000));
>> +	printl("Minimum Same Bank Recovery Delay (tRFCsb)", tns3(ddr5_ns($bytes, 46) * 1000));

E.g. the `* 1000` here is because the values were already nanoseconds,
though, I'm going to change this next revision.

> Datasheet reports that bytes 42-54 actually are nanoseconds, so this
> usage is correct. When fixing the other measurements, be careful to not
> switch these from nanoseconds to picoseconds too!

> Is this "Optional?" comment referring to the following code? Sections
> 8.1.48-50 don't appear to indicate that the following information is
> optional... Maybe you already mentioned this somewhere, but did some
> behavior during testing give the impression that these values aren't
> present on all DIMMs?
> 
>> +	printl_cond($bytes->[96], "Minimum Read to Read Delay Delay for Different Bank in Group (tCCD_M)",
>> +		    tns3(ddr5_ns($bytes, 94)) . " / " . $bytes->[96] . " cycles");
>> +	printl_cond($bytes->[99], "Minimum Write to Write Delay for Different Bank in Group (tCCD_M_WR)",
>> +		    tns3(ddr5_ns($bytes, 97)) . " / " . $bytes->[99] . " cycles");
>> +	printl_cond($bytes->[102], "Minimum Write to Read Delay for Different Bank in Group (tCCD_M_WTR)",
>> +		    tns3(ddr5_ns($bytes, 100)) . " / " . $bytes->[102] . " cycles");
>> +

Yes, it's for the following code, I'll add a new line to make that
clearer. Both my desktop (KF560C36-32) and laptop (CT16G56C46S5.M8G1)
DIMMs set these values to 0, which should be 'Reserved' according the
the spec.

> This patch is looking pretty good! Impressive work.

Thank you, and thanks for the review!
Steve.
