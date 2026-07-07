Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011030.outbound.protection.outlook.com [52.103.72.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C017A303
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783386818; cv=fail; b=l2hKjwCSEJUeD//B6BD2QLDCbpr6HauyQKCQQInhgZES+qZPFuSaVTy2Ad8Uz2l1S/+TGSgsx65wID6Ln1Twz33fAy3QKibOmkjGRRqR6bdhpX1l8R0QgSKDuXK4tqWAKn8F9WAOis4KekHQ5UqaBJnYqXvi1dwxVjTMnf89dKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783386818; c=relaxed/simple;
	bh=/HqDaf+GgkEpthuX8jecZ9dOOzTG0Gu1Nq37prM1bbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DcSwZw+nIhABZ3fq5oWbtwu/LUwAvqjL6sySIOz0IcFaw1TkxgJAfeoH/Ae0+ftGTLeZskVU8cCgtlGvC2zEKFOeGbVQopSo15rsZZs1S6/I+CwdK5TOPBSk+8j2nnxaG25w9iBTqTvCHj4ojk5wTvElD2bqLDyGaDW2jkkIkKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=VIX2ZPsw; arc=fail smtp.client-ip=52.103.72.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="VIX2ZPsw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzzGMcmg/rVb12XvSJBEBxozXfHwcX//rijh0q4iAFQaL8AVHFdwWas0IIOtGaogvjKujwXCCXayV7+uhz6fxnyeGZF6Ly34U9laA01WVB4XTRnAgY5ZNGP5aeHPZfaXqG7x7n7LMFnwfNdkAKdHIDEsWc0cXRDiUNRdDzyU1n8rMNdcrdrAKJthMX1eIhAc7d4SzXwLgNSteX3j8maDhHJNyrubFqAW+FWaWgEOLga8T6ri70F+pBlUfeWtnHtHGKv7SBZK+Kn1PXcYVgaJebEvg/wcjzy/ng5+qQFonXj/o4DwjRr+pW2NIsiOyoqXXtUN14NcgZt92LYZrrmJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+0VGd/Yd3HDm3ert2nxuRsqGxssiJ2oSMMbA1kcPsE=;
 b=iUoFKmswUtTaPU8ZSjtGIhWYfA5l4Zm3TVf0b/Az2AiejtnWk+w/+uSrPNGPRk3l1q4KMTX7HctkjnIFkzpCsqrE9QzeXScJXheMsUgO3LOWJCtyN0P8ycGw6iMr3lI65pZAwDCD8SAtWnZ7cJoRPFg0ZDQYUVgH4IDLG6edUF+qiiWzT7060SnUZqDrzzHhZSSLmuYNmquMLki7kIruWJTI3KJzgtD4xupYNeHwzZz1yOxlTbOwBCVFeXeFLM7i/Qi0CGPUCjS0Zn30u1j7HxNELL5e20/KtHN/hm9rJO6hgvtnV/CB+xetQk3pVEIFzD4mcgwo137Uvw0IMn6M4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+0VGd/Yd3HDm3ert2nxuRsqGxssiJ2oSMMbA1kcPsE=;
 b=VIX2ZPswUhg+wLe0FVQumLRSARJw8oa9shrZJRh6Ozh8gwgIjLW4L8maNiPNI/IuH75X9KSh90+OOAWK24fW5bXhbbxbHom0No1PwFDxkuUgtod2PkHdDifva1HXc2MCIksViDCucW2HWDu37EbBL6HTkt+j4/R9DF2K3lWHqX3lHRtf1TKz0jArH8HYTH3SGFxsiVGjPBWcReHW1yHZY1zdCGJaFyexL6TTrBzaFY7ovkaksWQ0FqU/zwAvZjMjeQXbHYUh/AKWCL+OZkt3//6qwsq6gc0TNUCO1l9RunbMU6CtWWvBxdj3i/uai5Pi1f7xVb3QRfbgopIxT6WBnA==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by SY6PR01MB7669.ausprd01.prod.outlook.com (2603:10c6:10:174::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 01:13:32 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 01:13:32 +0000
Message-ID:
 <SYBPR01MB45868C482D0DF25D1647AC2FC5F02@SYBPR01MB4586.ausprd01.prod.outlook.com>
Date: Tue, 7 Jul 2026 11:13:30 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] i2c-tools: Make tools accept bus path
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Brigham Campbell <me@brighamcampbell.com>, Jean Delvare
 <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
 =?UTF-8?Q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
References: <20260530-accept-device-path-v3-0-20c01b8f6726@brighamcampbell.com>
 <SYBPR01MB45868F802BCAB22D56DDDDC0C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com>
 <akvF9W7r2gXi77eT@shikoro>
From: Stephen Horvath <s.horvath@outlook.com.au>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <akvF9W7r2gXi77eT@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYYP282CA0004.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::14) To SYBPR01MB4586.ausprd01.prod.outlook.com
 (2603:10c6:10:59::12)
X-Microsoft-Original-Message-ID:
 <a9691e10-4748-43ef-b1f2-a6a396ecef63@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB4586:EE_|SY6PR01MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac0ac33-d70d-4fb0-87a2-08dedbc4f5c7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|51005399006|19110799012|24021099003|23021999003|6090799003|15080799012|37011999003|25010399006|5072599009|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkZuUGNpRHdXRHc2MExFZFdGZ3RSVyt6V05xVlc5WW9aYVdsbm1GWGkxdmhx?=
 =?utf-8?B?aHJubFFyR0sxaE04WnBEam5vb21yWnNQSVp1SUJTMFFtL012bTBPcUhXTjJu?=
 =?utf-8?B?RzFlYWtmYVNwRTdLTlNScDJXRVB1R2ZBQi95YzFxeW1HejBrUyt3SWZBdGN2?=
 =?utf-8?B?SUp2ZE4vcy9OM0VlT0dGbFBnN1JGbEE0a2hHbllvV3E4SHIrajA4VFhMKzRa?=
 =?utf-8?B?V29QR3MvcnYxQm5qRkY5dThFS05iZlp0NVZMK2NTcUJKZHVaVi9WQXVLTUc4?=
 =?utf-8?B?VC9UNjlUMkxhRStYRDBvVGRYZlUwWTl1ZExSaHlCTEJIUHFVZjhFSUhDYWl2?=
 =?utf-8?B?eFNob0haWGhoVUFOVnk1VGZXZEw0N1VVcjd1Y0hkSFE0QmtMT05ZY2lhSjYx?=
 =?utf-8?B?RUU4SVZXb1d2cU1wcGV3S3RWOVhSNjIxa2NKcFNLN3NUMFYrcVpjYmU3S1gr?=
 =?utf-8?B?bzJrZklCUk5kM3JYamNCeTBnYytzL1hVQTVIYU5yTExBYzVKaDBMOHJ6MUxN?=
 =?utf-8?B?dSt4QzIvUjhmODJnaTAxeTQvU20xYVVsOGZYMWJsRXMzbTFFUDg4SG9lVHY2?=
 =?utf-8?B?SlY1SXFXSUNWR0J5RkdJL05BcHU1cC84RGoxOVJtcE9sRWl5WHBVNDEvVDZ3?=
 =?utf-8?B?eCs2Q2lKYi9lSXN1QWZZMGxRYWNQeEx3WWZvekhFQ3VnMFVieFBJQ3U1MU9J?=
 =?utf-8?B?clBOcXB6NnpjY1dReVZiTkZtNlVUV1RSaWcyZ1ZOc0Y5VTRtVEUyU294SHR4?=
 =?utf-8?B?ZFhXS1Q4d3JqUytSaGxHVlNjMEVPTVUvQ2lwRGZIMGdHL01EUzgxMGJzY2V1?=
 =?utf-8?B?WFZHbHk5MDZXcGh3T0x3cXNWcGJ6dmpZajc1Rms1UHlsYWNGU2xsSjNvMk0y?=
 =?utf-8?B?c0l2ajU0QU8yOCtIeVBFN01VQllrM3FybGRGWDNTWnRON2FzWU5tWEhYaFJ1?=
 =?utf-8?B?cEVJbHNJYVV5NDB0WlZoVjFidEhYN3FyVytSVUtDZVBvSmhVWG4rK0plZGUx?=
 =?utf-8?B?V0doZjM2T2grL0lxbFZPL0lXcE5UNk1PVzZNU1NvSy8zcGZSMXl2c3ZvSWNM?=
 =?utf-8?B?azF5R1d0eVFNdmlhNHFNSmpuTVhwd2tEakJNNWRjM3N6TytuakVVNUpFUHZM?=
 =?utf-8?B?SmIrbEFoVkFialA5TEVKMFRHLzdiUWI3elhLSVF4cGF3OFNkeG4yUG92Z1ZU?=
 =?utf-8?B?YUZkWW1tbTJkWWJsZVd5RVg3UWt5M2VOdDZ0TUxOQnlsRWZ0RmJQeGZwbHlP?=
 =?utf-8?B?V0ovMGFoTFJNKyt0Sjd5ZDA5YWVvYW43YVBjVkhhVlRlZzNtV1hMazI2M3Nl?=
 =?utf-8?Q?zFuSrz5VOV6P+ho5wH1+w0gWVgG+GTCM+j?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2F6TXRRaDNmQ0ZnWDBzYWtlVUJ1eis2UjRpdzdRQ0Z5eWd1SHJhTmVvcXBk?=
 =?utf-8?B?N2ZwM3hpSU82eWp0UWlRZHZmaS9KaW1Bc2t6QkRWNk8veEpEeHdzUkh6RC9R?=
 =?utf-8?B?Z0dtOWExNzJsSlJJcVJESzRpenlUcFM5dEV6RC9HTG9Kc3l1QVJoVS85Zm9M?=
 =?utf-8?B?dW80Ky9DakFuVityK1Rja3VRanIwV2VyQmhNMDJYSUJvM3ZGRE81aDhKM2wy?=
 =?utf-8?B?a1JGcW04cjJuYjV1ODVhZEZ4Sy9TSXUwYTNQRXdlR3A3UkFuNlZFOUZpMEdy?=
 =?utf-8?B?SXlQc3lWV0RVU1p5dEdwZ3g4ZkhNTmZKOFhlN3pHQ2VzTCtyUFVOeGhNT3VV?=
 =?utf-8?B?OHQ5Zjc1OWRhTUhYMkVRR1hBdzQ0UmJoNzEveUgveFJuVU5TcitSMmdVZXhI?=
 =?utf-8?B?R2JsdlIrN3RmV2Q1Rm9YSFFPelY5d2pidWZ3ODduQUhIcmhxN2dlMmZOc2Fr?=
 =?utf-8?B?N05Bd3pnUkhtU0lXazIrY2Z2VVJrTGFpcTErL1ZFdERuY1pBMFhkaCtXUVVx?=
 =?utf-8?B?ZFRQaGU3aERhWFhDY2F0L2xLZ3B5MmllK2wyN00vOFA3WVRHSWYwZDZEMmlL?=
 =?utf-8?B?b0tkdUZ0c0d4VnBtVTlaa3Vtc2hUbUJaWU05enkvdGE0MEJiSU5qODdJWVI5?=
 =?utf-8?B?Tk1CdmhpVUF2am9HYUdyYk1hSE9wdHV1MW9yVlVDZms0TkhwRGdZdUw0SXYy?=
 =?utf-8?B?c3Q1TmRWcURRSHM2MEVCeDRWYzV5SC9kSU1qSTBlWDBGYU9BZDdsYW55QzJV?=
 =?utf-8?B?NkNDRTV4NGdKb3UxTXhkOUdjVTJEZlFiZ1RMem9iblVSVkpyNzZlbGh5ckFk?=
 =?utf-8?B?Q2c1WGtUcmtkcXBKTkNSRW1UQ1NuNWVTZEU3SWlwK3RKdjRQS0o3R3lTOGtR?=
 =?utf-8?B?VGlBc2tXTWJVTGlXd2xRRlhVYXNoTVVQdnRNeXUyK1V1czdvempqdDBTR08y?=
 =?utf-8?B?NGlHOTd5T3JKUXZOdW1iNEx1VmF5TWE5TXBuc0ZYbkdFcGc4WDVyeitKMGJD?=
 =?utf-8?B?MFcvdWtzTmFVekc3RDBHS0c1ZEREVGQ3VTloWFkyVjhCaVBwNktIVmVEMG05?=
 =?utf-8?B?a1d2TEUwTUI4anpjc2M1YW5GUENyNWNHZ045WU9HTmlNR0hlMFd2SGVwVFlG?=
 =?utf-8?B?akhodjdvaVFLTWZSUXl6dHpsdXZYd2d6T0cvSi9WK0o1emIzS1ByTWdzRklE?=
 =?utf-8?B?RXR6ZEpTVUJTUHdIT2tEdEdldjZNTWZKUmVQRjcxRXBOR3pIcklsMzg5b21T?=
 =?utf-8?B?dG4wWlFvZURteU5NOTFGSUI5b2FwZWZpYkhmejk5b2lRTDR5WFJIZmNBQTRX?=
 =?utf-8?B?bU83d0xCWGp0ZHFNV3VNQmZUcW13bEdzMXNFdkZHVkpKQS9yMWd5QzE4bTdK?=
 =?utf-8?B?L0s4MkowMWl4RGZ4ZGFsZFQxTEhTZ0JLaHhadDRmOXhGb0NFTHlrRi9rNWFh?=
 =?utf-8?B?RE1EalVDaWlyT2xkZkVtVXF3bVlldFdZMG5XM3oweEtyNUJoOWtPUXJIVk8r?=
 =?utf-8?B?UVFzdE5qZGt6MllTK3Q2aHVJMWVVZlNTYkptWjlhcUpPd1hhVDJLdXY0L2Z4?=
 =?utf-8?B?UzZxRGRXZExPTTlSL25OeXBZVlU5bUFHdER3OExyS1FHdlBwN2JWdnBXcGlS?=
 =?utf-8?B?Uk9LSEdpbUNDNTFiVDhoM0hjd2NLV1JKUEl0MVBiTFNvblA3TGkxY2NTTmlY?=
 =?utf-8?B?N05EWktPMkEzWWxJd1R2U2p4RjREMHF1VXcwdnRISUJ1RWlNZ1RlZkZiZTdw?=
 =?utf-8?B?MFRzYS9ZQ2I5cXB1eVRFZVZndEJiMkViMlNUZ2lTV3ZPODJCajJqWXZQcTl4?=
 =?utf-8?B?QlRsYnJTUzViUHVlNU9oZlVxQVFEOFA3WWEzSjJFWkRhQzNOajdXMkdXODlX?=
 =?utf-8?B?dTdWYW9QN3RxaW8vZ3d2dWNHK1FMOEhrWFNZbkJGakRocVhYRUtyUXJJdUlU?=
 =?utf-8?B?c2lQUTZZWmVtbHBQMTBibXp3R2MxWkd0NXdwVFd0UktQTm1yNkoxWFYvTUhH?=
 =?utf-8?B?cmYxTURrSUN3PT0=?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac0ac33-d70d-4fb0-87a2-08dedbc4f5c7
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 01:13:32.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6PR01MB7669

Hi Wolfram,

On 7/7/26 01:12, Wolfram Sang wrote:
> Yes, it does, thank you very much! I will convert your mail into
> 
> Tested-by: Stephen Horvath <s.horvath@outlook.com.au>
> 
> if that is okay with you.

Yep that's perfect!

Although, I have considered getting a new email for patches, since
Outlook has some quirks that makes it a pain, but for now it's fine.

Thanks,
Steve
