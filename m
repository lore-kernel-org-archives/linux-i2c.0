Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45C3CB2D8;
	Fri, 20 Mar 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021145; cv=fail; b=MPufZHxKaIg3ZUFjmd3oLAdgTCxgDZGIWSHCfxJ1OSFwdBePMuSn+l9aXxPk0mYFMtMiKnHyuaQcsGtbSRoPLxQO0mOuTtF3kXD4zYvmjHqviVjIXIAYC+U0odZ2t55+zv0xYD9TNcNWk8GgeR1E2N1kuKLyeQvF1UdMpdxCoC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021145; c=relaxed/simple;
	bh=y3mP5+5g52jmlSxetNr+SausyLsYZt2ynDsDGJMhm1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XRJ08d4aOP4Ge6XNKFymaTOMnfBQPzISD9frUVNECEejpn0cr8MkYuqhusyl8QfGj3pLnLc4PN413ucKbD646sRNYLCcGfEzVS/tx6N8hZAiArv/Qh61fasowpDv8moplVYT4u4S009tm/0coXDgIkiwijBqLe7+Vm9r1yty32M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CKLdjjcF; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CKLdjjcF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0CdtNjsyqCEVbM2p/I/Vjj+LYrB1uDFHd+GhFDGKCaiKUyREZd6r0K0bbepjwofYhTTsj75YxS+l+qHsEzH4MUF5y7uRzi5pvAwPl7YnyGONvPAwFtHc8GXDSc3sYmT8bvYkQl0F8CtwM7SNQXFIvNq+r2/gOD8I52ZcUNQJCKcIQBeFq9KTOYnOSviemI0X5wLlt41pjxE26gKkanuLL5e5ChijO6e92hzwuVsyX8xl0sd9qerZkOoqB7o0GFygu/gPLCCkx7bvZj35fRZL5UG4xMahG57b1DEKJE204QEE5jLklVsNSe5yNYxJ5zLu32wu4Gdq7oymrawasJxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usxeDFUuyeb8shU8OWZP4UQaTbC2PuAYsae6X6WPhmc=;
 b=LHFG5nAHsfJs/se/ZqRYQqcZi38tVkfr5m6pI5SdgNjZ0HlYqZYsvLK1DuD7kdX9HJPtsjUL2GB2o822FAB6l44j5FRB4YDu4tWxBlE0bLyd+/8yXZKOPXDpThrfvc2iAdi5nXG4NEd6cjdwO5uX8UfIBQaqWdzuQoQ1ggPTraMk1d/HDcQfDW4Q/XiEC346r5NKN2HVmI4Rab//9NXsFvviSDuK6Bb9Ny4L6efXQBz5QZjE6F3Tg5aW6Yk+g2D5fxBauHGJ2OdyadyBB4fzoMRThJzjgKycsk8OdeDCrdrqtoHokbx2tXjsfYkjl11BJiMN4/TsM+9S/P3o0mNIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usxeDFUuyeb8shU8OWZP4UQaTbC2PuAYsae6X6WPhmc=;
 b=CKLdjjcFAcrHX8Tu4W0AUGGx6ASqOj60q00gW/y9Lu1i2RkB3UDDt2EIBwyAfkF9eZiZhkX6zUcU8Pehq6qjY9hOrs9savBVwyuIrqT6jstQy7nxyjN/xAOo/dFk4nm9iv48RVMBqjjug+fOgSSGvtthkv3KqONGmgZaoVIRJZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 15:38:58 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9723.014; Fri, 20 Mar 2026
 15:38:57 +0000
Message-ID: <4268191f-2063-4031-8c67-3663cc7c5d66@amd.com>
Date: Fri, 20 Mar 2026 11:38:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i2c: designware: amdisp: Fix null pointer dereference
 in runtime resume
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, andi.shyti@kernel.org,
 mika.westerberg@linux.intel.com, jsd@semihalf.com,
 rafael.j.wysocki@intel.com, mlimonci@amd.com, benjamin.chan@amd.com,
 bin.du@amd.com, king.li@amd.com, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260309220038.1420996-1-pratap.nirujogi@amd.com>
 <4527c72d-bc59-4f5d-af94-4b2f37d75a96@amd.com>
 <61dbe8a1-6578-4690-8571-6b00c1850d34@amd.com>
 <abz-SmE5-_OLcZb_@ashevche-desk.local>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <abz-SmE5-_OLcZb_@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::16) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e98d2d7-6e6f-4863-42eb-08de8696ccb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nIXfnFVCpWzYLIVf5c+6eT01qiDCCX55U2IjXhYftJfy1yfwu0tzXVY41SuFizY7YF+DU9wrSkdlAW8Gz8Vkp3b8po2/2QFA6x5zIca8B66o/KfHcjpUILXWUBnDPySLM3sSN1SRRyXG0QdG7GCbet3FImqNhn2VWaBHNgxXD3ZAsefnOpIjcJ6yrauQP6oq/ZaChHFkehSYiJP6H4PjCRqnZrEKLyPAgewoW64P8xj0cHo5ln6thYrJ2uM/RNS8ZtogH5yUd8Xgq928ix9Fsc3q9BEP56+X77mYASP2SY0mRfSemHa3FCqoz8gylGYoGQtjnQ3yix2vSMSvEdrlPUbutIFm4tyFYcZZTHSf6AODd7akj/IBPswT5Y1PGjHsFSEbwOaCj5H5eanHqpV1km2tK5ViO90QMFciE45iRCKc5/6WfNBjqpKy7kThY0Kz629eUzoJClDaJxCoCm5eFW/VNyHAXJLIduq216Ay5Hh3TR8DZEX9eVjJdkNr4m9GNhUcUkxYK2eSxzGizWpANA5B7J+btBCXJOTnVJaY0m4MRzciIcJWsaeZeuyG/ekkfbQtEvLTN6Wa+ssG68ppLANzhgu7TjxV4NnOv/r7alGF42T9ekpfUUbyD7fWhwVTere/YswrKpat9wvdipsqEjGcy0o0ZgF/2TXa6CRDYrc6KPu4JnGIeQxlEWn3s1Ci
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnhOYmYvcmJYbWhoMDdCZFBid3E1VTBDeGVoVWs4aUFVcS9RQm82SUNWSFB6?=
 =?utf-8?B?VXhDeWdOVkE1bEJNM1ZxOWYxREJLa1pOVlVwTWNTV0N4Y1JyL2VocVN6MVRU?=
 =?utf-8?B?bFRyaUkrbEhxTXY0NE9sUTFiTHNYT0k1K3l5YVJEcjlpZWgwUWYySzZaQWg5?=
 =?utf-8?B?WUVkZit3NkpMa0l5ZU8zdlFLTWtXZTFmeGdibUZSYlp3c3l6VzVqdWpzbEcx?=
 =?utf-8?B?NkxoOWdhZmw5cUpocVJHTXU3RjNLTkVWVDMrVEhKVGdPTHMrcjNWalVNR2Rw?=
 =?utf-8?B?anlKd0NkL084T3N4MEZoS1hDWExJdDFsRW9zRDlYVmJHTlZFZUJBcFR1NDZV?=
 =?utf-8?B?a2YrcjVZalJBd3RNNDg0L0QrSmdJZzB4MUtJMlZjbzQxV2sxUE5ib2NWR3BJ?=
 =?utf-8?B?MVZPbEZwQ1VjYzhFN2ZXZTY0dXVMdjV0OWNyV2NFV0hFS29FQ1J6V0NXZG9p?=
 =?utf-8?B?bVJES3BhMXhyQlQzUGlMbnJaeVpaZW05VWtadzRIUjA2VkZkWWNVeThVbVIy?=
 =?utf-8?B?eVFBazYwR0kzZHhzMDNjNk01VkVwbUtsb0YrSE1CaWpYakdUTDliVisvNnJK?=
 =?utf-8?B?VG5tV25KT1dWbU5SaStRL1lnbTNrSTl0U2prK1IrYmJpd3FMcHg2UXErWm5H?=
 =?utf-8?B?VUFSQXN0Z1Y3T1UrZ3Y3SXZhejFyODg0MHNEdWNwb2RpeDNkR0NDVWxWaUVY?=
 =?utf-8?B?NE5LTnc4VVNNNmhvTzFSRlRrZDNwSGhMb0JNYXIrenBPL0Rlb1o1NnVrS29U?=
 =?utf-8?B?M0JqL082ZnVhSEpPMWYraGViV3RaQ25WQUlpVFJoc2k4aW5KaTlsSkFvRnNq?=
 =?utf-8?B?VDNxa1IwSjZDL2g1ZVN1ZkZqbEN1bjZjQmJ1R1gvS0p3YVBrTzBxQWdFZ0xy?=
 =?utf-8?B?MThPLzNSK3VDSDYxY2Y4UllKWUE4eW4yVW53NzhvRmJZOElXUlJFSG05TkRz?=
 =?utf-8?B?VmlUQVhnWWxwbmI0MHdSejJaclRkcWZnMHFubnNVQWtkL1FXczJpOXdWREtp?=
 =?utf-8?B?V1VLbTY3TzZJZGVPV2lkQ3YzejZwZFIzdGhQTWEybUpLTzJOMlJHck5oMFNZ?=
 =?utf-8?B?dkxmc0FXQWxLMGxnSmxUR0VJM0YyVlpPcTdROUc5RzI5MEZ6dk1lWWxHRDhq?=
 =?utf-8?B?ZmE0citsMlNhT08wMzkyNTJDd2NWLzVjRUpuWFJ4WDRwWHYzSzFmSkxHUlVS?=
 =?utf-8?B?S2FBOWpzbFljYVVmb2hldnZKSHZzeEtjeVZ3QVVsWFA1V2t1ODMzdlEvMERD?=
 =?utf-8?B?NWhLWEt3MXpkZVp2bjRRNi9Ic0JhV2Eza21udjc1dUFHWEU0WXQ4QXpPMGlY?=
 =?utf-8?B?SmpUQlVtZWY3KzEwNmxScXBFSTNXeWs1dTRIVGY0V1ZMQmZWNGlXaUFic25W?=
 =?utf-8?B?QllTVVhVa21kSjk2K0VYdXhaL3Y3WTU1MGtjSWpsaytTQzhkWm9Eb056aEpo?=
 =?utf-8?B?bDBIL1djZXd0MTloeEFaR3NvR2h2ZU85TXBNb1ZaSVBldlBPUjlWT3NkYWlM?=
 =?utf-8?B?RjAxeEJDSm1DeEhKcnU4YVFmakc5VVJseGt6czFMYkI2R3VKaU5CQVJ5VDd5?=
 =?utf-8?B?ckFVRkJ3bVp1eVlJOC9nS0xuYW40bVVQWlM3K0RwRnNYbzhaa24vcXN4VjIw?=
 =?utf-8?B?R3VsVnd5bTFTbmtRbzJhd2lyWXlsOG1KWExIYWk2MzA5RTZ1U002WUdqb3Fi?=
 =?utf-8?B?VVp3UWhTc285S3JucUF2VjU3d1kwa3lpQnkrVGFYUk5lN20vOVZVa2VpZm9h?=
 =?utf-8?B?SFJ0di9jMk9yUjgwNE40bHBhSWhoNlMyM21mV2N0akd5cG1QamEvcURxcC8x?=
 =?utf-8?B?eHBIdDI4eEhUOEJJOW1VYmw5ZVpUM0VRQ0xyMVBHUTJxTmdHRGEzMjZyQmsv?=
 =?utf-8?B?QkF4Tll0NFl0ZWRXaEVOcGNicHZSRVhrTXdPUU9rVHluWkFxMXRpSHZOUDJ5?=
 =?utf-8?B?VC9WWjVyY2JESDlUdG9yL0pQbnZJNm5ORjc2Y08wNGcyZ2RHUEZPQnYyeldw?=
 =?utf-8?B?b2NNQXYvZWF6QldIeFBpbDY4MWJoczA3bi91ZTRkZzYyam9sVFNrb1UrTU8w?=
 =?utf-8?B?bHQvVVBNSWdXNzJzU3Q5dm1uTTJtaC84SjRocG9aaU5sWGk3czNzUmkvRmww?=
 =?utf-8?B?WU5JaU51NnpBTmo5ZmtyQzZXYnlQM0hxT0JvL0JtdldyWkR2dEVKMkVEWENT?=
 =?utf-8?B?dDlOSDk1Mktnbmw0UjVWRnl6TzFUS2g5ck1ZY1ByV082ODNjTGhxNk45bjky?=
 =?utf-8?B?YVlnVGFpTVdxMStMc01vd2VreUxxM2VnVk53Y2laMk1OREwvdTB6UHQ4TUVY?=
 =?utf-8?B?WE1ISG9kNXJ4UC8vNEI4bXdXT3J2TU4xV3pNR1JGWi9nek9hLzhldz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e98d2d7-6e6f-4863-42eb-08de8696ccb6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:38:57.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GakL4X8tMnSpXBIqK8rqGb9NLYlseGRO+kYIjvTzZX6SS56ya2eWRfHoGXc9hJJeIXIStjamPcqYNegBsnWWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725



On 3/20/2026 3:59 AM, Andy Shevchenko wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, Mar 19, 2026 at 05:09:55PM -0400, Nirujogi, Pratap wrote:
>> On 3/9/2026 9:29 PM, Mario Limonciello wrote:
>>> On 3/9/2026 5:00 PM, Pratap Nirujogi wrote:
> 
> ...
> 
>>>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
>>>
>>> Is this the right commit that introduced the race?  Did it change the
>>> timing?
>>>
>>> Or was the race always there and we just got lucky until that commit
>>> went in?
>>>
>> My apologies for mixing up this change along with other changes that were
>> needed to fix the AMD ISP driver regressions in v7.0.
>>
>> I investigated further and found that this issue was exposed by the below
>> commit.
>>
>> https://github.com/torvalds/linux/commit/38fa29b01a6a295aedb69d1bbdad70acd7d204c6
> 
> Still it might be not a culprit as at that point the device should be in power
> on state.
> 
>> However, the resume‑probe race condition existed even earlier and had not
>> surfaced because device initialization in resume is done only when init
>> handle is valid.
> 
> That's what the initial cause, the AMD ISP driver initially relies on
> the broken (racy) behaviour. So, the original patch d6263c468a761 does not
> explain that bit. You need to go deeper and understand why the heck that
> condition is present there.
> 
>> Here is some background and context on this change:
> 
> Exactly, the below seems that you have nailed it down.
> 
>> The amdisp i2c device requires ISP to be in power on state for probe to
>> succeed. To meet this requirement, we added this device, which is a amdgpu
>> MFD child to the genpd, to control isp power using runtime PM. The
>> pm_runtime_get_sync() call before probe triggers a PM resume, which powers
>> on the ISP and also invokes the amdisp i2c runtime resume before the probe
>> completes resulting in this race condition.
>>
>> To fix this issue properly, I’m considering this change. Please review and
>> share your feedback on whether this makes sense.
>>
>> - Call dev_pm_genpd_resume() to Power ON ISP before probe
>> - Call dev_pm_genpd_suspend() to Power OFF ISP after probe
>> - Call pm_runtime_enable() after probe is successful to take care of system
>> suspend/resume.
> 
> I don't know the scope of dev_pm_genpd_*() usage, but the description of
> the proposed change sounds sane. And definitely it's much much better than
> previous attempt.
> 
Thanks, Andy, for the feedback and comments. I’ll send out v2 with the 
proposed changes.

Thanks,
Pratap

> --
> With Best Regards,
> Andy Shevchenko
> 
> 

