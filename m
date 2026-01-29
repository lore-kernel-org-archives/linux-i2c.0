Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826126E6F9;
	Thu, 29 Jan 2026 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713412; cv=fail; b=nKgyrpZeZcSelXn3naJGfoSV8Z0VrvXEz3FDO/4se7htV23OVacIywoJENh5OCOY84iaK5D5rDjwST87zq6otayqCYClg0udnqOGqkiY+hl/c4eHA1a5F4bx1FcPF5fRDjlJ6Rx8LyMpD875UdccNOZTrj9cIHxJhEcJSyKi1Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713412; c=relaxed/simple;
	bh=DjjzaVPrfCpDrpS3NYnWBycFRGRbIzKHsdLkoqkDwa4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sb+6ExIUEv7Bi5K2/cjMkA9miCgSjSwutzfZS6ngu0axVqMh6bM9W6mMHO3rXphmnGz+vOqZewCa952JWVAN5Gs9zaa/va2fsx/eYWMeXMeUfFNxbFZlNuujh0ZRYGiZTBn/PCWS3PBX9laaBd12dJUHxOZB6VQmILMAIXnjSE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TTmGjP0M; arc=fail smtp.client-ip=52.101.85.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TTmGjP0M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/6AG259LqG2/+5wdDZLP+DUaGeZRjxaICGVHft0L0WxJsoSf+bVv0LWd98o6bb9vpL3qNsLsCUJL9H+dXySqqxZfYVgZpYpGgAf3Wap9zn83aCHxoKrHMFqtOyadJr2v8WsBHMx4iJYJCZljeaTGIWd1d+czuj7WIgR6j6zoEkSTKSkT1PjcdbkHxEolQS649YC2nJwpYTjQALR/Ck6ibs+vuCrBneFrZrR0S/9w3kFX7UV8kjw9We5jqQjAl8wOJMz6m751UnbxLzpbsoNliNqLmjs8RLK5CDwIeoKzimvikpdfF5seiShw1aDWpoyK5wZpjCQ6k1LiSGlCeK4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8ZOxLGY9bl0a6PwiRP9VUl+2MpZmsmOp/wQZ8vyIrE=;
 b=wCsIz6PAAGKUah4YaUtimIhgRITHeTR3LrifD5F60jjf7KSqNiFYVkCx6/QHxzhK44MJPy5jD4/xQg1P4HNgzf74tcat+lW0jZ6yLxyb+V8zEV6Ulo4woP4S0T2OPvi8kqdlQq41Ar/5k8ejxAb/jsA12Zp2B+n7fg/fXSOlrU1maTtS5/WKYfPcBDHnPdKXASPPNCwkukRCtnStm6xJblBlYxFbZWzOk0GoC3QdWlsjt/wmx9k4CaK/J9QShYUWdS9H0po00fVdrqsGCR0jyS9d05oZIhM+TMwOB4FsR8/lttWtTppgTzmU1VpW5St4xxBOLPXWXEohuYLDDPYryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8ZOxLGY9bl0a6PwiRP9VUl+2MpZmsmOp/wQZ8vyIrE=;
 b=TTmGjP0M/wq0HGt/OgbiyiJbnbKcpFS7+vJ0nRTxGV0mYqvi+MxxwimcoC+F+ZAR5hrkXQA+SQqZJemk1wL1fQHq7uaG4x2CyfiMJmXL17cw0dMVK8N4c9+F0VldbkQw4CSn/gOWH1s3GPzAuhcG20Kb2K129pchl/AEtS8kdkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 19:03:29 +0000
Received: from SA1PR12MB9492.namprd12.prod.outlook.com
 ([fe80::a866:904d:73a1:d65d]) by SA1PR12MB9492.namprd12.prod.outlook.com
 ([fe80::a866:904d:73a1:d65d%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 19:03:26 +0000
Message-ID: <bd3f15e8-f602-4833-9101-f1899add18c5@amd.com>
Date: Thu, 29 Jan 2026 14:03:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] i2c: designware: Remove dead code in AMD ISP case
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andi Shyti <andi.shyti@kernel.org>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jan Dabros <jsd@semihalf.com>, Bin Du <bin.du@amd.com>
References: <20260129103439.187478-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <20260129103439.187478-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::19) To SA1PR12MB9492.namprd12.prod.outlook.com
 (2603:10b6:806:459::7)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB9492:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 377f2314-f5c5-41fd-727d-08de5f6914f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkxRUGhCZFRIMk9KRlpYNEx2Y2pheFJYT1RuVTR1UHhod3IxdmcrWjUrS0Z2?=
 =?utf-8?B?Z2NoNjB5R3ZNY2N0S0pCYXdKTFpnNGduZVpqaGFsTHp2Y29RVFBSeDA4SWdT?=
 =?utf-8?B?Z09EeWZMY2NCWlU3SkFwbHBZU0d4cUF1NWZIMHRDSUtGSGorTEwzOUZXMHJx?=
 =?utf-8?B?ZWs3ZndjWmlId285WXcvUUZBaGk5TithOTR6UHdzQ1ZabDlhZGVwZmxYb1ho?=
 =?utf-8?B?eUtIVzhXL2FRNExzMDB5cHBHeU5GYVFCMEpUVVd0RG9ON21wemEzTndoMFh1?=
 =?utf-8?B?d3EyWmlxZUtnb24yQ0kyRW03bXo0aHNYZzdzSDZxSnJWUGQ0Nkx0NUlkUGgv?=
 =?utf-8?B?K0tkQWxTMCtubGZwTERRMmhmNDRMYXJsVWxUQzFsTFZPZ0tDUjZITzlwMU8y?=
 =?utf-8?B?YTVBQ2hFczVTQ1g3TDlEemI5ckhIMXBmYmNKSHM4Tm93ZXZpbVJYVXRHbXh5?=
 =?utf-8?B?bnUxTzFWL0JmSUo2UzRwQjNRSUdYOWZsTFZkbEIyVTYvbUlIaThnOVQySFN2?=
 =?utf-8?B?b1NJL2lhaGNQMFJnM2N5YmJPUVAwS2gvcWEwREgvM0Q5Q3BlZGlBUk9scUlo?=
 =?utf-8?B?Y0VmVHZUQzlERDJMcXhpTW1tY3BTYWZibFloaU56cVk4anpFU0VYV1ZNV1NQ?=
 =?utf-8?B?VXpCdjdlS3F2VEtpSXlpeko4TkFMWGtJR0t1bFVkUFNoaFJxVVdEeDhya1RY?=
 =?utf-8?B?R2FsSng5RDR1MUVGc1FhRmtRcS9TV1FHQk0vN3BRSkdPb1JYR25pVGxpTTFy?=
 =?utf-8?B?SGtuRE5mTWZqWld5Tkt6VS9tUUUvU1BQa0tzc0VoQ0J4blpxUUxyK3VaK1M0?=
 =?utf-8?B?NzFkTzE5SVJCbGhORWtTdngzQ0ZtQ3JXb0ZhWDl1TUVDV1ZucmxWbUIrUHpv?=
 =?utf-8?B?L0l1Q2Z2VHlZM0lyc2xYb1FWQVdIMDBqSElIQTNnOVljcXM0NmVSMk5QWUxM?=
 =?utf-8?B?c1Y2RlgzMngzTW5YMnBRdHhELzJkam5Ca0ZmOUV6VDU5TUZQQnhJUGdSVE5T?=
 =?utf-8?B?VERLNzRwS2MvQjVEOWxReXRWOVZCRnhQazZTWnZ0NXN5WmhDSVhhQ1Q4V3U5?=
 =?utf-8?B?cmhqMDJSU3NsQjhDYm1FdDNNdGw1UTRZSm5qWGlxTzF0ZjBaSDY1bEVVcytn?=
 =?utf-8?B?WkVXUloyVklIMmlBam9LWUNpeFBRcld0dHludStuUjN5VjRkQUhNbm1aWnFi?=
 =?utf-8?B?WFB0b2dxV2Z1a3dNUDlOY0gxM0NtN2Y1T0Y4NnZieFRkcWpsQzV0VnZwWjM2?=
 =?utf-8?B?cTlHSzZrczhaRmIwSzQ5MVFHdDdLWGdURUU0MkhwNndwUTdPbVphaktqR2s3?=
 =?utf-8?B?QWNVcit5R00vZytESktaWHovKzVNellxNU5tNEY5ZFRwVjF4d2pBczZzZy93?=
 =?utf-8?B?S3NSVm1XS2xOb2FKSEFMSkdWYUZFL3VhTGhlT1JwbG1DekZUS3RGOTZlcnZI?=
 =?utf-8?B?ajEzeWhLSEFwa2hZajM1Nm51b291bmsxaEtENHdaN2FzQUZqZk9uVHhYUXJD?=
 =?utf-8?B?WWFWZG9tcll3OWtITEg0UE5nSm1RQVMvWXRBRXM5NW9MSkg3bHB5ZE9rem5Y?=
 =?utf-8?B?ZkNiMVRicitnSnF2QVg3WmFFbnZlUU1tS1V1Tnd3M3ZSYzBkT0ZvOUVYcStQ?=
 =?utf-8?B?bXlscndlSGFvQUY1Yjl5dTgzUmE0aTBYZ1JvRG41cU9qRkdYcnNJWHkzam00?=
 =?utf-8?B?eXlaaGNwY0QyazcwY0hDZ3pWU0RJSEpjUnpMeWE0dThEckR2Vm44ZEx1MFQw?=
 =?utf-8?B?RHBtSm8zUm9RMEd4MXpFMjkzV0l1bFpHQlFDUStSaEVST3lXZ1dCNTJhWDVk?=
 =?utf-8?B?QWpzQzN1dS84WTl3VWEzZXZWeHhxR1BLSWNtdkViZUQrbHJmalkyR0ErTkhJ?=
 =?utf-8?B?TjcrYzVqRkFiT1YwcXF2Umt5aGZ3THlhS0FkdFI3eEIxR1F1d3pqdC9tS3My?=
 =?utf-8?B?VC9QQUNKWlVQaXdKWktPUlQ1NjFmVFJjeTZDZEYwcjlRbUpTcjc0Q2FOMy9Q?=
 =?utf-8?B?d09Ddi9oV3VPdS96TnFmZFh4M3VETkROYnhjdFpzeWNXMGtuQkJHbFo3S2xY?=
 =?utf-8?B?UkhzTC9aSis5aFgxS2l4Q0h6WGlEeFkyWExWM0txdmg5RGJUN2xtZHpsZTlj?=
 =?utf-8?Q?6HXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB9492.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0g4S3h2T21iMFZKQmc5L2pqS0lsSHJ0dHNGL1FuNDJyTk8wTUI1cVJBZzVD?=
 =?utf-8?B?Wmg2UVYzZHF2WW9DbWRvTGRpNGVFdnR4M2VPZkxFeUh5eUdzNWU5VzRMRi91?=
 =?utf-8?B?dXhkQzRNZXYzWC9hNGtDb2hxanNsT3NXWTY3S1FpZytEbFFQWGFjZ29HZDFM?=
 =?utf-8?B?RCtXbFVkdFJxV08wMEpZdTU1TWdoRExWOXhwakxUWXVOWFRkbEw3T09ZOXNX?=
 =?utf-8?B?MmRaTmRLMjBvRlBHUUg4cm9LVmtTS0U1RjhWMllGOStmWUxEa1dmU0ovL1VT?=
 =?utf-8?B?V3lZYXN4S2hQUVUzdFNvSkQxWUVTTG1JSWpMZ0wxU2JzbE4xdElyRVJQWitK?=
 =?utf-8?B?SG1qK2F1VDhiNjB6WUthbzNUY0lyYjQ3SUlPa0p4VW1yOGtnWUpaeVoxTUFz?=
 =?utf-8?B?QjVONXB4cE5uY0RmRUlxWEJ2bjlILzlmVzlvWFRCT0hibjdLTDFjcnBDQmUw?=
 =?utf-8?B?SGZSMVB2NUt6VndCTDRDYnFFQTNlQ21yOFZ1VkgvVVcyVUlDVkVWcUppNHNJ?=
 =?utf-8?B?QmJWVE9nMWl3NEdub0pSRjZrTnJGVURLTStRb2JxR1pIbXQyNzFuejZhcE1h?=
 =?utf-8?B?YStoTW5VWC92YUNCdW40MjJkbjhlTnQ2dFlrSnlIbDdVNXB5NS9WRFFvZjFR?=
 =?utf-8?B?NzgrdFpTYldnOWg4dUZKZjRsblJ4Z2tOdEgyclQySkRYOHprcVFVeTFZR3FS?=
 =?utf-8?B?RUt3SCttRFA1L2IxV0diVTFDdmx4dERuazZCVUVTVFB0UFpSUG5QWHZpNVVP?=
 =?utf-8?B?aGs5aUV2ZFp5NG9WcDlTUHpIZ1JUbkxTQVBTYlhzandFTUVlSDJFcTc5Q1Yy?=
 =?utf-8?B?VEtHK2NjajIySG4xSmtkNXBNUU94OXVVZU9aaDltdkxyOEl6eGIzbVFWZTlm?=
 =?utf-8?B?dzdxaUFzdUxaa0hibUQ3UzFHTk5BeVNFTEhPYmc1d1QwNTFHVVFKWnpEamln?=
 =?utf-8?B?amhjcnJaWjJXZFNZVUVqQ012MUNmMTIwM3Axbks5VGo1Ty9zNnV0bUZ2QXRw?=
 =?utf-8?B?dmhwbmU3eFJrcXhTb3BuS0p5UHFDamQvb1M3SWVLY0sxTEphWGJGbG04cjUz?=
 =?utf-8?B?MlA1dlFSRTdUZXRPQVNGenl3allnVEF3RTdkNStPRkIvZ05VV0lrY0VTSkJn?=
 =?utf-8?B?Zmh0anhlT0k0TVhTU3Fnajlld0E1TzRyZWExcVNFcHBrWXZvbWRUVExXd0Vu?=
 =?utf-8?B?My9WNk56c1JWOE5acU13ZDdMLzBJUXdHQU1qRWFZRVpTTWpYT0lOVktVU211?=
 =?utf-8?B?YndPbGtueHhlQWdlcmR0U1Y0Wm1VajJvb3BOV0ZYRnZuU09USGtpd3N6OVNh?=
 =?utf-8?B?aDRPNEJQeE9yYm0zUjh5LzVsZXNoRFBjR0RITTlWVEFZUmxKNVpGUkFvVTV5?=
 =?utf-8?B?dnd0dXMzbE9TbGhmT0JOS01ZTW9ER0FGVFlSYkFSWWlDa2JyMzY5aXBEYXU0?=
 =?utf-8?B?Y2FVV1VIemdYdUt2U01TSDV4Z0R1ZUN1K0FEa2dBbmlnV0hpUTUvaTZ2NGVM?=
 =?utf-8?B?VDRDNXI2RlFrcWpaQ2k5ZFhoeHB5bE5xZzk4dDg4aFE1MEM5N2h5YU5CVXFs?=
 =?utf-8?B?azZIQkpKRXhPUWMrL2R4c1VrOENUVXpiY3BySzk2N25UbTQvTUlUb1pSdXlK?=
 =?utf-8?B?TVNjc3gxVFA4eVJlZTNadmlkRTdsb2g2aHYwenRMV0Q1ZEg5eXA3Lzk5WTZQ?=
 =?utf-8?B?Y2pWTllJRGs4Z1BLRXpXSzJMWU9BVzVDSGtsc0hQOFQvVHczRTB4bXJKMGh3?=
 =?utf-8?B?WDdKTVVndFp3am5oSXVsYm5ISHZxc2szK1ZFZHQyVDlOV1RnVU9IQkJQWFpP?=
 =?utf-8?B?TzBsSEVteTFlb3hxblRRY0gzeUFCWlRNME5HVW9ZUkxpT3I5ait3ajljbnNL?=
 =?utf-8?B?NFF3NVVSV2hmMDh5TnVYSUxtRmlMS09naWVxQzBJNXZIbXhqQWNNeFhybllH?=
 =?utf-8?B?UlhuSGNnVUxEYm1namlWTXZMdnZ5MDVCamJQYS9pZzJaYzZUaWhtYjVjTWFU?=
 =?utf-8?B?bmJoRkVzWmJRQTdRcERFdjZwVGF2dnc3Yk1GVzVhZkViL2FhNDZkREowMDZo?=
 =?utf-8?B?dmc0N2hVWmxzb1doL0s1aWpjbVZmVE1ZMmRZOUZUK1VJRmhqKzNFb3V2NnRY?=
 =?utf-8?B?KzROZ1o3QUVuVTZ2YmE4MXB6RC8yNnRUaXViU0FHeTJyZlZYem9wZjNjU25n?=
 =?utf-8?B?SXBBSzVTcHkxZ1NFV2NPaDMxOUFLVVpUTlh5NWdtaVVzWTg0ZlZZSy92Rm9R?=
 =?utf-8?B?bXBuUGp0NnpReVlVS1ZPUzJwNFN0WjVuSURNbHU1eUNVdGxjb0U1Y1BsazJM?=
 =?utf-8?B?b3Q3eW9PTWVVVjNTeEQxUkc0aXVwdzdOMFpvSzdwRk9LSmp2a0lMQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377f2314-f5c5-41fd-727d-08de5f6914f5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9492.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 19:03:26.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dx3azWv9XTtzhxv1qGe2JZ/nS6juxsLdMwizs+P6GeAkQrtMl3anIxQempPBdTDkdetiJERCPcRjYsvC5i2FAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960


On 1/29/2026 5:34 AM, Andy Shevchenko wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> The I²C bus shared with P-Unit is Intel only thing as far as I know.
> The AMD ISP driver has no relationship with P-Unit. Remove dead code
> that seems copied without much thinking.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Thanks Andy.

Reviewed-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

>   drivers/i2c/busses/i2c-designware-amdisp.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
> index ec9259dd2a4f..c48728ad9f6f 100644
> --- a/drivers/i2c/busses/i2c-designware-amdisp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdisp.c
> @@ -18,9 +18,6 @@
>   static void amd_isp_dw_i2c_plat_pm_cleanup(struct dw_i2c_dev *i2c_dev)
>   {
>          pm_runtime_disable(i2c_dev->dev);
> -
> -       if (i2c_dev->shared_with_punit)
> -               pm_runtime_put_noidle(i2c_dev->dev);
>   }
>
>   static inline u32 amd_isp_dw_i2c_get_clk_rate(struct dw_i2c_dev *i2c_dev)
> @@ -79,9 +76,6 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
>
>          device_enable_async_suspend(&pdev->dev);
>
> -       if (isp_i2c_dev->shared_with_punit)
> -               pm_runtime_get_noresume(&pdev->dev);
> -
>          pm_runtime_enable(&pdev->dev);
>          pm_runtime_get_sync(&pdev->dev);
>
> @@ -130,9 +124,6 @@ static int amd_isp_dw_i2c_plat_runtime_suspend(struct device *dev)
>   {
>          struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
>
> -       if (i_dev->shared_with_punit)
> -               return 0;
> -
>          i2c_dw_disable(i_dev);
>          i2c_dw_prepare_clk(i_dev, false);
>
> @@ -161,9 +152,7 @@ static int amd_isp_dw_i2c_plat_runtime_resume(struct device *dev)
>          if (!i_dev)
>                  return -ENODEV;
>
> -       if (!i_dev->shared_with_punit)
> -               i2c_dw_prepare_clk(i_dev, true);
> -
> +       i2c_dw_prepare_clk(i_dev, true);
>          i2c_dw_init(i_dev);
>
>          return 0;
> --
> 2.50.1
>
