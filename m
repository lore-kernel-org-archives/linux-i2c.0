Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793100743;
	b=2T/77sPllX1hMgCgLlOEXLsmQE38V/BjuS70umVSq5IsZEA3LfT1iQYH8EmMbU0ExuJK
	 xVf9T1EIMs8cAqPZX8kcTmpE/SzMwCP0+dK+rWRBDbAMY4DjwtD9gmJJsbvG8vJ82Kmpt
	 ZS3B3oJjgmbss0ovp2i8fnJ5pOlMCfaqQNTmZrID0TPfoeSE6vs6k07K39PYXGlZMTtFe
	 6jWYYcB8piPAVSe2XzcjM3kQsZor/koKTtRfxopxLqUn8DidBz9sq2kmERyySthxtpeIF
	 8bI4sTUh5n+2SF2ojPfgnzzat7/KbdbPUYwYnBTMpvNebQm0/tjxm23/GDE3zRDnDiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100743;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5sKrFo0almOAgVfjQrFbiR7fF0bHyQAGhl3e1nPZ6OI=;
	b=C+6FHZm4XyISZbbcWKedgW44clLJEdtnoBRYltgu/DQAhiplJi7RgyAW8fVGE1VjGssK
	 YYMXmkkDlX1+/C6gs6wAkzjQ9FhgsLbJEftlKYZbnFqpxcIfytKRW2BtG1MsisPO7mbrL
	 Skaxk2rvbSt2cpFrcEq/JJ0iW/AL/Yz0ojuY/kLeAh9uDke4YGKYbL884tNTm4Vek/txd
	 9iLyRmi5gL+//NrS5tNvErUzFsajn7gItGNPZFzleFTgXjz9uR72a6pQat/wVVb/aHO7d
	 NZ9oy4mysvbRFiSHGPHKs1EdzYldAnnJo1MHzMx/A1gqCQqbM2kfEku88f9lEd0AxdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Wt9JXQWM;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=VI0aVh5q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF4F606A33D;
	Tue, 27 Oct 2026 11:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF4F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Wt9JXQWM;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=VI0aVh5q
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69RBCx293385590;
	Tue, 27 Oct 2026 06:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=5sKrFo0almOAgVfjQrFbiR7fF0bHyQAGhl3e1nPZ6
	OI=; b=Wt9JXQWMF+ib813o76h/o42x0cawL5w1YxCpyFw0Lh7vjYiIYu3HUzPof
	atkpQ/AMVIbk4YP2UgYzboVA+50n+AibUyULDdS6fCtC21IOW7MxW2xPDFf4M6TT
	lT0ZIZ0R0rajiciLZ2jA6bv+YDHWY/BLBJvgkd8mn2e3WZy3rGSMdFdDr/jGlwhA
	C00U1nyhl63o/sQ8bxtZuo5My6zHlSaWNl4aRteiv9UtvqTcvxumY/a6yyttgB5t
	lzvL7ke6sylr5X2IKB3ctrMoWeUPuhgsMSzFD3up2X2zwww8NYZU21BMe/MWTCy8
	6drUrpVSvHUmQQdJx5phGhge1kA1A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hjtvxg3bf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 06:32:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlR//QuUPPYgErk9pdQBRsf+IUjpqH8wAz7N/BlUxXO5UxAYaXNXiV4t8zdIxUfAUsH6La4brwPt9LWgfKeHtjjnm0fqGFgsdiBn8crpQEr3qg64DhECEMubydAk1ZGiGvrqRnb74uKAzYpbUFrpBAJFSS4bvIlxrn2xLH0tq7iNTf0xrGkxiOw13gJhGb7/71Hw6nJsmZXdX1vy7neYakXkxURCgBGKZaw7VgrlmRrmCqOSKfxNN4grbr/O+EpIze85u0vfa5g0jDAbisM7ge4CCLcU/HerbB4zQr19fm56Tg1IFGxJrtwSV47N7ooUb1wamCG2zEZTbivtgaTJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sKrFo0almOAgVfjQrFbiR7fF0bHyQAGhl3e1nPZ6OI=;
 b=hSRPAxCay6TKUQxQZJKJHsNWsKb1vElkUNYsNs8SIYwUL2EmPldtWJRnyPdWAv5XzTXku2j36P5KLi6iteVIBwbd3p5T17lg8uEb/AUDFhNaZQFaw7+jIFzBip81+/Ukfxdej07fuX7AS99byH8/15DlBLNH9zeBiOebLiGQUDL84WzVwRV23xUeyYPjbMw/OcS7V3kyfDLs7y8DeOdJ4ZTCMy88l0b937YPnCU/Gl3yLJRc8se0oWo139A1DjW+m+V1xJzMEMdyyxXCM2z6sZiPF5H2N2BKuhPUfozqmYQ078XI7lsuXzHbObMfTQyX3/XvD8ghbPHGtFNQ93lirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sKrFo0almOAgVfjQrFbiR7fF0bHyQAGhl3e1nPZ6OI=;
 b=VI0aVh5q7T23NFTBsn42RVCxm5N275UpDA8rWb9px63FqHIU6JQsgFCs6eJpeue8RQM/zMHnY4SiaG85zihqUJ5VGUme+zPSKv2T6WjlNIJ2DwtV+8WF34jNIvXY85AiTmmI1fctblMOqRcfXUZ2//rgUbWxjtCmef/IvhcZyFg=
Received: from CH0PR03CA0093.namprd03.prod.outlook.com (2603:10b6:610:cd::8)
 by DS7PR10MB7321.namprd10.prod.outlook.com (2603:10b6:8:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:32:04 +0000
Received: from CH3PEPF00024580.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::1) by CH0PR03CA0093.outlook.office365.com
 (2603:10b6:610:cd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 11:32:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00024580.mail.protection.outlook.com (10.167.252.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 11:32:02 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 06:31:20 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 06:31:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 06:31:20 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69RBVAHT1817461;
	Tue, 27 Oct 2026 06:31:17 -0500
From: Aniket Limaye <a-limaye@ti.com>
Date: Tue, 27 Oct 2026 17:00:36 +0530
Subject: [PATCH v4 2/2] i2c: Add Synopsys Advanced I2C (DWC_i2c) driver
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
Message-ID: <20261027-tda54-upstream-i2c-v4-2-ebeeaf87d181@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00024580:EE_|DS7PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: be04997f-6352-4444-701b-08df341debf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|6133799003|18002099003|22082099003|261026140227099003|261026130827099003|3023799007|13003099007|56012099006|5023799004|261021123027099003|10067099003|261021121427099003|261021130227099003|261009223327099003|261009220027099003|261022113327099003|261022115727099003|261009221227099003|261022105027099003|261021135927099003|261009221727099003|261022075727099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	5wiKMWKWhd+QYPB+8qZIbAjzIyg7/ZbeXGaAwnxLfQNKmlZrGJ8mat0Ip+pRqsknT0c02IQGGjMX+yxvvbsiOGiaK0e7gJgj3M6p7hS9wcm1L4zlId6ly7qyp6h5iPo5SUEaXJCZwNPjZ6co19wlUbXddxAZYjfucdtHYvr7WZYm9sfem7UaewpxKdUYh2wCsk0qYFzH0tyKUnI6bF4IUaRJ6aOaRbSTz73P/lOzYy7aMFEFDH2LIojaN/Wc75mw0MloZzNYHN2vW0xEee+7V/5sqeBH5DJSt2JeAMjcB4Yoa7l9oJRnMWrv2y201aN1GSAJL7ORA3+eDpPo1uKCO1aRNG6VsK43m+cCSMISlDKGlkl3zqBwDcmt+NW5DYPChkhKAVztruI8o1hlo7PSZFDD6Kh2sPMbfIqhpjTwlobzTW3tKuZ3idFz3ktxLxXkXhYPG/5ilNd532SXS8+FP7KxyHj024xPTjKvzoGxUGEzUJq6JV2foYo6Myp6/aKFqHvbznSma0oYy04FaurNX5ehwe9gAsvTuN3rMCN5SZqEHrKntEndT3qU84Dc+LtcokKyx3QDji6S0b/QF7aMViOo7ypjwVcqeflM4s+HxqC13oZFbI0Sv5fIGcykvSLooW3NYafo0jpdjg6zmufRHA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(261026140227099003)(261026130827099003)(3023799007)(13003099007)(56012099006)(5023799004)(261021123027099003)(10067099003)(261021121427099003)(261021130227099003)(261009223327099003)(261009220027099003)(261022113327099003)(261022115727099003)(261009221227099003)(261022105027099003)(261021135927099003)(261009221727099003)(261022075727099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F2P3sg3T3MiYj3S5x8JxTS22VKYSFUvkZZ7P47qSzWCAKOdGkv5VXMgHE8eI8SrJMga9pHmqnvVukyik5qjLWLOO5VzfIz9CxIAh171A0izWorKDqhBHb0zo3+7oEixvwYv8VKxyqHtxoE20Lexm1tzSOple93oIaFANXvwzL7XazK/y39C+U+zZUKpqzRbWw0h6xYDglG9NZqFQqFZLqx7BcP8UZG8ppTsNnKmeSxzSDjgHRUmG83jdkHBqYTP39dp/mMnCmqEL5O0tISX6r2hjWlg6ZJa1OQbK4bc/JqrVaEhBgyN1mqIE59ED6gdcrJT1xaTOOMv/arqO2rJ0Af3GLLOnACcu8EW+HIQZsljf7Ma0Tr/VuGeGQwOLvVefd0n3npeqmhwZeTFXje5HwrxmVxyrMHHk5OgpZ5iAy8+Wn8hZaYdHInHWtYCiPezn
X-Exchange-RoutingPolicyChecked:
	bM1dzYLF0whNQ+jhdLu3cBZaRKiQvzBOJSvh47DUVNuPr6FL4v4ZQsd20Pl/JcGXjhZPVVYiTS9WmkiFMbTvjQT4RKRPDY9EnlMHUVYomRP2ffkUcRbjFo5hRDBSKiBnb3J65EE1W1r1zFsvHupd+dewJEuv2pigHfODVZBx/PsklsuSobFQr+Q/HOQOIkWFH+YA8/bC4eP4rWI8AWdVvrLumBOFRBy4mFT6K4d2z49vqXXJSUavYKp64Sh54Ahf2aHLZw/qZfRuTw5rkz+eVb2se0l3sVy/jzGVi8I0RcumiQxmauF8T9CeHNVmctxBMlQHZWLhvAzsuFLXLCPLJw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:32:02.6091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be04997f-6352-4444-701b-08df341debf1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00024580.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7321
X-Proofpoint-ORIG-GUID: lRJ4fkV1X88ZXaa94eanyxRUiD0APT1W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX/N4fvdotKMTf
 9T+4xSMLusQc+ia69qrf3mxhUTJSjVCelzWDacHrhPM+CgVpp9x++rMrJvQbYlPWOpAc+hHRYFT
 X0T2fUFQ/ho9GcvdvHYDoIrnxxFe4Lk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX73+huRtrXpme
 9DqrQJe6z5qtGyATYcifNf1G8Mvr71qtvu35GgsrQTrOhhpztzOlxuDit3Hrfrwty0QtpDgwLwV
 Z3yF5/VXHLc+P7bw2vvf4vEKGmULC5BUCBJYItABzEkljTautJGj3Kw0TQFnR8KS942MGmFyYt1
 8AviUnSht1OZb2YxzSh6TNp8DiGiXcI5VQwpH5u7F54X8ztp2giDKKy/wefypHKAf8xKeJxKRPs
 R4IrUHKRJ2dAWGay7T7WB7pk8EKY1omlhcHLfaHjt+KgJfzaKWWoF5pceHNm4mL0lbaPc0i6LMU
 okS+O/805O9qw9M/+Y9yhirUcvtuKo+0kMyR1nnPGetBxPLY/OkvZXftykghLLk3pSWlnjOyYw2
 pCkzzJ1+l+ZEOkef5WTY179SP09oXvp3+TvHIDU7dQVnVW/1LkDJnB+5XPRemABGqy+GcZFwBuN
 zNO+zVo3D2KUr45UPvw==
X-Proofpoint-GUID: lRJ4fkV1X88ZXaa94eanyxRUiD0APT1W
X-Authority-Analysis: v=2.4 cv=dOwzC+Zb c=1 sm=1 tr=0 ts=6ae08bba cx=c_pps
 a=c8ROGaHEYT5V2SXoku0acA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=WsEqZR2ZYLAr1KTuRVEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270045

Add a new platform driver for the Synopsys Advanced I2C (DWC_i2c),
controller mode only.

The register offsets are defined with respect to header registers for
each block. These header registers are discovered at runtime by walking
the block header chain.

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
- Link to v3: https://lore.kernel.org/all/20260925-tda54-upstream-i2c-v3-2-544d74e992ff@ti.com/

Changes in v3:
- Revert to special handling for the max_register in regmap for
  MODEL_AMD_NAVI_GPU instead of unconditionally including
  AMD_UCSI_INTR_REG in the legal regmap range.
- Link to v2: https://lore.kernel.org/all/20260925-tda54-upstream-i2c-v2-2-261785e58493@ti.com/

Changes in v2:
- Move the Reg ID -> Offset mapping inside the regmap functions such
  that existing calls to reg_read/write are unaltered. This does change
  the reg_read()/reg_write() functions to take reg IDs as input rather
  than their physical offsets, which also requires updates to the
  xe_i2c.c driver to handle the same mapping.
- Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-2-b0b9f77be18b@ti.com/
---
 drivers/i2c/busses/Kconfig       |   11 +
 drivers/i2c/busses/Makefile      |    1 +
 drivers/i2c/busses/i2c-dwc-adv.c | 1333 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1345 insertions(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 275aaa7f3583..ea91221638e8 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -649,6 +649,17 @@ config I2C_DIGICOLOR
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-digicolor.
 
+config I2C_DWC_ADV
+	tristate "Synopsys Advanced I2C (DWC_i2c) driver"
+	depends on ARCH_K3 || COMPILE_TEST
+	help
+	  If you say yes to this option, support will be included for the
+	  Synopsys Advanced I2C controller (DWC_i2c) driver. Only controller
+	  mode is supported.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-dwc-adv.
+
 config I2C_EG20T
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) I2C"
 	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index e5440de0fe14..bf710baa9c11 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_I2C_DESIGNWARE_AMDISP) += i2c-designware-amdisp.o
 obj-$(CONFIG_I2C_DESIGNWARE_PCI)			+= i2c-designware-pci.o
 i2c-designware-pci-y					:= i2c-designware-pcidrv.o
 obj-$(CONFIG_I2C_DIGICOLOR)	+= i2c-digicolor.o
+obj-$(CONFIG_I2C_DWC_ADV)	+= i2c-dwc-adv.o
 obj-$(CONFIG_I2C_EG20T)		+= i2c-eg20t.o
 obj-$(CONFIG_I2C_EMEV2)		+= i2c-emev2.o
 obj-$(CONFIG_I2C_EXYNOS5)	+= i2c-exynos5.o
diff --git a/drivers/i2c/busses/i2c-dwc-adv.c b/drivers/i2c/busses/i2c-dwc-adv.c
new file mode 100644
index 000000000000..1c5b7b154bed
--- /dev/null
+++ b/drivers/i2c/busses/i2c-dwc-adv.c
@@ -0,0 +1,1333 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Synopsys Advanced I2C (DWC_i2c) controller driver
+ *
+ * Based on the Synopsys DesignWare I2C adapter driver (i2c-designware-*),
+ * which is based on the TI DAVINCI I2C adapter driver.
+ *
+ * Copyright (C) 2006 Texas Instruments.
+ * Copyright (C) 2007 MontaVista Software Inc.
+ * Copyright (C) 2009 Provigent Ltd.
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/reset.h>
+#include <linux/units.h>
+
+#define DWC_ADV_I2C_OP_ENABLE			0x04
+#define DWC_ADV_I2C_OP_I2C_CAPABILITIES		0x10
+#define DWC_ADV_I2C_OP_I2C_CAPABILITIES_LOADING_400	BIT(3)
+#define DWC_ADV_I2C_OP_I2C_BLOCK_OFFSET		0x14
+
+#define DWC_ADV_I2C_HEADER_ID			GENMASK(7, 0)
+#define DWC_ADV_I2C_HEADER_LENGTH		GENMASK(23, 8)
+#define DWC_ADV_I2C_HEADER_ID_CORE		0xa1
+#define DWC_ADV_I2C_HEADER_ID_TIMING		0xa2
+#define DWC_ADV_I2C_HEADER_ID_FIFO		0xa3
+#define DWC_ADV_I2C_HEADER_ID_INTR_DEBUG	0xa4
+#define DWC_ADV_I2C_HEADER_ID_HWID		0xa5
+
+#define DWC_ADV_I2C_CORE_CON			0x04
+#define DWC_ADV_I2C_CORE_TAR			0x08
+
+#define DWC_ADV_I2C_TIMING_HCNT			0x08
+#define DWC_ADV_I2C_TIMING_LCNT			0x0c
+#define DWC_ADV_I2C_TIMING_HS_HCNT		0x10
+#define DWC_ADV_I2C_TIMING_HS_LCNT		0x14
+#define DWC_ADV_I2C_TIMING_SDA_HOLD		0x18
+
+#define DWC_ADV_I2C_FIFO_DATA_CMD		0x04
+#define DWC_ADV_I2C_FIFO_RX_TL			0x08
+#define DWC_ADV_I2C_FIFO_TX_TL			0x0c
+
+#define DWC_ADV_I2C_INTR_INTR_STAT		0x04
+#define DWC_ADV_I2C_INTR_INTR_MASK		0x08
+#define DWC_ADV_I2C_INTR_RAW_INTR_STAT		0x0c
+#define DWC_ADV_I2C_INTR_CLR_INTR		0x10
+#define DWC_ADV_I2C_INTR_ENABLE_STATUS		0x14
+#define DWC_ADV_I2C_INTR_TX_ABRT_SOURCE		0x18
+#define DWC_ADV_I2C_INTR_STATUS			0x1c
+#define DWC_ADV_I2C_INTR_TXFLR			0x20
+#define DWC_ADV_I2C_INTR_RXFLR			0x24
+
+#define DWC_ADV_I2C_HWID_COMP_TYPE		0x0c
+#define DWC_ADV_I2C_COMP_TYPE_VALUE		0x44570140
+
+#define DWC_ADV_I2C_CON_CONTROLLER		BIT(0)
+#define DWC_ADV_I2C_CON_SPEED_MASK		GENMASK(5, 4)
+#define DWC_ADV_I2C_CON_SPEED_STD		BIT(4)
+#define DWC_ADV_I2C_CON_SPEED_FAST		BIT(5)
+#define DWC_ADV_I2C_CON_SPEED_HIGH		(BIT(4) | BIT(5))
+#define DWC_ADV_I2C_CON_10BITADDR_CTRLR		BIT(9)
+
+#define DWC_ADV_I2C_TAR_10BITADDR_CTRLR		BIT(12)
+
+#define DWC_ADV_I2C_DATA_CMD_DAT		GENMASK(7, 0)
+#define DWC_ADV_I2C_DATA_CMD_READ		BIT(8)
+#define DWC_ADV_I2C_DATA_CMD_STOP		BIT(9)
+#define DWC_ADV_I2C_DATA_CMD_RESTART		BIT(10)
+
+#define DWC_ADV_I2C_INTR_RX_UNDER		BIT(0)
+#define DWC_ADV_I2C_INTR_RX_OVER		BIT(1)
+#define DWC_ADV_I2C_INTR_RX_FULL		BIT(2)
+#define DWC_ADV_I2C_INTR_TX_OVER		BIT(3)
+#define DWC_ADV_I2C_INTR_TX_EMPTY		BIT(4)
+#define DWC_ADV_I2C_INTR_RD_REQ			BIT(5)
+#define DWC_ADV_I2C_INTR_TX_ABRT		BIT(6)
+#define DWC_ADV_I2C_INTR_RX_DONE		BIT(7)
+#define DWC_ADV_I2C_INTR_ACTIVITY		BIT(8)
+#define DWC_ADV_I2C_INTR_STOP_DET		BIT(9)
+#define DWC_ADV_I2C_INTR_START_DET		BIT(10)
+#define DWC_ADV_I2C_INTR_GEN_CALL		BIT(11)
+#define DWC_ADV_I2C_INTR_CTRLR_ON_HOLD		BIT(13)
+
+#define DWC_ADV_I2C_INTR_CLR_ALL		BIT(0)
+#define DWC_ADV_I2C_INTR_CLR_RX_UNDER		BIT(1)
+#define DWC_ADV_I2C_INTR_CLR_RX_OVER		BIT(2)
+#define DWC_ADV_I2C_INTR_CLR_TX_OVER		BIT(3)
+#define DWC_ADV_I2C_INTR_CLR_RD_REQ		BIT(4)
+#define DWC_ADV_I2C_INTR_CLR_TX_ABRT		BIT(5)
+#define DWC_ADV_I2C_INTR_CLR_RX_DONE		BIT(6)
+#define DWC_ADV_I2C_INTR_CLR_ACTIVITY		BIT(7)
+#define DWC_ADV_I2C_INTR_CLR_STOP_DET		BIT(8)
+#define DWC_ADV_I2C_INTR_CLR_START_DET		BIT(9)
+#define DWC_ADV_I2C_INTR_CLR_GEN_CALL		BIT(10)
+
+#define DWC_ADV_I2C_CTRLR_INTR_MASK \
+	(DWC_ADV_I2C_INTR_RX_FULL | DWC_ADV_I2C_INTR_TX_ABRT | \
+	 DWC_ADV_I2C_INTR_STOP_DET | DWC_ADV_I2C_INTR_TX_EMPTY)
+
+#define DWC_ADV_I2C_ENABLE_ENABLE		BIT(0)
+#define DWC_ADV_I2C_ENABLE_ABORT		BIT(1)
+
+#define DWC_ADV_I2C_STATUS_ACTIVITY		BIT(0)
+#define DWC_ADV_I2C_STATUS_CTRLR_ACTIVITY	BIT(5)
+#define DWC_ADV_I2C_STATUS_CTRLR_HOLD_TX_FIFO_EMPTY BIT(7)
+
+enum dwc_adv_i2c_abrt_bit {
+	DWC_ADV_I2C_ABRT_7B_ADDR_NOACK = 0,
+	DWC_ADV_I2C_ABRT_10ADDR1_NOACK = 1,
+	DWC_ADV_I2C_ABRT_10ADDR2_NOACK = 2,
+	DWC_ADV_I2C_ABRT_TXDATA_NOACK = 3,
+	DWC_ADV_I2C_ABRT_GCALL_NOACK = 4,
+	DWC_ADV_I2C_ABRT_GCALL_READ = 5,
+	DWC_ADV_I2C_ABRT_HS_ACKDET = 6,
+	DWC_ADV_I2C_ABRT_SBYTE_ACKDET = 7,
+	DWC_ADV_I2C_ABRT_CTRLR_DIS = 11,
+	DWC_ADV_I2C_ARB_LOST = 12,
+	DWC_ADV_I2C_ABRT_USER_TRMNT = 16,
+	DWC_ADV_I2C_ABRT_SDA_STUCK_AT_LOW = 17,
+};
+
+#define TX_ABRT_7B_ADDR_NOACK	BIT(DWC_ADV_I2C_ABRT_7B_ADDR_NOACK)
+#define TX_ABRT_10ADDR1_NOACK	BIT(DWC_ADV_I2C_ABRT_10ADDR1_NOACK)
+#define TX_ABRT_10ADDR2_NOACK	BIT(DWC_ADV_I2C_ABRT_10ADDR2_NOACK)
+#define TX_ABRT_TXDATA_NOACK	BIT(DWC_ADV_I2C_ABRT_TXDATA_NOACK)
+#define TX_ABRT_GCALL_NOACK	BIT(DWC_ADV_I2C_ABRT_GCALL_NOACK)
+#define TX_ABRT_GCALL_READ	BIT(DWC_ADV_I2C_ABRT_GCALL_READ)
+#define TX_ARB_LOST		BIT(DWC_ADV_I2C_ARB_LOST)
+#define TX_ABRT_USER_TRMNT	BIT(DWC_ADV_I2C_ABRT_USER_TRMNT)
+#define TX_ABRT_NOACK \
+	(TX_ABRT_7B_ADDR_NOACK | \
+	 TX_ABRT_10ADDR1_NOACK | \
+	 TX_ABRT_10ADDR2_NOACK | \
+	 TX_ABRT_TXDATA_NOACK | \
+	 TX_ABRT_GCALL_NOACK)
+
+#define DWC_ADV_I2C_STATUS_SW_ACTIVE		BIT(0)
+#define DWC_ADV_I2C_STATUS_SW_WRITE_IN_PROGRESS	BIT(1)
+#define DWC_ADV_I2C_STATUS_SW_READ_IN_PROGRESS	BIT(2)
+#define DWC_ADV_I2C_STATUS_SW_MASK		GENMASK(2, 0)
+
+#define DWC_ADV_I2C_ABORT_POLL_US		10
+#define DWC_ADV_I2C_ABORT_TIMEOUT_US		100
+#define DWC_ADV_I2C_DISABLE_POLL_US		250
+#define DWC_ADV_I2C_DISABLE_TIMEOUT_US		25000
+
+#define DWC_ADV_I2C_XFER_TIMEOUT_MS		1000
+#define DWC_ADV_I2C_AUTOSUSPEND_DELAY_MS	1000
+
+static const char * const dwc_adv_i2c_abort_sources[] = {
+	[DWC_ADV_I2C_ABRT_7B_ADDR_NOACK] =
+		"target address not acknowledged",
+	[DWC_ADV_I2C_ABRT_10ADDR1_NOACK] =
+		"10-bit first address byte not acknowledged",
+	[DWC_ADV_I2C_ABRT_10ADDR2_NOACK] =
+		"10-bit second address byte not acknowledged",
+	[DWC_ADV_I2C_ABRT_TXDATA_NOACK] =
+		"data not acknowledged",
+	[DWC_ADV_I2C_ABRT_GCALL_NOACK] =
+		"general call not acknowledged",
+	[DWC_ADV_I2C_ABRT_GCALL_READ] =
+		"general call read",
+	[DWC_ADV_I2C_ABRT_HS_ACKDET] =
+		"high speed controller code acknowledged",
+	[DWC_ADV_I2C_ABRT_SBYTE_ACKDET] =
+		"start byte acknowledged",
+	[DWC_ADV_I2C_ABRT_CTRLR_DIS] =
+		"disabled while active",
+	[DWC_ADV_I2C_ARB_LOST] =
+		"arbitration lost",
+	[DWC_ADV_I2C_ABRT_USER_TRMNT] =
+		"terminated by user request",
+	[DWC_ADV_I2C_ABRT_SDA_STUCK_AT_LOW] =
+		"SDA stuck at low",
+};
+
+struct dwc_adv_i2c_regs {
+	u32 enable;
+	u32 con;
+	u32 tar;
+	u32 ss_fs_hcnt;
+	u32 ss_fs_lcnt;
+	u32 hs_hcnt;
+	u32 hs_lcnt;
+	u32 sda_hold;
+	u32 data_cmd;
+	u32 rx_tl;
+	u32 tx_tl;
+	u32 intr_stat;
+	u32 intr_mask;
+	u32 raw_intr_stat;
+	u32 clr_intr;
+	u32 enable_status;
+	u32 tx_abrt_source;
+	u32 status;
+	u32 txflr;
+	u32 rxflr;
+};
+
+struct dwc_adv_i2c_dev {
+	struct device *dev;
+	void __iomem *base;
+	struct clk *clk;
+	struct clk *pclk;
+	struct reset_control *rst;
+	struct i2c_adapter adap;
+	struct completion cmd_complete;
+	struct i2c_bus_recovery_info rinfo;
+
+	struct dwc_adv_i2c_regs regs;
+	u32 tx_fifo_depth;
+	u32 rx_fifo_depth;
+
+	struct i2c_timings timings;
+	bool hs_loading_400pf;
+	u32 sda_hold_time;
+
+	u32 ctrlr_cfg;
+	u32 ss_hcnt;
+	u32 ss_lcnt;
+	u32 fs_hcnt;
+	u32 fs_lcnt;
+	u32 hs_hcnt;
+	u32 hs_lcnt;
+
+	struct i2c_msg *msgs;
+	int msgs_num;
+	int msg_write_idx;
+	int msg_read_idx;
+	int msg_err;
+	int cmd_err;
+	unsigned int status;
+	unsigned int abort_source;
+	int rx_outstanding;
+	bool need_restart;
+
+	u8 *tx_buf;
+	size_t tx_buf_len;
+	u8 *rx_buf;
+	size_t rx_buf_len;
+};
+
+struct dwc_adv_i2c_match_data {
+	u32 tx_fifo_depth;
+	u32 rx_fifo_depth;
+};
+
+static const struct dwc_adv_i2c_match_data tda54_i2c_match_data = {
+	.tx_fifo_depth = 32,
+	.rx_fifo_depth = 32,
+};
+
+static inline u32 dwc_adv_reg_read(struct dwc_adv_i2c_dev *dev, u32 offset)
+{
+	return readl(dev->base + offset);
+}
+
+static inline void dwc_adv_reg_write(struct dwc_adv_i2c_dev *dev, u32 offset, u32 val)
+{
+	writel(val, dev->base + offset);
+}
+
+static int dwc_adv_i2c_next_header(struct dwc_adv_i2c_dev *dev, u32 hdr_offset,
+				   u32 expected_id, u32 *next_offset)
+{
+	u32 hdr = dwc_adv_reg_read(dev, hdr_offset);
+	u32 id = FIELD_GET(DWC_ADV_I2C_HEADER_ID, hdr);
+	u32 length_words = FIELD_GET(DWC_ADV_I2C_HEADER_LENGTH, hdr);
+
+	if (id != expected_id) {
+		return dev_err_probe(dev->dev, -ENODEV,
+				     "header at offset 0x%x has ID 0x%x, expected 0x%x\n",
+				     hdr_offset, id, expected_id);
+	}
+
+	if (!length_words) {
+		return dev_err_probe(dev->dev, -ENODEV,
+				     "zero length header at offset 0x%x\n", hdr_offset);
+	}
+
+	if (next_offset)
+		*next_offset = hdr_offset + length_words * 4;
+
+	return 0;
+}
+
+/*
+ * Register offsets are relative to per-block header registers. Walk the
+ * header chain to find each block, starting from the core block offset.
+ */
+static int dwc_adv_i2c_discover_regs(struct dwc_adv_i2c_dev *dev)
+{
+	struct dwc_adv_i2c_regs *regs = &dev->regs;
+	u32 core_header, timing_header, fifo_header, intr_header, hwid_header;
+	u32 caps, comp_type;
+	int ret;
+
+	regs->enable = DWC_ADV_I2C_OP_ENABLE;
+	caps = dwc_adv_reg_read(dev, DWC_ADV_I2C_OP_I2C_CAPABILITIES);
+	dev->hs_loading_400pf = caps & DWC_ADV_I2C_OP_I2C_CAPABILITIES_LOADING_400;
+	core_header = dwc_adv_reg_read(dev, DWC_ADV_I2C_OP_I2C_BLOCK_OFFSET);
+	if (!core_header)
+		return dev_err_probe(dev->dev, -ENODEV, "no I2C block offset\n");
+
+	regs->con = core_header + DWC_ADV_I2C_CORE_CON;
+	regs->tar = core_header + DWC_ADV_I2C_CORE_TAR;
+
+	ret = dwc_adv_i2c_next_header(dev, core_header,
+				      DWC_ADV_I2C_HEADER_ID_CORE, &timing_header);
+	if (ret)
+		return ret;
+
+	regs->ss_fs_hcnt = timing_header + DWC_ADV_I2C_TIMING_HCNT;
+	regs->ss_fs_lcnt = timing_header + DWC_ADV_I2C_TIMING_LCNT;
+	regs->hs_hcnt = timing_header + DWC_ADV_I2C_TIMING_HS_HCNT;
+	regs->hs_lcnt = timing_header + DWC_ADV_I2C_TIMING_HS_LCNT;
+	regs->sda_hold = timing_header + DWC_ADV_I2C_TIMING_SDA_HOLD;
+
+	ret = dwc_adv_i2c_next_header(dev, timing_header,
+				      DWC_ADV_I2C_HEADER_ID_TIMING, &fifo_header);
+	if (ret)
+		return ret;
+
+	regs->data_cmd = fifo_header + DWC_ADV_I2C_FIFO_DATA_CMD;
+	regs->rx_tl = fifo_header + DWC_ADV_I2C_FIFO_RX_TL;
+	regs->tx_tl = fifo_header + DWC_ADV_I2C_FIFO_TX_TL;
+
+	ret = dwc_adv_i2c_next_header(dev, fifo_header,
+				      DWC_ADV_I2C_HEADER_ID_FIFO, &intr_header);
+	if (ret)
+		return ret;
+
+	regs->intr_stat = intr_header + DWC_ADV_I2C_INTR_INTR_STAT;
+	regs->intr_mask = intr_header + DWC_ADV_I2C_INTR_INTR_MASK;
+	regs->raw_intr_stat = intr_header + DWC_ADV_I2C_INTR_RAW_INTR_STAT;
+	regs->clr_intr = intr_header + DWC_ADV_I2C_INTR_CLR_INTR;
+	regs->enable_status = intr_header + DWC_ADV_I2C_INTR_ENABLE_STATUS;
+	regs->tx_abrt_source = intr_header + DWC_ADV_I2C_INTR_TX_ABRT_SOURCE;
+	regs->status = intr_header + DWC_ADV_I2C_INTR_STATUS;
+	regs->txflr = intr_header + DWC_ADV_I2C_INTR_TXFLR;
+	regs->rxflr = intr_header + DWC_ADV_I2C_INTR_RXFLR;
+
+	ret = dwc_adv_i2c_next_header(dev, intr_header,
+				      DWC_ADV_I2C_HEADER_ID_INTR_DEBUG, &hwid_header);
+	if (ret)
+		return ret;
+
+	ret = dwc_adv_i2c_next_header(dev, hwid_header,
+				      DWC_ADV_I2C_HEADER_ID_HWID, NULL);
+	if (ret)
+		return ret;
+
+	comp_type = dwc_adv_reg_read(dev, hwid_header + DWC_ADV_I2C_HWID_COMP_TYPE);
+	if (comp_type != DWC_ADV_I2C_COMP_TYPE_VALUE)
+		return dev_err_probe(dev->dev, -ENODEV,
+				     "unknown Synopsys component type: 0x%08x\n",
+				     comp_type);
+
+	return 0;
+}
+
+static void dwc_adv_i2c_ack_intr(struct dwc_adv_i2c_dev *dev, u32 clr_bit)
+{
+	dwc_adv_reg_write(dev, dev->regs.clr_intr, clr_bit);
+}
+
+static u32 dwc_adv_i2c_scl_hcnt(u32 ic_clk, u32 tsymbol, u32 tf, int offset)
+{
+	return DIV_ROUND_CLOSEST_ULL((u64)ic_clk * (tsymbol + tf), MICRO) - 3 + offset;
+}
+
+static u32 dwc_adv_i2c_scl_lcnt(u32 ic_clk, u32 tlow, u32 tf, int offset)
+{
+	return DIV_ROUND_CLOSEST_ULL((u64)ic_clk * (tlow + tf), MICRO) - 1 + offset;
+}
+
+static void dwc_adv_i2c_set_timings(struct dwc_adv_i2c_dev *dev)
+{
+	struct i2c_timings *t = &dev->timings;
+	u32 ic_clk = clk_get_rate(dev->clk) / 1000;
+	u32 sda_falling_time = t->sda_fall_ns ?: 300;
+	u32 scl_falling_time = t->scl_fall_ns ?: 300;
+	u32 t_high, t_low;
+
+	dev->ss_hcnt = dwc_adv_i2c_scl_hcnt(ic_clk, 4000, sda_falling_time, 0);
+	dev->ss_lcnt = dwc_adv_i2c_scl_lcnt(ic_clk, 4700, scl_falling_time, 0);
+
+	if (t->bus_freq_hz == I2C_MAX_FAST_MODE_PLUS_FREQ) {
+		dev->fs_hcnt = dwc_adv_i2c_scl_hcnt(ic_clk, 260, sda_falling_time, 0);
+		dev->fs_lcnt = dwc_adv_i2c_scl_lcnt(ic_clk, 500, scl_falling_time, 0);
+	} else {
+		dev->fs_hcnt = dwc_adv_i2c_scl_hcnt(ic_clk, 600, sda_falling_time, 0);
+		dev->fs_lcnt = dwc_adv_i2c_scl_lcnt(ic_clk, 1300, scl_falling_time, 0);
+	}
+
+	if (dev->hs_loading_400pf) {
+		t_high = 120;
+		t_low = 320;
+	} else {
+		t_high = 60;
+		t_low = 160;
+	}
+	dev->hs_hcnt = dwc_adv_i2c_scl_hcnt(ic_clk, t_high, sda_falling_time, 0);
+	dev->hs_lcnt = dwc_adv_i2c_scl_lcnt(ic_clk, t_low, scl_falling_time, 0);
+}
+
+static void dwc_adv_i2c_write_timings(struct dwc_adv_i2c_dev *dev)
+{
+	u32 speed = dev->ctrlr_cfg & DWC_ADV_I2C_CON_SPEED_MASK;
+
+	if (speed == DWC_ADV_I2C_CON_SPEED_HIGH) {
+		dwc_adv_reg_write(dev, dev->regs.hs_hcnt, dev->hs_hcnt);
+		dwc_adv_reg_write(dev, dev->regs.hs_lcnt, dev->hs_lcnt);
+		dwc_adv_reg_write(dev, dev->regs.ss_fs_hcnt, dev->fs_hcnt);
+		dwc_adv_reg_write(dev, dev->regs.ss_fs_lcnt, dev->fs_lcnt);
+	} else if (speed == DWC_ADV_I2C_CON_SPEED_STD) {
+		dwc_adv_reg_write(dev, dev->regs.ss_fs_hcnt, dev->ss_hcnt);
+		dwc_adv_reg_write(dev, dev->regs.ss_fs_lcnt, dev->ss_lcnt);
+	} else {
+		dwc_adv_reg_write(dev, dev->regs.ss_fs_hcnt, dev->fs_hcnt);
+		dwc_adv_reg_write(dev, dev->regs.ss_fs_lcnt, dev->fs_lcnt);
+	}
+}
+
+static void __dwc_adv_i2c_enable(struct dwc_adv_i2c_dev *dev)
+{
+	dev->status |= DWC_ADV_I2C_STATUS_SW_ACTIVE;
+	dwc_adv_reg_write(dev, dev->regs.enable, DWC_ADV_I2C_ENABLE_ENABLE);
+}
+
+static void __dwc_adv_i2c_disable_nowait(struct dwc_adv_i2c_dev *dev)
+{
+	u32 enable = dwc_adv_reg_read(dev, dev->regs.enable);
+
+	dwc_adv_reg_write(dev, dev->regs.enable, enable & ~DWC_ADV_I2C_ENABLE_ENABLE);
+	dev->status &= ~DWC_ADV_I2C_STATUS_SW_ACTIVE;
+}
+
+static u32 dwc_adv_i2c_try_disable(struct dwc_adv_i2c_dev *dev)
+{
+	__dwc_adv_i2c_disable_nowait(dev);
+
+	return dwc_adv_reg_read(dev, dev->regs.enable_status);
+}
+
+/*
+ * If the controller is holding the bus with an empty TX FIFO, terminate the
+ * transfer first. IC_ENABLE.TERMINATE is only honoured while ENABLE is set.
+ */
+static void __dwc_adv_i2c_disable(struct dwc_adv_i2c_dev *dev)
+{
+	u32 raw_intr_stat = dwc_adv_reg_read(dev, dev->regs.raw_intr_stat);
+	u32 ic_status = dwc_adv_reg_read(dev, dev->regs.status);
+	u32 enable = dwc_adv_reg_read(dev, dev->regs.enable);
+	bool abort_needed = (raw_intr_stat & DWC_ADV_I2C_INTR_CTRLR_ON_HOLD) ||
+			     (ic_status & DWC_ADV_I2C_STATUS_CTRLR_HOLD_TX_FIFO_EMPTY);
+	u32 status;
+	int ret;
+
+	if (abort_needed) {
+		if (!(enable & DWC_ADV_I2C_ENABLE_ENABLE)) {
+			dwc_adv_reg_write(dev, dev->regs.enable, DWC_ADV_I2C_ENABLE_ENABLE);
+			/* Let ENABLE take effect: 10 signaling periods */
+			fsleep(DIV_ROUND_CLOSEST_ULL(10 * MICRO, dev->timings.bus_freq_hz));
+			enable |= DWC_ADV_I2C_ENABLE_ENABLE;
+		}
+		dwc_adv_reg_write(dev, dev->regs.enable, enable | DWC_ADV_I2C_ENABLE_ABORT);
+
+		ret = readl_poll_timeout(dev->base + dev->regs.enable, enable,
+					 !(enable & DWC_ADV_I2C_ENABLE_ABORT),
+					 DWC_ADV_I2C_ABORT_POLL_US,
+					 DWC_ADV_I2C_ABORT_TIMEOUT_US);
+		if (ret)
+			dev_err(dev->dev, "timeout while trying to abort current transfer\n");
+	}
+
+	ret = read_poll_timeout(dwc_adv_i2c_try_disable, status,
+				!(status & DWC_ADV_I2C_ENABLE_ENABLE),
+				DWC_ADV_I2C_DISABLE_POLL_US,
+				DWC_ADV_I2C_DISABLE_TIMEOUT_US, false, dev);
+	if (ret)
+		dev_warn(dev->dev, "timeout in disabling adapter\n");
+}
+
+static void dwc_adv_i2c_init(struct dwc_adv_i2c_dev *dev)
+{
+	__dwc_adv_i2c_disable(dev);
+
+	dwc_adv_i2c_write_timings(dev);
+
+	if (dev->sda_hold_time)
+		dwc_adv_reg_write(dev, dev->regs.sda_hold, dev->sda_hold_time);
+
+	dwc_adv_reg_write(dev, dev->regs.tx_tl, dev->tx_fifo_depth / 2);
+	dwc_adv_reg_write(dev, dev->regs.rx_tl, 0);
+	dwc_adv_reg_write(dev, dev->regs.con, dev->ctrlr_cfg);
+}
+
+static int dwc_adv_i2c_wait_bus_not_busy(struct dwc_adv_i2c_dev *dev)
+{
+	u32 status;
+	int ret;
+
+	ret = readl_poll_timeout(dev->base + dev->regs.status, status,
+				 !(status & DWC_ADV_I2C_STATUS_ACTIVITY),
+				 1000, 20000);
+	if (ret) {
+		dev_warn(dev->dev, "timeout waiting for bus ready\n");
+		i2c_recover_bus(&dev->adap);
+
+		status = dwc_adv_reg_read(dev, dev->regs.status);
+		if (!(status & DWC_ADV_I2C_STATUS_ACTIVITY))
+			ret = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * Wait for the controller to go idle once the transfer has completed (STOP_DET
+ * or TX_ABRT), so that disabling it does not cut the transfer short.
+ * Return: true if it is still active after the timeout.
+ */
+static bool dwc_adv_i2c_is_controller_active(struct dwc_adv_i2c_dev *dev)
+{
+	u32 status;
+
+	status = dwc_adv_reg_read(dev, dev->regs.status);
+	if (!(status & DWC_ADV_I2C_STATUS_CTRLR_ACTIVITY))
+		return false;
+
+	return readl_poll_timeout(dev->base + dev->regs.status, status,
+				  !(status & DWC_ADV_I2C_STATUS_CTRLR_ACTIVITY),
+				  1100, 20000) != 0;
+}
+
+static void dwc_adv_i2c_xfer_init(struct dwc_adv_i2c_dev *dev)
+{
+	struct i2c_msg *msg = &dev->msgs[dev->msg_write_idx];
+	u32 con;
+
+	__dwc_adv_i2c_disable(dev);
+
+	/* If the target address is ten bit address, enable 10BITADDR */
+	con = dev->ctrlr_cfg;
+	if (msg->flags & I2C_M_TEN)
+		con |= DWC_ADV_I2C_CON_10BITADDR_CTRLR;
+	else
+		con &= ~DWC_ADV_I2C_CON_10BITADDR_CTRLR;
+	dwc_adv_reg_write(dev, dev->regs.con, con);
+
+	/*
+	 * With IC_DYNAMIC_TAR_UPDATE the 10-bit addressing mode is controlled
+	 * by IC_TAR bit 12 and the IC_CTRL bit is read-only. This cannot be
+	 * detected from the registers, so always set it.
+	 */
+	dwc_adv_reg_write(dev, dev->regs.tar, msg->addr |
+			   ((msg->flags & I2C_M_TEN) ? DWC_ADV_I2C_TAR_10BITADDR_CTRLR : 0));
+
+	/*
+	 * Enforce disabled interrupts: IC_INTR_MASK resets with TX_EMPTY
+	 * unmasked, which would fire as soon as the controller is enabled.
+	 */
+	dwc_adv_reg_write(dev, dev->regs.intr_mask, 0);
+
+	/* Enable the adapter, then clear and enable interrupts */
+	__dwc_adv_i2c_enable(dev);
+	dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_ALL);
+	dwc_adv_reg_write(dev, dev->regs.intr_mask, DWC_ADV_I2C_CTRLR_INTR_MASK);
+}
+
+/*
+ * Initiate (and continue) low level controller read/write transaction.
+ * This function is only called from dwc_adv_i2c_isr(), and pumps i2c_msg
+ * messages into the TX FIFO. Even if the size of i2c_msg data is longer
+ * than the TX FIFO, it handles everything.
+ */
+static void dwc_adv_i2c_xfer_msg(struct dwc_adv_i2c_dev *dev)
+{
+	struct i2c_msg *msgs = dev->msgs;
+	u32 intr_mask = DWC_ADV_I2C_CTRLR_INTR_MASK;
+	int tx_limit, rx_limit;
+	u32 buf_len = dev->tx_buf_len;
+	u8 *buf = dev->tx_buf;
+	u32 cmd;
+	int rx_tl;
+
+	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
+		u32 flags = msgs[dev->msg_write_idx].flags;
+
+		if (!(dev->status & DWC_ADV_I2C_STATUS_SW_WRITE_IN_PROGRESS)) {
+			buf = msgs[dev->msg_write_idx].buf;
+			buf_len = msgs[dev->msg_write_idx].len;
+		}
+
+		tx_limit = dev->tx_fifo_depth - dwc_adv_reg_read(dev, dev->regs.txflr);
+		rx_limit = dev->rx_fifo_depth - dwc_adv_reg_read(dev, dev->regs.rxflr);
+
+		while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
+			cmd = 0;
+
+			/*
+			 * The bus is held while the TX FIFO is empty unless
+			 * STOP is requested in IC_DATA_CMD, so always set it
+			 * on the last byte of the last message.
+			 *
+			 * i2c-core always sets the buffer length of
+			 * I2C_FUNC_SMBUS_BLOCK_DATA to 1. The length will be
+			 * adjusted when receiving the first byte. Thus we
+			 * can't stop the transaction here.
+			 */
+			if (dev->msg_write_idx == dev->msgs_num - 1 &&
+			    buf_len == 1 && !(flags & I2C_M_RECV_LEN))
+				cmd |= DWC_ADV_I2C_DATA_CMD_STOP;
+
+			/*
+			 * A RESTART is only issued automatically when the
+			 * direction changes. Request it explicitly at the
+			 * start of each following message.
+			 */
+			if (dev->need_restart) {
+				cmd |= DWC_ADV_I2C_DATA_CMD_RESTART;
+				dev->need_restart = false;
+			}
+
+			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
+				/* Avoid rx buffer overrun */
+				if (dev->rx_outstanding >= dev->rx_fifo_depth)
+					break;
+				dwc_adv_reg_write(dev, dev->regs.data_cmd,
+						  cmd | DWC_ADV_I2C_DATA_CMD_READ);
+				rx_limit--;
+				dev->rx_outstanding++;
+			} else {
+				dwc_adv_reg_write(dev, dev->regs.data_cmd, cmd | *buf++);
+			}
+			tx_limit--;
+			buf_len--;
+		}
+
+		dev->tx_buf = buf;
+		dev->tx_buf_len = buf_len;
+
+		/*
+		 * Because we don't know the buffer length in the
+		 * I2C_FUNC_SMBUS_BLOCK_DATA case, we can't stop the
+		 * transaction here. Also disable the TX_EMPTY IRQ while
+		 * waiting for the data length byte to avoid a flood of
+		 * bogus interrupts.
+		 */
+		if (flags & I2C_M_RECV_LEN) {
+			dev->status |= DWC_ADV_I2C_STATUS_SW_WRITE_IN_PROGRESS;
+			intr_mask &= ~DWC_ADV_I2C_INTR_TX_EMPTY;
+			break;
+		}
+
+		if (buf_len > 0) {
+			dev->status |= DWC_ADV_I2C_STATUS_SW_WRITE_IN_PROGRESS;
+			break;
+		}
+		dev->status &= ~DWC_ADV_I2C_STATUS_SW_WRITE_IN_PROGRESS;
+		dev->need_restart = true;
+	}
+
+	/*
+	 * If i2c_msg index search is completed, we don't need TX_EMPTY
+	 * interrupt any more.
+	 */
+	if (dev->msg_write_idx == dev->msgs_num)
+		intr_mask &= ~DWC_ADV_I2C_INTR_TX_EMPTY;
+
+	if (dev->msg_err)
+		intr_mask = 0;
+
+	/*
+	 * Size the RX FIFO threshold to the reads already queued, so the
+	 * controller raises one RX_FULL for the whole burst instead of one per
+	 * received byte. While messages remain to be queued, cap it so RX_FULL
+	 * still arrives in time to drain the FIFO and let the next TX_EMPTY
+	 * queue the rest.
+	 */
+	rx_tl = dev->rx_outstanding;
+	if (dev->msg_write_idx < dev->msgs_num)
+		rx_tl = min_t(int, rx_tl, dev->rx_fifo_depth / 2);
+	dwc_adv_reg_write(dev, dev->regs.rx_tl, rx_tl ? rx_tl - 1 : 0);
+
+	dwc_adv_reg_write(dev, dev->regs.intr_mask, intr_mask);
+}
+
+static u8 dwc_adv_i2c_recv_len(struct dwc_adv_i2c_dev *dev, u8 len)
+{
+	struct i2c_msg *msgs = dev->msgs;
+	u32 flags = msgs[dev->msg_read_idx].flags;
+	u32 intr_mask;
+
+	/*
+	 * Adjust the buffer length and mask the flag
+	 * after receiving the first byte.
+	 */
+	len += (flags & I2C_CLIENT_PEC) ? 2 : 1;
+	dev->tx_buf_len = len - min_t(int, len, dev->rx_outstanding);
+	msgs[dev->msg_read_idx].len = len;
+	msgs[dev->msg_read_idx].flags &= ~I2C_M_RECV_LEN;
+
+	/*
+	 * Received buffer length, re-enable TX_EMPTY interrupt
+	 * to resume the SMBus transaction.
+	 */
+	intr_mask = dwc_adv_reg_read(dev, dev->regs.intr_mask);
+	intr_mask |= DWC_ADV_I2C_INTR_TX_EMPTY;
+	dwc_adv_reg_write(dev, dev->regs.intr_mask, intr_mask);
+
+	return len;
+}
+
+static void dwc_adv_i2c_read(struct dwc_adv_i2c_dev *dev)
+{
+	struct i2c_msg *msgs = dev->msgs;
+	int rx_valid;
+
+	for (; dev->msg_read_idx < dev->msgs_num; dev->msg_read_idx++) {
+		u32 len;
+		u8 *buf;
+
+		if (!(msgs[dev->msg_read_idx].flags & I2C_M_RD))
+			continue;
+
+		if (!(dev->status & DWC_ADV_I2C_STATUS_SW_READ_IN_PROGRESS)) {
+			len = msgs[dev->msg_read_idx].len;
+			buf = msgs[dev->msg_read_idx].buf;
+		} else {
+			len = dev->rx_buf_len;
+			buf = dev->rx_buf;
+		}
+
+		rx_valid = dwc_adv_reg_read(dev, dev->regs.rxflr);
+
+		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
+			u32 data = dwc_adv_reg_read(dev, dev->regs.data_cmd) &
+				   DWC_ADV_I2C_DATA_CMD_DAT;
+
+			if (msgs[dev->msg_read_idx].flags & I2C_M_RECV_LEN) {
+				/*
+				 * STOP is only set after receiving the block
+				 * data response length. When that length is
+				 * invalid, read one more byte with STOP set to
+				 * complete the transaction.
+				 */
+				if (!data || data > I2C_SMBUS_BLOCK_MAX)
+					data = 1;
+
+				len = dwc_adv_i2c_recv_len(dev, data);
+			}
+			*buf++ = data;
+			dev->rx_outstanding--;
+		}
+
+		if (len > 0) {
+			dev->status |= DWC_ADV_I2C_STATUS_SW_READ_IN_PROGRESS;
+			dev->rx_buf_len = len;
+			dev->rx_buf = buf;
+			return;
+		}
+		dev->status &= ~DWC_ADV_I2C_STATUS_SW_READ_IN_PROGRESS;
+	}
+}
+
+/*
+ * Clear the sources individually: IC_CLR_INTR could clear interrupts raised
+ * between reading IC_INTR_STAT and the clear. The abort source is saved
+ * before TX_ABRT is cleared, as clearing also resets IC_TX_TRMNT_SOURCE.
+ */
+static u32 dwc_adv_i2c_read_clear_intrbits(struct dwc_adv_i2c_dev *dev)
+{
+	u32 stat = dwc_adv_reg_read(dev, dev->regs.intr_stat);
+
+	if (stat & DWC_ADV_I2C_INTR_RX_UNDER)
+		dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_RX_UNDER);
+	if (stat & DWC_ADV_I2C_INTR_RX_OVER)
+		dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_RX_OVER);
+	if (stat & DWC_ADV_I2C_INTR_TX_OVER)
+		dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_TX_OVER);
+	if (stat & DWC_ADV_I2C_INTR_RD_REQ)
+		dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_RD_REQ);
+	if (stat & DWC_ADV_I2C_INTR_TX_ABRT) {
+		dev->abort_source = dwc_adv_reg_read(dev, dev->regs.tx_abrt_source);
+		dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_TX_ABRT);
+	}
+	if (stat & DWC_ADV_I2C_INTR_RX_DONE)
+		dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_RX_DONE);
+	if (stat & DWC_ADV_I2C_INTR_ACTIVITY)
+		dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_ACTIVITY);
+	if (stat & DWC_ADV_I2C_INTR_STOP_DET &&
+	    (dev->rx_outstanding == 0 || (stat & DWC_ADV_I2C_INTR_RX_FULL)))
+		dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_STOP_DET);
+	if (stat & DWC_ADV_I2C_INTR_START_DET)
+		dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_START_DET);
+	if (stat & DWC_ADV_I2C_INTR_GEN_CALL)
+		dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_GEN_CALL);
+
+	return stat;
+}
+
+static void dwc_adv_i2c_process_transfer(struct dwc_adv_i2c_dev *dev, u32 stat)
+{
+	if (stat & DWC_ADV_I2C_INTR_TX_ABRT) {
+		/* TX_ABRT flushes the TX/RX FIFOs, nothing left to process */
+		dev->cmd_err |= DWC_ADV_I2C_INTR_TX_ABRT;
+		dev->status &= ~DWC_ADV_I2C_STATUS_SW_MASK;
+		dev->rx_outstanding = 0;
+		dwc_adv_reg_write(dev, dev->regs.intr_mask, 0);
+		goto tx_aborted;
+	}
+
+	if (stat & DWC_ADV_I2C_INTR_RX_FULL)
+		dwc_adv_i2c_read(dev);
+
+	if (stat & DWC_ADV_I2C_INTR_TX_EMPTY)
+		dwc_adv_i2c_xfer_msg(dev);
+
+	/* A STOP in the middle of a read or write is an error */
+	if ((stat & DWC_ADV_I2C_INTR_STOP_DET) &&
+	    (dev->status & (DWC_ADV_I2C_STATUS_SW_WRITE_IN_PROGRESS |
+			     DWC_ADV_I2C_STATUS_SW_READ_IN_PROGRESS))) {
+		dev_err(dev->dev, "spurious STOP, status 0x%x\n", dev->status);
+		dev->rx_outstanding = 0;
+		dev->msg_err = -EIO;
+	}
+
+tx_aborted:
+	if (((stat & (DWC_ADV_I2C_INTR_TX_ABRT | DWC_ADV_I2C_INTR_STOP_DET)) ||
+	     dev->msg_err) && dev->rx_outstanding == 0)
+		complete(&dev->cmd_complete);
+}
+
+static irqreturn_t dwc_adv_i2c_handle_irq(struct dwc_adv_i2c_dev *dev)
+{
+	u32 enabled, stat;
+
+	enabled = dwc_adv_reg_read(dev, dev->regs.enable);
+	stat = dwc_adv_reg_read(dev, dev->regs.raw_intr_stat);
+
+	if (!enabled || !(stat & ~DWC_ADV_I2C_INTR_ACTIVITY))
+		return IRQ_NONE;
+
+	if (stat == GENMASK(31, 0))
+		return IRQ_NONE;
+
+	stat = dwc_adv_i2c_read_clear_intrbits(dev);
+
+	if (!(dev->status & DWC_ADV_I2C_STATUS_SW_ACTIVE)) {
+		dwc_adv_reg_write(dev, dev->regs.intr_mask, 0);
+		return IRQ_HANDLED;
+	}
+
+	dwc_adv_i2c_process_transfer(dev, stat);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dwc_adv_i2c_isr(int irq, void *dev_id)
+{
+	struct dwc_adv_i2c_dev *dev = dev_id;
+	irqreturn_t ret;
+	int pm;
+
+	pm = pm_runtime_get_if_active(dev->dev);
+	if (!pm)
+		return IRQ_NONE;
+
+	ret = dwc_adv_i2c_handle_irq(dev);
+
+	if (pm > 0)
+		pm_runtime_put_autosuspend(dev->dev);
+
+	return ret;
+}
+
+static int dwc_adv_i2c_handle_tx_abort(struct dwc_adv_i2c_dev *dev)
+{
+	u32 abort_source = dev->abort_source;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dwc_adv_i2c_abort_sources); i++) {
+		if (!(abort_source & BIT(i)) || !dwc_adv_i2c_abort_sources[i])
+			continue;
+		if (BIT(i) & (TX_ABRT_NOACK | TX_ABRT_USER_TRMNT))
+			dev_dbg(dev->dev, "%s\n", dwc_adv_i2c_abort_sources[i]);
+		else
+			dev_err(dev->dev, "%s\n", dwc_adv_i2c_abort_sources[i]);
+	}
+
+	if (abort_source & TX_ABRT_NOACK)
+		return -EREMOTEIO;
+	if (abort_source & TX_ARB_LOST)
+		return -EAGAIN;
+	if (abort_source & TX_ABRT_GCALL_READ)
+		return -EINVAL;
+
+	return -EIO;
+}
+
+static bool dwc_adv_i2c_msg_is_valid(struct dwc_adv_i2c_dev *dev,
+				     struct i2c_msg *msgs, int idx)
+{
+	if (idx == 0)
+		return true;
+
+	if (msgs[idx - 1].addr != msgs[idx].addr) {
+		dev_err(dev->dev, "invalid target address\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int dwc_adv_i2c_xfer_one_part(struct dwc_adv_i2c_dev *dev)
+{
+	int ret;
+
+	reinit_completion(&dev->cmd_complete);
+	dev->cmd_err = 0;
+	dev->msg_write_idx = 0;
+	dev->msg_read_idx = 0;
+	dev->msg_err = 0;
+	dev->status = 0;
+	dev->abort_source = 0;
+	dev->rx_outstanding = 0;
+	dev->need_restart = false;
+
+	ret = dwc_adv_i2c_wait_bus_not_busy(dev);
+	if (ret)
+		return ret;
+
+	dwc_adv_i2c_xfer_init(dev);
+
+	if (!wait_for_completion_timeout(&dev->cmd_complete, dev->adap.timeout)) {
+		dev_err(dev->dev, "controller timed out\n");
+		i2c_recover_bus(&dev->adap);
+		dwc_adv_i2c_init(dev);
+		return -ETIMEDOUT;
+	}
+
+	if (dwc_adv_i2c_is_controller_active(dev)) {
+		/*
+		 * If the controller is still active after the timeout, attempt a
+		 * bus recovery to clear any potentially locked state.
+		 */
+		dev_err(dev->dev, "controller active after xfer, recovering\n");
+		i2c_recover_bus(&dev->adap);
+		dwc_adv_i2c_init(dev);
+	} else {
+		/*
+		 * Disable the controller before returning, so that late
+		 * interrupts do not race with the following transfer.
+		 */
+		__dwc_adv_i2c_disable_nowait(dev);
+	}
+
+	if (dev->msg_err)
+		return dev->msg_err;
+
+	if (!dev->cmd_err && !dev->status)
+		return 0;
+
+	if (dev->cmd_err & DWC_ADV_I2C_INTR_TX_ABRT)
+		return dwc_adv_i2c_handle_tx_abort(dev);
+
+	if (dev->status)
+		dev_err(dev->dev, "transfer terminated early, status 0x%x\n", dev->status);
+
+	return -EIO;
+}
+
+static int dwc_adv_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	struct dwc_adv_i2c_dev *dev = i2c_get_adapdata(adap);
+	int ret, idx, start = 0;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	for (idx = 0; idx < num; idx++) {
+		if (!dwc_adv_i2c_msg_is_valid(dev, &msgs[start], idx - start))
+			return -EINVAL;
+
+		if (!(msgs[idx].flags & I2C_M_STOP) && idx != num - 1)
+			continue;
+
+		dev->msgs = &msgs[start];
+		dev->msgs_num = idx - start + 1;
+
+		ret = dwc_adv_i2c_xfer_one_part(dev);
+		if (ret)
+			return ret;
+
+		start = idx + 1;
+	}
+
+	return num;
+}
+
+static u32 dwc_adv_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA |
+	       I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BLOCK_DATA |
+	       I2C_FUNC_SMBUS_I2C_BLOCK | I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
+}
+
+static const struct i2c_algorithm dwc_adv_i2c_algo = {
+	.xfer = dwc_adv_i2c_xfer,
+	.functionality = dwc_adv_i2c_func,
+};
+
+static const struct i2c_adapter_quirks dwc_adv_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
+static int dwc_adv_i2c_prepare_clk(struct dwc_adv_i2c_dev *dev, bool prepare)
+{
+	int ret;
+
+	if (!prepare) {
+		clk_disable_unprepare(dev->clk);
+		clk_disable_unprepare(dev->pclk);
+		return 0;
+	}
+
+	ret = clk_prepare_enable(dev->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dev->clk);
+	if (ret)
+		clk_disable_unprepare(dev->pclk);
+
+	return ret;
+}
+
+static void dwc_adv_i2c_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct dwc_adv_i2c_dev *dev = i2c_get_adapdata(adap);
+
+	__dwc_adv_i2c_disable(dev);
+	reset_control_assert(dev->rst);
+	dwc_adv_i2c_prepare_clk(dev, false);
+}
+
+static void dwc_adv_i2c_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct dwc_adv_i2c_dev *dev = i2c_get_adapdata(adap);
+	int ret;
+
+	ret = dwc_adv_i2c_prepare_clk(dev, true);
+	if (ret) {
+		dev_err(dev->dev, "failed to enable clock for recovery: %d\n", ret);
+		reset_control_deassert(dev->rst);
+		return;
+	}
+
+	reset_control_deassert(dev->rst);
+	dwc_adv_i2c_init(dev);
+}
+
+static int dwc_adv_i2c_init_recovery_info(struct dwc_adv_i2c_dev *dev)
+{
+	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
+
+	rinfo->scl_gpiod = devm_gpiod_get_optional(dev->dev, "scl", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(rinfo->scl_gpiod))
+		return PTR_ERR_OR_ZERO(rinfo->scl_gpiod);
+
+	rinfo->sda_gpiod = devm_gpiod_get_optional(dev->dev, "sda", GPIOD_IN);
+	if (IS_ERR(rinfo->sda_gpiod))
+		return PTR_ERR(rinfo->sda_gpiod);
+
+	rinfo->pinctrl = devm_pinctrl_get(dev->dev);
+	if (IS_ERR(rinfo->pinctrl)) {
+		if (PTR_ERR(rinfo->pinctrl) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		rinfo->pinctrl = NULL;
+	}
+
+	rinfo->recover_bus = i2c_generic_scl_recovery;
+	rinfo->prepare_recovery = dwc_adv_i2c_prepare_recovery;
+	rinfo->unprepare_recovery = dwc_adv_i2c_unprepare_recovery;
+	dev->adap.bus_recovery_info = rinfo;
+
+	return 0;
+}
+
+static void dwc_adv_i2c_configure_controller(struct dwc_adv_i2c_dev *dev)
+{
+	dev->ctrlr_cfg = DWC_ADV_I2C_CON_CONTROLLER;
+
+	switch (dev->timings.bus_freq_hz) {
+	case I2C_MAX_STANDARD_MODE_FREQ:
+		dev->ctrlr_cfg |= DWC_ADV_I2C_CON_SPEED_STD;
+		break;
+	case I2C_MAX_HIGH_SPEED_MODE_FREQ:
+		dev->ctrlr_cfg |= DWC_ADV_I2C_CON_SPEED_HIGH;
+		break;
+	default:
+		dev->ctrlr_cfg |= DWC_ADV_I2C_CON_SPEED_FAST;
+		break;
+	}
+}
+
+static int dwc_adv_i2c_parse_fw(struct dwc_adv_i2c_dev *dev)
+{
+	struct device *device = dev->dev;
+
+	i2c_parse_fw_timings(device, &dev->timings, false);
+	if (!dev->timings.bus_freq_hz)
+		dev->timings.bus_freq_hz = I2C_MAX_FAST_MODE_FREQ;
+
+	switch (dev->timings.bus_freq_hz) {
+	case I2C_MAX_STANDARD_MODE_FREQ:
+	case I2C_MAX_FAST_MODE_FREQ:
+	case I2C_MAX_FAST_MODE_PLUS_FREQ:
+	case I2C_MAX_HIGH_SPEED_MODE_FREQ:
+		break;
+	default:
+		return dev_err_probe(device, -EINVAL, "invalid clock-frequency %u\n",
+				     dev->timings.bus_freq_hz);
+	}
+
+	return 0;
+}
+
+static int dwc_adv_i2c_runtime_suspend(struct device *device)
+{
+	struct dwc_adv_i2c_dev *dev = dev_get_drvdata(device);
+
+	__dwc_adv_i2c_disable(dev);
+	dwc_adv_i2c_prepare_clk(dev, false);
+
+	return 0;
+}
+
+static int dwc_adv_i2c_runtime_resume(struct device *device)
+{
+	struct dwc_adv_i2c_dev *dev = dev_get_drvdata(device);
+	int ret;
+
+	ret = dwc_adv_i2c_prepare_clk(dev, true);
+	if (ret)
+		return ret;
+
+	dwc_adv_i2c_init(dev);
+
+	return 0;
+}
+
+static int dwc_adv_i2c_suspend(struct device *device)
+{
+	struct dwc_adv_i2c_dev *dev = dev_get_drvdata(device);
+
+	i2c_mark_adapter_suspended(&dev->adap);
+
+	return pm_runtime_force_suspend(device);
+}
+
+static int dwc_adv_i2c_resume(struct device *device)
+{
+	struct dwc_adv_i2c_dev *dev = dev_get_drvdata(device);
+	int ret;
+
+	ret = pm_runtime_force_resume(device);
+	if (ret)
+		return ret;
+
+	i2c_mark_adapter_resumed(&dev->adap);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dwc_adv_i2c_pm_ops = {
+	LATE_SYSTEM_SLEEP_PM_OPS(dwc_adv_i2c_suspend, dwc_adv_i2c_resume)
+	RUNTIME_PM_OPS(dwc_adv_i2c_runtime_suspend, dwc_adv_i2c_runtime_resume, NULL)
+};
+
+static void dwc_adv_i2c_pm_teardown(void *data)
+{
+	struct dwc_adv_i2c_dev *dev = data;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev->dev);
+	if (!ret)
+		__dwc_adv_i2c_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev->dev);
+	if (!ret)
+		pm_runtime_put_noidle(dev->dev);
+	pm_runtime_disable(dev->dev);
+}
+
+static int dwc_adv_i2c_probe(struct platform_device *pdev)
+{
+	struct device *device = &pdev->dev;
+	const struct dwc_adv_i2c_match_data *match_data;
+	struct dwc_adv_i2c_dev *dev;
+	int irq, ret;
+
+	match_data = device_get_match_data(device);
+	if (!match_data)
+		return -ENODEV;
+
+	dev = devm_kzalloc(device, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->dev = device;
+	dev->tx_fifo_depth = match_data->tx_fifo_depth;
+	dev->rx_fifo_depth = match_data->rx_fifo_depth;
+
+	dev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dev->base))
+		return PTR_ERR(dev->base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	dev->rst = devm_reset_control_get_optional_exclusive_deasserted(device, NULL);
+	if (IS_ERR(dev->rst))
+		return dev_err_probe(device, PTR_ERR(dev->rst), "failed to get reset\n");
+
+	ret = dwc_adv_i2c_parse_fw(dev);
+	if (ret)
+		return ret;
+
+	dwc_adv_i2c_configure_controller(dev);
+
+	dev->pclk = devm_clk_get_enabled(device, "pclk");
+	if (IS_ERR(dev->pclk))
+		return dev_err_probe(device, PTR_ERR(dev->pclk), "failed to get pclk\n");
+
+	dev->clk = devm_clk_get_enabled(device, "ref");
+	if (IS_ERR(dev->clk))
+		return dev_err_probe(device, PTR_ERR(dev->clk), "failed to get ref clock\n");
+
+	ret = dwc_adv_i2c_discover_regs(dev);
+	if (ret)
+		return ret;
+
+	if (dev->timings.sda_hold_ns)
+		dev->sda_hold_time =
+			DIV_S64_ROUND_CLOSEST((s64)clk_get_rate(dev->clk) / 1000 *
+					      dev->timings.sda_hold_ns, MICRO);
+
+	dwc_adv_i2c_set_timings(dev);
+
+	init_completion(&dev->cmd_complete);
+
+	platform_set_drvdata(pdev, dev);
+
+	ret = devm_request_irq(device, irq, dwc_adv_i2c_isr, 0, dev_name(device), dev);
+	if (ret)
+		return dev_err_probe(device, ret, "failed to request irq %d\n", irq);
+
+	ret = dwc_adv_i2c_init_recovery_info(dev);
+	if (ret)
+		return dev_err_probe(device, ret, "failed to init bus recovery\n");
+
+	i2c_set_adapdata(&dev->adap, dev);
+	dev->adap.owner = THIS_MODULE;
+	strscpy(dev->adap.name, "Synopsys Advanced I2C adapter",
+		sizeof(dev->adap.name));
+	dev->adap.algo = &dwc_adv_i2c_algo;
+	dev->adap.quirks = &dwc_adv_i2c_quirks;
+	dev->adap.dev.parent = device;
+	dev->adap.timeout = msecs_to_jiffies(DWC_ADV_I2C_XFER_TIMEOUT_MS);
+	dev->adap.retries = 3;
+	device_set_node(&dev->adap.dev, dev_fwnode(device));
+
+	dwc_adv_i2c_init(dev);
+
+	pm_runtime_set_autosuspend_delay(device, DWC_ADV_I2C_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(device);
+	ret = pm_runtime_set_active(device);
+	if (ret)
+		return dev_err_probe(device, ret, "failed to set runtime PM active\n");
+
+	pm_runtime_enable(device);
+
+	ret = devm_add_action_or_reset(device, dwc_adv_i2c_pm_teardown, dev);
+	if (ret)
+		return ret;
+
+	return devm_i2c_add_adapter(device, &dev->adap);
+}
+
+static const struct of_device_id dwc_adv_i2c_of_match[] = {
+	{ .compatible = "ti,tda54-i2c", .data = &tda54_i2c_match_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dwc_adv_i2c_of_match);
+
+static struct platform_driver dwc_adv_i2c_driver = {
+	.probe = dwc_adv_i2c_probe,
+	.driver = {
+		.name = "i2c-dwc-adv",
+		.of_match_table = dwc_adv_i2c_of_match,
+		.pm = pm_ptr(&dwc_adv_i2c_pm_ops),
+	},
+};
+module_platform_driver(dwc_adv_i2c_driver);
+
+MODULE_AUTHOR("Aniket Limaye <a-limaye@ti.com>");
+MODULE_DESCRIPTION("Synopsys Advanced I2C (DWC_i2c) driver");
+MODULE_LICENSE("GPL");

-- 
2.53.0

