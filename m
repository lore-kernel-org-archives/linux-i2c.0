Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793605133;
	b=nGvkiKGTWXof1jMqnwB2MYKXV7HfLWkmj8g0XJcM/fKBmj97aXf8koDx2Ps2c/8B5c5Q
	 Hv6DTZ4KDZKqWH/1YHvg2aQUSYAFEGkJPDN8VLsRgLJe15cJDsJ0/C87BahisDjj6DMiQ
	 1OFVJWC5i4Z183pY3lclzmj0muqqSuIkhpYAA0SYGC6yf5RFfcqmIZOA9pyRkF5mkpQ34
	 0GZoAtYcOfebHttlIlStiNpkvibc3QbQvB3oLkGQ0a1EAlgi2AfHoX3Gl0XFqndq4Ckee
	 NzxRgN0AhGpe0W9pyd525cRVR+DT3GQ2+V5DXq8lBCEbcoWPnl9PJ0WBtIogE6dcnRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605133;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=f6fwxTHOZBGRaM1Qv4quVRO6VZkQuqnxMy6a+ocbSSc=;
	b=LuC4HhdPjOFMauGAiwXcNt8FtiUFkBQNU2bnnnlDInsi6j1Q57DrsbOCSUNWWr5O7BM7
	 jr5Ied4InayIQD1bDtJD2v2Fi/nbV92Jz7ledZR8zUcNJK+ryBxOmPMD10NfJcuL7UBIf
	 Cqz0WxL1HtvRKBSwEzK7TW8ysZKu+pYBaP3LigbdFnGDii+ElDtUXfMwh1AXbopBfLEK4
	 0RCKahy7/GRG+VoXAdRuxSEy4QsMQTqUW8NuFXgik+c7FaAV23bT4XJ96RwHYJ90Jsv3p
	 StrFZUQUNJE5tefPOcUqS1F3z3tj1kF1AiQ6VBe5D0vUND6i1jBvKyGIJetXKXCj2fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vnR5YRSQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.5
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B53606A324;
	Mon,  2 Nov 2026 07:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62B53606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vnR5YRSQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3WVs5c88jOI5dR9be8/hRvjoWRaWIVcNL1DymD6v9OS96oRDmBxjR7V/o/o2Hft9+WDiphyxiZeoRgRP7gh0zrnsCslQZ2Mfmx7+M02o2mwtb+Hp74oCZ1waWrEgGFYY1uxiwFBXk3DGB7FTwa2qEMOh7YPThRYIl2P0EMaVvynGbW/ywFcdyGHB60yAF7WFe0ZxDp/4B0iGz4eTZtzTt3A3znmUuSSzSElUaeaIYcObc4AwFUvV7LhvDSVGAGK9xWt6odqcl5afWyfWPTPucD1S0H5ie616saFL1NMwYdwfG6lOfMIH7iWlKDo+cK7TwOQw/uOBRoYA2oTQnIoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6fwxTHOZBGRaM1Qv4quVRO6VZkQuqnxMy6a+ocbSSc=;
 b=dPBtQKGw2GVEtdly/J191htoSfDxicrdqcOPq4zFgLNnxC02D/jnRkBF7Hm3lf2do2vGFthIsknNb6n22QEPM2jEWlVmoM48u5sH2+fBuyW1VmOFVue1ExWELVoF5d9cn8QRSQzurSrOIoylgOXz5TJMkj3M3XtYYyBlE5a/k5tful6MnjCJlRlFUi/mdI7OlZ/5ilyFdBJjdmlBZB3Kr9zXQLERl/zrzZTKHx4rBbvdJV/6gmXTxxQa0SxT/gzKgd5O5RfMktPcx5TXHcKZb7goG/dMdbDe60JI4w+CkhK6M7Tg7qzLD8upLuoE/rZ739NbKCaus2mdjn73z5tiOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6fwxTHOZBGRaM1Qv4quVRO6VZkQuqnxMy6a+ocbSSc=;
 b=vnR5YRSQUKWYjbxXYHuxVgLIMVvQqiwh+Xcpre9O+jQuYc9DkTYcby/jHN5b4yeS3lLHHRyHeVtEV5XGcbWq7Z03H3USLEuQp3CuueIxIWuFruN4VjzDFVNtnwZtdQHYrrHNcabWsspI+Fi4LnfqF77Jq6bvqbuVPvmw0AzSz3s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB999319.namprd12.prod.outlook.com
 (2603:10b6:510:40f::24) by DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:38:46 +0000
Received: from PH8PR12MB999319.namprd12.prod.outlook.com
 ([fe80::582a:6d15:9b75:5235]) by PH8PR12MB999319.namprd12.prod.outlook.com
 ([fe80::582a:6d15:9b75:5235%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 07:38:45 +0000
Message-ID: <fd6ff4c4-ace3-4e31-8477-d3e4e149490a@amd.com>
Date: Mon, 2 Nov 2026 13:08:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: amd: fix SMBus block header and PEC handling in the
 RX path
To: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>, andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paritosh Potukuchi <paritosh.potukuchi@amd.com>,
 Sanket Goswami <Sanket.Goswami@amd.com>
References: <20260627153532.547719-1-paritosh.potukuchi@amd.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20260627153532.547719-1-paritosh.potukuchi@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To PH8PR12MB999319.namprd12.prod.outlook.com
 (2603:10b6:510:40f::24)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB999319:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f0eb1b-af32-449f-3744-08df38b45389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|56012099006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|11063799006|5023799004|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	NNnrn+RwWyobo39P2v5t6Ng/DYkMJv6LShpmMBNm3VjpXXkz7pipcyyOS32OOm4btaSCilRdepH/wwEhLUdoafLfU17pF8b7OZouzJ2A0FdTWSRyYjPHRlDxjx60S0N/jsRDriQvb27gtOqBjrTh5XnDY83RrzoIjUJkZyUQtY8hkRhPu62VDsvQaple+oZaXY1QkU4rTel/WLu+et3LB/Me/q+VQmi2cxUaJSIw4YzEua4tZvsnhUtsf0gbJeIioaMp6KXdWfiCCg6P2I7y+jQQ1lWRH/GxSS1pOhLLnjPf/f1ydut7wtPPwDQO/qA8xAPrgKvUy1ncfpK8z7hGqfUpF5M3MrvLDeLK26wYY7AZMgplDbyMHnWGMETEl09TPZ1iv0HkW+hhmhoHWQzTGL31LQFGNc4+ibtFJ4elS7KPmWa+HLJhBfOJkrL3LsZHwcww+CYNv36PnvsVgB8YOA7L+W8OZnvA3nsNy1qiSccKiMsn1lsL6AIxsDxtTIAfytJQEedCtAyZh3i3m3DoxhRTECihgATZXIXZi6ccIYbJnzM4NnX6vNKQD0WbbYkpDE40/xH6mks2tUPsnBD3ZqPXkO7vu17QClGMcQAv0Q6uTjXNmoZ0APFTEes6yz4LbkgUIX/gyS4qQS2F21AMP1I2Ie5UpihJlSwUzS40QM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB999319.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(11063799006)(5023799004)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm14SlpUdXlOa0NIdHJiOGQrQ2lOWWJHV2RxWTdVMk5GV1ZMTFpoTGRDRWV0?=
 =?utf-8?B?Q3I4VDROWWdnSyt3MS8wdS91MFdGaGd2b3RNMDZYdU9vZTgwYWhVUXNXUldB?=
 =?utf-8?B?SDJVUWxUSHl2Q2dVM2ZIQ1BUNHpZOXkvaW9tZ1drOWpWTUdUTnFTYWNxTW5I?=
 =?utf-8?B?ajVwODMvQlBUWVdESzBVbXdLZCs3RXlhUWhVUG5YZ3JXaEZ6RWw5TDNJNE9q?=
 =?utf-8?B?RlNZQzU4VUI5MFlEQVczM2JKS1hjVGxMZkJwUGZvZlFFNE5EYmlmMUx1ZlRR?=
 =?utf-8?B?Q2s3aSs0dGF0NjhLVWR6ZmFTU1JFenlRVGhDdmg5UEM2bk9QU1NlWWh5M3ky?=
 =?utf-8?B?RldOQVQ5Mll6Z0pMV21FS1FlZFNTR3ZWa0NuNmdjdXpWT3hFTGVOY0xlTHc3?=
 =?utf-8?B?OXFGZGMvZjFBbC9UVnpRd0U1eUlzeWFGNjdMbTY1N01YbW4ydkFybnBaQXc5?=
 =?utf-8?B?TXJNY2hzUmpQVVBmc0lySkZHYWRjdGFoTHpIRld5N1dGQVg0NzJJdzZyS015?=
 =?utf-8?B?cTVONUFvcTJOWkNhbkU0U0RJWkdRSkJzZGhWRlhYdWp0OFRUbzNZVnNlTEoy?=
 =?utf-8?B?c2tiN0RzeGE5VGxPRGNqbGljSDhwdFJRcGc4OWxaamNLSkVSWlV6TSsxMndn?=
 =?utf-8?B?azh6OVZRdUhZNlIzWE5yK3Axc2FkK0ZvclM4ZE8yN1FRV0gzcTVmSzdmSVZy?=
 =?utf-8?B?a1lNWnh3cnJrNWUyQjhEMjVObHlxUWNoRHJkQ2wvSUxQU1RDRG13REdBeERJ?=
 =?utf-8?B?NTZoYVFaTnlUNVAzZjFxZ3Z6R1BRaXJMdkVpcVgrN1I3ZkVUdk5FUzkvYlIw?=
 =?utf-8?B?Y0RuQzU2K0FMeU4xNE9VSWJYWGFHNG0xTFNuYVIwSEJKOWlhRFhDOEg5aEFO?=
 =?utf-8?B?emFtSHZqMzZxeUJFMDQwYWhRdTN1RWkvNmdpRGhpbTR1YVBPWHdONGJrUld6?=
 =?utf-8?B?bzcwajBFQ0x1ODhYck9PNDJ1RU5XNEk3SHFYQmlBOWwyZXJLNnZKeWdkYkwv?=
 =?utf-8?B?RWVxYUprc3lNVU5TczFTeWpYaUJ2M2c1eThoWXo5eE9ZdGo1dWxNajFkb2tk?=
 =?utf-8?B?c20xTU84Vk54Z2Vub3BWTWw1MThTN1lkUlBjN0NVSzZseC9FOWdoLzdzWWtL?=
 =?utf-8?B?c3VlMHdHdDZaRGlKOFE1VGptZmRWYVVwbmVCeVVvOUhCTm05MFpOMVhMc2I0?=
 =?utf-8?B?cDlOcy9qY2d5d2pLMHQ0SW92bTZYMHVKSFluQUNYQ1hFaU5PNEloWTJXT0I2?=
 =?utf-8?B?Z3lBdHNzT1dROEdlc2laSWt6bFBQL2p2aWRKaUl6QkJBL25HaytPTXJuelVD?=
 =?utf-8?B?N2dQeXlnNks1TEdFL2xPQjQwSlFaUFNWWU8wdEtqTENmaUpMUWRsdGpMbk04?=
 =?utf-8?B?U1FBS2N1QS9scyszeW9ITzlrUXIxY3d4V3NFc1I1a3AxYkUzNzFxMEk0ZXI0?=
 =?utf-8?B?RU5pV0FyVXFkTzdEZWVudWlvMUh2MzNFTWZWRzlwRmp0T05UVWRtN29wNTd4?=
 =?utf-8?B?RmlwZUsyL0RKeTEvNExSQ2hvZDdwT1JhR2JzMFJuaGpxSEtGMm00eUlraktW?=
 =?utf-8?B?Y2dBbHkwQWl5amlUUlpuaWhzUjI2V2c1UUp1a3ZPK2h0aG5rMXdRWE02SzlB?=
 =?utf-8?B?RW1HVDNjRmFoYks3MUxwMDE2RVFPMkd0WHVlcmlXUStWNm5lSFZoZWlRY2tL?=
 =?utf-8?B?UmcvNVpkSHNrWnFpNmdrL202SGhPTTh5WnFkNm1waWM2RGNXdzA3TjdJZHJS?=
 =?utf-8?B?RXd0WU00cjB1ZVZxT2xMMU96Z2NPWEtZVlNNUy9FV2NzZzlpbk1IR3JJRTlH?=
 =?utf-8?B?OGpZSEZlQkVKZUlyYnNyTzFhRGJYR3VkWGlML2w2dlg0Z3NGUWNvRE80VlNS?=
 =?utf-8?B?TmRlMWoyb1hEdTA2Y2NJUmJuWmlBYXlGNUZ1OHBEcHJEd05CVWRtdFE2UUI5?=
 =?utf-8?B?L1BKKzNjQVh2cTVGMFpTdTVQTU80OFUwUEk3VmtTenRJVjhLL09YOUZQWFFX?=
 =?utf-8?B?K1RkS282SWFJSW8rdzNlVGlCbGFxM3YySGpIWnU4N2JUVUhWVEdiZjEyOGlI?=
 =?utf-8?B?N1NXSy9ZaHQ1aVE1dm9YTzZyOFZ0VTEybE1qWFl1S1kyU1JrQnNoQWJraGxm?=
 =?utf-8?B?YXVkVHJwaVFVODNBL2tCakZ3REk0ZC8xaGZXWGNqT3JteElyaDZ2R2Vzb2Yv?=
 =?utf-8?B?c3BTS2FFZkFXcW1iUS9kQUJ4aWN5bkU1VWpSNnNuQzMvVjJFYXJ5Rzd1WHc3?=
 =?utf-8?B?eHZaa2VCVElUSDVJRWlNL2MvN3dOSVFRMzZUb3ljSExFemVFL2J0eHZBMGxS?=
 =?utf-8?Q?5NmHBDfWpxGn0lBgOX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f0eb1b-af32-449f-3744-08df38b45389
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB999319.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:38:45.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWeiU+wfw9dCTuUbFcPeU9hli8bfRSAYWNIXTJt00YH6GhSQqpui2+ZzNfqPTRcO098VnVcCdNDpsjKYfSgxFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351

Hi Paritosh,

Apologies, I missed this. Comments below.

On 27-06-2026 21:05, Paritosh Potukuchi wrote:
> [You don't often get email from paritoshpotukuchi@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Strip SMBus block header bytes from the received buffer before
> forwarding the payload to the upper layers.
> 
> Handles the optional PEC Byte at the end of the received
> payload.

Can you say a bit more about why this is needed? Which target backend
are you using that wants only the payload?

I don't think the bus driver is the right place for this. The target
interface hands the raw bytes from the wire to the backend, and the
backend decides what they mean. mctp-i2c, for example, expects to see
the command code, byte count and PEC, and checks the PEC itself (see
mctp_i2c_recv()). With this change every MCTP packet would get dropped
there.

> 
> Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
> ---
>  drivers/i2c/busses/i2c-amd-asf-plat.c | 34 +++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-amd-asf-plat.c b/drivers/i2c/busses/i2c-amd-asf-plat.c
> index e1699da838c2..daf318ce3bbb 100644
> --- a/drivers/i2c/busses/i2c-amd-asf-plat.c
> +++ b/drivers/i2c/busses/i2c-amd-asf-plat.c
> @@ -46,6 +46,8 @@
>  #define ASF_BLOCK_MAX_BYTES    72
>  #define ASF_ERROR_STATUS       GENMASK(3, 1)
> 
> +#define SMBUS_BLOCK_HEADER_SIZE 2

Use a tab here so it lines up with the defines above.

> +
>  struct amd_asf_dev {
>         struct i2c_adapter adap;
>         void __iomem *eoi_base;
> @@ -61,7 +63,7 @@ static void amd_asf_process_target(struct work_struct *work)
>         unsigned short piix4_smba = dev->port_addr->start;
>         u8 data[ASF_BLOCK_MAX_BYTES];
>         u8 bank, reg, cmd;
> -       u8 len = 0, idx, val;
> +       u8 len = 0, idx, val, offset, data_len, payload_len, has_pec;

That line is getting long. has_pec should be a bool, and offset is
always SMBUS_BLOCK_HEADER_SIZE, so it doesn't need its own variable.

> 
>         /* Read target status register */
>         reg = inb_p(ASFSLVSTA);
> @@ -110,12 +112,40 @@ static void amd_asf_process_target(struct work_struct *work)
>         if (cmd & BIT(0))
>                 return;
> 
> +

Extra blank line.

> +       /*Below is the SMBus block header received on the wire:

Missing space after "/*". Also, this describes the whole frame, not
only the header.

> +        *     Command       --  1 Byte
> +        *     Data Length   --  1 Byte (number of data bytes)
> +        *     Data          --  N Bytes
> +        *     PEC           --  optional, 1 Byte
> +        *
> +        *     PEC, if present, is the final byte of the transfer
> +        */
> +
> +       offset = SMBUS_BLOCK_HEADER_SIZE;
> +       if (len < offset)
> +               return;
> +
> +       payload_len = data[1];

This assumes every write is an SMBus block write. Byte/word writes,
or i2c-slave-eeprom (offset byte followed by data), don't have a
length in data[1], so they'll fail the checks below and get dropped
without any message.

> +
> +       if (payload_len > len - offset)
> +               return;
> +
> +       if (len == offset + payload_len + 1)
> +               has_pec = 1;
> +       else if (len == offset + payload_len)
> +               has_pec = 0;
> +       else
> +               return;

PEC is only guessed from the length here, and it's never checked
before it gets removed. Does the controller check it when
ASF_PEC_SP is set? If not, a corrupted frame of the right length
would be passed up as good data.

These silent returns will also be hard to debug in the field. A
dev_dbg() would help.

> +
> +       data_len = len - has_pec;

data_len is really the end index, not a length. The name is a bit
misleading.

> +
>         /*
>          * Although i2c_slave_event() returns an appropriate error code, we
>          * don't check it here because we're operating in the workqueue context.
>          */
>         i2c_slave_event(dev->target, I2C_SLAVE_WRITE_REQUESTED, &val);
> -       for (idx = 0; idx < len; idx++) {
> +       for (idx = offset; idx < data_len; idx++) {
>                 val = data[idx];
>                 i2c_slave_event(dev->target, I2C_SLAVE_WRITE_RECEIVED, &val);
>         }

If your backend only needs the payload, I'd strip the header and
handle PEC in the backend and leave this loop as it is.

Also, the subject line should start with "i2c: amd-asf:".

Thanks,
Shyam

