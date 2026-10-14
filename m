Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013086.outbound.protection.outlook.com [52.103.51.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06689560AC3;
	Wed, 14 Oct 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992819; cv=fail; b=IPi3Xvh+/MzC1InLo2kxzdWxAAwwnMBAfQpde5G6TLAIx8GvG5gd9Ogn8qDvi1eAkoz9baU0nJTvkTEkS22WgMKmMLkzcOCnaZiiQsWZybZPJhM5xr1oav3J6qFa3SToganK5uK/avZPslfkZv8T1uLeQjJYfwxS58j2BfxRaTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992819; c=relaxed/simple;
	bh=UrTzxPO5qpMwX0RIkT9zr5/0SWdtPUqqNplKtr1UbwQ=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vr2rB1v2E1HDPKJ/iCmJ9+jioNOpc2oIMn7g70ycqcpUxA7ZltnIoZcD7mlQEarPn2XU/X+PQ4DLPJuZQ+tsAcctlUyUPabUVdHSsWNbGxL6lN1NO55C/N0PsPBL/6Lai7c9AdgY4TXkbISHc9w8zyko/fxB94H2uOsJCVKDvtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jtskzXLo; arc=fail smtp.client-ip=52.103.51.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jtskzXLo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq0JW0auUfS7LxQ/REb6vU5MVMdNbH/RoCS7IzjSH11E8fQwOmkC0G26FhNmMT9xXc2drIF3uE4OwGpvd4RadWlDkVaME6MnXNBGkKx9K2c18SBiAHV4F68FNGVNgh5rojZzFXPrsQyMF86wd5sVC78XisVFk1PGycvmfj/AOTD2tTtxGtDwjZInRRrViyyXrCyzjyZTHz8071dKEm9REeNpL2tMLTypVnLGHbb1HLqbXcmJTgkY8IOamQgKl+Q1McPGAsoYOvM/5DKs38yzr9Psy0TlPRGKblCMCCcX0wLt1IkgU0buvFXUdxZeskHiwfCnoVXixRcmxh8JfKxfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrTzxPO5qpMwX0RIkT9zr5/0SWdtPUqqNplKtr1UbwQ=;
 b=RlP81yNobx6ttv3XJSKYR7oVZ8te3IVeIlWFlZKulVL8Xq3fIe0jG7xoz8rq867DPJT+QLsp4Y/yIL55CwNjisDVAUlfuq441Jq/liYrWDUrojmSshqrpPYETQNoIu9mqoi1XqRBaizM+uCw/Bo9/Zu/b9LCaJvWr+pBTmm1X1vDWpMM/BWSkCDapvcmuUCWjH+mQGviVUbzlqXwzWmq2kDYuaoHbP9sxHEFay6lU67e+vWMrdXacNnzJnM7G1jvM16ErhFlgqpWdP3kcEGMD375zuHtXATF+z6aktAN541flXzdz9uLnuANG7yinerev71H6hypBgiW9y0GKUn4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrTzxPO5qpMwX0RIkT9zr5/0SWdtPUqqNplKtr1UbwQ=;
 b=jtskzXLo8XzxyVfsf7z2aMVVR7TyMIBkmaPKCJwq7f62PuiTwtDaxFL0xqW8iYCHyowBx9VCkbTugvkuo1sHJKOBz5x6Fe1yKmAMh3qpRxygD8ue/4+UJW9acn0x1ORdHhQqR2qSVR9bOJ2cqefFYsk1niMObbj9rQMlQE51fIc7tSgC1JX/oB5U7AhGtCOOYM6QaF1RDA9rANvO/Th6axrj4+mRbIwHkEv4FMOKvWe73HWEzKoOeFU0bww8ICg/E1M3Gv11bruzVvcdGjcDCGqjKJgaM2zCQAFQftOXUjcna4bkLPZPkovaQJ4hxfr8VxOBTFCBsE7k4NNW3Tgxow==
Received: from FRWP194MB2710.EURP194.PROD.OUTLOOK.COM (2603:10a6:d10:179::18)
 by DB8P194MB0760.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:16d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 15:46:50 +0000
Received: from FRWP194MB2710.EURP194.PROD.OUTLOOK.COM
 ([fe80::6fe2:dfce:393d:360b]) by FRWP194MB2710.EURP194.PROD.OUTLOOK.COM
 ([fe80::6fe2:dfce:393d:360b%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 15:46:50 +0000
Message-ID:
 <FRWP194MB2710EAF472B974C4D0330C59C49D2@FRWP194MB2710.EURP194.PROD.OUTLOOK.COM>
Date: Wed, 14 Oct 2026 16:46:49 +0100
User-Agent: Mozilla Thunderbird
To: andi.shyti@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, prinn.dev@pm.me, westeri@kernel.org
References: <asT6nqQMz13beDyW@zenone.zhora.eu>
Subject: Re: [PATCH] i2c: acpi: Force ASUE140D touchpads to 100 kHz
Content-Language: en-GB
From: James Heppell <Formularsumo@outlook.com>
In-Reply-To: <asT6nqQMz13beDyW@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::11) To FRWP194MB2710.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:d10:179::18)
X-Microsoft-Original-Message-ID:
 <3a3411ed-ebac-4a98-9c8c-f6611e7772a7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP194MB2710:EE_|DB8P194MB0760:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e17b54-5615-4b84-63c3-08df2a0a5c54
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|39105399006|25010399006|20031999006|4140399003|19110799012|5072599009|23021999003|24071999003|25031999004|15080799012|6090799003|8060799015|40105399003|10035399007|1602099012|30101999006|2607281247196008|23121099006|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFk4dnBzYllidmN6dU5JeEs4WmNzMVcrV09kV2hnNit2Z2RDL3pLb0dJWkpa?=
 =?utf-8?B?NEFBRmU3YlFVTGlld283b2NuVW9nZUFscjMvOWMxdlRyRWQwUGFkWVpmWTIr?=
 =?utf-8?B?eTdoTElwL0ZCSzYydzVTRmNMdUJUQkdCTjdPeWh4L0hidjhpOE1HLzdrQmdl?=
 =?utf-8?B?dWpxc2YwVC9BQzF1ODFCNjBuTWFkNUc3YVRZWnBDanRtcG90eUVTUzM5dE5k?=
 =?utf-8?B?enpteE9yVDgwMFh2Vk8zdS9aMjlhbG5UcGs0b3BpSy9mT3B0dUFwZW9XNnFW?=
 =?utf-8?B?N1d4Z2Z5aFVWUk5kSWsxVU40UmhOUllueTJEVFJIQ3JILzlKU3pROW1EQ013?=
 =?utf-8?B?WmkvTHcwWXJQK3NYeDdTSTgyS3FQZGRneFgxQ042dTFTMG5EUDltSjJGQ1pT?=
 =?utf-8?B?VS9Udm4zcUI4bGlZcElIRUkzbWxOdjJNNE1kRWtFYUNTTk1SNHRPTHdRWmVK?=
 =?utf-8?B?SmZSU0t4Mms4ZXl2azRRemFLRkVBZURnN3M4MGZFcC9hQzdMMUFYS0d3N1FC?=
 =?utf-8?B?VTlJSjcwVXExM1RVN0JsOXdYbjgzOHRia0Z0UzFuTTBHc2tGY09nY21YeEhE?=
 =?utf-8?B?NysybW1iOUZIUTVCZ3Nsbyt2Nmhia043bVh4Z0ozaU45dGdrVGVvcHJRa0R1?=
 =?utf-8?B?TlVWZXY5WnkxaVY3cGVEN1RDWXNkSzF2SC8wVTUzZ1hqc0pkVGdCWmlDUlRP?=
 =?utf-8?B?OE9TY2xFeWw2cUpUQVMwWXd3bHljNFZ6Vk4rRXZDM0RXZVJDSjRlaGRDMElF?=
 =?utf-8?B?eVpwclpkOFF4ZUZYby8xRDJkS3JIb0dvQkpOSEZFQlhIVG1LbDNyUGVKNS9z?=
 =?utf-8?B?NUFOLzdxWlp3QUxrNTR3Q25JYTI5YjdXYm13eVBPNVhKbndxaS95S1lzeTRp?=
 =?utf-8?B?T0ljRzNvaFJjNUJIOC9sUCszZGVQTTlOZ3ViTU9aa3YrNGo2a2FqaUczcFRr?=
 =?utf-8?B?THowM3h4TVFodUlSSENFOFVJMnNDakRBQVVVYnVMOFVJSThLaWRPQW9QNjQx?=
 =?utf-8?B?SGFjWk1wSjFudkFpT3RScXhzQ0RHZVNrZmxkekx3YW9CYjdLQTdNSzdHcmpn?=
 =?utf-8?B?d1p2clpobkVYaE5zQyszbXZaZk4zQSt1YW90b3dFR3pHcFpreEJOT3hCWGZR?=
 =?utf-8?B?ZlY4c0NuSlYzY21VQVpOUGN5UlhlTGRrVFA1b000SU1mYWFzUjA3dUJLWFhM?=
 =?utf-8?B?UWZBVGRnZy91QWIvZHBtUDlDRDNmVlhCdE1qdUNXYTA3amxFKzhXeWtuZDRO?=
 =?utf-8?B?QXo1V3RLVzNJSUdONk9RdmZEbXgwMVJwa2N6Y2JQNzRGejl1RHlzU25uQVdP?=
 =?utf-8?B?UnpzRUFMRFYzSTJrYlVrblNqdCthRC9SZjQ5UTFIR2RkYjZIQUFBdTdaVXRI?=
 =?utf-8?B?RCthWWtkYnJ6bnVzNE8rMDRnUmpSVUdybkJNcU5kYzhaeTFJTkMraWFhT2Vh?=
 =?utf-8?B?U2hPYm1oc21MbnVPUFExdjVsZit4MGVKMUhaSE9vd3NNbUFrR2x1SmFubHNq?=
 =?utf-8?B?M3NVOExZa090dHJqaWk4OGtSdTVtZ3FkK1ZlVmdNRFpXeFhYMCtvSHJ4anQ4?=
 =?utf-8?Q?JCayN8okKT/ocW5tBPXeGom/o=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEZZdmtJa1ZMbHo2d3Qrc25CSEZkVWIva2JpdVc2VndkWDhrVEwrMnpsMXJ2?=
 =?utf-8?B?NDZmUTFJbGdFOVdDMzZEakZhT0NIR0tZTTFNS2ZvNHRRalQ0N0VqWStHRjRB?=
 =?utf-8?B?alBlUFdBRGIxQmJWbTlTaG40RGI3NVEvUTZzZDNRQWgxcmdOQVNNZEZMbDVI?=
 =?utf-8?B?TGtwL2Z4RmVYVUVCYkJlY2NTdEFOdXlEdm5yZ01DdjlhNG5NVWpDcldJalhJ?=
 =?utf-8?B?WVVTazc4dDA0c01mYnkvNVJJM0FLQUxIUkpUdEFIRDd0Q3VwOXRhTlgwaWRq?=
 =?utf-8?B?enlBN2hBeEYybE1qOURQNEpDM2l0cWJ0SEU0VGlwNEZTZkVrOTRhelc2SUZI?=
 =?utf-8?B?amR0UzNOK1NRZXZ6VFNlelQrbUdVNm03Q0RvdUZJOVQvOERIUUJxM0Vhajlq?=
 =?utf-8?B?enpKODRDNFZqY095WldPYjJmZ2RVQzVSbENKSmd2UldVY3N6MW9hbnJTMjNR?=
 =?utf-8?B?YnhaU2ZpOUJMUFZCUGFuOFNIV05xOE4zekVYemY4aUpOM0ZUTER0eURIbndk?=
 =?utf-8?B?TFd3VzJnNlFmcVNRVG1kdnR5bTYyZlBRWUF1OTYwYVgzSEU3VVQ1RC8rT2pZ?=
 =?utf-8?B?c0FlNERLdXh6cHh2RHNCd3VDbVRYZ0R4Z0RlNmZDbERXdGh3aWdkUXltdTRa?=
 =?utf-8?B?b0l5SWZ2QkhvUXRObnJGS3VUd0R3eU15ekxBNUVJWmFrcFV5VnRLeXNpbHc4?=
 =?utf-8?B?cE5aOGd2Uzh5UFpURzY0cTJTNkNTSm9CT1VjMUNWWi9qL1lOaU5kK21kTmxB?=
 =?utf-8?B?WmNlYVJQTkJyRFdhY1RSZ2x6eFZSOXpucFIxWEY1RjB0R1pLS3VWeU9GZXgr?=
 =?utf-8?B?ZzVTU2ViTUxpeDJ4SjJQMzlRbU9NazBhNks3ekxWem9WUW9WOHZwQnVJeXVW?=
 =?utf-8?B?b3ZpbmlMZ2JqUUVSSUN0dWhDd2k4Si9TMWNvdFdTQUFOZit0aG5BcDVsVVBU?=
 =?utf-8?B?ZDVnamsyeU1ONGlwUURhaU1QYzJZVVBuOHIxTkphd1Ywby9rRVZhWUk3SXRr?=
 =?utf-8?B?QmNnOTBKdnVhR1J5U2lmTk5iTHdOcnh4ZFd1cE56Tk1PVDVrK2tCbWc0Y3hz?=
 =?utf-8?B?SFlKeWE2TndXQmx6WWVRUFZaUUFER2dlb1cwOWhjd2M4UGZCTzQrRTN3M3Nl?=
 =?utf-8?B?QndiVVNLTW9NUnh4Qkx1QXZZSFEwNDRmVXN5eU91MHhHK3JGeW0yT1ZqVExz?=
 =?utf-8?B?VjloSzlLQjlLMDhOOTh1NjZrU05RK2VyenpqOUhUOUt1dWRCZWgwSDFQU2xj?=
 =?utf-8?B?cXF2dkJPZ1FEMFRHVmVWZnl5SGhZYlJWaXZ5OE1UeVRiK2V3TWNJOWtRNGlQ?=
 =?utf-8?B?dkZTRnE4eEY2Z3krMXhkU2g1Ry9mL3ZKcTdvcm9uQVM5R2Y2TlozTmJJWEpn?=
 =?utf-8?B?Q1J5UEdhRUFVMTU4QjhlVXNWL0tkSTNERE1aMm1taGdXYitVcjV2NnlxV2VD?=
 =?utf-8?B?WG51VlJReU1SRk1WbkE3NjBPMkV2T1lBQVRTSnpEK1Y2ZE9MdUpEK0pkTkNI?=
 =?utf-8?B?UVo4MTIrcXF3N2RHL0oxN21NbFdsaHcrOWZnT29xemdVb044VDkwbWNtOW80?=
 =?utf-8?B?blZlMmNHVStTU3BqVENnWFM4ZHBlWFd2WkN6MEgvOEhYVW8yZFl1bHFWQnEy?=
 =?utf-8?B?Y3gzZHFLRHFGelpSWWI1Z2ppajd0V1FEeURpNUdtd3BCeFhKNVdNNlp3T2hu?=
 =?utf-8?B?S2ZZU2pIL1FlbDdOOXNkMWhvM0ZUQ0Q0TXZBZUc3OERpdnZZbTc2UklCS3Ry?=
 =?utf-8?B?VFNkUGRieENEdVBxQWRWS0VIQ013TFVOVmt0VWhqTHFlbXFMSnhreXFNYklG?=
 =?utf-8?B?d0F1Sm43ZnFXVkRmTjU1YVUweHNXZWYySHNUalEwSDI0RzduVXVuZUxHbXNZ?=
 =?utf-8?B?UDBDOEVBRXpJSFRQdTZPYmY5OXZMSmF3ZTNmVHNiUzJaOWc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e17b54-5615-4b84-63c3-08df2a0a5c54
X-MS-Exchange-CrossTenant-AuthSource: FRWP194MB2710.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:46:49.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P194MB0760

I've been experiencing a similar issue to this on an Asus Zenbook Flip
UP3404VA with the same ASUE140D touchpad. The touchpad goes unresponsive
until I rebind the driver or restart, and I most frequently experience
this after exiting tablet mode. I reported this to the KDE bug tracker
here https://bugs.kde.org/show_bug.cgi?id=480671 at first before
realising it was a kernel issue.

I've built Fedora's 7.2.10 kernel with this patch on my Zenbook and it
seems to have fixed the issue for me as well. Thanks for looking into
it. It would be great if the patch could be backported to stable kernels
by adding Cc: stable@vger.kernel.org.

Tested-by: James Heppell <formularsumo@outlook.com>

Thanks,
James Heppell

