Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D603F326A;
	Sat, 19 Sep 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808875; cv=fail; b=IpYQXMkrdnX0W6hyD6RiSft0Kt57vXmNSXQBUX0xllhavmW/iniqRXXxpYaTvDGJGqRj6YC26y0hSvgzP8lHrOEh7W4RZq/RVGbnfhhXIg36I3Q+WDY4qkOboGQBqSgTAPmX/Lefx7iZt4e9Imwypw8TZ8onz9Uzfy+SFXDzjoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808875; c=relaxed/simple;
	bh=MufuMbZ+peByqKk0f4JjUgw1v5GueKpaeYjwNYflSzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rbqDU8uV7bZu8Bagmz4f5Nk1SFqgo2SDhdAUM4uLKFcclor5B2qKkMyV6PpT8cg3iOK6JsuVPCJ241GKvzgH8lGQ9wLdG2I81CSx0OUgijYpsskd4PcER3azZMDCYMtNXfBOW5f3ruSV/BXRYTiAXPuDU45oFTy1K2fGbJ/PxKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=nOHDNRGu; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dbqbD6Bc; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="nOHDNRGu";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dbqbD6Bc"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J6eli22393318;
	Sat, 19 Sep 2026 04:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=LhKJbIDNVRz2ZO0y1V+6jzxGx7/73Zjwex9amVcVd
	Rw=; b=nOHDNRGuPGPBM02t+yBmXjG3qwIRIv2Y+pjKU5XxtR4IExj0Vq2WPzzVF
	tpl7Zu+KVbFYRGTRstpW6KKu3SoM1T/0GsxMyOuORdwThlXfV5nZVwA7Er2oN33m
	/3SDcAsXRqufmffu7mu7eH/J99tvgfhwH0zaEOxD2v/iXYvE8aPxzofV2tp3K8Mx
	sF5WuRao198Xs0ANWXwhyu9U1SR5AP/VxhU0hY1QGGAOQHhcLM9YvSSIxWKrX8xt
	ldJ8U+m2NbaEL95xGw0umZWBtJn+NPlgkr1zS1pD6h6a55NCL6fJ8PSneYA7Ar0e
	zn8zgOJt1yzSD1OLNKNq0gSS9wSCA==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gs0k3eg0y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 04:07:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFqaW+hXl/NZeqxVmn4IsYw1jwX2PEYehNP9V1V3c+1IEt4hhZ632k88U9sAi9mAdP5Xql0AO0IV7CbN6AXdvus/87g5uvuue2+DJQr55AHOWxlAgNRu7DJeyOb7ikYDhPlff7oPq+Mx/oEzMz+O1Vjw5G15EcTsGEknKmVgDskQr4quxwSr8VYR0Vw8nQ9Vp3V3o8zuxq5uiOB/X1zWC+WBKAMgAVjoVPPTqEdjUBSF9gs2xZAalTQgGkmlWUFTA1gHlpq3M/qJMNqmoqa9MfReotUXpUZc4vNVnTzv6jtLFDGKQW1EuytIoudZHqCUt7lgoasGPqbweIt6uWNVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhKJbIDNVRz2ZO0y1V+6jzxGx7/73Zjwex9amVcVdRw=;
 b=kyH+s1clrtLYzqMTjXHsu5ys/X/c5bcvTxNTAr8HJytxbIaFXZFMfEaZLJVRrZossDqGAszVGJMoQdxaQAEEGpnV554S6d0F2KvgCOnF6/stdWDn4BGAnHwskBA588PblUKWgGu1OSAaSLY0MhAnq4vXpbIlb++YkiL9M0D/fKyWznzFlNTK5AEsRrecVCjDfWQnAeFzD3M5pt/onsq6mbssOKyj0FoUj8Uf1ObRA0OKBS8KWgxTzWqNpP8WPZHxZQ0DghUtpp45ogbvaOuRd0UHNfZbe0oe60Gbh+K5fBMIzdboK4w3/j9LFv8d5Z13QqhmAZxNVH5R7YVGXz/I7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhKJbIDNVRz2ZO0y1V+6jzxGx7/73Zjwex9amVcVdRw=;
 b=dbqbD6BcaVUVHPTZ3vr9lC9++V6LUim2lw/z+liiwmlgUE/fMcrfAXdkgutWhQ6XaOoTiFVsHgzD6cKHrDBPfoTAg/uOCejthp32BmsQEFwJh312bujTS8/frx++La2A5X87h6ZE5i4lzwThd1US5TL5yuO+wZCR/JZHBwfvN4w=
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Sat, 19 Sep
 2026 09:06:36 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::99) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Sat,
 19 Sep 2026 09:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 19 Sep 2026 09:06:30 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 19 Sep
 2026 04:06:29 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 19 Sep
 2026 04:06:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 19 Sep 2026 04:06:29 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68J96Jme3292028;
	Sat, 19 Sep 2026 04:06:25 -0500
From: Aniket Limaye <a-limaye@ti.com>
Date: Sat, 19 Sep 2026 14:36:06 +0530
Subject: [PATCH 1/3] dt-bindings: i2c: dw: Add DWC_i2c compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com>
References: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
In-Reply-To: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nirujogi Pratap
	<pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <u-kumar1@ti.com>, <lianfeng.ouyang@starfivetech.com>,
        Aniket Limaye
	<a-limaye@ti.com>, <Ritwick.Sharma@arm.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|BY5PR10MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: abff2401-d884-411f-5809-08df162d4ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|1800799024|376014|56012099006|3023799007|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	14hjbnb6c2d3TD7A705SWN45fsD4kAXl04euxZGk+dB6wLJzV2/btF6kLP8S5kGwCahpPOKbfd+WWRmq0c0sKBDMDpCPrsOXifkruFI1DOgNXKhF6Amtg6HkafBpBpPxyxiN0jVedJi8ORVtk5Ox86Pw5lXFFZCKLjltCihnTBJBMIhdtbXqc+fkwVsjn4VPSZS47brBAbfGPeLA42+MHr7WlG6nJamSPsdlfqyWgi//t3OAWiRxWll1i9Jy2FnO2i92CLpkTj2jSGuq0yJ8gON53FTjzhMlR2augMHultRlGS+m5L/UqtaQ5rzY4dSyooqB9iJZE/w638Ft/XthwxrLpbRuThM/fNXcZepcjY2pSBZNoZDNuV7cyrSWCUFx7hExYKoZxvooQ0sYhzmm/DQPDiyiVKcKbhCc2V0ueVCW02PAss1S5L7793mBFpJC1JpBqwkNedXt4ZWQejlb4ld/kd42YBQ1An7c/atst0KTFkg1Gc2z0TX9mr3fZS2Dp+3FIREGQUOnT9IBnbY0a7e/iacfYg7OXNKqfWBe+vb1/Ffrvk42Zygf0OSDh1tNOXGWXJ6IicJlEWJmZsxWFdpC76lvfmc709hZUN1591kFrolySU/jm3K+aIhkS/tqy7F9ANakWZIX5a4oEbbfOkR+nUMIdfu81iBfMPx3GLtH51ulFvTPfsRLRN/ZqvYx+wELM3lroKxY68qN8LxFTA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(1800799024)(376014)(56012099006)(3023799007)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nQkhhwdpQJnzR68m+HeuSCaAHd9bD4Thjzd2QKJ1iix30TRz9zpX00oQPYmUMmpOVc8n92CyTkZ3Oe4Sf56Zrjd8f1TGyct39LKMcQrb1rAiaQnsLnTS14puPDJs7f2XBOHbJmTWGIFsHoGrjgLl+IG9vpQe92xxCTfzByLEYEN6LgFi+G5MRrBWM6UXQggFbhGgtKmKXmrv8WhgUVmEOqe1CWx/FMyarDP5TJc67roXocp2sh9P8VCObEar8ejCxP/h/WntDkjuXUrw0P16DBVCHZ6Zb+8Tg4stDaeUHMedXQrkpt12z9wqZzx7bgqSbafzO868fLvVHbQZwBxFDCXwdfAPhGXawgUgUaIgXbkyMEUEsZH0l/lJxFpo+FxlEJz+CwSTvZAbYBj1cmWK/0DhKtbebUzA9qhKadImXkLbOucIvjJam+ngxyAtAuz8
X-Exchange-RoutingPolicyChecked:
	QO8IKQKmfCJaITUpw1fonhXd+4x/lC6U39CuZOFEX9uqeD6QYXJxzuVvOUtzUKhp5gernFFOnnPlgKGEFgDHzY0rDWJ1zXEWgrD3RvhJXV+7WBdeNgNm8hxtAo7VDbHsMM8U+8h+7Lg+Da1AsbzXvDqZU5U0lhAkVQriHb9Qh0265xAsJspCXIkElC0w3qJZsDgyHNGQKzvBbA5mfgyyxjIauzS5YxycpABZrY0k3FkHBaPInRKVgU087hGA254jL4SzbLBcZClFmMts1DbDcAi7Ru6RC//5DkSiTiyaOkgPoIpQMuqfg1L8vmnkZ/tvXOc9frPeDuC3ZZF5ufURIg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 09:06:30.7219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abff2401-d884-411f-5809-08df162d4ba3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDEzMCBTYWx0ZWRfX4xlwXtW06Qsc
 hTyRuYoQ6NRK3mRlpJ5tGraP8ragNhjjinAjYlyJF8XabNxYVDF3ML13vDfKOBHf7lujgJocO7X
 Hc8+M4IC80APlBfd7L1i51tlaTIsI/U=
X-Authority-Analysis: v=2.4 cv=K6S3jCWI c=1 sm=1 tr=0 ts=6aae50d5 cx=c_pps
 a=UdDD+omNl1Ext3Jod4IcCg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=uZk1cXSUN_pWDuckaD8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDEzMCBTYWx0ZWRfXwxJvRSckrEEZ
 BuBucA3TP03UuRYxofd9lMxYKyFc8laQyboaibPe1ikEUfcPKkEB2pyALYoFQYZ91vC7IHXgVjv
 a02j0l/5z2aj4Sh0Vq5OOAv0kd41Hl0AE+nuqhkSRItHj/GNJD17rdEM776udzXoTlBt850fG2Q
 VRRRzjKvCxI3QpUDDuUrw5ewNS2uBfMTTX2XPaGLxxBOJo1F58jiI7abgl3Ox8+5C+ad0CTDxsB
 bUlwl/fhZXv6kLvNV/En4Fo9CxVe3yZw+iEBmItVmwsgwYRQ0xqyXt5j4mn+YC4whjDaX/ji/AI
 v2g/0TSK6beFJiljhgh4GD1d3YhtcYvc8EVXq3E15yyhlZIoT7x2/Fly6ONOMM00FTAxPq2NDr0
 M+lLVBUtuTXshuLv4Cs8lyj1vNhVE6H3DcF/KX19fRlFBnpp0zEJ+ocNEVBI8nmSR4PNXpVAtl0
 M1beAeLM4q5YzJSGSIA==
X-Proofpoint-GUID: 5e4_QTChDz-mFN7ImfYILDGaIvRnW0oE
X-Proofpoint-ORIG-GUID: 5e4_QTChDz-mFN7ImfYILDGaIvRnW0oE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609190130

Add the "snps,dwc-i2c" compatible for Synopsys Advanced I2C Controller
referred as DWC_i2c. Compared to the existing "snps,designware-i2c"
(DW_apb_i2c), it broadly differs in its register offsets and some bit
fields, requiring changes to interrupt handling, timing handling, etc.

Unlike DW_apb_i2c, this IP has no COMP_PARAM_1 register to autodetect
the FIFO depth from, so add snps,tx-fifo-depth and
snps,rx-fifo-depth as required properties.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 .../bindings/i2c/snps,designware-i2c.yaml          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index 467bdcbb8538..f56272a45096 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -21,12 +21,23 @@ allOf:
       properties:
         reg:
           maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: snps,dwc-i2c
+    then:
+      required:
+        - snps,tx-fifo-depth
+        - snps,rx-fifo-depth
 
 properties:
   compatible:
     oneOf:
       - description: Generic Synopsys DesignWare I2C controller
         const: snps,designware-i2c
+      - description: Synopsys Advanced I2C/SMBus/PMBus Controller
+        const: snps,dwc-i2c
       - description: Renesas RZ/N1D I2C controller
         items:
           - const: renesas,r9a06g032-i2c  # RZ/N1D
@@ -121,6 +132,18 @@ properties:
       low period of SCL line.
     type: boolean
 
+  snps,tx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The depth of the hardware TX FIFO. Required on the snps,dwc-i2c IP
+      variant, where fifo depth cannot be autodetected.
+
+  snps,rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The depth of the hardware RX FIFO. Required on the snps,dwc-i2c IP
+      variant, where fifo depth cannot be autodetected.
+
 unevaluatedProperties: false
 
 required:
@@ -172,4 +195,14 @@ examples:
       interrupts = <8>;
       clocks = <&ahb_clk>;
     };
+  - |
+    i2c@53b00000 {
+      compatible = "snps,dwc-i2c";
+      reg = <0x53b00000 0x1000>;
+      interrupts = <166>;
+      clocks = <&sysclk>;
+      clock-frequency = <100000>;
+      snps,tx-fifo-depth = <32>;
+      snps,rx-fifo-depth = <32>;
+    };
 ...

-- 
2.53.0

