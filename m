Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ABD3FCB39;
	Thu, 19 Mar 2026 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954608; cv=fail; b=FT0wAx+b4F0u11ks1pKfVRYU/r31No4BbiBY8yqW0cxVdlLcdtkrryVtIobA4MMdYR0Hib2xeUNmBCThromDA9Z0fiAXp5SyAziPcKNWUxVfk5Z6Go+x6Ks/en31gS0GBxTyWDuVciRKyzM1IaDJYaQNBArJwOjptgYUGSffZiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954608; c=relaxed/simple;
	bh=oKF1uYd3nhQVw68ezPRrz+ZENwHpU3ulz0fXYhwlyNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KMzeaC8VLfYYXY5HXiJObtjC3rhZnD0+aDDpiTZktZmELJZ8rjGAXhexoLhYRjizaRcakGQSzi9wQAZgaan9FudP37BlRBTfeT7Rd5Tlh0+gyM0T+Z0p/P3mj9GaQl0JVdo5zOOZInZlfrU1haZ3O0H6PPTcLiLlJjlgejZja/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WV4TEnRV; arc=fail smtp.client-ip=40.93.198.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WV4TEnRV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDVau3ENRzlBtbuvyJahqbDhPLKyhMIqQSalxkn+Pu6r7+o7w2784w/n/cWmx7DeaKRZJj4EJduSnWDVRDYGmugkICxFs3hdqE16By/9gz7B71O1lMPuwNx9oGmeL4f7XbPmjSHAk8CE2l77CsfqddWygMMppQ0n/8CkDHQWExervcvX/7K4vf/GQrsHOj5gUu6pzkt/kIMorVCrC7wsPIiBYarCoqDL+ZPZ2LE+lz1r0sLGTvhQOn/Akp934ZxNdbNTIedY7gicFIwlnO+AfA8B8sMWiqvCwI9EX5pBjYI8yv7/fD4nw0mFis1ogSZEch00uXmB8eHAp0aYNv5l5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIUoe9GeJj7rMj+4s1P5OVXzx3FM/Asdsi18nyXoJXk=;
 b=CzqX6ocPyCvK+FNTd37yER0/bnxVqV6pvcQP0KiWueeGO2456Lme1WeoRD3v/5Do7QaFT7QsM8z3IubRdnT2iB3S6SwGUkAxDqx9odirk9/vY9BIE2ErREJd51+0y7Wdv/+8tYXuA2DKx6+4OkKPDEB2r5gJYcP0hP5B3RbnhR5XgNeaXkv0CI/Tp4Bt7wkrC9dvZPVgnRmARKaq58JJam3nWyVDsm5Vlnur3g0bd1/deFIb7rS19Jk1Jk6V1e3YQmutMfXFyKQQ2o87Tn9RMsXvV9DiuLZjW6VQVlmKhb4bb4NinI/OvdBoe9pCHBEa05AZKwrFL/wG4AY0LE7Hbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIUoe9GeJj7rMj+4s1P5OVXzx3FM/Asdsi18nyXoJXk=;
 b=WV4TEnRVx5+Sk03afSQ0IS8y4CU4tZ6XupdEXqqlMxvFoSVI6oeN/PNi9FTPCBSkm5huxtc4NhbljgQvb+jVLKSSyfvieiGkKbCEqC2XQuroW6YR2x7N7r13mDWPA6JTbLdJNSyBaQdp9iuzgIhk3RtQFEKYSuEibijqgxoG1yQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Thu, 19 Mar
 2026 21:09:58 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9723.014; Thu, 19 Mar 2026
 21:09:58 +0000
Message-ID: <61dbe8a1-6578-4690-8571-6b00c1850d34@amd.com>
Date: Thu, 19 Mar 2026 17:09:55 -0400
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
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <4527c72d-bc59-4f5d-af94-4b2f37d75a96@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:610:56::21) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d0bffe-7fb9-4b31-011b-08de85fbe068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EpgivUAPS80P81C5k1V6gGUVlnCRGM85z9JCQTjNd2YC+UXVX6QBDglGQ6zqc8RuO5Q9JQNpwJF/WuUpOCKqVlYQ6WWk4AmqexGwxNwcMBG3dD7z7JadmFyn3bZhfE8KPQE4PHAaffCcN+t3fma224QOkmPW4iFL8v8IX+gSQuAVUTTl+pw6jDsaIhNYVEpFs/Y1nu/f0B8q+eN1w5BOBE1o5DpV7pBqn6nxkPVFj5mZNgVgWE+kH72LgOWE6PU3RFsYiWhWm+MaiuNcmPgx2Ynv06ywgBjnZ/SfE72aJuXbAVc/Y/nZXN7g/xThpHWRSoQqDRpszsLWTvaIc8EW7dSYhVx2aFgd0AqY//W4BjLcgVOiP8zDLJiKgp2c8/v76OI0EF3CV9HMnuqXO93rWNWXl2DnoqTR41LDZxQiHcG3tHm1unnurbLAegswUvdAXRLzPl7tsaNi4so5lvMnp+OhyZTUT2KNbV5H5hAbQsYIKap5Sqx6z/v3B1CpDdEvsmkWuarch+6AxMxnUrCMiLVeA0O0/9nx6VYEJbFT/1FzNqxKuyyXEq1QnQUvmYo9npVXycy2l8WEUQ3ho+VMljK1EWfqv3fYWfn8Lj5WHm8LHpNeUZT6H16JImcoOcCYV0nBJzN1mNEsxRXjl8IGtUw0lHtsAJ6OiDpFZNBXk9slEcvdav7FyAtrbPG8lzWt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3RRa2NEaWNJQjFKRUo0ejVmV2p5ZGdQb3B5RkpGTW9ZekpTdk1Kek44RWl5?=
 =?utf-8?B?dklOTlBYZGg4UTNBdEdqcHJXQTB3WXNGcGlQbkpYS3NMU2o4WVpLS1RSNms1?=
 =?utf-8?B?UmpxT0VEOHRxa2JJTnU3QnVJaEFoczNXRWw3THBVMkRtaGhKSGtpTzV1UGV4?=
 =?utf-8?B?NnlRT0dNbm0zSEhsMHdacmljcmZyS0Fqbk03dmxUaGJUUkZTVWZQQzBQWlhC?=
 =?utf-8?B?OGN5cGFIaW5GM2syVVhuSUJBUEdZdzJOTmhlNlJDVm91OTRaMDVEOCtDRmlq?=
 =?utf-8?B?dHhndWRZd1Y5L3hkR3Vmc3JQd2w1TDZ4R0dGeW9ubmdWN1NlUEdGUmVPaHFl?=
 =?utf-8?B?aGNsQzJQWVRDUVJVOWlObXVRd3V6Q3BYbFFlZmdRVDhKZ0JRdzN1Yzh3SVFX?=
 =?utf-8?B?S3BIcVZ5Z0dvQ243QTFMUWNHYTdvbnIvakYydnZwenJCNTFNYXNSd29QVjAx?=
 =?utf-8?B?UUo0T0sxUUpsN1VuK3dMY24vNGoxT2dCU3c1UG9JcG16T09ENHdnNnB1dEc1?=
 =?utf-8?B?eDNtQWhRMm42cWhJQXV3b0hjcWQyeHFKaFkzUWsxNVhUZzNiYSs5WTJGaUdS?=
 =?utf-8?B?TTFTZkxTR3RqNSs4TXZ5aTFzZmdLbHBFZHdjQ0JFZEd3M1FnODNoa3NtNVRO?=
 =?utf-8?B?VHJlNFZ4ZkViYlppKzVVM1hTUHE0UHc4K3NVRDZRbERGR2oxQ3RFMjVIdjRy?=
 =?utf-8?B?dldsV3FhSzdBT3A3TEV5bVBQelM3Q0J2V1AvYWFVbmxoaGc2TkU2Ulp5WFJV?=
 =?utf-8?B?NWJzWGNVQThvdk1KamJjSUVYaThCOEhveFYydFBuQm5iRVBFdUplTW1JYm4r?=
 =?utf-8?B?bEZnREU1bkZuOFBBdXZGQ3orNnR1elZORTR5TmxzQm1jWUZQbS90VWRtR1Rk?=
 =?utf-8?B?SGducmdkSmpMRHNXbkorbSt0cjFnQStzclZwbDUzNGFuSmQ1YWYvYlRtWGtp?=
 =?utf-8?B?UGdscm8wWDhLU2ZuTXlBS2Z5cUdWVS9QZDlpWk1MdzlNVUROQk1UVTNEdTA3?=
 =?utf-8?B?Z29Dd3A4djRWaXZnUzArZ0QzeWtSRHQrR2VHVzRhYVphSThuWGVsa3JEeHVG?=
 =?utf-8?B?c0pPMTJPVXZMOWVOOVpvaDRmczUyMFNNdnpYMTBBM1g5NjFuSVprd3MxL2Ri?=
 =?utf-8?B?aXhabXFvUWNwd1ZEUWMrNXVXTFZPeXlpR3dGLzlIWU9aLzc2QldPeXBSaVI5?=
 =?utf-8?B?NTFmSnVTMGxPY0N4cnc5bE55YlhpMFpRMFhiZHh6bStVY01oVkt0Zmd6VFc1?=
 =?utf-8?B?bjZnbWI5MUFCdVpub2U3dTlSY3ovakJsQnZLek56dzl1T3AxZjVCOXZJUkpX?=
 =?utf-8?B?ektBUUJmMERpZDRkL0R2ckkzOUFOdUx2ZzZxM2JVZlJKSUVWeXdrbVcveVJX?=
 =?utf-8?B?OXh4bWVxZENqSmtnc3NwbVVzUWFaOVpvc2srRk1qUmxwcU1yV21uRzYyK1Ew?=
 =?utf-8?B?aG4vY0lJZGlBQnorNkFWY3RjL1k3V1VCSDFuTW5EQmFKaGlkSDY0TVlXZGZt?=
 =?utf-8?B?SXVTSWJTb00rWndRUlQrYlJNckhkYVRVN3pkSDR0QU1kd0JOKzUxUzhDTm1n?=
 =?utf-8?B?K3ByRFhPcW5xeEduYUhvN0pOZHpndGw3emZaNUxIUEExMWJ0OGJKR3dYR1Vi?=
 =?utf-8?B?ZytudE1UeVN1dWVmY0ZKaGxBckt3MDRFc09IVUp3Ty9vd3l4RGJ5YmZPR0lI?=
 =?utf-8?B?SWd0VnhrbmlRdGMvSjhhdDBHODVDbG11eTdqLzBBSEdCU0M0SVlGWFJwSzUx?=
 =?utf-8?B?dWdoMEsxNXcxM3BtbW9HWE9PM1d2N2lNRTY2TEhPVEp5M3doNHhpTU4rYlVw?=
 =?utf-8?B?c1JyVStrMGRrOUxJSDFEMy9GYjlSeVlCTjd0Y1ZrVU9mOHJNdkJweXd6NVJv?=
 =?utf-8?B?UFMvd3JsSFpSMTQ2Y0YreHQ0RnpLeEZpdXkxdWMwZmFicWlXTm1RVnJPK09q?=
 =?utf-8?B?WkUxMzlCSTNzTk1FUk15aWw4R3M3amZFQ3R0MlBrTHRNOGI4bi9BMDNCdDlj?=
 =?utf-8?B?R1pPSmVHazRYU3RCRDdqMEdtSFQ4T0dvT012L0IwNnRZWVIwNkZaWDd2Y2wr?=
 =?utf-8?B?dzZPTllONFdDMHJveERyRHRtNk9iRUFobm9vTmRYc2VIbmxNMnBmbElNeXpH?=
 =?utf-8?B?c2ZKWjd5WmUvcE54NDRYS2swencwZGFmSEZwd0xSSml1VzNHV3V3TUN0U2pB?=
 =?utf-8?B?dUp6VzNjNTkzU0pwcmlZMTNkRGdSczFqZ2l1L0VDSmk2MXc2ZXdwNWsyS0R6?=
 =?utf-8?B?UmhWaDNSWFJneXFvdnIyVkU4aEV3U1hXZXhrTjRNNDdJdTBTUEN6c1NzUHlQ?=
 =?utf-8?B?VTlkVy9kUHdmenA1YXJFZkxxa1ZLUHorMWJic0lSbElUSnIyMzF2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d0bffe-7fb9-4b31-011b-08de85fbe068
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 21:09:58.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw3uCrc60x6RnOHWvkaBbrgyeeacvxhHDu3Noe9xHbEUlmOeAikTBjIFPmyX6I+RPOzGEZEOEf/b1PgKgzRpjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771

Hi Mario,

On 3/9/2026 9:29 PM, Mario Limonciello wrote:
> 
> 
> On 3/9/2026 5:00 PM, Pratap Nirujogi wrote:
>> Add NULL check for i_dev->map before calling i2c_dw_init() in the
>> runtime resume path. The regmap may not be initialized yet when
>> runtime PM tries to resume the device early in the probe sequence,
>> leading to a NULL pointer dereference. Skip the i2c_dw_init() call
>> if regmap is not yet created.
>>
>> This race condition occurs when runtime PM resume is triggered before
>> i2c_dw_probe() completes the regmap initialization and was observed in
>> kernel v7.0 where the order of device enumeration has changed because
>> of the changes in registering the device sources in the device hierarchy.
>>
>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
> 
> Is this the right commit that introduced the race?  Did it change the 
> timing?
> 
> Or was the race always there and we just got lucky until that commit 
> went in?
> 
My apologies for mixing up this change along with other changes that 
were needed to fix the AMD ISP driver regressions in v7.0.

I investigated further and found that this issue was exposed by the 
below commit.

https://github.com/torvalds/linux/commit/38fa29b01a6a295aedb69d1bbdad70acd7d204c6

However, the resume‑probe race condition existed even earlier and had 
not surfaced because device initialization in resume is done only when 
init handle is valid.

Here is some background and context on this change:

The amdisp i2c device requires ISP to be in power on state for probe to 
succeed. To meet this requirement, we added this device, which is a 
amdgpu MFD child to the genpd, to control isp power using runtime PM. 
The pm_runtime_get_sync() call before probe triggers a PM resume, which 
powers on the ISP and also invokes the amdisp i2c runtime resume before 
the probe completes resulting in this race condition.

To fix this issue properly, I’m considering this change. Please review 
and share your feedback on whether this makes sense.

- Call dev_pm_genpd_resume() to Power ON ISP before probe
- Call dev_pm_genpd_suspend() to Power OFF ISP after probe
- Call pm_runtime_enable() after probe is successful to take care of 
system suspend/resume.

diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c 
b/drivers/i2c/busses/i2c-designware-amdisp.c
index 19de518be30a4..9ce58522951cd 100644
--- a/drivers/i2c/busses/i2c-designware-amdisp.c
+++ b/drivers/i2c/busses/i2c-designware-amdisp.c
@@ -7,6 +7,7 @@

  #include <linux/module.h>
  #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
  #include <linux/pm_runtime.h>
  #include <linux/soc/amd/isp4_misc.h>

@@ -76,9 +77,7 @@ static int amd_isp_dw_i2c_plat_probe(struct 
platform_device *pdev)

         device_enable_async_suspend(&pdev->dev);

-       pm_runtime_enable(&pdev->dev);
-       pm_runtime_get_sync(&pdev->dev);
-
+       dev_pm_genpd_resume(&pdev->dev);
         ret = i2c_dw_probe(isp_i2c_dev);
         if (ret) {
@@ -86,14 +85,14 @@ static int amd_isp_dw_i2c_plat_probe(struct 
platform_device *pdev)
                 goto error_release_rpm;
         }
-
-       pm_runtime_put_sync(&pdev->dev);
+       dev_pm_genpd_suspend(&pdev->dev);
+       pm_runtime_set_suspended(&pdev->dev);
+       pm_runtime_enable(&pdev->dev);

         return 0;

  error_release_rpm:
         amd_isp_dw_i2c_plat_pm_cleanup(isp_i2c_dev);
-       pm_runtime_put_sync(&pdev->dev);
         return ret;
  }

Thanks,
Pratap


>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-amdisp.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/ 
>> busses/i2c-designware-amdisp.c
>> index c48728ad9f6f2..cd7ee55fbe1ee 100644
>> --- a/drivers/i2c/busses/i2c-designware-amdisp.c
>> +++ b/drivers/i2c/busses/i2c-designware-amdisp.c
>> @@ -153,7 +153,10 @@ static int 
>> amd_isp_dw_i2c_plat_runtime_resume(struct device *dev)
>>           return -ENODEV;
>>       i2c_dw_prepare_clk(i_dev, true);
>> -    i2c_dw_init(i_dev);
>> +
>> +    /* Skip i2c_dw_init if regmap not yet created by i2c_dw_probe */
>> +    if (i_dev->map)
>> +        i2c_dw_init(i_dev);
>>       return 0;
>>   }
> 

