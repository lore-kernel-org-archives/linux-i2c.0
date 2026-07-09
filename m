Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46D428466C;
	Thu,  9 Jul 2026 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581976; cv=fail; b=ShUmJqryJ6EvpSyv9EuFcnSK4XFwP0GhvaPzHfmof7DHDsABFPi2TFH1NIs01aAIxXC8lwCWZ4LQQhzm/fCBq9lU5qXsSZWF8WVoOdoQIkT0ccwt/IlExmQ+SuYNQPRgHp0eTuYnOj+Rz3uYzLQ4BETuLv4M2Ay1Y8OhTSKX9sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581976; c=relaxed/simple;
	bh=+ITxsahk6odXYNsvOf2WTmiiLvsytrBv1y08mk0YNMs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jZYLUtpuXHyVnOx8VgllzFTKKQL9mkvGLgMWYRonxNLYNRt9XRJ+AYY4GJEXrN2iZG3lds9gHku0LMiw9m/GMSSCX44iB61FNODVCKk8c0EZ5aJgSnH52U7UrAKz2Y9BOBB+V1J1869sc/TGd30VPsophUiZEuYguaMQHaeW2hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jTJczKzx; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jTJczKzx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5FPHEQb7LX6lHuSv2bIpkEXJ6WBDC6pnOs5ZfbUXfUyK+n13VA9tvthe5Pu6LARi+8z7BGiHaWSmW9JmckMsdrzXdHwpfmJ8sCR1lNR/m2ktTx3hRe2PdFSytEXSws3O/dniAJedvWY+ZwkRuy0fz6SndF/KZ0WkVGOFrjFVOv7ZMI4us5o+3vEZqSbudvggmCFhBxjUbfj/ri1B/YPfkUqiO4QEV69Y24uLTJPYUXJH+2P4BIVPehl84aJ624o4+jUofQIVe8OYfimdqWfkxvPRGYx4AsTE02JIHpfrRiXyosPmvkkfioXXZZjB8Mavu8DwYIBPPEFz4p4am+tXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKKSRgYiUSg1Ir2hztAdQjkfYGdr8CbWUfI4drdgMyg=;
 b=Yt1fP7T+LE6N20bm1/bZxHZmw8Pu4Ae+DO28/hEr8OUh2EWalkNSvoCMPS69M0f0REbH7FizSFKvtSt80mqRfNWCxpYXIIwVkvstqhJD5mbC1Qz1gPWVXweSjH+TA1wJBKTWL+3rLwDCCI7YlH4ZO/Q1PlyxJa7oaYfrYJl+OQejvnCd7rjG+CEIGoBuvG0dpQqNR/EnGVOWya+wfi4w1NkcfvA4Rx4Jw2e0/zn6scEedyH3frTrvFN/K3drN4gOgvtd7qmBL0UxxwKKMokGY3XvymuPy2DiSz21vK5cZqI0QTGS31UPGhCe2nidKKSns27E3wta3Q3Dr1H+o3s1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKKSRgYiUSg1Ir2hztAdQjkfYGdr8CbWUfI4drdgMyg=;
 b=jTJczKzxesjy3e8KFD9JcP5T0OmbKeXEMWA4KxPkO0izyZe6P22RPDk79IRe5RocFKqKbdmRnam4YXcQJy1xDOknhnBXIRjK+SxDWJveb0SiiwmR9jRkF6k6Uux9XDnsXoWXY9sVPKKURCRWXQUCWUVy63tb1PB1qgIfjeUHS4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 07:26:12 +0000
Received: from DS0PR12MB7747.namprd12.prod.outlook.com
 ([fe80::2ef2:e88:4708:b589]) by DS0PR12MB7747.namprd12.prod.outlook.com
 ([fe80::2ef2:e88:4708:b589%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 07:26:12 +0000
Message-ID: <e443ae59-c40d-49d2-aba6-dc9f6c8ee157@amd.com>
Date: Thu, 9 Jul 2026 15:26:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: designware: amdisp: balance genpd on probe failure
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Nirujogi Pratap <pratap.nirujogi@amd.com>, Andi Shyti
 <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260708090552.739789-1-lgs201920130244@gmail.com>
 <54e814c8-c2b7-4414-aeba-469973a30b42@oss.qualcomm.com>
Content-Language: en-US
From: Bin Du <Bin.Du@amd.com>
In-Reply-To: <54e814c8-c2b7-4414-aeba-469973a30b42@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:295::17) To DS0PR12MB7747.namprd12.prod.outlook.com
 (2603:10b6:8:138::20)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7747:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: ab776025-5f03-4258-b2c5-08dedd8b5a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xjoEEbM3ecObqz1T5VhYhCfzCFvlLrBSNhwolhv4FvlxTPocRhpfnZ1vwYAVct/C2iD+SZa+XjJpre1IZDmWFV9YmiDmQd0pFhV/vpoq7DEaL9bS11dXp2DudXpgWoUcvrIMzsgK1y3byFP9zGL53OkwlbZpybYmr0OsbiX04CRM4Xl3tKey+hknAJsAppT5Uni5dCpqSD4Uv/hUepU02acUQS5plK0cOknQN3d/LOxtFPs96UuZ5bJcRRE3LW9ANcIXZTsXprTdYrd6wrLGKyXovBgc3D2ovU908EN19ay56Hq6HhZYY2oGWT+eGJyAZkhSh7rWkkz25++liWdZDWliTfQ2d7Cm2eCd5JDesA6zSgSvH4n0LvZl0MRZvvQWTeKKHUuZNS93gSc26gffPUM9lyV9K2Yn76kZnJErcwZ2Nq4ngcJlhJewqLjeRGelmvWIj0+0WmzLJ1BVpDr6clCtdzLK/u30k03Dro1FR9idocZ5SCxTZaI2fo9Wfo4Me5yK7sZNFoHure5BieYpV2+HmnVu4zbVGfLdKg/o7ifY9ghWnGXwjZeHLDvDKRIcP9ydb82+UpcwTNstKdlrPTEWWrLIL89MG73kWe5bbT87uMp89uCqv1txbW1FANyjaDayvZ8M1GoKR6FY89axZYRuSUBOxv5878vU8VhMdqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7747.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGxUMkZ4UmxxNURQM1pKUUhaMjVzbW83cGFJbWEzVmhXOEdlVjdXbFRuYzdM?=
 =?utf-8?B?cUJBMFp4VFk1V0NLYVhQM0J5aWxoUlZRTnRzVllmS0xiRlpDSzJIR20wQU5Q?=
 =?utf-8?B?UUQrMEFmMmlTUmF2MEFnM3NycnhUOWx6TG5qaFlLUUU4aVY2YVFDcXhIOU1n?=
 =?utf-8?B?OHYwOUpnSjBldnFWa0tCcWJVMm5sVXREMVBYU0YvM0thTEw5endQNEZVWjVH?=
 =?utf-8?B?SWorSTU0UExoa3ZLUHQ4SHJUdjJwV3JnYkplZGNxTTltR0FZWDJGYkRHejFH?=
 =?utf-8?B?cnBWUzlxWXlQR0tjODFIYW9nMWZqdW9YaHFMdHIvN0xoVWJ0Y1ZwYTMwM3pC?=
 =?utf-8?B?N3BERXRpMW82cmk4aHdGVVIvZ0dTR0J6KzVTTE1pdTJYRDhGWWt0UEQzelV6?=
 =?utf-8?B?WXJBTlZCV1Q4UTMrM1AwN29pUDNNZC9XWDVaa0NxaE11OXNBL1U4eUFPMXlR?=
 =?utf-8?B?MHJTWkUxL3pLTjdsTFRkZ3JYSHZwNGt1VlJKV3NHWnpDNHIxN3ZGOTh0eHRp?=
 =?utf-8?B?OGxnOE1XY3RuRGtqNXBMQ1JmV1ZIMVo4SDVkY2NwdC8vN28zQk8wSCs5MkdZ?=
 =?utf-8?B?dFdpODZ5VXBYb0wzTzZCQmswaUxjODkwR0owdUdtMDVNUEdFTEU5NVBlSHlh?=
 =?utf-8?B?dTlRd0hETXF6dE1LVTNyZHpuRmp0eGRMUFdwSW1LZnlDRTBhTEFaQUFqUjRu?=
 =?utf-8?B?azhtVm9sUnlMY0cwc0pySEZWeTllRitQUHNyb1ZKdGxoRTAvOTJJRDZUSEJT?=
 =?utf-8?B?UDBKaUhuU2hIZlFCMzZYeWZDV2ZwelJvRU1JampMcUlIdjlxWlRlNEhsZm01?=
 =?utf-8?B?NVl3ME1EMFRFenB1N3BvZDRzWUFibnEzNjNna1p0YW1IeE9vK1J4SXk5ME9T?=
 =?utf-8?B?V0NYWk5xdjJERCsxZUdTaEVub2czUyt1TWlDMkJpUEovQzNxdXdVdCtVMkRq?=
 =?utf-8?B?VC85SGZoRW5QYVlVZThoc1NndVNyR3NTV1FFTUJxZ0N0enFpa0VlMTdtNFJz?=
 =?utf-8?B?M0Uwckk4S0RYSUJ0QkFNRE55M25xeE5kaXNUWjZGZTdud1F2NTVzdnFYZWFN?=
 =?utf-8?B?bXlMUDJPUmd2Mm1pL1lvRlB6MEhhT01NOW5URGVHN0JkTDY5d2dCRW53djRa?=
 =?utf-8?B?dTEyV2lQWjMwc3JDT1MzcmZHV1VoWTJQMEFCa3h2UkhPb2pjUSsxMWM3S0dJ?=
 =?utf-8?B?Unc5MGpNSFlqa2RESzB2aDN6eDB2dmdQVTNKd0h6Ymxlb3pWaEdkTDEwNngz?=
 =?utf-8?B?YjJnMGVWbE0xckdPYmNHa1cvZG9FeXIzYnBsT3l1WndGNG14dlJKc2hoVjdo?=
 =?utf-8?B?dzZieVA2a0h6MCs1SWpIMElvbGkzTGV0eTY1VDBPYllGeG1RbTJuNW1KQjBm?=
 =?utf-8?B?TTJMMFRZMHdlVFljTFBEeGJvdHJGWnZ3cmY3dWlzdXZycndMUkw5MFl3NFgx?=
 =?utf-8?B?ODY3QUVnU0UwZHdiMFlzWGJqT2UvUHgzKzhVZERPdnJOTkttTWdGREZVU0J5?=
 =?utf-8?B?MHJYZHFnbTRFL3k4V2thd2Y1b3ZtbmJSbUoxTzRDTTkxdlRrd1ZvbGdKSllz?=
 =?utf-8?B?dy9ROERoekF1aSs0cE1FUiswaGI5WmhVR2ZwLy93M3NXelN4V0RnQ0h2M2JV?=
 =?utf-8?B?Q2xoSmNOdkpBTGJWUmVNQUdXNjZzV0Z4SnR5dlJ0bTdVNFluNmpGUmtwWTcy?=
 =?utf-8?B?QVZVb2xsMjg2dlRaNE0xMTR1bERkWkdwY3dMdGhOQ0RZbUh4a1paVWhFUDFR?=
 =?utf-8?B?akRPM1hXaTNnMWZPOHFEbWRDbDc3NU0rbzgvUjVCVm9VcFowbXo0emExY0Uz?=
 =?utf-8?B?ZmF4ZVBCdnlYVmc2SlprYlNJckRCa29wa1p6L2lXSEhVdnVPR3dlbFN6YzZF?=
 =?utf-8?B?VFNzVlFtU3FyN3A2VjBhSjFoL1creE84cG9Nek5YUGlNSGFiUDU1NUhLNVND?=
 =?utf-8?B?UGNHSDljMWVtM1ZnbmtMWUVPU2Z0aGcrRERBckhGM2dzdEx6elZ4dGVzWHdT?=
 =?utf-8?B?OHhuZjcxTXBTZWpXUjVVTUNDSG9nMmhlbmpFUlRYM2h6UERaUVdhK2sxSzNO?=
 =?utf-8?B?ZUFmcm5rQmNqTXlURGhTeWQrZEtHaVVVK1ZnSEVHczBmZ1lLL0x2MnJTRSto?=
 =?utf-8?B?MWhEV1hKY2FVWS8yeXdvaWxwamxrUjc3OHMrYzVxaVhBUUR1b3RqUTl2eEFQ?=
 =?utf-8?B?WVRUVHV6Y0MrTk5IeTcrZGZFK3hXK2JSS1V6Q29xMFRzUWUxNVVtN1N4enVS?=
 =?utf-8?B?L285dU4wdE90WUR1cVNmNFRSZEpEUUE3TEdSSmJ0ZUR3UlFMMk9qdmo2cko1?=
 =?utf-8?Q?NzhiP8oU9S1wbO1YoI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab776025-5f03-4258-b2c5-08dedd8b5a29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7747.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 07:26:11.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRJ9nvWMe1zkJ9esgcGRrhEnHA2GC3X/PBuB5uVOH26FAgNiUOdFPq5/N/bK1ZrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760



On 7/9/2026 2:04 PM, Mukesh Savaliya wrote:
> Looks fine to me, Have someone from AMD also Ack'ing this as requested
> by Andy Shevchenko.
> 
> On 7/8/2026 2:35 PM, Guangshuo Li wrote:
>> The change referenced by the Fixes tag avoids a runtime PM resume during
>> probe by powering the ISP domain directly with dev_pm_genpd_resume()
>> before calling i2c_dw_probe(). Runtime PM is enabled only after
>> i2c_dw_probe() has succeeded.
>>
>> However, the i2c_dw_probe() failure path still uses the old runtime PM
>> cleanup path. At that point pm_runtime_enable() has not been called yet,
>> so pm_runtime_disable() is not paired with any enable. The failure path
>> also skips the dev_pm_genpd_suspend() needed to balance the direct
>> dev_pm_genpd_resume() call.
>>
>> Suspend the genpd on the i2c_dw_probe() failure path instead of disabling
>> runtime PM. This keeps the direct genpd resume/suspend pairing symmetric
>> on both success and failure paths.
>>
>> Fixes: e2f1ada8e089 ("i2c: designware: amdisp: Fix resume-probe race
>> condition issue")
>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-amdisp.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> 

Acked-by: Bin Du <bin.du@amd.com>
Tested-by: Bin Du <bin.du@amd.com>
