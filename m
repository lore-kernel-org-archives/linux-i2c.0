Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8298534DCCD;
	Fri, 25 Sep 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328468; cv=fail; b=Ig4lM6uonAoVQm7mdwyIO1lKomYLPT1RdMIIkfc5e7InAVolcRlBDLHOjCJjf3wXk1tnLhRR8Nx4tqL4OOHyS72MPjClSvFz1VryQBAN/fJHkM7lSW1LEsu5gjzgVOn380j73zVgJOTJ6W/DrStW6Z/2WK1IARb56IEIch/0+8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328468; c=relaxed/simple;
	bh=LHzoc9EcksFB3CoOYrAct+fQlqCNKwr0WeKgBdYJndo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=arb96MwAfolrMQ72fsZllvk4ipiklE5Vd70BK5RJlUs8rlh29G2F2pGEYcoTHN240fNcYRmteCITlEkbU4mzLIlxYmVsqlkttxUf2XeRh57jtGXX8eaytz7kY6mZSXAVW1cTj3si0yEs/j34/DXFta1a+dJrND20XfeU20ECvjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ehZ46SGF; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MZ7dlUPH; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ehZ46SGF";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MZ7dlUPH"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P6GBjE1848571;
	Fri, 25 Sep 2026 04:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=x/Cz9c1llnVwWdgiXNs19hXhGpb64FVXGHqAXXSp2
	rQ=; b=ehZ46SGFG6HpOXbymeGg3FHrGei2aS3EbGdhuSNDpykYDf5Yf5UJKBjKD
	yfi/bTX4xdf8KN703EjtM1+lA174G7lCmqp5c+KO2e7u/YrI5yRi2dH4SbV1tpKh
	QXdWZykJ0VEeoA8lQKnieAtWBqj1Oeq4SIoLnToQLYs3a1lPBH5lHuJ/CU8b8SnC
	/UrQt7f3LEFosUsbTk2Gq4T4LF/2saMIcjxqgzphzBKqAmQb+OfAtsmU26XZvOZ4
	bfVhCCU3JYktRhnxu1e3/tRtdHSvKjBd7A3OWhd/QdMCOuMmNPc5LcapWX1Q36Wz
	OMilT8Ouhge75S7O1fBablm3O5Fmg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gwkhr8v6x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:27:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4p9BpYLWx7ajr7HpLpzrWJT3dKcBBUWTi7pDqBeAsoSQiAbaNQwUvGDvu0zE8cm/5batznXQBQODc4FfD1OYqm1yJvRSS3PX4e/SONvJomQZW0tqImJdhe/bHawOrOOuopxvNk+2gBHaOlDoqXdR6ukA1Y5zQnLr8CuqM3RNHVXlpUbrsj9bEUnGJAhqjf+WY4PefNiUIFkkhOerY0z2XAcaplackmvF8EbzQmlqklA0qxeQP8t8BAXNuaX4HDolWlNuFHoDnFbWVn+10akk72C4bndktUfwJnb0abJPuOezFJ1AZkrGbzxBz5+RXJCTw4v882FvnW7TOknMD+Zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/Cz9c1llnVwWdgiXNs19hXhGpb64FVXGHqAXXSp2rQ=;
 b=SRPeqEkzJlfeDxeahjl6oOk5ZFUx+tkQY8cxosUIkOxg3iv1bECtWInbVgktz/HUiDz/UFsEkzH75Eh+J0rLWQSjEb4bcqXXQ17peq/RKLTvdnMbN+htbC8HzJcQdvYMfyb9uAdSKA3FNLBWhwliEEN7iEV4sJ5H6GaglaaLpmvArh7zqUbS3K4QBJoy3OgGJkH8Xo15ccQV9hO2TfSICSmCcxTHCS8YMd6uR2sq/Ic/Vw2HvAnQlf+JQYI8XAmp77N5e+BylyhD0ABAcw3VNiVGjOsTOdb2ekXUmQgG/2JCtd3Fi2R5OF2cgrPtWkHr/I/IjDUP73YevrAt2Bf3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=arm.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/Cz9c1llnVwWdgiXNs19hXhGpb64FVXGHqAXXSp2rQ=;
 b=MZ7dlUPH/dPn+fubT53Od9KO+ZaMR5scajsW8dzxD/vcUAZ+VThgWuzxN13aXcYYWifuq5z3PKyEuImXUWoa/UyVIH+hJA76Iq7UjgWJn/eqhly8gENehRRvXYtnXUbxvukUVljxPYVLuwJSQz9U5J7HBBTNgBFXA8rfoAOgygQ=
Received: from CH0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:610:119::12)
 by LV3PR10MB7842.namprd10.prod.outlook.com (2603:10b6:408:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 09:27:27 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::1f) by CH0PR03CA0366.outlook.office365.com
 (2603:10b6:610:119::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 09:27:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 09:27:26 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 04:27:01 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 04:27:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 04:27:00 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68P9QuGh2506063;
	Fri, 25 Sep 2026 04:26:56 -0500
Message-ID: <549277f1-8409-47c5-beb8-eee1f4e130b3@ti.com>
Date: Fri, 25 Sep 2026 14:56:55 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: designware: Introduce per-variant register
 offset and bit-layout tables
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg
	<mika.westerberg@linux.intel.com>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <u-kumar1@ti.com>, <lianfeng.ouyang@starfivetech.com>,
        <Ritwick.Sharma@arm.com>
References: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
 <20260919-tda54-upstream-i2c-v1-2-b0b9f77be18b@ti.com>
 <20260921111148.GT106095@black.igk.intel.com>
 <arYsyiu4KG-m23hh@ashevche-desk.local>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <arYsyiu4KG-m23hh@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|LV3PR10MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 68609605-3e79-4f93-7764-08df1ae73691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|23010399003|376014|10067099003|18002099003|56012099006|4143699003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	+z2ve2bP2Oyx5NTCLViIaXv0MVK0PuQHaXHy9cWs0Ev4v3JT5fZx4VMObLtZKl4dKKjlzZFK3DCCPEPJmzhFSUqFuN3HtsK6f1pkKoZsJiP/+UXSGpM1K7nz5NikGTRvw2Bq6DbpnEy994Ok7VGSrU+mkfogE47hWFWpW06hxBv7l6QLOA2ieAMu4bpcefQF3idwWlk+LQD37n/45BonnrtnoE2e7ylP8Qjrg1zB8rr3ySs66XT5Jpt3zbRqlUeVpB1V/07Iw92oXF6oWEd/wdZx4UahMufKmPI2OMAsk4F8dGaPpWsi9ZJZ92vBp9ng3mFpqAxW+i/lNpJEBto36mC1BitOOiVvH7sgsLGdjCyF5VisKrpKMixWes6VTEx9hJ6XB8jUtFaCfFSNwJT5bpbaPtkbN/wCGzGn+HFwAXUH75hwGNsHQm5JP0ADywkJqJAvXhiDnSWjY84C4DzDD39n3FHYbGyoL76UQhixOFqgFZCFnvimRYD14Vi0zirN5SuoJovkuKGG8d6QrwAq54atZm1bFsAJLwmDrITDyqOiGr/vkdp8KBSYjVflWonjdbOXoCCICBfy0wh+x3JwdtefkMQ2JXCbdtZJOMgVQ2fredIAAClwqUmRI4XR6v/cCQDVW41yxaLs3qDqMI6LS6T0ze2CgZV9hI2oN9ubJb5NuLKY5xTEJEDNcXY0wtRCl44cPBq1M1JKhZJAH1m7bQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(23010399003)(376014)(10067099003)(18002099003)(56012099006)(4143699003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6DUfwvTTmor3TkyUs3v0u5jgs1+HsiiW02NH2PU0BYZbA8NJGEqyUS4wY2Zm6FviQPsdsTU6NFv7JBrtNQWUkSF0tzj1SLGUirFSiTHwf9knlkWkhDF3//8vsgG+0ut0El2lmJaU5iWNJXMCkC9D5UUNDfnjmWGj4yueAMAROYCNlvAfo1JZqRPhj4WuWjF7fRj3Y8EQTA8q9aeTXJdeH7Y93eJZi5TVOwszyPiGVG4ONMpn8oNcGsvwC6UNLKDIAA5VPbM3FDu6/h4mcMJXA3R6fnZyBf4td5J5dFJ1JXnZWajaTmpmyIW1aHSYIrCBpuTaPLaq3zB8FDOxQuZIO4cE7T9k5PYfyhRNvmaX9LNdBwlTkZ0QD1Pz7EyIXt73GDuu/1SexbGSchP/T8/fn2uDJSu0AUpzSMhsuIAAne2v1sJUXD7WQpm6/13+0luS
X-Exchange-RoutingPolicyChecked:
	Sr7B83RGBnZeaUIisK/nSzYxNl5PJoMNO5oe+knEgApPgEapji+dhoBsoOsRutk2TQA4T7iAIO8FhryreQO+BuSvI3IXKoiF/xPQEEhQUJRa7p0VaZfq8ykDPg0b78xv/LEU1rNiSRJ9h9pl6SBk2T4yIqlBzlGSY/xG77OqUOmUQwssTDmkd0FcPHRIrz5JYJs6kazAFRNFGV0fPidRL1lTykgQGpvFwIg62YnR4+CcYVfI+aMr096PsP6rfCLKNuJvphyGcxnm4OYaYPBvD90fJPscUPL4kORnYo9V7sdG5TN/kvcP+IVLt2jV2AqASgrPE0Ynt9Pw1T+WfKJyvA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:27:26.4143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68609605-3e79-4f93-7764-08df1ae73691
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7842
X-Authority-Analysis: v=2.4 cv=Fv+QbGrq c=1 sm=1 tr=0 ts=6ab63e81 cx=c_pps
 a=foOfPl9YvWvIvXDtd8Rkbw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=S7ODyJLCT_IJ1eaTuwIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9FOB3Ximca07Zntk1WNH6_11aoS0R7sw
X-Proofpoint-ORIG-GUID: 9FOB3Ximca07Zntk1WNH6_11aoS0R7sw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNyBTYWx0ZWRfXx+CgxQ+j3ePw
 EO0W3QyZw7SI2hoTmyrQsYRQqJ2WAg6IQTGFnR9DRqROPMaGhpbqIlduCCXOh0KCP4b6AXRb5MM
 via1ggKJQSFXINS0fSmKusdQTiEpV9qeQfxi+7WvQhN6lSDmydsWK94wh5Svid7NggQLS7JtzI1
 kupxScgxfmYj2hmUNtFa6rTrQFDPQiWo7l5nIxgwzCtK5eCPKZbnGftAbpkH8D1aDV60qsIG0d6
 mkDY01OsB97GVzKwtuywHn+YD3dylxEYU432s0amcoc1PSBGO4u4Mkz8zamKb88ZtGhu0ZA3Wo5
 ts8vnQFUKtfvVZ5mVRhY+W5hKxKrk32nW3jTNLOuUW7CajhJk2EaK6t/7g2w6YyCQLm6UVU+KqM
 +jHgznmZFmr5uqfdDUeGidUpjeCtiZBHUvBvMzHhaeyetxp4zTcA2ZzilSVOmIPDfriwjnDzhs/
 lW6/lX1CHy542qJgAew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNyBTYWx0ZWRfXzrQIVBFoWSNK
 SbbtqFme2jG0K8tWNjoyGgIiMmRnIf6arvGnplijZcR2bZ31VXnbxnagFtltoefWi/IWYWGjaH6
 bXto37MeexN5kOcNL0vbCnSN2bw0VOE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250037


On 25/09/26 13:41, Andy Shevchenko wrote:
> On Mon, Sep 21, 2026 at 01:11:48PM +0200, Mika Westerberg wrote:
>> On Sat, Sep 19, 2026 at 02:36:07PM +0530, Aniket Limaye wrote:
>>> Every DW_IC_* register offset and CON-register bit position is currently
>>> baked in as a compile-time constant, which only works while there is a
>>> single register layout. Introduce a logical register-ID enum (enum
>>> dw_i2c_reg_idx) plus a per-variant offset table (dev->regs[]) and a
>>> per-variant CON-register bit-layout descriptor (dev->con_bits), selected
>>> at probe time via the new i2c_dw_select_variant().
>>>
>>> Replace every direct DW_IC_* offset/bit-position reference with a lookup
>>> through dev->regs[]/dev->con_bits. Also fold the read-to-clear
>>> interrupt-acknowledgment pattern into a new i2c_dw_ack_intr() helper,
>>> driven by a per-variant dev->intr_clr[] table.
>>>
>>> Only one variant exists at this point (DW_apb_i2c), so this is a
>>> mechanical, behavior-preserving change: the values in
>>> dw_i2c_reg_offsets[] and dw_i2c_con_bits match the DW_IC_* macros
>>> exactly. It lays the groundwork for adding a second register layout
>>> (DWC_i2c) without duplicating the whole driver.
> ...
>
>>> -		regmap_write(dev->map, DW_IC_TX_TL, dev->tx_fifo_depth / 2);
>>> -		regmap_write(dev->map, DW_IC_RX_TL, 0);
>>> -		regmap_write(dev->map, DW_IC_CON, dev->master_cfg);
>>> +		regmap_write(dev->map, dev->regs[DW_REG_IDX_TX_TL], dev->tx_fifo_depth / 2);
>>> +		regmap_write(dev->map, dev->regs[DW_REG_IDX_RX_TL], 0);
>>> +		regmap_write(dev->map, dev->regs[DW_REG_IDX_CON], dev->master_cfg);
>> Instead of all this. Can't you do this inside the regmap so that here and
>> elsewhere in the driver we continue to do:
>>
>> 	regmap_write(dev->map, DW_IC_RX_TL, 0);
>>
>> but internally, depending on the hardware it then maps this into the
>> corresponding register offset.
> Exactly what I was going to say when I hit "reply".
> These series is definitely NAKed (in terms of the approach taken).
>
Hello Mika, Andy,

I have posted a v3 for the series [0] with a different approach, 
preserving existing call sites.
Note that v3 version makes changes to all regmaps (native and inherited) 
to now handle enums instead of actual offsets.

[0]: 
https://lore.kernel.org/all/20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com/

Thanks for your reviews!
Aniket


