Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92EF4AC147;
	Mon, 21 Sep 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011598; cv=fail; b=ij6ZQ/fR3glmZ330rDpPtz0qGtCJdaMVeU7AM8OXOIbab1PjIddNEVmaXpYQoLuKa7fVAGDAX63vdDQDA5jJQOzjr3GU51g8Afwk5qxEXVVoY6gnI1RUXPGd8gqV0VXfPcjYORTk2JvpthBz+ie2GMtgsMtonFnkq0XB9Ik12QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011598; c=relaxed/simple;
	bh=YMajas4f7E5yacDqp9FtXHY1iCS351h73/vvca6RDWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QMr9VDC73BsiN9SIUtMRcPFvx0nYkAkQXzJ7wMVQ2l/KNO1Xls39QU5Qcao87Tba4uszmKNP/xjlsM4qRZB1P/3pLg4cXpg0rLJYlTElW3q8oyHsZe8Efr8er/cSIc8wU2YJN7YL6358F4PfqqA4KiA09sW0hxw6Fu9xpHwI+pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=KAZUcYaP; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bM1ZCJ34; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="KAZUcYaP";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bM1ZCJ34"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LGuQ8E4140769;
	Mon, 21 Sep 2026 12:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=jfcvuthxvH4Z98S4p8Wx/dCIUx3Zk3qrG3HR25Vi1
	4I=; b=KAZUcYaP0HWXPZ6H0ib+MBtb34yecX+CnN8GPUesgoArIrGER83C2mf8k
	T38s/pjC5Tls/7AvmsfFHDYhaKlo/xA3P8RRRlJGXpmLKVTKdaqeEuOsQwAwhj6f
	fvOySPNz29EN8w5ssfOl94qc9uLnASIvUQOQfrB9SHHScEVjmQ8SgXkfQIwbedrF
	9vN7N1nAb+F+VPGc5AI9lRoTaXmSI87ZIduvBz3hnQOhuZesyUy7MfhSGLBjRJHL
	qqZl2/hvDq9V03IKeEx6PbsrkvmpJE6U9pb2miZ/h/D3d2K/8Pvyouy6n9yAcfmg
	Z3gDe6c9IuwHczw16jnCpsDFkIMzQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gtx9fc2qs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:26:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNNr6UClZmOgFlV8ftv4pT90XK12aA4yfeXS6yKzp6Ufr8MK0spfO6T21RtRjyx0vDxe3iz6hd9F3GxN4peuPjj7kT2BsYhv7jKWFisgYveGDJHPaIqe/LM7k+2Nn/1dki2cxyvU3yZO7IvjDpToyLqb8vYa5/RqXJpdWZXiFnD/fYwadMJWbCo2qpYDoEi2A5wqFEKdrURvHOKIa0tJpcbngbcxtQqqMs1yfaXnDu5UVGKA1/iTrK5S7F7OVraOfbFfIukbTMamoneGaHC8zFmgR/IYyadxvAfyy2OnjR6/jI6wavpTtUgK6ly51Mnsr6onjMY/gRUDovrfQAO20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfcvuthxvH4Z98S4p8Wx/dCIUx3Zk3qrG3HR25Vi14I=;
 b=YG8/AVlCYFAty9BjsIaAlQfrYPyjtQLtLpkf4Yw2/+2dDHg6jdvf4iihuPO+Kujnisv8levAuQemrKHBCQ770R25aWiZF0GTT9xnbGMeBfRpp+B9E3+9C+Wq4aHmWYfTWkgu/MG7wfUVE+rHZ2k7NtqkSL6eKCFmuFddPwqlJKhUiIX7OaC8pVvNTT+7tvjON5GSup4wqA1zq9Op0Sn6Ybpot/OerNCrganuIVIZD+npuCSsIW7fEaWVxyMEjWJBExqvK7XioxeVvCNLL1c33sllbiGr2ErC4nKOfDtHYj6fCiHpHgIImzDGUZJWa2//gdBj3tEBHu2/UfqTHQsISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=arm.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfcvuthxvH4Z98S4p8Wx/dCIUx3Zk3qrG3HR25Vi14I=;
 b=bM1ZCJ34QhJ6+psN9JxKkOUYGCAYNJ1lyKUH8Ad16gDtf2xnFX4rfzX+XiihtqJM/Wyg37PL1vsa+eBHA2dIW1oQWXA3AGSkhr7/fZ5apZbcf9qyntLmylN2fB+CUDNx3R0hJS4WBeAC3mwzpdpbyoRc/WUUWW7Umi2iwBREAKE=
Received: from BN9PR03CA0304.namprd03.prod.outlook.com (2603:10b6:408:112::9)
 by PH0PR10MB5625.namprd10.prod.outlook.com (2603:10b6:510:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 17:26:17 +0000
Received: from BN6PEPF00000072.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::35) by BN9PR03CA0304.outlook.office365.com
 (2603:10b6:408:112::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 17:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN6PEPF00000072.mail.protection.outlook.com (10.167.248.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 17:26:15 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 12:25:40 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 12:25:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 21 Sep 2026 12:25:39 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68LHPZ6o2501058;
	Mon, 21 Sep 2026 12:25:35 -0500
Message-ID: <203f72c8-4a06-41d4-9212-9625f6be0281@ti.com>
Date: Mon, 21 Sep 2026 22:55:34 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: i2c: dw: Add DWC_i2c compatible
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>
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
 <20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com>
 <20260920-warm-lurking-poodle-dd73ee@quoll>
 <de66ac18-6bc3-4693-bd76-df8113bdb914@ti.com>
 <20260921111407.GU106095@black.igk.intel.com>
 <6fa3b1a7-33bb-4619-a0a5-42d99c076d2f@kernel.org>
 <20260921141031.GX106095@black.igk.intel.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20260921141031.GX106095@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000072:EE_|PH0PR10MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 019ead43-b8e9-42a6-55b4-08df180570f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|7416014|376014|82310400026|10067099003|18002099003|22082099003|56012099006|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	gvNmLDx2HWzwhvW53Z+HSaHRBP/l1UnSX5lz14rPZ51I99yROTs/eV2WjjaHRffqtvxQq2bBfW91zH3Rsi4BfDpy9ef7vQ5+rXRb6vPq5NIfvN/zbCi2+0oE8AmHRrj1HTPSvX9cMs+7z89P/KAEdIb7ACy+gtS8BEaLn77wHb9b20RCJ+9ASl0fPZzv0UDIHhc3MU87yEefryjwzhebWIv55sErGae5p1hVu6Zq8wxzfbQCzwaoydXqgv62jOBxXrddheDDDCemJrcpqRBxlthvE7pDs/tyM9/S6UMkngkX8k0eVoWgwVEj+edy3Pm5b3QCnlxe5NlMbv2rB+aQpU+YOBJ31ZzyoVsCtq5iwjXtw6KMmIXVeBkHjpNFvZv+EruURd9bQ21Eea3prfodUz95u8G7Bptfxhx7ht+oSw5lO6QXzG581fZm2YBWZzRxoxgnTqSY/DXvAzNclfTFqmWXMO2NwUMMhmCuJgR7wE0p/b1MKg5IyGcRG028Xuv5/A2cxuyprB2jiDXrk/q3OmMNRUG44Ftc3zI3EMFVuIhxYbBuz4NxZ3r8pDwYJ5Rff8ihzoPPQZiKxs7pEfMj21FQnOiBp5+hdKtQqgcOhYvZuHiKsgtMWA0Lk3eqVMjlBVyMmi+qXxs2be20b1T42Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(7416014)(376014)(82310400026)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f3bYzpy7EcbWBKtHCa+dozTlAkAtSPd2Ribw6BNTD/LnRVtCni8El2Y7Vgy0Bh+G5ihOLc0nzGeSJwWopxBvmRXtwXKVsPaBjynsh0wUmKICrWdJZOHf3FHwfQ0XlLJGc9aDD4taOytqsuo/T8tdktphBexOlIo/sEkNcIpLtGIGjgoIHjDIJoYYlWjPUqIor4zA+i9K+J5USqi0+fpoNHrd8lq2n7Y8j795T96xa/dgNtW8luFPmXeihU2oAxOD9aqknY7/T8fFdw2yHKJQdUhCB9HlsdRSWEY0SkY6tzOuSf+7ZejImHh9QH/r/6KEglvL7FSdCl3AYgtMe95QavRHZrG+TONsPWa64TZirXZppHwuI9MKIrAgv5Hck/biv9PFDsi2AhzkpEgD3ihKo3wvfugOjWrPgbFOiq8u9F21TIpqvRcpnSNlWDM2J0IQ
X-Exchange-RoutingPolicyChecked:
	MLCAjeiYE9apBvDg4j23vwd6Hrror30bv/sRbMs/3ZPUB5w94LU3wc12L4MSqrWi8RbT9/6ow6oFaosPVwlAZXuWuP4ub7RTofa1G0oftUK9x3jeF9m99ltoecHw1OAzkYwmCD0WeI2M3ll1VSulGTAQaWfl2If2P5KO9Z12wQe6woUSRud/0CElfxPZ3NHfF/6KKADN1IzeVRhF3r+9VDSQaFLnmifdtYpEBsbj2i/ISeSj33TkzpQ/cZUFWROsA8yxdt1hs7XOdyBWJb1svdJ8tjsT5H9VewDyAQ3CCi5MCr2PBi+nbU/JBInHcj5BqA56m21uQmMe6WN9v7cW9Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:26:15.7827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 019ead43-b8e9-42a6-55b4-08df180570f6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5625
X-Authority-Analysis: v=2.4 cv=Vou2kO2n c=1 sm=1 tr=0 ts=6ab168bf cx=c_pps
 a=nhquEFRPp8Cuo1IKRjcF3Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=Bq6zwJu1AAAA:8
 a=2yce866yz_KQTb3LiikA:9 a=QEXdDO2ut3YA:10 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI1NSBTYWx0ZWRfX81IcpdzCrXCD
 BiSH3kgfIty8aOh6VrBvHP/k6r6YHhnRCPUuTPLlLxvROI76arp1yguVw9qfy8yfem052AmfRLM
 IbMY2iMh9jHLhlSpWroqn8IFMwykn/vmQzD3CkK1RqxPGWtgQQzzEF1IYejZGZnyO4jnsDoiZ+B
 GszF36uFIRIaWvj2dz3UtQdNu2VArwCXj+bvJeFQr8bCkwZuBtWd7GaAH9+Rnv25uWXCpM8BakL
 oKpKeSmCaPFYYiRldvO3GSfC5Dh18g/Lixm1WQnYA8uim7+Xeb6+Hqi0L6VQNYHS6xXw8eAL6Kj
 e2zqMoNer6L8JQweNaw0wk7J12FjVBuXMoiMgPTJ98OBsDAhXblHRglC2VVU65dGKsQXetp4T/Z
 GGCJ56Q1d863vgSrf+sQcQiYgbNhvVMe9xgnhtk0A4vxTp41itvNSpgPpPWtMd0k7l1GNjvbJvy
 h5e6+Zc7iLG3j/sdueg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI1NSBTYWx0ZWRfX3nXUHTbgtWvM
 DuZ7t89nDqiYF/YkAvClCaSD2xTr7WcB5I04UlIrw+wjmbIyd/hCkxWVYV1Gz3++/Nv7fwwRJvc
 Qiwyf9mqoVvmLAIyMR0EwezQuSD/xgI=
X-Proofpoint-ORIG-GUID: Up4hpFgA_cOfNaWFZJnAXjbXV3ReCiVo
X-Proofpoint-GUID: Up4hpFgA_cOfNaWFZJnAXjbXV3ReCiVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210255


On 21/09/26 19:40, Mika Westerberg wrote:
> On Mon, Sep 21, 2026 at 04:00:52PM +0200, Krzysztof Kozlowski wrote:
>> On 21/09/2026 13:14, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Mon, Sep 21, 2026 at 01:55:23PM +0530, Aniket Limaye wrote:
>>>> On 20/09/26 23:54, Krzysztof Kozlowski wrote:
>>>>> On Sat, Sep 19, 2026 at 02:36:06PM +0530, Aniket Limaye wrote:
>>>>>> Add the "snps,dwc-i2c" compatible for Synopsys Advanced I2C Controller
>>>>>> referred as DWC_i2c. Compared to the existing "snps,designware-i2c"
>>>>> dwc is designware, so snps,dwc-i2c = snps,designware-i2c
>>>>>
>>>>> I think this is *the* argument why generic compatibles are wrong.
>>>> These are 2 different controllers with some different registers and
>>>> vastly different register offsets.
>>>>
>>>> So, the official product name (short format) for the SNPS Advanced I2C
>>>> controller is "DWC_i2c", as per SNPS' own reference document [0].
>>>> Whereas the original "snps,designware-i2c" corresponds to the product
>>>> name "DW_apb_i2c" as per its own databook [1].
>>>>
>>>> So based on this I though it'd be best to keep "dwc-i2c" close to SNPS'
>>>> own naming, despite the fact that it does seem very similar to the
>>>> generic "snps,designware-i2c".
>>>>
>>>> If you'd prefer to make it more explicit, I could change this to something
>>>> like "snps,dwc-adv-i2c"? Although, again, this does deviate from the
>>>> convention that SNPS uses in it's own documents.
>>> What about just "snps,ai2c" or "snps,advanced-i2c"?
>> Can we just drop generic compatible completely instead? The block cannot
>> work alone, needs SoC integration.
> Works for me.

Original intent was to try to develop a generic driver so that it could be
re-used by other SoCs with some more work (referring to an earlier 
series [0])

To make sure I understand you guys, you prefer TDA54 SoC based compatible
since the driver itself currently has TDA54 based offsets?

[0]: 
https://lore.kernel.org/all/20260527085039.44435-1-lianfeng.ouyang@starfivetech.com/

Thanks,
Aniket

