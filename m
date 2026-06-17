Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D3137DEBA;
	Wed, 17 Jun 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694385; cv=fail; b=UEbEeMhGtj6EpA/LQPup6PWRAHe6NX0cMp4CI73ZfEHTWER73ZoVf+eVkfJisLNF3dwNxzzJUHh7PPjM9xr27HG57Umg8XjL4JNIcxcth6Hzbe/7JNXdDoCvdtPyINw7d11I37FQVgG32g4QivpHgxvFO5FPSC7lmuJ0z7e8TVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694385; c=relaxed/simple;
	bh=JkgmmVEi9+jNayqwnTK31/zEgQSABCtpd4xZasz7RMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q259efgfXQYpDfDOBZ6v6V8ASpcY1TSTfacPs2ykpGq/wnH9mLuIKyoaAkPciBW4n7IoxapG/XioqAEe+gVw1LV6GKMwb1pXunqt7lYS6m1euaE5oS8O0c8RCOGOpHOU+sdgzEqpx647OyospT/VEnmp2wcKrP5Y3lgHZTx44Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v98GhKWS; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v98GhKWS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibiBY1fthgnLcLm0DnrW2S5/dTRj6KsEAzO6UNK7wFj0VJqvaAUk2JmBIockQOad6VnaKItY7P5Dg274xY4yEXwSkL/cu7gdrGy3pMOhDEhlw1XbFM4Y/ULIPRvP7h+xgym5QG8nh0QlYXmAqsrHpCaXJaaOjLKpNZK6K6fWPc8bKTF9JFIgFU33xDWaW1u6Dixs+5tC3icxq9awfefaIn55e2BRScF8W5xt/UIrAXs6ShHSlvjSgLGSysvm/UD8M45ey2N5wppJGNtjKV2TC9qwnz6mWV3GP8H1BJmWJIazfQBh1BEfB/bV/UBH16A3oZzrljGkwHgoHtteciieNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swbEfcS2qt4DBi/2G1TWUWMksrPNbitZwGgztrysPJE=;
 b=ywxu6n8KGRRPLbCwDMdIrqukb9+f8sEQ3zDPtMNRyw/eIrNv1NhAHzou8ijQaVX3rp7WIeaXOWOy6ryQaSfZavhZaPwWCoyVtrJ1+vafgFv+P9qrmY1apW3n6WoctfF/x4NlTW6CSIBhn34LXFgX7zsKBGmxLmTBQSteJ6s/XQ+YOkTtiaPDW0p/vhLL/t0dN70wVbe2ZjPfbAO69iboykBbnTaYJtNoW/hl6b77/qwzdMEdib3myQQwrOCNel900lZ66OJgPfzxOAvBzLY2ZWx1Ndyo2XVo8nnj6F+nMrmy3uNt4PmI3svMgl9v6zrjYVf1xZ12pTrS9GWECzbbog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swbEfcS2qt4DBi/2G1TWUWMksrPNbitZwGgztrysPJE=;
 b=v98GhKWSlAOeDvrHpfzM8M4UbWaExW+nvhCVY08O1gwfrUv3ZUqW92U0ce787uKlysk0r0USEJD6Mh3qZxBdUUBwEjB08NPAP8+ETncEmRsdwWVZnkZZ+IyUG7+vKHq1m93GT5AJKQetKqIfS1HeSal7wH8bMSC/9Gm5dfrJivE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SJ5PPF8AECCE022.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 11:06:20 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::91cb:8f10:c6d2:d683]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::91cb:8f10:c6d2:d683%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 11:06:20 +0000
Message-ID: <209145e0-fae6-4613-9933-449cc53b040c@amd.com>
Date: Wed, 17 Jun 2026 16:36:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: amd-asf: Validate firmware-reported length
To: Andi Shyti <andi.shyti@kernel.org>,
 Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paritosh Potukuchi <paritosh.potukuchi@amd.com>
References: <20260612093502.3805287-1-paritosh.potukuchi@amd.com>
 <20260612101815.4124804-1-paritosh.potukuchi@amd.com>
 <ajJt18_NBGSAvMJf@zenone.zhora.eu>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <ajJt18_NBGSAvMJf@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::8) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|SJ5PPF8AECCE022:EE_
X-MS-Office365-Filtering-Correlation-Id: d233d987-187e-48e1-cd1c-08decc6075ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	xwCYeJAiVdHxR8UH2EFcK7tTHXkhJ8hJfqQHDGAyy6JnvbsYAK648n36NlYTclsn1qD9qNdHLsYf65kyhXYj96LTwBVPl3ZrZFYAx2TB4ZwouzKrvZpvEse8yWTah0UOQ7AkbrGFqtXORX90bgGq8M7ne3pgOaxAuFktA4mpyjwormipJhjJFx88SrQZZPzaqpVud/1gHckhO/zXGJdb+ALwYMWJVy9ohDsLoVkYCjvOpegI8eyklBeDUF7P0K4NAJFynfePKQgj2O8rlDdPhqWG0nTY6ni6rznAWbnYa25IJaY7/0FTEkDWuYF638GMY3Jy6O+5zgDjsRdBB+mqDmvFawwl5ZXiRvFgCC6EhwSpk6cgJYm1Ir1vmAL6kH+3bp9XGD3+cOcrcC8DwJ41UXMo4VNjXpCbrXbiMPQjQMqaDSfa4mhP4Cbbbwrtx3jIfPmaXJfOmOd5VYBzPlr6F9n7dvl6PHBcIJpHpRmb5OOV4HYY27NEfqIZmJz+vRKYdSn5tgC1R5UabKMkRav+jDoupGZNT4oLbP/4PTJZSNvnOfcDTffRtsdy7wW/LYvD0erniSIsQfMckdekU9au3JUoQj0PgyKkjARUcIMTdVIOpBlAlORB1YV4fE+iOXYkv1WjuuO1SSuzlqegzmHmTqoDv68fFmLP8fO6wqtSb1/XRFIU9SUbpvKz92Mdka8a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2NnYndxQTR3Q1NuSmdJb3hFWU5IZzY1OThGWGJTSi80Qkdzc0VBZDRGdnhy?=
 =?utf-8?B?MXdMOEJBcnNqdThUV2VaSVFDSVdyYVd6SVRVMWpybWRHckZkRVpOVDk0Nldk?=
 =?utf-8?B?bkU4Y29Cd1VQajRESEJTV0hvWk5BUklUVVVwdEl3ODI3aUtLNktNQmNpRUxP?=
 =?utf-8?B?NitTL0ZOQkkyMkI0M1BtQXhzOUpPVVR4MVlTRnRGZktBd0tNR2trazlVZ1Jj?=
 =?utf-8?B?OUpIOHd1MGVib3lOSlFZUy9rMVY2cjF0dlRzWTVOUHhVbjBFZHFaemFHanhs?=
 =?utf-8?B?b3dQTHFhajdjNDJhMmw1NnNKRG1tTGxWQ3ZGTmdFRGZlSXZUZVNORE1DSEJJ?=
 =?utf-8?B?NGQzcWF3RG9QVXh0cGtnRmd4TWJmMVV1c3U3MUhCNy8za3R2UlVYZ0NrUDQ3?=
 =?utf-8?B?K2VCcmFtRVZqTklyTjN0cURycEpuTlRSYjV1SnNYS3ZrcTBYdHJiL0JBZkFN?=
 =?utf-8?B?VUwxYUZNZGpPM1J0YjdYSHIycWZZTUdKTDZBM2RFY0hIZWcvR0NBUUcwdnUx?=
 =?utf-8?B?NHU1NkRSSnNGRTd4TUVaeDJhdG5vb2ZMc2V6aXR3L0RXTW9UVEVoYUo0Z1lk?=
 =?utf-8?B?L0hiNWdWa0o1ZmUreHJQejArMG9MSStkTm5PVG1XNWF3VW1SbFlQeDh1NlZa?=
 =?utf-8?B?N1NvKzJ1aWlpWEswZ2wvWWhydmR5Z3hBZjlnWFNwYUgwV1ZXaHA5aUZWZjJF?=
 =?utf-8?B?MWVHV0I4OHVZeFVjby84OFBidlBpTTNaclFqSkgxS0RLNjc3YWkxU2VqWC85?=
 =?utf-8?B?YjhUK0hLckFod05Hc1g2ZkZ4S0hTV2RhQlFLMEVRSjJ3c01OejRRWkx3TXB6?=
 =?utf-8?B?OUJML3NqeE1rVEhnbVZ4Z29HL2pmbWYyeDV6d0pRamhhY2pPQjBOdW5FdHlt?=
 =?utf-8?B?bUFPcHFDUURmY0M0eTBtUllmQ3BVVm5sMyt2bmZJcUpQLzRCMjk2cWI4NTVU?=
 =?utf-8?B?VklaQTFsOURTMElaM21ZTnhnb1NPbnF0RkJPM3VTWHc3NjhJaWo1VFBjaXFp?=
 =?utf-8?B?cnpOa1VmSG1YZHZobWVERk9qTUo5UDVXZGk1bndhWUJwditwNTgrVGZKd1RY?=
 =?utf-8?B?RUFWUkxPbHhRRlMzN2R3RnBtZjlyOHVxK1NwTGkyMEFwRHIzU3BTaUxJQ2Jl?=
 =?utf-8?B?Q3V4SGdLUFp0ak5ZaG9aNEdpaUFzYXpqVEwxYnZMSHYwd1hlcDdYYVkySkhQ?=
 =?utf-8?B?ZkpvT2hqK3hsRFZEOC9kMCtlLy9HMWFYMzdVQzRyQ01vWm5VeWNwMWQ1NG5t?=
 =?utf-8?B?eDE2UDBPYytOb1FIU1EvWmtUdTc4NmpZczloRm5sSmd0aGtiN0syNUQwcXhK?=
 =?utf-8?B?ZGhXbUkzZmlETlcvWmJpTnZXZXBCMVR6S2h5N21aUWNiV3ZJVjBiKzBraDNO?=
 =?utf-8?B?endNbk13M3Erd282b2pNZ2hMY0prYTlzQ0ROTEZZb2lzT3FkaWozSGpEVHFE?=
 =?utf-8?B?UHJKRmFGZkc1b1VPMUp1RWJGdE9ldEtiZURmZTVSTTlHU2cxdXpySnkvR2FI?=
 =?utf-8?B?MnNIUkg3NFJUYkROMG5GRCt6Ulp0YXBuUk5PdVQvZkZmV2t3UVdsWG5PNDhy?=
 =?utf-8?B?YWRjTTBPYXBoR0NKd1FvdVN0VmZ5bG1OLzZLUXhVUU1TVHpTQUUxWVRwa25P?=
 =?utf-8?B?Rm5hOUJybi9LaDlLMUZzamRvWWpvMnRuY1I0ZDl4ME5Sa1BFNU1ZS05GeVRQ?=
 =?utf-8?B?RHdsNGNkVHh6UHlGNVU4cXZaeUdiZ1NEZjFNQldtak4rOVcyT1dha2JFNURa?=
 =?utf-8?B?eno0S0tzRS9PRnlwUHZSTE5XdmQwdWNzOElsU1FKVlNVazM4eTMrWXJqV0I3?=
 =?utf-8?B?RmJ6YVZVWDlQdjIrWWpYS21ta0pTL3dLbVcrTHNDOHhGeHU2Rm9LSXl4RWNE?=
 =?utf-8?B?UE81SXNobnRPaUR4b0lUTjlxcE5pQlZCWkZ0NERkQkE2dExoK0xuQ0RQbUtj?=
 =?utf-8?B?ZEpMcVdoUUduVVpIb0d2VXdSTjAyVUFlSitSZXo5bFdNd0JCdzBJbC9JVDMr?=
 =?utf-8?B?ZEZTaWNKSnE4L2VYbEhWZVNEQ3dNSk9yTHVtZDRYT05PMlhsOW9kY2lKRWxP?=
 =?utf-8?B?VFRVd2ZFNnpaNm9GVEpCbjd6YWxxMWhjMHZ2Z3BMY3JGSWtLamFjYzMwZ1lQ?=
 =?utf-8?B?eUpReCtSYmtxYVF4RVRrZnNpeURtUXBQQ1lHSXNmNkUrWlYxbDVXY1BZcmNk?=
 =?utf-8?B?SVdvMWRzOWNzQzREVWN0RGJubXdobWV3S0szTUVjMDE0SVNFclo5aUU5Y01i?=
 =?utf-8?B?dU5XZWtlZzRUM0RSYzVkU3VweENpUXlNbCtrTUljNytFeHVHZmtiYlp6SVFT?=
 =?utf-8?B?TXUxVU50b2lzREF3RGRXTkxaU1UvUTZndnNrQXdkbFJWcHp1RjNiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d233d987-187e-48e1-cd1c-08decc6075ea
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:06:20.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVjp4mW1/HQtMVln1BrboZmM08kqjgCAiSYozpAiPhUxyCabi7/LpCuKw8GcL1ZEot8mf/wCgkK5fB20YZE97g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AECCE022



On 6/17/2026 15:50, Andi Shyti wrote:
> Hi Paritosh,
> 
> On Fri, Jun 12, 2026 at 10:18:15AM +0000, Paritosh Potukuchi wrote:
>> The firmware may sometimes return a length greater than the
>> allocated buffer size, which can lead to out-of-bounds access
>> and a kernel panic.
> 
> How often does it happen? Should it be considered a fix?
> 
> Shyam, any comments on this?

Looks good to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Shyam

> 
>> Currently, the driver does not validate the length read from
>> firmware.
>>
>> Add a check to ensure the firmware-reported length stays within
>> the bounds of the data buffer.
>>
>> Fix indentation issues reported by checkpatch.
> 
> I'm going to remove this comment here as I'm going to take only
> this patch and it's a meaningless information to leave in the log
> history.
> 
>> Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
>> ---
>>  drivers/i2c/busses/i2c-amd-asf-plat.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-amd-asf-plat.c b/drivers/i2c/busses/i2c-amd-asf-plat.c
>> index ca45f0f23321..e1699da838c2 100644
>> --- a/drivers/i2c/busses/i2c-amd-asf-plat.c
>> +++ b/drivers/i2c/busses/i2c-amd-asf-plat.c
>> @@ -90,6 +90,9 @@ static void amd_asf_process_target(struct work_struct *work)
>>  		outb_p(reg, ASFDATABNKSEL);
>>  		cmd = inb_p(ASFINDEX);
>>  		len = inb_p(ASFDATARWPTR);
>> +		if (len > ASF_BLOCK_MAX_BYTES)
>> +			return;
>> +
> 
> Your patch makes sense to me. I'd just like a blank line before
> the 'if' statement. No need to resend it; I'll add it while
> applying the patch unless you disagree.
> 
> Besides that, the patch is not properly formatted. It is missing:
> 
> 1. Versioning: this should have been "[PATCH v2] ...".
> 
> 2. Changelog: for a single patch, it should be added below
>    the '---' line, after your Signed-off-by. You added
>    "Fix indentation issues..." as a sort of changelog, but
>    it is in the wrong place and it is not clear that it is
>    a changelog.
> 
> 3. Please don't send a new version as a reply to the previous
>    one. From a maintainer's point of view, that makes it more
>    difficult to track and apply.
> 
> That said, I believe this is your first patch, and that's
> perfectly fine. Welcome to the community :-)
> 
> Unless there are further comments, I'll apply your patch to
> i2c/i2c-for-7.2.
> 
> Thanks,
> Andi

