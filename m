Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4D358386;
	Thu, 19 Mar 2026 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955467; cv=fail; b=htJ66bhZSsdIxA/EyRu7ytyIFD9V6issOPFT1E/nJDFdGIBnQikeKlL+hN9Me251bMpCVVSD7Z6H0MWSASamveEbYIl6lZh3Rj+L2kYDrsCpCqyWrCLHf41PYrRBKhjrSFZmAnK9WXzVDWlMqV0DYvjxpXlWJJNBaRVOWEDy9wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955467; c=relaxed/simple;
	bh=oD2hRdkTfCKpttg4Cpk8+NYJE72Aclror512YzQPaWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h7sospfkm/31QDB1S2gdsD2XplPvObQ+SBryU4hNiFLgcYVdigD1vNyMVwvOIs5v/GN7UVW82vgpUEUJ8Qf4Kcfo28GD0r5hBkDS4m0F9aCkMtfbhuTQ7ymz+LUcUCPkQnZz5W/9BkMcqyNUZxN51aMX21emdC6KPqVvEspuh9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I2Vu7402; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I2Vu7402"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVwXdifPook5ppFYMsBVaxpp1/AkllXcugn8Y8OaKRhn98QMCTYQhv01wtZyNNG4QIxS/2FoVWqYSF25bO1K8Kk4nSp+qsCwJKavs0fIrljiM2HPMKfg+vHhmRuJMnldRTnkUv+Gnh8PbEuXPN67iO+/MXqe0+3hYBu1DPiGmyFIjGYPbJBGL7NKtJpUWtzJEbrT1zlfQ0D1YNUw3+qeMw8A6kK2J03kQxVB1zqnDMuo+gGG5RBzx0jkRrmoR23ZWNy+9aAagXs4zeUinzJMFHFt0Hj/rDH+OQlqbI+AFGki0y0oBbYnXvXjNBWBfVMiGqTyjDw1B2EnH2r8T/m/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C20nLjKYhrGssKoSjgA0pkf0e24EwMcIVjV3iO5hN3s=;
 b=N//IK3bR+kKk2JF1iUhlPTMU1SHe9Vd2WKkWq24ggeO4SIgAVSQ3qJa6VRPADf1ow2yzWBrIj+eF1P0RwOGkvOPBWAtriwMmE5jml2CWFQZePwvY/c1cj4f5ooyf6hzXQRbTLftN216j7SwPGQXsn4TDwfGoUq5kWUBA0uXVpDEKvUTPDgStkolEK6+mvMRSCQaothVLAjanDTGaPY7fMSUhkPc+zp9ee23w/aSaxIS2uy3bxrDCKs+sdE2MUNryMMFyl8PXGMQywmiEiBp7s3l6/tQCkdQNDF6i1+wXxCkScqi5D/06xU8vhEYqDTIKTCANOq2F8tocqjvNGXSd7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C20nLjKYhrGssKoSjgA0pkf0e24EwMcIVjV3iO5hN3s=;
 b=I2Vu7402SfuZ51Z8NsYgNSt9JkcsIhIvI73Qe1/G5jwdokiGoPaoeTSpsmRqGTpt7+akt0X7F7r0Vzxtf/7yn4AamKgo3a+uv0whdjlMZO7k+lU7u5mDsy0MlJ2ptNYe4CF5gb6q6OeqgE9Qzx+/m8lpjVTrNDB6c1bLIVywdTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 21:24:20 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9723.014; Thu, 19 Mar 2026
 21:24:19 +0000
Message-ID: <0b32b6b8-5144-4cad-b5f5-f4531a9508c2@amd.com>
Date: Thu, 19 Mar 2026 17:24:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i2c: designware: amdisp: Fix null pointer dereference
 in runtime resume
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: andi.shyti@kernel.org, mika.westerberg@linux.intel.com, jsd@semihalf.com,
 rafael.j.wysocki@intel.com, mlimonci@amd.com, benjamin.chan@amd.com,
 bin.du@amd.com, king.li@amd.com, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260309220038.1420996-1-pratap.nirujogi@amd.com>
 <aa_-rfyWBtdkA_qx@ashevche-desk.local>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <aa_-rfyWBtdkA_qx@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b38bbc1-69d7-455e-7259-08de85fde1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zsKCWByGK/b3j57vE/AGLOaMvxApxPRmgS7YdpXqvjjUCERtkjHsa9jGpkZj3GNM6qXHrtUpkxbjEFL6QN6S6Lv9PDMn00mSptVunytgD2c7Pp9y3On5yLp1DaizHMQ6Raw2oxzhtBBK3gNwWG0tVNA8/CyMVDyyCJwjsLOWCIB9PF+fHRxrYlxZvDf1gfct5V85A7pY7FnqgRinou0apasBHQv3Uepq0yv0aLiqr6gCh6XeA5Xw65en5RGObtUEYn5u4NlaupApKuD/6vi3X2iVhgK+puVT/Jx4f0dF56PgYjZELWemlv2l2NPaKPu865HPs3Sq6HzpgtyAM3kpSLHWggvHv33RAAX8bm4NmRa2L01m5WIiJKWwsr9PJ0B78p1WWLNci0Ru7pSF6XsY5uvVveDrJMextmz2cTBP/4BB0HozkeiqkOy8Hx2GF2HzcLReOWXLFsk2CAJ5/n0u1kDm068BIqBCGIqFErU4c8H3Nc5/lLbP7Zc1Qw87b5SyGammF06oq4S/5/5HeJRF/xrVDhcTOIqLyTQ7TibtGAOXJV2M1vN7z/6RtESq4sehsn+Ib1jbIlC7cFTgen/ye5q9K1gU9vUO/sw+KXVrooZMF7IKxqx1xe60zJ26BsvEaQF8H4Pplv9spaa+CNjAs7vKeYBQPyvBqkAB2m1wo5XJoMvvKqy9K7CrOYtmQIDLlxRgONJzrZUMMpRaFv9ErTZJP48Fb9GE9RI8bEb2z/BHsQIhQMWMTpVN++RoRGu/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVFHVkNqTEtoSC85SlBFSksrRmk0cEF5ZG1JUkJMenhsMmQzY2Z3WktmTmt5?=
 =?utf-8?B?ckhXMkU1eGFOREJFTGxJdHB4Lyt4aXZGdFpYQ3hIdndvam03QUZyVXpZMzhJ?=
 =?utf-8?B?VFZ5Sm9zc0xxUW8wdzJYYjRUMTEvUXA0dWVFdUM4VkRLRTJWbUptRjBvb21z?=
 =?utf-8?B?dHNNemdsZCtjM3NQcjFJaXlBQlBFY2tuNVpJbFVvdDQ0MFJhRFpnMTRSOG1h?=
 =?utf-8?B?VW84MjQzdnUrTENSR2E0eXlzSlJRWWFxeFRpU21yM010Mi9oOEtyOTI3MUFs?=
 =?utf-8?B?S2ZZY3E4TUtrSjlIV0gvaUZZNVFVbmtmeEpjOUh4allIS2dNUlUyUm8raEI4?=
 =?utf-8?B?M0lKdHgzM2NZa3JGQmFQa2M0U0FHWnh2WHUyZ1dINmx6UitZWG5zV3FObXRH?=
 =?utf-8?B?enBGdC9BTUZRcTNHbjIza3lzbXMwTjVuS3hNa21pZzRsMXNDcGFURXdlRC92?=
 =?utf-8?B?bXpFSzBmc2I2bFFVRGVza0ZqWnhHOVFOcC9RbCtrck01dWNkUjFTdU1YWGFT?=
 =?utf-8?B?aFdzRlN3eHl0SGlqdGNNTkhNQ3YvLzM0K2g3N2FrYWhwdmZmTWorRWtwT0p2?=
 =?utf-8?B?ZTIzVkR3dE05TjVJbHJLZG9EY1EvZEFxczNFY1JFd0hlcFkvd1pJM1ZyN0ls?=
 =?utf-8?B?OVRjMC9QVmlpR2RrT2VYemljczBrV1dtbXRYRm9UcFBXRWpreWpIUzNrRldy?=
 =?utf-8?B?akdYSnRFb3R6NFlDL2s1UDJ0ck1MNHRsclpuNWxtUWZXVE82WHZEVWo2aGhI?=
 =?utf-8?B?OFUwT2N2NVo2am9UY0MzWDIyT3VIa2c0U1V5TVFCMXBSZEpvdjVRdSsxRHJW?=
 =?utf-8?B?dmREN3RJVU8zWVVYRnd6TGRYWVpjcDFTUUI5Uko3eENqdi9jWW1YWElvc08v?=
 =?utf-8?B?MEhYS0JiTGIzSTFKaXNZRzZCK2dtUGl3ZzhHTmpBUnhiWTluN1k3RW0yd1NN?=
 =?utf-8?B?Y1B2cFJWc0xaQks5OG9aR0JlSjQ4Ty9vaGNkOFoycUc4TU0wQUw2WE13UmU0?=
 =?utf-8?B?NUhWdFg1YWRHS1ZtMXN6MWhKUzVxeDNQYWZTZGIyMEJwWk5pTUZzTVVUVzl1?=
 =?utf-8?B?Vi9aTDNueEJDSjMwZGczSU54WnpEK1VpRXJTWkdvMm9vUHpSbEFIQWY4ZEVF?=
 =?utf-8?B?YklwcWx5L3lLZEswNG1WR2NXdkJKckZHWkxrNnF5dTkrcUtrRkVXMWVNVlgr?=
 =?utf-8?B?NGc4QUJoY05QWG90N0RnVk84eElyRjhKNVZ4VHdRSXRGNmZpQm5vT2JmSVJy?=
 =?utf-8?B?RHJDb2p4Z3RpYlA0cTJ0UXhyQmxvUXluMHVPUk1PdWZvaUNqMkpZcU5lMDdi?=
 =?utf-8?B?SGI2V2RQMkgzTi9pUm4yY1JFYndjdGVHVC8wY2M1OFpsanA3Z2ZHZnVJNXVh?=
 =?utf-8?B?RG5RWWp1TU1lemVlNVo0Zk1ySlFHT1g5UTNlSStYazk4VTh4dTFvaExMNFox?=
 =?utf-8?B?SUlFYnhZWDV2WTlQWkxLaTEyWUQ0ZkpNUjRueWxVNThDcklGMDlNWG5wZmVW?=
 =?utf-8?B?MFA1SzJoaDY2VlhGREFRblB1TGk3Yi94SUhHdG9sYlhvUkF6eHExYVBxUS8z?=
 =?utf-8?B?TGZDL2JTb2laUnhkMFlTbWdRY2JJRm9pOExnVmMvbGFzeGVta2YxOU9oY0NR?=
 =?utf-8?B?V0lBRUg0WHBZQjFSWmdxSGFyQ2JxdjBSL3htUnZxMEtyNGc5RnlmY1AvMEVN?=
 =?utf-8?B?d0hDOXFKSUpSTk5yNUlLM2Qva2tabVNqcjJaSkVmMFhtbFFMa3d5VE4rODZ2?=
 =?utf-8?B?TVFDTGkvOXZDdjdnVnArYjVjRWM4anI2KzY2R2pLMlJpdWkrRWN6dDlxcWVt?=
 =?utf-8?B?WnFVeE5vRy9OUkNLanVGUEVSayswOHVmck1LUklRRjVLQWxhZUttOTZyYUEx?=
 =?utf-8?B?dllCaXN4eThJSDZzM1prdllMUDRvWXgvbjIweVVKVENZbkhOSmFZNEFGVG5N?=
 =?utf-8?B?b29MN0NVMTNuWjVxamo2Ukhpbmg1MkNGUUhiWXBqRHZYN0svM1lXQkdBR2Fn?=
 =?utf-8?B?RnB6RVpkUWRLeSt4Tk4vdHUzNXFIQTFCU2xwRU1HNWU4U1lTckZkSGpLZEZj?=
 =?utf-8?B?NFJ2cTV1Q2NyRmxVQ1ZuK1A5d1N0bUxLR0YzdHhOR1c2RlBCN1VBOW5ZUWh1?=
 =?utf-8?B?SnV0RUUvTS9CalRIVEJQcXpkeTgvYTVuRGZCOWF3ZFA0eFZ3M1VCaUR0TjNP?=
 =?utf-8?B?ZVVMS1VRMUJZUWFYK2dlYnBQTnp1ZkVBRlBlUFNqd0VTZk93NjVEVmlPd0Q0?=
 =?utf-8?B?MTF4TTVGNGdTdUpCRXkwcGloQmdydmI0bFpjOXhQaWxua2llSTdlS3NvNVNv?=
 =?utf-8?B?MTVJeU9oM0NTK2tzeDhIcW5kK2JQd2pZTXkxek1MK0ZMTkp4TGtiUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b38bbc1-69d7-455e-7259-08de85fde1ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 21:24:19.5480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SsuQWT1Zkwb6C1mP26UxBQuX+jnS+nnda6MOytf953D22wBpcl+WkrfcclP601c/S8jdaXaXqncHRGTOVpECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

Hi Andy,

On 3/10/2026 7:21 AM, Andy Shevchenko wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, Mar 09, 2026 at 06:00:01PM -0400, Pratap Nirujogi wrote:
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
> 
>> Co-developed-by: Bin Du <Bin.Du@amd.com>
> 
> Please, read Submitting Patches on the tags, especially how to correctly use
> Co-developed-by.
> 
sure, will fix the incorrect usage of tags in the next version.

>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> 
> ...
> 
>>        i2c_dw_prepare_clk(i_dev, true);
>> -     i2c_dw_init(i_dev);
>> +
>> +     /* Skip i2c_dw_init if regmap not yet created by i2c_dw_probe */
> 
> Use same style for references to the functions: func().
> 
sure, will fix it in the next version.

>> +     if (i_dev->map)
>> +             i2c_dw_init(i_dev);
> 
> TBH, Looks like papering over the problem. Why the resume is called on
> uninitialised regmap to begin with?
> 
yes, I agree, this change avoids the issue rather than fixing the root 
cause of the race condition. I investigated further and shared the 
details in response to Mario’s comments. Could you please review the 
latest response[1] and share your feedback?

[1] 
https://lore.kernel.org/all/61dbe8a1-6578-4690-8571-6b00c1850d34@amd.com/

Thanks,
Pratap


> --
> With Best Regards,
> Andy Shevchenko
> 
> 

