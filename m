Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07E495ACB;
	Mon, 21 Sep 2026 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010862; cv=fail; b=L3eQTjnlniIx5oPQwRtv4hWkZVDAGMCN0v486UQJ25etcVOc75fFJZe0U0ez6Q1H80ScN/dEi1vyIGyI/GrHdEnwdRIn5aIWtYbZUZHp+AGfWeYWvi/QuqL3Io6qPghSgKbHgRSW7CdhMMxurxr+6xFbzs7KO77INuRHDslCSKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010862; c=relaxed/simple;
	bh=EtCrYL2qjoEmeKs5l3vU07KH+17gMT9Qoe/LAJtes60=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VAINqWCELNzBX381VA4z2l81aAuOZCJwUinbwZ9bF3w0Ax3uIugdSNjbuZ0JjhtpvDsvU6lNbcD15rJvZAaCIOpPWQwA45oosjRoGGR9kUvjvV11pLEz7J4DFv1ltG3wuZObyYQmacPFadjtxjcSFVjr8FJPDPmJkUdBd9QOYAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=fJoHqZxn; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wBAN9PG4; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="fJoHqZxn";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wBAN9PG4"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68LGuLFs081353;
	Mon, 21 Sep 2026 12:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=BJFITvyk15BxzrJ/wkAtyZsz7VYKbgALDfeJwrEEq
	uw=; b=fJoHqZxnyTGQxnOhR7SdGu+d1n7rmqf7rJMLQzEFvA+IOszM9FvzhyiqP
	neZfHTibmw3WkAgBzVKFSPnjaXE+HtiKeksKqkh1I2Pj+v95L+A9tiphAlAsTPRL
	f/zsfCkB5ozn3g6V357oJSGhoG1m4qXtdFVwgToY1vJL1Ez9qAP537sIrAM8gBfZ
	AF9Rek/SqJksO2XMSF05eueS5j7z78LOYFaHWCUnaNgto9e7cfGoMLQIYMJKdwWx
	pV94QV55lwNag4K9iG2ZjkSM/BR7ZhYn04AwHtX6Z4fmi1NjqG2mNuTrZVaH2weI
	bYAMmbiTB0q/Jv5hKpi/MWYDMikVw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gtbdngagp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:14:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwITixMAKybfjHmkfNK7ASPYstsdaRv+TbXmzDbJ/VU6Q4uadxr7h9QIZM0t2pESvteMM5obybjv823J5WN6gOq8lyEPhJIrkCbGWsvU14f9m9ppFzW4bKTe+9tNJA/i/iJy338547J0H11Axwv2WHfkVFOkEMuvXJO6AEMF7ZKgAG0HJGVO/v30eDmZqvIzLKTgjQcACNBPRu8/n11vikmA8cF1TZs2MGxKLm9IG8oF3a3Uuy7TMIOAq1iYwy9LsDPF/zVvdDZe2D7cMvogp1CA2M4Q8t57M7b66p6CiIlqsWHFouYILo0Lhny3QugXor51Slm38EJbKcTF1VVdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJFITvyk15BxzrJ/wkAtyZsz7VYKbgALDfeJwrEEquw=;
 b=HZ5akD5W+yuuqDCrJOUufO4ZHMq5agLItdDLJDHuvo5BALM1P39CjoXhi45gY5ToYrxvwlnGMcM54zgAhhJBlwOBQfHroE5q56ATWARCIODoAp1DAqYnSUDcz1gO3oAGV2u9fZ/ekW5DbjvH3pjuP5MKwKrStf02y251MDu/jGJvasf6z5hk/JFoOwFp8TH5HKDMW8XB6mPpwud3yYyZwgsPm7LqloM7lTJIJa44kreRfayI8+jYjk+CQ37kgRsGCcKkZgeV1353IrIBYUCLPePuwsYWBlKgR2gTQ8r8rmNdwrDnz7eto2FEDmS9Ya0d5sjTd+do4fljYy8PNv4yLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=arm.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJFITvyk15BxzrJ/wkAtyZsz7VYKbgALDfeJwrEEquw=;
 b=wBAN9PG4n50sWb/PUd45YShVBCgmT6/Lk/bU9wthJO1ziHr2rsyF0u2IHScG2BllLrvvFKi7sBJA+1zmnbXokEDvWyshIqHiK8DOGSKtuHLEMdDhZ3zTq0O9Wzoc5ojmclhfkS6XRYHxGOFWef1v59FbkcqTrmDa4ER07QtteuY=
Received: from PH8PR21CA0003.namprd21.prod.outlook.com (2603:10b6:510:2ce::14)
 by SA1PR10MB6517.namprd10.prod.outlook.com (2603:10b6:806:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 17:11:48 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::2d) by PH8PR21CA0003.outlook.office365.com
 (2603:10b6:510:2ce::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Mon,
 21 Sep 2026 17:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 17:11:47 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 12:10:39 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 12:10:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 21 Sep 2026 12:10:39 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68LHAYRs3390622;
	Mon, 21 Sep 2026 12:10:35 -0500
Message-ID: <b2d1e442-5254-413f-9c71-b071c6ef11bb@ti.com>
Date: Mon, 21 Sep 2026 22:40:34 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: designware: Introduce per-variant register
 offset and bit-layout tables
To: Mika Westerberg <mika.westerberg@linux.intel.com>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <u-kumar1@ti.com>, <lianfeng.ouyang@starfivetech.com>,
        <Ritwick.Sharma@arm.com>
References: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
 <20260919-tda54-upstream-i2c-v1-2-b0b9f77be18b@ti.com>
 <20260921111148.GT106095@black.igk.intel.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20260921111148.GT106095@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SA1PR10MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: d6256f1f-8bb0-468c-a1f0-08df18036b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|7416014|36860700016|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oiqlItEgRTiY/ht0SJICiUlO1H/47R4RdlzygU32u+zArBV7BfA+TjclnWwnxQpmiFBlHXablnU3X43EGl3V5kPlyr1CDfUPY3CqrTWTXwsGPm5H+4zgD/mkL+O+Zvvp/dafoJhX+iJbQ6H/ec8PQDLxh3omhusQ5PLOrPRVOzuex7iZZ5fQlZU/HJJWZw1DFy0fK1jiQXQ+o6gqaJAxha/pStp4c3a1ciDJzgIwkXCkL1B+r5V7pgTVPRDbmt/LvWWOLfc1JpCLKdC4nBIQRx01CogDtgwmUfDxbmPRSIo5vCLu1cH0u/7eQELLPEW5iAKJ5XZQvrdS1z7Q0d38+/BnhmbtaxcpcHuyppYnhjbswDZh82bUVSQF13k3sCOYYUYT8bzLH4FZ/8+2zLa6xRNUPxC6DpGO/NxWHWcZEKBP5Yii8gbFv4/qn2e5LpgyqmMtcMeTNK4CsMDzC9g0m7tUNT8ZYg01Q7pxnAIodGCMkfrkNt1RLOiNHlft0ezzRzg5gE0p+rW3dNJulzovY6XFDjX5TIStQYN0bMv14QmXRpGpmRR3FmDWGpIRAQ+j40hiR2/yDSseoXVWW2GL+/1G5b1WMjNAR06eGVM66V+KmXBLoThPh2c9rCQ1331AAlvLgWdlBT8EUZCnT0hC5EMdnC8oGPQDJmz2ajzsR5DWgsmwBbEjaw7I6c0gkAi0Ce4jlDPO3fDctBwKIvBlgg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(7416014)(36860700016)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dj+ezKWsqSt6IQNqEjPuGDbTvaIfItVOJdWYM3r3V6V1O3DoNYs+vMTIy4kIpA9a1Okjx5jTxkphBGelVFRREKffNCweBTf6Mkq5ty2iwwmcuMp6wElCPKcw1H9u+jpSPp56plnIQc2wLy7XGxQ0lBeJuO6fiWrSs2wsYWMbYFEBB4Vq9092nXZmBS+OgaTublPPJaTUqP74tlHX0uJrKUakgf63qRtwsnGwjHuqfq1qxh8ukzCxXKcdR88Rjsrq4PTG/H43HiezUd4XIsCD//q7WHLBcSkZ5ProWDtq7zS2V2I2gZNjVBXt9XQjvBl1YVMfPDcjuWUJ+YVchAWsBOZxX098GQCmi1DqLgnntxrSTppxeNFqFs8nnuEbb/fZuZNHQIeVWHyMYr3Ogt1cgOMwkKtJvjDd0Ii2ykkvMrMSg+3PvV1EQDgslYwoxjJ0
X-Exchange-RoutingPolicyChecked:
	0xRV6gVadKBmXt/OTO1AQeFxRWIW32ra8mQ2oxkcWlemtd2ezp5Nry2bwoD/ibxDTVrmeWA2UcTtUPsDjs6geyw7bBCHWeMdocay5wVJ018KDrfxfqn0SodxvELQ5heWZMx81811CVZlJ/TD7KDFMy3UPPnle6WDW2fSvD+7kCl+1JGjduXoEHW4jqxTDEHnrzG55y0hF9Jtm7NbkO7jIZO1wS6wGait9TDKJ/YQOUyFy29oMLH5mV3N/yYGwEeAdDur7T+uTQWvNxc9nDxK3wPls7yL0CNd1MR1AcrMVgFy8BSG2jaE5kSsoOttWfDRmptvZ/Ysx4qe/w0KOD0TGg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:11:47.2312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6256f1f-8bb0-468c-a1f0-08df18036b39
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6517
X-Proofpoint-ORIG-GUID: 1nTHXUIAaLvkChp4hzu2TlA605_io9Jd
X-Proofpoint-GUID: 1nTHXUIAaLvkChp4hzu2TlA605_io9Jd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI1MSBTYWx0ZWRfX+UtcuwPHyLR0
 bLNrxUHxTenxxwcsSkaJpC8EwIYjzEgFNuYowWkRwxsZaz4nOoasTucm43IN5kwrhxA2FUc74/o
 Bi8jke9rp7s2bWCINnDSElUI7tcqR5TkNe1KNzG0yVhTT2CIBmd0cSUJOkh5THq3vPWa6kxhsL+
 F+d4A9CaWm74ym2j4SRMXZP7m+eboaMTkqm9iQfgAUGVfF/Lw8LfDCNrtqZhveHH810fmXVN6rn
 zYo+EVuRqi9WtYyYgqVOo5m23pSZJK7/K00VQDZjLvEcSTJ5iETe3PVTQByuqqABs/Dxiye8My5
 tHCSbR0Z1NGIXfdszixLtycDSxTl788iHi6gcman5zUQsDpWwmkYfGPHzfHayEgsIteaylppRCk
 EWDcfomLkjd9eMR6BBxLs7SPGicg+EyK0UpLtH/UIOrkBqx3bw/XVRCRZHqEd+zjNryZddaEY3v
 HG5K+BxN4pwjRc4t2Eg==
X-Authority-Analysis: v=2.4 cv=bpDZl0ai c=1 sm=1 tr=0 ts=6ab165dd cx=c_pps
 a=hhtN0wN0XYjGptQO8Yv39Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=KxUmQjL12Svw3x4mmEMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI1MSBTYWx0ZWRfX7FTYJVqYM7uq
 IxeXpz8/tg0KG0v82I5xnmRfL1CEu3MPRR9aGOI+V0wX9NKssl5uvBeoovTs++d6GlNfmNiSB4T
 nzILwd53ST88diY2RYCN8rXdrRlnxO8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210251


On 21/09/26 16:41, Mika Westerberg wrote:
> Hi,
>
> On Sat, Sep 19, 2026 at 02:36:07PM +0530, Aniket Limaye wrote:
>> Every DW_IC_* register offset and CON-register bit position is currently
>> baked in as a compile-time constant, which only works while there is a
>> single register layout. Introduce a logical register-ID enum (enum
>> dw_i2c_reg_idx) plus a per-variant offset table (dev->regs[]) and a
>> per-variant CON-register bit-layout descriptor (dev->con_bits), selected
>> at probe time via the new i2c_dw_select_variant().
>>
>> Replace every direct DW_IC_* offset/bit-position reference with a lookup
>> through dev->regs[]/dev->con_bits. Also fold the read-to-clear
>> interrupt-acknowledgment pattern into a new i2c_dw_ack_intr() helper,
>> driven by a per-variant dev->intr_clr[] table.
>>
>> Only one variant exists at this point (DW_apb_i2c), so this is a
>> mechanical, behavior-preserving change: the values in
>> dw_i2c_reg_offsets[] and dw_i2c_con_bits match the DW_IC_* macros
>> exactly. It lays the groundwork for adding a second register layout
>> (DWC_i2c) without duplicating the whole driver.
>>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-amdisp.c  |   1 +
>>   drivers/i2c/busses/i2c-designware-common.c  | 158 ++++++++++++++++++++++------
>>   drivers/i2c/busses/i2c-designware-core.h    | 108 ++++++++++++++++++-
>>   drivers/i2c/busses/i2c-designware-master.c  | 125 +++++++++++-----------
>>   drivers/i2c/busses/i2c-designware-pcidrv.c  |   2 +
>>   drivers/i2c/busses/i2c-designware-platdrv.c |   2 +
>>   drivers/i2c/busses/i2c-designware-slave.c   |  42 ++++----
>>   7 files changed, 318 insertions(+), 120 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
>> index 9f0ec0fae6f2..f7aa075c9977 100644
>> --- a/drivers/i2c/busses/i2c-designware-amdisp.c
>> +++ b/drivers/i2c/busses/i2c-designware-amdisp.c
>> @@ -46,6 +46,7 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
>>   	isp_i2c_dev->flags |= ACCESS_POLLING;
>>   	platform_set_drvdata(pdev, isp_i2c_dev);
>>   
>> +	i2c_dw_select_variant(isp_i2c_dev);
>>   	isp_i2c_dev->base = devm_platform_ioremap_resource(pdev, 0);
>>   	if (IS_ERR(isp_i2c_dev->base))
>>   		return dev_err_probe(&pdev->dev, PTR_ERR(isp_i2c_dev->base),
>> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
>> index a1eca6cd4b75..a21aeb7f415a 100644
>> --- a/drivers/i2c/busses/i2c-designware-common.c
>> +++ b/drivers/i2c/busses/i2c-designware-common.c
>> @@ -72,6 +72,95 @@ static const char *const abort_sources[] = {
>>   		"incorrect slave-transmitter mode configuration",
>>   };
>>   
>> +/* "snps,designware-i2c" flat register layout */
>> +static const u32 dw_i2c_reg_offsets[DW_REG_IDX_MAX] = {
>> +	[DW_REG_IDX_CON]			= DW_IC_CON,
>> +	[DW_REG_IDX_TAR]			= DW_IC_TAR,
>> +	[DW_REG_IDX_SAR]			= DW_IC_SAR,
>> +	[DW_REG_IDX_DATA_CMD]		= DW_IC_DATA_CMD,
>> +	[DW_REG_IDX_SS_SCL_HCNT]		= DW_IC_SS_SCL_HCNT,
>> +	[DW_REG_IDX_SS_SCL_LCNT]		= DW_IC_SS_SCL_LCNT,
>> +	[DW_REG_IDX_FS_SCL_HCNT]		= DW_IC_FS_SCL_HCNT,
>> +	[DW_REG_IDX_FS_SCL_LCNT]		= DW_IC_FS_SCL_LCNT,
>> +	[DW_REG_IDX_HS_SCL_HCNT]		= DW_IC_HS_SCL_HCNT,
>> +	[DW_REG_IDX_HS_SCL_LCNT]		= DW_IC_HS_SCL_LCNT,
>> +	[DW_REG_IDX_INTR_STAT]		= DW_IC_INTR_STAT,
>> +	[DW_REG_IDX_INTR_MASK]		= DW_IC_INTR_MASK,
>> +	[DW_REG_IDX_RAW_INTR_STAT]		= DW_IC_RAW_INTR_STAT,
>> +	[DW_REG_IDX_RX_TL]			= DW_IC_RX_TL,
>> +	[DW_REG_IDX_TX_TL]			= DW_IC_TX_TL,
>> +	[DW_REG_IDX_CLR_INTR]		= DW_IC_CLR_INTR,
>> +	[DW_REG_IDX_CLR_RX_UNDER]		= DW_IC_CLR_RX_UNDER,
>> +	[DW_REG_IDX_CLR_RX_OVER]		= DW_IC_CLR_RX_OVER,
>> +	[DW_REG_IDX_CLR_TX_OVER]		= DW_IC_CLR_TX_OVER,
>> +	[DW_REG_IDX_CLR_RD_REQ]		= DW_IC_CLR_RD_REQ,
>> +	[DW_REG_IDX_CLR_TX_ABRT]		= DW_IC_CLR_TX_ABRT,
>> +	[DW_REG_IDX_CLR_RX_DONE]		= DW_IC_CLR_RX_DONE,
>> +	[DW_REG_IDX_CLR_ACTIVITY]		= DW_IC_CLR_ACTIVITY,
>> +	[DW_REG_IDX_CLR_STOP_DET]		= DW_IC_CLR_STOP_DET,
>> +	[DW_REG_IDX_CLR_START_DET]		= DW_IC_CLR_START_DET,
>> +	[DW_REG_IDX_CLR_GEN_CALL]		= DW_IC_CLR_GEN_CALL,
>> +	[DW_REG_IDX_ENABLE]			= DW_IC_ENABLE,
>> +	[DW_REG_IDX_STATUS]			= DW_IC_STATUS,
>> +	[DW_REG_IDX_TXFLR]			= DW_IC_TXFLR,
>> +	[DW_REG_IDX_RXFLR]			= DW_IC_RXFLR,
>> +	[DW_REG_IDX_SDA_HOLD]		= DW_IC_SDA_HOLD,
>> +	[DW_REG_IDX_TX_ABRT_SOURCE]		= DW_IC_TX_ABRT_SOURCE,
>> +	[DW_REG_IDX_ENABLE_STATUS]		= DW_IC_ENABLE_STATUS,
>> +	[DW_REG_IDX_SMBUS_INTR_MASK]	= DW_IC_SMBUS_INTR_MASK,
>> +	[DW_REG_IDX_COMP_PARAM_1]		= DW_IC_COMP_PARAM_1,
>> +	[DW_REG_IDX_COMP_VERSION]		= DW_IC_COMP_VERSION,
>> +	[DW_REG_IDX_COMP_TYPE]		= DW_IC_COMP_TYPE,
>> +};
>> +
>> +static const struct dw_i2c_con_bits dw_i2c_con_bits = {
>> +	.master			= DW_IC_CON_MASTER,
>> +	.speed_std		= DW_IC_CON_SPEED_STD,
>> +	.speed_fast		= DW_IC_CON_SPEED_FAST,
>> +	.speed_high		= DW_IC_CON_SPEED_HIGH,
>> +	.speed_mask		= DW_IC_CON_SPEED_MASK,
>> +	.bit10_slave		= DW_IC_CON_10BITADDR_SLAVE,
>> +	.bit10_master		= DW_IC_CON_10BITADDR_MASTER,
>> +	.restart_en		= DW_IC_CON_RESTART_EN,
>> +	.slave_disable		= DW_IC_CON_SLAVE_DISABLE,
>> +	.stop_det_ifaddressed	= DW_IC_CON_STOP_DET_IFADDRESSED,
>> +	.tx_empty_ctrl		= DW_IC_CON_TX_EMPTY_CTRL,
>> +	.rx_fifo_full_hld_ctrl	= DW_IC_CON_RX_FIFO_FULL_HLD_CTRL,
>> +	.bus_clear_ctrl		= DW_IC_CON_BUS_CLEAR_CTRL,
>> +};
>> +
>> +/* "snps,designware-i2c": dedicated read-to-clear register ID per logical interrupt */
>> +static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
>> +	[DW_INTR_IDX_ALL]       = DW_REG_IDX_CLR_INTR,
>> +	[DW_INTR_IDX_RX_UNDER]  = DW_REG_IDX_CLR_RX_UNDER,
>> +	[DW_INTR_IDX_RX_OVER]   = DW_REG_IDX_CLR_RX_OVER,
>> +	[DW_INTR_IDX_TX_OVER]   = DW_REG_IDX_CLR_TX_OVER,
>> +	[DW_INTR_IDX_RD_REQ]    = DW_REG_IDX_CLR_RD_REQ,
>> +	[DW_INTR_IDX_TX_ABRT]   = DW_REG_IDX_CLR_TX_ABRT,
>> +	[DW_INTR_IDX_RX_DONE]   = DW_REG_IDX_CLR_RX_DONE,
>> +	[DW_INTR_IDX_ACTIVITY]  = DW_REG_IDX_CLR_ACTIVITY,
>> +	[DW_INTR_IDX_STOP_DET]  = DW_REG_IDX_CLR_STOP_DET,
>> +	[DW_INTR_IDX_START_DET] = DW_REG_IDX_CLR_START_DET,
>> +	[DW_INTR_IDX_GEN_CALL]  = DW_REG_IDX_CLR_GEN_CALL,
>> +};
>> +
>> +/**
>> + * i2c_dw_select_variant() - Pick the register offset table, CON-register bit
>> + * layout and interrupt-ack mapping matching this device's IP variant
>> + * @dev: device private data
>> + *
>> + * Must be called after dev->flags has been populated from
>> + * device_get_match_data()/ACPI id data, and before any register access
>> + * (including i2c_dw_init_regmap()).
>> + */
>> +void i2c_dw_select_variant(struct dw_i2c_dev *dev)
>> +{
>> +	dev->regs = dw_i2c_reg_offsets;
>> +	dev->con_bits = &dw_i2c_con_bits;
>> +	dev->intr_clr = dw_i2c_intr_clr;
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_dw_select_variant);
>> +
>>   static int dw_reg_read(void *context, unsigned int reg, unsigned int *val)
>>   {
>>   	struct dw_i2c_dev *dev = context;
>> @@ -147,7 +236,7 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
>>   		.disable_locking = true,
>>   		.reg_read = dw_reg_read,
>>   		.reg_write = dw_reg_write,
>> -		.max_register = DW_IC_COMP_TYPE,
>> +		.max_register = dev->regs[DW_REG_IDX_COMP_TYPE],
>>   	};
>>   	u32 reg;
>>   	int ret;
>> @@ -163,7 +252,7 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	reg = readl(dev->base + DW_IC_COMP_TYPE);
>> +	reg = readl(dev->base + dev->regs[DW_REG_IDX_COMP_TYPE]);
>>   	i2c_dw_release_lock(dev);
>>   
>>   	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU)
>> @@ -365,17 +454,17 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
>>   {
>>   	switch (mode) {
>>   	case DW_IC_MASTER:
>> -		regmap_write(dev->map, DW_IC_TX_TL, dev->tx_fifo_depth / 2);
>> -		regmap_write(dev->map, DW_IC_RX_TL, 0);
>> -		regmap_write(dev->map, DW_IC_CON, dev->master_cfg);
>> +		regmap_write(dev->map, dev->regs[DW_REG_IDX_TX_TL], dev->tx_fifo_depth / 2);
>> +		regmap_write(dev->map, dev->regs[DW_REG_IDX_RX_TL], 0);
>> +		regmap_write(dev->map, dev->regs[DW_REG_IDX_CON], dev->master_cfg);
> Instead of all this. Can't you do this inside the regmap so that here and
> elsewhere in the driver we continue to do:
>
> 	regmap_write(dev->map, DW_IC_RX_TL, 0);
>
> but internally, depending on the hardware it then maps this into the
> corresponding register offset.

Yeah that's definitely cleaner... will do in v2.

Thanks,
Aniket


