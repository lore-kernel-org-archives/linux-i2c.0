Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343056;
	b=Gz6XNIDq5oxJf3OelKwfBkQ0qk/DRyUnqqG+/lZLhkm0QrYpzuWKBkSSqPdN2a+mcs5x
	 fTq3bGtgmSb2PPCbr+xEFFb0/ypMSkPQLdcKqEjrWeEAnExq+PJHy53+JF3ThgCiUi9NT
	 mL+J38wXnDg4JUUzVsty/PAv2O+h/EDu0lSN8tF0kgeZI6rgjPeDDUdaatIjdWkEGVSED
	 VchJe8Y+tQSZb0gGaH6PYH7qVhjIrY9p+yIAYeYZdx1G4uVq727QlhWh+1e5P4skHcFc6
	 CVC6DuAoGGnXpLAza1/ZPmYPC1hrwqWIFjbcW1lHL1ufKXtkvutkKWcVGIoTYGhLlLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343056;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zm7tggqn9mzgEY5c5KtY7qxOyXJIjRAzxpRFr/SByaA=;
	b=aGQ4eI9N9zhRq8ka5cRsYOB4VSaDsYNOvwAshJMzz6f3eBnEyZ5v58PCkliACuGQbLHF
	 iD8k1z/9pnrabS+vjRum4T7kJ7dJo/mL4FFNwxpjSBxdQ2EQfwcdDSp7/mMUUyXxTFKnr
	 AgVeElVI5pDiqPTfxJp2LkSRMkk6NHi6cbxCeO+39gFgcL44gKMUcPUNv6Ylsz8go7qI7
	 CE9p/BWTHrcJQSn05vwxDNf7JQUCwfKJoffoV9IFU1cuC4C26sRTeajuxNAlOlfAin4xd
	 xHRCNOIC4Rmt8QWKf/dge1hmSeoWBtnsH8UDLm5/BZw4uz0bdWcUsu3B+sCLN7VwAqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b="oWe/+SxD";
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=GigiU3h0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C7606A326;
	Tue, 10 Nov 2026 20:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA3C7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=oWe/+SxD;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=GigiU3h0
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AAIoQiL3738026;
	Tue, 10 Nov 2026 14:37:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=zm7tggqn9mzgEY5c5KtY7qxOyXJIjRAzxpRFr/SBy
	aA=; b=oWe/+SxDTaSOPJTK1B063KYDn/Ms0DSuOr2dPlgHrLFNvjcR4OWT+BnX6
	IOg65tbOrIvfjNVVpj/cF6gObsE+O1X7+6R70UxMX7w8tPqe4qtG3l0//fdWEmp3
	eAu8ioBck7XqObu/wGJt3YWBuOzR4CoYCV0Ve/Lr14mvxd2uR66EWl38d7MTFFLt
	GqIfn8Hr8SewOLqMhcXJ63VdXfxc2ggoWJM3F+M8J1gJik4uMrUCWkVnyH/dk02e
	uyxVNUwtUzswMg/ZmpKNrc5fInTLMU6scZ+4wmQ/t0zz2EqV5KFZNplp/MEveVlX
	bOg9GWVSX5z9/1IeyGOIZ4Ic1VSmg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hv0j0btmy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 14:37:02 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v358jko3PBhE5uvAZ4ktLdFe+w/843yNZzyQa/A6Zqs3+4dRaRuYCPsRsVSjnVBGeFwFqv7eaPsWc2t3ww7g5dvbnD9gWMeWMHjhLst/+a4ISFBBPXg+HNar+dvdAb/dy/GVddWTd7w9sKcIIYyhdGglBET/EZWge5GTbVC/ZqO3PyQWHMlGe+lZwTCosvblH3hiXSpjyBUAHLUnxFFx/nf96eGVgq12zELyupdMHr+Y1PA9aD76yScANOsNva3zDN1I2GZJtZuTxYyPlYBTzXFvnPVZIFWXvEnef0O0fzCKXQ2s4ycCw4YCrCc4KZM28/mzJUgCwqKinP8XdBCprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm7tggqn9mzgEY5c5KtY7qxOyXJIjRAzxpRFr/SByaA=;
 b=yQXAy6KmA21iPVjJM6BdmtZpnUJMEzCA0mloMu5aZcvmV9N1gPdnxSgjRCMzaDCPS3dmZIxVGiO/nDTifcaSirrlK4UqWjMf6n80zyknD0JmMhpQU2AwuVJWfVCmy/hCXNWMY+nTj7kCv9mUOqIcNtRWEZda5pFtj9CQyRFQVwPbuxVcqnSkugQ8zva573rflnxXW4/zuVWHm/kO9ONJjNTdWxOGJi370SFT2xwpjJqKDwCtM4j/3ybkuX73BG97g/qJp6RUZuNBnkDsOr7PpJ6hLIdLfG8DZ2rjeFfrXYbrhYvXT9VpQdmMMrJeLmglFdlNk/6aoSTztCcw6qcR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=debian.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm7tggqn9mzgEY5c5KtY7qxOyXJIjRAzxpRFr/SByaA=;
 b=GigiU3h0voD99l3gVCIPJaghdMsSg4WS4cArp2lC6G+baKb0fjYHfoCsy5JMvRpO/XKr6vy5OXjiGTg9G7KO86UeYuyTaHCCsrmteC+XzQGh7riT0Q4D9qyM4bT1bjgpQHcMbn/bbZQIAdcDD3On0PUhQftot3+sn4xV1xp/q8c=
Received: from MW4PR03CA0145.namprd03.prod.outlook.com (2603:10b6:303:8c::30)
 by MN2PR10MB4224.namprd10.prod.outlook.com (2603:10b6:208:1d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:36:57 +0000
Received: from SJ1PEPF000037A2.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::10) by MW4PR03CA0145.outlook.office365.com
 (2603:10b6:303:8c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:36:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000037A2.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 20:36:56 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 14:36:38 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 14:36:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 14:36:38 -0600
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAKaTkm2513238;
	Tue, 10 Nov 2026 14:36:34 -0600
From: Aniket Limaye <a-limaye@ti.com>
Date: Wed, 11 Nov 2026 02:05:48 +0530
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add Synopsys DWC_i2c controller
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
Message-ID: <20261111-tda54-upstream-i2c-v5-1-280a4a779b24@ti.com>
References: <20261111-tda54-upstream-i2c-v5-0-280a4a779b24@ti.com>
In-Reply-To: <20261111-tda54-upstream-i2c-v5-0-280a4a779b24@ti.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aniket Limaye <a-limaye@ti.com>,
        <lianfeng.ouyang@starfivetech.com>, <s-jain1@ti.com>,
        <broonie@debian.org>, <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794342990; l=3906;
 i=a-limaye@ti.com; s=20261015; h=from:subject:message-id;
 bh=K1TdPgCur/gRetaSQ7ut1TYz9PctaSQcQouEiQ+bWEU=;
 b=YOcd0ItcItkh+f1EWVK7XMTrPx6fX871Z2MA07kQ0G2EmTz+Ewi1+VJjkK/ReR/idNGb9kZp8
 5lOECylVoHbD1Q7pedfoKtImTpsj4xiTfct0pb+p2alvjuW2NSpyGp0
X-Developer-Key: i=a-limaye@ti.com; a=ed25519;
 pk=n08rZiCmdy5/1c6+3QoI+fu2cHoQt9cw7543u1YgAyw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A2:EE_|MN2PR10MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db93e30-34ec-4270-3e52-08df3f6a5cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|22082099003|18002099003|3023799007|13003099007|56012099006|261022105027099003|10067099003|261102123227099003|261009223027099003|261026121527099003|261028144727099003|261021123027099003|261022113327099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	cMIRYEUWR+6BBkUutyiP+R7KvQrITNfqtanqkcRQjgfj+p8z8qh0VtShxsWHxC0xCcPUuVNHwevIuBScwORI+RJnvZrpGdyjJIreSm5g81piMAZHcWzdOMVUnYxC+NDTDGNirfAr7KmbSHo57QdgiR28nShyE1YjT1ronK5+taf78xWayjzQpqEVjIUajG3mXLemJct2ZjltkJnWLHnOp4e8iVku4am3fWZGLBxEhtcalslI7tY47x853XQcEZdQ7ms+WObNdBTt/F/iuQGo+kSu0SgUchQco4ZTLrT/gCEgjbK5BHlNaGvRc2t/5HU69QFomLz0XfcH0BvQ/BjwrUW3J65ywHYiMuZ7BP5iefE7vjgFX+aEDywF4FaoVnATfdLb0NwQlTjSriPmFArCgT5Rx93XPkkfcYZUTvS+FvgdkGytaIXOQluBxU+1GsfMO6zez5FtO9bSDLEcZ6NbnDDrwPbGkq+VPno46g46p+ql6/R9KZ7KyLIhZ+NP1hOtmY+7svUsginw5XJ+g2re2tnlsJWrjauqNvzs8g1gM74jrKk0Z0jLLFSx6DQkili1vWFZ9JdhPAco15yTDKhuOr4ohsep5HBsmBqL8T2P6D/3cDS3d2+vjtAAE3jtqn6TgJ6NxhejgqfDG6jqsty4cA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(3023799007)(13003099007)(56012099006)(261022105027099003)(10067099003)(261102123227099003)(261009223027099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022113327099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8NHbjVZJ5r4vmdjTeqK9TLSbOw8Vw59pH0oRDf5iJSSKzd90DQHwIMH+R4KjvgOPAhkPj/EVx7eY73+vSYm6P8pi4S0dvQH84WIW1V2eU3/qiPC2lA1KxK3C16w4jH2NkgR3NMhJ67FG5OSg5qTuOAJ29bucLthjwF3CvYV/y/ITq6bUldGAmUBCMlhpS+TXbTogLVmrsSEuo4rzwL7SWB58Cj57l2thD1eAnI8nudWJqBL+Q/rHgLw4NjUMOxu6necrbj1wuYdrztfAdo3g4smf8X9pjZMAY4AdIsuCWI/+eyFuDNCcjGlol/o07G6O7qs+EAI5pUDHZYE/YQhfFQGr667UXlZJt2l1XZFcRxRAMGjXmkmYHst6N721+VRLFPMjKgX8nm9IDjTHi+Z93wIHXWX1jObmL2RzQgCcHl5i/VMHGU9aZkHZwfP48j4i
X-Exchange-RoutingPolicyChecked:
	LwnD1Js4/bfU8vYZdceY78CaNBgWvtMTSyNKqqWI6J+2Crd1NvigHrTi4++KmOhXII0vZt/CaPKcrxyhTRYjxtr3/EDpEshN28yXQ0zcR50NzsJY3IoswTawE8TCLZqydDEDkbb0iJ3lfLPDwscsUrnFtVkB80wb2JQTG3yM5uCaCE5/eh0S7HTu6SOkwciswc3Zo/ZK8zdt2AU04tJ7O4vZK6ANS73b5qsbo/aVjvYXpnXPTTP2uIwzBk2BVOXoKebiyFJaQAdcCMivdfoZ5/lffLKb9hvQrfUZDqKAqujE7g1shha2+X+HqI/9o3D0Rip54h02vFxt0s22Y59HCQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:36:56.2867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db93e30-34ec-4270-3e52-08df3f6a5cb3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4224
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4MSBTYWx0ZWRfX08QePZ+4L5+i
 397JRq8rQk1K7ccERgz1yMPKkngq+07BORl8/cXQ34x9d0a/FDEf9XYczaBC/IXKq9s3vSSJtwP
 YMiwH9gQllout+Mka94HU4ISJkHiw+Wqle+9MoCoSn71YE9IHD03PLlSWkILnhFVaXXxxlFaMui
 eEQ2L9Q8U0CzE8uxL2OoKe9kjjFtduzfErkvFq4PYlwG24gXQKLv1Q2EH+9ogSjqUGK4FlIR+TZ
 /cUeTAOQ8QxJImHwf8hjI7+z07wO8+9jfHxKf06zidfyWx4slR4Lt7HljyeDQi7NzR3y7k1b9dC
 WCyJV4cENHHbITGK0cKAdOBkzfL//ObN4OA02GV9SibUI8q9eweEr3hFDIS3O2Psy2k3D4IIqbh
 KiuvnUHbcd6jNDRwVMZPgh5V/q1ib8z0SNACPxW9JXPO42//IvEx3lkVjMKyS2PQDOYLbAUFerz
 46BoPyxtR4ZveLsCpfA==
X-Proofpoint-GUID: IPC3SpGDAXIOQaAoW0D3Cy4QlyDT9lIh
X-Proofpoint-ORIG-GUID: IPC3SpGDAXIOQaAoW0D3Cy4QlyDT9lIh
X-Authority-Analysis: v=2.4 cv=BrgIUoX5 c=1 sm=1 tr=0 ts=6af3806e cx=c_pps
 a=lV9semjb6HF4qJ8WeHToSQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=gEfo2CItAAAA:8 a=baaPCjhr8G5CHDsqmTYA:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4MSBTYWx0ZWRfX7sDfA7ySGHlp
 bysZc9qFTLHyXucbGWUGHQe09tiMkNn194DQjkL7gzXt0qOWkOCRAc0rwQ5sFAg4Utk1EjBPkrR
 JMEu0cSYL6jENlJpXslvxgi/kDgEFAA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100081

Add documentation for the Synopsys Advanced I2C (DWC_i2c) controller, as
found on the TI TDA54 SoC.

The block cannot work on its own and needs SoC integration, e.g. the
FIFO depths are not discoverable from the IP. Do not add a generic
compatible and only list SoC specific compatibles. The file is named
after the IP so that other SoCs integrating it can be added here.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>

---
Dependencies:
- This patch depends on unreleased dt-schema commit d1fbcafd6716
  ("schemas: i2c: Document i2c-sda-hold-time-ns") [0] for newly added
  "i2c-sda-hold-time-ns" property, without which dt_binding_check will
  fail for Unevaluated properties.
- [0]: https://github.com/devicetree-org/dt-schema/commit/d1fbcafd67168c1f736d81f335a05e18183148c3

Changes in v5:
- Drop the local i2c-sda-hold-time-ns declaration, now provided by
  dt-schema (needs dt-schema commit d1fbcafd67). (Krzysztof Kozlowski)
- DWC_i2c does not specify any constraints on fall times, on top of the
  generic I2C spec. Hence did not add min/max for them (same as v4).
- Link to v4: https://lore.kernel.org/r/20261027-tda54-upstream-i2c-v4-1-ebeeaf87d181@ti.com

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
 .../devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml  | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml
new file mode 100644
index 000000000000..1dd3c61d5826
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml
@@ -0,0 +1,73 @@
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

