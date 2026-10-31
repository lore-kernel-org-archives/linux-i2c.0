Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793440543;
	b=NOqfmjMpcq46Dcjj37/lymmKPld7kz6cXc7uSlwP7DhhqpuBK5lFT7DxVSVq7/otpmHT
	 Djgo2GB8oPNsm5Do86/Ii6SDxUCLS0VBJ6UKEwCNfVZuPH31S6VL4Gqh+75zx7LvCCxZJ
	 mFKECtsct2Wka7qY4GafVC7NnGz44bpTrlytEtmQTkxwqZf7qV7ftBYCf1+0E5dBZI16n
	 salOQTFPzKBRNKLQV0riDXjtvwEvscupv+FmGHxe6yL70fvBaDw6RiDorBnnkwzxUzBnh
	 Huk/iusQLBGqqi4tbndUqaHkm60WyOAVRpmvxIrR1Yl9E1FsxA9oH2dYSIIgoy3XQ+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440543;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UkAZFSPafi7/BvhUHMMafJAHuPfX5WFgwLggA5uGR34=;
	b=zO+Zf9pFYpveTqMGgO6rW0Ysio+xfqp9iqkkA8mjJwbt4tbyUhdIhb/kwPkvYlX839ko
	 VUbqlYtElOWz3Cd8BiJN9zByergzSytPOKb9YKotYb9G213dlgci3NFh2aTgM+BqjTr5S
	 AR+deJQr1kQjULzMGfz5KTd2SakwUKfOaQ2SrhQ95WH/s4gldeYvhh0Ig40QzkneBOEG9
	 I41x2ulrw5I+Wfs+fQ62HtKgGYTnl/rs9xZNNpJJKA2ZA7Lz+xvfsh/eVB3jmMbshf17O
	 PyDAy6nTv3o5kGJkzG4N/70vvonVpcOBQxuejTzoJRZOytJqxxyPw1WxMiBO/wyTmPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=n8V997Ix;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=N+sU7WLL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F752606A31A;
	Sat, 31 Oct 2026 09:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F752606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=n8V997Ix;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=N+sU7WLL
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69V4c0bi2591190;
	Sat, 31 Oct 2026 04:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=UkAZFSPafi7/BvhUHMMafJAHuPfX5WFgwLggA5uGR
	34=; b=n8V997IxC8JOlVl10xICjjsK/j9NsSmrsFFSVc/rboyKSZZsIqFAbokak
	+fSAX65jxhzm6+A5SObxnHkjQ5xpnnPRYOJdkCGCWbzrqh6vTlYZFcdpq6Y5KawV
	6NoMQq8d+LpiDQ+Hdn54O4v7+PGmBqVShsxN1zVDu92Yt0dArp2E60jqe0MlPG6k
	lEAzAfgo26OjCBIBgdsQRbz4ZT/em5nIgrqcA/5aWjlWqBGA46hsyVsVq60IjIfp
	ATvLQcDb729aOBfnw8ihluW+XNIqneivyQV1VOta0mnpnZQya2t8Gv2S0HYU6Kr3
	XSXHvYeQH1SDFIEQ2IHq9/XX+m/ZA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hn2vyj144-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 31 Oct 2026 04:55:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xv+TDGQXQaB5XvD/zfQOWUjTO87p7/td3NeDcRYBNH3eLKy0U1Js0pvLBUTqBlCV3mzR7eGeAixIsCE6yI3Pf0FoDLprBV6vfkfUXr+xKhd/AAIyQNxl6CbrhqvDpgCALEpRZVrjO9LSWOwxeOA4ico+Y7aEL+nCI5iMQaLqf0CUKAJTp9pd7TFLxJhbE5yZQ3GJRbuU/Oi5l0JZ9klpuCT3msiflGVQknMzlgTsjDUC/oZ771Gsl55rjtRwjsd0Iisl8fSky9FgHAn8V/PLSwA5+jPF00yNFko0bniNEo678B1uMD3fQ12LQaYrkyW9T9ougDP83mJMdc1/DIqFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkAZFSPafi7/BvhUHMMafJAHuPfX5WFgwLggA5uGR34=;
 b=lC7WoUrzpU+LttZUbE/WxBeOXpsn5lHVgMIcBX/OZhU4Z5Igw/q1DYxwG/YAj+/7iMKP93YqmCB8RR/QtToQxON+KycAuseXpqvHaf8id+72XohCSDfScOtTbb92NW3P2ziiu8qgXRpxuGS2iXBmK+i7yA9uAMda+LZ/M1w8+uaOPqXdlxMOEXU42/dyypAHib2vWTbgux8bWfi/c47qqtAmbCKJpKcl1DLuXwrR3Mr9dXrKFq+xyey9YF/rMKgCxcb4lGVsCm5Ea7JfaySD1KeQbkeWGeZkGVLRvdrxJh05fpQ2PTw6f4ognYgsXMq1q3BYpFPXBULMvyBvSmyPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=starfivetech.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkAZFSPafi7/BvhUHMMafJAHuPfX5WFgwLggA5uGR34=;
 b=N+sU7WLLDcJmAJeNnXbTRwUd8ZHSlHY8+OhwxfPWEEyHseq5QP5790Dm6VjGOiGhkvNjRs7C8lm5R51/vqOl58TFhmidh/B/EhC6p18RBnIwkhZfI+P+wjVBfmiKpD52pPDgBC2s3psR36+BCQfzchqeqlLgMkiJVHxjH0an81I=
Received: from CH5PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610:1f0::10)
 by PH7PR10MB6309.namprd10.prod.outlook.com (2603:10b6:510:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 09:55:22 +0000
Received: from BN3PEPF00022BC3.namprd05.prod.outlook.com
 (2603:10b6:610:1f0:cafe::a8) by CH5PR05CA0012.outlook.office365.com
 (2603:10b6:610:1f0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.6 via Frontend Transport; Sat, 31
 Oct 2026 09:55:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF00022BC3.mail.protection.outlook.com (10.167.248.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Sat, 31 Oct 2026 09:55:20 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 31 Oct
 2026 04:54:54 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 31 Oct
 2026 04:54:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 31 Oct 2026 04:54:54 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69V9spEN2446084;
	Sat, 31 Oct 2026 04:54:52 -0500
Message-ID: <d074096f-73ff-47a6-8eb5-c85f0536e3c2@ti.com>
Date: Sat, 31 Oct 2026 15:24:50 +0530
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
Subject: Re: [PATCH v4 2/2] i2c: Add Synopsys Advanced I2C (DWC_i2c) driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lianfeng.ouyang@starfivetech.com>
References: <20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com>
 <20261027-tda54-upstream-i2c-v4-2-ebeeaf87d181@ti.com>
 <auGgVBEHvowseCt0@monoceros>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <auGgVBEHvowseCt0@monoceros>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC3:EE_|PH7PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 548f1006-4a47-4d00-476f-08df3735130d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|22082099003|18002099003|4143699003|56012099006|10067099003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	g6W1gCgZy2xKXbiSAcos4Q5C1eO44U+X56vusscyQ8lPZHD6/eeDDMfAiI0xpx4jCbduLpZk7bVpPbn8dXv2A1J0ay2DdE7YE5rudhyV2XoMT99Vk3BknOoNWPpVtwRD8koLFfLuIZ+AGQB2PKcCaN5y3fXpTaRtbGEO+uyEDBj8blhcWmeu1DI42wOEE1w/UGekNIv+HpbH5To5WA56worSsVh6Hq/+rr19P2xSgtVu7iBPv/f441DvtO/gNTmj7aJmq5A+3m/xYVJCLfzHqsJ0DCLAGHlJKjVJse8Alv8a43PErq9sW9TDZHpOODofhwUOafhOyUnyP5VTTceYhmeAHXuuYZmg2FfQ12Dknf9KICiG5EW00ZYhAtfQZ8Ugz1pDQSI0drI6Mvu5G84D2pABPqcCK+teAQSnXpAnb7oeHz7Q6Z2lipxdWPwPnj7S+fv7aJEJrcBNgbCpndN7BLZ0poDJka7FFjFiQaQtuQmnTQ1j45oOJOtiS2rvPukPgTVanuKJ/ad2lbdXiQusQTTUvYgqvEGBLq5Q9DXttlEyHIMKpSui+AXXMHOiBGKVvVgSHyES0vKrwmRJh5M95OU4ZoegoHtSIjt1IWYKT6wLrDqvip1hVxgz2l2qKLKo1JrLril+01UMJ6ATfDO7v499HDMsl9N0HtKlfsXIZW4q9wQ0wbw11RI8+5uGzSClEiAQ9SOTCHUHHSpfpuXxvQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(261026121527099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ADkaripElhn65APTn1Ngso5sgXHPjwjVmkJB9xBOOcwDZtjkfTEaUEeP0YLjIyalcQTmTETeQBsfgtk3JZpngv1Npyh/iYzh1DoqMpcc9jqtaOG8ZksOb1javGR9Pthl+AO3WkCw36NG5Z5EZ7PxACLKwpamYqDCro5XJ6lUAHV7dD+oonsfN15ZK8lh2fYNDcJ7WgZA6lzrJDwueEl7JNru07L05Q+metANzubbgsUsr5dp6fk0qBGnD9BUQAYQHhUIGA9VqzsNWZuMdJt30KA59hAWqiB044Zp6qR3oz69W8JRQgufYdeaoVZgr3OgS+abvo5crwQq2BlaxEH2YfezV62iq4xqFq1VzMT8Bq90NxaCLagn4U+TWmWzn+1VEEstQt00TwU3j5UyAeZIzdl/BEmXPlUkUqHqJ6ayy5/r9fuk3cNblP9NPqgJRLPb
X-Exchange-RoutingPolicyChecked:
	P38hzpgVRJ2nyJHVTEISZwcn6uB78PiIQQlPrKX6VBvjZbqh21S4wpHA/Qizz5+we3a0OSLVB927iyFvRwc1V/v52X5KTPQ2Wcbrr3oHsNBiJrlSnbaTACo7h8HRZLvYWPw4DD5FfkVtR2OZCquB19OIKJUsWJtZGZD0e224dH2MuZ1CCsWngHWvo8INBjJzsLcJdf/7720I9Df0MA6PsuminWssDfarXUFPH908Bn92Ucpnpv0NUp6nNkr/Y7GRLpvgv0PddUA88oNzSrRJgLfomuBwDwN2vfuluzwvCKW1P9AHTEhNHMFm9iXSz0YysBlANG2Gd915CQlFWIWdAA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 09:55:20.1100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 548f1006-4a47-4d00-476f-08df3735130d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6309
X-Proofpoint-ORIG-GUID: tcheq0lKJiSDl9tWLFFSuqaV4ecvAPoZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAzOSBTYWx0ZWRfX7XbDKvvy1I4Z
 yDzB2XZky7Pos/HzG/lXVhM/C1qCw1kmhhZwggUinVSWiUR25f2XFVlGipZTsVSckyeDKVQA718
 mWqzaiV4draZI15g+nFSdjredDGc0Jx2YhXSq9vtFVg1zY7CalZDOUbyzZC6dkhb6l2D87BSGZm
 D+PzNvpyctJ77dRB9UXISghIGouH9yeHRD3CqWP4Y868Oka1RfXIxugNCzCh2bmwrQcdUDsC50T
 GsQJqdq0nIKCZwoLTYFSdp9DhNIkhy8iix2gZWpenyKzyYMUyJRq4L9Ikx4HVcXkSqVGoonki8r
 iPcqEl4KSvLLXT9HUW1wm34f6ULdU10aplKLWDeYuyVbiHMRe0NDhGE0UYB1e2j0vsQFJEXSHJJ
 Nui8ddx8+4D1M8p3DiVViAy5BgsH0K09XG3Ee8NmhLhOT6U/wOQeYph9ay/9VlgHQlQM58gAWXT
 O0A0tmb0lSAG+nAjhHw==
X-Proofpoint-GUID: tcheq0lKJiSDl9tWLFFSuqaV4ecvAPoZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAzOSBTYWx0ZWRfX2841tJ9fRSM1
 Tl6tAnnrPfWvOs71OepBcE0uaCeoyYY3wrx/yE+sprrh+d5tEh3PPYRQJp1q3ahOd9xD6Iw9eP+
 hYUc/cUTwk8gWkSr0x/NN2INQqTwc+s=
X-Authority-Analysis: v=2.4 cv=OIuyTiaB c=1 sm=1 tr=0 ts=6ae5bb0c cx=c_pps
 a=zi9RuwRnjJAIHZVcFFhnlA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=cjH4zlM6ic4bi_ZhpVcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310039



On 28/10/26 12:44, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Oct 27, 2026 at 05:00:36PM +0530, Aniket Limaye wrote:
>> +#include <linux/mod_devicetable.h>
>> [...]
>> +#include <linux/platform_device.h>
> 
> Please don't include <linux/mod_devicetable.h>.
> <linux/platform_device.h> already gives you everything you'd expect from
> <linux/mod_devicetable.h> without introducing a bunch of unneeded build
> dependencies.
> 
> Best regards
> Uwe

Noted, will fix this in next version

Thanks for the review!
Aniket

