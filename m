Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010016.outbound.protection.outlook.com [52.103.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E541F7DA
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599773; cv=fail; b=cWxdWd36+R7jQweT5zjsCSRSGEEBRS9W2335dHd25twZv3XgJSNa5P6okYAZr7LhjdkDrNUNt7ekIY1UKuSXfEheWaMya47hmV3T8uqg4y9VM3vadqIeB9yAYO0JMtt4h7O5sR5/ArYNQi+6eA+ynkKL/2IbAfr6zInpBOuJdoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599773; c=relaxed/simple;
	bh=F57R7zMvdmSBc48kSj0Uk0qmZIxPpQEij3x8xQk2AVU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FMBlh1XwEFtdTDBPPb4PsuvfOv5LN72WCbHYZDIWGcnWiZIGYt0pSnPNOy6Ao6PyIt+knnBWQdTGnGVBFwgy6T7bQ5sSD0qxJr2Ekpn4AF8ogn6GMh8flq1bFPGI8ajbR+I+crQ864qe7wUEH8Qi7Yo9t5F2oVGZgWfRnat3wa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=oKVz570G; arc=fail smtp.client-ip=52.103.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="oKVz570G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWMrmsPNSNNmoFEtKf3P0yemwH0Lbcb3xROPu02JKAUM6O9udcbwbSRV7t7RMF/Buu+a0j1MkgIsfBfdwYHKZxRe/Xr8K+O3shYOq3X5Vjffcbqc5fMdsJR2X0K194uu4LI5QOTTvj0UpF0HSL6ToywHvYRDkEUU44/KvlATvJJNILosHCfqwQdE59ZWU+OgniEdEB8eCPEjoGDN5EycRxtBPS8/LwB7BMswXkrX7C8yzk3FEr75meP5Sqc74moolbOYKiIrEohxIjAf/MEgKcIeXf5QIAcXZx7AprW+XEw7E633eAw8sVFpcCGjIAKPwLGvqX0M1ArqDaRaBFLAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jB5aDLra/fcDwhGEjux91nsW66y0vqodp83uNiMJasM=;
 b=O2dnM/IgiPuPRo4goGNklcRnSqo0NfKp8w3ZawYQNQtD/uDkN4yjEAL6/jyfEEmrlz7oQm+zpOTHpt5sfYyFf0Ralcl2laGjRWSA2apKDyULI9A6duuzuyAOHLgkOCUweVQ/ph791/+chfQPBJiXVoYcUHSxlBHUOb0DbNXgTHUX+QFxIZzx/El69Tdvn3Pay0xx7vfL6B6piriBRFuILbk+nzKlFwTIurYGNV1iJ48OWav1WeEsN749yMZTSeIZR+VvhfspLCb8tFf1Nqw6hsfkQU1aXDQnp6cIv2fGQnrZVoeMVSVkfYhrBTl0gczYmxF1Civ93IPgLSIv56Qxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jB5aDLra/fcDwhGEjux91nsW66y0vqodp83uNiMJasM=;
 b=oKVz570GK+Z5Nb6HGtkSuyvaxYSHAbDQsJVvRkmCqcvmU9XPnZlsAH2/2Sx83mqcBODwfL3cOVQQI4dtYMjXmc8B6c2RJaGm51SYBGIg1QbyPnW2ZfUzwYo6qHBxhq+UF+xJhy1/ssmCFtYkzN2hIooZ0psAavH4brZspZxkzosC1NQj2BhKVknuUYb8HJEk1v9OAUAflsoy3WxXE9aDlhCNndvr1OCtJQUQ/H+4vd8bYNKyLgz92UjIHEOLOp1y4cZhU6cGOQs8EVfmoweFf5n/7JqV+mPPN4OcxJo2R9z2YZ+RFu84BCRrS4Tm9T2xVdIPQ1Zfu3O/5OfOGnEnKQ==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by SYBPR01MB6697.ausprd01.prod.outlook.com (2603:10c6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 12:22:12 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:22:11 +0000
Message-ID:
 <SYBPR01MB458670FEEBC39B44372482E3C5FE2@SYBPR01MB4586.ausprd01.prod.outlook.com>
Date: Thu, 9 Jul 2026 22:21:33 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i2c-tools v3 1/8] decode-dimms: Implement DDR5 checksum
 parsing
To: Brigham Campbell <me@brighamcampbell.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Jean Delvare <jdelvare@suse.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Kamil Aronowski <kamil.aronowski@3mdeb.com>
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
 <20260629-ddr5-v3-1-07f45075a51a@outlook.com.au>
 <DJSY0M2NCF0S.Y3YUOZXTH3FI@brighamcampbell.com>
From: Stephen Horvath <s.horvath@outlook.com.au>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <DJSY0M2NCF0S.Y3YUOZXTH3FI@brighamcampbell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0109.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::17) To SYBPR01MB4586.ausprd01.prod.outlook.com
 (2603:10c6:10:59::12)
X-Microsoft-Original-Message-ID:
 <d65be736-6b5b-4409-9759-ce8ad172e9f1@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB4586:EE_|SYBPR01MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c80591-ccc9-42b7-d5c8-08deddb4b3b9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|15080799012|23021999003|37011999003|5072599009|19110799012|6090799003|41001999006|51005399006|8060799015|25010399006|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3V2Z2wxU3JXUllaN2ZjekJyZ2R2aTloY29ZTytma3NMNld2ZjNMcE9hRGt3?=
 =?utf-8?B?TncrVWhOcUduNm82cUxObndoUmEzcHlRZ1J6UWVlV0lROGRqamVPUE9oQXN1?=
 =?utf-8?B?R1p5WTNSdGdxcHh3aTcxWHZKY0gzd3k4TFYwMEpzUWM2VzhVSWZlR08wdFdn?=
 =?utf-8?B?QVgrNUVhNWhLWGU2TlE4Q1FLaWhCcXJDcE83bkYzZThLOE1POUwvQTBNYWJT?=
 =?utf-8?B?RGt1dVhBTG9TVStGZmlLenU2TmZ2Z2VBSGtRaGxMTEl0UTByMW42UWlaZE5s?=
 =?utf-8?B?UTRPYzNEZzQvcTNuQmpRTENWcGpwNFlENUxHelpuTnNhNGRWZEVrZnR4ZXBG?=
 =?utf-8?B?RzgwUTZhYS9FNW8vaEFCWkZWWkw0T3laaktwcENrVjMvV2VNcG9kcGtRTTdr?=
 =?utf-8?B?Rk01YmJpYktjMVVRYWZ5T2ovTlJFRnFhMU1hbjJKdEhxT3NkRXpWZ2tZVGFD?=
 =?utf-8?B?eExLOHVOTU1FTXZBalhvUWJjYUlrMDlFS0dJMzFCUC9kWWJjSFMrWGl6WDJI?=
 =?utf-8?B?VWorbkFaSU50TmJJUjhtMEx5QjBUNTRYanlxNU5ielVrWEU5TlBYN0UyVERz?=
 =?utf-8?B?NnNRc0hJY21iRmNHMnEvakNkUGllWEcvOUp6aCt0ejBYU1E4UDlpNTYrYXRS?=
 =?utf-8?B?RDQ2MXZOQ3UyYTJXUGN5bjJwUHYxazZiUkN4N3piaTRwNENUb0FOenpwQzhy?=
 =?utf-8?B?RjdGMm1URmdETC83ZDhpQzZjN0Y4MGx6Y2UvLy93UjUzdEV0Yng2bjFxbHZx?=
 =?utf-8?B?ZnVSdHVwaHVmVVZMRmFidmtJUmxKVkRuQVllSjF2SWZsNUx4NnRlZDFLaUZn?=
 =?utf-8?B?R2JQUXpldG5DSDQ2dE04UDBxT1VsaTRZcGxQbFBYM0tVZGxpem4reCs3M3pt?=
 =?utf-8?B?VEdxbXcyRTF2U3czSGxrbzhNVnlOWk52Qm9VcXlyWjluMTF6bUtEMG5NSjB4?=
 =?utf-8?B?Z29Da2dnSmZ4RDFyWGI4MXdBSm1Xb2gwSFJES2xDblJxNE1KN0hhMHkyYi9j?=
 =?utf-8?B?c0JhUENTWndiK2NhaXMrWmN2bFY3Z0tRS3N1NStZYndPVjdYWjZOUXBDUk1j?=
 =?utf-8?B?TXNlOWpwT1UxZVdSWkNvSDltSjl3Skt3VDFxOHZQcWJtRmErV0xHQTZWZWZH?=
 =?utf-8?B?WTN0MEt2NzdCbHZqQUF1UnVQY1ZDZnAxRW9hdW1teDJHcmJDTzJSYkk0dmp0?=
 =?utf-8?B?ZlR1ZENFL2s0cFB0Wi9OQ2k0YUV4Tk5WUnBCK3dURUR1NFNobExzazY0d0to?=
 =?utf-8?B?Z05WdHduaGpmSStFWDJSdDlMYU1GVDhZcXVrSXNuNGxMcm5vb1dKRmxVVll4?=
 =?utf-8?B?N2htWTJOM3ZHN2wrVjUyOEROam1CT2VQNC94blZHWjhsN3pXOThtbGZYREw0?=
 =?utf-8?B?QWFyWFcyeE9oVnc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0NCb1ozZUZlZHlkNFpNUnVwRzQ0dCtieEVyenJXT2l5TWZKd0JXdWpSQzA0?=
 =?utf-8?B?MUpGMVFuWWNIZ0dZNXNIOGxwWlk3VVhJS1JucGNLd3FBMENEV29iMytoRm1i?=
 =?utf-8?B?MkFhUG1MTjl6KzhCZUtUdkx4M2wwUkRuQkdPWm4rNmVuVUo4OEVybThzdXc2?=
 =?utf-8?B?OXBQbnBIcnZmdjlnMWx0U0p4c3FRV2FSLzU1aU9zQ1haRjJRUHhBTFlMSXpn?=
 =?utf-8?B?L2M0Z0hXL2xyUk9nSzFBbERaWEVzRUJMT3MvOFhMaFpKTnpSSlB3R0YvSGlD?=
 =?utf-8?B?bkNuN09zbXU1emdFZWd3U2ppNXRhbVhqdW5ETm5NMVNITUFYUG0yMnprbElH?=
 =?utf-8?B?clFxNmlVSG44MDFYdzE5V3Z4OVUwRTZtaHdnbUR3RUlpdkpoSnpkOWlTSjd4?=
 =?utf-8?B?WTZZSVpFOXVZb2JGQlFFQW16aFdJODZNaTNnRTJWT2k2b29YWU8vVjArMWM5?=
 =?utf-8?B?KzVwZzRya1RwaXNuTWJHZnBnZmpjQTFLOVZFazd1ekNrQkJMa09FOTQrTWxx?=
 =?utf-8?B?RUl4NXNTZmhpVTRFQ3E5NnhOUk1DUmJUZ1hSK0x6MzJIVEwyU3lFRVVLZ1gv?=
 =?utf-8?B?ejYrZ1FIS1huM0tNbWQ4dkExajhkN1ZqZ3JPYmFwQURSM2U4RzcxOTJFc3Vy?=
 =?utf-8?B?V2wvK1hSS0RzMWNNbElad1ZQajV5VEEvL2JkSjhlV1RpVG1HSGprb0QyMStY?=
 =?utf-8?B?UVRNTVdTV29MRWFmZFY0T3cvMGFORlJlQUZJV3d2Ulp0Rk1ESDdLRlBpNUZY?=
 =?utf-8?B?R2dKajVQS0NkTHg1OEsrQktLMmJNa3Nqb1lVbnlyRVpOVHFSc05EZDJsY1FB?=
 =?utf-8?B?WER5aHNkamJ2d0kvOXo0anljY0pvdnJxWHEzVFRTRUFTV1VWdGtHUmxqdlFB?=
 =?utf-8?B?N094eVlsRi9Ma1MxRzd5bk1SQWVrdnd2amIxTkdyM1dFZmUyQ0w0VHFjblQx?=
 =?utf-8?B?SVVhRFB4UWZGNGNhNjA5b1VCZGszY1BzSFhDaHJaL1kzUlVlUXFFMkhQdUov?=
 =?utf-8?B?ZWRhSUM0Zmd1ZlorODRuWlhDREdYM2ZXVDZTbTlXVXRUY0VoSTlySzJ0bE1B?=
 =?utf-8?B?OU1Pb2pxRGlOQkR1c2YxVEQ1MVExd2FDeTV1VHRleG5QVkhnaCtlTjN5M09o?=
 =?utf-8?B?eUpLTWhIV3JJcDZ5NVhIV3RyeU1aa1BZaVhNaytEUXdVeE9lVHh3b215MEt4?=
 =?utf-8?B?bW1OMHdrbm9QbFlsdldoR3kzK1licmFEVnpiQVcyM0RSQi9BN0FGNldTejBB?=
 =?utf-8?B?ZGZJZXRLQ0xCcTNOa2czSnlYWFB5RGZUenZOdWVzNkR4SHpDTk9wTlMvcEZx?=
 =?utf-8?B?Qk1hY1F0N00vcHdWYnk3R2JhMTFIeGZPQ1JTMURoeGg3RzNBVC9MM2RKSFpJ?=
 =?utf-8?B?WERGcjA0RVFod0FkSGkyYzkxK2ROQlZvM1d0TS9xK0Jnakx3YnpOMDgrai9l?=
 =?utf-8?B?Y2I5WjU5Zk1Td0tyWkNrNVN1MFk4eWl0ZWYrR0JJeHpmdXJsRFp1dis2YWll?=
 =?utf-8?B?WTE4VVJLTlE2N0wzUUIycGIzUFBCY1R2Y1lEWVV0WmV5eG0rTk52dVRUc0JF?=
 =?utf-8?B?TngyWUc3dzdCN2ZqRlRrZENVb3JoS2IvSTNmZHJjZjYyQ3lWRDZ3Q1NaYjk2?=
 =?utf-8?B?eUJaQjJCaktxUmV2Yng0SkhsZ093ejVDYml5bUJraWRRb2lOZHlDdnZNcDVZ?=
 =?utf-8?B?M3g5RDcrRUtPaXJRTHZ2d3U0cm9FVFVKeThRVmFyS1ZrdnNsYlFheHBwSjZU?=
 =?utf-8?B?a1pScWdWNjh0c0FjUnJKeEFicWk2SWNGeVlhSDg3cTJMNUJoclRjdGw4N2ht?=
 =?utf-8?B?b2U0eUU5TjNmVjRSSVZGNmV5b3g1NTkzMG1INTBhcEZCR0pUd0VBcHpYSFoz?=
 =?utf-8?B?ejErdjFwMFI0bXlQSk1MaU5qc1R1Unp0MjZkckRveDk3RUVNLzB6SFdIOE04?=
 =?utf-8?Q?3fFUGHbRipVyxlPmhyg0HzNeocGlugzH?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c80591-ccc9-42b7-d5c8-08deddb4b3b9
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:22:11.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6697

Hi Brigham!

On 8/7/26 15:33, Brigham Campbell wrote:
> Please treat my feedback with healthy skepticism. Keep the above in mind
> when reviewing any feedback I have on other patches in this series.

Of course, and thanks heaps for your review!

> On Mon Jun 29, 2026 at 1:10 AM MDT, Stephen Horvath wrote:
>> @@ -2402,7 +2403,12 @@ sub spd_sizes($)
>>  	my $bytes = shift;
>>  	my $type = $bytes->[2];
>>  
>> -	if ($type == 12 || $type == 14 || $type == 16 || $type == 17) {
>> +	if ($type == 18 || $type == 19 || $type == 20 || $type == 21) {
>> +		# DDR5
>> +		my $spd_len = 256 * ((($bytes->[0] >> 4) & 7) + 1);
> 
> Shouldn't this actually be as follows (exponent and no +1):
> 		my $spd_len = 2 ** (7 + (($bytes->[0] >> 4) & 7));

Oh yeah, definitely. I must've just trusted the DDR4 code, but I've got
no idea why I thought adding 1 was a solution.

> Reading the datasheet, it looks like your algorithm only happens to work
> for the particular value which we expect SPD5118 devices to have
> (0b011). This makes me suspect that the algorithm for DDR4 may also be
> wrong, but I don't have the datasheet pulled up...
Out of curiosity, I just checked the DDR4 datasheet (SPD4.1.2.L-6):
> Bit [6, 5, 4] :
>	000 = Undefined
>	001 = 256
>	010 = 512
>	All others reserved

So both methods would work fine for DDR4, and `256 * bytes` probably
made more sense considering bytes used is `128 * bytes`. Though EEPROMs
generally come in powers of 2, so `2 ** bytes` is probably more correct.

>> +		my $used = $spd_len;
>> +		return ($spd_len, $used);
>> +	} elsif ($type == 12 || $type == 14 || $type == 16 || $type == 17) {
>>  		# DDR4
>>  		my $spd_len = 256 * (($bytes->[0] >> 4) & 7);
>>  		my $used = 128 * ($bytes->[0] & 15);
>> @@ -2684,6 +2698,12 @@ for my $i (0 .. $#dimm) {
>>  		 $dimm[$i]->{chk_spd}, $dimm[$i]->{chk_calc}) =
>>  			checksum(\@bytes);
>>  	} else {
>> +
> 
> No need for this empty line.

Oops, fair enough.

Again, thank you for your review!
Steve.

