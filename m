Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010023.outbound.protection.outlook.com [52.103.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6DE358389
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783309601; cv=fail; b=Iz+7LRasnaraI1F5ZV53L76vjGwbFQYlLro10RuAFvNwwwBmzrkjZ9GcygqAfZj2e/UCIbfoKVOtlgcqY8OUSavlO22GIgUvcxbDdWSE8ADzsNpNldZzuFgvq09JgT3OTDjmxGSi7EO0vusMn2OmDqUFOOfGMr8TRQ2X+3eBN/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783309601; c=relaxed/simple;
	bh=2rN6ecB+l7VIQ2CRW+Au7Sw5/Jv3rO6nQsgzvim70i4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bzdfp1Vb4eQ4qXMD0H9WletWeqxM87LHwUJdHhLomTqJdDgFtw1S7jzU/YpDLYQGDfALxNj59UsFgF1eRQ1y4+YeWUWEfpPaI5nog+sv6bxDlOIF9A+ggBF6ZHvqnanQWgu/OXPayRiJM0NfrSUxK1vYeFS/BZH9V8e7548XOFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=BnSkA1K4; arc=fail smtp.client-ip=52.103.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="BnSkA1K4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xii8qM2GEzoY9KI7nBZJn1RLnAWw4mEiHkYOd5Q9Zi7jre6UM6k+RdQLIBv+X6NTHSrQ+3dnqRUQMgeI60ikXemPNrNcJDmfYnQzm516pwP3AnM7W+8iuzuF4Hu2lULiUFZji+k/OfjIuI7YLQ2AqC6ILmZnU95RXf5mqD859JLQxNEkxrcYi9+s/dsKYXJN9RLDuh9N8CeM3S6Hn89ec5CJnccC4MhCoRSNyVtCOU+MAgUsEpCzDuRskE/ZnWngCAykL86qaotkLwSiXBWkKq2EsxfXwqs60zPtYRvxs9TZr2UFRGVS4dVeX2YZPHhzwy7GQgVGQbZUDuTio7o8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rN6ecB+l7VIQ2CRW+Au7Sw5/Jv3rO6nQsgzvim70i4=;
 b=oQhLRKxnrDsszwy4pJAVuKzHDldsnwHBsuLjf8Tn0EhQc41EP3T00Np1lnUnK7oE8i1aJzb+DhDqDk8cCx2iT3SoXfqi4JpLiUldR7slzVeNQ09KkbAvRx+EBFJv6IxDzAg3xm7388irx7b5+biz9OXK4nMwsJd4HReJPPAfAb7jTuTsQbMHeJWXfl4bWGm/O27k0yWGDb4Q2gohjub1m36q9jClbSy/86e90gsJjt2C+BOOoUkcv/6Zvu15px4F/NIVjmNwf/wgA0rmYcXydkWPkC6pBIoGJbVMbXMvNGZHcKi6sBiBPlMfD+yxf0TjxKvofOmsyGeghte54TCVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rN6ecB+l7VIQ2CRW+Au7Sw5/Jv3rO6nQsgzvim70i4=;
 b=BnSkA1K4f+t4mI5NrDvchvCZKwivcjoieVu2JXPjNL0BjBc0MUALNAA0utn0hRwPwyCnrvaB35kJRY4qV6VB68G3cc9UAjxjKBJKbEEFQLVxf56/zin9ELy/U5fhJ0zAJw2Ll6ZXFjrr9pat8yThZ4nJLHzaqRmxcQyWbZeGX4Pya5ZIIJ413qirfjd9kopg3VMeCNXxosfJsFAkfE4ux75Yu/twiRyZeDz/tVPzEtA3tHLqpwjm2Ozk8MqK2XWooHdrpsrCVcreOS4jf4v78qZ7KbW7C1SY1xmZipYqv3HweeRmSjFMxjBuQclki82UN4aDWuzNhF5Utu/VllwuGQ==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by ME3PR01MB6307.ausprd01.prod.outlook.com (2603:10c6:220:f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 03:46:35 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 03:46:35 +0000
Message-ID:
 <SYBPR01MB45868F802BCAB22D56DDDDC0C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com>
Date: Mon, 6 Jul 2026 13:46:30 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] i2c-tools: Make tools accept bus path
To: Brigham Campbell <me@brighamcampbell.com>, Jean Delvare
 <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
References: <20260530-accept-device-path-v3-0-20c01b8f6726@brighamcampbell.com>
From: Stephen Horvath <s.horvath@outlook.com.au>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <20260530-accept-device-path-v3-0-20c01b8f6726@brighamcampbell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY0PR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::17) To SYBPR01MB4586.ausprd01.prod.outlook.com
 (2603:10c6:10:59::12)
X-Microsoft-Original-Message-ID:
 <3392f3e6-a798-49e6-a425-de03c2061279@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB4586:EE_|ME3PR01MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: cd466a5f-f845-452c-a1a4-08dedb112b79
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8022599003|19110799012|8060799015|23021999003|6090799003|15080799012|24021099003|37011999003|25010399006|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGZMRXBBZk1ZVWlOQXNJQ3U4elhxK0VQZThMNnJZTHlBSzA4M28wakhQc3gr?=
 =?utf-8?B?Z1VoRE91Skk0bjhtd0t6dkR0aUFRV09BVVFUQU1HVmFKanptTEF1STE3TXBm?=
 =?utf-8?B?ZWFHYUpyRlIyQW5rVC9GUW5LenRtYzBVcUMzTCt4ZXlsbWN0SnJ1N1NDOWJO?=
 =?utf-8?B?d2FFR0NlTktFTUUxcithQmtyM2VDUytxem5tMnlZMDI2NnpsK1M1amkrUG5F?=
 =?utf-8?B?RUUxYjdxVDVubkErKzFscVNTWkd2SFR1dzliaWNCN0ZhMkVueFh6T0xBSzdt?=
 =?utf-8?B?eFJ1QlFFQ1liUmZNbjNpSEhVTG5PRkdXVllXOTY1L1hKbUxqaG9VMEZCUms0?=
 =?utf-8?B?emFPTit5dytDQWp6NVE3Mm9XQ242UlpZSHRLUzdnSW1jMjFYVTFDMjladnQ4?=
 =?utf-8?B?dXJuZkJ6VGI5TmJaSE8yMVpxWVE2S0pid0JvdDl4ekVRWE5NY1F5NzlRdkFt?=
 =?utf-8?B?TVlvbHMxeEpSbHZjc3FndWtNajNPYWppUldVU1FLNUg0b3ExOHVHTlArYWdl?=
 =?utf-8?B?V0pCRk5MdGVBeFJQTXc5SEJBTU92RjFnRUxpSW1SdTFkOXk5bEJmYlAwaU9J?=
 =?utf-8?B?dXRPRjlBWURDVEhsRTlrZFBMK240QzNnS2JaTjJtTTk3SE1zd0xxVkNEYWdS?=
 =?utf-8?B?WGgrL2FnSENZbUk2T1pnemthOW5tZXVIamlxRXhSUDVWTlpwVWFqbCtwakRH?=
 =?utf-8?B?eS9lN0x5WVBFQk1ZbUdlZ2M5ckFUNktDdFNMZTIvSkxPVENoMWIyZytzWnJa?=
 =?utf-8?B?QUQ3VmZ3YWE5Q1VORldrUWxYT1JZcHZUeStSbzNmQ0k5YkpBTHhqUnUwbkJI?=
 =?utf-8?B?bXROZlNQOWVQd3kwcENpekJzWk1ZQU1OazVqa09hWVVvRUlPMnY2ekt4dnFZ?=
 =?utf-8?B?cFpHYnV0eHhiaTZDcTduWVFzNi9LRHgxbXFPVm9NdkJacTNQZmtWL3lRT3Y2?=
 =?utf-8?B?MlB4RU9KdnZTSWFFWFExMU1rWmk3WGJ0dHlBUThtQTg3ZndyVTRidlRSYmZn?=
 =?utf-8?B?d2NRSXJVTERVZERENjF6Z1NCRDRwYUk2SU1QRnVwaW55V1AvbXdVKzV6ZjhR?=
 =?utf-8?B?TU1hSHRLazg5MWlMUWRGeWdGS01HNTR6dXhsY09BM3BNMVlKa2V0Wmk1Vjdr?=
 =?utf-8?B?cGUrcGpYanl5dW9YMkxabWFtUU8zc0ttUjZaa29VbGtDTkZoeTJjTGpRSlhO?=
 =?utf-8?B?TzdiMWx3Q0huTnpnOTdxR2hlRnd2Mm84RFJKZ0xyM1dyZElRWnVqUVhEdXY5?=
 =?utf-8?B?RmdBVGk5NTZQdFJiOGQybzdhL2pPaGFZRmRDUFkwNyt6dktIdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUJ6ajlZdU5qdEtINjdYamZkYytrZkVVVDNSQURLdXpBTnQ5a2RoN1ZQbVRQ?=
 =?utf-8?B?dVdPL3NQcUNqbE9MbFJ4L2ZRZnFKb0pydklkYUNHNytTSmpjV2hGTkZtZURH?=
 =?utf-8?B?QThNQWRPOFFtbWJhY3hlVE43TFJJOHloZlVYejlVQitGUkpLTnUrVitabnRX?=
 =?utf-8?B?cHlWVU1NY2YybjJ4aElOREJrekt3YUh3ZVhwbWRkSUhMeklYNDJaZVpTdFJP?=
 =?utf-8?B?K3ptTUxoU0prU0xRaFYvcytoaWJPbVJZWk5IbkkzRHJGeWZKb3VkVjNiekJP?=
 =?utf-8?B?R2k3NFk5aVM1RG00M1ZBMnRPbTJaWFFldzVuODBGc2xvR1NLZk5zZ3dsMXY3?=
 =?utf-8?B?czh2b3ZHazV2RzNWQml6RVpsRlN2dFRqNS84VHRWa3FSaHloa3B6SnhKVGxh?=
 =?utf-8?B?T2NaVkd2ekdTZUhrV3pxYkd0TThNZUVMNldVTTMweTRmVDd1eTNEZGJDZWNE?=
 =?utf-8?B?RUxHSkJrV2NzWWVlc2pCVVVZS09BQ0VIQVRnOFVBRjJ0Yk9KVExUNWl3WUFT?=
 =?utf-8?B?MXdMQlIyZHV4T2N0Sk13ZnI3UC81eGhEeVRGanJsaU1FTGEyNnZ6aWdXVUxj?=
 =?utf-8?B?NmxYbHJETlVnNyt4TVZBSlZ3NU5MOWEzT0hYeHV2SDJBR1dpb1FCbWFkcjcv?=
 =?utf-8?B?QkJVR0VQVkwxNStnYk44U3JqdVlLOUNyVDF5TXpDOFZFNVRkOXBvdGVBR1c5?=
 =?utf-8?B?YTh4dGQ5Lyt4R2ZZdllRZUFhY3lWVmdVMzhTcEpPbmJFbURUdFhuV1lUL2Rn?=
 =?utf-8?B?WXlJbCtlRjdCNkdxcFdiM0cvZHJxdHp3akU2MktqLzBBcVIwTDZYWXlSUVk1?=
 =?utf-8?B?ZWRycHZjdUxoTXYvR3NHRFFxcDhTYWpYd2FnaHk4UWFUbThiNDZyWmluL3BP?=
 =?utf-8?B?d1dWeVk4Y0M4WWZUMGxMdjd5TkQ0U1A3SXRub0dVNUt5enlMY0JUdDAzUUhp?=
 =?utf-8?B?ZHVwMWF5QnVVUHVLRzhlMFczakg0ZXNxS2hObE41ektabyt0QUlzeXdRcVgy?=
 =?utf-8?B?dkdmRWdpVXdpajh0aE5RaERNVmE4L2N2aEZFVThBaUhPWVZjcGQrU09HOUln?=
 =?utf-8?B?elpIcnhHVjlWSGs4ZGJpU1RBQkNwQ3ZuTDFvVVRsTjJ4SEFMNklRbTJuZUdz?=
 =?utf-8?B?ek9pS2NMWnEzNlhtNUFZaDBnUU9ONUtyQktxU3VPL2toNEFpOC9JN1dPZ3ZE?=
 =?utf-8?B?T3RXY292RDhHNCt5RHJxR0p5dG1Rd1lRSGhtN0tpNzkwN25QZldZNjhTcWRD?=
 =?utf-8?B?WE14V2NLN285VDBvSWw5eUtWMmJqazYrejUyY0ZmSWE3ZFZGUElMZUkvNHoy?=
 =?utf-8?B?M24zTkhsV20vZU1ZSVJTcmdldnZsb0RsUHB1Qzc0WWIzSnIxeXB0ekdDNFBM?=
 =?utf-8?B?QzlYVmhtejVCVDRLZkZpRThBSXZna3lTSk81Vi8zaFVRaWZFUmVDeGczbk14?=
 =?utf-8?B?bXhqRXVUSjNmUHFxWlUvUG0yajJjOS9nNmZabWw5aEY2M1NqZ3R2Z0NzczNs?=
 =?utf-8?B?U0xha3NGQ0pwdGtKUzBUZ2ttNjQ3MWpBZCtOY0d6a1E3RUg2WmJLMlVTa2Yy?=
 =?utf-8?B?TEVhV1E2R2ltbU5EcS84NVNubEpORWo5ZmdQeDVMU2p3KzJmK3V2ckdVczFY?=
 =?utf-8?B?MElyOVhrZ0FZUkVCNTc4VTk5aDhJNG9WTkRVeVltdTc1b3U2WFBXTDZodWFy?=
 =?utf-8?B?MXRIRzdIa0dQWnI0VnVVeEczUTRJaWc3cERtWlNGUmZtKy94TTNNRkNmREU1?=
 =?utf-8?B?ZVhXaW9TeXVsckJXQXBSRUhZcmxRQ295dUUzL0VsKzAxOFF6YnMwOTB0eThy?=
 =?utf-8?B?cEVOb1A0eUVqNFJrZzd3SUllcFBiU2NqT1N5SDREY1lacTRxaHJNd0dRckJo?=
 =?utf-8?B?N0Nmb2gydytmTmJ0MGcyV3RxeWcrYy9FVi9Eb0RVTlpoV3FBdHVpdG1NRmd3?=
 =?utf-8?B?RFBGMVZtbDk5M2dCbU0vc2F4WDAxNVdlS1hNandPb0lKNFN3ZFF3VHkrZ1ZW?=
 =?utf-8?B?ZFp0SnZZZzNBPT0=?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cd466a5f-f845-452c-a1a4-08dedb112b79
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 03:46:35.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB6307

Hi Brigham,

On 31/5/26 06:06, Brigham Campbell wrote:
> I've tested these changes by running i2cdetect, i2cget, and i2cset.
> Please be aware that my current test setup has an i801 bus controller
> with what seems to be no slave devices connected, so my testing has been
> superficial, involving mostly failed read/writes.

I've just tested this on an AMD PIIX4 bus, and I am able to successfully
detect, dump, get, and set devices (mostly RAM RGBs) on my I2C bus;
using `/dev/i2c-1`, `1`, and "SMBus PIIX4 adapter port 0 at 0b00" as the
I2CBUS argument. I also successfully tried detecting on other buses.

I hope this helps,
Steve.
