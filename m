Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8744AB64;
	Fri, 16 Oct 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154507; cv=fail; b=i0OnDmA+z9YXAz3rHDnraHDaYn/OjFYny30rfSXd1kXoxVgN/cXx1RjJD3LUwfjv9KtzHZc8fZ2sxwcoVLSZD7wGpPTcOBvt4nU1xjQlz0fCbBzdfOy31X7JY1HhaPOuIsYJ9d2DlnfS9+u0m8Xsrh6XTStcc27a/OjxpiKqSbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154507; c=relaxed/simple;
	bh=OsWVET4Ha+1PFpmSdeOsRV3+YZQ0STq8OP/8TF/sleU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LxY/a13ouEAGnJlvolZ+WXblyE63h0hAAt0njypXF2yRQDiu77vjQP4+hB1HI6XDqDa/+UmyyCHNoM5F5yQEw64fmEEopVc9GOMoJxfIVkD5eLUu6zS9Xn1+t7ZTqBusQI/CFyqE7SYcn76AgULqfOXLNn2VV4zdMyFR6ymnOpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lHtTO3vI; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lHtTO3vI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnbl+fCs5QkFXj3AadmpwNMStjILaagl7ZMhJKASKmqZsUHIyCu6s+bKvvnVtQQf+Z/TLc0Ab2Wc5N7JvSKzKkVr+sEpcUAxX94Uui24kv8PY2QeE1+CWIpCyQcbx5Db8Tkg12LwOy5sLmmJeEidVR6CzKVMhCvCTOJ+xbmBRe13LAutioD/wlFh9usKQGdoHS0mxWdP9B5Ob1UoJpfEckwLiCK9wBFeeaosXFZ2CQGhI3bPXD/aOXUlE7fIcWKPh8yi278PG0fty7qkvR94efHz34zEPjhMJPGSWVsPnZ/TjjuF2HS8m+9fwK5cjd8KXn/8WN/F6rCHf+c2XB/seQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2WIOLDy/ac2UFByyTqFIOUazdQqld+ldKg9qP+/ODg=;
 b=x9lH5TUWaeGgdewvejAHjYdKOLYtBde3JxU0SPBJPxEHHOFajVMORxNue2DiPnC/9Nfky9DhxllxJnwpv/IHKpUwD5pE7KeHVCkD7l0BlTSCNPtbEfWK4ntJWzw4c41U8eehZSWSwnYxX6/f/G/C6BCHEwjcQ9+1/FGtIuuPTcUzRkXHKgkMz+u1lumXUabk5QKWTCp/OBSz7k+mh4QoyKDiWFyF1+6mvqY9zY1KenJYqqAKOvx9CicM1fE1KXZ2jfvSnZ8LRfQkmxBy8IMzBVKH2sCRpvG3kRVpykwoKEmxrqwNQ8YJ7zd+7CqdYx/wMwXu7prI0gNyZKcgBRbsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2WIOLDy/ac2UFByyTqFIOUazdQqld+ldKg9qP+/ODg=;
 b=lHtTO3vICvhxCgJukS7XgRIjPe5EjQADS45PmVGfj1LXmXy2BRmkEwOJRdZRKTJe4SvbmmuxsyCCHsB3K8tdmg2CV1UNXgtUGabgXuPXDdol3DIYMWThZV6jorsRuXk5TrgMGT16+OlFJu7qJ4+yhJDffwB+cXd9hEQm9X2gbAA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 12:41:43 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 12:41:42 +0000
Message-ID: <1d3a38fe-0d67-4911-bd4a-6d101ba83405@amd.com>
Date: Fri, 16 Oct 2026 14:41:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] i2c: i2c-xiic: fix clearing of bnb irq
To: Thilo Zirnstein <thi.zirnstein@gmail.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 "Dubakula, Venkatesh" <venkatesh.dubakula@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20261015081127.1566244-1-thi.zirnstein@gmail.com>
 <20261015081127.1566244-2-thi.zirnstein@gmail.com>
 <atFf1ZbNi29Lbdbb@zenone.zhora.eu> <atH2njvkxHjq_75E@thi-server.fritz.box>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <atH2njvkxHjq_75E@thi-server.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfbc60c-4017-42a7-cdc6-08df2b82d4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|10067099003|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UgXJBmqFOUfYggMCOXEjE8Tx+YeO59BEx5SXHwNhYi+LwZaR6Li/PCFg+LwbMdu0N/QMvDVOW0khLPowC0ggn+zHldzJFOtMa847VyQ7WNC7YQD/WPzkt0sX2U78FehzCZlE+N5CtqShpeZl9zq6XDA6GOCkXOblB6YXH/11tio4OfyAfC/CRrXgxYA/Y/f+zmzc2JM+RoNk8+uBHIIwcHIho8AjsY6+ZUxn2OkiUA/eurluc9Dd3hmLqZflWfiJvgc/QxoFIAyZ512k6O6x6UUw9IerHLnIqnde3DN3GLNtJEBo6Mw8MYz3rjzfvq9f/cCbv5uljkMMaRg8TnoEDvz5mqNgBYWZx/Sw5eu+QwI/fSFVhigygLlO7RLXzMdvk+byzwOjKA8iI7kM3l4vrWyoBQJrCMh17+4P6Kp9OVjDN+iYBK9wvkytXkFIs+ZpZkRidOMTQiJO3hv09OX7Bo/Hqc8Kb0p+totpxmxojyoZqS7+6R2bVFRj+GMNiKvxTw+vun5a3NUk8507ZVDw8c4dqfueF2rnFknLcgYmAwo7VjIqvVslp+JE5/D7jHbBn6USwjgfaFiessLNaUJ0CnZy2KhMRN/x4wge5mkVdZg4sDW1x0sbcEQIFF8FTXb+htT+RUtnULfkAaxW8xBYuM+tXD2WmBeRkxmV0cwK/ks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z01JNW96TVVzZldJTlRIWk5JYllTdHRNZU01RWx5VHJyU3BRaXdjck05TXNj?=
 =?utf-8?B?QjhYZjV1RFBEZ0dma0JOdWRHK0NRN3ZiYVhTSWNpVEZ2cmxTWDRuUDRwNC9z?=
 =?utf-8?B?US9xZ2o1NHczUW9jSWxaNGRVQ3BrdHJiVFYxbGR1TzVPalV0dUhaNGxReTRC?=
 =?utf-8?B?RlhkdWZEM2h1QXZhemFxeHlucFg0UFBaQzFISEZmaEhHU0pRbnNUZHNkQmtQ?=
 =?utf-8?B?Mk1VU1k2bm9ENnFRZGIzWkFDZTQrWEMwR3JiT1ZuWC82V3craklaR3JMK0Rj?=
 =?utf-8?B?QnIwcTQ2c0FrcVhTSmFZNncweGhKNUxxRjl2QUkvaGVkN2VSWWZvcEZiUkJ0?=
 =?utf-8?B?SC9Nc1A5enNvWnNoZ2s4emo3Z2MvQmd4SVppY3d5OWtRR3l3Y2ljQ2pwR3NL?=
 =?utf-8?B?bmU4NGFkQ0JkZzNDQTIyY3gzM3ZrT255cVlidFBiNTBNRGhlbFpaNC82RGVj?=
 =?utf-8?B?OE5CL0srdXNiNWg2MzJKZUJXc2hCNVJXR2ZsdE1Dalc4M3BRbERLK2paYjhI?=
 =?utf-8?B?RlhGYnVrR1B6bk5uQmIwZ3hqaDFpREFVV2YrY3JadDc1VGdROVVtRlJEMzVt?=
 =?utf-8?B?eDlmWnd5Unp6UGh6WVJSN0FKbk5YYnZ4dmR3cGlySXVRMUI3cys3NEhia29h?=
 =?utf-8?B?N0l3M0UrdDl2QlgrL2xZM3JHUUdNRHNHV2loalNuaVdsek5rQ2QySDJxbkZ0?=
 =?utf-8?B?aFZtcWtVYUNhZjVNQzlaY0tNQ2JSTmI2bk91SGtxZUFzb0t6b0VrVmsxNlMv?=
 =?utf-8?B?eExpenlTS3Y4TFpFbGM5K3dJK2dDR3dobGYycTJIQ21HcjdnQmxuNDRUV3Y5?=
 =?utf-8?B?VnIxY3NRclBYcnJzdGpDVHBrd2h0ZlFIR2NxL003cXdwdkxlRWNmYW5vNElI?=
 =?utf-8?B?ZTdlbkd1V0prSFVDc1VKTDFnWUN3WUhjOERLbVhwcjlMSnVGaTNyV2I2OHZj?=
 =?utf-8?B?bzd6cEpiakllQXRKUTdjK01OSzh2aXo3cVR1K05TKzI2Y2FDSldlKzVBZDdw?=
 =?utf-8?B?SnJOOXYybVNrVzUzRnFBYWk3clh4ZkpqQXpPNHhmdWNxQnlVSEM5My9sOEdj?=
 =?utf-8?B?MytnQkRidk5IRncvVjgwTzd3dFk1dTZKQmw0eEZWNG9SaE04dWJRdEhVSURO?=
 =?utf-8?B?SHZPdlhRSnMybTRaU3FYRDlFY2NVK1ZrTnFoVXVNdXgwVWg2M1dUSnVOVkxw?=
 =?utf-8?B?K1pPZUhKazF3TmoyMDRwTDRKMW9NdGlKM1BFRThHc1R0YUs1U1BjUytTV0R3?=
 =?utf-8?B?ZFpNTEQwVE9BTWJ1bzhKanQyamsrWFQ2SE0xZUs5aWNQVWJyRENuNnNOWHNC?=
 =?utf-8?B?T3lmYjlLMDRqOXVDOWQveXdlb04rYVRXSGRiL21FZjJEWUtRRER2Zm84eXZo?=
 =?utf-8?B?ekQvMTR6T0NoeEU5SUlRZW9NakllU0tQZlQxTmtJNEN6VEprejZuYUdOUDBm?=
 =?utf-8?B?MklEWFRhWGYyMEJTb0U2dDgwa05uNnR2dXZqV2thSUMwYkNaWVN0N1prZmtO?=
 =?utf-8?B?T0NxdkhjWnMrcDJGRlB2NzliTmdxM01BbDNtVUdaMFV2cC9sVEhUeE4wcUpV?=
 =?utf-8?B?ZzdkQjhZT1ZZSWFkTlVrRGp4NzJwWXFtZ2IzUEo0bi94NW1Ed2xRR05tTFI4?=
 =?utf-8?B?eXpDS0ZIUldWTUdCVkpUTHZ4L2xqYzZ3OE4wM1dNT0dGSElTMjQxbmQ0TzBX?=
 =?utf-8?B?bEQrb1Q3Q0VPK2lLenpKTTlwMWpaR1FYV0pKWS9BT1BaS2ZZT2hsdmp5Ylhn?=
 =?utf-8?B?RVhqWG5FWWRmc3ZmTlZ5Rk1DOEp0bjFlOE9SaVAxMEoxYkZrRWxYcXVhWkt1?=
 =?utf-8?B?SjZXT2VXT2xwSTlqcVBndHU3clQ2dUtId0p4dE9Qc1ArU1ozaCtLdWZzSHl5?=
 =?utf-8?B?dDErQWwxcVNzK2RDblh4Ry9VYzVQYitVaytKVE9HZVpTZDRsb2RYUWdOMDJ6?=
 =?utf-8?B?Y20zV2x6Vys3djZCemhCbFUwNzBGVWk3c3ZGcUNxNzRYYyszRWVvYWNYbi9M?=
 =?utf-8?B?OHhYR2lBbEpEQnlkTEpXeU5PejMvejdqcWhySlgrWTZFcjRRTngydFY1QkR1?=
 =?utf-8?B?am1SUkZGV2w0RzdrbTZLak5jNGhsRjJKaHZ6b3hmYkZCTXpYREU0YmVXa1Vi?=
 =?utf-8?B?UW9nOEs0LytJTGVSM0ROQjlsaG8yQ1VQRW82QzhBazNwd29oRGh6RkN2T2dR?=
 =?utf-8?B?VFZ1VXdOd0RDM3lzek9qdXF3OXZQTmhlRGVxU2hEYUV3YXprZ2JhVlBOMlVq?=
 =?utf-8?B?YjBrblVKMC9UWDUwRnJVSFVGcU1mS1dlN1RCbnFDNFBPZi9TNWhUb2oxZ2ZI?=
 =?utf-8?B?U0YyM3VTUW1aa0wza3YzRnFQY1V5OHhVNkpuSjZhS1JDQ0I4TzY5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfbc60c-4017-42a7-cdc6-08df2b82d4a9
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 12:41:42.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ELMNo7ppl4h0iWt9ISerM6It98Vs8MEv9p9CbRiOz2IVVZ2PZ93IR8FxC5husJx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107

+Shubhrajyoti, Venkatesh

On 10/16/26 12:04, Thilo Zirnstein wrote:
> Hi Andi,
> 
> Thanks for your review and feedback.
> 
> On Fri, Oct 16, 2026 at 01:51:35AM +0200, Andi Shyti wrote:
>> Hi Thilo,
>>
>> On Thu, Oct 15, 2026 at 10:11:27AM +0200, Thilo Zirnstein wrote:
>>> Add a function for clearing the bnb bit,
>>> It waits for all preconditions before clearing the bnb bit or times out.
>>>
>>> Tested on Zynqmp dev board with some custom logic.
>>> Tested-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
>>>
>>
>> Please, don't leave blank lines between tags. Moreover in this
>> case I don't need your Tested-by, I believe you tested your patch
>> before sending.
> 
> Ack
> 
>>
>>> Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
>>
>> I'd need here an ack from Michal.
> 
> Ok, but this is nothing i can steer somehow - right ?

Just give us some time to look at it.

Shubhrajyoti: Can you please look at the patch?

Venkatesh: Can you please test it on boards?

Thanks,
Michal
