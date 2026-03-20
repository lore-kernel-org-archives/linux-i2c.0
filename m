Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E22D77FF;
	Fri, 20 Mar 2026 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021218; cv=fail; b=QM2tK0kDqR4etsb+bUvWGHZ7VUJNxnvyvepD2GC6NkpFZgyZZkL7cT6KbI61edofeZKs3kPzO3dEkwN6EchBTd63qJDeF3LwZOw+aBRRHW2mbQBPHvcuOkVtZn+HsMn4fF5ezbcNjfIAg2fZan/6kSvTLlrJ9x0hCJbzRn4J1gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021218; c=relaxed/simple;
	bh=ywyxs3VA3qxzDk1Qc/fehhf+0lBb7XKpJa2N/BB7D4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qaykmYAvUiTzfO8R5Au5LLka9llvpM7ukPMCslbk+mmfWgOqbML08Qe606AcvbnqQ9r9rZcxbw6LeECkAQjGpikJwrdkJXkCkj7CmiF8oSqc/KseTpoJemI2eQFp6Kk/WAm5mnMuTBd0CeVJgc69VKU1lWEWTze0r46omCk1kE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OBOPrGqw; arc=fail smtp.client-ip=52.101.61.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OBOPrGqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0UIaK3tGK7CdGcgkGEhorxwRCV3muGoB4khdUIAvGKIY8Huvva8ZM6x7riz6pBoeELXcsNSHDg0FaElIeP7p1tB2AXNEJxEMprDXlhoQx1liATP4IWwiv6SERji1Rx2k2TRj6Ij9X2qPinUfULMSGnECTzTB5vRaEXDZgAjvYvgRCL7JkqO3Oe+wSYWv6lDmx8kssveGjaRAZNTqjCGdiAv7ZoUNgLkeyDG115g6jQ4mLGXJoD7wVrrgiBYMER0OU6zblgJlrxJTeufzSwfu9AePSlSW5fBfYguviUsB0jbEzdA/Jch3Z6bfqgJ9f5wLmcZBV4iQbnmi97SgWlz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udOAyR1U2fJkTEft0CJa5VSaga5o0QW83duutOZqQFI=;
 b=XkvoVIz8HwK3+wIot/HxnCTKV7Fh9EXlvnQydscGez/fkhj5ttxrhlUtBrmm5qcCKZrHci2MWU09Wyt3Xa7VL519kK4pKlRhN9WIgZYKvYJsRygSnwKdIA8n9Ja6Dk4AjNrPmXKEQZDgFWOJe5YEZLFW7BdyQ+68+qZqfKeBpb4sw+F0yWhaQ3V4Ch0QzbBZq+2PgpNSsfN383Hnx3wlFhgVJYu4ach+w16NRkv8EUWUuZZVjE7GDeEHd6sCEnjCTWCsbuV8BTvNtprkCfyTJTSm7Ycm3hiNyx26TUsX1VHkTyzPa+PYDxWrJrbVQk2TKLyRHQWY7TlrSI4OuuX2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udOAyR1U2fJkTEft0CJa5VSaga5o0QW83duutOZqQFI=;
 b=OBOPrGqw8DF5yKJeKqNbhTYy/9VPULM9487yoAXHdchKmrXzA1zvYWd6He4parUB9WUapUIutiQZed6tYTwlbnZ34YoRyt8Y8rjc+HfzsjvZo4/9U/wQyS5pzfIiqEoJzPf3ztuYwgdATl8MxHWwx3sFpszGWG4+hxbpOhgsnu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 15:40:11 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9723.014; Fri, 20 Mar 2026
 15:40:11 +0000
Message-ID: <02d0bbfe-1b48-4c07-9dcc-3d34a60b55db@amd.com>
Date: Fri, 20 Mar 2026 11:40:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i2c: designware: amdisp: Fix null pointer dereference
 in runtime resume
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, andi.shyti@kernel.org,
 mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
 jsd@semihalf.com
Cc: rafael.j.wysocki@intel.com, mlimonci@amd.com, benjamin.chan@amd.com,
 bin.du@amd.com, king.li@amd.com, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260309220038.1420996-1-pratap.nirujogi@amd.com>
 <4527c72d-bc59-4f5d-af94-4b2f37d75a96@amd.com>
 <61dbe8a1-6578-4690-8571-6b00c1850d34@amd.com>
 <2b9162e5-be5a-49eb-915a-4a557b027e13@amd.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <2b9162e5-be5a-49eb-915a-4a557b027e13@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0046.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::28) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d20c9b4-0eef-4624-2868-08de8696f8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4QPcwTxqEGrfpks2UTE6PrxYmEza4C94WhTjOvaA4vDvw8XZOXfNVrj2d3fHdwW4peiombvGcnOtaWerHXoCWLB3/VHH9QyVcqKGYqC+34rNdiFRNU2/0+20+BZ6uZOF4nLsHU0z/hqjFLD41bw3U8EaxExRo1LlkbXAbC6z0YHLnermGv9cBrBzx3GfeOCf7DzycNnjd/rIsU8DOWS9mnJhrO0z8XSkYLiZZtlagI4yKKGHTCiPa2gEsS+FWvS3DC9cJT/v24bbyq7Qa4Lk44Ku9se5wA6o9OtDJqdvA1J9WPD6lADrvsyqQ29sGar3iqqgwlDlDTXxVXAshC8M+ZQc64xsvuof2nYMCqP5gHtwhFCdCe7q9Keu5kQKuxvf+Rk0fJYn74aMPxwX170VhOjREiZXQ1kTgpvnR5tMBpOdagVsxRYhdY4wE/9uQ2i4MCFo9CqLdO4Ov9S7GHbyQ3f6U7DVZhcdUq4n9tAtdyPdfVWhDSJcBX6K9ZVdVIJ9D19/0UdN42h/ufHtB07fTj0aYUkqWoiirD4z/mmpUd8jH8tTvn/kdhrVHpgJOO+QxCytFfoq3eu70P4xLAvrKU9eTkDLHq4TOsoht4cs+msNGtDRSoy68Hzr5IejoXmVZXqyxPYrgQ0gK14sMMeUXJ7pb6gmw7YjEKdS8iOrV9AO5byuO1oKEYQDEandIBVk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDhsZDhCOW5NSG4zYWloaHd5dlByQllheUFFdGV0cmhHUFQxWlJaWm1MMHhI?=
 =?utf-8?B?aFplUTRqU3BSdmJwZjF2T0JROHZYdXhIcktKaFBrR2dSRHhaMzYwd3pscjB4?=
 =?utf-8?B?czJRU0tZc0xUaGhHRXZoaWlhWHRGYk9nWXZIaUpyMU9lc1U3UjlweWh5Syt1?=
 =?utf-8?B?YnJtSUowc3N4ZEtkQmp2YVFQdjFRa0gyMk5KTXNPR1FJTldRVjNQdEdjSTA2?=
 =?utf-8?B?ZW44alExbUpmemUrNWZJcWVvaWRjYWVTSDdIams1QVl6S2UvUTQrRklUVnc0?=
 =?utf-8?B?aE4vNDJRVWVDMnBkZk12Q2VKNUNQc3U4ak9WWmNXK2xOT1d1T3NMUUl1OHRn?=
 =?utf-8?B?djFybUNFLzdhOXh3NFNRajVzR1NNcG00WHgwM1FlWFlFSHMyWFJQS05BWVNU?=
 =?utf-8?B?eE42K0dnVHk2VGJRZm9kcGtjcjkwdnR5Wk5vNm5OS2I5aTZvUjVvdktYdlVW?=
 =?utf-8?B?T1RJbFNyZktXMjBsSXJjSkV4elBRbWt0TENwSEVuTlhHNitTOVRwYlBXc1R4?=
 =?utf-8?B?QWg0Zk9Xc2hyTCtHUGpCSnhxdnVaazZ6YUNEWnV2alRSRHZJcTAveDNhU3pG?=
 =?utf-8?B?SXRKTWt2a095cUlLN2JHVHNjaUJ3OUZQTHNyVmhJdGtvSnJra21oSHZSMHVO?=
 =?utf-8?B?N0ZwTVM3QUt3VWs4MHkxVk9UaWRBbTdyaVYwaFY0YWtxdU9vUXkxdk14bk9O?=
 =?utf-8?B?d0dmVWdsdmlmWUVsM3FFZVlTdmhaakUzM24zTzVrOWpZazFpc1R1YmgxQVln?=
 =?utf-8?B?WGxWd0wxdEhMRjZkUXpXNUI1elViSzk5eEJKRDVSOVdLaGRWbHFBVURWR0ZU?=
 =?utf-8?B?aW02Q1d5YUxHMXRaQXI0bHZJY2hwSnhRUldYNkJzMGl5S1gxMjhGZzl5Tk9Q?=
 =?utf-8?B?NGdYU1JRUXp0L0h6a2kwTjFuUVg3bWZ4T3F6M0Q1NGVxT2dlLzh1YzJ3ek44?=
 =?utf-8?B?MVNaVGlScU4rY2Z4KzRZalVtWTcxSnAwRmJNVmZZWFdpN3l3YjNQMjdWMHkw?=
 =?utf-8?B?R25EQXBsbEx5amZQMkxOSXRnZUYrMndGNWw3Qlc5bGNHZHhTZXZhRjl6a3RE?=
 =?utf-8?B?bkRoU2Q2U3Jsd3p5UHBaMmFFYkJJRzdERGM4THhRSVBSYWZoKzhDeFFWcFBM?=
 =?utf-8?B?NmphbWdBMEpidUJrNzZ2ZFIvNnBNM3ZwdjBsU1hwWW1ZcmhHOXVpRFJkL2xB?=
 =?utf-8?B?TnIxYkNIZDQySGt0VlpZQmVHTG14cmlab1FuazBFTVRLd2htNGxoRzAyeFNp?=
 =?utf-8?B?Qy8vZ1JYR1ZKb0RlTzdDdjlkTi85M0VqcTBtVXkvbGdJcGU2M0ZtRWJDeUhC?=
 =?utf-8?B?ZXkzWFE1ZDRPMGdJRDlXKytUVWJLUmFjbm5odW1MdjBVMm1sSW51bkh5MjRj?=
 =?utf-8?B?ZXJDZGV1MVUreG8rb1k1R1F0VnliOGR2TWs0dEJaZ1Mxc3VEcENJTnkxaGdp?=
 =?utf-8?B?Y1J3VTFSNU0zQVNCM1BIeHBydzhzdGhVcWFHRjNOMzNpcjl6QUs4VFJOQlJq?=
 =?utf-8?B?a0FBWmc0dDdma0Zlak1qUi9mSC8xY3c2QnhxRjE2MDIrbUJza1Q1bk9VbjZG?=
 =?utf-8?B?SlZyRzRBbHVPblB2Vjd6VTFRWm5uNjduQXdwaytrbTQ4QUVYZCtLbENpaGhZ?=
 =?utf-8?B?SHNiR05JTWRBUlNwR2tSMVRjb2tmdnA1QXYvR3ppYzlsL1d4aFVnYmdxL0Q1?=
 =?utf-8?B?dE9yUGkrd0UyZ21QdEkzK3pJWHZkZ0ZsQlZpODVZNTFnRDh4T1FaMlJjbE1W?=
 =?utf-8?B?dkJhSDkwdTRrMVVQYVNQcDIwYUJDbXBiV08xZFNNSzVGRzEwWXV5RmtLQ3pW?=
 =?utf-8?B?OUpQd25aeGQvL3pxWUFJTGMzcDBWZ2ZGRE5yVUtGTUtSR2lPeDkxUE1nYW44?=
 =?utf-8?B?M1dBdDNzZjRPWUlYUDdaUjVpMmVtOEh1WCtFbXJnTmxZenltdDZMNEkrb00r?=
 =?utf-8?B?aWdvSmxReHJEeG4vcUZRUy91N2l6eVIvRUQvQmdrZGdBZUg0eUh0TW0vSEQr?=
 =?utf-8?B?Rks3L0FHYVBabVV0ZGlzNy9TZ3Y0aGZKRUU3YkxTVzFRSDZ5RWtLdHJVR0Q3?=
 =?utf-8?B?aWhDUzZpWE44RTJIMks5VGVHLzRvQ3E1WDY2ZWpZdDNTUTBFUXd0OU10U2pO?=
 =?utf-8?B?akxCaUN3WEVSM2Z2dUpFSFRzVGxhZkwvR0NmRG9ZRXpGaENoQXlkNk9xNGtR?=
 =?utf-8?B?MExzR2ZKSjRzNk1KbTVYTlgyYm85NWRVa3poQ1ZXRE9wQ1V1S0dmTDQ2ak1Y?=
 =?utf-8?B?Wk02SDhwemVuYXlaR3gzVk5ONHVqNVJyMWhPNDlKSXJOME11TlgyVmFWMEVI?=
 =?utf-8?B?UlFUNm9Td2tobFlvK1FoWnVnN3I0S0R0Z3RFSkVGNXdtUlowVHlHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d20c9b4-0eef-4624-2868-08de8696f8ea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:40:11.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqSnIuazvC0PxHSvR1lO1Dfv+2hN9x7Y3OezUpxUpQvwyhEER4dk9FpKBkJjoNpbV0VLIDxt4ydOiketQIFOzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156



On 3/20/2026 9:56 AM, Mario Limonciello wrote:
> 
> 
> On 3/19/2026 4:09 PM, Nirujogi, Pratap wrote:
>> Hi Mario,
>>
>> On 3/9/2026 9:29 PM, Mario Limonciello wrote:
>>>
>>>
>>> On 3/9/2026 5:00 PM, Pratap Nirujogi wrote:
>>>> Add NULL check for i_dev->map before calling i2c_dw_init() in the
>>>> runtime resume path. The regmap may not be initialized yet when
>>>> runtime PM tries to resume the device early in the probe sequence,
>>>> leading to a NULL pointer dereference. Skip the i2c_dw_init() call
>>>> if regmap is not yet created.
>>>>
>>>> This race condition occurs when runtime PM resume is triggered before
>>>> i2c_dw_probe() completes the regmap initialization and was observed in
>>>> kernel v7.0 where the order of device enumeration has changed because
>>>> of the changes in registering the device sources in the device 
>>>> hierarchy.
>>>>
>>>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>>>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform 
>>>> one")
>>>
>>> Is this the right commit that introduced the race?  Did it change the 
>>> timing?
>>>
>>> Or was the race always there and we just got lucky until that commit 
>>> went in?
>>>
>> My apologies for mixing up this change along with other changes that 
>> were needed to fix the AMD ISP driver regressions in v7.0.
>>
>> I investigated further and found that this issue was exposed by the 
>> below commit.
>>
>> https://github.com/torvalds/linux/ 
>> commit/38fa29b01a6a295aedb69d1bbdad70acd7d204c6
>>
>> However, the resume‑probe race condition existed even earlier and had 
>> not surfaced because device initialization in resume is done only when 
>> init handle is valid.
>>
>> Here is some background and context on this change:
>>
>> The amdisp i2c device requires ISP to be in power on state for probe 
>> to succeed. To meet this requirement, we added this device, which is a 
>> amdgpu MFD child to the genpd, to control isp power using runtime PM. 
>> The pm_runtime_get_sync() call before probe triggers a PM resume, 
>> which powers on the ISP and also invokes the amdisp i2c runtime resume 
>> before the probe completes resulting in this race condition.
>>
>> To fix this issue properly, I’m considering this change. Please review 
>> and share your feedback on whether this makes sense.
>>
>> - Call dev_pm_genpd_resume() to Power ON ISP before probe
>> - Call dev_pm_genpd_suspend() to Power OFF ISP after probe
>> - Call pm_runtime_enable() after probe is successful to take care of 
>> system suspend/resume.
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/ 
>> busses/i2c-designware-amdisp.c
>> index 19de518be30a4..9ce58522951cd 100644
>> --- a/drivers/i2c/busses/i2c-designware-amdisp.c
>> +++ b/drivers/i2c/busses/i2c-designware-amdisp.c
>> @@ -7,6 +7,7 @@
>>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/soc/amd/isp4_misc.h>
>>
>> @@ -76,9 +77,7 @@ static int amd_isp_dw_i2c_plat_probe(struct 
>> platform_device *pdev)
>>
>>          device_enable_async_suspend(&pdev->dev);
>>
>> -       pm_runtime_enable(&pdev->dev);
>> -       pm_runtime_get_sync(&pdev->dev);
>> -
>> +       dev_pm_genpd_resume(&pdev->dev);
>>          ret = i2c_dw_probe(isp_i2c_dev);
>>          if (ret) {
>> @@ -86,14 +85,14 @@ static int amd_isp_dw_i2c_plat_probe(struct 
>> platform_device *pdev)
>>                  goto error_release_rpm;
>>          }
>> -
>> -       pm_runtime_put_sync(&pdev->dev);
>> +       dev_pm_genpd_suspend(&pdev->dev);
>> +       pm_runtime_set_suspended(&pdev->dev);
>> +       pm_runtime_enable(&pdev->dev);
>>
>>          return 0;
>>
>>   error_release_rpm:
>>          amd_isp_dw_i2c_plat_pm_cleanup(isp_i2c_dev);
>> -       pm_runtime_put_sync(&pdev->dev);
>>          return ret;
>>   }
>>
> Good investigation.  Since this was around all the time and just got 
> worse I would say you should add a fixes tag for the first commit that 
> introduced this driver rather than 
> 38fa29b01a6a295aedb69d1bbdad70acd7d204c6 and just note in the commit 
> message that 38fa29b01a6a295aedb69d1bbdad70acd7d204c6 made it worse.

Thanks, Mario. Your feedback on the Fixes tag and commit message is very 
helpful, I will take care of these while submitting v2.

Thanks,
Pratap

