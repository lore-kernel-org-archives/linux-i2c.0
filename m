Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794808067;
	b=HrvCRZX4dbD+Wnf9qR4eW4T1+vqgw7OFMXkHiTuYz6747WNZRvZLbhVCD1Xbq2e835V/
	 VJA+uRP4tk5jot2EMLYZ1X7Zx8Dx5b2Jq9N9rQs6qt9ykgYo57nlpDCpSrIx4rUOxqO//
	 TZV0OLLeT4zKGWr5nMJRQQtTdXoNxOB775D3L4c8DNfAsULmFomSFLC/vp2DCssg1I+cM
	 ewQprnXNqv9sjRA1MLaMxSudWX3pAb1JdS4IOymXxVfYyp9FThSsE6lqH8sJO9tLmwg0G
	 LkPSNck0/bWfdKw9CxcoBZxzSP2NI48xj0OfTzcqn7AOTr+udZOha78OqhLxuGv1O1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808067;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yadWf5uICM2fPhh416NdGS8AfSta/JkqUOvILRDwcw0=;
	b=RUN+fb3SHLTNJaOrUKSvzeW4ZrGrBDOnOSHcPuXWie1XgOvRZKy/f6+FfNGjQU9JI5a7
	 BIijny/6OsOhJW3ldMFlMqhe5pCWJGi9CarL6pvwCCjjxaO6AEN7j+efTlMjKvX0H2bJS
	 0STt7lalLBlL/1Y0C3gOOTs8/Gk1/o1MwhFFtvGB05fe5veD7nCpFxFYtKzH7sZ49XVmP
	 NZuikXuIEFWZwX0LK2laeiMl+QyYQ6QPE5X23Kj3JgUeNKknk66Cj52oHec8joz6clLQF
	 +cYXklH+G3LmLSg073nZ7UZ52rOplyKDwRYKE6/IVvP2CjMN+aKNUV56PEFWd8C4JpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2wnCQdbI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.62
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF19606A31C;
	Mon, 16 Nov 2026 05:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF19606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2wnCQdbI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpP0SeFspdmT/Y7og0862wH2wrtJSv42TKugnRUM3HUSkvx515mcTIo6Rbljk/h/ZPfnN/Ryit2dMI76+mvSLe7nrVCmAgBQ/eo4pYIQmdP9dBK2BjCj319ZUKmXicLVlmM9F36o24clTvFhS8u5SGdTCStxBtmNDfnoXweDJBD5shBcGAuwhCVCh7qNYzXo6SFYdXV51hdO/FZZvGWVZtjH91jSZb0lajt73R05h2s0zTAYEfnPWQhnJpPs+wqjpTyb6JWo8STIpC+uJJ2I+435SrX2dEIORXoLJDLmp7177WhqLMlLj/WpdaOZ0j3JPnYoeE5M3ItYPrDBwBE4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yadWf5uICM2fPhh416NdGS8AfSta/JkqUOvILRDwcw0=;
 b=L9Yax22HQ+6zdL6O1b2jURNycljXl4Sgo894EHA5kGeRd9DONOcVpHcKq8Z1992TvC6K69W0RuEHUYfddPb2pplQe7bKAd8s1zB0sy06diOq3808BzwMuYtIvWKAL9XIUoQ11iHzg88JvMN7TJbAPWjRYHxQdAddjnU4AmVW/9+LTNzcLX1QE8t9bL6fDUU8V66OvbGcHlDuTEQJDhhbnJjb42ecv5EWKdZFAvf991L0qAOL/3XE0tyRCWKDUteMwHic4bRKa1qsqmB6fAn7brj39csixeuuKCo0ukze5050NFLA2lVxye7l+d+rYKBIiQsQXAIiHxpd6fdeox0aUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yadWf5uICM2fPhh416NdGS8AfSta/JkqUOvILRDwcw0=;
 b=2wnCQdbIPaSHKIAcLaax6Yi93n+moAg5jG01+e7KHtsMaIOMdWerp5F4gxeInFcBkQiptM6ktnQTZPO+tMZYETPWI1N8PVcdxb4k/+Rm7YZqAFCXUI5gBhDGh+BGVtB2+7XVWMdi73pcOh19KmrKKEhlUce1WOV6PmaD0wzeqko=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Mon, 16 Nov 2026 05:44:40 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::9109:fa1f:23b:a10e]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::9109:fa1f:23b:a10e%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 05:44:40 +0000
Message-ID: <60062cf9-438e-4e03-8ebb-46cf0d327421@amd.com>
Date: Mon, 16 Nov 2026 11:14:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: xiic: Rework dynamic-mode RX FIFO drain in
 xiic_read_rx
To: linux-i2c@vger.kernel.org
Cc: michal.simek@amd.com, andi.shyti@kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
References: <20260928073425.2597782-1-vasanthalikitha.tandra@amd.com>
Content-Language: en-US
From: "Tandra, Vasantha Likitha" <VasanthaLikitha.Tandra@amd.com>
In-Reply-To: <20260928073425.2597782-1-vasanthalikitha.tandra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0026.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::9) To DM4PR12MB7765.namprd12.prod.outlook.com
 (2603:10b6:8:113::5)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7765:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: c64f1d13-76e2-450b-b29d-08df43a4b51b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009221727099003|261009221227099003|261009220027099003|261009223027099003|261009223327099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XxYtNx5V2R+1aK05BsPH14WFgY6TQY7Iz3rNgV/1N4/UU3JJb5JkU1IsUVrv+4NA/bNszqq2MVhfhlpSGOk6GIenmAWasbgKVwAGU2wZQgtKqfaKtxLFdc9TKVniTqgLLLzf0e4fF6U9raFBIjB/wZT9JD5s5ml/vgzRwZgSs47NoeyzNjPiFOj+rEgUakAGCBVUwSlZC2ooJfURzu3NBSoUJUKjrUDttgfCVmkOs53VRyitLka0a8VAHBkQHNsGMK3m7DscTylkLWjFpm9b7tNdMZWPhlS6/kbeo/6h49I9ROlrzZX3fkYDFuX7hQGtGujyyPchPMI2SpMIYAo7N64OfU41WaVw4zmvLfi6a7REOGE3wjTpCZ/Lazs1jZ62Hi7jO9scXzsAqRD0FE82reLp7/xcfrNJ+/RpyyfDGGv329/Ha/au+6A/wLU8YAAQ8eu7hjbVcGPQrXcZWVAwjkwWCeFNGKy+QkMCHHFvk4e4DMR0GdzEWBN3mHVQFWCcv5A/3UxHQAU49CDmxEpZWwfgcs/VjCyhZ+DiGA0nMJZVE1Lsc5KVGy5MiQI6MAx76u4N7GmZSc1nt99TcTIVVvGJSfiNv08zwv35uRQcTDv0WkQ3GsrZGUWdh1MWjoL+2HQF5S/3JRbhsqL/sLsfmXGBe43vHTkhG6BFN6aEpdo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009223327099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW1vUUxIbnNkL2tNUEhNRFZOMDBNbmNhQ2d5SUZua0pBRGRjUElNaDU1QnlT?=
 =?utf-8?B?RGVka2lnZTU5eHQwaXYwMWhPVm9yWUpvd3ZJZVhCVWVoZU9rU1hyaGF6d2hv?=
 =?utf-8?B?WlJVeE5lR2VISkIwR2FyVG9TZk92amZ6RVgwMFhBSTVIbjhOM3dRT2UyR2ta?=
 =?utf-8?B?ZXJMcGJodnZkRnZDMVNWWHF5WUpWdk1xSDFHdS9XMU1YSDhMQUVwU0R0NHE3?=
 =?utf-8?B?ZzkrQjhCN2ZLOVMvaFpsV0U2MWhOclh3RUxHcDBqNnd6Mi9VTlFMbXFRZjQ2?=
 =?utf-8?B?SC9PQ0lQTk1Od0FwcXJVeVlsNnI4aUhFVjZHQnNyRzBoekk0cTVlM2ZWTFdK?=
 =?utf-8?B?WlNOUWliM3k5VEFOdlNCa3RwSWYwUWphakJRUFlDZ3dObEF4dTJ0ditkNzla?=
 =?utf-8?B?cUExdkhRblgraEVnZDIxbFBzdFJnVUVJbmZoeHdrM3BvVXZNSlo1bk9sUWI5?=
 =?utf-8?B?bGtqdElUQkJhYTM4SzlvZThWc1Y1VlBjZHhqTFNybVU0TDIrYnBXTTN1cWVu?=
 =?utf-8?B?Q015cVFaZlBCN25zaFNkMEJFN1hOWVZtRGpySFluWFI1dkZQV2dqdVdvTkhJ?=
 =?utf-8?B?UmE4VEx6WXhZZm9PYUNyZXhTcElBT1NvVDhUU1FNUFBmY1hOWUhjandHSHFW?=
 =?utf-8?B?a0xtVXhwc0hnS1o0Zyt6THFKQjV2WjRhQm5IZzkvNm5wbUFYMlNzSHJkbXRl?=
 =?utf-8?B?TU5vRU1Pc3JmUmZhcDd4WXQ4MjZ2UVRQSWJBanFJZVkvU1U5MEtuSXdmUXJM?=
 =?utf-8?B?YzMvQVUxY1RhYy93dGVRcEEzU0xQYk9mK08xN21aZ29md0Y3T0VqeXlBeDRh?=
 =?utf-8?B?OVpCd05Zb0t0eEphakRLS2lEVnFNdWZ0MFY5K2NyRTMyRkRNdGxyd2RTY2Qy?=
 =?utf-8?B?dXRvTE13OG13aXczempEUjZyMmxNVWM5THYzQlY2eUpxcEpJd0J5Rm1URkQ5?=
 =?utf-8?B?cGQ0VlJrTVl1ZjlJMTFDVGF3OUNCYmRwV0c3ak50RVBMaDljYUY0S3lONzJl?=
 =?utf-8?B?WkRxQm1MSEV1eUJyemt6MlJ5YkdhNzJBT2hhL0cxTnVuUHRpMldBU3RFQnNK?=
 =?utf-8?B?NkQvdG1xbTBocnM3ekU1M3d1c3hCL2I2R0hmcnJOUnlGR243SGU4WlphWjZ5?=
 =?utf-8?B?T2xNQTJiYXc0MXFVUnZjV09LSzBXNUF0amJWTzM5KzJiZllBR1g2ak0yTTly?=
 =?utf-8?B?ZmVTMm1LbWM3THBNTmhKYlNMUUhIdTJKQlBtSGhXeGtha0VkRnJ6WGZmNEN2?=
 =?utf-8?B?UEFYb2FKU1RtU2dvR0FjOHh3VUoxNGI1TjQzN0s4QkFtOGxxY016ZzAxQ0x1?=
 =?utf-8?B?VFFaK0toWXVZR2kzWk9kcFJUMXBscXRtVE1HdUlhMDcyYWhYajE4VEhNZUx1?=
 =?utf-8?B?bExQUGkyODdBV2JweFhrc0dPWDJjSkV1STQwNUxTd2hha1NZUjlMa1lmaHdx?=
 =?utf-8?B?OWZKdFNTVkkxbWcwQWVRWmdwcGROQnE5NEc3VnpxWU1zQzdZaHpRZzd1YTZL?=
 =?utf-8?B?N2s5ZmxMWGFJY0J1MFJDbnEweEZiMzRxUzkxVE50NURHVVBuNWtEOElLdEtt?=
 =?utf-8?B?R2x5bysyTEVVdElqdDArQytTVjhIL1A5TjB0UFVIZUVLT2ZBc2p4ZjRON20w?=
 =?utf-8?B?dmdhdy9Nd1RZMTZaV2ZzN1UwbnZpMFRyNlYySmdMNkt0c1Q0YTVVSlQwdERR?=
 =?utf-8?B?T2lHb0l5NEtKRXpSdCsrYW43bDEyWU1YQ21iaklBSy9iUXRqQW5YakN5eXlk?=
 =?utf-8?B?cTgxV2xTb25YZjhRK0VkaVV2SzZwOXVYN2VNSzhUN3hqRTZUeDJmTmhROUpL?=
 =?utf-8?B?R0lYZWlNMnlWY3ROcW9tcFVHRk5zSWtGRi9IR2hxd1NwMWZvYjJqMnBsMG1K?=
 =?utf-8?B?YWJyc0ZMR25JczNud2Qxbk82MWRPbVB1aThRS0djV3R3TjZ0TmVUc2dWeXVN?=
 =?utf-8?B?NlUrd0dmZDRlMUpPb3VSUk04cE1HU0x3QkU4Q0UvbnVMY1F3VUxRMjBkMnF3?=
 =?utf-8?B?WWV5aHJuYmpWWG0xMWxJOHc1L2M5NHUxM1Nva0dEdGJWV3hUZ1l4eUg3cnN3?=
 =?utf-8?B?eldwUk4zUHVzYVpWdkVBdVFSekFXNlJIR0hyTmV0aE85WFQ1bVhKSkszUkNi?=
 =?utf-8?B?dVVhNk1VMTBpSTF5WkxoY3FkS2JEdHMwZFBxTE9hWXg2NUdCT0JvenF4cklI?=
 =?utf-8?B?UEVCcXFDOHF0clZaWTNLaVk3dkZISXRPWXBtck85a1RCVHZWRHoxbFZRZUc4?=
 =?utf-8?B?dHNUTHJQa2Zpa29JVUIvSm9uSU1uL0hReVl5VlYyL3k0eXc2T0QzRXZ5dS91?=
 =?utf-8?Q?57p5sf68MqxALh7Pt7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64f1d13-76e2-450b-b29d-08df43a4b51b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:44:40.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8kCnq41M+Sb+Kht+CFf0F80AatxGDJEHdxSkGYcvmr1RquDgMuPES5Dr622gVsS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

Hi Andi,

Could you please review the patch?

Thanks,
Vasantha Likitha

On 9/28/2026 1:04 PM, Vasantha Likitha T wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> 
> Programming the RFD (RX FIFO depth) threshold at runtime causes a
> spurious SCL clock pulse which results in the STOP condition being
> missed.
> 
> Fix this by programming RFD once, when the receive transfer starts, and
> handling the final-byte sequencing in software: select how many bytes to
> drain from the RX FIFO on each RX_FULL interrupt instead of
> reprogramming RFD after every read.
> 
> RX_FULL is then always raised at the same threshold. When fewer bytes
> remain to be received after the current FIFO contents are accounted for,
> drain only that remaining count and retain the other bytes in the FIFO.
> The retained bytes together with the bytes still arriving restore the
> FIFO occupancy to the fixed threshold. Otherwise, drain the FIFO
> completely.
> 
> Fixes: e1d5b6598cdc ("i2c: Add support for Xilinx XPS IIC Bus Interface")
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Co-developed-by: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
> Signed-off-by: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
> ---
> Changes in v2:
> - Updated commit message and Fixes tag
> - Removed dead code
> - Reused cached rx_space
> - Improved comment wording
> ---
>   drivers/i2c/busses/i2c-xiic.c | 39 ++++++++++++++++++++++-------------
>   1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index 3e7735e1dae0..474540d4d611 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -578,7 +578,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
>   static void xiic_read_rx(struct xiic_i2c *i2c)
>   {
>   	u8 bytes_in_fifo, cr = 0, bytes_to_read = 0;
> -	u32 bytes_rem = 0;
> +	u32 bytes_rem;
> +	u32 rx_space;
>   	int i;
>   
>   	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET) + 1;
> @@ -590,13 +591,32 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
>   			xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
>   			xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
>   
> -	if (bytes_in_fifo > xiic_rx_space(i2c))
> -		bytes_in_fifo = xiic_rx_space(i2c);
> +	rx_space = xiic_rx_space(i2c);
> +
> +	/* Do not read more bytes than are still expected for this message */
> +	if (bytes_in_fifo > rx_space)
> +		bytes_in_fifo = rx_space;
>   
>   	bytes_to_read = bytes_in_fifo;
>   
> -	if (!i2c->dynamic) {
> -		bytes_rem = xiic_rx_space(i2c) - bytes_in_fifo;
> +	if (i2c->dynamic) {
> +		/*
> +		 * RFD is set by xiic_start_recv() and must not be changed during
> +		 * a transfer, because reprogramming it may generate a spurious
> +		 * SCL pulse and cause the STOP condition to be missed.
> +		 */
> +		bytes_rem = rx_space - bytes_in_fifo;
> +
> +		/*
> +		 * If fewer bytes remain to arrive than are currently in the FIFO,
> +		 * drain only that remaining count. The retained FIFO bytes together
> +		 * with the bytes still arriving restore the FIFO occupancy to the
> +		 * fixed threshold. Otherwise, drain the FIFO completely.
> +		 */
> +		if (bytes_rem && bytes_rem < bytes_in_fifo)
> +			bytes_to_read = bytes_rem;
> +	} else {
> +		bytes_rem = rx_space - bytes_in_fifo;
>   
>   		/* Set msg length if smbus_block_read */
>   		if (i2c->rx_msg->flags & I2C_M_RECV_LEN) {
> @@ -636,15 +656,6 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
>   		i2c->rx_msg->buf[i2c->rx_pos++] =
>   			xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
>   	}
> -
> -	if (i2c->dynamic) {
> -		u8 bytes;
> -
> -		/* Receive remaining bytes if less than fifo depth */
> -		bytes = min_t(u8, xiic_rx_space(i2c), IIC_RX_FIFO_DEPTH);
> -		bytes--;
> -		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, bytes);
> -	}
>   }
>   
>   static bool xiic_error_check(struct xiic_i2c *i2c)

