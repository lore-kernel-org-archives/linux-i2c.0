Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2872623;
	Tue,  9 Jun 2026 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987486; cv=fail; b=gwWTWs+HAMBNCXORwUN36FzDqeUhj/h1NIdq1mG+XOoKm1iHMg5yNZmLCx6ZEeMCXuoUmM+NywWUSKC5iVibPMhFn31qEYL13zT2Cdz8uugxIyBYHCuorpqWSljgjjyEoXWVmelzw8W7md4CP663OVPsB2rrRAw+Kj6qylaFqB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987486; c=relaxed/simple;
	bh=Whz8jVwoKRgEai7mHLEqfm076jYGL4Wqq0EIYd/G8nI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nTeI+VkfW6xeIZoerknJrDFt0OTux3RDqPqMNiWB+2oD4RlG+8EX4NR6tx+zHyGoEdHVAi2WUVSpXbgzf5HkEAprlBC+dKBeKq9MAJuRC6FKZyFP1GQUseAgCoOl48Actz8QjqrqR+LnW28R3hNj7QzJf2Z0UK2ehUk1iwm8SaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HfKBjr9y; arc=fail smtp.client-ip=40.93.198.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HfKBjr9y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gK1U7eNTWukz62MzWTO5gt58cpFwvutNOAcUyDWuSq29C+drJ5v/gPojWGQMOyt2nzZ2DKX5OqVwW7SsSmzN00QbqzfUJLXxBgFrWSoyOgwNHnUAVDoX4f3JNFJ8ny5VNOrvZNYR6qRhyF9SSRwRufatjG8WugUXeDmmyd4nU8CbKpdxSy+F2mR0xgsQywnsofXE0K0GzkeE3Q4ea6xFk/IfkB3Zn34cm6+XFWforF2hPEXjnm4aliCxeXV3aD9YgzEdrufr4hzYF+5xYyD5ISoW3RZGDivfMwDm44ejn1W4s413Hm+oePOG/HAmzMh43DcYL5G+l7/rZGLulvfnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhXftXKeG5UrGayNqfqTsukoWRWN0VPBbNJjo/YKnaU=;
 b=lJnU/5h3kR/X1ISPLapv/5miUBCjOVzaD7VylCgJ7CO/51xlN6XXRJ/V4F2QjuF2IHga0YCdARZj24+hfDpRYffh9Ce1soAL5OLsdhF/6DuIQayjjDeDERQzX5NP8hGAHc04o6Plyyl3PqpgB/QvKqZRNvUipPGt63+GcuqxxOW/V11wEDcm3OzAbq234woAvYJqTWXYvl4LIcvVAa2g4zaQbBHvPgz2kfvviMzX6nCVmQh8bjVPOXFIInVs3LDoHCIZXaHVhin1MxEKG96fVxuH/TJsHn1eZtrn4B+zLh5cuqjUR2m/E5/4BkIdhKgfPkiQWQZJSBU9ixpD41hRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhXftXKeG5UrGayNqfqTsukoWRWN0VPBbNJjo/YKnaU=;
 b=HfKBjr9yEJ1ed7sq7YSe1hif4LEaSU7U3u4GnOG3Il30rbeCe0FxJvPDRUUSi4TDpAu5T6bHlqDB0lPLkZ3H0YlZvqgRa88cwQkJMyOzqx5x1PDIc+v4noafaPinK2tPHy0PBHhH5aF8T3KaDqHzKnDGaMqMdcwhKlB7D95bq0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Tue, 9 Jun 2026
 06:44:41 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:44:41 +0000
Message-ID: <ee73380f-623c-4fe1-83bc-dbf536054b3a@amd.com>
Date: Tue, 9 Jun 2026 08:44:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] i2c: cadence: Add shutdown handler
To: Andi Shyti <andi.shyti@kernel.org>, Ajay Neeli <ajay.neeli@amd.com>
Cc: git@amd.com, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 srinivas.goud@amd.com, radhey.shyam.pandey@amd.com
References: <20260430053050.3590173-1-ajay.neeli@amd.com>
 <aiez0H0PPX2NYkyv@zenone.zhora.eu>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <aiez0H0PPX2NYkyv@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d615c2-b6ca-491f-c5f0-08dec5f29525
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	j33dD5HvtwtGQ0ZaBlDi87yjzIT5g6eunn5DY/6wQC672UrXCnSvqdJgfFNbmwQWqSWwh1LjnFYcdEyNgj7A8mvvAllZpp41kLW9hJZOCdSTR+M8uZ98paySpENY2XxlMeyh6ggOTs8K1HSeAWRqtXwzZ6C0BMkL4HLG+/NTmdkk0CzvyxYIL3+4GSUbah+XebBq77+JnTYyWFlE9xntNNr/O+o8BQ46vnlsH0nwVFrsFninfGm7yB7oj+ZXJcWmtIQSNmUCDHRlLtDxNaRTgnPXGszcY9blFhrs3xuJKS3R8PCHiKKhctXwAQMHqt+UdsTpb8QPydUfinYeYT1Ai9ypMEX53jjraZ0nVZSYVgi6kKjvoy89Rbd2a308Q3ANr8pREEyTgINPufRi7m6YJPGkF2GqFkD6dFpqtU34cVkYtziwUniFvRg/3ro/D0bvWk+8LE6ZXYQo2Y8y+KvBcszEmR4XbFV+ipeQijz0n1jKd5F9Au8QWL34/SL9AObcVqz8QlY92aJHgSi1mcDiZHTIZnJgxIGLbkpPOVuzkysnmRTR5bGM1hDJ/mQ+NiS/d27OqkPK3Q0qHQigizqMaZ3oYNEVRQfFVqSnF7o9qv633nx5kl15So0H3vMPOnfVGFa8TA6unYrpPRnk0GdlGlgkTVU7nYpK6Qy1ufTRPoeOPVY9bCfaGYkHVXdyVCH8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXhGNng1bmU2UzQrOUpudHFBR2ZqbGxjZk9SRnpxNzJsbVc3NEs4QmVyL0Q3?=
 =?utf-8?B?a2l2Q3JONVI5NVo3QVBwQ1dVSlo3M2MwdlB6MUFsZ3dUTEo2RUpWMW9Bd2RL?=
 =?utf-8?B?STVDWDJGOU8zelFnWHFJemZxaG94R1g0aHZyVDJSdGNHMDBMb0xvbm80YzBm?=
 =?utf-8?B?UE5VRTlHaklQeEY4cHh4UEFyMUpGQ0VHdnVIZitIMUxKSjMreUpCTytjMmNi?=
 =?utf-8?B?N0p5MjNQV3ZpOTI2TnNZTjdFNU9rRGwvWGFlM0dpVklXK3A3S1NpckpGTzZL?=
 =?utf-8?B?TWJod3ZFbG82Z3F5N1VOamxXU1JFT2ZMU1E1dWovMzd2bEFvU2hRSTF1dE5n?=
 =?utf-8?B?RS9jaGFKL2JwV2VaOUZ2RFRTRS8rWGZzUXc2eXowaEM2UUt4RVpQSzZha0M5?=
 =?utf-8?B?YXc1VGdNV2xibTNVNUdYNjJnc01BWkVIRTdaVW4wajFUQWllWldoTTMrV3pR?=
 =?utf-8?B?eXNPaHlBNFMycnZuVkdnY3hjM0ZtTWFkalRrMHhJNVVxdEUwNVZlZGZhT05n?=
 =?utf-8?B?NWJHalZWeFdyT2xNQlIvdUgvdXJ0cWJMN216anFROXdMRUlITWoyWkZTUGVH?=
 =?utf-8?B?QlJMdVZRaFA0WWJqRURlZ3pHVnltcW9ySWZRQmo3K2hjN2FPRUJ1djBodThE?=
 =?utf-8?B?NWhHRTF2NmZoSzlBQ3dIaVc2R3UxS2YxRWZ3TU0xTmdiWE1wTHgzQUxFSXMr?=
 =?utf-8?B?VVZmQUpicForeXBqS3IxRTh2eDlucWp4aWxqSUV4dzcvUzdaV1dLbDMwVW5h?=
 =?utf-8?B?NEpUbC9KL0lkdzQ3RHU4RlZjSkM5OENubVliMkhQRWpzbTFSakh6ODdBbkh1?=
 =?utf-8?B?dlN2WlVlMnBoQ1paUk0ySStta0tnVEpUeTVYeEh3eHk2bFRWMXpnNzg3SmVn?=
 =?utf-8?B?UlVld3ppVUt4VlV0K3pIdUtYTDl2em1TMWF4cmRMWFp2dWhqRVNCMWE4LzBT?=
 =?utf-8?B?YnVHRGF4c2tqOUt3Z0FWMHJuNGdoUUVXR3dqRnNJVk5EQUkxbERUMjdyVFJq?=
 =?utf-8?B?NGZPdjhlV1NBbzdWTGlDRnQwa0NSOUxTTlkzWDFJUnpVbEVDWTJRV3ZQVVMv?=
 =?utf-8?B?dG81RlVuK1N3d1VkclhGbktsajZXUm5oZC9UNE4yVWhLaGdablhBYmVUbFJX?=
 =?utf-8?B?OXJManRwZG1aNFNpQjFGRWIwWUVQQmh4SEtkMjdZcUI1b1lNUHRYdTFodzdy?=
 =?utf-8?B?QUhFdlZFUmp3SzBCeEczQlo0NGVpN2JHS0xYeDQ2M0c3Nmwwa3NuNEJyV1dJ?=
 =?utf-8?B?OE5oV3VEQjhnbC82Wi9aNStxZmRZWC9Lam1NRHRmcHJpM2JBUjFSZDRQSU4x?=
 =?utf-8?B?cDJVRmtDL0RDcVNST3dvZ2NhN1BPcnVVM0FRTjJHL2YzTU9zN0tMWExzMXVn?=
 =?utf-8?B?SXRPTzZTNGIvMDRidkd3N1daOXZLaFBMeTZYREJiMldmbjJVNHZ6TFQzbG9F?=
 =?utf-8?B?bG84a2V3OEt4WHBlanYvYk1MdllWOU94NVN1enI4Y0tyVjcxUGdCUjgvRDA2?=
 =?utf-8?B?aWJCRERBek1IcWx4R2k5KzlSTDl5MmRFcGNNd1ZIcDRwaE5aTy9YdHJJN1ZP?=
 =?utf-8?B?VElPZ1ptQlpCYTZNV2sxRFdzK2pPcFdiQnRWN2ZPZ0M5bTZYVW5BbmRWNDNX?=
 =?utf-8?B?ckNvekVwYmNGQ3YyWEhVdFF1V3VzQU96cDZjYkRMekhYeG5QamxZWXlZMGxn?=
 =?utf-8?B?b3pveHFNTU5PNzFDT3BoUE1WQlNhUFV2dktYRTVnVmxEZm1NTkJqR2paQVdO?=
 =?utf-8?B?YTNmT0JlRVJuMWdyQ0dsU2dEdHU3enZFUStmSGZiZDdNS0tCenRvcHdQNGY5?=
 =?utf-8?B?cGhKaUlGNE0xSnJ6ZUtYZ3pnakJXa1lMQ1lqMW9VVVNCR1F0MWhiS3g4Qk9i?=
 =?utf-8?B?ZlFtRlJLNXlBaTNHR0tSK0twa1VNTEUwaVVvSm1pSFVZMkQxdVQ4b3RtNEtL?=
 =?utf-8?B?SlBNTmJpUVpJeDl6eEtNaEx3RXAvbytISWVVVzNaREt4TjlrMVZSSEdKOFNo?=
 =?utf-8?B?bUVrMVA2Nyt0Ulc2NHpWa3lWQmVJNG5OZ0x6UUM2d0VlR3hhR1FzWlM5RmRS?=
 =?utf-8?B?VHh6UGUzVWFUU3FLWElVYzhjL0VJSldkMDE5RGNYS0NIZzV6SGhXOGlqalp1?=
 =?utf-8?B?ZTdWYlNhNUViM1d5TXExelplb2E1Q1JOcHBpeENLRE5LR2V0L01ZVi8yN1Rw?=
 =?utf-8?B?RWc3U0lyQXlrRlpyWk5UUEZIWXBYNWx0TlZDZVNBbHlRL05ObWpzanhiSGRp?=
 =?utf-8?B?c2VwTEJxRWtkMmhKRktVTGppNDVtVzhXbHNHeDFSLytiN203ZWpwRjZ0WDVa?=
 =?utf-8?B?Y1ZzQWIzOVZyUDIveWhUTUhPb2RPUURYRkFhbWRhTisycmZtWlFZZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d615c2-b6ca-491f-c5f0-08dec5f29525
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:44:40.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92lU47bC5xWvARkNua6r8kFBYZMfZzabCw1kYM0EoD1m4EDKIkjdsMu5iRTVdZbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815



On 6/9/26 08:39, Andi Shyti wrote:
> Hi Ajay,
> 
> On Thu, Apr 30, 2026 at 11:00:50AM +0530, Ajay Neeli wrote:
>> During system reboot or kexec, in-flight I2C transfers can cause
>> spurious interrupts or leave the bus in an undefined state. Add a
>> shutdown handler that marks the adapter suspended and resets the
>> controller, ensuring a clean handoff.
>>
>> Signed-off-by: Ajay Neeli <ajay.neeli@amd.com>
> 
> Michal's ack was missing here.
> 
> Merged to i2c/i2c-host.

I have reviewed this patch internally too.
Just checking why I missed it.
Anyway the patch is fine for me.

Thanks,
Michal
