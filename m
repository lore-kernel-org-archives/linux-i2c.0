Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011057.outbound.protection.outlook.com [52.103.72.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46BA212548
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740447; cv=fail; b=J7G+7gQqW2SQZfNHlvQyKjDXnYDv9I4UxNuH+jRGzzWcaXKmbnQtVC1NrUrU10lLLY9FvJ3TEwLTf2rp6blErHci/4u8uYihzVYSDrWGHfORDxvZiE5SlhOg9zXXbJBEVBTw+9zegIZO5LbNFjp1gtn1UPj3Y1yTV5g3XTqBBDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740447; c=relaxed/simple;
	bh=yEPZY8QRNTxu75h0Ln76qHZcDL0oXuIVdQul2ThlyxU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=agLD+MWOGwY6OVE6uMSH7sdASHHyHG2Hohlz0Ad/UpcMZ5s+WhmcQ48CKA2KifqibCQAwIZ6ZvB587evLhLS4Gu42g6mI9b9UWsxHWGbZPBYJqBBhDrTuHt3Ewvjg4o1avzRdwPBCmQBPZNyJb5Js3Tci3ePuR8bVKYJq720LrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=KQyOZJ5G; arc=fail smtp.client-ip=52.103.72.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="KQyOZJ5G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAOh1TCjHSBsYLDlBosgQy3u9E6juz8P2/Bz6k7/PBVgsK5nQJUaQqH5nqZPyoFMXPXV/XZYMCP0rugQZzCnbRn39ircHLHWROIZKgK2aneDYjrLWj5ws1zCimJaxaJ2OmPhlYYLJ+annpMoTuuzJi0wOpzS161750XCoy2FMU7rdlJ/Dk8eTGwb8xEUTl//uvxaSk6j/mPRFVwAnDquHoS1ItFKBVEMWjqfwUEh3fGHeH0/i+8ND79hmB49K3BjlWX/VBPoRO+gesFk/zY6hQ6yq0v/Yur/ubDQJByA4MeXZh7Ip/9rA6MIk2NOiWx3zFhb6XKk3Sk9eTBxu7PaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zw3sBwS6o30L/EHTzau5PmzisqXP9hRzu+gykgyUNCM=;
 b=IiYkndXt6v7bXub7o+RanNehRoFVVolHvWRP8IYL0YShjaA14s2v7oz3huRVDN+913jq1Bsuy7eYYbdYV/7CbjDq9Ari5kPMH1GbTBg+DHFxfJy1/vpyCTHwoGNh8c7i1RR20tWOS4ylbmEQ9IokCF3funx6+X6UyTwjVqA9LSk5835HncaKHb39f76QQVzDZBgCHf0f7JzSgdV5DjHp8g7WNY10T99rrfmafY4UCSs7ut6tTZYZVD4FXKWsVhK5ls2iHdzzAE/poZLuHDn8Yg1AgtJAR/VjvBldmTXlT9XYDh62huwCibShFad3sTdACDYd9q9WIRwf6cQ5HsGBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw3sBwS6o30L/EHTzau5PmzisqXP9hRzu+gykgyUNCM=;
 b=KQyOZJ5GB5emjwO9XahTtWqQQzWGqAiJkND0v3pWbpC/zuKhYr/cowO8Ud039cRMGDeAqoJJsOSC/2zVnuqep0ZOTyawSdYpYvM94DYvEQ+Py/on+RYckd6iBWMhqUJyrP5q23oiGJHjovhUApfGj/jb2+gIzKMcEIfU9XcmkSVLa/jizgT4aFDb4P/dq17On8eLLq9FIl0P5RNGrgtqVsJ2qDNC4RLYXkjtPddb+Cp7ADa3KSQ1ROWo7TUwSyscGHwAaUPbA/YHEkkNp3LCkLj+1aI9Oa82aBO3ElEd5ZZqAGCMZo/+IzQjs5UsK4NtUwe/bUuYRqOBcrqnWwXkXA==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by SY9PR01MB10784.ausprd01.prod.outlook.com (2603:10c6:10:320::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 13:40:42 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:40:42 +0000
Message-ID:
 <SYBPR01MB4586DF956D4DC963254267B3C5E82@SYBPR01MB4586.ausprd01.prod.outlook.com>
Date: Mon, 29 Jun 2026 23:40:36 +1000
User-Agent: Mozilla Thunderbird
From: Stephen Horvath <s.horvath@outlook.com.au>
Subject: Re: [PATCH i2c-tools v3 0/8] decode-dimms: Implement DDR5 decoding
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jean Delvare <jdelvare@suse.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Kamil Aronowski <kamil.aronowski@3mdeb.com>
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
 <akI1ZOP_wccyC2bO@ninjato>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <akI1ZOP_wccyC2bO@ninjato>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY4P282CA0011.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::21) To SYBPR01MB4586.ausprd01.prod.outlook.com
 (2603:10c6:10:59::12)
X-Microsoft-Original-Message-ID:
 <7b7b7b80-13dc-4b7b-b393-dd9a0034997e@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB4586:EE_|SY9PR01MB10784:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c13f32-1449-44be-8768-08ded5e400ba
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799015|8022599003|41001999006|15080799012|19110799012|23021999003|24021099003|37011999003|5072599009|25010399006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFhLME1HNkZGTTV2WnBRbDNob3BkNHBGbjIveitBczEzVFRaNTZScU5yaTk3?=
 =?utf-8?B?Z25zK2JIN3VSVFE2M2E4WWJjVm9uUFpHK2tqYW1nSzVnVjdjdkFQOXViR3Yx?=
 =?utf-8?B?WjYxWUJrUWJPQ1VPWVM4cGFNUnQwUGlVVWR4TDlxMlJmZ3NVU1FmN1UrREJv?=
 =?utf-8?B?TFVOSzg5ZUE5dnJKQXM5MS8rd3JndmZ3d0VJMnQxdW5Fa0dMVEdqSisvYnJU?=
 =?utf-8?B?MVdsRjhxTkRUZjNZenhDKzRVcE9ENG92UFpXZTFjN0txZlpxcTNudHlXL1hY?=
 =?utf-8?B?VWNURStodXNUMXhhZU9NSFlkTkJCNVRiN3E1akVEakcxQTltRlNMUVhYcS9G?=
 =?utf-8?B?bzVLN0liZVVsK2tnYnkyUnVrRHdTaGZOaXlWdy9jOUo5RlV2ZHZZcERxcThy?=
 =?utf-8?B?dUdhcnN5OHZFRTZPdDFkaGlqYUd5ZnpMdUlLU1VvNGxWeDFFclNVMUZmcHBn?=
 =?utf-8?B?VHBFYkpzemV3a1M1Ry9ra0FvckNjZHBLKzFSdGJEVDIyR1FEWENxWll3aUUx?=
 =?utf-8?B?RXV4VjQ3MmVUMnRKN1VFK3ZFb04vK2hDdWVoUGVQUGVqOWx6bHo5amwzeitT?=
 =?utf-8?B?T2N3NjVEVS91T1pzSDNlZmJnMHJSNEtPWkpBeU1qVi9xYlFuTG16T2NHK3lV?=
 =?utf-8?B?MTdpc09kTmFMZldrYVl3VGowUlFsMExhVXFsTzlUN1FGRmQyY2tMd1hCK1E3?=
 =?utf-8?B?Tk1pbE9ZZVd1RUtIcWR6b0JXdnZTMjJidmwvaDliK1o3N1llOHpQNzJ4MnpL?=
 =?utf-8?B?OU9vRmVHZUE0OFJCcFFTNHVBcUNZRERsTUtzQnhCTzMxYTdJVjY0NFJjTWox?=
 =?utf-8?B?SGN1QU14NXg2MDNXNURYR2d0dzRLSHBwckJCWGlJSXhoU2pHT056TC91TVdW?=
 =?utf-8?B?ODRBSUpRdFBzSlNlY3B0L0dVelFOVFc4K0hrdFNMMmVUT3hsNGZ1N2hTRERa?=
 =?utf-8?B?WWtSeDRDWURyTTJPcTVoSWlNODdDRjRCcEw0Z0pYQjd5L25rQ3h3b3VZbnB2?=
 =?utf-8?B?MVNXcTBOSzRGeURuVm42dDFCSEdkakkrZjc1MjZ4emtSVmk5c1BpTUc4d0Zj?=
 =?utf-8?B?NDVzZW5QZ1VJWFNpQ09vR25vWjEwcmYyVWEyWTB3R0doU0FadVYzWUtLbVYx?=
 =?utf-8?B?Ym0vSmpEbVRGU1l4eDM3dGxCWStvRDhDWnc1eW1FckRaY0hHZFhrN0ZQNEFF?=
 =?utf-8?B?UGxlTDd1ZGNYRzVZcnBYV2dtQjJidmRRUXhZenhhcUZVTk1icm5zMDhpSGFN?=
 =?utf-8?B?QUtlWCtzbXA5Kys0bUo1YnBreXIyTFpQb3JXUDJ4Z285cjNYdW5rYm50NG4r?=
 =?utf-8?Q?hK2sak7WGXeaBRx3eeNye9C0+5BXRS6qgi?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akhrMzVzQmNZbEJQYlNXN2NRK25BR1o0TFd2TWZTUTYwQWVyTkZ6SUNtNXVR?=
 =?utf-8?B?WmR5WkM0WEdsS3RhL3cxMmhGOFB4VnM3d0dUR2lzQWpBLzhVWXpyNXdOUjVU?=
 =?utf-8?B?eXN5OUtRaEJNY3N5Tkh1bGsvejgwbHg1Z1lsWm9POWtYSk01UkpBNEpNQXNa?=
 =?utf-8?B?V3ZQeFUxSTFNMzRGd0wxZ0w2MDBtRExTcmhYandRSXp3dUhXb2lPMUVwR005?=
 =?utf-8?B?SzBncUFKbDBFVTlFZitZaGc5cjdlUlVFcE5FaW1xNTJpNFc1MWtzVWMrNVJh?=
 =?utf-8?B?cWswV1pOZmlBVnFQR3NEYkN5RmZQRkVjZmtUbE1GS1NGcHhVQnJHdHRDTi9p?=
 =?utf-8?B?VSs4dUk3YXpXR2UzU2xpcXY3OGRLKzR6SFE3ZkF1YzI3STlNV0J6bnNBOUNI?=
 =?utf-8?B?TWZsWmJtOC9MUzlrYXN6amtuY1FQVEZwMkwzNmJKU282MEUzbFI0Ry9LbVl2?=
 =?utf-8?B?U0dzVVN4OVhPeTlOREd1cTlUd1YvUjBtT1hNV2t2Tm9ZakhFaWdINVR6OUxn?=
 =?utf-8?B?R0o4dEVWOHFtTTY5cVVNZWRPM0MzMkI3RU8zc09TMm11empWWVZRSkVOaWNI?=
 =?utf-8?B?bXVvMXlXNWcranoxSHpHSDlPSHp5V256OEVmRm1OMVVWS3pxZXRPVGFlbkhj?=
 =?utf-8?B?WG1IcUNKcndYM0loelZ5enRXNlNkMW0wdUFHc3NxRFBtTUZzNEJUYXFOQzdQ?=
 =?utf-8?B?QVN6RU51SlpXWFRucHEybDdCaUFxdW10NmQ4Ti9RbXM3NEI1aldCUkpUSWx5?=
 =?utf-8?B?Uk5hTm8rUGszd1dtMFRRQVNvSkpGNGordU5KZ01HNHVrWEYwMndRSngxOUMz?=
 =?utf-8?B?TGpkd0Z2cER4NnVOS3Y1ZTFwNFQ2WEljYzVzV0lQSktYRUVyQU9QOTNEb0ZH?=
 =?utf-8?B?ZlljcDV3SVNuVHladCs2b3V0OW5aYXl3cUdIQmxNZm41N3U2dEVrMm5uZVJQ?=
 =?utf-8?B?QWhRc3FnenQrTVcxMmhZS3FxY1gxVzA0ZUlrVjMrdEozWlp1a2M5ZHZmWkdy?=
 =?utf-8?B?OGRRdHF1QmxIV1VhcEc2eXE4M3Mza3NwUC9Wb0dhZ3pRenptZUJrNXBBMy9C?=
 =?utf-8?B?aTVudy9VMnlaVWZlbEVFWFoydDMrWmhCZkwvRDFiTVlyVTBLdzkva2NNQWlW?=
 =?utf-8?B?U1dsdU1OSDZucmdUMTJwckFPS2pXcS9pZ3dmc2t5S3VzT3JGU0hUOWJOOTd0?=
 =?utf-8?B?MnVJb05pOHhwai8rYVp0VGwrSXhjSWJFUWNWaHN0UkJPbEt4V2UrYjJTWXF6?=
 =?utf-8?B?aTNkV1Zhb0JPMlVpc1pSK2J3eEprTHk1UmgwNXdBd1h0RGV6SUhTdGlzZUQ3?=
 =?utf-8?B?eVAzcGJiaTJ1T2lnUVVBYVNKK3c5QTRyTXZINVVyRWhBcUZOL2dOWmlLY1h0?=
 =?utf-8?B?L2RHaExscmR3cU55SlB1QUFkQmd6OFJhMVBVK08vcmxFTW5ROC9ROWE2Yysv?=
 =?utf-8?B?TGhtK3JJL2RySlkvMTEyTDJ5aVRQYjllTGQzT0wrV0w5YzRtQTdPWVFzZWV2?=
 =?utf-8?B?NEczRytTK29mMVZ6TGt3UDFzeFJWNzZDcGREUTk5eTlIYzZOdDAraEJMUkN6?=
 =?utf-8?B?bGxHamk5czltTXhWdWlCU3VSNThDSGR1dWZIb2R0SzhwMVhpemhnZUNPUHlH?=
 =?utf-8?B?RUhXenRyL2IzZEVUcHFWTm14NVg5VHFveVZaSFpyUDh2VW5rZk50dllYeFBM?=
 =?utf-8?B?V3cwZUhSRnVtMXh2Q1F2bTlGTHhUVGRGckhsN1FrNHZOSWdpVTdUa2szQVFJ?=
 =?utf-8?B?Y3lSUkI5aGRGVVFmbFRsMjQ4SVV0NGpzL0pDZm9QWWlWcUhsMjMrOFo4d0RM?=
 =?utf-8?B?cG92SmZMd3dPd0lqeGZmdlYxb3lMSjBqOUtLNnVPdEd3L2JVSDk2NUp6Mmx6?=
 =?utf-8?B?OVNTQ0tPa1BydHFlU1RvdVYyZmo4S3VzbXF0SG51K2VPQ0xYK0gvSnpFYmx2?=
 =?utf-8?B?enFseHdEOFp5a1hUa0RlZGhOY2QzS0dWQXdLQjRCQ3YzZVZpY1libVdyY0Vl?=
 =?utf-8?B?dm9FcW5qRjRnPT0=?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c13f32-1449-44be-8768-08ded5e400ba
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:40:42.3858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9PR01MB10784

Hi Wolfram,

On 29/6/26 19:05, Wolfram Sang wrote:
> Hi Stephen,
> 
>> Hi, this series of patches adds DDR5 support to decode-dimms.
> 
> Awesome, thank you for doing that!

No worries! Thanks for your email last week too, it gave me the
motivation I needed for this!

>> I'm not too experienced with perl or the JEDEC specs, so there's
>> probably going to be some questionable choices here, but I'd love to
>> hear feedback.
> 
> I am not the one who can help here because this is so not my realm. But
> if you can already point out some 'questionable choices', it will help
> other reviewers to chose their starting point ;)

Thank you, that makes sense. Mostly what I meant by that, was there's
quite probably some unusual patterns, as I've barely touched perl before
this. That line also came from the earlier revisions, where I was quite
concerned about the timings roundings, but I believe them to be fixed now.

Although one thing that does worry me, is the CL algorithm in the
JESD400 spec is massive, with some values I don't understand (such as
speed bins). Right now I'm just using the normal rounding algorithm for
tAA to CL, but rounded up to the nearest even number. However, the spec
does state this:
> If these rounding algorithms are used to convert tAA to CL, they’ll
> return invalid CL’s for some cases when down clocking (and the DIMM
> SPD CL Mask doesn’t protect against all of these cases). The proper
> setting of CL shall be determined by the memory controller, either by
> using the speed bin tables, or by using the CL algorithm, or by some
> other means.

I am curious if that was an issue Jean ran into with DDR4 support too,
as it prints `AA-RCD-RP-RAS` instead of the usual `CL-RCD-RP-RAS` that
is usually listed on RAM specifications. I am yet to look at the DDR4
SPD spec though.

Another thing, is some timings have both minimum nanosecond delays and
cycle counts, which are independent from each other. I don't know how to
represent that without being confusing, right now I'm doing
`5.000 ns / 8 cycles`, earlier revisions had `5.000 ns (8 cycles)`.

Also, that 'Module Nominal Voltage' part in patch 3, seems somewhat
unnecessary, as 1.1V (or 1.8V for VPP) is the only defined voltage,
anything else is reserved. I was on the fence about removing it, but
decided to keep it for parity with XMP/EXPO (which does allow arbitrary
voltages). Although, I just noticed VPP should be 1.8V in the patch, not
1.1V.

I can't think of anything else at the moment, so I hope that provides
enough starting points.

If possible I would like people to test it on any DDR5 modules they
have, whether UDIMMs, RDIMMs, CAMM2, whatever; and please provide a
hexdump, especially if you've got:
> SPD Module Info Revision                         1.1

Additionally, if you know your DIMMs have more than 3x XMP 3.0 profiles
or 2x EXPO profiles (including user profiles), I would like a hexdump.
If I can get access, the XMP 3.0 and EXPO spec sheets would also be great!

Thanks Wolfram for your insights, and I look forward to any feedback!
Steve.
