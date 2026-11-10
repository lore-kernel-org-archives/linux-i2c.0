Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343158;
	b=PdaDuUa3E+YUa7pUE/vMFvBuTRIKSqsC76fR9MpNLwC8LP8+9Vt9mexgwPyaLPNQxwhg
	 HMd4uIxrfPNcbUs9ALzkMyrIeOQou0xsW3PEerAn/RJqy37IMQydobrEI/iYRIh/3IUbW
	 Vcz+xgRGGZ/H1xdU1E6y4mvEEjxA3xMXtOq34j3rztTWI4al/2IODy+beWAaHUoJ3+7wB
	 OehgcXkcZ6pwXs//oVs5gtDFojX3V3ykcgNutbXKix2C3NKcwYJ6esFXQkqCqwbT7dBIV
	 buoaOlW6FGGa04p8CQu2K1Kx4Oe8/unk7u5TIeOI8wxNNl4VyCkxxEYmVSjR+fU3+Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343158;
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
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=p8KiIhcEmd44qrTt44+5Rhfj4yROV2cSkOMZ+zwCCfA=;
	b=sLU37oV7euVg6ciBko2jrtJvx5FXH1lDDbY93T25PROgXjL12odP7XsIIHsh3lecbaZU
	 lAri0nbvxlDoJfiuxd1FY+URAXpyUElHx/5dmlsVyxQZhGFLFF36f7mup50yk1WweJHta
	 fYG5FUA4t4Ea8lgT8exTejPCIyY7NmirsEYQH8V2y/0fAly3ZVhXjY990xQVjK6rwGlVq
	 7Lwq3/qg6oO0pabR1elsZb0WBpBYYj3xvG/IDzDmpaU/GlddqkoS2IZJZDFdRhw1HREoT
	 pB5udscso4NxjTAvWIIh0N5vGIJ0FF73rRItrX+3pLpBGBKhQkU2vt20WD4IPX5kRAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b="aCDpSk/7";
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=M2R30zBb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09200606A321;
	Tue, 10 Nov 2026 20:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09200606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=aCDpSk/7;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=M2R30zBb
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAIobxn2078059;
	Tue, 10 Nov 2026 14:38:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=p8KiIhcEmd44qrTt44+5Rhfj4yROV2cSkOMZ+zwCC
	fA=; b=aCDpSk/7SAHyWrwN1Y8R12sMktHXcFofwLyq/3xSfbnruAnv7x/bF2XB3
	FwzUooiNaQy8uEWNvbmuycbsBiU230HorZ9P/MQXGtyT/0u0R8lp/iyJqs6/vcdP
	qbm9x9vaFN103PtoM6iw35vmL0hBosOaJ54SJzX2/DubnTmYBO2idivtQJC7U7rF
	MEvOg/6PxbNuwc+U1KKyr6FTMn0/xOwUDupJd13vn/bbHyNqCtC3h1FyelMIwSyw
	nYEoNw+pHauC89I5olzHtKj2l7bZPoNgIDjqlIuULxfy/pcLuuaEMuWT4DR+WmRi
	QpJ72b5wRu/bMSJow8gWWQT28W3dA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hv0ksusbv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 14:38:53 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYZDueBMskw70DEFiy28fWGU1wkak4To7K3P8YygZP2SGiEAU3jU4iht1eLfBxolz+S0Uuudrf1oeF+N27d70hgo42ukIC9QPP2nJR/VO+a1hthx/QrIcJi1CG+fWrMSxjqhjdb1kPQ2PZxuz/mNtOsbFZsQVZ7KsSoSeTMe1sOevD0DD3FOHYFlXuG6DDB/TaqdSmt0vv590vv+qcbGwPicekxCPs4LlQaTrQ/CKPIrH1w2Rf+MlC3Ss+dzbJvOFMAPec+Nvl1mu2D6Ta8B1xLFqM4ss2aH1hVfFxyPJxZgNoSQY1O9/XM9lR/ymINc2W4/YkChTXgSZSZFy8lxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8KiIhcEmd44qrTt44+5Rhfj4yROV2cSkOMZ+zwCCfA=;
 b=tUaU/A7hRDNNuB0eRClB9Y2zhTKn+ZEJTLuXNyQkwfHc5TeleNquSBwcqejHWd7mdCrVNOE6lvWcgM9Kly4HDpn+2+9PyLOC5pNJ1vMqHpQb/dYVqiRJhdiZN02gTXAnRdCElgRvGGKLlfJQ8U57QFjexfP3LP1XRJZAx2Yt81yekvxq0RbFcMSXO3oQBsPrJ9QpR3PWvEZ64ccjIc9mm3hn6bbJpc8fXbq7hfQ3wzBU+9Pg2yRkuIOUiDQYG5EN1r1nf/DW2jM2EnT0SGS1HPh+kUuY1NSzOzhCOfc8YoJP0oPLKRGDBhUAaMhC1U0kAkcuSM9oec20D/bZUvmpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=debian.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8KiIhcEmd44qrTt44+5Rhfj4yROV2cSkOMZ+zwCCfA=;
 b=M2R30zBb558bcRv9icKeZUURGTGfkrUOO2dXZp5+WgW6OgDrVkaSKr3ssJl2fdHn8jnaUDpds7vLcgdY4dt6FSZaVfGmMjbuR3n9vWR+g17/UKHsPVCjmDYsOZFHBR6Ua0OtygyFjz+gGsgQ2BtR6L2fsX19xaHqF5pZVpjVsv0=
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by PH0PR10MB4455.namprd10.prod.outlook.com (2603:10b6:510:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:37:27 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::12) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:37:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 20:37:26 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 14:36:42 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 14:36:42 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 14:36:42 -0600
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAKaTkn2513238;
	Tue, 10 Nov 2026 14:36:38 -0600
From: Aniket Limaye <a-limaye@ti.com>
Date: Wed, 11 Nov 2026 02:05:49 +0530
Subject: [PATCH v5 2/2] i2c: Add Synopsys Advanced I2C (DWC_i2c) driver
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
Message-ID: <20261111-tda54-upstream-i2c-v5-2-280a4a779b24@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794342990; l=46120;
 i=a-limaye@ti.com; s=20261015; h=from:subject:message-id;
 bh=ty63F37Uko3A17EkMDyS1Le17m2SBwKMPhty9M5tZJo=;
 b=l7P0WvP+hmm1mqrJMf2hT/hQ4ZjINwS09ilH4GTSCOoR9C6dqXdSAIrWWUVnBDXATQ/k7gMzx
 L5KSN8TOnP/CflWe9uvXMzF1S2fobbjX4o40vWKuhY/WgB5pXcX57ws
X-Developer-Key: i=a-limaye@ti.com; a=ed25519;
 pk=n08rZiCmdy5/1c6+3QoI+fu2cHoQt9cw7543u1YgAyw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|PH0PR10MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b702b4f-1a02-4f18-4cb8-08df3f6a6e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|5023799004|56012099006|261022105027099003|261021121427099003|261021135927099003|261022075727099003|261022113327099003|261021130227099003|261021123027099003|261026130827099003|10067099003|261026121527099003|261022115727099003|261009223027099003|261028144727099003|261102123227099003|261009223327099003|261026140227099003|261009220027099003|261009221227099003|261009221727099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ccP1Sy4IC4MV4AMATWhVqP/qOraylSt7WGzDtnXbtBwG88MGzW013NJZ7GchLV6UPZAqeOCYDXVjDWu2fvyiYxVA0bO726ANsmGvMxfrzY08QzL6iLcrIbK8jujUVwuxBHzPxQE6GnbKnuAbWcQenMGUP9psqgjld3cHZlCy67BMHxciXqEtOJP1PKLoKrdbYhBG7BuE4I33ghZOV9jg4Cc4Wvr4tS//o7jgfc7h+vv72eArmdziH73j98pOh6FuuacFdRf1+blS+0ox3bYyR823sFWJfF6figxMVi/IDlpGwjB3cPiJQS86HdOBabujJR7vWy86HLmTbauCT9MzUSEVzP5XQRQwroVb+rKN0iuw+GcCCXhveDZw044WhFGJlue6egUYXQ2NDGmFPSPwBceLjScpJs1T7kH/HYVMgSRmfZFot2hljxHweu4zZFk/mYAmbiQwEUoiZ5M0XOoyu4L/h+t6ce8xmdlTV0AicWrhDS00LN9/GSAgVArs3C+YYYGenXwHGsppFjU7NB0sVJM88yebBguQOGbM8t2pvVAE4cZiB7FRa7eAjDHhUTSY0wDoifdpdUsmUo0NtANEW0siVz+sQngSHDGSBjPlfjMVYDfuOk/03lxpcFnPTyKRkMSTAOT6hekHVQ16N0/y7A==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(5023799004)(56012099006)(261022105027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022113327099003)(261021130227099003)(261021123027099003)(261026130827099003)(10067099003)(261026121527099003)(261022115727099003)(261009223027099003)(261028144727099003)(261102123227099003)(261009223327099003)(261026140227099003)(261009220027099003)(261009221227099003)(261009221727099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xGPeoEQ15zfVMiSctfIRnNbmi2wYN8itdJS/ec7d8igAW485mJhPuH6tx0Sw4xg0ZXJBnS/JWYNRLN4ZKFkirm8XaDfUG1yKK+XSl00kTTISpZqbj9kJcXiY1Uy3EPKw7b0xVE3o6Lz9TEyti5G5hcO9IUKlM6N7dwny8SKp86ag53UuQ+U1p0mbOsA+h/tj8R7w1KBCqPLT7t7F71KG019FTUkS+ZZq+Q/gcSior2AL0T9Yxn+UUAawQuy2mD3zeEa0FnS1WT9pYU/U9DSDSd0WikFotlaQ6FMcByr3Gd66ilnNmJTVNnGVnycp/lfxjP8KqMJj0nbgBQeM3pSYSBKYuJeizoVgNp3wBct8hT/jhrBGMlGdXNIa3DjZ223eqLaEJhVH6lkBlEW/gzSWvZZKBu6GVY1evgGCrjY1ypBSrfYsJx6qLBOKuSoblt2a
X-Exchange-RoutingPolicyChecked:
	h6vEhuE8VQLuqdl2k68LGVQOKquDxAqKZRMFpTwvGIdmKWnjd0Qq80JxYjHmUu8qJj7m+f6AO1jw3XD7jEqMqbu2v1Kn2vOeVmGDiI9i5koK3/8oGp4eEUvD0oTRP1EtwhD1nlb3gviZL6OW46+axhtci6oyB/t9HPjJ/F61GvkSL3E4Uf+xOeTFnV2Z5xVzCSOaQXvnGTphBcheAgF/sbaa7y6fjsQA6Ykv90fUYo0i5K4ljM4MITsw/M29QdgEnxNlcaB+rO7PgvZCwgH9QzNRIChBOkeNC08v2RrlHyHnap63+USXkRzZbx3sUf0xqAw9yAxJXB/mzGe29NS9+A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:37:26.1193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b702b4f-1a02-4f18-4cb8-08df3f6a6e7a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4455
X-Proofpoint-ORIG-GUID: h3BSPzy5W1-GgELC9SMv4_5OKqYNMM33
X-Authority-Analysis: v=2.4 cv=bcH+w+PB c=1 sm=1 tr=0 ts=6af380dd cx=c_pps
 a=VmiGRewH7mEIsprpaxNw0Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=sb03dA8UqXd_7CB6EWoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4MiBTYWx0ZWRfX3kkBl+VAVaSA
 6/b96w4l9Xfnb38bnBicBhCtMyKQL5WONR+Hnjwxh3UFLChgYY7YMSPqphSdPintQYOLRLjxh7h
 KHhQezY0QicJOrt0+WY557cS6bZm8lMVcaX4jXtMKY3N27yqugvr8RLd137VtfTi14OKK6MFBLd
 uViN+jLLi/RaiimGc5wJ3K8Qzpj3xDbT5ZCr5d/JvPqRO06hYmmkxPJDr+1+gafvsM5IUIwX0ln
 WN/T0d1oNFhq2895dtbY4brnTweV/EexGUKXPiclqhRkGyEQcr4JNZCKygyaOXtzDuyfllE4MRF
 1JP4+sFRJ7ctc25C0q6RH30+jhxjWOGOm9W79cI/mNeHGefpcGFdTE/Jk0Pr6GnodPvw+AHRyXH
 BSUasYR4DhMhK1PV1yMHKmtZALWPPWCTJnvABKwp5QQZGMQt7CjrxEt38NIzY8L8bFeQ8FDU/NB
 z5EMt9KwiE/flfxsf/Q==
X-Proofpoint-GUID: h3BSPzy5W1-GgELC9SMv4_5OKqYNMM33
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4MiBTYWx0ZWRfX4JFEaSwoDOOb
 jSw+47mXRAC9oRnAh51ce30Lpa+XYNNGXJvolLDGRwOaJN63ck4xRgksLo6GbouYG1QyJ11UsVd
 yQcAvwc+20fVfpYM/7AKE7ld4ONwaTg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100082

Add a new platform driver for the Synopsys Advanced I2C (DWC_i2c),
controller mode only.

The register offsets are defined with respect to header registers for
each block. These header registers are discovered at runtime by walking
the block header chain.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>

---

Changes in v5:
- Drop the unneeded mod_devicetable.h include. (Uwe Kleine-Konig)
- Keep an invalid SMBus block length in the buffer instead of clamping
  it silently. (Mark Brown)
- Read IC_ENABLE before the raw interrupt status in the ISR. (Mark
  Brown)
- Recompute RX_TL and resume queuing after draining the RX FIFO.
  (sashiko)
- Mask TX_EMPTY for SMBus block reads only after the length read is
  queued. (sashiko)
- Keep the RESTART request when the RX overrun check stops queuing.
  (sashiko)
- Mask and clear interrupts before gating clocks and before requesting
  the IRQ. (sashiko)
- Do not touch registers in the ISR when runtime PM is disabled.
  (sashiko)
- Link to v4: https://lore.kernel.org/r/20261027-tda54-upstream-i2c-v4-2-ebeeaf87d181@ti.com

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
 drivers/i2c/busses/i2c-dwc-adv.c | 1355 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1367 insertions(+)

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
index 000000000000..990026e09bdc
--- /dev/null
+++ b/drivers/i2c/busses/i2c-dwc-adv.c
@@ -0,0 +1,1355 @@
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
+static void dwc_adv_i2c_disable(struct dwc_adv_i2c_dev *dev)
+{
+	__dwc_adv_i2c_disable(dev);
+
+	dwc_adv_reg_write(dev, dev->regs.intr_mask, 0);
+	dwc_adv_i2c_ack_intr(dev, DWC_ADV_I2C_INTR_CLR_ALL);
+}
+
+static void dwc_adv_i2c_init(struct dwc_adv_i2c_dev *dev)
+{
+	dwc_adv_i2c_disable(dev);
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
+			/* Avoid rx buffer overrun */
+			if ((flags & I2C_M_RD) &&
+			    dev->rx_outstanding >= dev->rx_fifo_depth)
+				break;
+
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
+		if (buf_len > 0) {
+			dev->status |= DWC_ADV_I2C_STATUS_SW_WRITE_IN_PROGRESS;
+			break;
+		}
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
+	/* TX_EMPTY would only re-fire until RX_FULL drains the RX FIFO */
+	if (dev->msg_write_idx < dev->msgs_num &&
+	    dev->rx_outstanding >= dev->rx_fifo_depth)
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
+				unsigned int count = data;
+
+				/*
+				 * STOP is only set after receiving the block
+				 * data response length. When that length is
+				 * invalid, read one more byte with STOP set to
+				 * complete the transaction. The received length
+				 * stays in the buffer for the caller to reject.
+				 */
+				if (!count || count > I2C_SMBUS_BLOCK_MAX)
+					count = 1;
+
+				len = dwc_adv_i2c_recv_len(dev, count);
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
+	if (stat & DWC_ADV_I2C_INTR_RX_FULL) {
+		dwc_adv_i2c_read(dev);
+		/* Re-evaluate RX_TL and TX_EMPTY for the reads still pending */
+		stat |= DWC_ADV_I2C_INTR_TX_EMPTY;
+	}
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
+	if (!enabled)
+		return IRQ_NONE;
+
+	stat = dwc_adv_reg_read(dev, dev->regs.raw_intr_stat);
+	if (!(stat & ~DWC_ADV_I2C_INTR_ACTIVITY))
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
+	if (IS_ENABLED(CONFIG_PM) && pm <= 0)
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
+	dwc_adv_i2c_disable(dev);
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
+	dwc_adv_i2c_disable(dev);
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
+		dwc_adv_i2c_disable(dev);
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
+	dwc_adv_i2c_init(dev);
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

