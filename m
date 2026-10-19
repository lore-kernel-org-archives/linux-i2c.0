Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792428199;
	b=mHbKyOAhklSeUCbW0EDYBpdzW65Epf91alyoCQdqg1P76FtqttACS8qGKmuyBHYQIcuV
	 dk/ct7W8xbd/clIErY8cI3qs99GQDJ7Uz6PZbHe3m3s/1rd8v05Hl7+eKOLfULz0ELq9U
	 f0Zf32iDX5VwYcFS9keZX7xKE42LKAdYVQcn4HJoyjSNgoYOXhTSKBCIh1N3pPWK8v0WZ
	 IbA8FoMlIT9HzBhtsy6275wPm8O6HDPgQn4HXe4w0LDMIQRsYLXsPUbaQSN+N8Y6qeu3z
	 TGXyWi/yB2CD6IbYCYrWt9NBy6qA1BOlzyM6/dKq8gKxKps74bQM9WBKu2X6jW0amqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428199;
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
	bh=LPxlTJkVfWLbEQsAfP+U7TB3bjpYLsaU0yKIo8xqhH4=;
	b=TN/3FhDSDob8pgpxHPZF/pvLNGuIttRB/sos0pp64gdrMCMqjHef2gYUr3bseWxFlqST
	 2qS0QIg0Lk1aYzPcu6Pis7wfJraf/eHWGDBbIItFm7lEy+tdWWeJEMJ2tcSwP8QYK0epU
	 VO5bwE8xp0KkCivq0WBzQfSQQ+WjokekNpQq6R8xhP5E9PhxIlpSWLNvHvskHB0ZuZkAe
	 k1wKYdZcWgszmtGSInVTn0JAK/ATO2hfrt8na4elxXnYYjyKPwlCA9mS98vJBZl5FtFNW
	 GZep7jwDePF+8stqFQrwb9BgeI9fmuG84LMB3hzMpiCD4sGelyodOCAMuQ4UOB8kdqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wj3OBDLI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.41
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A515606A31D;
	Mon, 19 Oct 2026 16:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A515606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wj3OBDLI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQrkl1AovHLJK3ffV52IwBhqlsz3gfGO+bCTROoMSrgqghY1gducCV2Y4aaISmabWuGbwpsKi7qtM4WaCED8v4EfGvw+VXzEQfYBepRMWYaOV5439E8DGit0Xr8C3va4E/qzA7kf28ZQtuW50msQpBH1YHozXgkCh39MI7lgXOBKxC8qxXsOq6Dt/iOufa2EjYeIFaD85viA/jX4652cyofC6ZAmzvebD4Q8LwvG+MKogj25QFcbISrRAa6l8bWaetmfU5lsh0MfzaOZR6EChi8ln1Fg2xxNgR1ufteIO7p04LrrTkEJk+DRl5bVInm9MJJlyyHwGfdDnlRW1hc8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPxlTJkVfWLbEQsAfP+U7TB3bjpYLsaU0yKIo8xqhH4=;
 b=UN3JkyDaGHGPRKIbALVerti/q1XSt4aIzjKu4cxzlOpQsqX/H1y0quYNaLJETkEyBFr/uDERPoqC3aP+qABnmF+vRHeQ0tNnbjTDVTWYt+doroAY/GyDIFeR3F+rv3jA1AHCeGzimBj/odbHudkpMCyFjnpAeJYJA2S0KjEJiXiHAukR0mhcSyORAzHrDx2SbgF0ASeaurON2vasIQejQTf4s+kQ2wb74XUTWzUsO76csQQidpOo2N+clVwzIWcArveGuNeXnr6mc8RiOZAZfqsJ6cKc9HglpPhxJxEKpieFs2p5bbylYlr37IlCTx5LednwYQP8MdZNgnv2EHiRKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPxlTJkVfWLbEQsAfP+U7TB3bjpYLsaU0yKIo8xqhH4=;
 b=Wj3OBDLI/wDco46Sw9g3ZsYFrR+Ft8Cshdo31VynNabVVNwMIpdU0rpawvQiotRiMfmlBaO5GILhuuTqgW81sFURYs2Qe8fI2r63PdQVARXkr4/e7j+/1HF7GszICmYFd3sa3Y4/fRLXdKPVWcdZFw1AcvDlfkZO7XpbqvK3lbY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:43:04 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:43:02 +0000
Message-ID: <11a5b3ee-df45-44ff-b882-557c170ab44a@amd.com>
Date: Mon, 19 Oct 2026 22:12:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: cadence: fix clk disable/unprepare underflow warning
 on remove
To: Cong Nguyen <congnt264@gmail.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260918164500.2726242-1-congnt264@gmail.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260918164500.2726242-1-congnt264@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0263.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::11) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
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
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbbe1f7-d0d3-4424-9c29-08df2e000aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|22082099003|260925021911599003|260925021311599003|260925022911599003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JF6UJHBMRHV2cbWsXkOS5xd2hlfCJCpBqo4s4yppK2Hhd48MWUhskhSGFcSE/JfyjZlAL5Wiy0Qd66/BB7j5w46Wp9GseF0mh6wD0P1CsdIi7v5mKSObzYHeEA+v3+7QZ0nF4UQUWMRfKbBNjzmxdjiMycv2Ng7BcoS+gq11bjHBydZrA5vrUNJlTkgmwC1jHByI0FNd3feC+EUCTMLgP0VppK622JnT5sC6FA3n/CTIOgtVrE5h3X7RE8nu8wkVT6aSwkGPSpcMz7XPyV3VOoabmLqBNKk5jyinad+Xnd9dn67Tf0t9oMpCfo44Exi5pU3UziRDdJ12EXXtap8Qnd85/NHc7LfhhXgAybkmEKxd2c0if/IBWOX5/MuC5xWN49PQ9XFUQqnnmYC6kt8JrGbvxDZGyE6wzBAJOssi5tRruanH56Lb/ByjhZRY2fUA/drVM+z9FWEXSrkatUzt5VkA42cl/l7hSGR7oyDVlHkp+utzfZjUS1sZHybs74SeMvaIwIquRAcfaKspK4jGqCSUFIjY892S8PEy4vJ8V5ehG2USh6V/kIwwgxSCKdPyv2Z/cyFa3PVYcGdOuAShMa0gpUGVB0rPETiHUb+MjSnGu0bSsblWLgVCDXilPmvxjMIgd6+CP83RJYWH/wMl1wyrgqDS/GnMl57LnbdYywU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(260925021911599003)(260925021311599003)(260925022911599003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXVJa01ua0VIbFdFZFNFTC8zTUNVZXloTVJrVlNiVWV3MnRZVk0zNmg2clE2?=
 =?utf-8?B?bmo1TkVXcWtQN0pSaFl1VVhZc2Vyam9OSXY3anBVK0tVUHY0Ty8yeW42c2c3?=
 =?utf-8?B?cEVZZmxJcFNoYnRocnYyUjQ5NkFyVWxKcHJicUJqZDk4U1NpV1lUY3duTnZr?=
 =?utf-8?B?d1VoV1cyRUZ5TEtwSzlmK21tWDcwR0JIVm9nSjF1L0dkditnNDdzZVhzdWI4?=
 =?utf-8?B?UytFN3J2MmNESDlTMFJQQy9wQ21naWlsNThQRUtMU1owZ3l5eGJIaStpMng0?=
 =?utf-8?B?ZWs5RWhxVjdxUENOb1ZiMTEraHIwTyt4VG5QU0FaSEEyaTR2NGJDZDNjUTRQ?=
 =?utf-8?B?bnl6T0N4QVdmRVBqVjRBYW00VHIzWEtVdEY2MFNmNzc1UkpxZVBIN0ZzRm1h?=
 =?utf-8?B?djVoRXpxVnNPYzJGam45Y1A3aXZSQm9DdmhNWW5BKzl5b1ViQmEyTDVsZFVq?=
 =?utf-8?B?RUVtajdRcDJMMmRzcHhueWd5S0ZpbTdXVUp5dFJ6WWJEc0FJa09FL1E5Y0hx?=
 =?utf-8?B?eWp0ekhmcW50cE1nM2J1WjA1akp2MUxQSHBwZ0N1VS8zMUZ2cGYrZU9xVjNY?=
 =?utf-8?B?NmViSGpZM2l1c05VdGpid0t0VnBNUmd1VHRPcWFMQXdxd1JYa2RzTHZCK0h4?=
 =?utf-8?B?VGpFQkpYeHZ6TnRxZUE5S293djdYbk5mb3ZNbXd2Rlgvc0dhSW1WdDRwWHBq?=
 =?utf-8?B?bTFRdDN0WFRtdHlTNHBiakRhZk9IQlhWZnYzbExVcWN4N2gvT21haGpvalV3?=
 =?utf-8?B?Tno5eXdUb25UaEJBNVFJNlRrVy92SUZ2UnRkQWNiNlB2bWlSNW8yRndwTGxJ?=
 =?utf-8?B?eFluVWFCUFFjZTFuazV0MG5DK3B3QUEzZTJjSkhOdmozcWJCMEJUTmt6ZWtj?=
 =?utf-8?B?MlRYd2hmcUJKd0hjc2pBbW4vRFRPcFBBYVVTMDA3azhDaEl0M2hvcGFSY1N3?=
 =?utf-8?B?L25GOW9iYzMzdk1heHJaQmsyYkRjSXhYbHNVcXJyNi9RZUcvbzJueHBHMU1z?=
 =?utf-8?B?eEYxbjJCYjg0eFlLUWpHVldpOUs3b000dmxOZW5vYi9ZS0o4QmtsYjNRWUlH?=
 =?utf-8?B?Q01zNDY4TTh5Wkp3c3UvcU8xb0VkSjZXR0xwVjJiZzE1aXJmbEJkcmhhenk0?=
 =?utf-8?B?Si9PekVVaVFjanRpZEM3NDFlc1VNUmRkU1RLTm1VOEVtUStZSDFXbmYxSTlU?=
 =?utf-8?B?aGcwMmJyN1hWUm9RMkdMQTZFb1VnR0lJVU9SeWU5dytYdzYvb3V3aDk3Ymhy?=
 =?utf-8?B?QkRyendBU0k4TEdXZnZDL0VvUUtUZG5uRk5tNlJ4OTdZYUJSandaby9ocFBq?=
 =?utf-8?B?Y3BadTlpRHNrdzY1c0xKMExWa2VwODd0YlNSVHo0c1Z5dkF3UWh1RnJQUGZS?=
 =?utf-8?B?NHJCWXlJN3pWbjdmT3ExdzRqWDhRNE5zU2hucVIxL0ZMK2tlS1o5MXlQVnkv?=
 =?utf-8?B?L09talEwTE44SmlJWTZtNjU1SDBSR1BiYy9WaTQyRDh6TlBxR3Mva1dnelVq?=
 =?utf-8?B?d1NaZnQwQXR3dWd0MXFKUm5BZThoSnBoa1VKZWFKWEhPT2FXNzc5cDZWOTJY?=
 =?utf-8?B?V0hXYktKOVUxaHJ5RHRhc3VFOWo1SERGRy9nMkxrMG0zUFdQSDRjRjM1RGxV?=
 =?utf-8?B?ZmJscmFLYXJvTkcvQ0dmZjBnUUlOK2kwdWZVQ1Z0TC9FMURrM2N0aGxXcGZB?=
 =?utf-8?B?aG81YnJkUmo0ZnhwNGswZlJpY0l0M0NhcWJoRVgvOE04a3JXUzk4UlFhWEJ4?=
 =?utf-8?B?clNJRHJYN2xaUzd3OEVWQkZ6OElyZ200aDYyWHAyWGlwVy81WGxSdXIwRjRY?=
 =?utf-8?B?WVVBdTB1M0RBRG9TV0RHNThnZFRHZHM4ZkJXemo4SFJRd3pIUWZ5c0h4NDlx?=
 =?utf-8?B?Sk1kdFYzME04MVBBc1VFbFhRNjk5T0ZzMThURzk4MXhoMEhSNjh6VndET3F3?=
 =?utf-8?B?M2t1dVNXNHdwVzIzUW95Z2tuK2FVWjU0ajFnNnJObWNOOTJOWCtoN2FVZkNh?=
 =?utf-8?B?c09FVFl4aEFBdjNOT2kyS0k1TG1UOHZ0TlA5WlBKNU8wTnp3eGFjaEl4L1lX?=
 =?utf-8?B?eTZjc1Jra1Y4MCtZcGFIZytBdkplbFR0RFREYy9lWXBaMXNXcXpPR1JWSmdS?=
 =?utf-8?B?dCtOLytOeFhYM1FETEU3YmJOeHBHZHpGMy9Walc1ME5OTkxQOElSMGZCRUsz?=
 =?utf-8?B?c1JNMFhpaVArcVRxaktnTzR1TkxNNThqTVduWEN3SHlQWndwSEFFMXNVWWhm?=
 =?utf-8?B?c3EyaFZIYjJYS0ZnTnpjTHdyRHpPTS9WZktKeHkvS2JYRkI4ZndTRGVOZmFS?=
 =?utf-8?Q?x3e3mGzNwDO3LF/EnY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbbe1f7-d0d3-4424-9c29-08df2e000aa4
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:43:02.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwgNdEDwK4mw1j+wwSawJUrQfyLJ53web7yfx5DKRmR4g2tfOgv4+FMh4AUErL7q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

On 9/18/2026 10:15 PM, Cong Nguyen wrote:
> cdns_i2c_probe() enables id->clk via devm_clk_get_enabled(), which
> auto-disables/unprepares it on unbind. Runtime PM autosuspend
> separately enables/disables the same clock as the device idles and
> wakes. remove() never forces the device back active first -- if it's
> runtime-suspended at removal (routine after any idle period, not a
> rare race), the devm cleanup then disables an already-disabled clock,
> hitting the "already disabled"/"already unprepared" WARN().
> 
> i2c-imx.c has the identical shape and already gets this right:
> pm_runtime_get_sync() first, balanced with pm_runtime_put_noidle()
> before the final disable. Apply the same fix here.
> 
> Fixes: 3d36dd1161ca ("i2c: cadence: Simplify using devm_clk_get_enabled()")
> Assisted-by: LLM
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> ---
>   drivers/i2c/busses/i2c-cadence.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index da8770182a18..d0919593456b 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -1625,14 +1625,21 @@ static int cdns_i2c_probe(struct platform_device *pdev)
>   static void cdns_i2c_remove(struct platform_device *pdev)
>   {
>   	struct cdns_i2c *id = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(&pdev->dev);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "Failed to resume device (%pe)\n", ERR_PTR(ret));

Nit - With this error handling introduced we also need to sync remove() 
documentation.

  * Return: 0 always


With that fixed.
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Thanks!

>   
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
>   	pm_runtime_dont_use_autosuspend(&pdev->dev);
>   
>   	i2c_del_adapter(&id->adap);
>   	clk_notifier_unregister(id->clk, &id->clk_rate_change_nb);
>   	reset_control_assert(id->reset);
> +
> +	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
>   }
>   
>   /**

