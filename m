Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020087.outbound.protection.outlook.com [52.101.69.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC51643B;
	Fri, 28 Aug 2026 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787947956; cv=fail; b=dGTc+huyTQ9P0X0kY9aZzigCA9rxNz0ukSHaKrnl1fA5xwG9iFKvPopd9ROwUZ3zfnM168A/gOVL2fLWhmPwFebSRS8AiEotQ2w4a+LuTMRpFrIpwn+rt+510rUNE9GjeaaoNbMXNVGg8OTv25maRybEACghavc/n6EwzMKpiOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787947956; c=relaxed/simple;
	bh=9mdj/1/Q/qJjT0oGTydUbTI6QusxHpSz/KhHiOGF9ms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jdPr6k+N4AWTqyfzVdOtmgGriM+2V+YVHmHiQDlEWa0BUvowT1rrV7xD52iS/TrunDsSeozDpOcIvdMN7uxIFSnteIL5+4voJRPCi4FrRN3cpvxohZqqV0PQe80SkmvYrHCfaHoF4EspUdbq0n+/xMBts8X3xxB44iUcXn5bs7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu; spf=pass smtp.mailfrom=sch.bme.hu; dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b=RQ6QWb2T; arc=fail smtp.client-ip=52.101.69.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b="RQ6QWb2T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oooQemEvEO0NeeIfkJ1UH1SU0MKuS9v/LSeKbscWt8xirw98s6RwMgeMV7jdmJEFzCpXFGpleXnfne8l41MF921yGya49gSLj70hWdMluXywkm0ngHMwWGZnSKXrA33W+2YD8pJgwd9/4zG5G42yrij/qYoElWIx3Eq7w+rSAH5R1ICrYkGFMaog6yjqWzpvIg5uwNvo97pjQ0J4+1Pfw8JMN7lrXQ2ZgGr+W08mMqxUm9DaAdkt1BLWHj4jwxiYhMEI/Zck+mrKOsUu1PNZnS5OfaBCTlRsOm4QNvh6jpJmXBDRGPGgkY9gTRB/xqceyoTak0lqCvesCghFmzf2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idx36IdUcNX7Pi7MMQsP/KpM/tI+WkO1eqtY5nZHuZw=;
 b=uQfPyIp0O099kiQifamesU3anIrE7BdB4+TcAKI4zpCsXEuTsI/G3kPvfJuB5fQuXHhW7F+Db9UBUJeg+6Wpqs9aRh7h+rbqvZv20A7GlDwuBsMHUjCi2lJd9ZuzyoqVgcjNpKo9fYEwesYxJtvKVY96UVWTZfIX0UfrqxD3I8eoXydDa/XSK7r6HiNwoyWu9NX6dUKZ0iMpdxtl00gprBYPJtlPdtpQ8TTBJAAoYvS4MakmAgcSulSSH8DDcB9tlMDjbSGZjc23V78j2Ys7oYIWDBCesbBjBR7bHQBZ7yf5qH+JylXBTIto108f/wwHMEshb76LrCLoWdijpOxhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sch.bme.hu; dmarc=pass action=none header.from=sch.bme.hu;
 dkim=pass header.d=sch.bme.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sch.bme.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idx36IdUcNX7Pi7MMQsP/KpM/tI+WkO1eqtY5nZHuZw=;
 b=RQ6QWb2ThxE+tvVmPiAFY/vA6ScnWM+nUPT/d2ku3q7i0bm33hkDSEUkqT7bfluhPfYSC+XbagCdy+fnubtIjhdtvmLw9SPbte+No02qEuSPKbR725HrZn2NWNSfQ7E1HrPBRc9QJP5/oWKUQKGjLZy0TpHLiv9twCwXnMxKYtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sch.bme.hu;
Received: from PR3PR04MB7260.eurprd04.prod.outlook.com (2603:10a6:102:8c::15)
 by DBAPR04MB7256.eurprd04.prod.outlook.com (2603:10a6:10:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 28 Aug
 2026 20:12:28 +0000
Received: from PR3PR04MB7260.eurprd04.prod.outlook.com
 ([fe80::bc60:c1f6:2fb5:8cf8]) by PR3PR04MB7260.eurprd04.prod.outlook.com
 ([fe80::bc60:c1f6:2fb5:8cf8%7]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 20:12:27 +0000
Message-ID: <d3840605-a5f5-4b27-83b4-98aef6e7fc89@sch.bme.hu>
Date: Fri, 28 Aug 2026 22:12:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: cp2615: handle allocation failure
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Triet Hoang <triet.hoang.dev@gmail.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>,
 kernel-janitors@vger.kernel.org, =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?=
 <bence98@sch.bme.hu>
References: <20260816161751.24840-1-triet.hoang.dev@gmail.com>
 <20260818111703.19604-1-triet.hoang.dev@gmail.com>
 <05df77ed-855c-4897-857e-0bc2439666d4@sch.bme.hu>
 <apHAu8HnMD14c_Au@zenone.zhora.eu>
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence98@sch.bme.hu>
In-Reply-To: <apHAu8HnMD14c_Au@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI3PEPF00004E9E.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::455) To PR3PR04MB7260.eurprd04.prod.outlook.com
 (2603:10a6:102:8c::15)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR04MB7260:EE_|DBAPR04MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: db350334-6893-4739-88cc-08df0540ae8b
X-LD-Processed: 79f0ae63-ef51-49f5-9f51-78a3346e1507,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|786006|1800799024|366016|41320700013|10070799003|4143699003|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TE0aMntYVl2YHdw1nJH+xGe7PBUQwRuuUirFGGZT76BtiwhKVz6fXfqVeyRvHpsjRcHlz1+d8+ZWfAvFRFPaBdTgtAM09opwUagG3m+bupBA1Ma57F2GLd2aPteTRO0EI9Yest27V2ouSJsSdo9hzhJWeuSNrhaG8sJprZ+rpXB/Rwc8C60v+SjWdGVQ+e2apgDF0poHhLffWBjH44EQ77VgcFA4+50Jin8MXHfxw3x0Y3TQBUjrSDkBcqVKvsjhuS7P+GNJtYEgATaLc8J3bJmPU/hHfWtjcSqyhdEdY5GPRBUiHXSM+usDtknacH+4F6PwCbF++ssGD1FvyjgaA2QWne7Tcvv6/GHDXK3xVllhnNrJJZeAQrlR8N0Hwx/01Hdqlw7oF1ktX2GBRulP8AUqbOGvosqfC3Yt9Ebj4w25bg3lftKgqzeu939Sy+zXQOA1yPYIyzH9vERJG9xd6uWQ6au4/lcs0dTPCqhxTpVm9nNDz1r/lnvYQSoJG/vDXAuKEi2KGV/eRPTcTp7NnR+M6TbdZv++MEtAAgLvE0PIigN1SJxjREB63BflotYHPS4ydpd9j8yRDLH14N0rO+r/qZO1hNrGrBvayQ+f5MiQ7t/edUW1O3srX/CpXzomgwUxh//B97BKIpGkADNPAl08xYGQn4/3N+js9J8nfYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7260.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(786006)(1800799024)(366016)(41320700013)(10070799003)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEFjbEtTM3JqV3BHVjJNSjVEZ2hteGJwTFYxUXRMbVRCbmFEWjlxd3h6V2Ez?=
 =?utf-8?B?WjJXVlNGbHdaa3VhT3dSOVRJaTUrQTB5TUJ0QXYySlkyMjNxVkhYcVpDNmVE?=
 =?utf-8?B?T1pvN2wrTkQrN3RBU1lyQVJjTEEvWUl4SFVUa1dqNXlqWElMZnR5YUNyZm10?=
 =?utf-8?B?RnF4aERCVlI3Yy9EUHdCaHhYWHppOCtMZkRad29UT1VqR29jQVRYMFFxcHVx?=
 =?utf-8?B?ejFZd2NTM2x1VzBUbkRDVkJ3QnBOSzZaTGMzV3h4Q1lNMThPODl2MEtQRkw3?=
 =?utf-8?B?dDB1VEZHWXdoVTFOZEMwRWl4MzNkY0pxSmpJcHlzL01BQkwrTFZqdXNUa1pv?=
 =?utf-8?B?MnQ2dW94WHRha3BvaTlWNFc4aitqNWxCKzBaTENLek5IYzV1S0pSemxXN3gy?=
 =?utf-8?B?VWtSOG9DT3dJZVdKYzNyVllZMEJ0Q3UzUzZZSzQ4OGFmcUl1bmxOQ0w5aVBJ?=
 =?utf-8?B?dkJYZGFnb3p6VG5TNFRiTVI5VTBic2QrT25LZU9jOGlJR3dXZDBZaCtXanRq?=
 =?utf-8?B?QVNLaDN1TTZzRVVMWW1FZ256bndZeEVCd1E5bENPUEV4K3ZHNTUwbDhaalhy?=
 =?utf-8?B?cUxsN2FuZ1pKcEdVM2pJMmcxM3IyK0NPT1phNlk1KzQvT2R5UkhHT1VVSExx?=
 =?utf-8?B?VUdVYVpsMGsrY1dlM0dCWEVJRnFVY3Z3TGJINU50RHd6SklpSnlTTDkxRUlP?=
 =?utf-8?B?aDBkUkdaYVE2bFNmUnBEczc2VXdkQlR1ZGxKNHI1cnV1YkhsN0ZjdEVVVkhC?=
 =?utf-8?B?ZFZoMGhIdkVVc3p4VzNrQnVJbXhKaXdoWDVrWVB0THVxRFFjQ1ArWXBrVjJw?=
 =?utf-8?B?M1VjbnY3MytEUHVKTXVDQUo4MTlDTlh0clZMWHpZL1JMNHowaHBnbi9XUGRU?=
 =?utf-8?B?TURmUGg3dXlENTJTS0E5eENTcjFrc2gwWHlBOXMxVDJTUjVwaHZQT2hhQUxl?=
 =?utf-8?B?Rzh3bkt2c1BiWnh4d1ozRTAwQ2NRY1NiUHExOUQ1eE5UcGFkdzJkWisvRnJW?=
 =?utf-8?B?YUEvb21TV1NReUhIaEdjb1AzWmRzYjZSVmxmRTUrdFEwL2tZZW5kRHE2OUta?=
 =?utf-8?B?aEdoSGZ2VVIrcS9uWlk5VS9RbVFMMkNHK1ROUWtmK1Axa3pPN1orZmdubkU1?=
 =?utf-8?B?T1oza1BCckp5YW1EeDZPWk4yZ2E5cjhka2lHckt4UGZOQlFITVBsZHFFbUpm?=
 =?utf-8?B?blFYMXRRc3poc1FvNXdwR09ZZ0J1aFM4Qm8rNFJ4T054ckNmb3NEdm1CdXky?=
 =?utf-8?B?bkZISEhqQVFOa1Q2K0NvK25SaWkwbXFERThvbW9BSVZUQ0Mvb0tER0pIZlFM?=
 =?utf-8?B?a2VJWU5hMHI2T3VLMkpDL1Y2N2NTaFRiT3EzeDRkcnZuZFJDWXpmKzFuV1Bp?=
 =?utf-8?B?RjcwbFJsYzlaUVFubG56VlZTT3E4MTQzcjNlVDE1czk4TlJCZytWYXhmMHBz?=
 =?utf-8?B?RjBEMTI2NVU5dm9XazVmZG1BdmdHSlhocXd6WkJIczNhSFEyaDZjcTRmRDNn?=
 =?utf-8?B?eU1mUUtOdGdKdlBKQXd5R2lKamlMMEdWZVhtdHF5b2pldVJBZWQyeE1jVktK?=
 =?utf-8?B?ejNyMS90bkxzUVZjcG9EcnZJeUF6ZEd1WlRiMmprMjA4a01UU3BjMlYzbkZu?=
 =?utf-8?B?UXBpTk5WRU1NYlNhdlR6dW9ScE1qT3BmYUxkNnBvcytoR20xck9zdVF6bVBF?=
 =?utf-8?B?YnhtYWhzT2JCN2ZXaWlLRDNlRTBVQjcwSERKWjlaTk1TaWtNbjgrcjBURG54?=
 =?utf-8?B?TkYwbncyOVkvSWUvSFBlOHM5SWYvMTNsOXAzMTB0Qzc0RnQ5bG91TU5Dd3Fp?=
 =?utf-8?B?VVJhRGIxWmFvS29JRjdKOTRMa0tNdXdXWXA3UDdteUlHU3VmWFIzYUZKVmdC?=
 =?utf-8?B?SmNSQkwyZFE1cTJFUXc4ZXNXa0ZlLzU1VnQ1WXBPU0U5TlpuS0hEYUJWSzRP?=
 =?utf-8?B?V3JSUFZWZ1BuSTF4NlhyR1QrcVNwdTlYcVgrR1g3cXF2cXNodFV2VU55Ykts?=
 =?utf-8?B?Y0EwcUJkR2VqOXJ2dmtjZGpwSzY0MTlXN0R5TEJlUVZIWEhoK2xjSllIMzd0?=
 =?utf-8?B?M0txRTc3VzEzTVBmUUVjUmZnZG4yQ2c1Wi9pUWlXVnNBVEs2dWwzRUp0WFBB?=
 =?utf-8?B?MWQzUG9UaFJFQi9IVFJQOGpLQ09xcEEzczltMkw5d1FyOXZtblhKTmFEQjF4?=
 =?utf-8?B?SGErWDFlRW1WSlF2UUNOYkdpcVhLUUZNM2l6NmQ4RGZ5cjJvZmpiOEgxWlRT?=
 =?utf-8?B?dXZ4aXVUVnFTSzVPbW4veUtoTHlNTWl6WlhIZW5jWmptbzVzQzRxdXFkeXpx?=
 =?utf-8?B?N20vSXlzSTlLYytsTjV5SGRwdEs4QVZsVHFzNmZCK0xKS3hLUmN6TzBmUm02?=
 =?utf-8?Q?ZcmhRIjZ51nWVH+fv2ZQ5Zusi7wBrSF9c9s3R67iC8KLr?=
X-MS-Exchange-AntiSpam-MessageData-1: qKiYLsMZAW6eQQ==
X-OriginatorOrg: sch.bme.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: db350334-6893-4739-88cc-08df0540ae8b
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7260.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 20:12:27.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 79f0ae63-ef51-49f5-9f51-78a3346e1507
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hi1CcBu48d0aRDr1K5biUiyj3BZMV4NgtDELgw8tUzMrE8Y4k+Ll5yjsjfyxxjsSAvrQZB6nGRHG/TPghYHeAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7256

Hi,

On 8/28/26 19:09, Andi Shyti wrote:
> On Fri, Aug 28, 2026 at 02:08:19PM +0200, Bence Csókás wrote:
>> On 8/19/26 08:28, Markus Elfring wrote:
>>> * How do you think about to increase the application of scope-based
>> resource management?
>>
>> I second this, this old code could use some RAII modernization.
> 
> is there a managed version for kzalloc_obj()?
Well I'm thinking, since msg's lifetime is only within the functions, it 
can be attributed with `__free(kfree)`.

Anyways, in the curent state of this patch, I'm afraid I must NAK it.

Bence
