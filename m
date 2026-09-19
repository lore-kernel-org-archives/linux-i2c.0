Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E973DA7D3;
	Sat, 19 Sep 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808850; cv=fail; b=Y2Bv6CHVN5OQgrih8o5rWW/C7TdEUsVdwbOfr5+M7AYvCpekR74IB1bW2r79VlICkL26yaBPEO4i/TOR0ATxHty2YYNHQIrQARR+aNH7d7JRo8LCQ5gkstdH1ymLRIJcRWv37Rzzqppt+EiOG5MeMOgatQUqMEFEmfETA+CncII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808850; c=relaxed/simple;
	bh=IOh9S6CrEo7BncsifNH/7vxQ8NK/x9WP5bSdj0gDzK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=H3hOnVECP0mafxep9RUKo+ioxhlNusZn9t0SRqRPD3DSpxyJfIbWrvyTz3xb1AW9Y7Fj3Ycw4Ib0muLzAbOgw1olUrwbTP6dcDfBMeQNcul4sVOhpVLqIOP6sD+D+QBElKDXhP6UMTbrFeZkxHRwa15T26qfrIkShBjQ64r362U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=X76S43W0; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g7CzC+hj; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="X76S43W0";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g7CzC+hj"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68J6ej803514638;
	Sat, 19 Sep 2026 04:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=dGvCoTsv54LCAP2aJTekV4yCcyhZPmQCyrZVXdNVm
	yc=; b=X76S43W0cUBEKjRNR9DTwLZlF6Su8EPlZ0EsBS7ISGUXT1WErS2isC7XM
	yYU1CjfwNsiVKJ6hNQoBXw48CF/GonmdIhxzzCb+emNbuzLNnyohOt4pdqqAAvza
	f2VWc/cL3ufe8bLw44iZnppx2w55ZDfXcclj7Zh9mw3gpd3aHJdkHUewzwKQtOSt
	qKoWIfB7BNoUlYjtOsI4rQc7VepsgkH8Uy60V76qmT4k/nIqfhwMrn+Zwd6nogCk
	YWkBbpGGKwLukUb/SDpa6vfyclrlaDBRM/+zkqh1AQEtQumLGRI2EFgav/7BNliB
	8gRyLWdSLXK8PXaz+8IbHuxHV2O9A==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gsd341xme-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 04:07:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajRl//Wtnx9/thStoTW8rm0vUzCnBln+l/P3GQNNTjiJn0R8XogiAdkXSFvj/YZLP6H99wikXg1Sf55gWx+2rqjjL6Rg+rcOxpgazwZZPTDMnzPrmAV980NYqobmtVNBH15Iz823vuWejle3pJORBnBxYrYrySomIaIgw115s+t+9VWVPcL7IzIwB8O9VPY8dqrff3xnatBA257dt2u5vyrZ7mHd8sfwVSZv/20/UXbBWBscHcwHI9kofjssL/h8zNADcRNPmopUMi32HBjugwsDZwBO80Im8BxmQ7q4wzV1injFT8bPcIlpbs6C0JrwV4HNlAZyFOehX8a7e/SdiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGvCoTsv54LCAP2aJTekV4yCcyhZPmQCyrZVXdNVmyc=;
 b=NkYhE+WeMevE5qLY2mRY6aVkwhJ8Rdw3sDqVzsX1cT10coEeU1MfcYvssMsNnTwVc5MckvTEYTQdquO9Sid9tlzL/3LVLC7sBJOSO+rgsM1Q6XuxvE2VeHm+LuSWaia0bVPqJ6czsZYnoT/UpLPRrdP1ZZVIvKxgQCoSQpVYLH6r79O6YG1ayrfY83ag8Gl+LFtshT1wWfZQS8Ukx6pIuPo9tOyWqbhcmdhuywYN2JnUxrUSnZHf64SwgtzOCmX1oE/TOjZqxfwiIeR2KLrNRTuOf/DPukBBR9DyxpMOSPnHBHyvXvoHrR2quzYVhek+qsYvcRyPPK3hzYf2WVAaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGvCoTsv54LCAP2aJTekV4yCcyhZPmQCyrZVXdNVmyc=;
 b=g7CzC+hj38Ee3eW+dSHtOwGyANx7TrxNBwmW4xhX+wPCkMZwFdigl+Ylyrpwd2oUqnpiY04WqYjSQplUaEZFq7VlPLsBb+w0Rwe1x0HCvdi/eYj9K2764F6dznv90EjilGIy6w6qmLIkJqiZnXXTUaKKM6JGj2kmbLMqIzJ8AV0=
Received: from SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::18)
 by AT6PR10MB043640.namprd10.prod.outlook.com (2603:10b6:170:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Sat, 19 Sep
 2026 09:07:01 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::51) by SJ0P220CA0027.outlook.office365.com
 (2603:10b6:a03:41b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.14 via Frontend Transport; Sat,
 19 Sep 2026 09:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 19 Sep 2026 09:06:59 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 19 Sep
 2026 04:06:34 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 19 Sep
 2026 04:06:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 19 Sep 2026 04:06:34 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68J96Jmf3292028;
	Sat, 19 Sep 2026 04:06:29 -0500
From: Aniket Limaye <a-limaye@ti.com>
Date: Sat, 19 Sep 2026 14:36:07 +0530
Subject: [PATCH 2/3] i2c: designware: Introduce per-variant register offset
 and bit-layout tables
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260919-tda54-upstream-i2c-v1-2-b0b9f77be18b@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|AT6PR10MB043640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6800f069-ba73-4202-331c-08df162d5cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|7416014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Lbun3cpjSX7upkhAMh6MByAFLWK2Z7e6Nyas8a+ewF1nrq96Pt29Lo+qdY16lJLse2z7+BoZisHyMvC8zxX9Gf4tnbLeG5hktYNT8Zmu9SPZkwxKaueYoeLGUylwTaA2UqJStOXkGcq4p/EUddQuKC96ZmGXooF9tytyCyr5fXFLxXBv/5yse8xy7zbjy/L61G8abwJ0Xe6a8l5BofvDgOriU94vGmENvj9jA5j6vhOZKD2mGDeYMhw7GNcon27QN1Jx/33SuBgOsldTZtxcrbYRnq84OyO90Lf1WccxipFSUUiWylpODz0YPAgRk1TLtcRY3kIdwRyoj0S2vouUXLXwSpCEhZO4S+lVA8WSJNPHw2O7VVG/CZUbSKyZQxZPTtcGLpq8TFQtnExm+vslFym9hTNC4v7xHJgIfqzZrUpb8t2/ZzOGL+vaEfPxrgHtPx6MGCy3ktvJq/pziwXaQHMkwOnnW9fyiG9bpbtJgVLT6WXTleuZ0HnEV2A/cKk2gDhNX0I24lQWzyZ3lsg/dY3Od/C07xsRo49IcG2va4zOAOPA9ZDNvCskxgd9VaoKobRsy9RrkQh9N+1QTfWn1T6i2gTrfK7GEpbDwN+vRP7JFH8ZrLirhzU9/9MnP5oRqoljc4DcPyBsWYb4xtdu7a8Ivan5gwr5O4AXAXlIK4pow/8Gvlu+Pyc4Pav41V3Szy9/GBbLSsRbyryOI5eIoQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(7416014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ksBGyANUYgXPpTD7h3M24SAhC2ois3Np71n6HaaMi0RmxoMqFKM2K8HLIY+TvJBLkYiRFg68+/VrvL1+CDXBuTZmeP4bejbAuaQE+FvpzvwWuQzlDON29NXovIUaJ8GM3XVLmoultibV3QhwQ19mdLKvxnD2UnWsGRTXHvIojur/xkbA8bsOYTiYNHxa98MU6B9HqgoLduLore1vaybps0FYChJ85RvU2ddzDdW7hHpuOgXzwG5uP9m9Mfi93BY30lJQdrefVvzibxeiBotZJbo7efgO2OSGMbhEZZZcfb1ZCXND1XW/mNqqYMnm09aSkLVh95AFoJcDVJPOSL2voMAueN1c7IquQTi1sKdCdUfwGdtE9sFoo3UrjwGWBxDrjlnpRZAG62C1FiUvEo1j2headlf9JKfoWfIoK2QBB27EdahIEMKWwJ+eqXFfFhbC
X-Exchange-RoutingPolicyChecked:
	Jl7+UjrnodVcpLyTf9+qOlXiIFORi7gbbd+Dig1xUyahza3oi8kl6TMDiP42iMGlfhL8ZuerXHDp0e3Aaes8IEZWihDdbV2Li0GwhEAvzqdGxFK1Ofk61MnBdUYiEMR55UA95OU8bd+c6PyNOdwRwFu1vR0y15i1qohqFA6iNJDWzQDif4yPp+474Df/tbaoI2VlW4pBzLQBwBaunDBEXY7zABHmeTtbyIB6HClSnjUJsab4M+iIALXVeGLiuvnJVO0RtS/jn9ac/cZ2Ume9amRPs0tJAudGGvV2MFboBjcxfPgfpmyHC2h5EedlFpM+vasORVXAeLy2ovSmTkhn3w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 09:06:59.4631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6800f069-ba73-4202-331c-08df162d5cca
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR10MB043640
X-Authority-Analysis: v=2.4 cv=Yoqa1IYX c=1 sm=1 tr=0 ts=6aae50b7 cx=c_pps
 a=yaJUXpcFNTkE3gTvo4ZtIQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=6ufxba3UMpem96m-QMYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDEzMCBTYWx0ZWRfXyhI6ohvZLzVR
 h8yPw01N24tdBjvsXJxfaKirC1/F+zDl63PtHea2EGuPB2Io7fmIHB0feoSyQZCBamdurcdHQxX
 ghVkk23Xf0kH72C5INHLxzjw4TxGYDfOsxkAnFQrwQmyADP35uLLjSoZuyf8y3cy5qgKXDJeuoQ
 q3XBqlklt2ONQC2EWpOvhQ/SVLAsw9xoqm5Aot4tVAdGfLHnQWFVQJ40n9FzHKlUOoXSoOb0/L2
 fT9MkFq5XiXAFXywQ7Ew6m2JjHJ9XrMwgC3WWH7xt5xuJfbE1nzuX1bOVE5ONiD/CGYSkMYr1gU
 nAPu0iiNC3xvydsezXJG9tp12MwLbP61KjEoZ4mYXCAdmv1M8NMAxoHSMXZqnsa1HfZhwy0MrJ/
 HzxgDM5dfmmxkxx4HiU3D65d2l+TYNuuOjT8jAILYmrrhn492XSBORh/ylTpgy6sAyJAsPYUyT9
 Iknhcpqw2THKyxBQxAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDEzMCBTYWx0ZWRfXzc+INTLzQzON
 JidIqYvfKPBD60/VgblYhZ6yvekk5msUWO8M+NR9KZaOeSRcuttVpmT1306lJ5MB7Ep9/2OL56b
 7oRsf33lQaoxJn1qFqxlfxrcZoNxAaw=
X-Proofpoint-ORIG-GUID: 77OWWzzTmoKJdZAw0XmBmdTV0un7-nyV
X-Proofpoint-GUID: 77OWWzzTmoKJdZAw0XmBmdTV0un7-nyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609190130

Every DW_IC_* register offset and CON-register bit position is currently
baked in as a compile-time constant, which only works while there is a
single register layout. Introduce a logical register-ID enum (enum
dw_i2c_reg_idx) plus a per-variant offset table (dev->regs[]) and a
per-variant CON-register bit-layout descriptor (dev->con_bits), selected
at probe time via the new i2c_dw_select_variant().

Replace every direct DW_IC_* offset/bit-position reference with a lookup
through dev->regs[]/dev->con_bits. Also fold the read-to-clear
interrupt-acknowledgment pattern into a new i2c_dw_ack_intr() helper,
driven by a per-variant dev->intr_clr[] table.

Only one variant exists at this point (DW_apb_i2c), so this is a
mechanical, behavior-preserving change: the values in
dw_i2c_reg_offsets[] and dw_i2c_con_bits match the DW_IC_* macros
exactly. It lays the groundwork for adding a second register layout
(DWC_i2c) without duplicating the whole driver.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 drivers/i2c/busses/i2c-designware-amdisp.c  |   1 +
 drivers/i2c/busses/i2c-designware-common.c  | 158 ++++++++++++++++++++++------
 drivers/i2c/busses/i2c-designware-core.h    | 108 ++++++++++++++++++-
 drivers/i2c/busses/i2c-designware-master.c  | 125 +++++++++++-----------
 drivers/i2c/busses/i2c-designware-pcidrv.c  |   2 +
 drivers/i2c/busses/i2c-designware-platdrv.c |   2 +
 drivers/i2c/busses/i2c-designware-slave.c   |  42 ++++----
 7 files changed, 318 insertions(+), 120 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
index 9f0ec0fae6f2..f7aa075c9977 100644
--- a/drivers/i2c/busses/i2c-designware-amdisp.c
+++ b/drivers/i2c/busses/i2c-designware-amdisp.c
@@ -46,6 +46,7 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
 	isp_i2c_dev->flags |= ACCESS_POLLING;
 	platform_set_drvdata(pdev, isp_i2c_dev);
 
+	i2c_dw_select_variant(isp_i2c_dev);
 	isp_i2c_dev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(isp_i2c_dev->base))
 		return dev_err_probe(&pdev->dev, PTR_ERR(isp_i2c_dev->base),
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a1eca6cd4b75..a21aeb7f415a 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -72,6 +72,95 @@ static const char *const abort_sources[] = {
 		"incorrect slave-transmitter mode configuration",
 };
 
+/* "snps,designware-i2c" flat register layout */
+static const u32 dw_i2c_reg_offsets[DW_REG_IDX_MAX] = {
+	[DW_REG_IDX_CON]			= DW_IC_CON,
+	[DW_REG_IDX_TAR]			= DW_IC_TAR,
+	[DW_REG_IDX_SAR]			= DW_IC_SAR,
+	[DW_REG_IDX_DATA_CMD]		= DW_IC_DATA_CMD,
+	[DW_REG_IDX_SS_SCL_HCNT]		= DW_IC_SS_SCL_HCNT,
+	[DW_REG_IDX_SS_SCL_LCNT]		= DW_IC_SS_SCL_LCNT,
+	[DW_REG_IDX_FS_SCL_HCNT]		= DW_IC_FS_SCL_HCNT,
+	[DW_REG_IDX_FS_SCL_LCNT]		= DW_IC_FS_SCL_LCNT,
+	[DW_REG_IDX_HS_SCL_HCNT]		= DW_IC_HS_SCL_HCNT,
+	[DW_REG_IDX_HS_SCL_LCNT]		= DW_IC_HS_SCL_LCNT,
+	[DW_REG_IDX_INTR_STAT]		= DW_IC_INTR_STAT,
+	[DW_REG_IDX_INTR_MASK]		= DW_IC_INTR_MASK,
+	[DW_REG_IDX_RAW_INTR_STAT]		= DW_IC_RAW_INTR_STAT,
+	[DW_REG_IDX_RX_TL]			= DW_IC_RX_TL,
+	[DW_REG_IDX_TX_TL]			= DW_IC_TX_TL,
+	[DW_REG_IDX_CLR_INTR]		= DW_IC_CLR_INTR,
+	[DW_REG_IDX_CLR_RX_UNDER]		= DW_IC_CLR_RX_UNDER,
+	[DW_REG_IDX_CLR_RX_OVER]		= DW_IC_CLR_RX_OVER,
+	[DW_REG_IDX_CLR_TX_OVER]		= DW_IC_CLR_TX_OVER,
+	[DW_REG_IDX_CLR_RD_REQ]		= DW_IC_CLR_RD_REQ,
+	[DW_REG_IDX_CLR_TX_ABRT]		= DW_IC_CLR_TX_ABRT,
+	[DW_REG_IDX_CLR_RX_DONE]		= DW_IC_CLR_RX_DONE,
+	[DW_REG_IDX_CLR_ACTIVITY]		= DW_IC_CLR_ACTIVITY,
+	[DW_REG_IDX_CLR_STOP_DET]		= DW_IC_CLR_STOP_DET,
+	[DW_REG_IDX_CLR_START_DET]		= DW_IC_CLR_START_DET,
+	[DW_REG_IDX_CLR_GEN_CALL]		= DW_IC_CLR_GEN_CALL,
+	[DW_REG_IDX_ENABLE]			= DW_IC_ENABLE,
+	[DW_REG_IDX_STATUS]			= DW_IC_STATUS,
+	[DW_REG_IDX_TXFLR]			= DW_IC_TXFLR,
+	[DW_REG_IDX_RXFLR]			= DW_IC_RXFLR,
+	[DW_REG_IDX_SDA_HOLD]		= DW_IC_SDA_HOLD,
+	[DW_REG_IDX_TX_ABRT_SOURCE]		= DW_IC_TX_ABRT_SOURCE,
+	[DW_REG_IDX_ENABLE_STATUS]		= DW_IC_ENABLE_STATUS,
+	[DW_REG_IDX_SMBUS_INTR_MASK]	= DW_IC_SMBUS_INTR_MASK,
+	[DW_REG_IDX_COMP_PARAM_1]		= DW_IC_COMP_PARAM_1,
+	[DW_REG_IDX_COMP_VERSION]		= DW_IC_COMP_VERSION,
+	[DW_REG_IDX_COMP_TYPE]		= DW_IC_COMP_TYPE,
+};
+
+static const struct dw_i2c_con_bits dw_i2c_con_bits = {
+	.master			= DW_IC_CON_MASTER,
+	.speed_std		= DW_IC_CON_SPEED_STD,
+	.speed_fast		= DW_IC_CON_SPEED_FAST,
+	.speed_high		= DW_IC_CON_SPEED_HIGH,
+	.speed_mask		= DW_IC_CON_SPEED_MASK,
+	.bit10_slave		= DW_IC_CON_10BITADDR_SLAVE,
+	.bit10_master		= DW_IC_CON_10BITADDR_MASTER,
+	.restart_en		= DW_IC_CON_RESTART_EN,
+	.slave_disable		= DW_IC_CON_SLAVE_DISABLE,
+	.stop_det_ifaddressed	= DW_IC_CON_STOP_DET_IFADDRESSED,
+	.tx_empty_ctrl		= DW_IC_CON_TX_EMPTY_CTRL,
+	.rx_fifo_full_hld_ctrl	= DW_IC_CON_RX_FIFO_FULL_HLD_CTRL,
+	.bus_clear_ctrl		= DW_IC_CON_BUS_CLEAR_CTRL,
+};
+
+/* "snps,designware-i2c": dedicated read-to-clear register ID per logical interrupt */
+static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
+	[DW_INTR_IDX_ALL]       = DW_REG_IDX_CLR_INTR,
+	[DW_INTR_IDX_RX_UNDER]  = DW_REG_IDX_CLR_RX_UNDER,
+	[DW_INTR_IDX_RX_OVER]   = DW_REG_IDX_CLR_RX_OVER,
+	[DW_INTR_IDX_TX_OVER]   = DW_REG_IDX_CLR_TX_OVER,
+	[DW_INTR_IDX_RD_REQ]    = DW_REG_IDX_CLR_RD_REQ,
+	[DW_INTR_IDX_TX_ABRT]   = DW_REG_IDX_CLR_TX_ABRT,
+	[DW_INTR_IDX_RX_DONE]   = DW_REG_IDX_CLR_RX_DONE,
+	[DW_INTR_IDX_ACTIVITY]  = DW_REG_IDX_CLR_ACTIVITY,
+	[DW_INTR_IDX_STOP_DET]  = DW_REG_IDX_CLR_STOP_DET,
+	[DW_INTR_IDX_START_DET] = DW_REG_IDX_CLR_START_DET,
+	[DW_INTR_IDX_GEN_CALL]  = DW_REG_IDX_CLR_GEN_CALL,
+};
+
+/**
+ * i2c_dw_select_variant() - Pick the register offset table, CON-register bit
+ * layout and interrupt-ack mapping matching this device's IP variant
+ * @dev: device private data
+ *
+ * Must be called after dev->flags has been populated from
+ * device_get_match_data()/ACPI id data, and before any register access
+ * (including i2c_dw_init_regmap()).
+ */
+void i2c_dw_select_variant(struct dw_i2c_dev *dev)
+{
+	dev->regs = dw_i2c_reg_offsets;
+	dev->con_bits = &dw_i2c_con_bits;
+	dev->intr_clr = dw_i2c_intr_clr;
+}
+EXPORT_SYMBOL_GPL(i2c_dw_select_variant);
+
 static int dw_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
@@ -147,7 +236,7 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
 		.disable_locking = true,
 		.reg_read = dw_reg_read,
 		.reg_write = dw_reg_write,
-		.max_register = DW_IC_COMP_TYPE,
+		.max_register = dev->regs[DW_REG_IDX_COMP_TYPE],
 	};
 	u32 reg;
 	int ret;
@@ -163,7 +252,7 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
-	reg = readl(dev->base + DW_IC_COMP_TYPE);
+	reg = readl(dev->base + dev->regs[DW_REG_IDX_COMP_TYPE]);
 	i2c_dw_release_lock(dev);
 
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU)
@@ -365,17 +454,17 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 {
 	switch (mode) {
 	case DW_IC_MASTER:
-		regmap_write(dev->map, DW_IC_TX_TL, dev->tx_fifo_depth / 2);
-		regmap_write(dev->map, DW_IC_RX_TL, 0);
-		regmap_write(dev->map, DW_IC_CON, dev->master_cfg);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_TX_TL], dev->tx_fifo_depth / 2);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_RX_TL], 0);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_CON], dev->master_cfg);
 		break;
 	case DW_IC_SLAVE:
 		dev->status = 0;
-		regmap_write(dev->map, DW_IC_TX_TL, 0);
-		regmap_write(dev->map, DW_IC_RX_TL, 0);
-		regmap_write(dev->map, DW_IC_CON, dev->slave_cfg);
-		regmap_write(dev->map, DW_IC_SAR, dev->slave->addr);
-		regmap_write(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_SLAVE_MASK);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_TX_TL], 0);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_RX_TL], 0);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_CON], dev->slave_cfg);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_SAR], dev->slave->addr);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_INTR_MASK], DW_IC_INTR_SLAVE_MASK);
 		__i2c_dw_enable(dev);
 		break;
 	default:
@@ -387,16 +476,16 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 static void i2c_dw_write_timings(struct dw_i2c_dev *dev)
 {
 	/* Write standard speed timing parameters */
-	regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
-	regmap_write(dev->map, DW_IC_SS_SCL_LCNT, dev->ss_lcnt);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_SS_SCL_HCNT], dev->ss_hcnt);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_SS_SCL_LCNT], dev->ss_lcnt);
 
 	/* Write fast mode/fast mode plus timing parameters */
-	regmap_write(dev->map, DW_IC_FS_SCL_HCNT, dev->fs_hcnt);
-	regmap_write(dev->map, DW_IC_FS_SCL_LCNT, dev->fs_lcnt);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_FS_SCL_HCNT], dev->fs_hcnt);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_FS_SCL_LCNT], dev->fs_lcnt);
 
 	/* Write high speed timing parameters */
-	regmap_write(dev->map, DW_IC_HS_SCL_HCNT, dev->hs_hcnt);
-	regmap_write(dev->map, DW_IC_HS_SCL_LCNT, dev->hs_lcnt);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_HS_SCL_HCNT], dev->hs_hcnt);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_HS_SCL_LCNT], dev->hs_lcnt);
 }
 
 /**
@@ -448,13 +537,13 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	 * firmware that leaves IC_SMBUS=1; the handler never
 	 * services them.
 	 */
-	regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_SMBUS_INTR_MASK], 0);
 
 	i2c_dw_write_timings(dev);
 
 	/* Write SDA hold time if supported */
 	if (dev->sda_hold_time)
-		regmap_write(dev->map, DW_IC_SDA_HOLD, dev->sda_hold_time);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_SDA_HOLD], dev->sda_hold_time);
 
 	i2c_dw_configure_mode(dev, dev->mode);
 
@@ -579,14 +668,14 @@ static int i2c_dw_set_sda_hold(struct dw_i2c_dev *dev)
 		return ret;
 
 	/* Configure SDA Hold Time if required */
-	ret = regmap_read(dev->map, DW_IC_COMP_VERSION, &reg);
+	ret = regmap_read(dev->map, dev->regs[DW_REG_IDX_COMP_VERSION], &reg);
 	if (ret)
 		goto err_release_lock;
 
 	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
 		if (!dev->sda_hold_time) {
 			/* Keep previous hold time setting if no one set it */
-			ret = regmap_read(dev->map, DW_IC_SDA_HOLD,
+			ret = regmap_read(dev->map, dev->regs[DW_REG_IDX_SDA_HOLD],
 					  &dev->sda_hold_time);
 			if (ret)
 				goto err_release_lock;
@@ -629,9 +718,9 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 	unsigned int status;
 	int ret;
 
-	regmap_read(dev->map, DW_IC_RAW_INTR_STAT, &raw_intr_stats);
-	regmap_read(dev->map, DW_IC_STATUS, &ic_stats);
-	regmap_read(dev->map, DW_IC_ENABLE, &enable);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_RAW_INTR_STAT], &raw_intr_stats);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_STATUS], &ic_stats);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_ENABLE], &enable);
 
 	abort_needed = (raw_intr_stats & DW_IC_INTR_MST_ON_HOLD) ||
 			(ic_stats & DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY);
@@ -645,7 +734,7 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 
 	if (abort_needed) {
 		if (!(enable & DW_IC_ENABLE_ENABLE)) {
-			regmap_write(dev->map, DW_IC_ENABLE, DW_IC_ENABLE_ENABLE);
+			regmap_write(dev->map, dev->regs[DW_REG_IDX_ENABLE], DW_IC_ENABLE_ENABLE);
 			/*
 			 * Wait 10 times the signaling period of the highest I2C
 			 * transfer supported by the driver (for 400KHz this is
@@ -657,8 +746,8 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 			enable |= DW_IC_ENABLE_ENABLE;
 		}
 
-		regmap_write(dev->map, DW_IC_ENABLE, enable | DW_IC_ENABLE_ABORT);
-		ret = regmap_read_poll_timeout(dev->map, DW_IC_ENABLE, enable,
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_ENABLE], enable | DW_IC_ENABLE_ABORT);
+		ret = regmap_read_poll_timeout(dev->map, dev->regs[DW_REG_IDX_ENABLE], enable,
 					       !(enable & DW_IC_ENABLE_ABORT),
 					       DW_IC_ABORT_TIMEOUT_US,
 					       10 * DW_IC_ABORT_TIMEOUT_US);
@@ -672,7 +761,7 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 		 * The enable status register may be unimplemented, but
 		 * in that case this test reads zero and exits the loop.
 		 */
-		regmap_read(dev->map, DW_IC_ENABLE_STATUS, &status);
+		regmap_read(dev->map, dev->regs[DW_REG_IDX_ENABLE_STATUS], &status);
 		if (!(status & 1))
 			return;
 
@@ -754,7 +843,7 @@ int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 	unsigned int status;
 	int ret;
 
-	ret = regmap_read_poll_timeout(dev->map, DW_IC_STATUS, status,
+	ret = regmap_read_poll_timeout(dev->map, dev->regs[DW_REG_IDX_STATUS], status,
 				       !(status & DW_IC_STATUS_ACTIVITY),
 				       DW_IC_BUSY_POLL_TIMEOUT_US,
 				       20 * DW_IC_BUSY_POLL_TIMEOUT_US);
@@ -763,7 +852,7 @@ int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 
 		i2c_recover_bus(&dev->adapter);
 
-		regmap_read(dev->map, DW_IC_STATUS, &status);
+		regmap_read(dev->map, dev->regs[DW_REG_IDX_STATUS], &status);
 		if (!(status & DW_IC_STATUS_ACTIVITY))
 			ret = 0;
 	}
@@ -816,7 +905,7 @@ static int i2c_dw_set_fifo_size(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(dev->map, DW_IC_COMP_PARAM_1, &param);
+	ret = regmap_read(dev->map, dev->regs[DW_REG_IDX_COMP_PARAM_1], &param);
 	i2c_dw_release_lock(dev);
 	if (ret)
 		return ret;
@@ -845,7 +934,6 @@ u32 i2c_dw_func(struct i2c_adapter *adap)
 
 void i2c_dw_disable(struct dw_i2c_dev *dev)
 {
-	unsigned int dummy;
 	int ret;
 
 	ret = i2c_dw_acquire_lock(dev);
@@ -857,7 +945,7 @@ void i2c_dw_disable(struct dw_i2c_dev *dev)
 
 	/* Disable all interrupts */
 	__i2c_dw_write_intr_mask(dev, 0);
-	regmap_read(dev->map, DW_IC_CLR_INTR, &dummy);
+	i2c_dw_ack_intr(dev, DW_INTR_IDX_ALL);
 
 	i2c_dw_release_lock(dev);
 }
@@ -1054,9 +1142,9 @@ void i2c_dw_shutdown(struct dw_i2c_dev *dev)
 	 * To quickly NACK the controller during shutdown, we set the target
 	 * disable bit while the controller is still enabled.
 	 */
-	regmap_read(dev->map, DW_IC_CON, &con);
-	con |= DW_IC_CON_SLAVE_DISABLE;
-	regmap_write(dev->map, DW_IC_CON, con);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_CON], &con);
+	con |= dev->con_bits->slave_disable;
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_CON], con);
 
 	i2c_dw_disable(dev);
 }
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 2c929a6e8da2..2fad18582db7 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -43,6 +43,91 @@
 #define DW_IC_SDA_HOLD_MIN_VERS			0x3131312A /* "111*" == v1.11* */
 #define DW_IC_COMP_TYPE_VALUE			0x44570140 /* "DW" + 0x0140 */
 
+/*
+ * Logical register IDs. The physical offset backing each ID depends on the
+ * variant of the IP (selected via i2c_dw_select_variant() based on the
+ * device's compatible string) and is looked up at runtime through
+ * dev->regs[]. This lets a single set of driver code paths serve IP
+ * variants with different register layouts.
+ */
+enum dw_i2c_reg_idx {
+	DW_REG_IDX_CON,
+	DW_REG_IDX_TAR,
+	DW_REG_IDX_SAR,
+	DW_REG_IDX_DATA_CMD,
+	DW_REG_IDX_SS_SCL_HCNT,
+	DW_REG_IDX_SS_SCL_LCNT,
+	DW_REG_IDX_FS_SCL_HCNT,
+	DW_REG_IDX_FS_SCL_LCNT,
+	DW_REG_IDX_HS_SCL_HCNT,
+	DW_REG_IDX_HS_SCL_LCNT,
+	DW_REG_IDX_INTR_STAT,
+	DW_REG_IDX_INTR_MASK,
+	DW_REG_IDX_RAW_INTR_STAT,
+	DW_REG_IDX_RX_TL,
+	DW_REG_IDX_TX_TL,
+	DW_REG_IDX_CLR_INTR,
+	DW_REG_IDX_CLR_RX_UNDER,
+	DW_REG_IDX_CLR_RX_OVER,
+	DW_REG_IDX_CLR_TX_OVER,
+	DW_REG_IDX_CLR_RD_REQ,
+	DW_REG_IDX_CLR_TX_ABRT,
+	DW_REG_IDX_CLR_RX_DONE,
+	DW_REG_IDX_CLR_ACTIVITY,
+	DW_REG_IDX_CLR_STOP_DET,
+	DW_REG_IDX_CLR_START_DET,
+	DW_REG_IDX_CLR_GEN_CALL,
+	DW_REG_IDX_ENABLE,
+	DW_REG_IDX_STATUS,
+	DW_REG_IDX_TXFLR,
+	DW_REG_IDX_RXFLR,
+	DW_REG_IDX_SDA_HOLD,
+	DW_REG_IDX_TX_ABRT_SOURCE,
+	DW_REG_IDX_ENABLE_STATUS,
+	DW_REG_IDX_SMBUS_INTR_MASK,
+	DW_REG_IDX_COMP_PARAM_1,
+	DW_REG_IDX_COMP_VERSION,
+	DW_REG_IDX_COMP_TYPE,
+	DW_REG_IDX_MAX,
+};
+
+/*
+ * Bit positions within the CON register that could differ between IP
+ * variants. Values here match the DW_IC_CON_* macros in
+ * <linux/designware_i2c.h>.
+ */
+struct dw_i2c_con_bits {
+	u32 master;
+	u32 speed_std;
+	u32 speed_fast;
+	u32 speed_high;
+	u32 speed_mask;
+	u32 bit10_slave;
+	u32 bit10_master;
+	u32 restart_en;
+	u32 slave_disable;
+	u32 stop_det_ifaddressed;
+	u32 tx_empty_ctrl;
+	u32 rx_fifo_full_hld_ctrl;
+	u32 bus_clear_ctrl;
+};
+
+/* Logical interrupt IDs for i2c_dw_ack_intr(); DW_INTR_IDX_ALL = "current pending interrupt" */
+enum dw_i2c_intr_idx {
+	DW_INTR_IDX_ALL,
+	DW_INTR_IDX_RX_UNDER,
+	DW_INTR_IDX_RX_OVER,
+	DW_INTR_IDX_TX_OVER,
+	DW_INTR_IDX_RD_REQ,
+	DW_INTR_IDX_TX_ABRT,
+	DW_INTR_IDX_RX_DONE,
+	DW_INTR_IDX_ACTIVITY,
+	DW_INTR_IDX_STOP_DET,
+	DW_INTR_IDX_START_DET,
+	DW_INTR_IDX_GEN_CALL,
+	DW_INTR_IDX_MAX,
+};
+
 #define DW_IC_INTR_DEFAULT_MASK			(DW_IC_INTR_RX_FULL | \
 						 DW_IC_INTR_TX_ABRT | \
 						 DW_IC_INTR_STOP_DET)
@@ -126,6 +211,9 @@ struct reset_control;
  * struct dw_i2c_dev - private i2c-designware data
  * @dev: driver model device node
  * @map: IO registers map
+ * @regs: logical-to-physical register offset table for the active IP variant
+ * @con_bits: CON register bit-layout for the active IP variant
+ * @intr_clr: logical intr number to reg table for the active IP variant
  * @sysmap: System controller registers map
  * @base: IO registers pointer
  * @ext: Extended IO registers pointer
@@ -189,6 +277,9 @@ struct reset_control;
 struct dw_i2c_dev {
 	struct device		*dev;
 	struct regmap		*map;
+	const u32		*regs;
+	const struct dw_i2c_con_bits *con_bits;
+	const u32		*intr_clr;
 	struct regmap		*sysmap;
 	void __iomem		*base;
 	void __iomem		*ext;
@@ -265,6 +356,7 @@ struct i2c_dw_semaphore_callbacks {
 	int	(*probe)(struct dw_i2c_dev *dev);
 };
 
+void i2c_dw_select_variant(struct dw_i2c_dev *dev);
 u32 i2c_dw_scl_hcnt(struct dw_i2c_dev *dev, unsigned int reg, u32 ic_clk,
 		    u32 tSYMBOL, u32 tf, int offset);
 u32 i2c_dw_scl_lcnt(struct dw_i2c_dev *dev, unsigned int reg, u32 ic_clk,
@@ -283,12 +375,12 @@ extern const struct dev_pm_ops i2c_dw_dev_pm_ops;
 static inline void __i2c_dw_enable(struct dw_i2c_dev *dev)
 {
 	dev->status |= STATUS_ACTIVE;
-	regmap_write(dev->map, DW_IC_ENABLE, 1);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_ENABLE], 1);
 }
 
 static inline void __i2c_dw_disable_nowait(struct dw_i2c_dev *dev)
 {
-	regmap_write(dev->map, DW_IC_ENABLE, 0);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_ENABLE], 0);
 	dev->status &= ~STATUS_ACTIVE;
 }
 
@@ -297,7 +389,7 @@ static inline void __i2c_dw_write_intr_mask(struct dw_i2c_dev *dev,
 {
 	unsigned int val = dev->flags & ACCESS_POLLING ? 0 : intr_mask;
 
-	regmap_write(dev->map, DW_IC_INTR_MASK, val);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_INTR_MASK], val);
 	dev->sw_mask = intr_mask;
 }
 
@@ -305,11 +397,19 @@ static inline void __i2c_dw_read_intr_mask(struct dw_i2c_dev *dev,
 					   unsigned int *intr_mask)
 {
 	if (!(dev->flags & ACCESS_POLLING))
-		regmap_read(dev->map, DW_IC_INTR_MASK, intr_mask);
+		regmap_read(dev->map, dev->regs[DW_REG_IDX_INTR_MASK], intr_mask);
 	else
 		*intr_mask = dev->sw_mask;
 }
 
+/* Acknowledge a logical interrupt via dev->intr_clr[]: reg ID */
+static inline void i2c_dw_ack_intr(struct dw_i2c_dev *dev, enum dw_i2c_intr_idx intr)
+{
+	unsigned int dummy;
+
+	regmap_read(dev->map, dev->regs[dev->intr_clr[intr]], &dummy);
+}
+
 void __i2c_dw_disable(struct dw_i2c_dev *dev);
 void i2c_dw_disable(struct dw_i2c_dev *dev);
 
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index a1bcc3797e4f..f3b952f730bc 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -46,7 +46,7 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(dev->map, DW_IC_COMP_PARAM_1, &comp_param1);
+	ret = regmap_read(dev->map, dev->regs[DW_REG_IDX_COMP_PARAM_1], &comp_param1);
 	i2c_dw_release_lock(dev);
 	if (ret)
 		return ret;
@@ -60,14 +60,14 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 		ic_clk = i2c_dw_clk_rate(dev);
 		dev->ss_hcnt =
 			i2c_dw_scl_hcnt(dev,
-					DW_IC_SS_SCL_HCNT,
+					dev->regs[DW_REG_IDX_SS_SCL_HCNT],
 					ic_clk,
 					4000,	/* tHD;STA = tHIGH = 4.0 us */
 					sda_falling_time,
 					0);	/* No offset */
 		dev->ss_lcnt =
 			i2c_dw_scl_lcnt(dev,
-					DW_IC_SS_SCL_LCNT,
+					dev->regs[DW_REG_IDX_SS_SCL_LCNT],
 					ic_clk,
 					4700,	/* tLOW = 4.7 us */
 					scl_falling_time,
@@ -93,14 +93,14 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 			ic_clk = i2c_dw_clk_rate(dev);
 			dev->fs_hcnt =
 				i2c_dw_scl_hcnt(dev,
-						DW_IC_FS_SCL_HCNT,
+						dev->regs[DW_REG_IDX_FS_SCL_HCNT],
 						ic_clk,
 						260,	/* tHIGH = 260 ns */
 						sda_falling_time,
 						0);	/* No offset */
 			dev->fs_lcnt =
 				i2c_dw_scl_lcnt(dev,
-						DW_IC_FS_SCL_LCNT,
+						dev->regs[DW_REG_IDX_FS_SCL_LCNT],
 						ic_clk,
 						500,	/* tLOW = 500 ns */
 						scl_falling_time,
@@ -116,14 +116,14 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 		ic_clk = i2c_dw_clk_rate(dev);
 		dev->fs_hcnt =
 			i2c_dw_scl_hcnt(dev,
-					DW_IC_FS_SCL_HCNT,
+					dev->regs[DW_REG_IDX_FS_SCL_HCNT],
 					ic_clk,
 					600,	/* tHD;STA = tHIGH = 0.6 us */
 					sda_falling_time,
 					0);	/* No offset */
 		dev->fs_lcnt =
 			i2c_dw_scl_lcnt(dev,
-					DW_IC_FS_SCL_LCNT,
+					dev->regs[DW_REG_IDX_FS_SCL_LCNT],
 					ic_clk,
 					1300,	/* tLOW = 1.3 us */
 					scl_falling_time,
@@ -133,14 +133,14 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 		fp_str, dev->fs_hcnt, dev->fs_lcnt);
 
 	/* Check is high speed possible and fall back to fast mode if not */
-	if ((dev->master_cfg & DW_IC_CON_SPEED_MASK) ==
-		DW_IC_CON_SPEED_HIGH) {
+	if ((dev->master_cfg & dev->con_bits->speed_mask) ==
+		dev->con_bits->speed_high) {
 		if ((comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
 			!= DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
 			dev_err(dev->dev, "High Speed not supported!\n");
 			t->bus_freq_hz = I2C_MAX_FAST_MODE_FREQ;
-			dev->master_cfg &= ~DW_IC_CON_SPEED_MASK;
-			dev->master_cfg |= DW_IC_CON_SPEED_FAST;
+			dev->master_cfg &= ~dev->con_bits->speed_mask;
+			dev->master_cfg |= dev->con_bits->speed_fast;
 			dev->hs_hcnt = 0;
 			dev->hs_lcnt = 0;
 		} else if (!dev->hs_hcnt || !dev->hs_lcnt) {
@@ -166,14 +166,14 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 			ic_clk = i2c_dw_clk_rate(dev);
 			dev->hs_hcnt =
 				i2c_dw_scl_hcnt(dev,
-						DW_IC_HS_SCL_HCNT,
+						dev->regs[DW_REG_IDX_HS_SCL_HCNT],
 						ic_clk,
 						t_high,
 						sda_falling_time,
 						0);	/* No offset */
 			dev->hs_lcnt =
 				i2c_dw_scl_lcnt(dev,
-						DW_IC_HS_SCL_LCNT,
+						dev->regs[DW_REG_IDX_HS_SCL_LCNT],
 						ic_clk,
 						t_low,
 						scl_falling_time,
@@ -200,7 +200,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 
 	/* If the slave address is ten bit address, enable 10BITADDR */
 	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN) {
-		ic_con = DW_IC_CON_10BITADDR_MASTER;
+		ic_con = dev->con_bits->bit10_master;
 		/*
 		 * If I2C_DYNAMIC_TAR_UPDATE is set, the 10-bit addressing
 		 * mode has to be enabled via bit 12 of IC_TAR register.
@@ -210,14 +210,14 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 		ic_tar = DW_IC_TAR_10BITADDR_MASTER;
 	}
 
-	regmap_update_bits(dev->map, DW_IC_CON, DW_IC_CON_10BITADDR_MASTER,
+	regmap_update_bits(dev->map, dev->regs[DW_REG_IDX_CON], dev->con_bits->bit10_master,
 			   ic_con);
 
 	/*
 	 * Set the slave (target) address and enable 10-bit addressing mode
 	 * if applicable.
 	 */
-	regmap_write(dev->map, DW_IC_TAR,
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_TAR],
 		     msgs[dev->msg_write_idx].addr | ic_tar);
 
 	/* Enforce disabled interrupts (due to HW issues) */
@@ -227,10 +227,10 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	__i2c_dw_enable(dev);
 
 	/* Dummy read to avoid the register getting stuck on Bay Trail */
-	regmap_read(dev->map, DW_IC_ENABLE_STATUS, &dummy);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_ENABLE_STATUS], &dummy);
 
 	/* Clear and enable interrupts */
-	regmap_read(dev->map, DW_IC_CLR_INTR, &dummy);
+	i2c_dw_ack_intr(dev, DW_INTR_IDX_ALL);
 	__i2c_dw_write_intr_mask(dev, DW_IC_INTR_MASTER_MASK);
 }
 
@@ -253,11 +253,11 @@ static bool i2c_dw_is_controller_active(struct dw_i2c_dev *dev)
 {
 	u32 status;
 
-	regmap_read(dev->map, DW_IC_STATUS, &status);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_STATUS], &status);
 	if (!(status & DW_IC_STATUS_MASTER_ACTIVITY))
 		return false;
 
-	return regmap_read_poll_timeout(dev->map, DW_IC_STATUS, status,
+	return regmap_read_poll_timeout(dev->map, dev->regs[DW_REG_IDX_STATUS], status,
 				       !(status & DW_IC_STATUS_MASTER_ACTIVITY),
 				       1100, 20000) != 0;
 }
@@ -267,7 +267,7 @@ static int i2c_dw_check_stopbit(struct dw_i2c_dev *dev)
 	u32 val;
 	int ret;
 
-	ret = regmap_read_poll_timeout(dev->map, DW_IC_INTR_STAT, val,
+	ret = regmap_read_poll_timeout(dev->map, dev->regs[DW_REG_IDX_INTR_STAT], val,
 				       !(val & DW_IC_INTR_STOP_DET),
 					1100, 20000);
 	if (ret)
@@ -320,7 +320,7 @@ static int amd_i2c_dw_xfer_quirk(struct dw_i2c_dev *dev, struct i2c_msg *msgs, i
 		buf_len = msgs[msg_wrt_idx].len;
 
 		if (!(msgs[msg_wrt_idx].flags & I2C_M_RD))
-			regmap_write(dev->map, DW_IC_TX_TL, buf_len - 1);
+			regmap_write(dev->map, dev->regs[DW_REG_IDX_TX_TL], buf_len - 1);
 		/*
 		 * Initiate the i2c read/write transaction of buffer length,
 		 * and poll for bus busy status. For the last message transfer,
@@ -332,11 +332,13 @@ static int amd_i2c_dw_xfer_quirk(struct dw_i2c_dev *dev, struct i2c_msg *msgs, i
 
 			if (msgs[msg_wrt_idx].flags & I2C_M_RD) {
 				/* Due to hardware bug, need to write the same command twice. */
-				regmap_write(dev->map, DW_IC_DATA_CMD, 0x100);
-				regmap_write(dev->map, DW_IC_DATA_CMD, 0x100 | cmd);
+				regmap_write(dev->map, dev->regs[DW_REG_IDX_DATA_CMD], 0x100);
+				regmap_write(dev->map, dev->regs[DW_REG_IDX_DATA_CMD], 0x100 | cmd);
 				if (cmd) {
-					regmap_write(dev->map, DW_IC_TX_TL, 2 * (buf_len - 1));
-					regmap_write(dev->map, DW_IC_RX_TL, 2 * (buf_len - 1));
+					regmap_write(dev->map, dev->regs[DW_REG_IDX_TX_TL],
+						     2 * (buf_len - 1));
+					regmap_write(dev->map, dev->regs[DW_REG_IDX_RX_TL],
+						     2 * (buf_len - 1));
 					/*
 					 * Need to check the stop bit. However, it cannot be
 					 * detected from the registers so we check it always
@@ -347,7 +349,9 @@ static int amd_i2c_dw_xfer_quirk(struct dw_i2c_dev *dev, struct i2c_msg *msgs, i
 						return status;
 
 					for (data_idx = 0; data_idx < buf_len; data_idx++) {
-						regmap_read(dev->map, DW_IC_DATA_CMD, &val);
+						regmap_read(dev->map,
+							    dev->regs[DW_REG_IDX_DATA_CMD],
+							    &val);
 						tx_buf[data_idx] = val;
 					}
 					status = i2c_dw_check_stopbit(dev);
@@ -355,7 +359,8 @@ static int amd_i2c_dw_xfer_quirk(struct dw_i2c_dev *dev, struct i2c_msg *msgs, i
 						return status;
 				}
 			} else {
-				regmap_write(dev->map, DW_IC_DATA_CMD, *tx_buf++ | cmd);
+				regmap_write(dev->map, dev->regs[DW_REG_IDX_DATA_CMD],
+					     *tx_buf++ | cmd);
 				usleep_range(AMD_TIMEOUT_MIN_US, AMD_TIMEOUT_MAX_US);
 			}
 		}
@@ -399,15 +404,15 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			 * IC_RESTART_EN are set, we must manually
 			 * set restart bit between messages.
 			 */
-			if ((dev->master_cfg & DW_IC_CON_RESTART_EN) &&
-					(dev->msg_write_idx > 0))
+			if (dev->master_cfg & dev->con_bits->restart_en &&
+			    dev->msg_write_idx > 0)
 				need_restart = true;
 		}
 
-		regmap_read(dev->map, DW_IC_TXFLR, &flr);
+		regmap_read(dev->map, dev->regs[DW_REG_IDX_TXFLR], &flr);
 		tx_limit = dev->tx_fifo_depth - flr;
 
-		regmap_read(dev->map, DW_IC_RXFLR, &flr);
+		regmap_read(dev->map, dev->regs[DW_REG_IDX_RXFLR], &flr);
 		rx_limit = dev->rx_fifo_depth - flr;
 
 		while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
@@ -441,12 +446,12 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 				if (dev->rx_outstanding >= dev->rx_fifo_depth)
 					break;
 
-				regmap_write(dev->map, DW_IC_DATA_CMD,
+				regmap_write(dev->map, dev->regs[DW_REG_IDX_DATA_CMD],
 					     cmd | 0x100);
 				rx_limit--;
 				dev->rx_outstanding++;
 			} else {
-				regmap_write(dev->map, DW_IC_DATA_CMD,
+				regmap_write(dev->map, dev->regs[DW_REG_IDX_DATA_CMD],
 					     cmd | *buf++);
 			}
 			tx_limit--; buf_len--;
@@ -537,10 +542,10 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			buf = dev->rx_buf;
 		}
 
-		regmap_read(dev->map, DW_IC_RXFLR, &rx_valid);
+		regmap_read(dev->map, dev->regs[DW_REG_IDX_RXFLR], &rx_valid);
 
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
-			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
+			regmap_read(dev->map, dev->regs[DW_REG_IDX_DATA_CMD], &tmp);
 			tmp &= DW_IC_DATA_CMD_DAT;
 			/* Ensure length byte is a valid value */
 			if (flags & I2C_M_RECV_LEN) {
@@ -574,7 +579,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 {
-	unsigned int stat, dummy;
+	unsigned int stat;
 
 	/*
 	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
@@ -589,9 +594,9 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 	 * The raw version might be useful for debugging purposes.
 	 */
 	if (!(dev->flags & ACCESS_POLLING)) {
-		regmap_read(dev->map, DW_IC_INTR_STAT, &stat);
+		regmap_read(dev->map, dev->regs[DW_REG_IDX_INTR_STAT], &stat);
 	} else {
-		regmap_read(dev->map, DW_IC_RAW_INTR_STAT, &stat);
+		regmap_read(dev->map, dev->regs[DW_REG_IDX_RAW_INTR_STAT], &stat);
 		stat &= dev->sw_mask;
 	}
 
@@ -603,32 +608,32 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 	 * Instead, use the separately-prepared IC_CLR_* registers.
 	 */
 	if (stat & DW_IC_INTR_RX_UNDER)
-		regmap_read(dev->map, DW_IC_CLR_RX_UNDER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_UNDER);
 	if (stat & DW_IC_INTR_RX_OVER)
-		regmap_read(dev->map, DW_IC_CLR_RX_OVER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_OVER);
 	if (stat & DW_IC_INTR_TX_OVER)
-		regmap_read(dev->map, DW_IC_CLR_TX_OVER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_TX_OVER);
 	if (stat & DW_IC_INTR_RD_REQ)
-		regmap_read(dev->map, DW_IC_CLR_RD_REQ, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RD_REQ);
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		/*
 		 * The IC_TX_ABRT_SOURCE register is cleared whenever
 		 * the IC_CLR_TX_ABRT is read.  Preserve it beforehand.
 		 */
-		regmap_read(dev->map, DW_IC_TX_ABRT_SOURCE, &dev->abort_source);
-		regmap_read(dev->map, DW_IC_CLR_TX_ABRT, &dummy);
+		regmap_read(dev->map, dev->regs[DW_REG_IDX_TX_ABRT_SOURCE], &dev->abort_source);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_TX_ABRT);
 	}
 	if (stat & DW_IC_INTR_RX_DONE)
-		regmap_read(dev->map, DW_IC_CLR_RX_DONE, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_DONE);
 	if (stat & DW_IC_INTR_ACTIVITY)
-		regmap_read(dev->map, DW_IC_CLR_ACTIVITY, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_ACTIVITY);
 	if ((stat & DW_IC_INTR_STOP_DET) &&
 	    ((dev->rx_outstanding == 0) || (stat & DW_IC_INTR_RX_FULL)))
-		regmap_read(dev->map, DW_IC_CLR_STOP_DET, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_STOP_DET);
 	if (stat & DW_IC_INTR_START_DET)
-		regmap_read(dev->map, DW_IC_CLR_START_DET, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_START_DET);
 	if (stat & DW_IC_INTR_GEN_CALL)
-		regmap_read(dev->map, DW_IC_CLR_GEN_CALL, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_GEN_CALL);
 
 	return stat;
 }
@@ -688,8 +693,8 @@ irqreturn_t i2c_dw_isr_master(struct dw_i2c_dev *dev)
 {
 	unsigned int stat, enabled;
 
-	regmap_read(dev->map, DW_IC_ENABLE, &enabled);
-	regmap_read(dev->map, DW_IC_RAW_INTR_STAT, &stat);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_ENABLE], &enabled);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_RAW_INTR_STAT], &stat);
 	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
 		return IRQ_NONE;
 	if (pm_runtime_suspended(dev->dev) || stat == GENMASK(31, 0))
@@ -940,20 +945,20 @@ void i2c_dw_configure_master(struct dw_i2c_dev *dev)
 	if ((dev->flags & MODEL_MASK) != MODEL_AMD_NAVI_GPU)
 		dev->functionality |= I2C_FUNC_PROTOCOL_MANGLING;
 
-	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-			  DW_IC_CON_RESTART_EN;
+	dev->master_cfg = dev->con_bits->master | dev->con_bits->slave_disable |
+			  dev->con_bits->restart_en;
 
 	dev->mode = DW_IC_MASTER;
 
 	switch (t->bus_freq_hz) {
 	case I2C_MAX_STANDARD_MODE_FREQ:
-		dev->master_cfg |= DW_IC_CON_SPEED_STD;
+		dev->master_cfg |= dev->con_bits->speed_std;
 		break;
 	case I2C_MAX_HIGH_SPEED_MODE_FREQ:
-		dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
+		dev->master_cfg |= dev->con_bits->speed_high;
 		break;
 	default:
-		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
+		dev->master_cfg |= dev->con_bits->speed_fast;
 	}
 }
 EXPORT_SYMBOL_GPL(i2c_dw_configure_master);
@@ -1037,13 +1042,13 @@ int i2c_dw_probe_master(struct dw_i2c_dev *dev)
 	 * bus recovery process. Driver should not ignore this BIOS
 	 * advertisement of bus clear feature.
 	 */
-	ret = regmap_read(dev->map, DW_IC_CON, &ic_con);
+	ret = regmap_read(dev->map, dev->regs[DW_REG_IDX_CON], &ic_con);
 	i2c_dw_release_lock(dev);
 	if (ret)
 		return ret;
 
-	if (ic_con & DW_IC_CON_BUS_CLEAR_CTRL)
-		dev->master_cfg |= DW_IC_CON_BUS_CLEAR_CTRL;
+	if (ic_con & dev->con_bits->bus_clear_ctrl)
+		dev->master_cfg |= dev->con_bits->bus_clear_ctrl;
 
 	return i2c_dw_init_recovery_info(dev);
 }
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 468287922363..fc73106fb0f9 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -246,6 +246,8 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, dev);
 
+	i2c_dw_select_variant(dev);
+
 	if (controller->setup) {
 		r = controller->setup(pdev, controller);
 		if (r)
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 447af5523c2e..42b34c678146 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -156,6 +156,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	dev->flags = flags;
 	platform_set_drvdata(pdev, dev);
 
+	i2c_dw_select_variant(dev);
+
 	ret = dw_i2c_plat_request_regs(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 0abcc7757b23..7f20124d1181 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -53,7 +53,7 @@ int i2c_dw_unreg_slave(struct i2c_client *slave)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(slave->adapter);
 
-	regmap_write(dev->map, DW_IC_INTR_MASK, 0);
+	regmap_write(dev->map, dev->regs[DW_REG_IDX_INTR_MASK], 0);
 	i2c_dw_disable(dev);
 	synchronize_irq(dev->irq);
 	dev->slave = NULL;
@@ -65,7 +65,7 @@ int i2c_dw_unreg_slave(struct i2c_client *slave)
 
 static u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
 {
-	unsigned int stat, dummy;
+	unsigned int stat;
 
 	/*
 	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
@@ -79,7 +79,7 @@ static u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
 	 *
 	 * The raw version might be useful for debugging purposes.
 	 */
-	regmap_read(dev->map, DW_IC_INTR_STAT, &stat);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_INTR_STAT], &stat);
 
 	/*
 	 * Do not use the IC_CLR_INTR register to clear interrupts, or
@@ -89,23 +89,23 @@ static u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
 	 * Instead, use the separately-prepared IC_CLR_* registers.
 	 */
 	if (stat & DW_IC_INTR_TX_ABRT)
-		regmap_read(dev->map, DW_IC_CLR_TX_ABRT, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_TX_ABRT);
 	if (stat & DW_IC_INTR_RX_UNDER)
-		regmap_read(dev->map, DW_IC_CLR_RX_UNDER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_UNDER);
 	if (stat & DW_IC_INTR_RX_OVER)
-		regmap_read(dev->map, DW_IC_CLR_RX_OVER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_OVER);
 	if (stat & DW_IC_INTR_TX_OVER)
-		regmap_read(dev->map, DW_IC_CLR_TX_OVER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_TX_OVER);
 	if (stat & DW_IC_INTR_RX_DONE)
-		regmap_read(dev->map, DW_IC_CLR_RX_DONE, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_DONE);
 	if (stat & DW_IC_INTR_ACTIVITY)
-		regmap_read(dev->map, DW_IC_CLR_ACTIVITY, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_ACTIVITY);
 	if (stat & DW_IC_INTR_STOP_DET)
-		regmap_read(dev->map, DW_IC_CLR_STOP_DET, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_STOP_DET);
 	if (stat & DW_IC_INTR_START_DET)
-		regmap_read(dev->map, DW_IC_CLR_START_DET, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_START_DET);
 	if (stat & DW_IC_INTR_GEN_CALL)
-		regmap_read(dev->map, DW_IC_CLR_GEN_CALL, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_GEN_CALL);
 
 	return stat;
 }
@@ -119,9 +119,9 @@ irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev)
 	unsigned int raw_stat, stat, enabled, tmp;
 	u8 val = 0, slave_activity;
 
-	regmap_read(dev->map, DW_IC_ENABLE, &enabled);
-	regmap_read(dev->map, DW_IC_RAW_INTR_STAT, &raw_stat);
-	regmap_read(dev->map, DW_IC_STATUS, &tmp);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_ENABLE], &enabled);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_RAW_INTR_STAT], &raw_stat);
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_STATUS], &tmp);
 	slave_activity = ((tmp & DW_IC_STATUS_SLAVE_ACTIVITY) >> 6);
 
 	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY) || !dev->slave)
@@ -141,7 +141,7 @@ irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev)
 		}
 
 		do {
-			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
+			regmap_read(dev->map, dev->regs[DW_REG_IDX_DATA_CMD], &tmp);
 			if (tmp & DW_IC_DATA_CMD_FIRST_DATA_BYTE)
 				i2c_slave_event(dev->slave,
 						I2C_SLAVE_WRITE_REQUESTED,
@@ -149,13 +149,13 @@ irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev)
 			val = tmp;
 			i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED,
 					&val);
-			regmap_read(dev->map, DW_IC_STATUS, &tmp);
+			regmap_read(dev->map, dev->regs[DW_REG_IDX_STATUS], &tmp);
 		} while (tmp & DW_IC_STATUS_RFNE);
 	}
 
 	if (stat & DW_IC_INTR_RD_REQ) {
 		if (slave_activity) {
-			regmap_read(dev->map, DW_IC_CLR_RD_REQ, &tmp);
+			i2c_dw_ack_intr(dev, DW_INTR_IDX_RD_REQ);
 
 			if (!(dev->status & STATUS_READ_IN_PROGRESS)) {
 				i2c_slave_event(dev->slave,
@@ -168,7 +168,7 @@ irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev)
 						I2C_SLAVE_READ_PROCESSED,
 						&val);
 			}
-			regmap_write(dev->map, DW_IC_DATA_CMD, val);
+			regmap_write(dev->map, dev->regs[DW_REG_IDX_DATA_CMD], val);
 		}
 	}
 
@@ -185,8 +185,8 @@ void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
 
 	dev->functionality |= I2C_FUNC_SLAVE;
 
-	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
-			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED;
+	dev->slave_cfg = dev->con_bits->rx_fifo_full_hld_ctrl |
+			 dev->con_bits->restart_en | dev->con_bits->stop_det_ifaddressed;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_configure_slave);
 

-- 
2.53.0

