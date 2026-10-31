Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793442530;
	b=Uaw9pg7//Bh/apfaCsn/sSrmshJL1ukIKJ8qB2LNx3Tu+aHvimTSoijbCT05VTXlucbv
	 lnUOtf2MYWeT8BN1hSz+xUsl3rOLM+Isen/mAjWmJIQ7z3EePbV5jSNvQ7sq6iLyZcWol
	 7yxV9GvhsQ156TWttHSvLp8iflH6FMLmuOskyn8q9QySb04oTw7g2WBFLmeVUGI8AmcwG
	 yzeZcYkjQLBs7CL+SGbYnAivqAs3mpripaVzWjjvDnI5svgdHcoaNrIKiQc7p1qWSDc8T
	 8eCYnPUWm6LAzktkNCjgsPmolhlvePbLLEqRgs5uy0GvBF2xzxBht1l+/C64mWUCAjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442530;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RQQnPl3VD4V6nqMh9JMTvIaZOo08TvlimD54gYqVobM=;
	b=e2kwD+6m/whgn+uK8/j/Zmf7LUtaUD0ku2xzmSeRxfeDStHpu5Ju8n1xuM5H4SvCUSSL
	 NKNkS/IUgpzsfBv9yIS+OyXKtW9cxeMwbr89Ei+9h3ljIccv0nHnw3Zbs28rPzV++sLW1
	 6KuYNMQKj+m/4TRLjo8/p0k4o85PyPtt/ESKkIdwYJxe3Zk4JV3WkoONsbrP0aur+hv/Z
	 fzNqc7Y0fp5ZvVhb1CcxYwuWm1/FzKl+3doawe//BK1+6yiE/KXgBod2kK8bjOZwToipe
	 HBUNE1R7pMuuPSfIzpMF6THsVFdND5nTVLF5sKinaAhJWi5ZXsomcy2xoDdnnPgHuQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Gmz3eG+b;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=A6Gu4Rsw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90498606A31C;
	Sat, 31 Oct 2026 10:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90498606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Gmz3eG+b;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=A6Gu4Rsw
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69V9rY981468630;
	Sat, 31 Oct 2026 05:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=RQQnPl3VD4V6nqMh9JMTvIaZOo08TvlimD54gYqVo
	bM=; b=Gmz3eG+bZWu3dh2EhEQ21HKBbmut/f9atttSIi7l2DzHiAnPyAgE6+p18
	artq+OhmaPBIYM9Y6u/ZxxswnH76q8YYVr9/fG4FLoOKGnjvvY//BaxP5IdIRshR
	e+WEQqh9W77sqwvP9kI6rCuc7qxbn3U9M1q8a2O59Z7wVVbvCQz4zXXf8ne85XnB
	3Ps0bRKL71JWGVY4hGUn9NvVgweSWGeQ7CswPZE4Ux6Phju/RKlnuUsr9yZID/kW
	yOOpfj9819ZB2kba4aWSEqfhuutnRL7cht0OX+NI5pm8GbIUbjQbH2f0LKcrksxk
	XApG1186vxmDdtoKgxRllDBsJS7+Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hn2vy258c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 31 Oct 2026 05:28:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBPAOPbmuODlHwYT0LY34up8CuYQFJjjM9L67xj+wEqMOtDZl4rPhnQrUdOBKTMnyVhxbfw+dxQi7d0BpMjbEaAjxoq4jejABm6nGnw/4erfS9EP/37Es304mHwxOLDwxF2a8pGFdscqiitozt/A5myPdjSW4Fa+jwQ9N4O5mLNKKikXOT881OZZNKlQr/DcDkXfb9BnCChCDjVzvcL0XcEpuMrG1JJ3JPKb6NP2mJxuOz2wrZ8kV+uslzsicNOk/qo1G1gUTifSO3MvMZkSZGYaqKpk71NvYqZtyW7G5U3L812wlXeSW4+hFFSPm2s/4TjG87VR9jiFcpnBeESl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQQnPl3VD4V6nqMh9JMTvIaZOo08TvlimD54gYqVobM=;
 b=nrxoGRNh1aPzsTUhXfyGlCtlP23TXE7xhpiaNUMemnc+W/6owyvWBPG/tLBD898koHaxnQP0rg74Qz5wkUfL20snOimH70KEQaol5mbLCwPaG8uyNtE3af5JCP0oI6J22vVB645dCXh+kgP3PPB8ovxKQLacvs7a10v+ZiFAaspEm85ELrgHH74aBwHezFBOLJ67/5RqW1WPA++HNDS2M36Afccjlnoi/5FV2VDoUtPWtfh0Bgf8nvIDGThIIX8zo8CttDRgUVuNwEfw0oHiT/5y0xt7201PHH+g0EJr/FMoh6ES+FVscN5nDjNGLWUqfMpwmPBHlunFIHLgMsGHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQQnPl3VD4V6nqMh9JMTvIaZOo08TvlimD54gYqVobM=;
 b=A6Gu4RswN0JF72ssnjDwQO6Vw85nvi4D0PMVgLRwufLJbicAETM+BMyv1C1ZXHfIzXD+dGeaWy+Xcz4djOf5eQd2YGXn1JKkw1srSlgtQghm3JYPhzsFmjR/D+g05KkEEM0Q6qBiVZoLrNg5R130PsK0bjwGazmSkIVN4gi9eIk=
Received: from MW4PR04CA0169.namprd04.prod.outlook.com (2603:10b6:303:85::24)
 by PH0PR10MB4599.namprd10.prod.outlook.com (2603:10b6:510:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.13; Sat, 31 Oct
 2026 10:28:35 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::10) by MW4PR04CA0169.outlook.office365.com
 (2603:10b6:303:85::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.11 via Frontend Transport; Sat,
 31 Oct 2026 10:28:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Sat, 31 Oct 2026 10:28:34 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 31 Oct
 2026 05:28:31 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 31 Oct
 2026 05:28:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 31 Oct 2026 05:28:31 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69VASR0C2484495;
	Sat, 31 Oct 2026 05:28:28 -0500
Message-ID: <03bf8f02-3270-4f5f-9737-b2fc327c454a@ti.com>
Date: Sat, 31 Oct 2026 15:58:27 +0530
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
To: Mark Brown <broonie@kernel.org>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lianfeng.ouyang@starfivetech.com>,
        Mika Westerberg
	<mika.westerberg@linux.intel.com>
References: <20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com>
 <20261027-tda54-upstream-i2c-v4-2-ebeeaf87d181@ti.com>
 <8e393ecc-9955-4686-8689-5c8e4a105a28@sirena.org.uk>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <8e393ecc-9955-4686-8689-5c8e4a105a28@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|PH0PR10MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e80bee-0752-4503-3736-08df3739b7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|7416014|30052699003|376014|6133799003|22082099003|10067099003|261026121527099003|3023799007|261022075727099003|13003099007|261022105027099003|18002099003|261021135927099003|261009223027099003|261021121427099003|261028144727099003|4143699003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	X/yk/kVs2/CGBxAKTpG13UMYu0fUC9HzDdZL3/nq0scUwch7PI5jAmToRaPciznh/VUzxbgVa4iqppS4TDZjafmFrNWqNztob/UayHthNMCzXVWAuTD6JVxwelEz55b0KG+EtpMQelkrxfbRzI/slrnSlI/b5sV71W1j4KpoGRAOazBA0GvTnJotOjOdwGAaVFWK8Q4xDHdeX1sC3S7DNpMqJa21+lgKd2Hz+OokmINjp+iwj0Ql2pDTqKnoZM0OiFKhC138ShRnRQJ8txaYHP0ehcj6dQEPzzrlhdTAv2MEGJHYWjpGHKJP8dtDW4tLIb0fpcR97kaZvs1AsSSD2NA8hZZqunwVtMiEbs2DgYXMMwksliz/39SGfoTPxZmyr/ikvUfk+oF4dQfZzLr1Tt8H7qE6X+2YOvx6bV2sEwDFB/hJZgQg9dGr4zHGXAu09PTW5ZEKsVj72YNLAoYZFt1GB002SQV8VbtxADtuA4x2DzWHBAIiWWMqX+FBdi5tRV0tVtSlUYoPoNoxWkfK+XRJCvcrKRegdXvVvtNYDh7R/SwRWhGdEialEIIfM+3nuFTr8uTsrjFxPNeWV8le9duElDHmJJeqaXGEJoKgI+ZNMioXKGWl+TXgGr4X+V1obvJFYVPcSeor7kGmSFfB5wr/SJ98yv4iRQ64fiOoHh4=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(7416014)(30052699003)(376014)(6133799003)(22082099003)(10067099003)(261026121527099003)(3023799007)(261022075727099003)(13003099007)(261022105027099003)(18002099003)(261021135927099003)(261009223027099003)(261021121427099003)(261028144727099003)(4143699003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aHt45frNAP/gBskPxOp/nR/M8s6hv4/u0lpM8V6Tm4Vvu1QRfZannL8SgbipWSwsPnvEi4ZBQRH3C5lWnF7oYaA4PvJGi9T5jkp15VgR5cSI4Ta4aYukR2SME7sHGPWjA+a2bmWbpsQeA+fT0Ft8cDERuuWkNcxJLnOYUBKOhpt+1FJ5cVYIA1Km0eH25wzneF56uoXJTjJg9jn6PfW8S5oXMY1x4W/KIdIhUfdnw6QWoQi3cXTUq4o/Iprw8EQjiLKKOOEcPFP8FGBSCNkjjjqoo320J4x2sGpNEkss4yYcCxvEwc+BeAVGtbrLhOpZy3eokq2bz3ZJlLkyXt7pRqkkcAmvqlYgcaEix5lnIYDOe9yBL8JIIoT3nx17pWRdUGxjirl3oSgqabDyYYWhtcvL8GGZ9w0OBkqPITWiwgTM1MImrcUL5TkFl5cmwLNw
X-Exchange-RoutingPolicyChecked:
	C2LweWzFf/NhP1xE60Z6HEAOr8XlT8MZna8XmPZAvyfx+vEQcpeOgeCpycIw5hfKD8Ybq67rB1WqjwtzLBnyCrHsRxFhgvYHtdMzLgYtxl9gmMZhZAfKwEr9QcrvWeQWMjimT3OvGaNDX0/T9PPoiIFX4mzCByYZIlZoFkZ3dgCy8hC3f3tGoUQvxhclwGZPOJckCd77r187zMuQLy+TcrbLiP+7ZLiuVyDKxZPGZPvg1oVfkQhsYXzd3R9QG4KLykdxUoUgWRMel0NkgraQfc4h0kEmp/ZsmuQSt92klzMgILvxBsGTt3CDidL8sKg9OQxmO4F7XDLCARakG1vQPw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 10:28:34.7091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e80bee-0752-4503-3736-08df3739b7ee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4599
X-Authority-Analysis: v=2.4 cv=C9d8WgP+ c=1 sm=1 tr=0 ts=6ae5c2d7 cx=c_pps
 a=rDMf0xV6zgmXoNUq+bKLQg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=bXMA4wecyEjWKH-T8xYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: J42Wpl1QETf14q6fITivgQCjL3wdpjzg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA0MSBTYWx0ZWRfX44SfxswQBKWb
 ttr09fxn0DgR7+jRefCU0qjo5dVpsPp9gAyVlgDqElEzUQMjCxCuV7UTuHyErw5EBxGNU6bf3pF
 bTlgrE0wggKQU8p+9YA8I3aNNijcfC4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA0MSBTYWx0ZWRfX1rjMxyJfjCTv
 qZfsRLt30thpfL/Obgm/Koamv/W6pMyTpCkDdhUcDwxeavJO6i6ds/273eUroyg2lIJNgQPFg5z
 UKHsvW/QRgXDpZAo+rzVRjgZwVTDXC34pjhIP/OjjHQ5dmPdqdfHi4zvCHvSz9Ii6QHjLHQenhZ
 HcmeImMp3vk4odR69Hmjhvmq963nfL20s1ALi4v0XcjQ25ctM9Af073+OCFFvlp8BIenu6MaMTe
 Q7EEZTZXMBKd26v9sXa7YOEADWnA+MY7EVHdCm5Uf+AEvhhSgXXr1/TtLiCAbGJo7zDaU18OxHr
 BUqIqdpx9oX6fJ8udOIiy54iL1F+OnLLcjdit6mXHCM9YbL7s63cK/bY1r+yyTNvDD5BCvf2HUm
 IxJe3PsTLDncaZ7mCjzqiL5i1cB3RBe6VOGf6W+N15azfVn2gxOtMFfa8L7cO4KB6nku2KI/ldf
 8el6yNJtJT2YTxAE7Vg==
X-Proofpoint-ORIG-GUID: J42Wpl1QETf14q6fITivgQCjL3wdpjzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310041



On 27/10/26 22:02, Mark Brown wrote:
> On Tue, Oct 27, 2026 at 05:00:36PM +0530, Aniket Limaye wrote:
>> Add a new platform driver for the Synopsys Advanced I2C (DWC_i2c),
>> controller mode only.
> 
>> The register offsets are defined with respect to header registers for
>> each block. These header registers are discovered at runtime by walking
>> the block header chain.
> 
> This mostly makes sense to me, I've not tested yet and will dig in a bit
> more as part of that but a few minor comments below - I'll let you know
> how my testing goes hopefully later this week.
> 

Sure, let me know how your testing goes.

>> +config I2C_DWC_ADV
>> +	tristate "Synopsys Advanced I2C (DWC_i2c) driver"
>> +	depends on ARCH_K3 || COMPILE_TEST
>> +	help
> 
> The dependency is there due to the whole sadness with being unable to
> discover the FIFO depths so not having a fallback, but as soon as we add
> ACPI bindings we'll have to either drop it or broaden it to be on
> CONFIG_ACPI which gets so broad as to be meaningless.  There's a
> reasonable chance the dependency list will end up unwieldy for the DT
> platforms too.
> 
> Since I believe we're always working with configurable trigger levels
> for the FIFOs I think it might be better to have a fallback compatible
> that uses the IP minimum of two entries in each of the FIFOs, that ought
> to work even if the FIFOs are in reality bigger.  Performance would
> suffer but slow and functional beats not working at all.
> 
> It's really unfortunate that we can't enumerate this from the IP
> directly.
> 

Well, I was going off of direction from v1 [0], where feedback was to 
avoid generic compatible.

Although I do understand that the feedback then was for when I was 
adding support in existing driver, so may not apply directly when adding 
a separate new driver, where having one fallback may make sense?

I personally would rather we keep it simple and not add a fallback, 
which may not really get used since one would want an IP specific fifo 
depth configured in the driver, but willing to add one if that's the norm.

In case we do want a fallback, shall I add a fallback of fifo depths=2 
for both rx/tx? That's what the IP doc seems to say as a minimum for 
their respective configuration parameters.

[0]: 
https://lore.kernel.org/all/20260921141031.GX106095@black.igk.intel.com/

>> +static void dwc_adv_i2c_read(struct dwc_adv_i2c_dev *dev)
>> +{
> 
>> +			if (msgs[dev->msg_read_idx].flags & I2C_M_RECV_LEN) {
>> +				/*
>> +				 * STOP is only set after receiving the block
>> +				 * data response length. When that length is
>> +				 * invalid, read one more byte with STOP set to
>> +				 * complete the transaction.
>> +				 */
>> +				if (!data || data > I2C_SMBUS_BLOCK_MAX)
>> +					data = 1;
>> +
>> +				len = dwc_adv_i2c_recv_len(dev, data);
>> +			}
> 
> It feels off to silently fix up an invalid length, but possibly that's
> the most sensible thing - I didn't cross check what's idiomatic for I2C
> in general.
> 

Yeah, will return with -EPROTO in next version

>> +static irqreturn_t dwc_adv_i2c_handle_irq(struct dwc_adv_i2c_dev *dev)
>> +{
>> +	u32 enabled, stat;
>> +
>> +	enabled = dwc_adv_reg_read(dev, dev->regs.enable);
>> +	stat = dwc_adv_reg_read(dev, dev->regs.raw_intr_stat);
>> +
>> +	if (!enabled || !(stat & ~DWC_ADV_I2C_INTR_ACTIVITY))
>> +		return IRQ_NONE;
> 
> Should we check for enabled before we read the status register
> (microoptimisation is fun!)?

Will take care of in next version

Thanks for the review!
Aniket
