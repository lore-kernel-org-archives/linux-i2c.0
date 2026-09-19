Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8BA3F44C5;
	Sat, 19 Sep 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808857; cv=fail; b=gpR6nYPQbyyu0MQU+jXv8rrMo/i/ply2DW/p/0bnR7TDIqjC8lDE7Dvpf/zhot/pijO6G+3bas/wmcmvxSNHFdt+4qWKnwASzoM7jGwgbw/nNPfitLNFSd8XNuZ0TZ0UwwBaJpl13egc7YpKq02kydYeMrXTjnEyC3d3LmHX4lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808857; c=relaxed/simple;
	bh=AQ0AyRUpUfca6eRTcV3KgKYELB4FSN4zSe9xWg/w8Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ca1XdwVdM0NI4F5KY3/h4uWzBao3qC+7aWNjNPWh+rft5Pre3BAl6/J5Z3o4W2tw1/e4QdiwlytUHJhGRea+ZGG7LDx+F8oiqhKie2gaRctv6EhNKd7EMD2XYr03Gvkg/m72fcdY0rbBujJXjR9ueOfYgr+hVvXqfFCrke2hM78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Wg4dtFnJ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ebUdAEmI; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Wg4dtFnJ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ebUdAEmI"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J6ffCK1921565;
	Sat, 19 Sep 2026 04:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=pwRW1/j9EnI4k/nmDLnHdks09euqcxoWVumQOmPdG
	u8=; b=Wg4dtFnJKbU00z1T+SmUMoyWYbSKAy2fRu51gzi4LlwqUTdPqoiC+RJb9
	8otqTyM/fEF+gTGzER0ojqLwELtBZ7M/65NPyIkvtGcAGvBP3DMWBeumkuXvGovo
	Qk0PNiLo9rObQte32M8/GyFitcoQGYLVfhejghdN5jOW7IwAc7shET7bCuxo19er
	xkc5s6Ra90XfbhcKrCJjmuA90bCcX4DQhxMUWJ2/tdjxjDVwdGLCezQiHNUEmrLe
	F7q6yMruLrMoYtpyEMiG3oKOXqUmbBZNbswCzMWN28THto2snbagWJIKjrGGtEun
	M7uBX7egcbS+JEanaqispGs+NybJQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gs70ym5hg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 04:07:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDR/Nr5u2Q5UJirL7ScALfq7S8yfskmx9704sJvNrW3MJ2XpzGjIwUgh9hkviZOGP8H92Oc6yZ+biTuHaCwKezrLztSLcxK5h9enfuw7X6/0zHzwQypE4UmwBt+yJKo8UOb7UgtskbRYViFMQGCM0bD3a2xZt8BrrKEqCi3Nq6WxnoUoJqLoo4Dw5bGjN0c5U/rdW0LQxclHRttWcK40rPChvKC1d7K9oA8enVwZLQXY6sx0TJeExwfAgxsD+hWBMy07fgxco8Z/N0W/PsMY7S3maVqre/k71wBee6pNemAHvTXGTvPwcEQtomhOrlC0b9LqGKUv8a8z1PKJajI9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwRW1/j9EnI4k/nmDLnHdks09euqcxoWVumQOmPdGu8=;
 b=Ql7I9h24iSL03AuzhY1rN+Cy7i7J7G8hDiShsVkvvzHT6sJY6dYAV5Y9E6oezi+LHlznFr/NagQmEYqKcikqGGUmoTuAWV6UJqRQFui8z3whQ5JMX9qUYHkVHYjpjYj6RgCwgOIkKuWcnpKFmbD+m9H8uh0vNMsfAMPVQB3YQEmIfJQZg2wVtinl7ic8G2xWwlueymML0eLyWf8jVuizBbxy7bUb9f35aKJojBC/8w3tpqnPUnNC98LIYONpz4LmJZWIU2/oLAP0R7INBkCVn86pWGfR6epiu8ozbX3SM84vJ+ifT5VGKBe884zGZ18qhYD7Y09tMgkQrvW+G7ZVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwRW1/j9EnI4k/nmDLnHdks09euqcxoWVumQOmPdGu8=;
 b=ebUdAEmIRGwBusc/gm7cE6dmI6nPFEZxM1Dak5GGqA4UD12F6i3O/fiwE2wnlmrXpBxHd4lsG7tYB3w2W/WIaF57aO66je511h84dHNWbrh9CtDM89foX3a0YTrfhpOs+c2Vfrw1D3sc828XbtThT5UAFlMB/W/4m56nE9PdHNU=
Received: from CH2PR17CA0026.namprd17.prod.outlook.com (2603:10b6:610:53::36)
 by CH4PR10MB8226.namprd10.prod.outlook.com (2603:10b6:610:1f6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Sat, 19 Sep
 2026 09:07:16 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::6d) by CH2PR17CA0026.outlook.office365.com
 (2603:10b6:610:53::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Sat,
 19 Sep 2026 09:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 19 Sep 2026 09:07:15 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 19 Sep
 2026 04:06:39 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 19 Sep
 2026 04:06:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 19 Sep 2026 04:06:39 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68J96Jmg3292028;
	Sat, 19 Sep 2026 04:06:34 -0500
From: Aniket Limaye <a-limaye@ti.com>
Date: Sat, 19 Sep 2026 14:36:08 +0530
Subject: [PATCH 3/3] i2c: designware: Add snps,dwc-i2c support and new
 compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260919-tda54-upstream-i2c-v1-3-b0b9f77be18b@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CH4PR10MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 256007bb-3bbe-4d0e-2e22-08df162d6652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|7416014|10067099003|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	InXVXTmpActppdIT7FqrTEhHmC6HrfxFFHKHUltsND3IYgjeD7kMr9fWuNuoTuJMiOdIjCDffP1mRKLqSp2oeCGgM+/Y2LYM0yLwCOwpA0Kg1C3MbR91ACJgSO8v75QqxriTvZGPcLe7nvZceKyhUzlBPV6xonx1uvIRAveRK+BaewmfY+7bB4FuoObqriXOJMom0AJQqlXTtTMpxwLmpx4UWoDfxoVzSufwdtUAKWSHqu3LtInQ0aCvAzS6rM5TgwLyQxybWKjpDHFHQFeFYOky3FpItZvXiRXDz5OsgMqJPU3Zc3WZou68fspI+iNOGU6to4J/fmWfp2HAmDi/TBFN2qvt3JS32jjtU0S1Y70GfLnnTANBctztpQBKRZ6FPo/BH17It3AgU5P5mcN2U1GfMOvyAx6shaKjnWBvwTdaMfIuPA6SIDREd39TpOWyJ5S4ZUJo9ia7Lar7n82rGgc77m4ojaJOaC1BSGZHsivumc/PIeEfhRZVMF+3nBizi/Wsl+EbHZB38NjjVrVmKXwCF/hPata5ofeiMA8DU+UODhDJ6fVrG2hzvC8mOfp2NZRdNeWfKx1v8L49dLhMI/OOuO7ALwElIZ8Fp2DI/3MNe+ioacSnKytwrUeCJjLQjJGiPeiz1WS5jW5bedULTP3jrHreRT1gegzJ2eP3J+hpKOMdLnMFxhzSJJPhJpRh7nK8HB9piC3KApkSlVvZ7g==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(7416014)(10067099003)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NQRUCkiq4hES23r4g+wj2DNrpRFy15EbAPXl/IMr0GPpsE2PRlDdWY7JUBJg4MojOLzoCD34FIWsguZxkJLXtbf5cP6rYyIibW7mQMYGwNCVrErQA+YLX8Eu4IrgW+OpIGfRUcsQkGrpd3BON1h1vRoG3/2Il5mrMoLdQaN0oe0YCw1IwWtOf7qGmxuI9SYnoA0PZbnKxm22AfNqafIyKnm9pC0ptUC3ARQIGxS/1qDzQKuBuJznf3NrOt0FSSQ+HYvFTk0aMrg4SSb3IYn/QhvBn5mUuQWWfl5TGmfF5Za/qPlaS+S8HT58O3lWvVtyFxkWzGPMwWIvawM1eQMfFTW66Ho6ttvYFCjgrhckZfNfhoNexTHYiuhk2wVXDmC0RYdZyb7BOIQbKEEZ9cfqzwo87JZEQGiqU3EVk9llu888wGXRW8VF9wDuHrGXQA23
X-Exchange-RoutingPolicyChecked:
	RQEmV3Twui4is8agRs72ZjLKHAAmYCJXAaiP5VOAvEZ4CKCQakUwU/CbJFH201iJHsTC+gGkA1y6tqioUWaf/5TsYO/PXrQwqHx2W6/M0wW+o3NxzqNio5WiOVl6yK83oI+j6bDn6qSMARfQ08OheGsRAeFxBhZ7+/O0cAELSdRj5AQZFLOBgd21luHC7kdVygnXnC/Yc+NrIrx7EOc1ARyVzOyHKiJb/EM0UV3x+JWKUDLYviwktr1Ip4ecSwZKeeNBEbnueehmnlBZrtPMZi8IeROUo8HwjomGioRl/Y17/YN5YZce5BkxRcFQqY1cEt2mtH6zxp90NOlqqeV6aA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 09:07:15.4658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256007bb-3bbe-4d0e-2e22-08df162d6652
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8226
X-Authority-Analysis: v=2.4 cv=VKVIDNPX c=1 sm=1 tr=0 ts=6aae50c8 cx=c_pps
 a=Al0BzvsZ99ielPXA9PThCA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=qPVfMx805hdmaPGg-GAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDEzMCBTYWx0ZWRfXzBcjGyZ5EmpY
 +5UMxJEcDGhTKOwJgZmGsDxQgCB/5vIzaeKK2kebG3RjArTaZDjwwsAs5yy94Pj52C6XgG5nq2T
 cFLaJk9553RY7jYUOfjGgdXTaBdm+ZyU9M0pZW2OO4QVbR65zkBLQImAE1huXNCnkFcv0ZNy/W6
 rqL+CsKALt9oBQGL9rffkZKpTJh2nstbGD0RYCXtASChi7l/M6WkK+W5VzGedmijch6iu3/bamx
 HZKc6zp2js1xvLmUlDz/UyqzAh5ybtmKux+Ym9fYGX43/P70ZGqBn6WVhd2/wAq0E9y/Y+vwZHJ
 xudjerZUVZJYn+mA9v8NPXW0Fa/F2iuwr2d/WnQ3x+fDIJ9rczfypGtPYPPWF+8hPwIhA3bT6Oh
 MEWG4IpY2usIbEW1b/uKG2HLXoijctQxG2I4THj+M4oS1+/Yni2aENqTg3wWWoCdSHmRZ0EtySB
 HdnquMsE1sczpNOEFpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDEzMCBTYWx0ZWRfX+ALg97rtuO/s
 XM6pKkBGgY43I96RCsKMWRebBQ6WoNuoToyQxti9MfrlmKnGcUDfozxlk7OlcNGHVj+pidaMmhR
 QRImt3slJ938pkfaXW0yphWamQHT9KQ=
X-Proofpoint-GUID: xUpp9gTTS2RD-5ajB4XqCrO50MC-W73R
X-Proofpoint-ORIG-GUID: xUpp9gTTS2RD-5ajB4XqCrO50MC-W73R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190130

Add the register offset table and CON-register bit layout for the
DWC_i2c IP ("snps,dwc-i2c"), and register it in dw_i2c_of_match[] with
the new MODEL_DWC_I2C flag.

Compared to the existing DW_apb_i2c layout [1], DWC_i2c [0] differs
enough to need MODEL_DWC_I2C-gated special-casing in a few places,
besides the offset/bit-layout tables themselves:

- Interrupts are acknowledged by writing a bitmask to a single CLR_INTR
  register instead of reading N dedicated CLR_* registers;
  i2c_dw_ack_intr() picks the right method based on dev->flags.
- One HCNT/LCNT register pair is shared between standard and fast speed
  instead of having one pair each; i2c_dw_write_timings() writes
  whichever value set matches the configured speed.
- No COMP_PARAM_1 register, so FIFO depth and high-speed-mode support
  can't be autodetected: FIFO depth now comes from the required
  snps,tx-fifo-depth/snps,rx-fifo-depth DT properties, and the
  high-speed capability check is skipped.
- No defined CON.RESTART_EN bit; treat it as always set.

The register offsets used for DWC_i2c are those present in TI TDA54 SoC.

[0]: DWC_i2c_reference.pdf
[1]: DW_apb_i2c_databook.pdf

Signed-off-by: Aniket Limaye <a-limaye@ti.com>

---

SMBus is not supported on TI TDA54 SoC, and hence this patch does not
add SMBus register offsets.
---
 drivers/i2c/busses/i2c-designware-common.c  | 139 +++++++++++++++++++++++++---
 drivers/i2c/busses/i2c-designware-core.h    |  26 +++++-
 drivers/i2c/busses/i2c-designware-master.c  |  26 ++++--
 drivers/i2c/busses/i2c-designware-platdrv.c |   1 +
 4 files changed, 168 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a21aeb7f415a..cc05c822aa56 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -113,6 +113,41 @@ static const u32 dw_i2c_reg_offsets[DW_REG_IDX_MAX] = {
 	[DW_REG_IDX_COMP_TYPE]		= DW_IC_COMP_TYPE,
 };
 
+/* "snps,dwc-i2c" block-based register layout */
+#define DWC_OPERATION_BLK_OFFSET		0x00
+#define DWC_I2C_BLK_OFFSET			0x28
+#define DWC_FIFO_INTR_BLK_OFFSET		0xbc
+#define DWC_DEBUG_BLK_OFFSET			0xf8
+
+static const u32 dwc_i2c_reg_offsets[DW_REG_IDX_MAX] = {
+	[DW_REG_IDX_ENABLE]			= DWC_OPERATION_BLK_OFFSET + 0x04,
+	[DW_REG_IDX_CAPABILITIES]		= DWC_OPERATION_BLK_OFFSET + 0x0c,
+	[DW_REG_IDX_CON]			= DWC_I2C_BLK_OFFSET + 0x04,
+	[DW_REG_IDX_TAR]			= DWC_I2C_BLK_OFFSET + 0x08,
+	[DW_REG_IDX_SAR]			= DWC_I2C_BLK_OFFSET + 0x0c, /* DAR on this IP */
+	[DW_REG_IDX_DATA_CMD]		= DWC_I2C_BLK_OFFSET + 0x58,
+	[DW_REG_IDX_SS_SCL_HCNT]		= DWC_I2C_BLK_OFFSET + 0x24, /* shared SS/FS pair */
+	[DW_REG_IDX_SS_SCL_LCNT]		= DWC_I2C_BLK_OFFSET + 0x28,
+	[DW_REG_IDX_FS_SCL_HCNT]		= DWC_I2C_BLK_OFFSET + 0x24,
+	[DW_REG_IDX_FS_SCL_LCNT]		= DWC_I2C_BLK_OFFSET + 0x28,
+	[DW_REG_IDX_HS_SCL_HCNT]		= DWC_I2C_BLK_OFFSET + 0x2c,
+	[DW_REG_IDX_HS_SCL_LCNT]		= DWC_I2C_BLK_OFFSET + 0x30,
+	[DW_REG_IDX_SDA_HOLD]		= DWC_I2C_BLK_OFFSET + 0x34,
+	[DW_REG_IDX_RX_TL]			= DWC_I2C_BLK_OFFSET + 0x5c,
+	[DW_REG_IDX_TX_TL]			= DWC_I2C_BLK_OFFSET + 0x60,
+	[DW_REG_IDX_INTR_STAT]		= DWC_FIFO_INTR_BLK_OFFSET + 0x04,
+	[DW_REG_IDX_INTR_MASK]		= DWC_FIFO_INTR_BLK_OFFSET + 0x08,
+	[DW_REG_IDX_RAW_INTR_STAT]		= DWC_FIFO_INTR_BLK_OFFSET + 0x0c,
+	[DW_REG_IDX_CLR_INTR]		= DWC_FIFO_INTR_BLK_OFFSET + 0x10,
+	[DW_REG_IDX_STATUS]			= DWC_FIFO_INTR_BLK_OFFSET + 0x1c,
+	[DW_REG_IDX_TXFLR]			= DWC_FIFO_INTR_BLK_OFFSET + 0x20,
+	[DW_REG_IDX_RXFLR]			= DWC_FIFO_INTR_BLK_OFFSET + 0x24,
+	[DW_REG_IDX_TX_ABRT_SOURCE]		= DWC_FIFO_INTR_BLK_OFFSET + 0x18,
+	[DW_REG_IDX_ENABLE_STATUS]		= DWC_FIFO_INTR_BLK_OFFSET + 0x14,
+	[DW_REG_IDX_COMP_VERSION]		= DWC_DEBUG_BLK_OFFSET + 0x08,
+	[DW_REG_IDX_COMP_TYPE]		= DWC_DEBUG_BLK_OFFSET + 0x0c,
+};
+
 static const struct dw_i2c_con_bits dw_i2c_con_bits = {
 	.master			= DW_IC_CON_MASTER,
 	.speed_std		= DW_IC_CON_SPEED_STD,
@@ -129,6 +164,26 @@ static const struct dw_i2c_con_bits dw_i2c_con_bits = {
 	.bus_clear_ctrl		= DW_IC_CON_BUS_CLEAR_CTRL,
 };
 
+/*
+ * DWC_IC_CTRL bit layout for "snps,dwc-i2c".
+ * There is no defined bit for RESTART_EN or SLAVE_DISABLE on this IP.
+ */
+static const struct dw_i2c_con_bits dwc_i2c_con_bits = {
+	.master			= BIT(0),
+	.speed_std		= (1 << 4),
+	.speed_fast		= (2 << 4),
+	.speed_high		= (3 << 4),
+	.speed_mask		= GENMASK(5, 4),
+	.bit10_slave		= BIT(8),
+	.bit10_master		= BIT(9),
+	.restart_en		= 0,
+	.slave_disable		= 0,
+	.stop_det_ifaddressed	= BIT(10),
+	.tx_empty_ctrl		= BIT(11),
+	.rx_fifo_full_hld_ctrl	= BIT(12),
+	.bus_clear_ctrl		= 0,
+};
+
 /* "snps,designware-i2c": dedicated read-to-clear register ID per logical interrupt */
 static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
 	[DW_INTR_IDX_ALL]       = DW_REG_IDX_CLR_INTR,
@@ -144,6 +199,21 @@ static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
 	[DW_INTR_IDX_GEN_CALL]  = DW_REG_IDX_CLR_GEN_CALL,
 };
 
+/* "snps,dwc-i2c" DW_REG_IDX_CLR_INTR bit to write per logical interrupt */
+static const u32 dwc_i2c_intr_clr[DW_INTR_IDX_MAX] = {
+	[DW_INTR_IDX_ALL]       = DWC_IC_INTR_CLR_INTR,
+	[DW_INTR_IDX_RX_UNDER]  = DWC_IC_INTR_CLR_RX_UNDER,
+	[DW_INTR_IDX_RX_OVER]   = DWC_IC_INTR_CLR_RX_OVER,
+	[DW_INTR_IDX_TX_OVER]   = DWC_IC_INTR_CLR_TX_OVER,
+	[DW_INTR_IDX_RD_REQ]    = DWC_IC_INTR_CLR_RD_REQ,
+	[DW_INTR_IDX_TX_ABRT]   = DWC_IC_INTR_CLR_TX_ABRT,
+	[DW_INTR_IDX_RX_DONE]   = DWC_IC_INTR_CLR_RX_DONE,
+	[DW_INTR_IDX_ACTIVITY]  = DWC_IC_INTR_CLR_ACTIVITY,
+	[DW_INTR_IDX_STOP_DET]  = DWC_IC_INTR_CLR_STOP_DET,
+	[DW_INTR_IDX_START_DET] = DWC_IC_INTR_CLR_START_DET,
+	[DW_INTR_IDX_GEN_CALL]  = DWC_IC_INTR_CLR_GEN_CALL,
+};
+
 /**
  * i2c_dw_select_variant() - Pick the register offset table, CON-register bit
  * layout and interrupt-ack mapping matching this device's IP variant
@@ -155,9 +225,15 @@ static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
  */
 void i2c_dw_select_variant(struct dw_i2c_dev *dev)
 {
-	dev->regs = dw_i2c_reg_offsets;
-	dev->con_bits = &dw_i2c_con_bits;
-	dev->intr_clr = dw_i2c_intr_clr;
+	if (dev->flags & MODEL_DWC_I2C) {
+		dev->regs = dwc_i2c_reg_offsets;
+		dev->con_bits = &dwc_i2c_con_bits;
+		dev->intr_clr = dwc_i2c_intr_clr;
+	} else {
+		dev->regs = dw_i2c_reg_offsets;
+		dev->con_bits = &dw_i2c_con_bits;
+		dev->intr_clr = dw_i2c_intr_clr;
+	}
 }
 EXPORT_SYMBOL_GPL(i2c_dw_select_variant);
 
@@ -475,13 +551,27 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 
 static void i2c_dw_write_timings(struct dw_i2c_dev *dev)
 {
-	/* Write standard speed timing parameters */
-	regmap_write(dev->map, dev->regs[DW_REG_IDX_SS_SCL_HCNT], dev->ss_hcnt);
-	regmap_write(dev->map, dev->regs[DW_REG_IDX_SS_SCL_LCNT], dev->ss_lcnt);
-
-	/* Write fast mode/fast mode plus timing parameters */
-	regmap_write(dev->map, dev->regs[DW_REG_IDX_FS_SCL_HCNT], dev->fs_hcnt);
-	regmap_write(dev->map, dev->regs[DW_REG_IDX_FS_SCL_LCNT], dev->fs_lcnt);
+	if (dev->flags & MODEL_DWC_I2C) {
+		/*
+		 * Only one HCNT/LCNT register pair backs both speeds on
+		 * this IP -- write whichever value set matches master_cfg.
+		 */
+		if ((dev->master_cfg & dev->con_bits->speed_mask) == dev->con_bits->speed_std) {
+			regmap_write(dev->map, dev->regs[DW_REG_IDX_SS_SCL_HCNT], dev->ss_hcnt);
+			regmap_write(dev->map, dev->regs[DW_REG_IDX_SS_SCL_LCNT], dev->ss_lcnt);
+		} else {
+			regmap_write(dev->map, dev->regs[DW_REG_IDX_FS_SCL_HCNT], dev->fs_hcnt);
+			regmap_write(dev->map, dev->regs[DW_REG_IDX_FS_SCL_LCNT], dev->fs_lcnt);
+		}
+	} else {
+		/* Write standard speed timing parameters */
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_SS_SCL_HCNT], dev->ss_hcnt);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_SS_SCL_LCNT], dev->ss_lcnt);
+
+		/* Write fast mode/fast mode plus timing parameters */
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_FS_SCL_HCNT], dev->fs_hcnt);
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_FS_SCL_LCNT], dev->fs_lcnt);
+	}
 
 	/* Write high speed timing parameters */
 	regmap_write(dev->map, dev->regs[DW_REG_IDX_HS_SCL_HCNT], dev->hs_hcnt);
@@ -513,6 +603,16 @@ void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode)
 	dev->mode = mode;
 }
 
+/* Not every snps,dwc-i2c instance has the SMBus block; check IC_CAPABILITIES */
+static bool i2c_dwc_has_smbus(struct dw_i2c_dev *dev)
+{
+	u32 caps = 0;
+
+	regmap_read(dev->map, dev->regs[DW_REG_IDX_CAPABILITIES], &caps);
+
+	return caps & DWC_IC_CAPABILITIES_SMBUS;
+}
+
 /**
  * i2c_dw_init() - Initialize the DesignWare I2C hardware
  * @dev: device private data
@@ -536,8 +636,10 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	 * Mask SMBus interrupts to block storms from broken
 	 * firmware that leaves IC_SMBUS=1; the handler never
 	 * services them.
+	 * For DWC-i2c, need to first check if SMBus is supported
 	 */
-	regmap_write(dev->map, dev->regs[DW_REG_IDX_SMBUS_INTR_MASK], 0);
+	if (!(dev->flags & MODEL_DWC_I2C) || i2c_dwc_has_smbus(dev))
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_SMBUS_INTR_MASK], 0);
 
 	i2c_dw_write_timings(dev);
 
@@ -581,6 +683,14 @@ int i2c_dw_fw_parse_and_configure(struct dw_i2c_dev *dev)
 	if (device_property_read_u32(device, "snps,bus-capacitance-pf", &dev->bus_capacitance_pF))
 		dev->bus_capacitance_pF = DW_IC_DEFAULT_BUS_CAPACITANCE_pF;
 
+	if (dev->flags & MODEL_DWC_I2C) {
+		device_property_read_u32(device, "snps,tx-fifo-depth", &dev->tx_fifo_depth);
+		device_property_read_u32(device, "snps,rx-fifo-depth", &dev->rx_fifo_depth);
+
+		if (!dev->tx_fifo_depth || !dev->rx_fifo_depth)
+			return -EINVAL;
+	}
+
 	dev->clk_freq_optimized = device_property_read_bool(device, "snps,clk-freq-optimized");
 
 	/* Mobileye controllers do not hold the clock on empty FIFO */
@@ -897,6 +1007,13 @@ static int i2c_dw_set_fifo_size(struct dw_i2c_dev *dev)
 		return 0;
 	}
 
+	/*
+	 * DW_IC_COMP_PARAM_1 not implemented on this IP;
+	 * fifo depth set in i2c_dw_fw_parse_and_configure().
+	 */
+	if (dev->flags & MODEL_DWC_I2C)
+		return 0;
+
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
 	 * the depth could be from 2 to 256 from HW spec.
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 2fad18582db7..08a29f70c5dd 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -88,6 +88,7 @@ enum dw_i2c_reg_idx {
 	DW_REG_IDX_COMP_PARAM_1,
 	DW_REG_IDX_COMP_VERSION,
 	DW_REG_IDX_COMP_TYPE,
+	DW_REG_IDX_CAPABILITIES,
 	DW_REG_IDX_MAX,
 };
 
@@ -128,6 +129,21 @@ enum dw_i2c_intr_idx {
 	DW_INTR_IDX_MAX,
 };
 
+#define DWC_IC_INTR_CLR_INTR			BIT(0)
+#define DWC_IC_INTR_CLR_RX_UNDER		BIT(1)
+#define DWC_IC_INTR_CLR_RX_OVER			BIT(2)
+#define DWC_IC_INTR_CLR_TX_OVER			BIT(3)
+#define DWC_IC_INTR_CLR_RD_REQ			BIT(4)
+#define DWC_IC_INTR_CLR_TX_ABRT			BIT(5)
+#define DWC_IC_INTR_CLR_RX_DONE			BIT(6)
+#define DWC_IC_INTR_CLR_ACTIVITY		BIT(7)
+#define DWC_IC_INTR_CLR_STOP_DET		BIT(8)
+#define DWC_IC_INTR_CLR_START_DET		BIT(9)
+#define DWC_IC_INTR_CLR_GEN_CALL		BIT(10)
+
+/* IC_CAPABILITIES bit reporting whether SMBus is present on this instance */
+#define DWC_IC_CAPABILITIES_SMBUS		BIT(10)
+
 #define DW_IC_INTR_DEFAULT_MASK			(DW_IC_INTR_RX_FULL | \
 						 DW_IC_INTR_TX_ABRT | \
 						 DW_IC_INTR_STOP_DET)
@@ -340,7 +356,8 @@ struct dw_i2c_dev {
 
 #define MODEL_AMD_NAVI_GPU			BIT(10)
 #define MODEL_WANGXUN_SP			BIT(11)
-#define MODEL_MASK				GENMASK(11, 8)
+#define MODEL_DWC_I2C				BIT(12)
+#define MODEL_MASK				GENMASK(12, 8)
 
 /*
  * Enable UCSI interrupt by writing 0xd at register
@@ -402,12 +419,15 @@ static inline void __i2c_dw_read_intr_mask(struct dw_i2c_dev *dev,
 		*intr_mask = dev->sw_mask;
 }
 
-/* Acknowledge a logical interrupt via dev->intr_clr[]: reg ID */
+/* Acknowledge a logical interrupt via dev->intr_clr[]: reg ID or bit offset */
 static inline void i2c_dw_ack_intr(struct dw_i2c_dev *dev, enum dw_i2c_intr_idx intr)
 {
 	unsigned int dummy;
 
-	regmap_read(dev->map, dev->regs[dev->intr_clr[intr]], &dummy);
+	if (dev->flags & MODEL_DWC_I2C)
+		regmap_write(dev->map, dev->regs[DW_REG_IDX_CLR_INTR], dev->intr_clr[intr]);
+	else
+		regmap_read(dev->map, dev->regs[dev->intr_clr[intr]], &dummy);
 }
 
 void __i2c_dw_disable(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index f3b952f730bc..8ed4d89e631c 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -42,14 +42,16 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 	u32 ic_clk;
 	int ret;
 
-	ret = i2c_dw_acquire_lock(dev);
-	if (ret)
-		return ret;
-
-	ret = regmap_read(dev->map, dev->regs[DW_REG_IDX_COMP_PARAM_1], &comp_param1);
-	i2c_dw_release_lock(dev);
-	if (ret)
-		return ret;
+	if (!(dev->flags & MODEL_DWC_I2C)) {
+		ret = i2c_dw_acquire_lock(dev);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(dev->map, dev->regs[DW_REG_IDX_COMP_PARAM_1], &comp_param1);
+		i2c_dw_release_lock(dev);
+		if (ret)
+			return ret;
+	}
 
 	/* Set standard and fast speed dividers for high/low periods */
 	sda_falling_time = t->sda_fall_ns ?: 300; /* ns */
@@ -135,7 +137,8 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 	/* Check is high speed possible and fall back to fast mode if not */
 	if ((dev->master_cfg & dev->con_bits->speed_mask) ==
 		dev->con_bits->speed_high) {
-		if ((comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
+		if (!(dev->flags & MODEL_DWC_I2C) &&
+		    (comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
 			!= DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
 			dev_err(dev->dev, "High Speed not supported!\n");
 			t->bus_freq_hz = I2C_MAX_FAST_MODE_FREQ;
@@ -403,8 +406,11 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			 * If both IC_EMPTYFIFO_HOLD_MASTER_EN and
 			 * IC_RESTART_EN are set, we must manually
 			 * set restart bit between messages.
+			 * snps,dwc-i2c does not define a CON.RESTART_EN
+			 * bit, and behaves like it is set to 1.
 			 */
-			if (dev->master_cfg & dev->con_bits->restart_en &&
+			if (((dev->master_cfg & dev->con_bits->restart_en) ||
+			     (dev->flags & MODEL_DWC_I2C)) &&
 			    dev->msg_write_idx > 0)
 				need_restart = true;
 		}
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 42b34c678146..a3cd81cc2c0b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -257,6 +257,7 @@ static const struct of_device_id dw_i2c_of_match[] = {
 	{ .compatible = "mobileye,eyeq6lplus-i2c" },
 	{ .compatible = "mscc,ocelot-i2c" },
 	{ .compatible = "snps,designware-i2c" },
+	{ .compatible = "snps,dwc-i2c", .data = (void *)MODEL_DWC_I2C },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);

-- 
2.53.0

