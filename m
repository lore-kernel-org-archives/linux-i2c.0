Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFA280327;
	Wed, 28 Jan 2026 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611147; cv=fail; b=QDUyrXKNGdhC0FgyFIW5kQwvRDHcu8ag00Ht20yJYk41mzz/PaHuGXDPQj/JrSMw0xjOuffwZixNVP5D2VocvdlXHql7xx7YkGJDg4KD1Rpc/HtMsMl5y5+cSClIYRaGz1PerdPXzypygy4UANB9e4vf6es0ys5VWWJrYts0faY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611147; c=relaxed/simple;
	bh=BRk+JvyZRgZA47ZiDUNzyKUqM/J3xLqsuPOwQSo0dSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m05y6YkA8VPuVm4gh0pKFMkdrmwTwp+ZiXCQ960FcYBpD4ZySWbiJxEMFsyluvtIru/xl4VCe+cxxLCZMkiAugSQX2NTYY2U0G2jz1quxLMfAVXqqixkNLaOqcy488FMHBAP4An/9L2rhwb/e+a6+rS33RLvnA5ZJLv/glXLhl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yG3BuR/u; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yG3BuR/u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf1MRm1/lxXK/SliBOk7nd9zM+HlwZdRERRkikQHgVbISy2MLolxXLJU8HyYk1+tNJJ5MFRwJv1VZrTU5fR1d76rYQnJjeGHonY9awlO3Np6FYGYiUmwWCQLj0ZPw8HNGh1tknWkT+8ue1AJCe/3Ied3tAal78jR6berOuEO3Dpi/01xrz3TDDDiZpySXmiHIX5ZnWqitItaAktshiBmaw1eq+b5yWs+MjAOOSf41TxpNUqYjl6n9TBls5TxbQhfmHlwj5srFVK9uHLsOlX2dwDJ2j4yk6o/M9ft5HkvrQQVRAeOGVbRTXLl8UDDDIk5sXqnecTM0fOmxH72uwbNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3A9m9foJ4p5J4Qbvpqqp/0oZISamhQQhQWVdvyFXKs=;
 b=ZsJZU4EDGmPjsJMSQ8Vc5RaMu3tpTCwKbJdhlDmSeMLoMppJY38FZsVPb8dmbdorjVPpUGNLgdoYCIDIx1inA8eZCccaCSfiz4+9bNlTr/GDrcXjH/WoVgQkuRksNnbGyvCaXhZdWkRDrWrDFs73+2Xqnunimb3e0JMqydg/fqbekCQuVGUcXYeB7K8PMX+5FcVPLOya2h8PWor9X36HcVLvWBH6Pid0b8CMFtG5QR3cpy8H/UOQQ0ne856zur4BvbSDBZ1vDPf4d5qp3o9FNrhdq+SvPsT8q0ARVsnGXt2DtP/eodcBoxikpwDBtFTJ/DZIOmRqOu7uLboiTkJ66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3A9m9foJ4p5J4Qbvpqqp/0oZISamhQQhQWVdvyFXKs=;
 b=yG3BuR/upCrow1Se4PnbCAEbS9XSLj3q6+0S0ru1IkCj3n87zaIkdpFqc/qaU3zzJRo7QIEX3r1cnputB9y4Nzjg+mP3hzc5A1cGArtfB/27kHddZqLToLCE2W0dQ7CACPC6ew/RD11Kx98O8rKeRnE1/FyHKjA8SKYRzxTvTm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 14:39:00 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 14:39:00 +0000
Message-ID: <0e04d444-56a1-4c05-bb18-4e479110d5fa@amd.com>
Date: Wed, 28 Jan 2026 15:38:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, info@mocean-labs.com,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
 <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
 <66c7435c-a936-413e-a016-c860d448c971@amd.com>
 <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: c818b503-031c-4e3e-4d56-08de5e7af984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXNoM1FkR3dmbkt4NWNVVTh5KzlzMTNqbHFvMlJVWktkeXk2bmVlOUVuR01o?=
 =?utf-8?B?dmhkL0lQTDVhTlBmU09EdkN0V1hUTnVWSXluQ3RnbG8zTFlSbU1jb3R6UEVi?=
 =?utf-8?B?WXlXclkvbHhrWEFVSTVzQk9wWEtNazlDdy9WNk1za2JPcXdrT3VseHpzV0l1?=
 =?utf-8?B?Rk1TNHZDUXEybnNDZDVMSmYzUWtnckpkUVpNekx4OGZlTnZlS3FRaExnK3NQ?=
 =?utf-8?B?UVBsd3JkOHJPaVZjaENORXlnclhDcEthM0h2SVE5bittZWlCaWE3ckR0bFFM?=
 =?utf-8?B?bWt3dWw2R1RKSnlSalcxdlZIc2VMWTIxWVpwaElwQWdCbk1XZjFLck9PTll6?=
 =?utf-8?B?akZJNTZxTzFhRkVhV0RrQ2FPZWVqdjFTSm15OU1NekJuRlNZZ0xTb2JUbWgz?=
 =?utf-8?B?c3VvTnZVL2t6UVlmeHE4eW1ML3BaTXZEVzhRbVdrZTVvQU1ncjFjMys0KzNV?=
 =?utf-8?B?RHNlMjBGSjU0S3RWWWRhTXp2SzU3S3dMa1Z4d2Y2bStGZ2JhZ2Q2ZExsSGtt?=
 =?utf-8?B?L012TzNtNUpXWTdjNzR5a09QVjZ3OTdLWGVUb09DRkxNNmdYcURocDZ3U1Zj?=
 =?utf-8?B?VWsyb2xKTzBjd1hpYVhXM1R6UW1QN2hGV1R0YkxRNUxyVmFXUG1xQ0FRbE5M?=
 =?utf-8?B?bXhXbkVIQjM2bVczSVlieUtvTWw4K3JrUVpsaXU4YnJwazNNMG5ib3RrTlRB?=
 =?utf-8?B?Rng2MldESzRzVThCWTZOY2NUWFAzOVRudHk5VCtXNjBaYjNMSjd6U2s5ZlRa?=
 =?utf-8?B?cmYvbkNrWTNWQ2NOSW01b2dyYmV3c2RsMlNSRzdNU2pIRDNyQlJrTEtWSUlk?=
 =?utf-8?B?ckZ3OEpBZHBZWFJTYmZoVXdKWTdFOUdXaHBWK0ZiVEpuU3lrbHZraDYrVmJT?=
 =?utf-8?B?UHZTRVpOMzhyOVFyd0lFNE9ZOERzb1duUFdNZ1ZPRmNwYms1ZXlDeUFScGdM?=
 =?utf-8?B?RCs1Yi84Zzh6YVZTYk1ieXZRUU1RbHhieEsvYVZ0TUQ3MFB4TTVXazRSeVUr?=
 =?utf-8?B?TjZnQ2JwaWFvUmRmNHJ2Q0dsbm5vL3kxZ0psMURSeDh0VDJNS3RkUldjdzNO?=
 =?utf-8?B?RU91S3RnZEdGYkxzUUtaR3lNUyt3amFoVUt2MlU4QmxTQ0dIa0xhdGY3RDVX?=
 =?utf-8?B?Rnp2TUt0NzZEZklBQUpJYnVaR25wM0NJMGhpcUNCL25OOE5XSHZHaEFpcThK?=
 =?utf-8?B?RjFPMmRLRFNnTnZlNUdjRkIza3RvMkFjWFJ5Qy8zOE9Ocm1QY1BGZ1NpbkFm?=
 =?utf-8?B?UzY1QU9lMjBQVVIva204WXVjQjRYQVg0bHhOTkdabCtxNXhIOXJSemhxWmVK?=
 =?utf-8?B?RkpES2ZHWkpNamhyRi9rWGRwQmJaZ2ZTTnRhZnh1ZFJUc1daZHhhSGZPQyt4?=
 =?utf-8?B?dEZnellOS1l0TEdBYU16TzRDajNYdzdMSHNqOWxPQ0V6ZEZyVk10ZExDMTdQ?=
 =?utf-8?B?aXJaa2gybVNpaUtMa2U0cktja0NlcGJoU29zdytPVTQ0bFVXSlJBbm5rMHlU?=
 =?utf-8?B?OElpZUExMVl5N0tTMkRWL2J1Qy9OK0VCcktSQXUycE9DMVo3OUlXVnN4eG11?=
 =?utf-8?B?M1hXVVhraVl0UExFamFRVlYyb0RBWUxTb3RkVU52cWFwS0x2OTYxOEl0cnV6?=
 =?utf-8?B?Y2RRaC9ldWkvc21NQUNyRmZiaklFWkY4RDZydmFObS9pNFA5cjNjTWtjVDNl?=
 =?utf-8?B?RW42UFlacGI1bk1zMi9CN1VDVm5mUC9iNVBCTkN4TzFQU25TVjVhMFRSZUVF?=
 =?utf-8?B?Z1NHUVlYVjVGQnhjVDZVY3liMDBqTDA5SWZZMm8rWDByMDZNYjl2ZTB3eWtB?=
 =?utf-8?B?M3BvMHJSZWN6d0JHNVZmTmcyS2NuQ2ZHd0dVODhFVWNDanZ2blZFYzdUM3pk?=
 =?utf-8?B?RUpETWh4dzBEeVFhSVc4SGQ2ZE1SSHcvblUxK2dpbUpIZUg0eFNVZWJybUV2?=
 =?utf-8?B?NDNjcHdDQitUV3I2dlkvSGt2TUgrdVBjNXR1OER5RnN5dUFhd2FFUVBjdWZ3?=
 =?utf-8?B?MURuMXRhOXhTYXZ5Y1YyTVgveUc0OTV2U25UdldranRGc2tNcXN6NUk0bVFZ?=
 =?utf-8?B?aGlLTEFENVUrVS9pSnhnT295U3BsanVTdDFSOVBMRGxla1lOMGJGNlBuSmhY?=
 =?utf-8?Q?8NR0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6939.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUJzOHhiTHliWjhKdzRCVTl3bG1jYXI2RE8wTGVMNFlYM1BWcFVxY21wa0E1?=
 =?utf-8?B?YVhWY1dnM2Vxb1B6cnc1MnljTXVLSjJjZTRkUHJJMHp2NUh3QWRFbWZXbUNW?=
 =?utf-8?B?YXEwd2JIMktYWXgycFdzbmpIMldkZDh6c09kY2RyZ0x2WGhXMnRiQ01NUjJr?=
 =?utf-8?B?Y2JhTVVoQ1dWNUdBTGRCNGR2UG1DdTdSTmxXTzNjUjZnaEM4ZlZmVk1tMWI4?=
 =?utf-8?B?Z1M5UzVUdFZ3c2JzS2VBQndaaDRiSE1LZHZ0NkxCT2E0NDEwcnM5UlBYcTlD?=
 =?utf-8?B?K3lVbnpSR0s5RGREcnc5WVdQVUJ6T29ZSmphekROcEtvTDd0VDIwVkJZNitU?=
 =?utf-8?B?c3dmRFJiWFlPK0x3S2tNaURNZFhYOUEweFFvUE1FUGVTeERXRTd6WGZia3l3?=
 =?utf-8?B?Yk4wL2VQT2RHa0FKc2VNQ0VISTlpdmNmK0JyTSs0SmE4M1RoRU1hSS85T2k2?=
 =?utf-8?B?R3ZPT2xWZEsweFlmamQvaFZTc2s2S1c0VHlwY2NKTUIvSXlOTHh6KzdmbEp5?=
 =?utf-8?B?elZscWVEbUlZUVlqQzJDUnZ5N0JlRkxMR2RRTFQzejZuM3dYRGJMVmNNQjdr?=
 =?utf-8?B?a2Z4M1dXNm43a09VblNUN0VBelVYa0dUMU1LOTlDQ0QzbTF3dWhKWEVOaFJm?=
 =?utf-8?B?S0NqbUVnN3B4R21SKzV5Rnh6MTgvU3RHSjhDakJTT29mbkFSbmhuTlF3bmll?=
 =?utf-8?B?UGtTeGF4VXc5YVZpTytUTzAzdjQxaXNpMGxkbDkyQWtWWWNoZFpnblp4YTA2?=
 =?utf-8?B?RUUrbkVDV0JuUFo5WmFFeHdXUm1lQStNRnM3RklSdFNTTTZkUURHYXp6Q1BH?=
 =?utf-8?B?ckRJQWpRTkNmcm1JY2VZY1JJQStNT0VISVBLTkdiM21kdkIyZys4RjlKNVI1?=
 =?utf-8?B?RkVPS0NMQnptem4xNVJOV2crQXNNajBHSk0xUWxRMzIxbGRNY0ZRdFJBTC9v?=
 =?utf-8?B?RWwrbEdIajdoakNSSUJIeDRvMkVGZWt6QVBuLzhoVUxRMXpidHVYVU5MQzBn?=
 =?utf-8?B?V1pJalhWWERtUnE5WDV1bjN2UU8venlqLzNmMTdxSFRWVnBxUTdjMkhLcFBq?=
 =?utf-8?B?S2hVaTlNQlllT3dzSm5HSU5FOGZYZHNXT3YrZ3psMFQvOFU2UDNKdEdqc0xU?=
 =?utf-8?B?dGk1ZEY0UFFCMzdwenlBbDArZHlUaHRta2FLOVdqelg3Yi9KQ0ZIWFc4MkJK?=
 =?utf-8?B?WWZFTlgwUWJRZVRtbU0zV21TTmw5Vm42MEhpcm8ySnVEMlFwZ09uOWJROFZy?=
 =?utf-8?B?dGIvSjRiZmpEMFo5cW15NlZwRXRublRLZzJSS0hkcktJTkxWSVN3Qm90bnhJ?=
 =?utf-8?B?dWFJMjRUQ21JdTY0MUVvRTVTdkwrUW1Zak13WithcnREQVVURm9paU4wNHhl?=
 =?utf-8?B?Y2MrWXpPUHpYYS80V3pwaTkwNVZsalBTNTkxUXJaZXhLY25XY1ZtUzlROThQ?=
 =?utf-8?B?QmxvSld1d1BIQ0pjVHRCbkxWNUw1V1U3aVpNYldxbGtDSGl4MjY5U2hKakh2?=
 =?utf-8?B?S0FmWjVadjM1ZWlKUUcvYkdYU242YzBBY3NGbHMranNxWHp4QlNjb29qZ3pi?=
 =?utf-8?B?K2Y3L0FpWGJoZW5JR3BSRGxJRktUZmdLbEdnNGU1dHo4akRvQlFqMjNJMmVw?=
 =?utf-8?B?MVl5WkxXOHRER1RHL2x2TXRRMGZkK1JXbjcySXF4bFJaUTJOOWxPMFlvZ0ht?=
 =?utf-8?B?ZHRKZ3A4YVk2V1A0WVd0OTZQU01oamJSR3k2bHFHR3pQdzFON0pjcnZ2aVg0?=
 =?utf-8?B?dVFZNjlaaU13dGUvNmRxcEJkbHFXZVdTYXpRTk9rY0lkdys4ckZ5UG9XL1lu?=
 =?utf-8?B?V0xLYTNXb1kzbGNCK01XSzBaMERYeFBjNGh0R3licW5aLzNpZ01RQStkRnRa?=
 =?utf-8?B?eHNqK1hhdExDNFlDemdGTklZQmg0MGlEaTJYeVlzQkpTdXVDaXpCMkVQUmRh?=
 =?utf-8?B?MkdjWWdUdXpSdXd4YnZmc3k0N0o1cGVySGRIWCtNVkErTklMZ2kwa29LVUZh?=
 =?utf-8?B?ZG9wQ3NPVFBSb2lJVnZ2c3JkOWo5VWhIdlJ5NjRqRG44VkViZ2t2cjg2Sk9v?=
 =?utf-8?B?ZituWFJzTmordHhNY3ZyYmRqRTVZMDdLdUltN0l1QjRxb1d1dFNZb3V6VXhU?=
 =?utf-8?B?emZDUERwN3RTM0pVMnRhUkRLVWJPdnBQM09tSTNleE11MVRYOHpPYkVuRmdy?=
 =?utf-8?B?d1l5R2phY05WNXFyVDYwUS84bG5aL1dEbHhKOHFoTUp5VlpEd0xWNk9WUktv?=
 =?utf-8?B?bUFybnBOUnpDNjlwd0xvSG9Wd2tldGNFMDJNR3B2ZVFaZzNpeElrV0N1WDkz?=
 =?utf-8?B?eVN1bEVZVjBhWStXNzIxbEwweGh4ZStqUWU2aytJdkNyQnNUcW5idz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c818b503-031c-4e3e-4d56-08de5e7af984
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:39:00.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkbteK9qCFI/MAdoKQTcACv0ir9n3KERkJnnKJ/Sj5K9sKf0tBVJjtRuwBD9IHwd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355



On 1/28/26 15:34, Andrew Lunn wrote:
> On Wed, Jan 28, 2026 at 12:21:41PM +0100, Michal Simek wrote:
>>
>>
>> On 1/28/26 11:37, Krzysztof Kozlowski wrote:
>>> On Tue, Jan 27, 2026 at 09:03:55PM +0000, Abdurrahman Hussain wrote:
>>>> The xiic driver is designed to operate without explicit clock configuration
>>>
>>> And if you change this in the driver, then you change bindings?
>>>
>>> You miss here explanation based on hardware - how does the hardware work
>>> if nothing ticks it clocks?
>>
>> Hardware obviously have clock input which needs to be connected. Without it
>> it won't work.
> 
> Should ACPI potential limitations be making the DT description less
> accurate?
> 
> Would it not be better that the driver has an DT binding and an ACPI
> binding? Where there are common properties, common functions can be
> used to retrieve them. However, if ACPI lacks usable clocks, use the
> of_ method to get the clock from DT, and skip it for ACPI.

I found is_of_node()/is_acpi_node() to detect if this driver is probed on 
OF/ACPI system. If this is the right way to go then clocks can stay required on 
DT system and not required on ACPI.

Thanks,
Michal
