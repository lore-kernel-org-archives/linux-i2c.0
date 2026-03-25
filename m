Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086837269B;
	Wed, 25 Mar 2026 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470971; cv=fail; b=gNp6IA9Vhd7sMmJxPykGpMAYVEj4hrU9ZcWaElRbEpkYD4iKR7YE1DHxoU7uVvtvfq/GKKay5zHQe0l6Odi+Y8T2dZXU6Fm47HxFAkIdmXQMgz+gJTJMf/KzflNfoBwKcpSg8GLKF/US5JACER5lZgoTjSFhf4S78AII7xXqSfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470971; c=relaxed/simple;
	bh=42jVGF0X1g9Ntjg0qQAleNprKDuvBbdWcLFqWwoxRWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fq5Ja46c6EOrTiqepO29E6NdSVxDVbTpVkLVHSBxZ42oJ8k07Zz3939Bvg7emEMnBwD/Oqk/JL8akAPmseWQDOF19vz891MInbQfNETLncH13dYm1xNRe+dHj5XOrF8TV+CckqbOy4ZX1xhBls2jh7deomPnmdq+ge9QC3RpuSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oIRlvFHp; arc=fail smtp.client-ip=52.101.62.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oIRlvFHp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYTus6voVjNet8JnDVsuGu9lNjvpCQNeYt6Yxlsk44cHBRo+3DgJvQihO+9F4xKyEOJXwR7VTUBTUGgq/SFdjAAw3D8zX/h6A0+d5185fjgPQ6vnNJhVTHp7Gi/OtVeqB+sGV0MvMGs5R8DkmDAthAWFwJTGlZW07jmmTXGMPJyZoRNx5J51Qhu5rSpwqENyJ4l6zGKfnfoVhF9C35I2v0Wbt3zFQQNvPYEjClGrqSR++JrtYVPzmR3dU9SICmEATfE8IORaa83BuQtOaKpkQN+rntnDCJl5N5CxM3TJioazfVbzR46fcG6m8SxsJbNhqdxLHTV+ACZ7l9r8x63P4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITPjcJKjkKO3lwLKosjVza+WtFjOM4xoac/3wKAquvw=;
 b=TteNQ+2pdj0i6QthwRSF7Endn5+7A5n1LeNNMj3xXkdP08imhqmHciauVOeWBkUBFYumVkstEH1K2SG6pW8lQzrXdUhYnbq0Nvb/+elAtMIBGgcefCNq9Fb35PtqNQ3yBrW5KbahSc3Wm4ySveEcMMlx6/XrnUXKAALmgWrlzZq2KPUaFv5hNyW8bU9uR3G7wOv7FLP8peg/BGMdImW3KbGxv4bQ7BNGMR38nx/enh+EWyZL/iWwwe5fb0xjg+oUVaxNFeo64jTgPiE+TYV/kH/F71/8qccKdslxOQEPcXGB1uDCGYCvOaV750Au0XhGPUWJeqLanwmhHcBXNbhl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITPjcJKjkKO3lwLKosjVza+WtFjOM4xoac/3wKAquvw=;
 b=oIRlvFHpTh9Qq7Lo0JD/byqeOuSZQFHK5ck+hIHHyHLwVnpmwvADKEK8o36d4Wg7I7b5ZsOT5+0ZUJfx3tjSlDFGMSPe7v+y+bkb+7+e3txgwSoR+bYpGxjtopC7KNudUxLSNTHZpWClMN32ZCDQlwnAHjO5JwbtVR1Ikyiv+8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 20:36:04 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 20:36:04 +0000
Message-ID: <8b6c7ca6-839a-496b-ae75-c4c52b4cbd10@amd.com>
Date: Wed, 25 Mar 2026 16:36:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: designware: amdisp: Fix resume-probe race
 condition issue
To: Andi Shyti <andi.shyti@kernel.org>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: andriy.shevchenko@linux.intel.com, mlimonci@amd.com,
 mika.westerberg@linux.intel.com, jsd@semihalf.com,
 rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260320201302.3490570-1-pratap.nirujogi@amd.com>
 <acRCk2muSdoEvbEI@zenone.zhora.eu>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <acRCk2muSdoEvbEI@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::15) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1f36ce-e94f-483b-0a8d-08de8aae22d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OcWpxFJ2Td0EjteuD4PI7jiIOTJmwXq0Hjp7laXes1Hsb7pxT87bgGNMXdMDHCFo8q9P5gXg1pI+Uk7RMiRq4L01KoBU/fwow2G7auyG4q31xirjBNgDoLP/Jrz2az48I8pRThPC9WnRx/JAUcifQpNFCl87X1v0T4YQSGC/bcHe4UEnYwWwXihvpwiaOOdVNfWv6F/J11KgMbPkfQuJaDWH3LzD80Zi2Na6WlydigO5RfDVNqtze3SjWxRwsLWhyfycldVfT+zNCBKCnTClFl5T1uhSW9P4EGcxOZ/h5wEv+8kGk990E932neMwYwqbj/ZgIOI7FDzDk6Bb3aOj7GUObR5rBCwmc0Dcpo3TDRmiiQ9c0sClH1njCadyzvmrM9R5CVtHraN+rDwWpF5GTjFQmSwim09bucFnu8RoUJ44EBO0aphhdFfpOG9fLKL0gudXcvJZjvRiE/Lm6S5LD2q9sfbJRsotASGulqfHGxWFrJSY98BZCOHodj1++o8MkvXW1hcaOKPhvoN+EeUq1Q58HYM8x01g3ln449jz2105rbRKKJ7qFv9XYfbqWqhJeXFZ3+hQx2k+tSvsswTtOJGpbVUgEEX2JmxBpemah5gi4kmwf5S4gICTekZmRj/SVX7OzbIkFwi/+dgrP/LuI94Gt6dGxxEpbghz9ITSgI0lbeq74VXJFDGkBwrZoCubzJvdggULTle2O6yMJQN9U3IbGAJzpcfdt3vv2/MlgIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3AxS2c5dlFmeEZnOWpFeFVuTkYxSGRaSlF2azU5c1ZRWTlUVWRwaURwZnZ6?=
 =?utf-8?B?a3pKSDBpRzMxOFo4VG9Lb1ZWQTczODRyeGdhNlFjNzR0eUt5NWRCZnNCR1d3?=
 =?utf-8?B?RGI5YXAyUGhlRTRYZlZDMWh2cTh0NCtOeDVhWm03d2lnZTBzU0tXQlVTMndH?=
 =?utf-8?B?OVBKdjNEcUMzSkhYamREKytTNGdNN1VsMUZZSWlDbnNEdjY0NDdqWWZIZ0s3?=
 =?utf-8?B?TEFJNWk5S0FtakgrSGI1Z1FNdTJud1J4NU5rT0RzdnhmODBwekV1OCs1UTdE?=
 =?utf-8?B?OTUwM2pKOEFOZlhnSWZsVFV0anlkcUxmZk9KV1BxZHZmV1R3S3ZwdHJmaUhD?=
 =?utf-8?B?QmxMcy9HUUp4YTVSSmlxUkkrS1hQNlNmRjhxREZXMWZEL2J4djBrRmJZMUNr?=
 =?utf-8?B?bEhTR041L1VBUktCSVhSK2NxN3FxVDd6VjB5cnF1bFY4RjFuaWNoT2dtdmhU?=
 =?utf-8?B?YnJWeHRpYUY4N1U3K3I5QVdSSE8vQnpxTVdNQlRZYnAveFBuOGF1SDNkNkRa?=
 =?utf-8?B?Q1I1ZVZFSUU0WGpxNC9pNklzM2FYNmwrRFI3M1k4azRFakJ5TTFOMzN5bUZt?=
 =?utf-8?B?SHNhTFZZTmdDRHB6STZ2ekx0T2xveVhHWEJPMTdOQk1talgwUm9mZ1B6SzNU?=
 =?utf-8?B?WmpUQUVVaUllM1N6TnBJa1RDNjI0bTZkQ1FERE5NNGdkdVIwWElaVGg2a01x?=
 =?utf-8?B?K0N1RitZUytHMUczcGZyemVHNkE4Ni84azVSbVBOb1lWTEJGKzllbUROcWtD?=
 =?utf-8?B?RzRTa0kzRUJWOXkrS2FYYUZ4Rld5bmxwaE1PQnhuN1dRL1pKNW00RXVpNUtI?=
 =?utf-8?B?OFFGcURzUUJjNStkZ05kQ1ZSNHlDZDhrYkVzSFVZZFF2YU80TTdCbkYwRmhk?=
 =?utf-8?B?V2ZrQXFkVUJ2YWdZWU9KcXpjaGpqVEdMbFNWQ09rWE5nVDdSNzZvZTJ6dEdk?=
 =?utf-8?B?cmtwN2lLZ3djamRybjRvdkk2ckplcjI2ZG9hNnI0V0lGeUdadTNmQjRlMjMr?=
 =?utf-8?B?eFpGN0krMGFNVHE5K3BtWGppd3JyTUZiZCs3T1lNRzlmWXptYjZscVdFaURi?=
 =?utf-8?B?MFJKSWRMNUtjelU2alpKcFZRWHRXbUtoNkQ5QTMvVGFSNXFZSy9HVXZUY1ZZ?=
 =?utf-8?B?YXlLMlNFd2NLcVhFbkl4UkVzTHptVGcyU0tlTnFxcURZem5mUDRFSFdZM0M0?=
 =?utf-8?B?SjZLaytUTFp5UDgvV3ZNSXNNQ0txUHBtVjhqdVlDUUdNc3FNMTUvekpkdDd3?=
 =?utf-8?B?SUZ0SG83YWpSOTZzUGlrcXUvdUs5S1ZFTGxVSi9PTWxuTUtjN2tpOFQ0Sy9q?=
 =?utf-8?B?SUg2T0NyVnpKQWhWWkZZeDJEdzRjMEp5RDlKdGlZQUlKMXJoM1pPeGNTQzRI?=
 =?utf-8?B?UlNKK3Q3N2YxbGNnUm5vcmEzdWZVL2VrRjNKUnRkL0hTS3ZkZGxSbE9xaVJP?=
 =?utf-8?B?NisyNmJ4WXJGNHljUUdGQVoxUnJUUU5ENTVNbnZjTnBodUI5cXhFSnFQMlho?=
 =?utf-8?B?KzV0TVBnVThYNm1qclVBMjBGLzhuWXBNNmVvUFJCeXlib3RiL0t1cmlVNVF4?=
 =?utf-8?B?Y0VoakcwRUFoTXZjaDlNL3Vja3VBYW94SlNNOTcyaUhsQnFPVHRhV0dWRTAw?=
 =?utf-8?B?K0x2Um5nK2JCUFQ5YW9pem9rTTZtd0VhRFNRam05WGY0cUVYQmxpOUVicUxJ?=
 =?utf-8?B?WW9kNUFDYUw1UkxhR1FRS3VJbld3TlR1QWRaNXFwOUVsNzAvU0NjSWdaS240?=
 =?utf-8?B?V3hWWDBOMjhkN2FBY0JuSWY5MThRZTVJSXhIbGtRZm8rT3NDeGVaVzFCVzRu?=
 =?utf-8?B?SDRkaTRDdmQ4aXBSL3BOVmd2WGxkOUVnQldubjZMbVM4MGcyUDU2ZGFsV2tK?=
 =?utf-8?B?ZVRZTHI1NVFuQitSUHlwT0pWa1hlMm5VbTVRZ2ppZm1WYXVHcWNNeGxYeFVL?=
 =?utf-8?B?WXlGTEVwd0c4V25HbUVHVE55aHovbndSSWZmY1dpQklqM3NMeTYvMEJMblBU?=
 =?utf-8?B?eEc0STJkS05ERkxEWW5oMzFMU2JPbFRVeGRReTE1NlZ6ekZIMkZuUThxd2pU?=
 =?utf-8?B?SGs0ODVpVEs4dDJ5UWdXS3lhU203RG1iU0xNRUMwZ1JMTTVoSlFsek5sM1pv?=
 =?utf-8?B?cFViWnU2SE5QQkVMaDNjR3FrOUFvS1JoY0pBMXI5NWRSRWpoaDRXQlkwTU9G?=
 =?utf-8?B?bmtqWU1ndnpCYzZsUWg3UStWYXpUdHNWTmtEY05mYXNaUmlJMjdJaUpCVE1Z?=
 =?utf-8?B?TldUbkxnSXhHRFVXNVhrbkNRSHRydVVZbyt1N2VxU3FwYjhDbEZrYnk5bFhs?=
 =?utf-8?B?b0dwcjUxdVdBemYxUDNCVVl5WDlxQTVMSmp2N3BpL1AzUFhVdlJjUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1f36ce-e94f-483b-0a8d-08de8aae22d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 20:36:04.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZciW9SYOw/3tsMzxHv3d0QWIMZY0zLcMC6iVa7VxfMqVGwzDoFGC6zSUpHQtk3aXx4kvRCVgOkFvqpTYUSGyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081



On 3/25/2026 4:17 PM, Andi Shyti wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hi Pratap,
> 
> On Fri, Mar 20, 2026 at 04:12:22PM -0400, Pratap Nirujogi wrote:
>> Identified resume-probe race condition in kernel v7.0 with the commit
>> 38fa29b01a6a ("i2c: designware: Combine the init functions"),but this
>> issue existed from the beginning though not detected.
>>
>> The amdisp i2c device requires ISP to be in power-on state for probe
>> to succeed. To meet this requirement, this device is added to genpd
>> to control ISP power using runtime PM. The pm_runtime_get_sync() called
>> before i2c_dw_probe() triggers PM resume, which powers on ISP and also
>> invokes the amdisp i2c runtime resume before the probe completes resulting
>> in this race condition and a NULL dereferencing issue in v7.0
>>
>> Fix this race condition by using the genpd APIs directly during probe:
>>    - Call dev_pm_genpd_resume() to Power ON ISP before probe
>>    - Call dev_pm_genpd_suspend() to Power OFF ISP after probe
>>    - Set the device to suspended state with pm_runtime_set_suspended()
>>    - Enable runtime PM only after the device is fully initialized
>>
>> Fixes: d6263c468a761 ("i2c: amd-isp: Add ISP i2c-designware driver")
>> Co-developed-by: Bin Du <bin.du@amd.com>
>> Signed-off-by: Bin Du <bin.du@amd.com>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> 
> merged to i2c/i2c-host-fixes.
> 
Thanks Andi.

> Thanks,
> Andi

