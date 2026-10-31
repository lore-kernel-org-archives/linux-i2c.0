Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793440548;
	b=j9k6fAZWPc6sRwyn2ELA9R7HUaOp30+eX59/h3ok+weOfbJ99DN6nUD9xxPmrvZxP/jH
	 IMq3qxb760uvN+uEfEVyj6cgcxUr1wlFQjRgggyGlzLJ6BRiMINRYWWvb9aDAN64N6SeR
	 dp87SW/JeGXXK9GsXq7JL9rd1NBN9d/pKVC+5sHbq/MRm4jeipmAmcUhVfOWwIoyHE+vd
	 wZY0Nj++c46YoI6sXmdfBXiZRUeke4XbFRgt1dxZ1UdYNSnvDDvTKb54FbzkeVpevCG3/
	 k1UE5UB1YWH7N3EHpqmy26nSthGYFBOi75QYDZmSSILNEp3Bd0cFAsgmtaWSe2O152Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440548;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=D5Gh2L0FQI/Tsbqz5WcuNkh3wwWqmH9ZhZhw9arC7SI=;
	b=2BFFRDwbiBoJAEh/fNSyCPxaOcN49jlYUw6CghOZQeK8q+txyUAW0+qKgRMTaDVCfh+m
	 THTPDMtIbhUfYmOELyHyenhZt/qhLJ4yPIJbCSOxfQ3VS6jcKOD92DV4mOc3UKrxfe3/E
	 AkybIBHwm0LwNOPqcXsd0ni/Rp0rWeoUonPriRunKFWUhyQMxIQ8QY9fEiV8yFzjtvAeD
	 q9cDW0sEuAGv68fOe73YlgOPuHr5shp1QOwGuthhCV45EF0ZxP9HVToCdRSOqcLKnLUPQ
	 nn+ELr2x4btzJ2xTA7hxKRYo4woulNwDXwSr0rJNI3PSdtA0PV7+baSpc2uL0cUCOXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=H4ioC9uC;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=akPRa5Ux;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7671606A320;
	Sat, 31 Oct 2026 09:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7671606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=H4ioC9uC;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=akPRa5Ux
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69V4bpQB2974319;
	Sat, 31 Oct 2026 04:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=D5Gh2L0FQI/Tsbqz5WcuNkh3wwWqmH9ZhZhw9arC7
	SI=; b=H4ioC9uCch7s94ny5KtNdNsl8/Wn4cMfuaqJqBusKcccBWXovBk7tfSPh
	+8FewyBKK4cu3KiwbbKP4i5ZvujybZ/ehHewc7+B+XA/Bk3eYgb78nZxLJBJloMg
	c3JJfAKbgmnB+wAf3LF7oIpc/4x0xZYUuX/iFaVJyCAa7SqBQ5hS032MW6QaZXIy
	WsNzcHsF8L9As4vhmRisYN/5AmhpNRLkgd04c8nNF9NZvEVb6Nw0m5MEiuaY2oE6
	RnQoAnlgB5KVG0EIpOhHJmui2v/QOGNGmDNdyHEdOIgO04D4yyexMxKHdPWkL6Vr
	9q1jICOAjjkv+ec65LTO7Hu9kGr4Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hn2vwj177-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 31 Oct 2026 04:55:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQAWgMA0S1V7wtiG54Qmivf6pQHMCgmu4Zu/MOxmCkWhwePRU/RAFhIIeMCHv0K+TMQ0f9jP7MsUoxszEkIL0rYTlRU+kEv/NX/skfXiKcp5jbjVx/yr/oOT0birccKMbR2U2AXgIWPh8K+hA6DWDnXZPx93oF1ZBBJh38sRiWUtsMT2E3VGLaIiSBGuSPm8Ox0X5bzGicjzyf0T0pfzI4lCQtZ0wuTq6IVaXcWpHHz7pqynwXNWwoNwCHUY56xlwHr/fpZMpNzXJ08N+M4u6UzJHPt9RlvYqpPAjl6qslZdKUhCDYgxwHSLSLvahCxTpfVgsnQowjhbImW598JBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5Gh2L0FQI/Tsbqz5WcuNkh3wwWqmH9ZhZhw9arC7SI=;
 b=w+6+V60s1MysBV1EtzmfHAsGCwNfC/irppWjSg/Re6uGfIk+kBFMtpcyNT9b22lK9eyvYUusiXBw1qQJl0eZ0waiDjx7znEzeVZrs3gkRUtvqANQLyLZVGBEh+Ui5Ryca2wz7BUo7fFTo7QN0itmW2FgzWP74uk11stp3id5rdADDyYMUmpn/qJphCuMHAfmcMaton0nYslORrulGX+cu4kYnK+YEnfCPbcQWGLEzTiYgyGvx7VPV8Bi2oQsn1Eps1hLO9Ivwe88y939nz6pi8ypZ3HU24wEZe4ejg0+wnOzbTbYjHXClIzK/AXtqyxfo1L79kZXgGdAe9J5r8Mn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=starfivetech.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5Gh2L0FQI/Tsbqz5WcuNkh3wwWqmH9ZhZhw9arC7SI=;
 b=akPRa5UxVrG7HRxd3xZ7gXHdvj58zhHrBvIYk24CWoOWkbqO91pQ0XH6YuUOOD/AkNEUyxcd54JWqg/OnuPnLigS4ST5vwehmmeaWGUZqe9Dt3lXfjimjuGg3/RiyuL/V/0Eapr7arUaOGfC6Bf1qZPtzZ+UGwkYNrDCNeoKxDc=
Received: from BN9PR03CA0365.namprd03.prod.outlook.com (2603:10b6:408:f7::10)
 by SA2PR10MB4729.namprd10.prod.outlook.com (2603:10b6:806:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 09:55:28 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::1b) by BN9PR03CA0365.outlook.office365.com
 (2603:10b6:408:f7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sat,
 31 Oct 2026 09:55:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Sat, 31 Oct 2026 09:55:26 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 31 Oct
 2026 04:55:25 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 31 Oct
 2026 04:55:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 31 Oct 2026 04:55:25 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69V9tLWq1469207;
	Sat, 31 Oct 2026 04:55:22 -0500
Message-ID: <2a458be7-1235-4f59-ac4f-d838356af4a6@ti.com>
Date: Sat, 31 Oct 2026 15:25:21 +0530
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
Subject: Re: [PATCH v4 1/2] dt-bindings: i2c: Add Synopsys DWC_i2c controller
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lianfeng.ouyang@starfivetech.com>
References: <20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com>
 <20261027-tda54-upstream-i2c-v4-1-ebeeaf87d181@ti.com>
 <20261027-masked-ultraviolet-kittiwake-7da8ec@quoll>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20261027-masked-ultraviolet-kittiwake-7da8ec@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|SA2PR10MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dacd1c-2a97-43e3-7e48-08df37351710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|3023799007|10067099003|22082099003|18002099003|13003099007|4143699003|261021121427099003|261028144727099003|261026140227099003|261022105027099003|261026121527099003|261022113327099003|261009223027099003|56012099006|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	QkrrhuN7mItlKzc8YJnvrpK87JLPGXUItOaPGCs7iFyPhMju2e2eHzB8TZTXp/uk7xTILkTR7ZpmmKzlHGb7yJtd8k0lpIlLgf7pWZRYY3N9GXnF6aiQWZV1Jko2VhLZgKg88NPqYpfrMjCKDYd6RaJamYt9SlFH0ECkNXd6UWzzanBKywsjNy3zTtdJNZmmONNfE27fV4z383IZQJIzBsqTiUp3Ha1elaUzvIeXTyI9DrgzPQorDqeYDcQqy1wrny1FBN8rubqJeLhtYJypc6PaXGj8q6aV/Sv/kffyLQfUo5KRGMKAO1gRNDS/unQgmcingvzk8V3OwFRxzgAAlPt6MZoiOoLnyVDg8Hr5dXkf93J3mQ2amavgfFkOJimO+yI7V1mrGOtayoMCVfRufqj/ydItdN9FDtRsB73w6Cz96R8P/0r+EF+yl6ARObmWhufQgCRm+2qzgW8mBCnA87Mq8VqZMwF732f0p1Eu490UIYrEFNCnPS7TUjva6FlXkMPXoB6WbgNobXxvk04O1b48MOkdwYDzcMDAZGPT9vwRYyv3I7tgGOv8GtnxdB/A9Qb05wbKEzYmiP9XebCXl+eNkRJDJqV50g6Xoa2E69wz43bchIXe+juMkzB7mWztD7vQes17k2z+agl68AWUIQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(3023799007)(10067099003)(22082099003)(18002099003)(13003099007)(4143699003)(261021121427099003)(261028144727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261022113327099003)(261009223027099003)(56012099006)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hbb0OGCg7pdoxuzv8Xk/iyWuItv/cS7JTa2KbS6qWIexCC+6Dd/IdtiVTIQcmzy0oukBJahpxK/cMTK+ho7CnEDq5ZBGuTOdk2qwagw38hO2pE4BUperUZzBd3QZIbz6tWTlsNZCsjavyYi4wzO4lUo7qGDSgHQoscokX1gZEgrQcdqWuxK9No+FNgGIZ6Dq082KkFvQ8cgynLi4BoHSySYI/9J5VNvFtpWPfJuNHQKv/V8R+HIuk0V4FG9bly2IH2Jl+2oaCBFDkwMfGodJz5H/ZIZ9S3/MfNzA1wD5lfLDYIEDkdMR2G+sU4WcG4sRMdGJGKqV4pRm+Cc2eNFLNp/soJjDakK2rUTz0eMUbPAwfulbu7EKyoK9Uonu+dI7BWVQWh4oyv5aYUdEyyYU988JLilwI0E/mh9PrLNJ7YDsuD13g8IAR5Pyg56NHanP
X-Exchange-RoutingPolicyChecked:
	eEHhEVP2oVrTcluc8BvVnr2MNZjfAaQDuBQkEea5xBlwP3nU9kcrcWdovEVg8hIkNNizudjxIA/TzCqXrmlb2lTS1sfjjdQBusazKVlgO9GowmP3Mm0ONxLQqNu28VsgUAx7gYp2yjyaWiIbHDkuVhutbE0NqyuG4ZHLVE1p7D2OBopx9FW8e3d8JX21/pNWuxLFmBfS8ELyL42yNWigsAG1mKxjKb4j5WizBYgbx/fFlXMZ+UyYqNwEp4Uh+2cPwlRh0BX+o+rNKI3HOtircnxIiBnPiPHc6yLNQ36OoAFhs6oCVOLDDeZY1nLShZnF05rVtHIT4Fx/no/wa03KQg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 09:55:26.8443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dacd1c-2a97-43e3-7e48-08df37351710
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4729
X-Proofpoint-ORIG-GUID: KwNrvEBCaRZUa0sN9eE5lWcYURU_HL1V
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAzOSBTYWx0ZWRfX5rBY5iI3p38E
 AckdsYoSuEWKC3IeQGLVTFg/D+g2QQNn8gcwMrBeCrQGb1mDvF6l773+2a+KtZ8DKZxPCTcKTxr
 tvJ3pMb03mdX1Mgw2Stpd9js7KTEli0=
X-Authority-Analysis: v=2.4 cv=Kr3YSmWN c=1 sm=1 tr=0 ts=6ae5bb13 cx=c_pps
 a=pVIVKlmwkrZr9AIty3oQVA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=gEfo2CItAAAA:8 a=Fz5YD5QbVF3MmB8mKPQA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAzOSBTYWx0ZWRfX+Yt5WBEtfWun
 xphzQxegrgo3bEixCVnRP5LLBAFcP2v3mSOKqoJnEyUwLvaJkodsBX18WemNhu1AgnPGAFdDfyg
 k1gvY/xrL+ZptKTBIUWTTOV1EgGx9cMOUYq+iMCCM5OumPB+KrV4MNaBSYY6RIvgja6qSpNPG5a
 ar2loD9LE3LkSKjFF0lbuHjDnZvCg5MzReokUQm4olSSUe8pgl6wj1Wy6KmvgHhnqiREP6V9/cV
 Z6dYmv8y0KaiR9cOZeqQmEiE7zB3PeYxsovBIR5GnQzsaEeQcsr+K7Iem9INslFKwpp/5mgkjho
 laZL69WUgH5W3YMvEj2FEWbebNXB3mKEvhBrTINBvFm5LzDAf5SH4CqKZTlzG4+faI3BTIwFVI0
 XfoaPrPax1aPWx5Qai2FLDUDWxaapr9iFirKUhKrFlabbCVHzhq83wW7mA82pgYEw16dIL75MmC
 iVjWAdOzEamG5SDe4hw==
X-Proofpoint-GUID: KwNrvEBCaRZUa0sN9eE5lWcYURU_HL1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310039



On 28/10/26 00:06, Krzysztof Kozlowski wrote:
> On Tue, Oct 27, 2026 at 05:00:35PM +0530, Aniket Limaye wrote:
>> Add documentation for the Synopsys Advanced I2C (DWC_i2c) controller, as
>> found on the TI TDA54 SoC.
>>
>> The block cannot work on its own and needs SoC integration, e.g. the
>> FIFO depths are not discoverable from the IP. Do not add a generic
>> compatible and only list SoC specific compatibles. The file is named
>> after the IP so that other SoCs integrating it can be added here.
>>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>>
>> ---
>>
> 
> Here you mention dependency on new dtschema (unreleased), since the
> property was added a few days ago.
> 

Ahh okay, will add in next version

>> Changes in v4:
>> - Drop the approach of extending the existing i2c-designware-* driver
>>    with a MODEL_TI_TDA54 variant. Instead, add a new standalone driver
>>    (i2c-dwc-adv.c) and a new binding (snps,dwc-adv-i2c.yaml), since
>>    DWC_i2c is not register compatible with DW_apb_i2c. (Andy Shevchenko)
>> - Drop the snps,tx-fifo-depth/snps,rx-fifo-depth DT properties from
>>    the new binding; FIFO depth is now tied to the compatible string via
>>    driver match data instead. (Conor Dooley)
>> - Link to v3: https://lore.kernel.org/all/20260925-tda54-upstream-i2c-v3-1-544d74e992ff@ti.com/
>>
>> Changes in v2:
>> - Rename snps,dwc-i2c to ti,tda54-i2c
>> - Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com/
>> ---
>>   .../devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml  | 75 ++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml
>> new file mode 100644
>> index 000000000000..7ad22536825e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml
>> @@ -0,0 +1,75 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/i2c/snps,dwc-adv-i2c.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Synopsys DesignWare Advanced I2C (DWC_i2c) Controller
>> +
>> +maintainers:
>> +  - Aniket Limaye <a-limaye@ti.com>
>> +
>> +allOf:
>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,tda54-i2c
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: I2C functional clock (ic_clk)
>> +      - description: Register interface clock (pclk)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ref
>> +      - const: pclk
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  clock-frequency:
>> +    enum: [100000, 400000, 1000000, 3400000]
>> +    default: 400000
>> +
>> +  i2c-sda-hold-time-ns: true
> 
> Missing  default, constraints (minimum/maximum)
> 
> 
>> +
>> +  i2c-scl-falling-time-ns:
>> +    default: 300
> 
> no min/max?
> 

Ack, will add those defaults and constraints in next version.

>> +
>> +  i2c-sda-falling-time-ns:
>> +    default: 300
> 
> Best regards,
> Krzysztof
> 

Thanks for the review!
Aniket

