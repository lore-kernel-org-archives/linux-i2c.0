Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505218;
	b=uS0k5ztoi1VsPNo/mTFgy+PZlg8OVBh2A8Ay+23BPMyCum7gD269/W1rXmErnno1w2Bd
	 s10j8Y/atPOdrR8OlkMKttePHzRHjw5wm1hmMlEBtpEJAghQE4tR9KZh+mD4UcymvHXwQ
	 CFHFBYQ0/rDEJfgVOibYi16kOoMFbrQtgZucaN6EYEa71zRdHKwcdtQIODMZzwgPYkReL
	 3hw+baYqXNmWpXHRtXgZawbujaoNbnLCbG/C7P+Wy9Hj5/cqFaqwFzm1jgRw4MDUbeHBb
	 WzQ9SRE0XNYu5RwJ9yfK1dZAH5jquzb8WRHNtkodFSbcgdOPt/rJIsy1bseD5PLf7UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505218;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BBGp9R/w6prPYCHS1CKL3m/lcRbXIVJNzDRD9/ip5i8=;
	b=thQ+HEBr/LufYa6O9EvR7ngpND920cpecXwF2Gqc3kkEXD6bo7+UQnuwlzn6/4uaaHpI
	 fuTPgXm1/ER/GkicghHUjZ/vMgTcLzYN7+U/scUKB84ON2W3ny6B3IabBZASmoyCdy/7Y
	 qvsQDpDA9uAfkA3f8EfqxQYUUz8V/Zq9xKxBI7iGVEowScSwVkJmHA+lLzI2FuC37Xam4
	 jRHsWHTueliE5HAzbOvIWpiYKEJ7Iq379yy6RjHO+Z4rTWjysm2354MYbc1JfwJrOUFhB
	 AjEJt7iJtJc/wj2GG8/95Jm8ntNXUNT857z65sTWHpAjILiH1+L+AshpFeeo5H1G6xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GngcgJfq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.18
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E4606A31E;
	Tue, 24 Nov 2026 07:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E54E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GngcgJfq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhKxvfH/wLHiI3Fv0K19J7HGCPLqqFJv9NoEg7aixUiRfRv6OOYmj7zBmyw4ruNs08VUXADZw6/QCzeyivawaZVJBNnr1knjho+vKLSsk2RDj+4v15AlSeaWhKXJJh3k5Mr1EK1gphiL4BvuW/cmmlSJ9CGOZx+HIymqk7MUGvdI33SIen9JOV5VZnVbmtoSYkiG3wdMJKztbjdJSupHHU2/mUtKzIsIG/9ynyH2ydpxylBJCgHi+SJKxfGn3xgtofMdGpQ9bJkTsM/tuwnf2qOowNHXIIQCQtNUEbclP48J38qm0pZplFIXOjGJxr623gaytA0O7uwLKym7BQhtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBGp9R/w6prPYCHS1CKL3m/lcRbXIVJNzDRD9/ip5i8=;
 b=G7KG9eCtHQ1k0k6EOjWd/+sb3jBzUhiUAAEbUwU3bAlu5Hu15rjnS4bFB4ycIzjgSopvgGGQ6+l1wRVkBt0O5wH7zJ62jA7o4aN8MApp9hpjExSiMG26oSP2V/5+71DjeWg9h0R5Fq9fTadC95274aSuBRHo9mPgRCXmxUN7uUZ4sEC2uXiEk257KTztPTpiTNbRVzzMEZsUjBWXMqsYYMtHqqKZVHR4xHOCdedd9e1rSVrc6233MUJk/47Dktb6rsyVzEs9VEp+eLJ8ibUXw63KP2yzXTgDxtspHZ3ym3bjkyPabpLpGjsEcu4k+8orRglIWftEu2iGdsRtv2SzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBGp9R/w6prPYCHS1CKL3m/lcRbXIVJNzDRD9/ip5i8=;
 b=GngcgJfqAR7iIejl1aBwOKSW5EeyiKza1gAJbPyIPiGFP7PpdrY1rRsp6uaoAjJCnfprRh6SS+mJXBC7IPwqP9pwMiPvPeDVsRAjfz0eO1UsOjjqYLLLgWMEt8BfOscpLg2DfRlwqxe15eLW6XKXV16omoSTuGymsSj2FdI1u5U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PR12MB052986.namprd12.prod.outlook.com (2603:10b6:8:47e::11)
 by SJ5PPF4D350AC80.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::993) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 07:26:54 +0000
Received: from DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48]) by DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 07:26:54 +0000
Message-ID: <b234e6d1-0171-4d42-9d98-2babdb98ce61@amd.com>
Date: Tue, 24 Nov 2026 08:26:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] i2c: i2c-xiic: fix waiting/clearing while atomic
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
 Thilo Zirnstein <thi.zirnstein@gmail.com>
Cc: andi.shyti@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261123085351.3415122-2-thi.zirnstein@gmail.com>
 <20261123085351.3415122-4-thi.zirnstein@gmail.com>
 <CAKfKVtFDez0kDJp0Kx4WbJ4BwqV8-0hb6eeRNjQ8YDFm917_UA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAKfKVtFDez0kDJp0Kx4WbJ4BwqV8-0hb6eeRNjQ8YDFm917_UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To DS5PR12MB052986.namprd12.prod.outlook.com
 (2603:10b6:8:47e::11)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR12MB052986:EE_|SJ5PPF4D350AC80:EE_
X-MS-Office365-Filtering-Correlation-Id: a71eb711-7de0-47bb-4ddb-08df49fc5080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|261022105027099003|4143699003|261028144727099003|261021121427099003|261026140227099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	KaDC4XEkloqINCIkkDdLZlwmCbBvaW6ImJ+T79+//vkc0aJgJeBiapuI+72kwaiVU6y1VrMDXpU58s522d1FoAyEWc8fX3GiXKhpaZFNc1QKtygl/Ad2jX3UpWdkU/ugR8XOY1EG3s2xgmXaEfv5B/F4pgupXbT9hjAdjJBXCmGlBYfPlikyKRLOZEFwJBQcb1SZBolDbAmuQarYC3B9UemlHBgzhsnV8e8Be0XArL83KHofxRtWg+Oj5KXBxwIXMXE3l9Afdgjrc08omD1N1WY2257XpIGwXuLcmC0w9VX2UV58I3A9Y50qQoyixc0GFpVCQj5jrbGmi18VpfpEW5pYj0L6zqD6vz5oPg8b4GrRCQPkp7tgnNHZ3WpZZo9ns++aKksGn1y0UaERxo9vL82OfHxDSn2/w/Z9lZRbXjAioT83e1f57HikGiKMg4P0fx99VNm+nxJWOhoYyY3EIas8F2lKEriKbo9mrNvtHF9rqcVeTiBzxSRmW6aR86GcwXOWCJxGEcMUsEapA6fXb+SOEIVDuRwmAnwolJOFm3L8BIODT50J8aYe2Z1wkKF2Cm2CGdI/HOehin0QiQwZgaPiWuen9lUbe1VVSQMgZUpMoo7ik5mhy7aC9ZhPXGoc+VHiTrVBr38V4fPUxAEpF9YRXbDKWLPrOC3IK4aA+jY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PR12MB052986.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261022105027099003)(4143699003)(261028144727099003)(261021121427099003)(261026140227099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDF6bTZqR2tCRUtLRW92NFE3Q21PZG8ydlY4WTVXUWZldFpTSlRmTlFrRGpR?=
 =?utf-8?B?bGwrYVRESGRQWjBXcldLMFczWlUzazRna05TcEQzMVFuTitCVDZqUThFbDRN?=
 =?utf-8?B?ZG0zeFpKQ1dlcklVVlpoMWpjREtXczErdVR2NTU1Tnk4QjMwc3U1Y0txVHZ3?=
 =?utf-8?B?aHZPRnlxd3pibG42MnI1UjFmZDFxTE9RYUc5M3J6aVVRL2crQVl0cDlMUzBy?=
 =?utf-8?B?NVR4VGZib0x3bUJRaGdJY2h1emhrRXVzUHlxZ1ZyMmhGKy8xRmFBY1dhL25m?=
 =?utf-8?B?YkE5bjFrM2JqMkpoSGJJZEpOVWFrSXRQMWNXcVh3aW14WkxKNkdmVTBNUkFE?=
 =?utf-8?B?Tzd0b0NvU3VQR20xQ2ZKVTQyQzBOVTk3ZHhzOGlLSk1TZFFjUHdycUdaU0VY?=
 =?utf-8?B?MW1RQUdlTG8yUldGRU44b0NMVVRlVHlzZVV3NG91a2grZlI0TG8zdnRXZVJL?=
 =?utf-8?B?dW0yZHkxVFNpMW9zVDNVUWZrT0pxZUdqT2diU2RraGRldzdwZkh5OXZhZEV6?=
 =?utf-8?B?VUhCdmxGZmF4SUwyQmF5OEVRTHJUQksxM1NjMzRFVW1rZitQSWtwSEdmZnJT?=
 =?utf-8?B?bjUvV282MUJ1YmNWSjREanoyZ3hQZE9sdU02SmN5OTR6Y1JaS09oaDRlcXFP?=
 =?utf-8?B?dlorV2FZUlJNUjIwd0FCZDBaUUNrSUhPYVV3WGZ2bGVKak5NTHdmcWpEOVd3?=
 =?utf-8?B?SnNmYnBmT0VYSE9BQnAvZ3VONW43RTIrL3pvdzg3N21ZT1lWZ3pHMFR4VDFX?=
 =?utf-8?B?aGJ6bUZmRHlBU3p4ZVBiUmJ5dmJyQmV1U283VmZwRzdKdEoydThMd0NXSGRk?=
 =?utf-8?B?NWh4RlhwUWZLN1paVURFVWFnTkkyWVBORnZkQlFkWFRNdXpsa29MM2poU2x0?=
 =?utf-8?B?VXZ4dXp2aXJqMXNZcndTNU1mS2pqck9uaU9ISVBqb3FZSUw0eW5OSE84MHdv?=
 =?utf-8?B?Z3Q5cjFXS3FpN1hSKy9NZnNicXA2T1RJUzU5Q3cwMGJpZXRJdVBYV2k1dHNi?=
 =?utf-8?B?L2JJTVZlSEMrSjg5SlUzaUNDcnN6RWpNaUs4N2xHeXNRSTBseVUwQTZ5amlh?=
 =?utf-8?B?OU11Qyt6RGY2SUFTYjBOdWMydDFSa2pIYm9ZSkRlVEZKaUZHWm80RS8yYmsy?=
 =?utf-8?B?bklmREphMW9WcXNKajR2OUFSazllYk1XTjFpZ2h3SW5CaUduYVp1SVFkZm9Y?=
 =?utf-8?B?V2hYQkpxWGVHNnQ0V00yblpSQTBSQ2NMdTVzQlZLUHFXN0NSMXh0VzgyMnhs?=
 =?utf-8?B?Z2JlVCttTGVseHptT2hxUm5Jb0FpSUdVWXBDWE5tY0FjcExUWXRueEkxM0ta?=
 =?utf-8?B?elJuQkdzakcvTUZnOFJOdWQyeTlOY1M5Q3kvYUk2YVNRZUNIVTg5bXEranFB?=
 =?utf-8?B?Umt6OVBGbXArLytRZjJ3ME1tNmc5NVI4aUhiVThmOElTb1pILy9VL3cxTjdP?=
 =?utf-8?B?OFFlQ2F2RVhLa2Q2N2RLT0wrN0pRbGw2TWpPSXR1OUp5TWluTHhKYXFVZzc5?=
 =?utf-8?B?T0oySUpEV2c1WEszVjhiTVZSZFJYOE8rQXZrMkxCZ0tsS2FIYTkyc2xIdVhD?=
 =?utf-8?B?TTN1RkVRK0FUQnhQSzdkd0gvUlY1WVkzTUwzWEdveENpNzBpOE1KWU5JZTM4?=
 =?utf-8?B?c2ZBSVo3Uk4xQ1N5Z05sdFYzZkszbjUxTXpLUU5vRzdWY2g0WWFOcnl5NHN0?=
 =?utf-8?B?UXowYVRzOUkyN1dKbVp4b3ZxWU54Szh5QzlTMjQvTXp1czFKTjNiU2dyaDhP?=
 =?utf-8?B?UDBQQTVNWVdRNllKNTgvcmh3ZVFMcEk2bFRrOGRLSjBLeHFmZWxUWVQ2OUtl?=
 =?utf-8?B?TWdHWFZhS1ZUVXg0L0lscjRCUmN2cnRiTWdPWDlkaks5eGFsMmNwRFFtdU5x?=
 =?utf-8?B?S3h0SWJyNmJod3h5NFlEN0tvaW9Qdmp2ZWd5T0psTVJpWWN0WEp0NWFZdUdT?=
 =?utf-8?B?cm9LUW9yZVB5emw3VThlR2hETWxJUHdUbmZjR0ZaM0FtVWpwMVVDUzB0NW95?=
 =?utf-8?B?WFZzeXF5YXE3bDliU0VCeStzem1pLzJnbEp4SUY2ZlMrNGd1bmFySlh3cDNw?=
 =?utf-8?B?b0xXejRnaVI4TklHNFdpR1NBbzNEL0NVM1JVaGdmb2EzbmRrZjZheENzeHhH?=
 =?utf-8?B?eVNlUTdUWmdjeEx3am0wUEc3QWowb1RCeXpvUjJsdXpoSE9UNG5mOUtpSklZ?=
 =?utf-8?B?cWdBTCtzN25EZmlPQitRdlJnVEp2RUVVb3luQUxWL1hmd1JGOUxPbFFxckV4?=
 =?utf-8?B?NTY5R1JFRjQzRVhLZ0JqWm1CQU03Q1ZZYjV5cUFqb0xSalNsMFdPU0plWC9p?=
 =?utf-8?B?WkJHZnlCODBMdWxtYmdiZ1FUOGcrNkFPaFBhUlMvV3RHbnozaXIrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71eb711-7de0-47bb-4ddb-08df49fc5080
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB052986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:26:54.2012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7DiAMlkTBi5UMbkFLNPbMR++PU1K4RnqKPY8dnYdU3tQTgU7h5GnF6letlIplzc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D350AC80



On 11/23/26 20:06, Shubhrajyoti Datta wrote:
> On Mon, Nov 23, 2026 at 2:25 PM Thilo Zirnstein <thi.zirnstein@gmail.com> wrote:
>>
>> Use non jiffies based waiting functions,
>> if in atomic context.
>>
>> Suggested-by: Andi Shyti <andi.shyti@kernel.org>
>> Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
>> ---
> Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
