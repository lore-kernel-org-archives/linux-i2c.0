Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237C333CE88;
	Wed, 28 Jan 2026 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599311; cv=fail; b=bF/En6ajpbI1WBNZDhHLqq2HEiLswYI2GMr1Ipk9zhZd5GneTDjxfZuKMylzKGzujfgSpHvEDS8ObmY2UIalTOkA05N/lxZutsOleedIeaKMEvfFxsO1yCMUn0qauE7gl/rPKMW6HwsHA5HDJ2sUbiWnC83QAOf+f8XZk0UyQZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599311; c=relaxed/simple;
	bh=FA7L2nZ8jVIHmb27k9N8QvO6FyQcCbt940t8w6N5hnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IuDsAucbQh3sl3IZ/kaGOD4I+DfZiTXv82EVhvqWdlOP2lSpuYQd69yvmHZhQtBXTgw+PqDd6oHEr96QBXQg+f7wSuNV8xjvhTd2zd0euO1pQtWJRhvVSSoJQJO9Cf5lQGCmcTCyTn4PqBzePATjwJCuu34k3LBXlXNm9ZtIk5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IjcX7zI2; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IjcX7zI2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqhulsK8lbTXs/ElbrgN1ivhJcUJL1BFQ6FtJMhV6x8FSmmVOIYT1x4eik1XjHMxrmJmTuVlhrvDjeGZcRigYoRyG03+mViSi25gXxqLF/IFOCRA8j06nad04vL27TQX/PhTOrRfUQHecWYynx6ImFrPfY9wGlj4poVVGWYG5u807kw7JTQTBv/F3GLYUBo87iHMKwOReDVXCngCK00J6d1rUtLHl+M3rj1BZimEyQERADVDwtCNq7tSrAt92aX3JHaRUEbx55X4h9wGgbd1LxAGzXkeG5+gFjF0oIoPLSmtGIl9cpoa0VJffe6kgHSfmLjSQNheJgH5CAVbAUJkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBt6zQIr/3pCa5wRo0lEbs+JPs5+NitqFmZITpadnaw=;
 b=kpzHfb6KsnsVY23f+dKGlHPyuI3XUNVoUMNgP09GabWNyyonh1Bbog4rcI5K43BsluHN4Xq6KooGNeVm6Oh+nfnct/05L2ZCkGU4gm30TreDHz7vF03vA1CDRXXeDPpZortNhw+gjnj+Nb+wbxv1C5Ha6Yz0/Kh0pwP3T5VsqZccCDf0AcavbF3gVY0eD3zOtaLd5A8q8tp4B1KoNL61oT/pgT3mnRReDNR3tDgHyLFNQ8V47+gcl1vCSdLIjJQHXQ77uvkVcx5svCsxdvZfVoAzCjqBcnKoOJ0X55AiD8oJwbN66obj+ArTIxdLmfaDDSLoHtRqdB/EnvaxdDNnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBt6zQIr/3pCa5wRo0lEbs+JPs5+NitqFmZITpadnaw=;
 b=IjcX7zI2WlUV7TlWxPKE2r5g+ptNA2WTpu3XAjsmxnTYL8j4DtSreFx2Tv3txkkgEqAmqO0k+Bodm7HS4YZCOFdAXiOsUXxtZBnFVPgVpqiNECdON/GIeZyj5TIotv77zIVyBrlaxUhniCWKF2qQqgM8fo6qgdNbUHePsUvk0To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Wed, 28 Jan
 2026 11:21:47 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 11:21:47 +0000
Message-ID: <66c7435c-a936-413e-a016-c860d448c971@amd.com>
Date: Wed, 28 Jan 2026 12:21:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, info@mocean-labs.com,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
 <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::18) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 73702de3-124f-411d-d101-08de5e5f6c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnFuMTJjb3djWUVYT1c1QkZxTHR3dXpZZGdVM3BvaUg1Y0lpSTI3dVcwTWx0?=
 =?utf-8?B?emRBOFNhdmJCT0lHS1JyMDAxeVVrRW1weVFCUWkvTTJyZ1FIM0RIVGZuTk9J?=
 =?utf-8?B?VDNKT0lGSmZQWTk0d3E1T1BLSDdnL3dPRlNEQzZOVjJSVGxpT0Y2dzcwNzJY?=
 =?utf-8?B?YkJUN1B5MVVMLzl0VUgzVm9kZVZ4SFMzci9EaDd6dzJhWlBVNnJjR0JYVDNr?=
 =?utf-8?B?MUJjZkJ6akYrYXJrSWY4clcxTnMrZGNqQXByZEZlVEU0Mk9TT29UUndrcUtB?=
 =?utf-8?B?SWRKRytJVDlHSUZRamhxNnVxaFJDNnRCaHlJdEY4cEVKbDFuTFpSdlhiQnFp?=
 =?utf-8?B?bUsxRTE0aUxrbXp1SzJUankrZjk2dmRBekZaTDVhMi9XUElyZ1ZBM0k0U2E4?=
 =?utf-8?B?eERnOXlXUFhLWHlybUVzcCtLM281KzhiSVZ6ZlgrZXZqaFhBa3JJS3RBemMx?=
 =?utf-8?B?UU5WRGdKdWlzdzRyRThnakVmR09za21ZaS8xVHRMNDRhdzUyM2xITWVDUGVT?=
 =?utf-8?B?amF4Wk9LakpvSEFYMDFSejFLU2FQTVFNS1JsWDI4c2FLUllQMEY3aVE3aGZL?=
 =?utf-8?B?aWhxaTdMaXJQK3RkYmpTbTdLVE1qdVV3ZE5aWnhId01jZm8yeGgwamgyR0tn?=
 =?utf-8?B?NUFPR3VCYjBsTzZvNlFUTHdINkNHRkhHOWI0aXQ5UnBiY2RKamVIWmlUN3dn?=
 =?utf-8?B?VU85K2xLT05YdEV0KzRJYjVjSlNGeld3eDVsUmZxRGxYcFMzekIyN0RncVlU?=
 =?utf-8?B?YldvdlBjZUYxam1JM0lJTWFmdTVqZzExU2VWWXFhdys0cnNSUUorZDMzeFYr?=
 =?utf-8?B?V1gxMk5mYkUwYXZIS0QvSG95L3ZES3FjRzF2V1NSM1lLaDNGcU9wS01NeDl5?=
 =?utf-8?B?MEFHSFI4b21jZFBhd0U5eE1laUt2cXYzYnVCM2M3M2tQR282QWxFbkZucHo3?=
 =?utf-8?B?T1JhMk4xNWVVWVZPamtyRzlkVTNhSWNvNDc4ckJFOHJyUFRvVUpRWkYveGVR?=
 =?utf-8?B?NVI3d3cvMUNrNmhBYXlIL0FXbGgxRGt6MTBaZmRWVnIzVk9XYVV2dUszZm13?=
 =?utf-8?B?cUUxakdXQ3IrUTd5eFZ5aVZlVEcyMDB0RWJrNlg0RFNqMGJEbzJKTUlTWUFj?=
 =?utf-8?B?aER2UkFoVmJ4bDJaWDRzYmttOWNnRms5bmpyZEgvakVoOEtiQkdnL3pjMEgx?=
 =?utf-8?B?bHNoZXgxcTFwL01iNkU5KzY4eUNRSmNkU1FsYmQwaWhqd3pJOHVUVjZ2dk1I?=
 =?utf-8?B?TTE3WGdZRTdjcUdSdTUvVUtNSFFvU08xVHN4cGc5OFFqYTJKKzdKY0pEY0cv?=
 =?utf-8?B?MGY5MXJLb28xaHRMcC94YUtkeUNSZjFPYW40d2tDODhHNGxlTUp5a3VidjBi?=
 =?utf-8?B?TWhvRXpRQ1pwR2g4Tk9ncFg2V3BJRW95QzJHbVBQd2M1WXFSaEttY085RXVs?=
 =?utf-8?B?cWZnVjluYWxIcXR4WXhIdGp3RDhKemg1RnJ3cHhuQjMrYkhMTlJ1eHVmTjRk?=
 =?utf-8?B?aGRTeWR4L1RaT3lWa29qUUg0Z3hXT3l3dHZmSURsV1JpaGJBZ0Y2N3ZrVHBZ?=
 =?utf-8?B?VjdkdlJ2VW5LeFZXdm1nWWVwZzh5aHk1UTVkd09NT3NLMHpQN2JsWVdkeUR4?=
 =?utf-8?B?SlZ3VTkxd0pnUDU2bDF6Yytxakpyb1FzMEVBSFc3WTZSWTVUcUE2T0VwMndZ?=
 =?utf-8?B?aGJoMVI4aWtuM3JJUnR1TUJrSWxnWWFqOWY2WFR5cFN6MGpNQ2pSL1oyZ0hr?=
 =?utf-8?B?Q1ZkSEhXbXZ0ZHREejU5OERrSE82SldGU1ZaeVZzZGZnNk5mUndrcHJuNjBt?=
 =?utf-8?B?RlFHTlVTUGVUVHdFbHYvNDcwekpKUUwwOXpJbUQ3bGZlQks3alBXTXVXb0Rn?=
 =?utf-8?B?WXQ1OUs5a3BxUWFBK1VHbmZXTkNvMGtNV2hraVEyVWdFdFhoQStvZVpCbjls?=
 =?utf-8?B?aUFBaFlKL2xGbXVjTlArcmp0ZnFjOUlNalgzNGpFSmJvSEhtczlwbHBuZ05t?=
 =?utf-8?B?YkFDQ3JaOHA5Wm50NzBIS2NLTjFWM21LWXQ5YnUyUVU2WnJwMTVMeWNrY0Nw?=
 =?utf-8?B?RkNGbURKUXAzN2VhQ1JFZUJCcnk3a08yT29yZlQ2K3dlVVlhR3dMdEZaVDZR?=
 =?utf-8?Q?xVDk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6939.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTFIWm5YSlZwNjVLcnFQQVVCUHRNNTE4bjY1UkJvWDJaNlN6TzJLWE5sdTFL?=
 =?utf-8?B?S0puMjZlNWNkUEZucC94dlVEMzRsNUtudFlHWjlDQllWREk1YUUwbGZiWEc0?=
 =?utf-8?B?eWZlWkU2dTlRbGx0ckJLZG1yN29QV3U3TGtESHpQWlAwYnpqQkpFUUhFMG44?=
 =?utf-8?B?b2VXT3lkcy9hYVJwb1R1N0V3VzU3ZlI1OVNqUk9jZnFUaDJHWlBvcmMxOHhy?=
 =?utf-8?B?WnVPc0JZRXpkY0EwaUFBUFY4bmExMXVWR1FhWitDQVBzQVJSbVFzT2JYSXFk?=
 =?utf-8?B?dkJmVGtWZjY3dlI0cWt3cy9kSXVNZFYxSCtiZk53TmdQUFo2Zy9XQ3ROT3Jw?=
 =?utf-8?B?QmF3QVhjUitjbk5kZWdvaDBJbTg3d3lzRExnRjZ3aEdxYmlMa2dwOVFzMkFI?=
 =?utf-8?B?ZU04eTFFYWRrQ3FpbGk5dUIrMWpMMzh1VlRwZnY2dHptOWZiMGM5clN5UXcv?=
 =?utf-8?B?YjltajdHbHBFZUlmSGNtWVB2QTRMbE5pd09YYS9DQjZzM1BNT3VzMitua0d3?=
 =?utf-8?B?cVpKd0wzSGM1NkJxTUR4ZENWQ0E2TTl2bmhPakcwYmVXWlg1bVphbVVHa0dB?=
 =?utf-8?B?a3FTdDZLSWdvOExqMnhPaloycUp3M2ZvV3Q0MmFCWnJmeTlST0JjM3gzeGhj?=
 =?utf-8?B?RldFZTJJdWtLeVk0VHRZaGV4SUFDT1RXNndpaWNyK1dvdHpiVlNaVHZzY296?=
 =?utf-8?B?ckc3dHBVZDI1RFFjOC9SSVdLV0h1UC9XeTBsVFJENnpNa3hOUG9TOG93R3N6?=
 =?utf-8?B?eU5Qd01ST0xGSi9OSysxbHV2c0NlZm51UnFwdlhKWjFoZWdOclp3VkQ0QXpk?=
 =?utf-8?B?K1d4SnpEalRLeVZpUk1wNGlaK3VsYXIrR0pNbytRMlZHb0hQMllVRWJNNkdu?=
 =?utf-8?B?VDQ5N1drS3dISDVPZVhUanRVWjIyQWhFZ1NURlBRbGw4UFlOdFpnOEtSWlRh?=
 =?utf-8?B?ZkVvaWRuYzNiLzRFSDBSMUxGOGI1Qzh3WWI0bVpFS2NZbndlaHdwZ3hJb3Rt?=
 =?utf-8?B?TDg0dWtUTUdyS1VnM0phRG1GWE03K0xtNVJZNWhPSitnVW9pcEJERk1SaFpQ?=
 =?utf-8?B?YThiZlJ3dFQ4djg4d3BKQnZMd2tPZTJFVXM4Z3ZPVFo0blh5NkVqMXEzZFlY?=
 =?utf-8?B?TU0va291d1FoUFpCenVodlg4WTVTR2p1bkp2OHkrSjdwQWMzQ2dlV3NWOEJk?=
 =?utf-8?B?QnZHZk00cU1YUTMwWkk2dWhEZzJYRGtFdC9jeC9vbVVHVjAvaHdNQUZvb1Q2?=
 =?utf-8?B?T1Y1cjRNOEtzNUw3cDVZbUN2aGNtSmlia2doQUh4VmlsLzdPdytmajNBVWQ2?=
 =?utf-8?B?VGdCT1BpajRVd3V3SG9hQzZLV1hHRmE3NCtFQWJJSnNVUXVhMGI3UVZKSGt0?=
 =?utf-8?B?Tld4TUgydlZhWE5RcWRNWXpWZXQvNkMyd0M1Qk1XNERIYWRKS0FtZXVOWERV?=
 =?utf-8?B?Z05JY1ZPV3lYUisxVWRPT1Uxdnc4Sm5xZkdEaUZOeDdhUSs1MVI4SVFXZjNR?=
 =?utf-8?B?bWx6MDlQNlptMElTYmEyblVMQlh1dDdXcXdnOUxUazZub3pMY05Zd245Qmhl?=
 =?utf-8?B?U28wSThmbDJrc3hrQmk3cFQ4WFZ0N1crdDdTa1gvdHNJRVdrb3BiczArdmNa?=
 =?utf-8?B?UGtvbVJlVGJWQmcyakw0RVI1NklORTdaVmx0Z1dyKzJ0ZVlwNWxXQjBEaW0x?=
 =?utf-8?B?OEtZSnFTNVRva013VW5qZTFYYTc5aWZVNlplRGhBUkhXc2lQcDVTK1lLWnBD?=
 =?utf-8?B?SHp3Ui9SU2NLRjRTV015Ym5TWVZ2SjdaeDZjWkNEeWFsaGUvOGhkUkpUQmgy?=
 =?utf-8?B?c01TQkwzdThCa0VBcytNeUF4VkZTRXlIWUJEY3FTNWtJR2ZJVWFzcUdocDRi?=
 =?utf-8?B?K1hmb3cwUXJoR3NpaFgxa2VyOTRGQ21HbFdOb0p1NW8wa0RjR2tPdDV6Qkla?=
 =?utf-8?B?YjJvcDg1VTlrNzE3Z29MRmhSL0tSbytyZ0lXdU1GT3ZhTEh1andFNFZaL2kx?=
 =?utf-8?B?YzNrZXErK2lhc0RBSlVoQmVUQ05TdzdEVlp4K2lEZ3dLOHNLV09qMUNkL2la?=
 =?utf-8?B?aWQyYy9sNWNoQ2xMWk9IdnYrNGt0U014aGNkWGlybStmM3JFVWJmZUlNaUhS?=
 =?utf-8?B?NFI2cDRtZStBVlk1TjRONHhxdDRFQXArbjd2SS9weGU3OWd3TGw0ekwrbmUv?=
 =?utf-8?B?UnFnS2lIek9ucC9lZlpoL3h6OTh6THNCWUMyR051dHBEUDNKbjY1bUg2ZlE4?=
 =?utf-8?B?RDEvTEFiY2FRQTVSL2pBcmZhcDUrYlhiRUJkZEwxV0pqTGFLTUlKU0orMHVh?=
 =?utf-8?B?NGdGNVhGMXJteHdhUU1udjZDRzY2WGd4NGliUUJCK1RYOHYzWWlnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73702de3-124f-411d-d101-08de5e5f6c8c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:21:47.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQbA/BoAtmDwC9wHBqJBOhW5latIWg6wz1lCFOY/exKOdzS/vKLr+p5iTLc9Q96P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454



On 1/28/26 11:37, Krzysztof Kozlowski wrote:
> On Tue, Jan 27, 2026 at 09:03:55PM +0000, Abdurrahman Hussain wrote:
>> The xiic driver is designed to operate without explicit clock configuration
> 
> And if you change this in the driver, then you change bindings?
> 
> You miss here explanation based on hardware - how does the hardware work
> if nothing ticks it clocks?

Hardware obviously have clock input which needs to be connected. Without it it 
won't work.
And there are designs like Microblaze one where clock is shared with cpu itself 
and there is no way to adjust it. It is just working.

Then we have configurations where clock is coming from clock generator which 
needs to be enabled. That's case for SOCs with ARM cpus or with clock generators.

This series targets case around PCIe EP. Clock is likely derived from PCIe 
itself and there is no way how to change it, adjust it. It is just running on 
fixed value.

In DT this is design/described via fixed-clock but I expect this concept is not 
used on systems with ACPI.

Thanks,
Michal
