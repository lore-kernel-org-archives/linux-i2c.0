Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021096.outbound.protection.outlook.com [40.107.130.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5F44BC82;
	Fri, 28 Aug 2026 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918914; cv=fail; b=TZaDIxf0oi5juak0L8oZd9e42GHyvP6TCelLGhKl1DgVh0n9m83GUme+do2Tyt1iKZ2Aec4cOGNQ0/d5I7nGTRtOKiZiXmo8OFFU12Fp+JRMms8WxkU9za7Tz2nW1c3SJgF0vSwIz6znBtCJoVzCj7qrKH1sHAawDCVT03Q/N/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918914; c=relaxed/simple;
	bh=OFFzB+IgZe/EOkyDwNyQHQ3Z+hVy6bCXOga1VbCne2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iLx/raeBqtIHxZvOEFSFn61rhiiCrEnfRr1L7vP8KNF0iUPZ6quZTT8JXUf3uMl5s5vZ2gh8vSRp3UDdAy5ejvB19sml4RJEGnc+5h1VGKejSDtyh9CVnhv1ZqV2ZYFdaMWy8pQlX8of5sAyqY7Jx3PfcFRvVqXGZdz9TevzlsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu; spf=pass smtp.mailfrom=sch.bme.hu; dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b=cZRld1W+; arc=fail smtp.client-ip=40.107.130.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b="cZRld1W+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbcogkg2yjCTMO3FrEaHLThcZQjjFFcIXwaZBxtLDDH8ml/hPi8qEaKsVWXonoKm7dQ8TK2lnbQXyJOF3aDnlY0lvVBdCRxXWVaglxcafAL+wPl8jum6gy3A6L2UWA0Xurfa+FzginGybpkiBghrOVqhoPcdFQlWMH+MSprdBXltFkuySQBW4IjakH6NAvDFTQhOJ1COMBUYSD5fJJ9zHlvDs3U91Umz8DYE3Ldta9Q1Y/RrdkPpwQbahYBMTSKQ8fdR+h8aTP4nbN225UOuYOPBWZIvfFkBwTmlJyWrfnH8OMh+ldg+1F5Pp3MfC2QMt4a08Ioycdpr3/w2QODW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kIMCtJckwP5TEfeF7+7ObLcEwPnOfHh5EE55sYzNWI=;
 b=YiGBETn9/pCAXVmSNR0nACn3FS4Z8IuFLjBzYtZTXKPnHOILD18LMIpGLn7USeNtt8d+9uQzQehceizEK5sHae7MXj/n97wfskJ0ZmR/QKErcm17wBe48Fac9tiFpqrxTX3X9ssKpbjLP1fJK5RWR+HsafIZvJpwuKdgupnNPbUsiJWoTGuy7j4+EwxO+cX5buSk9SzF/m+V2wOZNmvf/DJn7QpdRPWYMHaZ5VTAE3lW2bthitNgPOTtRZiK2xCL5KAbJ2AEEFLRIXa8GDl4Lp0Q1N4K1CSmEV1/n+KYF/h54Xwfm/rFUtbK52STflUqTcOmyEp6xsrbj31uQ7SJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sch.bme.hu; dmarc=pass action=none header.from=sch.bme.hu;
 dkim=pass header.d=sch.bme.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sch.bme.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kIMCtJckwP5TEfeF7+7ObLcEwPnOfHh5EE55sYzNWI=;
 b=cZRld1W+VGSD0mQWgqWtKwLr0drjjb2wz65hzlXY2ULSPCI0uCa/Q6AuObUvL5SabLmpcuvb+tfV+t8IMAzZw1DYOUUHDSFYSOY7tAM4t06VIKWjZNYW/rF2aYBpIVqlQY/gnw6xnU6m01+O4bFwBPTKKpnjCU3PU7uPXvMjoys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sch.bme.hu;
Received: from PR3PR04MB7260.eurprd04.prod.outlook.com (2603:10a6:102:8c::15)
 by AS8PR04MB8514.eurprd04.prod.outlook.com (2603:10a6:20b:341::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:08:20 +0000
Received: from PR3PR04MB7260.eurprd04.prod.outlook.com
 ([fe80::bc60:c1f6:2fb5:8cf8]) by PR3PR04MB7260.eurprd04.prod.outlook.com
 ([fe80::bc60:c1f6:2fb5:8cf8%7]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 12:08:20 +0000
Message-ID: <05df77ed-855c-4897-857e-0bc2439666d4@sch.bme.hu>
Date: Fri, 28 Aug 2026 14:08:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: cp2615: handle allocation failure
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>,
 kernel-janitors@vger.kernel.org
References: <20260816161751.24840-1-triet.hoang.dev@gmail.com>
 <20260818111703.19604-1-triet.hoang.dev@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence98@sch.bme.hu>
In-Reply-To: <20260818111703.19604-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0068.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::11) To PR3PR04MB7260.eurprd04.prod.outlook.com
 (2603:10a6:102:8c::15)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR04MB7260:EE_|AS8PR04MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fb6887-fca2-4a64-7bc5-08df04fd0d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|10070799003|366016|19092799006|786006|23010399003|1800799024|376014|10067099003|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kg7ZbsllMozShCKqX0uITlZduhgVqQleR+pBkIeYbXEbOZdcBrFuwA5EJ95rb4VEjvTROG2lLVyY8d1xaQCACyCgvN4x8n+Fn4hf1DfedpRftvJ0K3RNSwzuFCW37YBGQPyuVYAIwm8sP00qAifJ5ZZvEbcxoviRJS/nt+Dejn2GYwExQlTm6s07Ymkg/CJEbLYlY7d9VF/OjRd6d4kFc76SQDYVJypRpj/2MbSJX/TiGjGrx3WzusiUOWAMdPsFwemBu/qxAgWoQrjvlO29wxT9GX0bWiGpg8cqPFEoZbfG3UL+B0sLl05b7dDSf0kz4Z9yrYj1JdC82VXqDGozntQUqEwg80T4Dv0BFGR8eWIOUcQ/5iWoy6RByZIymRGDV9GS5wNaZ86mw6wdoEqwtoJBq6sx8k542QIJW0fafVC4Nxnaxi5Ngw4wrXM1nY9V/5kLbndNb87GMo6D+ZVVS8quUfVfSpNN6Bw2JZt1guCKt8iXzgiYIonKD16K9ETfmzc9oOm7c56TY/h4ce70Agu+x2VTvddGPM0FI7uGxd/xbtbgG0l2pu1l0PMARnnmr+g6h2Iak0ek7R3LMhSv25n7GKr/rdu4+d/oLIIuPfCpo7AmoV5S4NIBGBUPsPNLF7MV1jnuMrDb+b9kTPkowyr04JYbgXP5XM7RdZWdyYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7260.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(10070799003)(366016)(19092799006)(786006)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0NlRU9kWFNSTTZpZW1vZ3IvOVA1S0x1RGNuVzhtSThkTVhTR29CQUl4NE9h?=
 =?utf-8?B?ejNQMnpSa2dJTi94cGdwTUhXaUZOdi9yT3NvOS9FUU4rN3NXYjZiNlVBOGpq?=
 =?utf-8?B?VUx1ZjB3RE1obUxMdDdjZzFpWDN5bGl1SWo3MkNFYXJrdWhyZStBS1FsVWhX?=
 =?utf-8?B?SkI4cGN4RHAyME02bDBjNGZPYW5oNGxCVjV1OEhMaDEyNUdQSE5Wb255Mito?=
 =?utf-8?B?bERMcUFEN042N2JHbjlWVWdabDdGdTNUUHE1LytVaFFQbko3WWljMG8wSGZT?=
 =?utf-8?B?NVNBTTQzZHltQ0IvdjJaakdaL01vSTZ6WkFuM3RPWHBGVjN2NzVlL2NneWQ4?=
 =?utf-8?B?cWZxSFNsTWVkeWRON2duZUFjZ2duOXlpK0VobUtNYXBpVmNxS0MyYmNxMklu?=
 =?utf-8?B?aVhSMFVNRlhHSUl2NHN1OHVZeFhKdlJPMVRLcUJWa1JWa2c2Wm9Qa2phUnNZ?=
 =?utf-8?B?SHpCSkV0NkVXYWVtSFRhWUJQeTFHZGFzK0NsKzk2VzhTQll2MjdydFlEVDR6?=
 =?utf-8?B?SG5DRXVPRm9Bc2FoVHRFMWgxa1BRNU4ybEFLVTQwWW9uUEF0b244YldUVFZo?=
 =?utf-8?B?VXdsbWNPdXp1NmU5cHAyVmplUHBZZzdIajBjeU56ZWJUQ3JTWEJ4WGhhcldn?=
 =?utf-8?B?RkwrV1A0dkZuNVRrT0NOdTFyVGRpNlRWTGtlWXBOTXd3U0doOUlIVndwdHBh?=
 =?utf-8?B?U1FkekZmMEhLZUNyQy9rYTN2bW5TZ0YxQjBEd0NvQXd1TXR5QVhiVlhqbHZq?=
 =?utf-8?B?R0w5MlBOWmhYVkJxTUtPcUh3NjYzVXRiTFFBakRLTmJndndwRmZvakRMcnRE?=
 =?utf-8?B?UDUzOHBuQkVNRVg3Y3JEZzVqUGg3YnhRdlZ2Uk03SFRNSkc2clJZZ1RTT1J5?=
 =?utf-8?B?SENoNTRxTm4wVVhhckhlM3daUkE4SkU4Y1hHbmQxdEZHc2tYL2hSMU5VZ0lT?=
 =?utf-8?B?bFcxOW1oZnBwTFNIcjRkL2pmYkczbWx3STRvb3VCZDM5NGxqUkFIOTI5Zy93?=
 =?utf-8?B?L21KbjgvTUg2N3ZZYkFVejN0bFFKZFVuTmY1dElOZWlNUCtKWXZEdVQ4L0Vr?=
 =?utf-8?B?ZVVwWWE3N2xPaVYwaFl6K2tQNDFWVFFzU0lwaVJMNU9aTFVoMEU1cHZEUmlI?=
 =?utf-8?B?MkpPZjJCMFVRMEhNMzl2d2s4Njlvc0s1WXBpT3ZFNll4ZENaaG1qc0E3eHc0?=
 =?utf-8?B?M2Y4ekNqbUNBdWRDT2dYY1lyeUFYd25KNXdkRldpOVRpamplOWlmaExqWDFC?=
 =?utf-8?B?bFdxVmp2Z1NDT21MTE10eXpCWis0a2cyNmNEMXgwaFhxZzF2bkhQM2tyRVpM?=
 =?utf-8?B?amkvTm4wV1hZajR5Vi9KREpaa2FucTBrMTMrZjcwbmJycHhsZVdhajJOK2d0?=
 =?utf-8?B?WnN0QnUxZlNSS09sTExTU0xqTlJhaGhDK1Y5VVV5MEwzcUh4ZlZYbjlQTGh3?=
 =?utf-8?B?OFFORTg3MWpFclkzQ0ZyZGl4ek9jRlBmeTJlUHp4dHE0WVFuSzlyRnJjb25m?=
 =?utf-8?B?OCtkd25hbHROYWZsVStpMDRKVTB0YTBtcXVpTzZVbldiT0xDVWJ0MWIzZjhN?=
 =?utf-8?B?b0JzSGRSZHVoSmJ1eXJzMmJKMmRiOXM5UUNBODBTOUVYd1dYOG0vbDZ2WnBE?=
 =?utf-8?B?ZzczNzFBMmYzU1hCWHJ1OUVmOVhlS0pjdDZIMHFuVWdMSGhpQnprekFmbWJv?=
 =?utf-8?B?bktQYXdaQysrZ2c4Qi9LY1AvdXBlYjZDWkh0bkVRaGg3NDA2cU9DdXdEbWN1?=
 =?utf-8?B?cDBiOTBFQkF6Z2txRytRZDJsYmRPSmx5U25wdENtSUtMQndkNVJjWGJ5b3FR?=
 =?utf-8?B?R3JDU0hPdTJWbU43Z0tubC9xZzlQT0ZHbE1NSlVqR3dDMG5BWmxsdW0xTGEy?=
 =?utf-8?B?aHpEOWwzeTdobmZQZkRabWN4QU1YQ0tqTmNDQzZkT05hV3BJUTY3RUZJRERS?=
 =?utf-8?B?RGZURzhIR0lNa2oyaXJadlA0eEdvVnU5TUVPck5JUTVndThWeVJvVCs2S0hx?=
 =?utf-8?B?S0V5amgwTXliNVVOazU5ejJBdWNyeVgzdzJRdHIxb0V6dTZkL0VpUzd5a1I1?=
 =?utf-8?B?cDRzZjlFdUFyK050VlNkbStDZk5EeEptcWQydGNibHhQZWsyV1poazhCMnkz?=
 =?utf-8?B?RGtCeXhTRm9LRXJnSlFtbm1jNHZiSXBKUU9sYVMwWElKdW9hUTNMY2VQenJn?=
 =?utf-8?B?Q1h2YmR1OGltZTk4M1JqQTBsSEJXUHl6N1NQUUJoVGI1KzI5S0NBT3JpNk9y?=
 =?utf-8?B?cllFRUR1d2pxdnZUekJXaU1LMElrOW5GSjVPazN6MjliNXRnRm5KdlA2bE5q?=
 =?utf-8?B?NlZEamhIZUdJbVJCWDNxVnNVbkplUGNwUlJoRkxSbHpUMGRkK0R5Z1FGNmFM?=
 =?utf-8?Q?THbqvGRNAj+EDdAc84voqdvHk1kE+scDQa7wdpiZilHsv?=
X-MS-Exchange-AntiSpam-MessageData-1: /1WBEr3m2w6hcA==
X-OriginatorOrg: sch.bme.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fb6887-fca2-4a64-7bc5-08df04fd0d07
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7260.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:08:20.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 79f0ae63-ef51-49f5-9f51-78a3346e1507
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0ynUpXt6AOcXG1vfCf2Eahx7C0fWuRlcDWwYQgEQEXtu+1ApPPu08YAhEhMsCEI0GK0tXwtkK9hrw7vY/pglA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8514

Hi,

On 8/18/26 13:17, Triet Hoang wrote:
> Check the result of kzalloc_obj() and return -ENOMEM
> when the allocation fails instead of passing a NULL pointer
> to the message initialization helpers, which would return -EINVAL.
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
Just change the -EINVAL to -ENOMEM. This is something which has been 
discussed before [1] as a potential to-do.

[1] 
https://lore.kernel.org/lkml/CACCVKEFXOKhXmF3rcmKQ8-aMFZJLZOf+imsuBYKAQsWptrJG6Q@mail.gmail.com/

On 8/19/26 08:28, Markus Elfring wrote:
 > * How do you think about to increase the application of scope-based 
resource management?

I second this, this old code could use some RAII modernization.

Bence
