Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF233BFE4C;
	Wed,  8 Jul 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525013; cv=fail; b=QauJq62dcmybPDpck/MyHZP+J8y3QGUViIaPywgwIFGGZDT3pMDfSSRIERuB5Z8wAqKpJQrdlrSvB30i/9yjTRhJ7bQbjuqOJXvAVxnOb54VxyCz9isHyotl/ILYnhcz+ItjS2rUOLgb4x7LQNFIb4m32F2oyWSSrpK6t1DDeaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525013; c=relaxed/simple;
	bh=O/nzBSAEtqU8uroigKjhXK2przD2WbIHQxxpbsug1WA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Db9D7OWiXLX5Id1UfYmN3Ypxy1CKd5zJBUltvAfeHDMwXwAHKas+oxIkOsnB6F0hn+8ncDD9JstBInNaYeEeWECJRPYYeLo+Yr2jZvzg3Pb5Y4FXIcgRCi3U8YvXn5bEly53r4AI9rkP3Df6LaH/d9NyscBa0OQvSSfyRl9hu2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B34FiYeK; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B34FiYeK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QN15X5fGlX7aEAHJTYvjKs7pECfV1NcYnD4p3vVACm+D+kWbDYyFRDlnLoiwS32UI+phyOH0++2Ya4sVyTUl4Q2LDp06xaD3/eK+s3lQR4dcd+7ABjmWfn3yIyfNe8b/gu8LA9GwnFolACpXjZ3OwD/GjG0ylPm9TfGLO3FFqSXM4BODhjH7FSxAfuCr7QGu+vpuYBDW9AB3SGMWzkfwC8WKjVD4mcXgLgEWclZCz6+m3t7iaDuB0dz3S2Jun8WtKQSVz6QYr6+O7pwrsClBB0BUx0P1KkQK80IeQkATvqGqwZf/BTqJ+r2Nnp01VUiA/m/G4+0jW5vHhlMU4KP1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XunRX9skHBzbR+6Ud8VLqxs0e59d3dorFImQSixyVE=;
 b=mBGKRO/p4JDKII5YHHeh9hB49N9RtXOlD7YCiDyo9LLVVx72QgRIWIhtttf29eVUX+vuR2acoRm8E1JAdW0T1LsqZAc+Jq6Hx7JY2rAFCjEkrNjATlmz+1vrUDSeuSZibj07/PZw82YKTzdAGvnu/VOGnWo9RvxdYxYYAymB8ywwnplgzCK76NEePniSaZqhNMu6GQz5oZxC/QagogaRxuoZ49xXZeU+YFBuOgirorKi+BOpOov862PlIrw/taVmDkHD7r7vU10ACukCCCYpE93xN9KdssB9mdHn78aWgLn8ZJtFmZPTjxMcsQAHvy3TodDQ2YonDUF0AELMxzXfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XunRX9skHBzbR+6Ud8VLqxs0e59d3dorFImQSixyVE=;
 b=B34FiYeKDhoXYOtqgOyEZKEeLmmoNStovQctH6N0RkRhJBSxCaUwrr1HY9SWRVQcKxiyh+y/YTbklev03v8BqF6iE+6Y0h+F9y3xxg6KmznWjg+WeOqrIV5rjFF27Yemyq1VYbUSKBLosOGQAK9yl7G61yZr/z27adK++WXQw8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by CH8PR12MB999205.namprd12.prod.outlook.com (2603:10b6:610:35a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 15:36:49 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%5]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 15:36:47 +0000
Message-ID: <4321266e-027d-44ae-8b29-7d11373d9c1b@amd.com>
Date: Wed, 8 Jul 2026 11:36:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: designware: amdisp: balance genpd on probe failure
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
 Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260708090552.739789-1-lgs201920130244@gmail.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <20260708090552.739789-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::25) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|CH8PR12MB999205:EE_
X-MS-Office365-Filtering-Correlation-Id: d691ed31-be03-47a9-b666-08dedd06b8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Tvsuqzl5GsUvKxRd1nVLwgCadVo7zVGZqN1nCbdKP9fsfep0Fzbhf9e4eqPulgM4IxTZfaNHNF9CfexbpCcPA1cZzS+pqUQ/fWItdeKZS6XRxjE8MZUHKhqT/Cehim3ZiMzIRu867QkWLNTGH4RjFqEsMfkvWLYtqEOQPCZT6YoScswtBNOVNsq0sEVRRd9MAyjQz3hg3X79RujhzB/Wp3/VFmid+XhXYVnwsLVHi7gjtkshf7jku8rS4/ypz0H/yyaCXCO7OwnQ5EjMunlonsJ4aVUVrkAbPqlQligsx2MtSp2yG1TOjLf7YzqS1R/l1YyZ6f6JH6M1nKcIikDnv+h86HcWJ13P2ihnL9GOBifc1uYh0+Kv2QUpI1c22OOJuhf8di8M3S5oewzcmKUmvAh9/dENmxH2tvPenJtF5dNmMjc1xs5eq6SIx46MdiZPYSvJTSrDTqIcV14MTDVo60BpoAsoq23G0aJgooGNcckBQaUk7KhRBvU8RNoS/3bQdsu806N06W+ifdY+brv4+KRDl9RMbS8e4MNm2GkrseT5HHI1c/AOipN509/fnfkb3agJEHw2oTyO80dYj8HOrm4R6HJZ1l0nPgNq88vaEvRww7++iDg9vUOmkm+9CkMSF9/m4vnd6BZZcgEM2VXKwidQ5Pjgy9POpwUqCvplb44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGlVelZaRDJpdmFYTFhpZ0VLWm5vZEE5RmpLTENucFprV25SNUl6WXZtQk5I?=
 =?utf-8?B?U3pJWG5lRW9UdHZmb0lpbDJuaFBjUnNQbmhpVU13RHBLZE5CQ0lJWTlGR05k?=
 =?utf-8?B?dVlZK0gvU0FBdUQ1TENMbERqbU1DYlJocEYrUnlPTkhRMnRwaWJ0T1MyQVZY?=
 =?utf-8?B?Y1RFSnlHKzBOUktFcWVaTVVOazFEdm1MOVRRdDVkV095bEFDaklPdFJhTjlL?=
 =?utf-8?B?ZE94OGltM1ZCY3RvNkU3THU2SmJYU3VlZDJMSjVYYTdDcUVwRjcyVThWTFpI?=
 =?utf-8?B?SUt4clpFdmk0YjlGUFo2ZFhTUTVOcHRzZjBTVndaU09ocWhaRkR3SGJpbVY5?=
 =?utf-8?B?MkFRcUJnRjloT1Zscjl6aCtJWis4NWVXR0padzMyNW0xTlk0a3AzOE45T2Vk?=
 =?utf-8?B?NFJ6QTZ6ZStmOWUrVWw0V0wrT09jYU9ja1RaejRhRUZyZmRKRUZicEhuVE1l?=
 =?utf-8?B?bGphd2Q5V2VsVTkxSUVuZThNZHNsMEExc2VkYUEzV2c0aDY3dklybG10aUVh?=
 =?utf-8?B?bmpkZEVhZCtIUFJSd21TSE5nNUR3cWUrYmtadnFqVVgyMjlPMmR2YmhEMnJS?=
 =?utf-8?B?STJibkVDK3llZlVLd3o5U1RnQVZDdVkvNlpuazhkcGczK3RnMlJIdk9oVUJu?=
 =?utf-8?B?TzVnODljUjNsN2pjVExnbnN2QVcyRlo5Y1Vsd25HZmUzbm11bFdic01OVDFZ?=
 =?utf-8?B?WGRIb2oxL2poSHhVN3FidXRWb253TGtyWmN6WElTc1VYckZSSWZnbU1RdE5j?=
 =?utf-8?B?QWJTUG1xZ0tFVE9TSWt2UGluOHY5TVRkcGw1T0tHaFFCaVhUaFRXWlVST29I?=
 =?utf-8?B?UmEyUDc0K3RIOVM5K3FtN05YcmpsWlMxMHp6WXRlWFZWNFk0aGVTREpHbmk2?=
 =?utf-8?B?TWpnWWJMMVNjN01YNWl6a24yR3ZBdDREL3V6SUlKeVE2OElsNFJQTzhBSU9X?=
 =?utf-8?B?SGt5YmtjWGJzNXNWT0FJeWNnODZtT3dPelZXcXF4OUlab3hUN2hHd3RSS2tI?=
 =?utf-8?B?TUpGc0ZqbmRXOThteTZOc0dqN0tKQWFmQUFnL3NJUTRrRk95RXJYK1JCdmdz?=
 =?utf-8?B?cVAxK2YydHg5aWk2YVdHdkVvYW9WWkxsUkVQS0NSVFNYNUYySER1OGRLRWhU?=
 =?utf-8?B?OW5wOU5oL0czVXZjRlJOaWEwbDlRWDdpRjRNcDB6N3VNaWhwV2VwbktTT00r?=
 =?utf-8?B?dStBZWNHYVBZUU9KTmNSNml3QzNqMnJDWENGTW5aOGx0N1dxaFBKOEUrWElC?=
 =?utf-8?B?c0J1eFo5ejVHS3lMRHkrNFFmNXA5eGNyc3lVSVQxRU9NN0dHUFVyMmI1TjU4?=
 =?utf-8?B?OUlxekVVNks0cUpRZ1dzTW94T21rc3VORUpFdm5XSTJ3V0M3bmdTL2w2SzN2?=
 =?utf-8?B?TGkrYlNZSWs3cm1vVE9GMzNyemtJemFpcjJCZWlhc1Z2MkhtWDNSbGNBcHNx?=
 =?utf-8?B?UnlZL1E0ZEYrQlRBSkZaeUFhNmErVllyZ1dvTzdvWGtoT1RHazRuMHNaUEVj?=
 =?utf-8?B?dkxkaW01b3hyUEk4NHdCa0tEUllMZkpueno2L2wwSFV2Z2lza29YOThxUnFy?=
 =?utf-8?B?NXkwcUM0Rm12bjYwZDVBWlpXOGV0blZiNFlSdDc1TXUzcEhXODVUaURMQm1J?=
 =?utf-8?B?QUV6OXAySGJSa21waVRUSXNPa3pxeUVFTFZobHRuWWtTU0EyMi9rTmYvczY1?=
 =?utf-8?B?TGNOK1dZZWhsejBQT0tia2RvMUxQai9ZczRQT25jaEpsTkFHZ2R3aU5IY0F5?=
 =?utf-8?B?WDRLaXpBMWJQaFFpRUxUZlVCSlhKZ1JnMkFrajh2a3pPeFhDbC9IUXd2bFJO?=
 =?utf-8?B?NURxYWNuQ1FhbXVmcGdsMmZ2a2JTWG9DZXcvRlFJcGwvTEwrZWMydnBxMm5l?=
 =?utf-8?B?cFVlekRZakM1a1N2Qjg4R2VsSkxHM3lSSncxN2FDUGMvVVI4SFVNZVAwbktL?=
 =?utf-8?B?OHVFeXBoaUJjK2oxVFBQczhac05NWmxhSmxjTXdoQ2d3bFU0am9rcU9wYmVW?=
 =?utf-8?B?clVCR2VLaFFkdS9ZSEZrNmdXQTJBQlI3WGkxZXBHWGhVRnd0eUxjSlFnOVRl?=
 =?utf-8?B?aFA1cDRIUlNDR095NVpHbTgwaVNCRjBucFgzbVpxZkhMUHBSbFFDekg3S0dM?=
 =?utf-8?B?YWNybmVUQlUxSnl6cjV3TldydFFub0JBL0ZzQThSdjMwOGxQTWVWcDltRElr?=
 =?utf-8?B?RG9iR3UwWVQzTm5CWW4yU2xmZ0FqR2lGZGthRVNxTkFTTkJtUktYZHRFRFhN?=
 =?utf-8?B?MDI1U3RReWRhNUVlWE8yVlVCQ2x6SEhjS3AwaDdoempRbjVUNmFPd2p3REVM?=
 =?utf-8?B?VURGSVNORDhaNjJxU2JLUlR6bkNqM29WR3dGKzZwWXo2K2RXN3ZlQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d691ed31-be03-47a9-b666-08dedd06b8c4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:36:47.4471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4PEBGj14vsu4VcK4dOJ0kD2cRRJ6l1PV2Xr/9veKsJRN0zQfYbjZtpBBLAa9LUgz6Z7OWNCYznNepvzCgcyFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999205



On 7/8/2026 5:05 AM, Guangshuo Li wrote:
> [You don't often get email from lgs201920130244@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The change referenced by the Fixes tag avoids a runtime PM resume during
> probe by powering the ISP domain directly with dev_pm_genpd_resume()
> before calling i2c_dw_probe(). Runtime PM is enabled only after
> i2c_dw_probe() has succeeded.
> 
> However, the i2c_dw_probe() failure path still uses the old runtime PM
> cleanup path. At that point pm_runtime_enable() has not been called yet,
> so pm_runtime_disable() is not paired with any enable. The failure path
> also skips the dev_pm_genpd_suspend() needed to balance the direct
> dev_pm_genpd_resume() call.
> 
> Suspend the genpd on the i2c_dw_probe() failure path instead of disabling
> runtime PM. This keeps the direct genpd resume/suspend pairing symmetric
> on both success and failure paths.
> 
> Fixes: e2f1ada8e089 ("i2c: designware: amdisp: Fix resume-probe race condition issue")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/i2c/busses/i2c-designware-amdisp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
> index 9f0ec0fae6f2..724cb05e21c8 100644
> --- a/drivers/i2c/busses/i2c-designware-amdisp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdisp.c
> @@ -81,7 +81,7 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
>          ret = i2c_dw_probe(isp_i2c_dev);
>          if (ret) {
>                  dev_err_probe(&pdev->dev, ret, "i2c_dw_probe failed\n");
> -               goto error_release_rpm;
> +               goto error_suspend_genpd;
>          }
>          dev_pm_genpd_suspend(&pdev->dev);
>          pm_runtime_set_suspended(&pdev->dev);
> @@ -89,8 +89,8 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
> 
>          return 0;
> 
> -error_release_rpm:
> -       amd_isp_dw_i2c_plat_pm_cleanup(isp_i2c_dev);
> +error_suspend_genpd:
> +       dev_pm_genpd_suspend(&pdev->dev);
>          return ret;
>   }
> 
Good catch! I overlooked that earlier. Thanks.

Acked-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

> --
> 2.43.0
> 
