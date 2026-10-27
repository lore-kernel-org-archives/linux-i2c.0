Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793100711;
	b=nIlpaRf4oqIQJtKtWTD+KXxHOrVaENVp7lOXLPtDhxJ3U5BcfpNRQz76zOoSiY8gntO1
	 AIZGd9s9lSUfwNCpAJJTEade+GuxVMDh17qxJVZplVJptIbOEBD78UPAmh8Ur6Uka6QYt
	 2rlK4dfj1gDZ7kmSas4CJWPCSy//5ddhkD/Y/E8cDWOvPXqvqkj5MyAURmThhRRgIPMp+
	 q6m1wOPWfASxz3Ty5QYtSbRwwRozXXmZMxnvWRPrn0TNxSIH623kWjQVV+xUzcRImil+P
	 zIcrfHU7na0efYHxX+vlvsRx1ABOhDB7U75Oe/JEUD3Te2hEeuJ4E6uis9Xb1nWXd/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100711;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vt93RnLaMdgO9w/WpEijr9NPo7tDN0sCPzEW3e39Z44=;
	b=jXydx9mdJwI6zb153mBmGvx3rfFEhmr7fH//tWgR+THgtj4sHhMVJISuOvNY0XPNrTbR
	 vGiTOU3bnB2WO7/u2bFReuoobDuDme2syyHFK5bd/vwO3YlZMSIlYwXVbLvZat/q18/G9
	 6RywfK8iK1vX9C0C4levrN+OTOvu0noiqUr8TR+iftMFcW5oDLwyWDP0tAbRQdIG5RAsE
	 DS7hf0/gfdtCkmFgjzI/xFlokE+ZXzb2IXWhOPR/Aclyqzo5jAPJ5mbbyz2ytwcHvAW1E
	 a2INvu9J9oSHey5RkmePejsZOxtWRmcrDB+yvW6qC0PgCKWf92M3bvVGBf535KXuejA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Tm+3amRZ;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="eX/cuKoQ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F84606A31A;
	Tue, 27 Oct 2026 11:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F84606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Tm+3amRZ;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=eX/cuKoQ
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R9E2XD485524;
	Tue, 27 Oct 2026 06:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vt93RnLaMdgO9w/WpEijr9NPo7tDN0sCPzEW3e39Z
	44=; b=Tm+3amRZAyDBsxoKuxabR127ANHG1LJNfR1hzr3Be/CpyBtuQGVr1DAEc
	fvQevq5qOmADUPUBlKtoC1gj1LT5GI4XjLaON/S1c4a8xPtbwHkkMqmiMDBMplvT
	lfeUBHylHH5sexQBx0vlIJdfWzb79MId4yA7bIXU9Vhh21e3XEg6cmE9gLwOtqDZ
	B2otxFxhNRZSxX3o8itVpPrQe+dQi0T6ZP8gAMyC2tMp8eKo/wkj7S1R9D5OV7kK
	Xl22abIH6LrOG0ijSRgmBYsZCUwd2tWC8XBarswSChvGgGI73eQT9N2bkEpiGt+X
	sZ7bB5QOE7mOmSQ4Pm643WJy48+aA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hjp2yhwp6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 06:31:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+YrZ5BkdsRa2+gMxhwIKfIbIulZSqOPSlNhlypxUdeuQ3kbUI6GXY/v+CgzKpxx87J+hieCjYEN4oLHbbCs5tmTYC4PknKpBs9RVl+FJ+t52BANlBumoIa9JpY2AsLYgGxoE/o73pwyFs6WRc6guo0iBiM6Frj9kVkR5jDplVs5ay9Galfk6aqRgqWGYtVF9rvU2CIVNA2yVf/5WK9kA0u68rGDaXCYl4+q2xH1vd/IO4ywolHBmmYrfI2j3fp9WnICJwZAydLYWF9jIobf2k/y/OiZii5VAdeHz0X+7BEhqbfWjdWWn4EJe6MYaIY22EvciVy6Q7FoGD48IdySKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt93RnLaMdgO9w/WpEijr9NPo7tDN0sCPzEW3e39Z44=;
 b=srxEbR4GmUnThxXhpzL94AQFpibpXN75+kAt4OMDADEh8QMLFDPGN55BXSqKZIm7oG6lSnFGSC7gbts0DC37FnJ5TkgkCD2Cgj5tQeMb4w6NyGPmTB9ek0Xnn5fga5upoWQHJQCZBYuJu0hPbvPmt6LIx7SYKi964IzYcuwpFUwgEL7OW2ljKrLbil6BrpLoW3lXh1BSCcjd1V1wXd94oPV4AHBRvfljsUOVOt5CNFwCtv35IuzhLhFDzH/z0TmrWyh/5FCyHuP7n/30VASxD0M/UEtutOueJ79orL9vNV/uYzy9/Jxk20exnFw7KdVhgPmAd+YGYkbelVU0XfaGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt93RnLaMdgO9w/WpEijr9NPo7tDN0sCPzEW3e39Z44=;
 b=eX/cuKoQYhgGxuVuT7eRE/qjftiAd4B4tuHVAeTHw6tReGPLKGETWsxXHxFftFpavPRtVqzFmrsOR0B/quXn42l1SKw8aNDF4HxzCnQ1PWKPjsQBfAASKdojfhpjNKiEEQvQfLPSIrzDZuUrVYZFImO3h2XN1jwk/tkm5eOdSnM=
Received: from BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13)
 by IA3PR10MB8041.namprd10.prod.outlook.com (2603:10b6:208:514::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:31:37 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a0) by BY5PR03CA0003.outlook.office365.com
 (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 27
 Oct 2026 11:31:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 11:31:37 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 06:31:17 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 06:31:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 06:31:17 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69RBVAHS1817461;
	Tue, 27 Oct 2026 06:31:14 -0500
From: Aniket Limaye <a-limaye@ti.com>
Date: Tue, 27 Oct 2026 17:00:35 +0530
Subject: [PATCH v4 1/2] dt-bindings: i2c: Add Synopsys DWC_i2c controller
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261027-tda54-upstream-i2c-v4-1-ebeeaf87d181@ti.com>
References: <20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com>
In-Reply-To: <20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aniket Limaye <a-limaye@ti.com>,
        <lianfeng.ouyang@starfivetech.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|IA3PR10MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c99099-0c81-48d0-1b7d-08df341ddcb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|13003099007|56012099006|261026140227099003|22082099003|18002099003|10067099003|261009223027099003|261022113327099003|261021123027099003|261022105027099003|261021121427099003|3023799007|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	u/zP350UrTZ2PCF/WeVRbD6L7+07X/spo2QxMeee0VzzJ2Ta/cZlvkw8R/qqqXV6vNj2Gig2pjm0vaCc9ZMvZwXEbZmCUhM152K1FvZHfaIhmSKoCAfvD3ODA//DMWP0jPUblp7+LFsrSWC5MCH6IZvxfmAAgkpTTwityZaMdDJzlA01DqzVqg++B9L/VZHsgbMl1F8c++6OKFCkemYGm8j5It/qjTr/GQj2yiR0a8LIk6W32erJj7oq+0s3kbcwjpVdVHJfVUnTu6jytGpMysDqgOIe3A1sXutJ1FPqc+CXbKAX/AnjQT2T5yGk7QG9zvi/os3l1hQT4bp6OWtzJR0XjXD+gesc3gXCCa6kTKrrVTd5OHNeTYJk5gnVZ6Jt2c2AFHI2uI23X4p1rqcZCUUFc1nDmHy3HQetpT1mK5VSH+SHsvIIuwMyQdRV42gvD0ZDS4Xh9pSfwUYpK3QZnKOg1l6hFrnf5piFI1F1/5s8+46ICOMEw8XtNydggqHxcg2AuPEcVdlGAhShodGdw5zn1YlZfUkqydhV9TWOXCJNVqAm8fBe5Dg1BSp9OetTwGTmt9JxJMVfTOqr1aTWaw4BwIfXDtZ8Be719ygo90fuOg5kVhyLFz0vXEQLuGkikjOTUake3gObZBl8f2Dydw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(13003099007)(56012099006)(261026140227099003)(22082099003)(18002099003)(10067099003)(261009223027099003)(261022113327099003)(261021123027099003)(261022105027099003)(261021121427099003)(3023799007)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P9oy4KvjAlaSXXbMCrpYcSmuz5u4hfms8QkdYT+wO+PW21k55t4t/b2F7hDenumteSSaXVgMLO+mj2YbJAl7zlpwWaQz2agOq10LA8i1660ov07m6vfySdDXlcJtuMGx+Wr/VbteOMJQegIK8+mF98RLYrlj0z7ReZnJXfmyi666MdoFgCvZDfB9oVA0tUwY1M9FcQgY0toB0DBCo9QSfkZAzO7lS6SWRRuSYoS/9YoAze9LhXb70/vXR307L4vBwDHpahsuLVPtm6emjD2sGrx98WSqVJM2qyexF6mvKIhIILt54jT23X5FXJc3JKXoTuKbn0vhb0ZlGJ0vYczvKz/XcDZ/bMcNN6Au3Hxfdlxgs8m7I8E6ocQCzYo/QM++2CkQ6hObjF0qsbo8tWApVo0GoNscezbChXEmTCn083OiNpXprXzcPMDwsSIKBs6r
X-Exchange-RoutingPolicyChecked:
	3vuQxalefMFeUVJxx/LauMOAcP1228E29jYd6YA7bbXCLMBRFQ5234W+RqWg2FVtzAOMy+LzniDacPQUqSJnO6woaTw8qsfOSafHlDRyhUit8HBMk5/YQyYEN2/NoadBCubukmvSNverltaUYrRLcapC4t1JQoLseBYPAQ6gwc4oR3iy3WNU3zAZyOmpsLVbcJOiDttpRIisbh2VBZRuQMH5tLb+Y5wQH7jNXtvNUfPLFq3Wxev1Ytw5vV9H1KoxeyK0dL0viQWTvMsghl7RfTBscjUoaoEOQivuNNFohRiw4bpAlCUG5akkrOOnlwi0Znjoi+v5rbu41F6rh1/MXA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:31:37.0304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c99099-0c81-48d0-1b7d-08df341ddcb7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8041
X-Proofpoint-ORIG-GUID: gGZMbCvT4JyUP4uMuyblRF3qYJJdofuC
X-Proofpoint-GUID: gGZMbCvT4JyUP4uMuyblRF3qYJJdofuC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX/n9bi8FJaJKP
 Fa5WNc/o22rle8U7d0pS35zMqdPvOOqpq7C8DNPoCGQQ+g9TspAGX/bF4B5NCqw1eF2b2CDp7bA
 To7Ji1SAR6yxvIr0e71SpA15ez/tKvnErPtt1phIbLT+3O3+/NtQH18t3frFf9ixzyfgZARHEdD
 Va99m0/H0UOe3E72yW3zBcdznYVAyFLW0cso4YiCUAr3/BPsFRs6sKCLg0RBcsPmnhWinlYUz9v
 B5D4Cwvhv0DWq2aPl/zO3ImfFLSR89nPwFqdVknlQCynkvnTfnQOSsMLPAxsETTG+VwRQU751js
 nOnKTvWOqb7Zl1U80fKFjvSUDQQfQZj/iMjVkEgEVgkZkJD55Xhc165lTNFIJQQM5s94Wy7gjBE
 MgcW9lSVMJbzyc3qGMaTbem0EFvlVojDRD/Yku/y2x+wskozK+Prf4pkl15yp2g1j6vQdGO9s0S
 6gl1d8rM0aOEzADJR4g==
X-Authority-Analysis: v=2.4 cv=FbaiV5+6 c=1 sm=1 tr=0 ts=6ae08b9d cx=c_pps
 a=m6tRWrYHdetyOVyhMCHtWA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=gEfo2CItAAAA:8 a=baaPCjhr8G5CHDsqmTYA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfXySytutTwYZtp
 Vg8uQ0MHtVEd7BDtHhcCJWnP2n22zveEtmoG3oAF3Z3IKWxRL1miIk9h3P/3d950SOeiDCJkDhe
 yl63UOmx4Xg3883DgWG+MQLEEULAjHI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270045

Add documentation for the Synopsys Advanced I2C (DWC_i2c) controller, as
found on the TI TDA54 SoC.

The block cannot work on its own and needs SoC integration, e.g. the
FIFO depths are not discoverable from the IP. Do not add a generic
compatible and only list SoC specific compatibles. The file is named
after the IP so that other SoCs integrating it can be added here.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>

---

Changes in v4:
- Drop the approach of extending the existing i2c-designware-* driver
  with a MODEL_TI_TDA54 variant. Instead, add a new standalone driver
  (i2c-dwc-adv.c) and a new binding (snps,dwc-adv-i2c.yaml), since
  DWC_i2c is not register compatible with DW_apb_i2c. (Andy Shevchenko)
- Drop the snps,tx-fifo-depth/snps,rx-fifo-depth DT properties from
  the new binding; FIFO depth is now tied to the compatible string via
  driver match data instead. (Conor Dooley)
- Link to v3: https://lore.kernel.org/all/20260925-tda54-upstream-i2c-v3-1-544d74e992ff@ti.com/

Changes in v2:
- Rename snps,dwc-i2c to ti,tda54-i2c
- Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com/
---
 .../devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml  | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml
new file mode 100644
index 000000000000..7ad22536825e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/snps,dwc-adv-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Advanced I2C (DWC_i2c) Controller
+
+maintainers:
+  - Aniket Limaye <a-limaye@ti.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,tda54-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: I2C functional clock (ic_clk)
+      - description: Register interface clock (pclk)
+
+  clock-names:
+    items:
+      - const: ref
+      - const: pclk
+
+  resets:
+    maxItems: 1
+
+  clock-frequency:
+    enum: [100000, 400000, 1000000, 3400000]
+    default: 400000
+
+  i2c-sda-hold-time-ns: true
+
+  i2c-scl-falling-time-ns:
+    default: 300
+
+  i2c-sda-falling-time-ns:
+    default: 300
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i2c@53b00000 {
+        compatible = "ti,tda54-i2c";
+        reg = <0x53b00000 0x1000>;
+        interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&sysclk>, <&pclk>;
+        clock-names = "ref", "pclk";
+        clock-frequency = <400000>;
+        i2c-sda-hold-time-ns = <300>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+...

-- 
2.53.0

