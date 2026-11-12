Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794507980;
	b=svbeRlnRo1fRsOFE4yYBAhZ5VAtwAEGRAlGN5h4j+JwRuQ9kGLUu6B9hk0w/Ob8fvt0h
	 BgUsuIpIjKJp/BbU8jlqLozlbL0tvl6tpoRHKiii+lt8vzBmj2JmTqRvqJv5lwnoU8aur
	 X9E7M/vn6QJuaTy+r8CYH7e9Eo/Y8AqjxrT4lvbeTqbRppe6WkeaVlJJtarSHa9fxx48+
	 YEXpvwuyLzvHlD0skS4E0qpKmX9xy1mvJxH4x5G2olKolAdj2DDQuLrF2ZeJumvtL0AXJ
	 wlREV6XntZ/JnyjmRaHQbkzol2yoBaE2V9ptoDB3KQUO4tsIyWq1ozxqWl6VwawV7Ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507980;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RyFwWQd1EH35DlEpcR0AixaC7O5URo0SW1BAJvCe50w=;
	b=ndb5u+XLbVAJOkAW7aAdrPQDJUWyNDF28raOBCcGK5ch3PWDT5oQBh/kG1KcBpAyC5G+
	 NDdOvqbcwZrnYFuxiyufRZp92K8xXiUZO3KeuO74uvdDFrqQOIzcFSe4YnGTx1qJm3KYN
	 C+tC1dPibA1QFu2g/xoCfBLZ7HDqQutkUHhIfGvGaoU66Q1T1knCL0WvVBVEO1VzG2oEs
	 kSccGm8PUHDzfxKcABot4vBXHTuIRK4NTA0+s3E5enngY79+p99SrSgs9SOy2lvnjXQ2n
	 deI9JpXx73h32PMX6tVd63DWhrhxBRUy3XY+vcK0eRPBK2PHiRsuSu3aRzWkyD5vptA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JOoZaEcq;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=n6RhhiiN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353B7606A31C;
	Thu, 12 Nov 2026 18:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 353B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JOoZaEcq;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=n6RhhiiN
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFcQsl3061936;
	Thu, 12 Nov 2026 12:25:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=RyFwWQd1EH35DlEpcR0AixaC7O5URo0SW1BAJvCe5
	0w=; b=JOoZaEcqa12sqJ0SNhJrB5I0PnBHIzNj2B9RBGE4RqrxaMSOcvVwG4cCr
	B14nD1inRA0WIHdjCbigyBGTUWgrVQ5MojSDd5PgbfoDIAN/GaiY5tbTE8lxoX4B
	beqkO0Btf9W3S5APNSMY6o+1D22k37zoObDeq1Ufi6GEivS/qpCZpVjIycxa5MSE
	pQ4i0tgUXU7ohqLF6IKUxcDx98/OvsWr8e7CHCOLCeRkAl4A9gTjJXUuHk5VNGtz
	XNrSUxJFZxyK46bT0sCZH7tgAbsLH2hjaqm3ep3qR3gZBFdS9+UXja5QUyqxXyTv
	GI0uaVsqmNp3dTpvdVbp6b3rnttDw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hw915kne1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 12:25:50 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY7eplIwk5hCshxyqg0atYiy1aFR1ECa7NnPu0PtXsNiZvayz2WMhjm6BnP9tfjh1C8l9GxQARrhbn+XSTfJqLhkdFZwEko7mexwze0AYmhX9ZVxY3Tw/CMmZgyUPBZreArr968oinpt99ymDrxEhFOD1UuOKTEBXtxqfKT8t8uii1Mu078faXSuA3KgMpOhkvz6HSN8RU/sGrwPHbVBn1YqLENqakOOs1ZPzz1HYorM2YZ39uHjokg/qDCgD6uyPKkCHlFGbzbtwdPEGcCgdtoDA84/gx2UZDjnda+NbLlny1+bGq7n9MOasb7KzjOj7Vzd4lcZi8+YztVnSqLXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyFwWQd1EH35DlEpcR0AixaC7O5URo0SW1BAJvCe50w=;
 b=pLLsH81dWeEUfJW7V5bLpuXedIyvYw87+DN5MsEULAgiKrOlC2qskYNizfyDTLInmbLVZCkSK3vULjFG5892/HhuhIEj9VUY94BqmuzA/C/6uIiAW0FOxbrPIHMRKcsDrOcs5P8gs3XNbltRKNH3nyjGNn9+KRSTPVtb+6c3TgEawuq00hBFst5cQxtcnWU0wSKn2DSClV1ZUfwzq4zZkih8jCgDoGQzepwlChpsDmNmc26LnLaIf1LMx7+mIe+PIUkvOZNJWR5l/ExzzU1tFyGroCBBuBEiu+qBYKU+hpxoWIB4YocJ4MEPqtu4ZO+oLQScGBGBXwbVXCKhMKZaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyFwWQd1EH35DlEpcR0AixaC7O5URo0SW1BAJvCe50w=;
 b=n6RhhiiNRYm9yRIPadkprcL+2oBPztj83O/fCeR30tN7oB61rJ1a+inmVH6bofJZqwvXbX7PQNSE01tsSFbBt/hluXbFhIUdHwd3K0uGwYvgZpotPOvJ/4qBVsMfs9FX0DwzKDNco10MLqoMlyGaUGiovF1ESH77JdmPZyfZ9+I=
Received: from YT4PR01CA0290.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:10e::23)
 by MN2PR10MB4208.namprd10.prod.outlook.com (2603:10b6:208:1d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 18:25:46 +0000
Received: from DM3PEPF000265BC.namprd04.prod.outlook.com
 (2603:10b6:b01:10e:cafe::1) by YT4PR01CA0290.outlook.office365.com
 (2603:10b6:b01:10e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 18:25:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DM3PEPF000265BC.mail.protection.outlook.com (10.167.23.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 18:24:58 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 12:16:32 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 12:16:31 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 12 Nov 2026 12:16:31 -0600
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ACIGRQE1375982;
	Thu, 12 Nov 2026 12:16:28 -0600
Message-ID: <fdeee43b-9a27-43b2-9193-7b2db468e9c0@ti.com>
Date: Thu, 12 Nov 2026 23:46:27 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add Synopsys DWC_i2c controller
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lianfeng.ouyang@starfivetech.com>, <s-jain1@ti.com>,
        <andriy.shevchenko@linux.intel.com>
References: <20261111-tda54-upstream-i2c-v5-0-280a4a779b24@ti.com>
 <20261111-tda54-upstream-i2c-v5-1-280a4a779b24@ti.com>
 <fc1fe51e-952c-4c8f-8dc1-fb832b03943b@sirena.org.uk>
 <20261111-smooth-meerkat-of-judgment-dbe8bc@quoll>
 <34533daa-7eb9-4674-a288-e8d87a8bf29f@sirena.org.uk>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <34533daa-7eb9-4674-a288-e8d87a8bf29f@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BC:EE_|MN2PR10MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c7e70e-f8c9-493b-b716-08df40ea41e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|18002099003|22082099003|6133799003|56012099006|10067099003|4143699003|261102123227099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	sPuWiQqrqk42VFdcfYa+yKIvAoYbU3L+uRninEQ6gU3GiDEW4pUOLmxGK6Uoc/04e4tQjy7andcOMxitwp+t4K8pEou+J007k3aI5CYnChI5S3qPJyzdS0IxhMh16YYyNPgOGtJz92+cskv0NOJBPautiyWcnEvFrRnZLVZDWXCoOcvj+/21HDRKbZKZjl9e/U0S9TzQtmClfdQjTyQzbd8GXNCLs4hMa+a2dKHl4P6DBAXYeOK6hzvN/mejPrm0pD+DJqsnRxezMYHKWSI5hqfJBbxOB6GMFbtAwknHEcd6Pt0m6jj3rfjOWxpCMYWesNYVXGmxkokw5JHvJqrR6t6Gs+4sJgdbyQ/6kddd8kY92OClqGA6HCeC6Hno5Q8mWTaSgHjyJ/Y8PqEwoKqf4tZ2DqCFgfLceSIWxA74asBcxIPGpvFrUWlMcWsdU6DNaKAx5WRmUXvQ+qo2c5GJ8gO0Az2Nff2ScUz+zkOPpRguZd/QNzZcBpTBCUFWj1YOOINGd6OM6NqzTpUM+Xi5MfMHfsuFWOzWtA/jioPzB5uoKJhBnCMW/V4FPvEBELfVciIMNsRRMisIHj07qppRp7M7d485A/bnEuqlcyMrJz+tiZjIZZCsWRQvPcKQVCo/b7JLpac9tiL52uSGlTJfb1ViCZ4wYbdTfgb6anttMEbg7kjnRJ9sewV9v2Slw3qeHJ0PPUXSCNInmAiOj+MPnw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003)(4143699003)(261102123227099003)(261026121527099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8brAzZQ9bKEOm26sl70jXKLdfYRXiOkDzmpgfzatY+E/9sdgJyMr1uOojgB9AN/qvfKSe/U9XE6X6/c25m1JX1Rq3LrVyMdlFKjU/T+kFwjEzjwmBfbOHVXOafbwG5KQ1hlQTioIHpPy29VrRAH6q9qFfCriSmu7XjNQ8qux55U8sPqwOJ41QvBvHrKr/+73xK2BIkkYFwmTmbuB11krMglOoX+hDDsFy8kNSAei9cTfFbYiEkJRQ3MYaexUiica+Eb48j++Z85AFjhXjszS2BpmIE9s9/1LgiEynsx520NWGoZcAsp8YNA+ypp4QpoQeDrpvhyRhKGNR4z/LDZOcsWIlPbnhjcy3FrIGlKunOCVWc9knkOY6Dbg0mcFm3db5k5MVypikCHYcHnEAQniT1P+HAIseaHzFQYwgaomOvYnHLBNrbSKQr+VLtpWAvOx
X-Exchange-RoutingPolicyChecked:
	RacpJwEscl6ARs35xlklTass7BVc0Map1rnV4y6DxHhs9E5JjXzhX4ynNyIRULu6b0xpIK3IibYzAUcHs/yRnHWFzYpmbavL5SxdO2lg8v5IIRx+3KRtNK+uGsgrlAuvtJvUe2bxpy9K/vXC1bQGIb8fU+LQGQQ+Du4kIIMULP9qe4KL6FYVPE23lX/d3UE3OW1GnhKE2xwHdenMKJ4gNgLwanjxUrLqzyMtOlcy0zLC9ihaH2eRE80aVPma126HybTSlTw9hc6njJe63SB9sxvFd2e+6yQQGs/ea2X+VWMd/Q2CiBfwA5WrfwgAoNdgrys/SyynokzX22jjtbGpDA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 18:24:58.1185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c7e70e-f8c9-493b-b716-08df40ea41e9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4208
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MyBTYWx0ZWRfXxfULmpkvD9nW
 OcXI5SQY9/kXCZsiOxqHDLWwz6amG6vOmd9xzljiSpb9VRDslVChDmGhqbn3N7wkdcf+USDE2RR
 fiu1KPSCCSjd/OKBF+WIXOOCTcjakKY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MyBTYWx0ZWRfXw3fGzmHkQJrN
 CGdxWDQdFdn0XVEaVuBMW11U5L50ZZNOxUBq35eUqtl5mzeB6HDUn/fTuR4bYKceUbUkqCbEY9m
 yXda9WVtpIcR7uxI5jCGeGrdnhOSBgQz6JzzBv420JGg9cis4Al+xuq5/OYJUcL1UAlowNH9ac/
 4YnBJun2Ae20Ubi9FnRxiP+omZajrZOvMuv0r2Rro7Gc3/vZd3pftdyOoGt0k1/RuVyqC5vO1IN
 RIqgYBihWidXU4AGKSjeoy5IhIuB9nt3APoSqcx3hh3dRcj15Gvc+LHiEXH9WbDBDszyBsi0eOH
 C8qv/sMKJ3XXdh2h6Ks/TeV1rCa04zI9cJpRFb9I5NjNtV8F2f1uBlIjs7+7ZoO8qOwkSVHFJRY
 Hq2rXW+VYMuDUk6fRQG9Q2mAV2ICYRW90RsrvUri2OosBOX+IOtcXvA0cyF80Tlf0jgYrAnXscv
 wEngr12Tu5XQLaOzr5Q==
X-Authority-Analysis: v=2.4 cv=a8WlZkSF c=1 sm=1 tr=0 ts=6af604ae cx=c_pps
 a=k0I/Xeyziwozq/4EdJtLuw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=AVKyRaM97I4O5Su4oLEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1LBWRcGf3AHVwYWkz-8fto1ukTW_44GJ
X-Proofpoint-ORIG-GUID: 1LBWRcGf3AHVwYWkz-8fto1ukTW_44GJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120073



On 11/11/26 18:54, Mark Brown wrote:
> On Wed, Nov 11, 2026 at 09:41:40AM +0100, Krzysztof Kozlowski wrote:
>> On Wed, Nov 11, 2026 at 12:05:15AM +0000, Mark Brown wrote:
> 
>>> I still think we should have a fallback compatible here, while we can't
>>> discover the FIFO depths all the uses have a programmed trigger and we
>>> know the minimum depth configurable in the IP so we can fall back to
>>> using that.  This would be useful for distro kernels, it's one less
>>> thing that forces using a kernel with specific SoC support.
> 
>> If the driver does not match on such generic compatible - and that's my
>> impression from commit msg -  then it is pretty useless.
> 
> The driver can match on a generic compatible, it just doesn't right now.
> It's getting the FIFO depth from the compatible but as I observe above
> the minimum FIFO depth is known so we can just use that as the fallback,
> we program the trigger points for the FIFO so it doesn't matter if there
> is more space than we're using.

So if I understand it correctly,
1. you'd rather the driver have a generic compatible such that we can 
have distro kernels not requiring specific SOC support for this driver.
2. AND it is possible to have a *sane* fallback by using the IP's 
generic minimum fifo depth. The DWC_i2c manual specifies 
IC_TX_BUFFER_DEPTH and IC_RX_BUFFER_DEPTH as 2..1024, so using depth of 
2 as a fallback would be functional on any integration, just slower.

Krzysztof,

What are your thoughts on having a generic *fallback* compatible 
"snps,dwc-adv-i2c" , used after a SoC-specific one, i.e.
compatible = "ti,tda54-i2c", "snps,dwc-adv-i2c";

The driver would match both. "ti,tda54-i2c" keeps its real 32/32 FIFO 
depths, and the fallback uses 2/2.

Thanks,
Aniket
