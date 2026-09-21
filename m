Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F637AA95;
	Mon, 21 Sep 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979173; cv=fail; b=VziaLb1HxR0050JU2qtJgSZKvKeKBl0uToM8vB3VypgwJK6CAp/C+dvSPviLop/ZHUijsHLQM6FuFIXiTCuq7+koFFdxlnNNDg+bY0lNv66G9XKH8i1NfEi05apXSAQ6NBLzuUaaECKtRTuNwMlzBtNTjuyJSH7GNpojR8mVDKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979173; c=relaxed/simple;
	bh=xy9zpBEw58ysTe5sYJnzsyOSGz+T4Tzm4B9l9Ekl5mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UVvxMvmJAgqhVjK9w1bQHlkbuF8wRvG7kscyUuL5J+YK7/VSGZk3oBphJFLtG7B2PpWutSgyIbDDWRuRnqeC8jSzbrXkPyUeiCojJuzUjZNyPBmzX77oV5DXwgG9w5fjxFcyc5ENYcEHbrBGRg2takfbjV/VMQhlEbvwbeLI0vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=O63v9xTJ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QVjgebaR; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="O63v9xTJ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QVjgebaR"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7AxHa3481772;
	Mon, 21 Sep 2026 03:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=xy9zpBEw58ysTe5sYJnzsyOSGz+T4Tzm4B9l9Ekl5
	mI=; b=O63v9xTJbMCRP7JCOVwfT69GPJxP1Q9Fuo+BwE+iqXLml9tsJN0JQaoq2
	OIqqJuUsTK4wuJtSjooy2i1UIZ1zw9DEtuKaF6/6TNgvaMSojidfCLIyiWhhAl2w
	sltIPnuuzMQ2m/NiiGL8tGfIzTMn07ME4uuhOUbfFgNfbs1yEGYabR++6DgfzfqH
	Jx/NR8JYPnGR71bEtsHXXcrYXJXafowBbwSr6QcRGA35FLE2GkYAooK4/GMMIGuS
	CI7vv+tM02JiJNQgb5CjQSa3qJ6u9+PZMCVpPBHTp0gPcou1PDds0mqD/zCAuxuR
	cCUkcP2vHGGwDg/xEzTBinugTF1Fw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gt9s5nq5m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 03:25:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6lM04FH26SfDSLZX88vrui7HcUb8172dXp+n94ogvx1KTgHKrMUuPs+hV7uR+33MMpbhhMhxMAn6pcJOn4IHD6kMAcIwSZxuSlOE+MnxXq8ha4uQSY2HqNIcOPdIpaaH+lZK2NG2qLGk5BnYw2ICaegVXYlKmjHx3F5y/k7X/dUd9ijwqxU130ajZjJFhkLVX95UJX62iSKFrzG8kxQnzaNOfFuSWGioNjLe03MrgxRDne0IhM1wPgPXLCuDAGxSFq8MoJ06p8lbCTbtvEI14TWbYB9HASpSoF1l1hUyobg6ujQ7tmwi59+QE+8i96OsOYa0lZEwoBHQ0nkExp5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xy9zpBEw58ysTe5sYJnzsyOSGz+T4Tzm4B9l9Ekl5mI=;
 b=psDOzQYUgkdy/YjiMoTPxvNRL+44BBVN4N9rrpR3dacLr3GoV4884XOMA/lxK9MSHr4e/Ru5Ae4O7/lLFYU3qzGq6KjEPXjP2RO8qwEuY2vXLxzrtXrEllwjbxtRBusLWETmsWcdbZtQHfAyQcrK9WMYILtxU+Gg+cqGCoFCd6rJ8Kr9cIDqk4Pvu+yMuDs1oc9ZGbZwqPY1vGOR7Y5y67XQnparfKTBIKxz5WOPxLfsN+UNldivdYjCoYz6kbo3k6R82dj2VLhH8KzJWeufa/uxlA/TrMMKaZSm63usr1DJLGJ7z9w8KtSiZ6CFtmfAEOac2HYbRsTcb/Z8s6ZhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=arm.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy9zpBEw58ysTe5sYJnzsyOSGz+T4Tzm4B9l9Ekl5mI=;
 b=QVjgebaRNbWlk2yPk8p7jr1aNO2nJhaKWy1bj52NpBwRoGWMHFHLBuKrQzXViT0sA/Gc7DRKK9mGdcMKLQGSOGUmKnfkHFDHZT7OnH0lzw4kSWE6r8BSLKkaLnlIvhvnBYd6ojYHiN+63W8Fha4HSxcZyRKqH5G3X8Dg0oK96Uo=
Received: from MW4PR03CA0079.namprd03.prod.outlook.com (2603:10b6:303:b6::24)
 by DS7PR10MB5024.namprd10.prod.outlook.com (2603:10b6:5:3a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Mon, 21 Sep
 2026 08:25:46 +0000
Received: from MWH0EPF000C618F.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::6a) by MW4PR03CA0079.outlook.office365.com
 (2603:10b6:303:b6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 08:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C618F.mail.protection.outlook.com (10.167.249.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 08:25:45 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 03:25:29 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 03:25:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 21 Sep 2026 03:25:29 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68L8PO0K1673871;
	Mon, 21 Sep 2026 03:25:24 -0500
Message-ID: <de66ac18-6bc3-4693-bd76-df8113bdb914@ti.com>
Date: Mon, 21 Sep 2026 13:55:23 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: i2c: dw: Add DWC_i2c compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nirujogi Pratap
	<pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <u-kumar1@ti.com>, <lianfeng.ouyang@starfivetech.com>,
        <Ritwick.Sharma@arm.com>
References: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
 <20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com>
 <20260920-warm-lurking-poodle-dd73ee@quoll>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20260920-warm-lurking-poodle-dd73ee@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618F:EE_|DS7PR10MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1ddb72-aaf5-40c1-2b92-08df17b9ef47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|56012099006|22082099003|10067099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	668XgPFfEJf9uepPeYDSX4p0PKzoEZLJmC8e5J0Ase59XWVd/IWgPZrDm+wS4nIPpWYN4Gak5T+biNigo62q2acCpHFaNVoiciUex0voWRcbEcDXP5YTLZ8xPswIjVU9p66thSVuZ8ZjVnWYGuv/CTccuFe4Q1XrwCS+6dtKJ2XuPE1DdR9c6VXP7gylDnBaWOHvzhMTGa5H3mkRYlQEf6wImkz72DTllOFj71SLcBfIW7919Cu9CIMpPa3f2NSSWPlvMxrzvPxCGZvHgxHKbDmEHUQgJ2QzbWnZYRgBzI337D/k4O+TRUWtW8Li+rOVKbNvXjdDa3iK44ddhI2yGEv/8nIFn9bzdNv46UETpNJOCpDwJjwEn+82D5LUypjWKdlk1TF9Kj2utjg4nBzkRpfBqg5b9odO58COlrbyUiCCG/qWa8JmbyHf4wlN/jIehdLZYSO1i1giF7BZ9g5OuERv9cXeSSiEebSiXgtsK89uzLsVnk6ir8C3Q7QFcPPJRBM8fgRS2MVcBwCifGq5/SDUrU9sShqlE90P8nkE2h6RAtAA8bHTH8dOyFnxhfI7I2IHKl2sZUe1on4Rjt075GzISgB188Ff0F5+ep5IVbYQ1vYfo1LFBpytdJx10xbw68l2fQ0GNDjinIL/AhWsj6DsqJIYL37iRGAjfUJR4wvwu/iAxzN1wmjkrJduefF0M8AfoEfR54rjU3B18piIMw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(56012099006)(22082099003)(10067099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fKeD0V5vzmlMWlxPS65+s6BZqeS7CVjhNXMI2NYuaNONMG4bt5MS3bg3wK1HL80lWZ7mf0HCeUGpQR6ra+Wdsl0dCwtD5knZo9x4mBQsZ6xqEaOqSwd0oNJifw+p9Z/oaMBB0V54ON9mBCRjZEEyPnoDlV8G6+S/gvZ6VI2GzdeM1lhWd8Vrg7NAO9Y8R9pQN3/jsptDRtOzRv9SUe0jVjEvnuHov9kmyCsW/o7fwruAv3K3jlUd7tRY1JsNE2ULj/mIvpHyWzI2QxGkEJwDpkhjDWvvkr08V1Z0t2IY2fyML7dtO7V2I+UXqkc8ZXaUPiDKsfbEfBA8mXl6AbClwPw094scuvTv9WXbJDVqhuACAyBvl5UGJo22SAaykNvQDjfsirOZbH/D1F8geckFWjTX9AHEWqByJg7R3am4DThguELeBnYFUZWBvDcAKl2N
X-Exchange-RoutingPolicyChecked:
	mUixhseV5dVfa6zQ9hU3l7Uu1yWEylb12WnW9utFQMIAJBOg3co0nBKO9clHwcyl10aDC81Cho+AyRrlYWniH3iK+R75Ot5H6FH3K00hpkMvhXxOqfIEWEI1LSNobIot4si5HtEA4SXe1L6G7p5m15mQmL42NRUtPsevJRRqcbHtXnKRyLvUIgii6qhlo5N0lXjDKsy/ORGgD2dZc9OpB6ws/UOLZWBd/G0MEenbd/pmtGL8spsp4xUMDA/iqxcCnJvIm2KJTmT49wWRjK9fmsIAJddTEDVs0JTbkl6OEkrnBLjBOTXwvLRiVo16qY9iY8IwZYY4oqeA8xsA9Hf49Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 08:25:45.9293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1ddb72-aaf5-40c1-2b92-08df17b9ef47
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5024
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMCBTYWx0ZWRfX1a7t/IFnV+3b
 nHJUPDwSJORvo+jJkfB/QLhP7x8ku/gU7zYe8YNroCHtn/RxISa938hfRPRwt0WOrOK5847v0M3
 cU5frE8fiImqxM4bgNZmTdYOwnS4SXb2AUYNa/1GQbEe7zPTFiVFIYVWE0ltnGYCihci/C000si
 OYMEeptrr0BeXpXo+1dXTwnICS7c2iAbSZoBJmyrsfVpVv8QVEylRCUJjHKViZmK1SM+RsiSwxJ
 XI3Yu/05PrAUvjC85/rzID7VCUlQOPndpNEbZE8UEvwImrpyVmoYtblhgj3OAoN07VbS6X+n3cm
 LpwmrXxnaL2P7+s99HhDKr9nLNsnhTR3OyF9arNKe9ZTYI4HG0lxEiNzev2c2UjlsoOEXybn5Ex
 N7hywtHYfwr0D/Qo09/EYpekH5js3FARSi8DhllCh8+G4AwM1H7BXEp4Amh/EEhKwL01yeuM0GG
 ae+4g6sIkcv8O2PtEow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMCBTYWx0ZWRfX0uqszv88h/0L
 r7tvhfx3G0mdW5f0yktIUEESP6Ak3JbwPFcyu+I/zKOUXxpgtHwOFrHaJ3FYSOzPn/XMo5A+0e4
 LBNsMPqSu1C7p1oxZxAo1t1npQlKnI4=
X-Proofpoint-GUID: 44fKCmK0b41OnNRGxCLBbr3IGGn2y3pk
X-Proofpoint-ORIG-GUID: 44fKCmK0b41OnNRGxCLBbr3IGGn2y3pk
X-Authority-Analysis: v=2.4 cv=X6rHu2Te c=1 sm=1 tr=0 ts=6ab0ea0c cx=c_pps
 a=GTrFB3HemkLL5/X2VaS9CA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=habD29W1QCEFKxx15VkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210120


On 20/09/26 23:54, Krzysztof Kozlowski wrote:
> On Sat, Sep 19, 2026 at 02:36:06PM +0530, Aniket Limaye wrote:
>> Add the "snps,dwc-i2c" compatible for Synopsys Advanced I2C Controller
>> referred as DWC_i2c. Compared to the existing "snps,designware-i2c"
> dwc is designware, so snps,dwc-i2c = snps,designware-i2c
>
> I think this is *the* argument why generic compatibles are wrong.

These are 2 different controllers with some different registers and
vastly different register offsets.

So, the official product name (short format) for the SNPS Advanced I2C
controller is "DWC_i2c", as per SNPS' own reference document [0].
Whereas the original "snps,designware-i2c" corresponds to the product
name "DW_apb_i2c" as per its own databook [1].

So based on this I though it'd be best to keep "dwc-i2c" close to SNPS'
own naming, despite the fact that it does seem very similar to the
generic "snps,designware-i2c".

If you'd prefer to make it more explicit, I could change this to something
like "snps,dwc-adv-i2c"? Although, again, this does deviate from the
convention that SNPS uses in it's own documents.

[0]: DWC_i2c_reference.pdf
[1]: DW_apb_i2c_databook.pdf

Thanks for your review!
Aniket

>
> Best regards,
> Krzysztof
>
