Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC143BBA1D;
	Fri, 20 Mar 2026 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015034; cv=fail; b=kZAiUY3bZlHZ/KYqtvpRm0H2HeyxVkrOjfjvmjksjY/BCQZEO58CmXDMFk81VZfTg6qOmInpOYYTn9uN3OPMCvsezAiD99RCTKvHvWsdyPs4CcvVgBPJ1c15QaH6HRrSSy7/y0T4AxG4NWIs6N1NHv4cwvR/gJhtOmbt0+vvDWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015034; c=relaxed/simple;
	bh=hbjwPpUepIqX/Ou4uqwtNm85b7vqgkFaUawlKBdy2iw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g30YWqsLeBKeJUx90tnkTM1ecFv30PFAyjO7Uy0bTYqzKoyFsaO7zXSCOeEmcLKbOVMfBxpLrkFkueY9Ji0VDd05jkmF4tdh+iFW/WBPrgbwfhZlkX04I16Qd1BsaI4qyhj2Sx44H9k0TmLTVmspX6PZsJ12duAryKJZw26XjQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eKScb98t; arc=fail smtp.client-ip=52.101.57.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eKScb98t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKz2AjCHKcs2fh/YON0H+vGFrSgdHPI8xR9HIxNTwKKJL5fQbGXeX+CZUii2TDxOAEVFWzFXi5N39HOcadaSGJMGubFFruxaO4ZtT40pvMFsD8XhYl/874qVrI1bkGaEvghcWbDC2m2LfP/UG50658XZGg3ZzDeQxBTdTlRry+FKzJbadmR3QLiatJTg1Hd46NzLqEMcy1Rn8Mr7JvDOLtDUnCg76CL5C87a4pQXjGtxtAGrhLqcKMdixUEZ7HP4JwTF+p/kvswKDk0ZslWCFw7L+78cqqQwDJ98R5lUywwdKP/CTdSoTnH2BKFxeh8M+ohLRSTOOktmsnPQnRResg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzw5+uWwDu05R6N7ZFhoi4a8hCkJkdokSmyTEQ1KqOs=;
 b=ystnMi0ltxs1tHepi820PZj3bUtU/JhsjJNRm5uyjgqJ5fWSBV7yTaT/HYQe+4bFNiP6mUBufGKtaaAHIqeBzfKjLgNPmoO20ug2qY/DQ9xs5/iy2LnDnS5PG/zR6fPGc+CM6vuAyrFL51pWjBtUFzRyFW32FjRohQF6FOX/wtU/wwWRraGuB7je1rH2zcTajsLZDv5orRdZFQPlzIavSdrVZswEvak61SIno6OeMGQjYSlzkPFQUVDPhzNfV+vshcrGdLdCpn/q6ajQC5vtWsInF2Z4SkKAkZjsNmuSf/l5qdnXvarfRNRf0qQiTcbTeQ2OQIMawiszDiTytX48nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzw5+uWwDu05R6N7ZFhoi4a8hCkJkdokSmyTEQ1KqOs=;
 b=eKScb98tV/8g/UMOFUv+mLpL2/zkugMwA9NgdmDKMPR1ES3h3mvtW1foIWWGAiphtJZQdJ0wwfbE1ZTNShBlf1nM7nD5x5FxXG674Kb3X58dEyDmgyHq/VbE5HsMZraJDG4h7bIVs7tX+zPOgBtRG4ve/hUvgLMnZIqm67MA8dQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 13:57:02 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 13:57:01 +0000
Message-ID: <2b9162e5-be5a-49eb-915a-4a557b027e13@amd.com>
Date: Fri, 20 Mar 2026 08:56:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i2c: designware: amdisp: Fix null pointer dereference
 in runtime resume
To: "Nirujogi, Pratap" <pnirujog@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, andi.shyti@kernel.org,
 mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
 jsd@semihalf.com
Cc: rafael.j.wysocki@intel.com, mlimonci@amd.com, benjamin.chan@amd.com,
 bin.du@amd.com, king.li@amd.com, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260309220038.1420996-1-pratap.nirujogi@amd.com>
 <4527c72d-bc59-4f5d-af94-4b2f37d75a96@amd.com>
 <61dbe8a1-6578-4690-8571-6b00c1850d34@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <61dbe8a1-6578-4690-8571-6b00c1850d34@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::17) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d130c6-ee73-4937-c2f4-08de86888f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4qnOHwoTaocZFJcItLe0RBvmtXnMEH+vapAEgMjOMbl6ZOfgMiSIgM/3tG4uBHzbYaYlEVwJ3DDExQvIoMrf4iXDFE8OVNJaPSNjuGeT+zGN5ossM+dNFaEq8kg7eEPK2C5EBjxvj9SwYolfd1+uFpzCEmEQiED5n0WzXzLsd0GrNM8j3uKEj7Ab9PxhJmCI94I6kQA7GqpGm3LfXiVS3siqRKNdGv4qk/PStMlPcBVijkQVN6igRZl5iV2bh9Xk2cJYRtKMoZX190+QeTKJV2WaiE12MIJNMWeAzMM70WarjiLx8S+Nx33x8FRxT67YdCGpKMZnOs1pg26h/QkXyOSh61F9EQ8M1/uqcS7k5O0bCaPvYP1w+rXA8sqRqGqVA62Xiy2taJl+J9CQUqzkq71pEG4fqpLy6VTPxTHlfUQtpoAhJgWYwoh0iRi+mCKTqqjyPD2mq2WfXYRN4yUD/SoyhjibhRYYfuikuXki6pk7NMeFak8wTe1e5OEllkcdZi4AewCIOTJ1Or23HvMMq3CaZ1fDM+gcoT0e9pbUWSoYzy9QZ7xDDJ0cFaPFlL89SI/mEQAO95PR7fvNNqECCSCpC01sXIZPg5ZTByiPiP/kfbKIrT7vk62/MDLki0PabeTdVWJa3hfciJRkblKR5Y4GMwvTiEAKuhpzGqHGOchRlZMRfuT7fQDMAXq3KrAe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW5oK2JyaG03U3ZlTmU5Y0tBUkNMYXdLbnNuSU1vd3Z5eG1PWFZhZjl4QlFi?=
 =?utf-8?B?QUVZcEIwUnM4VDFGbVRxZHR4aE5KemtBbHFrWE1HUmxtQ2JLRFowbVN0RE04?=
 =?utf-8?B?WEdFdldlckF1bjNvZ2c1TkJNYjNxUWp5VG1XMEpxSXhyakdSMEFnRGg2dzZ4?=
 =?utf-8?B?emoxZUZWb2Zmck94UG53ZlIvT2hPYlN3anFjQ25hUS8zNGxRNEtSRU9OdlNp?=
 =?utf-8?B?QzhoUFdFc2RndkJKMU1uYWJKTldRUk1PVTJwQi81dUlQOUVFYjlETHR4TGZK?=
 =?utf-8?B?anhJbUhaYTc5eXE2YWtxcC9Dd200Nm5zMkVDNXFGV0d5K2hEclhKa0NVQ3ph?=
 =?utf-8?B?ajgvYTQzQjJmaWRiZ1hEVGZRNFNzdHdGRTFqdkl6ZlFTYlBnK3cyVU5RZlhG?=
 =?utf-8?B?NTRxcmF5ZDBsMWhyZHZxcU1lbGlYbzNQL0FHcFp4dHE5dHVQNmdLa2prWldF?=
 =?utf-8?B?Znd2M3pzL3lEdmN3SWNKVGNWRDVZdnoxNWJJUzlpK093ZWpnM0lqVUxUTi9K?=
 =?utf-8?B?TWNGU2dDbStrMXJHRC9sU29rTElsOWJYK0J5KzRyaENPUFJmQ3NSZ01vSmhl?=
 =?utf-8?B?cFBLN3lHNjZhdmRpUXFGSG1Kbmt5ZXRXd2F5RTUzRDVVOTFDLzRTa0tDSDhu?=
 =?utf-8?B?dVR4NGpybkJDUTZ3VmNMTVRuYzJGTXpObXNMSUhIamNXdCtPZUZHMWdGQlJ1?=
 =?utf-8?B?WnduY1FINldycVF5VnZjb2t6L0ZsVFlxRnB1dHlHVDFPTCtrbXlRa25Kczd4?=
 =?utf-8?B?SDU4T2oyTWtlSWsxQXB2dWh2Y25hZFk3QnovU3NhN0FSTmlNb0VtRjBLRHZF?=
 =?utf-8?B?U3VvZnIrbXVXWEViVlpCQ09aaldmQVFnTSsrTzQ1RHhoTVMyVmN2anBXMC9V?=
 =?utf-8?B?WEJUSk1OcmpnS3BzV0lNQ3hzSmJweFcweE1JZTZrNFlZaDl5YXpLV1JWRDgv?=
 =?utf-8?B?K242Sm1wV3lLdFdnb0R0UldIdFNxWmRVTUhLRlhsNDVIc3crZkpOeENyREZZ?=
 =?utf-8?B?K1l2SElDelVhMThoWHVhNXhPTVQzWUJ6c0FjMXl5b1YxWmFlV2xEMVN0cUxt?=
 =?utf-8?B?cFZOTGN3aU9QcCtQOENFSHpKK0k1RHVpb2x0UXJsUVZEdU5ubStoRDlsdE9k?=
 =?utf-8?B?NnpXWVNTdkRSRzRndjJGcHNHT25tbHIwRUUydklBZ042V1JWcG5ROVNxMU9m?=
 =?utf-8?B?TkdBdnExc1FSMCtvNjR1UVN2T01XUW1xQ2VhcVhhT21lTHlyKzJGLytZeG0x?=
 =?utf-8?B?eHA5YWlQMy9xUTE3YlZxcXdJdEI1b1pxeGNqNkdpdFdReVBuN014aUNPRHVJ?=
 =?utf-8?B?dWgyZ0ZQMnJRVWpabFI3WUxvcWVLMFJpYlFxak1RSHZocVlrQmVDUHNaOHZW?=
 =?utf-8?B?MUVNVUJYQkFha2k2d2xrS2JwRitKbzR6aGZKZHFQMW95SkxVMTh1bUdIQzdJ?=
 =?utf-8?B?dXNSelk2Sjd5YmZDMXp2WVQ1cThmOEVscVR1MzJwRlhDa2tqTW5pYW1JRU5x?=
 =?utf-8?B?YWh4MjRvZG5sRmhab0wvdmwrOUVESk94QU5pUVhWZXV4cHBZa2M5RzM2eDNj?=
 =?utf-8?B?aHhsYVlJVnVvWmt5bUdNdjI0eC96RHpNc0E1ZjFMTzZWblV6Tno4UE1oL2tC?=
 =?utf-8?B?UWJrUXhGbVVLa1FHUjYrQ2hkdE55ZTRUbDA4MWNjRFBwRUxKMk1OV1IzelJk?=
 =?utf-8?B?aXpERmdOWkgzSitjWlgyZFhobjB0S0tBQlNuUXRJSUpkRmVHdkh1OUIwY25t?=
 =?utf-8?B?VlkyQklGczJ4NXVwdFozNlBtbzROYWRXWUxiemlLb3lzaFlrUy9naEVjc2Q5?=
 =?utf-8?B?MWJDM0lVdDAwcDUzQVdKcy9FRHdIQ0NKOHROVTBKZGc0eTdpSDZuWDJ6R1VW?=
 =?utf-8?B?UmszSHEzeWxaZ1FvVWNXWEhQM3Z5RUh5eUpFc3hvWkxmcVlRTjEzb3E3S3JP?=
 =?utf-8?B?RWZ4M3VBZGJHekYyV3dwRkUyQ0RnN2hJOEY1Z0RaY1ViVU10bXhPTFRaMWVC?=
 =?utf-8?B?ZlBBYngzU3NyTVhhSWh0RnkvUXBsWW1zd2FVUWdRNENzb0VBNXhlUnBuUDlx?=
 =?utf-8?B?NmxRdkRRa1VDUTI0c0YxMktwLy9vWEtxUC9pMUpWOHkvcDFxWlpGL1BHWStp?=
 =?utf-8?B?a3pyZGtTdnp5T0gvVXJBdjZqdFdheGlOMTZEQjE1a2plZGxGMnA1bTJUTGs2?=
 =?utf-8?B?UCtMNE9IWkNwTU1scEFadElSNWtxN0VmdXAvcXk1bjhxbXc3OXhHYThVWjQ3?=
 =?utf-8?B?VFQvd3pidENORWx3blBYNks2YnFqcVNZQTR1S1U0M0JWRVZLZVQxdnQvY2s3?=
 =?utf-8?B?cXQwSDZMVTBEUy9jQWxUc1ZZSFZLbVc2Ym5DTXhOUm5LWGVJMWo2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d130c6-ee73-4937-c2f4-08de86888f9b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 13:57:01.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9WgR3zvZQFRqkBb23viQ57+xO6is/it7ybebLXhGeeoVUcWM8SnxtglDZgC0vKW4fjcL7Rwlf7H4Lk+m/WTPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011



On 3/19/2026 4:09 PM, Nirujogi, Pratap wrote:
> Hi Mario,
> 
> On 3/9/2026 9:29 PM, Mario Limonciello wrote:
>>
>>
>> On 3/9/2026 5:00 PM, Pratap Nirujogi wrote:
>>> Add NULL check for i_dev->map before calling i2c_dw_init() in the
>>> runtime resume path. The regmap may not be initialized yet when
>>> runtime PM tries to resume the device early in the probe sequence,
>>> leading to a NULL pointer dereference. Skip the i2c_dw_init() call
>>> if regmap is not yet created.
>>>
>>> This race condition occurs when runtime PM resume is triggered before
>>> i2c_dw_probe() completes the regmap initialization and was observed in
>>> kernel v7.0 where the order of device enumeration has changed because
>>> of the changes in registering the device sources in the device 
>>> hierarchy.
>>>
>>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform 
>>> one")
>>
>> Is this the right commit that introduced the race?  Did it change the 
>> timing?
>>
>> Or was the race always there and we just got lucky until that commit 
>> went in?
>>
> My apologies for mixing up this change along with other changes that 
> were needed to fix the AMD ISP driver regressions in v7.0.
> 
> I investigated further and found that this issue was exposed by the 
> below commit.
> 
> https://github.com/torvalds/linux/ 
> commit/38fa29b01a6a295aedb69d1bbdad70acd7d204c6
> 
> However, the resume‑probe race condition existed even earlier and had 
> not surfaced because device initialization in resume is done only when 
> init handle is valid.
> 
> Here is some background and context on this change:
> 
> The amdisp i2c device requires ISP to be in power on state for probe to 
> succeed. To meet this requirement, we added this device, which is a 
> amdgpu MFD child to the genpd, to control isp power using runtime PM. 
> The pm_runtime_get_sync() call before probe triggers a PM resume, which 
> powers on the ISP and also invokes the amdisp i2c runtime resume before 
> the probe completes resulting in this race condition.
> 
> To fix this issue properly, I’m considering this change. Please review 
> and share your feedback on whether this makes sense.
> 
> - Call dev_pm_genpd_resume() to Power ON ISP before probe
> - Call dev_pm_genpd_suspend() to Power OFF ISP after probe
> - Call pm_runtime_enable() after probe is successful to take care of 
> system suspend/resume.
> 
> diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/ 
> busses/i2c-designware-amdisp.c
> index 19de518be30a4..9ce58522951cd 100644
> --- a/drivers/i2c/busses/i2c-designware-amdisp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdisp.c
> @@ -7,6 +7,7 @@
> 
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/soc/amd/isp4_misc.h>
> 
> @@ -76,9 +77,7 @@ static int amd_isp_dw_i2c_plat_probe(struct 
> platform_device *pdev)
> 
>          device_enable_async_suspend(&pdev->dev);
> 
> -       pm_runtime_enable(&pdev->dev);
> -       pm_runtime_get_sync(&pdev->dev);
> -
> +       dev_pm_genpd_resume(&pdev->dev);
>          ret = i2c_dw_probe(isp_i2c_dev);
>          if (ret) {
> @@ -86,14 +85,14 @@ static int amd_isp_dw_i2c_plat_probe(struct 
> platform_device *pdev)
>                  goto error_release_rpm;
>          }
> -
> -       pm_runtime_put_sync(&pdev->dev);
> +       dev_pm_genpd_suspend(&pdev->dev);
> +       pm_runtime_set_suspended(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> 
>          return 0;
> 
>   error_release_rpm:
>          amd_isp_dw_i2c_plat_pm_cleanup(isp_i2c_dev);
> -       pm_runtime_put_sync(&pdev->dev);
>          return ret;
>   }
> 
Good investigation.  Since this was around all the time and just got 
worse I would say you should add a fixes tag for the first commit that 
introduced this driver rather than 
38fa29b01a6a295aedb69d1bbdad70acd7d204c6 and just note in the commit 
message that 38fa29b01a6a295aedb69d1bbdad70acd7d204c6 made it worse.
