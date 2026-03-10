Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678F19D071;
	Tue, 10 Mar 2026 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106152; cv=fail; b=hM7K0MjHRly0hmZLbQCMiqdFszgfQAdk59cdR0jjHPvSwjupppUNMMZ1R/sJKdtlcGCmd2XROKRKOHLOJKWwkFqm9L4EeoW2jpUgm4+GkaksYY4iwpnHD9r2kTB8JtBl5X2O+YJKhUFENXySzJ1CyliPQAA25zxIDl8OwccxE98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106152; c=relaxed/simple;
	bh=vONqcaxFvsao6tGYQfMnXu7OmWpfiYCv6Ny9OSbec8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pNbybzNJufrhqsI7S/Q8dsEnx06A11zV4/ja/wU1pbSOmuwr1tTVl+lvJHy33jynCp1oEw11SWyszxJ/8my9qYyKXy7RbwKZZ4MfCBVuaSePFCRrqZFWuQFi8Xt0UvdReaVR2VyPqMXeDVDR+fe8J8tFJaWFuCUMN2oLSOAsIZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1C16XJk/; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1C16XJk/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pez92T2I83atkXdUs0AWpZ66ErK5jKIsKB4VnirpH5iTqo3hthMe+Omstg4FWUZ4QdC1rEgtSECByQ4HzTPGSBdEWufIwbnMgJH9z4H+SSn8Rkqfphuzi/smpRXDsjlGHPG7y9m5UOBw0+zFsMYgdIzFfa39gCoEZqPpjvXmfb06aDjSGzge1iqVxGLwpxdRLxH9SIo4n5bi+LRkEnGuuZNb+BbOrzXkZbT28Aj7+hcXMPHzdlyXvQESjEbXCKG97FTWXZXB41ksQ2JffiyiA/oxGl/CHOspK99+Ui5pk817LPF+aYTIihHKOhcPDM1X6cAxUSQXiYyJER+AO0APjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tSaOeH8q+Tiglkzkg9wpvFvTa3vfeuRcUZpcXeNg2g=;
 b=M+9zbZGhG9lefTeTZFEXDhIIShJqpZaBdpDDGku8IPiTE4TE/PLfDsywCxoOTGsRnSJUlwQQkSkwPfBIk2x+v/pBMt/XnTCr0oALNawqiLABGziPY0UtksCOAfLonCV2tuRU99GfNXCqh+lCg4qce4OaoEQU+vqDAXEQCCUpKRIXUCAHYJI2PWb318CGByFIQsFr6YtLjoEnV470FrrMoJR0b3TIsp50nBlfO2lRCh31cY0J1qmXPzxn9kp+1QUgKQ+DLmmSj1xq98Y262V/OUIosr59YWzwgAU+zj70XPUSp2Mt4062UAmsvo3ZtI52g8dzUBEaZXCUwJzw/EH61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tSaOeH8q+Tiglkzkg9wpvFvTa3vfeuRcUZpcXeNg2g=;
 b=1C16XJk/2EtlO76ygVW3TpcT8/5l3LzNYCtmK+8oTXTfdNoVbOAzKudWYNyXn+aDIO4ABPfN0+cTG0plKAxlRzWP7FoJM0XDaHbdR+Wje5Dq1mIhnrucAcqenO5wIN5L1swVXHLv+1XNHEPtltpjZTxrv4mFN/NbCBVzmL9Jf8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 01:29:08 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 01:29:08 +0000
Message-ID: <4527c72d-bc59-4f5d-af94-4b2f37d75a96@amd.com>
Date: Mon, 9 Mar 2026 20:29:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i2c: designware: amdisp: Fix null pointer dereference
 in runtime resume
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, andi.shyti@kernel.org,
 mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
 jsd@semihalf.com
Cc: rafael.j.wysocki@intel.com, mlimonci@amd.com, benjamin.chan@amd.com,
 bin.du@amd.com, king.li@amd.com, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260309220038.1420996-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260309220038.1420996-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:610:55::11) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2e47f2-0444-4a1a-978a-08de7e446cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	3AXyb6B28PuuQzwkm9ZhCNAa2PwfScAbSIBsT4nSXGLrAWo89NDEDjywe4aboxgh6kTTkJpv6jpDWWTJKBuYC0jSvMuUmriBkVmRphbxPUGCC/Qkh7xNFYA04SgXG8gv9QOpjs+mtNUMwl7egGfxHtQtr8fH5C8NI+ksB0PhKSrLykamd/UyBohk6nM0kbYR9RtSVB1b05pco+J+B9pKNIjSzkCiQPO+EtVaMDOTX9d6XCU9Hh8JZDR2lYcQN2GaZJLESRcDLs2+dOfMpK6trB9m/G+/XjUaWm7zGPNSd3OD6qqGWqkr8kPV1h5P7/lSMekE7ZV7kqK7nthOmFqjuZ9F8bYOU/ATKPbbAeRe+VMGVtBo5DC10HnYMXvQgn1UAToBm7uxKfiLOxn0v0Hqxta+au7dlliBkZuBFm8r0VJOMzCfFaLVnnVI1k1dTDRchsTjxcloWQ9qn8rSuBmkOAIKZGS2RyhVG9iqByYEJ4T1p50VSo5/H2hlq9yZg/E3/pFEKAoV+NYnAB6f2Md+QEx0F5YWgClEWKbOoirwRZggaVobrP3rRYEWlhgSs5b0gPEi6/pQ+Z71fPR5Io4VPKbUXlYasV1hDaGUopcHuV6+Sx/0qi+g0SaXCNVFd/A2KlIv/gtGILlxMhWF/bBy/uy8JVgd4RqD+bMN/o80X7EfhPa7g7YzfozV5QMH18rHco3K2igvrIqgibJt3SmfGkb5WdpTU2/lJ6qy1T3zzt0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDlEQ1VBRDR4a0Jpa0tkR1hacnZ0VkRzalNKd0VQOEh0V2FjbGJidmtGMDRs?=
 =?utf-8?B?QUJrVnkwT0lkZ0p3eDA2dGViSE9wbm1mZGZwVlZ6UnoxdTdtKzVCckZOdlgw?=
 =?utf-8?B?L3UyaUl0MjdFMmdLQUwydFkwaVFYRkNtc09uelBsd0FXQ3pCVkhwUHlGaWJt?=
 =?utf-8?B?OEtiUk5McTJMWmM1bzBvSFhyZGc1NU4rVGh5S0RvbHVUZmkzY013cUY3bVU0?=
 =?utf-8?B?cVE4bVAyTUxjSVhJR0Q4bytUdmtqZHo4ZzVTWm9KQ05sM2FDUDl0UGErUkkz?=
 =?utf-8?B?WXpUK1VueUNyaVZSUmtFZDNCSktKVHJwYUdlYjFFMDJGanorZnh0Z3Zva0pv?=
 =?utf-8?B?Z0ZRR1RaU0w2TGoyN0h1MVUyOGg2dXpaSFlRTWdUcFQ4RjhERE9uQXlmOHVn?=
 =?utf-8?B?UEs5ZmJCMU1oY3BvejR3V0hFRzJScGI1UkZZVDFLdHNKR2k4cDVsOGVxR0dt?=
 =?utf-8?B?aFlDOXZSakRObkx0bHI4Nlk0Yy9yb2lVV1RNbzNSTks0ekhSQ1IzOExHb2FM?=
 =?utf-8?B?NUxVRlpwYXB4TU1ocnlORGtXQmdsUG5JYVM3cmFPaHlMK1ZrSHArRlZxUThE?=
 =?utf-8?B?ckNpOGlqL0hRSlpwb3lqV1g4ZjUrUU1QdzVIS1ppa3hSYWVUYW05RXFVdlJI?=
 =?utf-8?B?alBVeUNRdVdZUW1ZSXRvM0dES0lYY1BFcjR3NVJHVVRhcXVkczVUWFF0bzNk?=
 =?utf-8?B?Q0xsNDNhTnM4UGhoT250cHZCQ2N1RWZidWQvenBxTFdjNC9laHkxcndzRFFh?=
 =?utf-8?B?a3NPQXlIdFZXYWF3NGEweTgxTm5BWnpoVVhXaysxODA1SCtmZXFNV1NZRW1h?=
 =?utf-8?B?K3c0blk3VXBnclNFSURpR1BkKzFBRlFqRFVuWEE3OW9aUUVSOXZlYjFxUVFL?=
 =?utf-8?B?NTFPem1HbkFpalRhVFJPQlNNRk1FckFMaSs3Rnc0UHJlVjgzMWIrM0tiVWIx?=
 =?utf-8?B?VWduWXBmVFFzakxKVFBlTFdpQVB1VWtWUEczd1hMMlBLSmd1THhtNHk4VGl4?=
 =?utf-8?B?TXF0SjRZZzVIQ0FSc3EzeEFnS1kvdHlmRG0vTVVpaS9RelB4MFY0blk3TVlF?=
 =?utf-8?B?NzJWYnZIWHVSaEZPWEdJbGFEK1J0d0RpdUpPcWZZZTUwQ21BVWNsWkQyWXM3?=
 =?utf-8?B?M1EzOUFhVUxwS21QVVVXS1pIbThVM2t3Kzl0U0xFd1hHa3FDKzdudDc4S0dU?=
 =?utf-8?B?SzRXKzR1Y0wzQjRzTkZWL1NnZmhJVTd0RjZtZjhnREtkRWFHRkpwaVVUL3RU?=
 =?utf-8?B?OCtoSnd0Mk93aEVjcVprYkY3R05zcnRqaHhYWWh1Z3FUWm5YYktndzBtK2Fq?=
 =?utf-8?B?OTFMdkVBY3AxbmVzN21zOXJOZnppS0dJTElkWFlOYWRXQmZuV25Dc2hZRDRj?=
 =?utf-8?B?Wk9TVGRCSkc4TGJXMXlRY2RhMHA0a0JxSk5WV2R4RXBPemdXODZVYzdSMlF3?=
 =?utf-8?B?WmdDcjlDQmRVZkFGQ1pWemdJQzcwcjVXSXl5MDJXcUV2Z2VkNDVDR25ON2Vm?=
 =?utf-8?B?V0I4c3JPSVo2L051d1NGSG9BS3IvYnJUTXk0MXRtZ3dhWEU3Znp0THlCL3JK?=
 =?utf-8?B?dkUwck1ZR3hVTXZvVGczaEhYL3ErTGJiSUtLaWsxWUlPdTJkaklOc2lla2VE?=
 =?utf-8?B?Q2x4V01WU0J2UVJrSndzM1AvS0N0eDQzY2lEcEcwQzYxQzEzMW9DZUFIUWQy?=
 =?utf-8?B?UXlXenlQQ010dGlSZ0hqRlJQeDVUcVJDamttTXdDWlhLeWRRQUdCZFJzVm1F?=
 =?utf-8?B?cFFBbXA5YnE2WE1WUG1OWnk5QzlpTDEyYStDOXBMZmd0a1VHeVM4QVJPajVm?=
 =?utf-8?B?V3NSZmlsM0tHU2FlZjg4RlF4VEQ1ei8wdkg4YVlNYTBEeWtrSnY1cnpOY1RX?=
 =?utf-8?B?Rnd4UnFtWTl5Q2RHWTNtQjlUVEVaZ3hqMTdWdDBSQkUxdENDRGlLRlU1YjVN?=
 =?utf-8?B?Ui9la0R2S2NmNUtSNzNWcUNHWnZkQkpyV0RXRFRXRjNYTW8zcUtNZG1iQlV1?=
 =?utf-8?B?dWZ2WVJLRmhobmtDWDdEeHU4U0ZRQ0N0akpsRW1qZmg0UlZ5RU9PaWd6ajZG?=
 =?utf-8?B?c2VGM1lOc01ha1R1YkN0N2tGUVFlKy9pelpYNGNXY0Z6Ym9ScE1EdmlSNGJZ?=
 =?utf-8?B?bVR4K21rcVRja0ZqR0FMYXlMOU5lY0hLa2VGSlN1bmFweThpK2lyQ2tBelZx?=
 =?utf-8?B?bFZQNEd5cU1iOHJvSGw3emtHbCtyNlpBM3lUdDdkdVJrUm1wU3dIOXFKLzd4?=
 =?utf-8?B?N1FzV1NXNS9NOWt1UTE3NkxjcEZHbGdWU09Nem9ucHptMlMrRUhQSGtRdmZx?=
 =?utf-8?B?ejZnY0xmK2xWNzArQTZNVVpkbHB5WnF6VnMrdHpsQVFtdldpRFdBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2e47f2-0444-4a1a-978a-08de7e446cbe
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:29:08.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeA/fO/BIKsuuITsvBBgv0X9ahIV3uXRPEAdwdwFL0Kw2v0lp+9y9ullPERvcGmKnOO4HWYyuX4D/0qqdZcr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899



On 3/9/2026 5:00 PM, Pratap Nirujogi wrote:
> Add NULL check for i_dev->map before calling i2c_dw_init() in the
> runtime resume path. The regmap may not be initialized yet when
> runtime PM tries to resume the device early in the probe sequence,
> leading to a NULL pointer dereference. Skip the i2c_dw_init() call
> if regmap is not yet created.
> 
> This race condition occurs when runtime PM resume is triggered before
> i2c_dw_probe() completes the regmap initialization and was observed in
> kernel v7.0 where the order of device enumeration has changed because
> of the changes in registering the device sources in the device hierarchy.
> 
> Co-developed-by: Bin Du <Bin.Du@amd.com>
> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")

Is this the right commit that introduced the race?  Did it change the 
timing?

Or was the race always there and we just got lucky until that commit 
went in?

> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>   drivers/i2c/busses/i2c-designware-amdisp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
> index c48728ad9f6f2..cd7ee55fbe1ee 100644
> --- a/drivers/i2c/busses/i2c-designware-amdisp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdisp.c
> @@ -153,7 +153,10 @@ static int amd_isp_dw_i2c_plat_runtime_resume(struct device *dev)
>   		return -ENODEV;
>   
>   	i2c_dw_prepare_clk(i_dev, true);
> -	i2c_dw_init(i_dev);
> +
> +	/* Skip i2c_dw_init if regmap not yet created by i2c_dw_probe */
> +	if (i_dev->map)
> +		i2c_dw_init(i_dev);
>   
>   	return 0;
>   }

