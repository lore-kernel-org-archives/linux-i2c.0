Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020138.outbound.protection.outlook.com [52.101.84.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2A30E829;
	Tue, 17 Feb 2026 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771321140; cv=fail; b=prWvGtBp1uRheRKP15Em2kSsk5OPjT5VCI/5vQGBqfVYs7zrHxhXVoH3NWz0c/lyz7abQvS3CibpG/9r8k3VLo7uT6cFj5h6v6guvaz3eyj0OQbO5fj6xgHZ4Kf7kFXx2xLMToCScmEkbzP78aUJvICNWdzfDOVOTNqQb7bJ7Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771321140; c=relaxed/simple;
	bh=Suvcsg7yrRHlxsMX+3NuojgROX6BQAQh3wnwY64/L9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RR4BjQh8JTWizrqSdLbgIYzt1kWbHlgDJJ3mdhn8ZpepgaOu+0xQKl8NE5ZQ4Rt8oNxdVTAsBY44CiTLTaoV4FrH92WwjNbcQilhs37ybFby2fho/lW4udchJvESf2JxmwaSxo7T4R8HFn4HyZ7Uewa90JTJ9FoRT5Wac3ku2ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=ZjyFcTo7; arc=fail smtp.client-ip=52.101.84.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ZjyFcTo7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0XCB8lqvDE2NYnu+Xait5pUkdixYHW4eT16udlJ7vmP4H04ONFPO45lwzIoTWIGHskqE6gmnkz3u9auACumIGfmGYdi4ieY/AKVL2yDGKSVGFNFY9xxpbUPxrldmJXJ65fRAVtIPCkXMR+hhWyRC/M82DXSF9uH8IAeCn3T/fLA5bWyiI9yaeEgNWPWlEoBpUxsn8jaXlx9ud9YJ7684RzRUG7jdtdpJjnYQhj6Y6sYoaGNyCcP2XYxZ0MkFNEVLihBmzy1C6eH946B77lGuUmipXRV1vFlTCZhzMjbfCbPs9ryHKzW0VMbe+gG+ki2nG5o1r1FdiqsW3InRxcdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCFj7XFj9piud/c2Sbd/HnCEZHgJjXXlNLVxmiUlJbw=;
 b=rGL+6+v13CIZUyynXtmrZ3yzH8NLnaTfvO8fZE0JzwDIW2y0SMB0RvY+R/7x4dRIR28utMmgl33TBTUx1S4aK8jdbowKikc47QlhOXKv1P5pxuZDGJwJ7fq6ljEjJTwibsW3EOqge3rLgY69Wlm9um4Lyy2EGt1y2ikHlIsim+3d5eZhJZPJpBs8gQXTVTL8+InKjgU/LtrQRHKYb2vseSOzKQdAi5U/l15/P6tO0prlKCg8e93onw+M4JQFU8/rseC/z8tuILyhzlVlVSG2G79xPjLZIXDVCqYtS5cia3e4FlK25jeLpZcx2/Th66x6ib0+Q5K3gdDKbNJICzCRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCFj7XFj9piud/c2Sbd/HnCEZHgJjXXlNLVxmiUlJbw=;
 b=ZjyFcTo7pXl0kRzjG1z/54Y1/fYgFlos4xhPrz0cQ4QKBflPxw7ZziDJUIV+Waj11Y5Zz+k4N4AIf2Q2w+pFZSn4kElXKKBllN8vNhhhHNmkZRFtxTwTawrOA+wktCNSOrxbM8yv0qbaUKcCE2lkojS33uAgw30BvsYNkHxejSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by DU0PR02MB9145.eurprd02.prod.outlook.com (2603:10a6:10:464::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 09:37:41 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 09:37:41 +0000
Message-ID: <e21781e7-0ba2-19ce-3c0c-bd198e73c03c@axentia.se>
Date: Tue, 17 Feb 2026 10:37:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 2/5] i2c: mux: add support for per channel bus
 frequency
Content-Language: sv-SE, en-US
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
 <20260216-i2c-mux-v6-2-9be28ecfd7e3@gmail.com>
 <ab7090f3-4c03-098b-b118-4cd7a68af8f0@axentia.se>
 <aZNm6LSK9C8DHC8U@gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <aZNm6LSK9C8DHC8U@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000383D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:d) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|DU0PR02MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 726051b3-3549-4044-bcb1-08de6e08322e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azFCMEFIR0VvMU1GWDZ6aHhvSXUzUG5sdDF1WVZFdnBhdFhyanRlRGhFWVBT?=
 =?utf-8?B?TWhwQjNCQ21BSHJRdzNkaHZManZtYUg1MXZMT0pZdU9Sdit6NVN2alJndCtO?=
 =?utf-8?B?UTZ4R042dWRTUENvaWtXMkdVVmhGU3Q1a0ZBMm5BQWtweEJ0dFJEYTVjdThj?=
 =?utf-8?B?eUY0S3NKMnIzQjdaUXV1RUU4T1hsRUhKQ2ZnVHFwWU1oZUZ5TEsxbnZpQ1Fq?=
 =?utf-8?B?b2V5c0xPVjFpL3h0Qzk3L01CYkk0VjRJdldkaktHUTdSYXZiWmlXWnROcjht?=
 =?utf-8?B?eUx1a2EzT2VZUXBNUkIxUnNCRFZucGhMRkFpZEN1dCtIZHJXWGc2SjBhOWVT?=
 =?utf-8?B?dDZIV01SR3cwS3Q2czlKZDNhclc3dks1RHBpS0F2MjJ0bVhVVTRmcGpSZWhJ?=
 =?utf-8?B?djAwbFJLekFsWlordUNXck1TSnFGRUtWWldhV2FxcEkvRlRYTUp6NmlHcEdS?=
 =?utf-8?B?RFVCdERRM1VWRTViakhSdHVuM2hadXplRjhGZ3p4dXFoSjlZbHFZNExYRzZr?=
 =?utf-8?B?eG9ESForRzZhekVhZ2dUajd1TDFTaENqNi84cytVdXNkNS9UNDMyLy8wbTA0?=
 =?utf-8?B?aHg2Tm1aTUZ4NExRR1BkZzg2YThzVEQyRnlBVkFaTE4vaXYwRDlVYTVLT2ZN?=
 =?utf-8?B?WlZWRWFoVHgxV0k5TTM1dUYvVnNKUE9yWTRJVWhFdkVCbzluUGF3a2pqUkpS?=
 =?utf-8?B?S21tZGFFVC9kL21POFRFYWZmTm1pU3U2cVVwMko0QTVZSDJyZGxkUmxOMWND?=
 =?utf-8?B?SW95cVlpVmZQaGFXQ1JNT3NIdElsWk1ycDZNWVNMd3RHa1A1dVc0YXBoNG9r?=
 =?utf-8?B?WElURmJhQ1NFc1NkYjFmSHlmZG1YQVhGbVp6YzhUSmRQNGdCQWNYb0YyNFFM?=
 =?utf-8?B?QlNJRVVwRFU0MTZjc3Ayd3BwbWc5V1BaSWRGeXZqT1FjRCtGSEgyMWNRcVBV?=
 =?utf-8?B?ZGh5bmFIOXl1Y2VGaTMrY3hqaGVuMXA5U1NCVDNvT3g1WFJlcVRaN1JZeXBO?=
 =?utf-8?B?WlE2WHlPRFFJV1VNbjhQL1QvV0p1cTJhK3BFbWpkc0NHa3luaHZPSnl4Mmx0?=
 =?utf-8?B?eC9NVUs1VVhZTnczWTFHWlI3TFQ5TGdPbVdFUFNhY1RDUkN2ZVpzRFl1ZlRy?=
 =?utf-8?B?bEtKKzEvOFZFVmE1LysvVHhMRWhEQ3RxczBVM2VnOVdWdEZDK2hUQStGRVYz?=
 =?utf-8?B?MVpUeVZJdC9wTVk4NXdxaTZ4OTB5OUxmd2xWYm1Qcm1KUm1FMy9hYkpvWWhk?=
 =?utf-8?B?S1QydG5QUzhJYi9qU2VMS3NtSlBhQlZuVFJ3NnNJQ01qNGVWdXRDMk00dlBG?=
 =?utf-8?B?NFJPUGdyeTQzYXplWE9QTGhhSW83TmM3b3lQcllKUWRyTnNna2RESXBFWlhW?=
 =?utf-8?B?ODhiWXVTYkVJdVhlNlpNL1UxQW5WOVZ5dHMvdGsvaDRaekxJc1dCWDlSZVMx?=
 =?utf-8?B?QTkyMUUvWnovblhmaHllQldNK05rMnBFMTQxYURVbEFiSE5WWWZQT01rS0Iz?=
 =?utf-8?B?d2tWLysyWDhkNkR0QVd3U3RwMnR0Wmd5Z2ZDeUtpakV6aDJNaGFLdjRjRmxh?=
 =?utf-8?B?MThDUGpUMTdQODdwODBqSnZ0Qmorcm85YkswQlZadHFSMVozQ2NncjEvaGRH?=
 =?utf-8?B?SG1EckVGRk1sVy9YRmRSNzZmZTRaVVgwUzZwd1NTNXZvaEhORy9ybVNKUEFF?=
 =?utf-8?B?WDlMbVp6VXhid29lVEpNNVRlekJDNGdQaXRtTE9vaDhxUVNnck0yTG43MC9C?=
 =?utf-8?B?eHNuNjdlOFJmaTZaYjhUS1ROQ3lWbkNWMXUrcnNPYVV0K2ZFZFRHV1EybFd3?=
 =?utf-8?B?b3E2LzlRQlJHWloyV2g0SXRuU2NoS1pjRHl3VksyM1NwWFgvb3lZdVBOYmdo?=
 =?utf-8?B?YS9QcFdFSGpHbjZkK0ZlMUNzRno0YjQzU0k5L0IwZytseG4xbnpHdHA1TFhp?=
 =?utf-8?B?RCtGazhJUm1HQ1hNdElDTTJlNUVMN3AwVlREd2hUNWtzc1IzTUgvREVNVi9k?=
 =?utf-8?B?bWlkNndJMm1UY3MrcCtENSs1bzBnYnRDRGxXdHduYnVsOVdST3Zib1V3VVZi?=
 =?utf-8?B?ZEU1bzBLWG5GZ0gzTkxEZXA2V29YVk1aQ25SOHZFcHNwQjR1bzkzc3pqSE11?=
 =?utf-8?Q?rqeU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUZuN2UrcittU0tZRXpRMGw0WkhmbzE4a0tPTmJJbENYQW41a1ZBd25NbG5T?=
 =?utf-8?B?cStzKy9PWlE2Zkp6dFMreVZncG5VRmFNNnVpQWVrcXpFdHoyMExvQmw2R3VN?=
 =?utf-8?B?UWluQjZMWGc3UldsekFPY2s5ZjNmcWdYYlBiWDFLSExPMTI1aE1LUDYxVzRQ?=
 =?utf-8?B?ajVmUGw1QkFhbEZMcDJsamhJZVZmV1dCd0tCNDRFbHAyR2VIRzRrOUUzZDBY?=
 =?utf-8?B?NjkxL09UZmdkbXdrMGo2VmFqaDlkMkwyR25jZm01WG81d3NzTWFaN25DSVlh?=
 =?utf-8?B?bEcxeEQ5S1ZrNkhHR0psNDZwM1V4c0VhcytlUmJyZHpkeFpFSVAvZWdrTlNY?=
 =?utf-8?B?OUpWaUJLZ3cva3YyM09QQ3RwS0x1Mnc0Z2hpeERwVkxWVkRnalJsLy8zSGt3?=
 =?utf-8?B?K29vSkZySlpOdStPR0VxajhtWkxteVlvSzQxczVZT3A2RkdqdWVBbVZvdFds?=
 =?utf-8?B?RU5qRldLV2xYQVNCMkZ2TnFvYWlKTFpER2lnUDRDVE4xTE43Y3pybE1kcXM0?=
 =?utf-8?B?RHVrMmJldXJRNzZNMUlLNWE1LzFnc3dka0l3bU01ZGROb1JscmFQOUI2MS9Q?=
 =?utf-8?B?Q3o1RU8vNnE1aFh1cGtKcy93OGF5OUlORjFSTnJVZTFleG12c0VHTTF5ZnEw?=
 =?utf-8?B?blBURVZRcTdacnphb0RiNi8wS3pZKzNmZXVjNHJCSmx3MXZWOGxmRmZIank0?=
 =?utf-8?B?Tnh5Wnp6MlRpeXJxWS9xUEFvNkJMYUJhQXVEbzNYdElUdzM4cnJsalRSaGpC?=
 =?utf-8?B?Z2Q2a0NCbDI0TS9HTk84dkkzZVl0cnhTNjIyeVp1VVpqTU1YQlh0NDZLcFRh?=
 =?utf-8?B?R3ZFUmlvZDhUSnVWMERvRDZNNXpRTmV0OC9XQ0EyZy9IWWU3emFyeEZaUE5v?=
 =?utf-8?B?N0ZaY2JFMDJoNlhpTHFUcEF0QzY1RUN0SmN6NTdzUEhJYkhYcWE0ZFg2T0I5?=
 =?utf-8?B?MEtJV2hVd29VWGozNkVvTW81cldsTi9NZ0pTSFdJWHRWTDZ4R1lTRDVxVG1F?=
 =?utf-8?B?UFZycU93RVc2QlJWRkFPZlFOaER1UVgxRTRzc05VVVZ1QjIyMXhNZEY5czNS?=
 =?utf-8?B?Z1lZMzBaTDk5cis0WDBUVEhDRkJ4eXVIaEVRdXhUQTJTdW0yQVA0Z21uNU5n?=
 =?utf-8?B?OE54VXp6ZG1ValhWZndGV1BqU2VoaEZpamlWM0ppMHhQZzF6Vm9ZRzEvRWd5?=
 =?utf-8?B?Y3VCS0t3ZjJzd1N6MFFWMjZOZGtSMHhUNGFGYVc3SVRwZmE1eERkQjR4bjB1?=
 =?utf-8?B?YmVBM01pS3JnVGwrNDFNMWlWSEF6UVpXU0tXcGd2cEJiWFBBbXlBY2IzU3Rh?=
 =?utf-8?B?VW1hdmhHUVJzTDA1M09XbVdMSWZhemN2UHE0RHFjNE52RzF3M1ZJN0tKVVJk?=
 =?utf-8?B?blhpRGNXU09FR0N3QnVabnRNTVlVK0FWTE54ZXJYZDVUd09GTlJzb3hIL3Qx?=
 =?utf-8?B?R29NSWozSUZBRDBjQXhjbENhM0I3WWFFUENHOE1vL1c3QWluSVpZbXd3OVhT?=
 =?utf-8?B?TTBCV0QvbVhTV2ViV05CMVBQNzFYV29HUlRKdCtCdVJxdTRKSDRWTW1LMnpm?=
 =?utf-8?B?RDhhQjRGYXNoYjR4d0M3RFNzNGptY1BwcHlYZW5LanJacmVwSjJ5aWY5dHZx?=
 =?utf-8?B?WjFkV0VoSHFhNW5YeU9wTFVFa1dtZlVvMEcxeVoyaitVdDdLcXErN3ZJcG8v?=
 =?utf-8?B?ZFdoZGNXNVJmd3BSVTlHdnB5Nk1JL0FTelN1WmJrYVR3bWpwQmQwL3JtcjRX?=
 =?utf-8?B?R0FYM0VpRVlVbDFBWHlLd3NZc2wwRmNTd3g5WEhGSkZqRTJJVzA3RlVWRkRN?=
 =?utf-8?B?Um9hdTcrT1JRdzhRY1RoMGZZN2o0L1dqSGZHRWg3RXUwNVdoM1dweHdFbkov?=
 =?utf-8?B?Vmk0Q0ZUWFVVL3A5YjFyQkhqL0RKeDR1UStqcjF2UmluWTZLMXVWSXJ5TEZ0?=
 =?utf-8?B?eFRCWCtqQTNycmlaWXIvdzZXYXgyeTA1bUhyMjREdFdsbXJ0T012SkM1aW0v?=
 =?utf-8?B?WlFOMVBudGlRaDg1bEU4WVJrUHhRWGhYeEdTWSt1cWVPSjZhTDlWTERrckda?=
 =?utf-8?B?MFR5VmdVSmdJMVlXU2ZXNGplSm5DMWdUdkw4L1dOenc5aDVReTluNEZnRDdO?=
 =?utf-8?B?c2V0Q0dJYmZ3eEUzK1RqNi85MVRCeStvNERBUEN6Y1pXaFN4akFrNW1mOGVH?=
 =?utf-8?B?d2ZIMGlVa1RtRlhxWFZuQit1ZG54UWovWXhTZjkwV09DTWttZ1RRYUJlR3Fn?=
 =?utf-8?B?dHowY2c5V29LZ25sNFY1RForQW1kS3h5MHI3eXBROTdEMnNtWHk2K1I5L2M5?=
 =?utf-8?Q?z4QDj8uB+CgvECFq8o?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 726051b3-3549-4044-bcb1-08de6e08322e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 09:37:41.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HReU4jOc9WZu6WZkecuDMUvdIEp9nWEF6F8LII09g8769nrh9De+BPz7dyg8rNzg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9145

Hi!

2026-02-16 at 19:50, Marcus Folkesson wrote:
> Hi Peter!
> 
> On Mon, Feb 16, 2026 at 05:40:37PM +0100, Peter Rosin wrote:
>> Hi!
>>
>>> +static struct i2c_mux_core *i2c_mux_first_mux_locked(struct i2c_adapter *adap)
>>> +{
>>> +	struct i2c_adapter *parent;
>>> +
>>> +	while ((parent = i2c_parent_is_i2c_adapter(adap)) != NULL) {
>>> +		struct i2c_mux_priv *priv = adap->algo_data;
>>
>> This assumption does not hold, making the cast pretty wild indeed. There
>> are other i2c_adapters with a parent besides muxes. See e.g. i2c_atr.c
> 
> I see. Hrm, not sure how to decide if it is a mux or not. The best I
> could come up with is to look at the i2c_adapter.lock_ops. E.g.
> 
> 
> 	while ((parent = i2c_parent_is_i2c_adapter(adap)) != NULL) {
> 		/*
> 		 * Check if this adapter is a mux channel by verifying its
> 		 * lock_ops. Only mux channels use these specific lock operations.
> 		 */
> 		if (adap->lock_ops == &i2c_mux_lock_ops ||
> 		    adap->lock_ops == &i2c_parent_lock_ops) {
> 			struct i2c_mux_priv *priv = adap->algo_data;
> 
> 			if (priv->muxc->mux_locked)
> 				return priv->muxc;
> 		}
> 		adap = parent;
> 	}
> 
> Or do you have a better idea?

That looks fragile. My recommendation would be to avoid trying to
guess how a potentially diverse adapter tree should be handled
locally in the mux code. To me, it would feel better to introduce
locking/recursion in i2c_adapter_set_clk_freq() for muxes (and
address translators), i.e. take inspiration from i2c_transfer()
and i2c_smbus_xfer().

I guess an unlocked __i2c_adapter_set_clk_freq() is needed.

Cheers,
Peter
