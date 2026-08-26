Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770F334688;
	Wed, 26 Aug 2026 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743428; cv=fail; b=GPpfqHtWCRwD92VtBh+8nY538rRpjM5AxBdeWfxZNDDfodUBzwroYRIuF7JNpVbtUkI1RuA5dSkn8zjtDw70JZm+0MFy3yuAVwC13IdK3F8kQYwE1IMejCf5eeUJBQ2AJ49jaMo7m/OeFd5khNKdv86fHNigWJJwIT9IM5ZfuKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743428; c=relaxed/simple;
	bh=fh88ONYbr3t1QoCGhXbNrGvXaUK/tWf0xzr8tQ9w1QU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cJs1hZvETPnNh1+6TB9HnOZ/t9wtF2lDnMxPZVPyeEf7qHBqo9FDnjeslj/YCvLHyjTGnxURUcHLVDgPmi2oBe4jICF3t2lbepng8GmKCLfsqwbijnaVvfRbXMJuS2q9cbz788VgN5kaaOhnqtDkQpcsZCUrdE7OrGcPkn7BT+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pMaDEXvw; arc=fail smtp.client-ip=52.101.56.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pMaDEXvw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiHS81Iuc/gWbU40zcCx5r6ylvvzw31Feb2oCfu5zcifAUuIXBJ8InUeYe19UPG0Zjf52bKYaoq8V14z52HH89G2X2dAndAOzMD5UUzAQxP0bP1HV2ldUYXv9/H6PiHpx6+eDFh2RwaE6hS/PpyhCmDR6spTmuVZwQb7sXg2CA1cfza3cQ/kFI4aljIl+ymwvGHv/9x+86QoYQ2iMwpij6Ecg9kh2hZXaPxin/+EYxG2pLgTfNKKLlBb6gogeeQCGf5gQvh9SV7Jh8pClAMnfSnOHgso/SvP4zF53QiWrMdjuBYyyUyt39pCC5qgmwJiHgCFubmkVGuevuErhi1FrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88+BveEQWj4woFGZQVud9tPyaOtSPhjvdy1RLLrC3tk=;
 b=EowOiIy01K2Wp21aJlMUtyRSMhBcuxsgKTK6dqjMxMeLdmSp9e5gUJuUYKb5PGtqlY6uIybrLwXzOVNaSVo49bFOScq2qqvw8//Kdu2pTwtztVNmUc9X4EyLKLKsuJRkPns+vaxX5R2xGg0r3uir6VYU7Vc8hpk2MpmpuTiZ3qeQ24kbTB/2kYGIPCK5hiYcDaigyGZS8Qj0ZqjM12rlEQS4+QsF/vyANVdU4fDFukU9LUsNrO7Rp0Et8/vM8ZmkUfYdgpydiM04ucccEUeMu3KIuYruirLmkWQgEhFLghuShlEV1TMFqQIYLMslnLiXVo1rNFROBcBih4P1BduKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88+BveEQWj4woFGZQVud9tPyaOtSPhjvdy1RLLrC3tk=;
 b=pMaDEXvwcB8bV6+mnYXPC/jaa6pns3vVy3NxZCScvxbvYd3aM5gd/rnmYVD6DU7VFUMnFKGIbgtdarByS3rNmQ1bhvkZ8QO9QbN/Wj7YP49b3mdPRMcosTOupgj4IU5HcbKqgK/chhWZ6ysmmn5urunkkxIhLhaLsMSWn/ugBRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.7; Wed, 26 Aug 2026 11:23:40 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 11:23:40 +0000
Message-ID: <59268565-7360-4500-a14a-c6cbb1b43b0b@amd.com>
Date: Wed, 26 Aug 2026 13:23:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: i2c: xlnx,xps-iic-2.00.a: Drop bouncing
 mocean-labs.com
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260826103042.147735-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260826103042.147735-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7aa49f-2c8a-46c8-7280-08df03647afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xBHiyfpqJIPE/+BT9kCvHipEwS5QANVk9V2U9OIhUWhk3ieAfXUI2M1WKn39zf8Pg6BXCI9TE2jdnV8UFBOJ2GVsupqVizaVCJxZWzC+eroRByNCJm0gqrBHi5PaA4pwMk9rUMwD6WZ4RplSJsMc1uo1+YHEPzxWyUail9hAcSgBA984QlLoQiDdoMzLOO9kyaaQNhSgDySQM0PpEIw2eTUvyeYbP0qu61MmrNI/R26PkqT1TWT1dOQyVRNoXllhqG2ZgHsX0f6TUnpmIY5T5WFkv0Gr5y+mL0IvWL+VkaXciHVIYU4qIDbBAvOEtF4ntdTa2aWntXvkUTN1qcCAExNRY7NmNE85sIxm45i669HdF6PxjefkXshDFVRTtJ2nktpti9rMDEBZFMkhjtZPfL8jyYuDrKeaShxjLXfV3NLz67WU+BkKrB/SnTC4sLi1pc9l/k61lNiy47KfYLImHNp9fACmruUOsOO1O4YZrEwBmtrzO+SC7Ji691q5MiAhvDc6WJ7a1Rr1UP9GnXi8/551Gesvsv9ECIFLLJwtIIG9QTECkrdv48GxlDWPQwE4rratsOoieYSvgE38zExZj2ZFstR49pexLVd1vi3ALU+SVZY6CLfZsqfaMUGSFZ0A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVpoTGVaaXpoaUZiZkxJcGc5emVEKzNGelJ0bXhYajhoVnkvRWJnZjN4ZklE?=
 =?utf-8?B?R2NKOElucTJ4bm1SZ3ROQWROeStoaFpoNEY1cGlMVmpmWUxZWUk1Q0JzMTVR?=
 =?utf-8?B?aW1nUmRkODliSTRvTUNDa1lMN05rYjhOb2R4bHdMS1NRWmF4Z294b3VCdkdV?=
 =?utf-8?B?Sm5hZHlhWXRBam92TGdnRFRGK3NDaU5QcjBuTnpzMytOWHM5SnlUa1JtbEJt?=
 =?utf-8?B?dmpHV1JJbStUckdZbmdMVFFBZExQc0tJd0IxbHQyZkFsclovczczRzVobUxj?=
 =?utf-8?B?SXYvUXo0UDFLaS9Sc2JORGU4QWRrT1NOTXoveUFNZTUxRDgycE1JTXBjUzJU?=
 =?utf-8?B?NjkrUFRaUm52VlJFOTB6ZDB1YzlKRXhaMVk3NnZUMU9HRkNETC9iYjdGdlN4?=
 =?utf-8?B?R24yWExndjVBSXArSURsQkQyMnNnMGt4akxVWWZUUmVCd2NmNGxGWVpRbDAv?=
 =?utf-8?B?YitFUGtxeDNBdEZSaUc1QnA3NkFGRzcrazhZdnY1TmhwT3lIdEdkZk10YldY?=
 =?utf-8?B?aFoyaXlnVUhMbWFodDh1RzFXcHpQOFlXdGZaRzJTL3ZsMURvQzJFM0kzNG42?=
 =?utf-8?B?eVNkbDBIQTR0aUM2Rm10ZFBvSWQ1cE5pOEtjNTF0bHFvQW5JWmxXUXFYSnpq?=
 =?utf-8?B?MDkyYlR6ck8wY2JOeGNCWTA4SVdTQzBGbE9ENi9Fckw4ZmlSQXVPYW03dWds?=
 =?utf-8?B?L1Z0MDdhVGNqaGRySUVZR216T2YwRGdERmVNRGNNdERlMllURWt3NlZhekF6?=
 =?utf-8?B?cXdKVytEY3BlNlFFNUdCYVFaVEIyYzhyVzhReVFINUF2OXVZUW83OUN6cTdQ?=
 =?utf-8?B?MHVLOGhYZFVCZmN4RzR5ZXZva1JFQmlmTFZ4RW9HVGU2eFkyMGh0Z2VtY1FX?=
 =?utf-8?B?ZHRSeGR2U2dvTFlpZmtlMmRBcWJ5UExVMjhTVjB4Nnk0YjhJZmFSejZpYUY2?=
 =?utf-8?B?Tm96SkpiVkxmLzd0N3dQN20wZmJVUFNzbzJPQmhvSzlYeUI5VzdLbDdjUkJj?=
 =?utf-8?B?TjF2amxXcjl2S21pZkM1WUh0K2s5Nk5HRUtaQUV2QXlwUGJQb25OQVZUZ3Nr?=
 =?utf-8?B?SGZmeURZZjU1U0pBZVpyVVVRVzhWSmNSR3RBb01iVUxsZE1TcnJXOG9RMm9u?=
 =?utf-8?B?dTZ6TitrQ3hGVzRRZVVDenBlS2RIaSttKzJNWU16WGpQaUt1V0VqUFRWMUJD?=
 =?utf-8?B?Nk13KzQ0M1YrK0VXd0dOMFRCeTM1UXRWK3ZXYU5LWFVlU2cxME9tODlOU1RW?=
 =?utf-8?B?Y3RuSk50ZkF6b28vWTlMTlBFdHN1c1FZNjErU2xldEE5VmtGYmxPczVCWnRT?=
 =?utf-8?B?dGs3QnZCSFlqcE5QUk1naUc4cjVCVU5SRWp3UlVxYmdQL09PRHZQT3oxT3lx?=
 =?utf-8?B?WnFvN3ZrajhCYWtQSkVUaVl3RmNLVWpEeTlkUnlMMHg2YVFqeWxjODRFWnM1?=
 =?utf-8?B?aGdyMThmbXEweDFMZytWWGx6L3NteUtnTkZ0WkltY3l2N04vdC8vN1A1TkFa?=
 =?utf-8?B?SkZHNC9hUUI1R3ZpSUlNUERCSzRYRXJ2S01zVXZPUXBMTHA4eHErOVlhU0dQ?=
 =?utf-8?B?alRQZTlTeWRFUHlTaDloWW1nS0JEWWZVL1dLV0FsQzRtRHpSUHUwS2RodmhM?=
 =?utf-8?B?NG5YTGxkZU5MQnFQTHR1eFlLc3kzLzdCbG5JVHE2TUZoaGdmTHVsT2FIbmtZ?=
 =?utf-8?B?VEVyNWc4bElwNkkwaEJlYUkyaW9WSDlGUEJDZlo4VU81SzVhK0ZsUUh1YUw1?=
 =?utf-8?B?UXI3OG9OWmUxU2RSZ29uN2U4dzdLUTkvMHNRZ0ltM0ZyelJha0VtUHdmajhu?=
 =?utf-8?B?dFZVbEcwYUJhYjF4eXNUbFJlejc4V1QwMkpxeHkzaVZCRnQrNWczbDdVQkk4?=
 =?utf-8?B?Q0s1UFU3Z01Wai81MmhpRUo3cm1rZ0xOaE9DRWs2bFdoVU1LQ0NLZTJVWklL?=
 =?utf-8?B?b2JOcUVRVy9EaWNpWnd3TUhQcmYwSlBBWnBYQjE2YldRblcwdmFvdzBySEgy?=
 =?utf-8?B?aWMxUlhidzBwVnlVbTdSK1grVWw1RXZVaVdOTzZpd3JkV1R3dzVuTDVDekJq?=
 =?utf-8?B?cERHd204L3l1VDZUd0szWjA0U0ovdGFCWEw1WlI3RUdrUHJMaGZSV2pZYnZx?=
 =?utf-8?B?ZDRkTDVyWjZDNGtxSXhtZkE0RzFPVEpnUjRlNytrSk5DVU1CNU5KMmt6b0pL?=
 =?utf-8?B?V0FsWE1USjBuU1NuOWxnUm0veUZUL2hyOElhZjg0eU1DazFhR1NrdzBYdyty?=
 =?utf-8?B?ZkgvWlZ1eEVMZUVIcVAwcWl0dW5xSDNhSytWb1kyU1Y4OFhDVVRCcjVnVUdI?=
 =?utf-8?B?b29QNWcvQVpPNEczcUMvOFMycmlaOEJIYWk5STVrbTl5WjBBQ1hjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7aa49f-2c8a-46c8-7280-08df03647afe
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:23:40.6232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUyIAi9lZ6X6alpHX94BPQV3iw4yZ8Jqh/LfE/XUamOEC/Yp18yRzJdMPSGUbUiE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964



On 8/26/26 12:30, Krzysztof Kozlowski wrote:
> Address info@mocean-labs.com bounces permanently (reason: 550 Host
> unknown), so switch the maintainer to Michal Simek.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
> index edd561d9733a..57caebe7af35 100644
> --- a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
> +++ b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Xilinx IIC controller
>   
>   maintainers:
> -  - info@mocean-labs.com
> +  - Michal Simek <michal.simek@amd.com>
>   
>   allOf:
>     - $ref: /schemas/i2c/i2c-controller.yaml#

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
