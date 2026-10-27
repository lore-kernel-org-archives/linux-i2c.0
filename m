Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793071130;
	b=hOcfLh8ylIV8WRA4/PQKyCWhBO34SPcSJOI9VajreW5p2zam3bmIbHcSWpjVaYKwnFGX
	 b9HGgJSK6JFbRewY0gqY5P0E84QB14bD16099Zt3IziNpjaZXTge+RSWzioDeuzbxhidx
	 SXWlV3SiFLXJaeZpu7bQOIJzkXz98KhED/oBLDolS+r+A37ONUhdY8AJLvpGN4mn1LB3L
	 QeiXL5jaPxKMnu6wJw4X2x6+MpI5JXO6xYAf3w/4DQ0W8/lA6EyhM1rKVOwvtH+lqT2HK
	 f/230COSoItFOhwGEE2PdGQde1rIQY98sZN9mLAr0hdCUojoyFc1KVWw0zJPvCgvT3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071130;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=M9GETrwyT1aV7g19g9EfeatfmGwyZ0WdB7cy+9tz8ck=;
	b=ouK0D2tebaZQSc5e46a48Gkw68kSudD7IJtLdGiq4EJ1pCLpGtPeJyzW71UUhRPYEndd
	 rsx5KhMameAScUAWKD7KbUT5VXe+sAintkVjMVkAcgIaOgfJDDUf8lNSc6Va8A1EHSwMN
	 sRzGz6flnrsJCnV2as698PgcuXJr7fcWrL2hqtePvQbVcJL9ddeTHeItkA7JOvJ8s0r57
	 6C1ujtBGhvVFkB7i5D+f1uRNdVFqRJfmeGZA8f3zlQctN9o6Qpb0Zyqco9iOPZ8OEWp5L
	 EoVJCCiCU3N4YBAG8H5aLq+2LFLI3Hh9cPklz4dqSedFrO8Zp8NdUuAjENSBerKnK8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b="h/gCXJyr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.139
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022139.outbound.protection.outlook.com [52.101.126.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1321606A31A;
	Tue, 27 Oct 2026 03:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1321606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=h/gCXJyr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1vTagZWhOX2W+CNCAP/tZqLCU0CuMN9Kll1MZBcIUEiQOut0eht/tyJ7aR5p51RNkYkn4IK+TXHAmss8QRV58/jzxXQDcjZ5JtT7k19wdLusXoWCAPGwA4uJcXSz4McJhQF2THsBFaoqTm3pZLJqAvHDoYStLs0PGjqGgPO2w6fLuJFfmM9WVAQe6mkVbXamobfDezqmEoONt4T1JHNlK/OXEfopSPaKp6ieDkX56+hPIq9PxFdE0ZeUSgtD5ACszckK2LsObUuxxMkBpAh9ynurQGPxDiAU45OTiSpk+KVGksWyRGHEfdim/0PyTDJHQd1U8YMkNImrGEC+e5o7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9GETrwyT1aV7g19g9EfeatfmGwyZ0WdB7cy+9tz8ck=;
 b=KFWRlPbpBjOlC4lUYV50GazrgCkEhXNen3NMowHg/8I5sG1lgV78o4i5k2kSBqD407SDu7L6H4F9Wr8+W8+VRT7OQSZrvINNh6hgvFGeesUu7bAulWjVV068hoG3aJCAHBaO3aER5hfSUNGeGTtMVGAxkem2VdKKVIncSwWxp4tOmDBJ+Wf+odls35vuf04iNfb5CK4YwGV0hZ8sNjQ4lfD45unvUgb5/2KrfAsImdKilW+dFGRZTSpqHpl2RigPQG9eW+l7B2LiahgSifBfzGV/ZL3xch9OfBsYj9i2s/rPdoKNE6emT2tQjF6Y2ugvXAsak3VvrqrRA9tp1MdC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9GETrwyT1aV7g19g9EfeatfmGwyZ0WdB7cy+9tz8ck=;
 b=h/gCXJyrS0j0n5JVbpufufQpuQznkX73UdfX9mlubLBXT7UERo1ZMUee9vtQUDHvGXn29TLeRuZC6uZElg/LdWrcDTXSix6cf6sGmQu8XjwgYnHcQEMzmXTdW3/ahnWNHyXiYPVjH1T6Pb37TQ6Cy83IakWZKajXiJBWr/MLgXH4wL0mznfHcY6ioE/hvye83eN6nwLtq9vC5CxBrOQERcEZgy0y02+tpqVpr4uiAWN6PCdkhwLI9O1doQLq/E3iS1ikCYJLZgSp+7UKCQioOgaW7r7/dd6zN+fEnGRwVhKXNsAN0qV04Rd3yHIHLIw82bfnmsmdGwRkfPqISad76Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7526.apcprd03.prod.outlook.com (2603:1096:820:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 03:18:46 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 03:18:46 +0000
Message-ID: <7bd4a0ff-7e28-4a43-b17d-6d92697b127f@amlogic.com>
Date: Tue, 27 Oct 2026 11:18:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Junyi Zhao <junyi.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>,
 Xianwei Zhao <xianwei.zhaol@amlogic.com>, LKML <linux-kernel@vger.kernel.org>
References: <20261022-a9-i2c-v2-2-45e3cef175bf@amlogic.com>
 <7015dc55-5f19-4a6a-89aa-d11da0190b7e@web.de>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <7015dc55-5f19-4a6a-89aa-d11da0190b7e@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::9) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: a50bb1ce-1c21-4a92-cc9f-08df33d9034e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|261026121527099003|4143699003|11063799006|261009223027099003|261021121427099003|261022075727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lrgHNkyL3npVqFiy91+qhivirzAQirX7X1rp2mqU5tFLBRBUADOrvC287FGrQ9eX3GQ4raLskVQIcGWZW1Y3GXabqD9FmKyu67xVWkIbEH4k5GPQqcpu81UiF4TM+mhwCsr4gJUft//U/Rv+DcSiu0abPMVn8bnZ2nKiKaZ/+1ZJ0rXps1lMegC9X8zhhIDkda3eSaYIhIOMO9K3rKd8cR/3Q7bdZlA7oz9GBvqWuEXL7SPnkqaromWn+tXArmjiRxK8nddLrbA1c4ii07ZoTfBjw535AABExMNMXr50KwUYM8eU0o0oMNRpNd36r/bJTChaqIdClYgozblHZ8oH2uwFplIAXzAaT7kKztDyBA8rPFJQdi2+xz9lpgZCl9Oxfv3f7RElSfCiO543xtATVKexPZucem9lXSaWV3ihMUkQqZnwOvA8fRvnAju21drPl53DpZJOAUxaiWA7raI1ZrxK7wbkX7yIJIddz3zH024PmI3R0Fa7GMQBdZI6+Sjb31TxHtb6Dn9hjocLD+nCVs8IuVKvJjMkezcJvTbq2/qQeJG5SMtF2EHr29C+RB18XBNeUEcnB+8cLep7Z4GO3jNMhafREARgjFdJ89cpVZG+TkJ/8Sifnr71GkkYkBxzXjXzTIBYwlKWpllPspWEW9/+ABJU58sNwcUzRKWe/Dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(261026121527099003)(4143699003)(11063799006)(261009223027099003)(261021121427099003)(261022075727099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkRiRG9tblEvSExrNi8zSk1PanVXWlhjbUFkT1l3R2pieGc3OEJzaXowcTIw?=
 =?utf-8?B?aGkzUktwZEFsTnNycDZRQzg0bUptUnFYaHk5MEZ6WDdaY0h5UmMrV1A0Q2pR?=
 =?utf-8?B?a2xnVFdvdXJCak1OajNPYVNWajRsZkNxcGlpUDE2YVB0U1ZCalNqdFlxS250?=
 =?utf-8?B?cUh6YW9uODg0eC82THZ5T28zQXVicUdvZ0N5REVobU44VndvMmFNSlNpSUJu?=
 =?utf-8?B?Z3hSdWlYS1NaL2JDRGlWV0hSdzhyazNGdk9nczRsQUNxR25XZ2srSWJyK05m?=
 =?utf-8?B?MFhndXg5YWZwc0ZQRHZZOHZvNjd4Si9sNmdLeG90OG82NFVrNkZLN21CUUpN?=
 =?utf-8?B?Y2ZUTVV0VXZaeS9Jb0F1UXNOY0FjUk5GYmhHd0hwbjdYVkczWktlSE85THk2?=
 =?utf-8?B?ZENDWU51ZHJSOEF0amg0QTNGWk0vYkxGS05KYm9Oa0Nqajh2ck9xU3RjV2Vw?=
 =?utf-8?B?MjFvTDQwbUYySzNPYVlKT29tNUh1SzQrRTdSOGtvbk5YVURLT2xnNFRZaFh0?=
 =?utf-8?B?aFN3THpsQ3VLTmhYRHlCaXFEelZic3VYeUUwQ0hWM1dpc1l0eDM0ZWNsd1Rq?=
 =?utf-8?B?N0NrZStSSnptTmhRVUwrTktmQWVSaTkzSWRVM2ZpKytjZkxHRGxQSkZ1bExw?=
 =?utf-8?B?WHp2YUhOeWVGdVFuV3l2WXFIUTdQZzEwZk5YbXlyQmNWMk92OVVuNEt2VlBP?=
 =?utf-8?B?RkVWMkVTMm4yUUppNHpuRkRJcVZOS2kyZm5EVWVtT2hoZXY1OWhwdGdaM001?=
 =?utf-8?B?WnlYaTFFeHIwUm16S0VCd3F4NnRBdE8yVXQ1YmVjSFVobk1uVFdPKzNPSk5p?=
 =?utf-8?B?VGFST2tvTkd5M29rTXM4NUJXTzYwZklTVit3THpaR3Jwd2hPRkNNUW1rc0Y3?=
 =?utf-8?B?ZDF1bjVuNHo3cFJRUUxtWmtHYklwWGJ4TUlrKzVncjFnc0RDNCszNkVDU2lp?=
 =?utf-8?B?ZzZHVUQrLzJpZUJ0Y3ZvamlSb2lUTE1aY2lsbXh0M2NyUnVJSXNRanFjNGNM?=
 =?utf-8?B?Y0x6cCszRFRzK2o0bTJ5QnU1Z3hFelRHMjBUZDF2Z2ZqU2dJSFZLQ1NUdk00?=
 =?utf-8?B?eXg1YmRhbDQrWHNmMUpocHlVYTB1Vi9KMnhvRmU5N2hFemtISGs0ZG1mRy9Y?=
 =?utf-8?B?NTBOTURLRFdxRUl2d2dmdjk5N1hxK1hTME4zSlNFV3FESFN6a2FRUHR4dGoy?=
 =?utf-8?B?Y24zcmM1d2g1SVdTN3Z4WTNWVEdWVEFZcDZLVWl5U1BTM0xmTlVWNTJFNE1I?=
 =?utf-8?B?YkdwdG1KbVNERmY5Y1AvdFJNKzIweHNiZkJHeGRXZXlaT3lpZDJzQjRZUmpI?=
 =?utf-8?B?UCtsa0FXVEV4Ri9DbnhQbEc4YXRFNnpEOUkzUGx4RmM4SHEreHdHcWdjZ0hl?=
 =?utf-8?B?WTNoQVJmRm1UbUVwMndnV3JWQ1dxOVltMUtJWi9TQ0xVUm1KQU9ldmJlMUpT?=
 =?utf-8?B?VnVFeHF2RHUyMTE0dVdudGR2WHc0T1BGUFhjYS9iRXQ5ZG1PeE52Q051T3RC?=
 =?utf-8?B?eUNGN0ZIeEV4QUpKRE9ERVo5Q0x5MW8ydFV5eE9DbGFNN2dnWm5EUnRRcC9S?=
 =?utf-8?B?UHhwZ0NwZytVREpNVEZsUVhBMG9NN2NGTyttZFM4NU0rU0xYUGFqcWdDU2NY?=
 =?utf-8?B?bUdGTzF2b1JMN2JWU1I3QzhhME5Ua3QxRnhEQnc2RTJhTW01QUlyMmc1UmZw?=
 =?utf-8?B?dndlOUhVVjRLeStURG54MnpOdTcxVURrSDFjYVRXTVhhM1dvbGxsSDA5RDRy?=
 =?utf-8?B?OWo2dkJ0R01iR0tOUnNOUmp4bFBITjFMQ3MvZ3o3ZGdQdkJtKy9vanBhd2JO?=
 =?utf-8?B?bjlzWFNZRWdwTlRnbVlGMU9KZHVsZWxSVmREOVJaaEJ4M2FRa3JaUzhRMEdH?=
 =?utf-8?B?VW1xK3VTaTVZUTJEZWd6dW0vdGUxNC9lQm16Q3BWY1l4K0J4c1M4OUFjeW00?=
 =?utf-8?B?RHAzL3VkVEFvQVFLUVZZcmVBd1IyV1RPeUxsUVhtSmpUd3BtdE1CSm55aE5Q?=
 =?utf-8?B?Z2JLRHRUV3ZOZ3p5MnpQQnpoSVFwQlJPVldjaTlnRXFkanBKUDNpNjJjNUwy?=
 =?utf-8?B?NlJTYit6YS8xY1NaNkdhVkcwN01SZlo0ekQ4WW12eWNBMHpYTmRtbkR0TkFt?=
 =?utf-8?B?R0Z4cTVRTGJxZEVDMTVFOXBsUTNhRDJCTWhySnJ2U0xMZWp3eWUvZHY1aUxR?=
 =?utf-8?B?blphTVo5SDVvVU5NaHFiZFVMdE9yeVF3bWFocU10MXhmTGR4WDhOU1Z3U3ov?=
 =?utf-8?B?SU9qMW16bEw4S2taUnFabGhnZlFKblVoK1VsaG5QLzlUNlp0YnNFaTIyaWZP?=
 =?utf-8?B?Mlljb0NmRG5lVmJ3aC9LRWdkVUlOa0I5dXpRK2pCZVJHQmFZVGxNUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50bb1ce-1c21-4a92-cc9f-08df33d9034e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 03:18:46.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UXcDJWlSp29c6+Er+7WS0ye9nvCK70IRCwLlE3/oH37iVbLF4/Qti4s94jRWeyZsmbUeSN+PGnIktyxLyumxnXoJGJCG+0hPlSJ/v8E2Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7526

Hi Markus,
    Thanks for your review.

On 2026/10/27 01:28, Markus Elfring wrote:
> …
>> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
>> @@ -0,0 +1,469 @@
> …
> 
> How do you think about to avoid a bit of duplicate source code?
> 
This one has a different IP from the existing controller. They only 
share some similarities in register access, and most other logics are 
incompatible. Therefore, it is not considered for the time being.
>  > …
>> +static void aml_i2c_prepare_xfer(struct aml_i2c *i2c, enum fifo_fill_mode mode)
>> +{
> …
>> +     if (mode == A9_FIFO_FILL_FULL)
>> +             i2c->count = min(i2c->msg->len - i2c->pos, A9_I2C_FIFO_DEPTH);
>> +     else
>> +             i2c->count = min(i2c->msg->len - i2c->pos, A9_I2C_HALF_FIFO);
> …
> 
> +       i2c->count = min(i2c->msg->len - i2c->pos,
> +                        (mode == A9_FIFO_FILL_FULL ? A9_I2C_FIFO_DEPTH : A9_I2C_HALF_FIFO));
> 
> 

Will do.

> …
>> +static int aml_i2c_xfer_msg(struct aml_i2c *i2c, struct i2c_msg *msg, bool last)
>> +{
> …
>> +     if (last)
>> +             aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, 0);
>> +     else
>> +             aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, BUS_NO_STOP);
> …
> 
> +       aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, (last ? 0 : BUS_NO_STOP));
> 

Will do.

> 
> Regards,
> Markus
