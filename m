Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28B3DB994;
	Sat, 19 Sep 2026 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808813; cv=fail; b=okipXMECQzC41UjrfyLfBcUhZPiup9qIxFCihlgdPsRBJnn6e+g0BcyvTyN+0OqRg80wRoRsdCW8Bgkk5kxXYJj6j1C9iWgT7zAjqV72Pn9oUPYm11QUC2WFKkMxoIvok/e0nQMpSocf7PkSwJU8EMm2fNavk+lZKaCU0dlVzrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808813; c=relaxed/simple;
	bh=1j4JrvSG4GCoduNXyf7xab0emmzAHIOKxUwny7aOOro=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=eHurAdtXVzPCI2MtwulCucYfu8LsH0WsgkFqXl/6YjOv+XW1jQO/7Qj5yC1NkGdK9vk5iPE/wK+NuFWkQSTw/+/8edv84eM7HNpxbrjIJlIyQvFEe2yL7bSFySwV70+jtRJuPKb3S51d+Zg3CCPSTagwmsoMD9C6Yd7a0s+Uxhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=brmI6hyz; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mfXNcAW3; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="brmI6hyz";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mfXNcAW3"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J6fHQu1920777;
	Sat, 19 Sep 2026 04:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=PyAC3cpU7uP4f
	XbsMYo8AKNa7I0VWek7iFmXisRLyb0=; b=brmI6hyzQClogwGr//QqAGACP3EO3
	/WnIo7xi924fAF7eDpLWvm3uVsHfUIY9rQ/XvWq2Rqvyejcsr/x86w/OEH+HmAXn
	0qjcpdQvXxSXduFIbsa5cKH01lICHEYa+jBQd2eU/x69XREA/FWBQ6oT/KQVde4G
	4/RbAICpIMli/vnPcdxHzNq0rtiVejplwb7lIekpLK1T5DoHe6CcOUz6nTvYwA8+
	x9fdSawnrkFiUS7zd5GasA9QfLYU8s9ffPeSs29SRv/r3P+qLwCsSs1DL+0LbCa+
	HN0Aksx0Gr4HQSnxMZMB2Ms6Ju+2SGAwZDZOSCTRd+1CmzspjH+146h6w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gs70ym5ff-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 04:06:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOzgoxDM+Z1HCdl7ivAS6OT9UnYd7wUAUAnlzTztMn0RvJlX9uh5s2kaTr2WzrJVImgJSENrDWvniNoP2kwGOTnxwfrBsvbX3wzgvgQMtTO6QyHg1JvJLXCSwAG+ksaR1B4lbEHlLtCWI+h3vyueXpPQ05f8e+8NcoBFi3JWc0bEcFTsWZc1hakbg51G012czrcFCXU3p44fY468//tnDAot2LjFnErLUJ47OdEeL/ngdcwKLFQ4kf5BRPeETZM85tJE+FE+WS/2TqvEF5e202JFxUVz2yfd2mPmoa86d8Xzj7jSkSB7NKO4DQm1NXaAnGnExHhXyBFi82ImlKRnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyAC3cpU7uP4fXbsMYo8AKNa7I0VWek7iFmXisRLyb0=;
 b=QFZeNkHO186F9ZdCApKXv0j4uTu77pzUaw3tmw2nlBc6/gxRoEcGjB9cirGlFdTUIGYgcd5YQF3d8IUfj/aVn7fCqqrGAhzEO/FWa9YZHdZN9u9Mt1DcfhBoxE56NN4V4/0lvNGhCbwdPu1Spr3KjbMk7uJi9SApeeE/GuSG/wh5jxKlQcnCXeKKVnX/yvSE0nZUJew9nHM+EZmHv0tmB5/Mh6A10mJuehAkQrNE99b8+QnkNoLlsYU/QPyIKfmM1NKUKq8emixehC3Mx2QW9cDUnMeAdgqNxEB6cw5aE98dCEy43cDnc3LggowB7SOraCtshGfBrzZkQZ2xOcTtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyAC3cpU7uP4fXbsMYo8AKNa7I0VWek7iFmXisRLyb0=;
 b=mfXNcAW3KjyaNXxkOYt/kNpm/6MMIdQ1l9Ioj37iU5kuWUUf/pxYHEgwnLiL5vHRxSEIrFTy+9ZP2uoR9aGJYISUHFkmL3UW5Ec4Z3MgtN29toRuacM45tWuqfVaAJk3ld7GFHu21sHGZ04BFAHbGAYEehwU8WlJvDZw2tLnIuA=
Received: from CH2PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:4e::21)
 by CH0PR10MB5178.namprd10.prod.outlook.com (2603:10b6:610:dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Sat, 19 Sep
 2026 09:06:25 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::8b) by CH2PR02CA0011.outlook.office365.com
 (2603:10b6:610:4e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Sat,
 19 Sep 2026 09:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 19 Sep 2026 09:06:25 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 19 Sep
 2026 04:06:25 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 19 Sep
 2026 04:06:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 19 Sep 2026 04:06:24 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68J96Jmd3292028;
	Sat, 19 Sep 2026 04:06:20 -0500
From: Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH 0/3] i2c: designware: Add DWC_i2c support
Date: Sat, 19 Sep 2026 14:36:05 +0530
Message-ID: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH1QrmoC/x3MTQqAIBBA4avIrBtQKaOuEi1Mx5pFP6hFEN09a
 fkt3nsgUWRK0IsHIl2ceN8KVCXALXabCdkXg5bayE51mL1tajyPlCPZFVk79NKZNigz1cFBCY9
 Ige9/Oozv+wHngH//ZAAAAA==
X-Change-ID: 20260919-tda54-upstream-i2c-d0c67f16b4fc
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|CH0PR10MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 523d92ca-4b6c-4a39-b7b3-08df162d4886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|7416014|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	U/Cpn1AY4oRFyxzZYeixhGQUgkz2uzNwLQATBSKXIf+nsey6F1PA0Oxt73vItJttlPTEBwsoXuCvULDD0onKsT+Rz36Gf3efLNrHloIxf8eVm3W0NCHydHtJp4264BKjwaKyZeoVgsdqwu/9c2sL+vP7AhIT0CjuTMk2ngMSoADQ52p3qdU7N/6Ox32HqgMlU2Rq/6eJ/gBgrSPsWhJ1AgXXrfyiBIE1mm0VX4Y/U5YSqmRCCzuFeeZAA/TqXKssX/hNgy2mhHM4OZ0U3s1zhHPBQksDqasw6IJkwQKRvD+zoixpXnXsCVWKFeH1OvatYvnYpNHt72Z2J9+eRS5sHVDBytSvdQkP3QYPvYiKia3Vx/NLwbrwimSIIdWeztINYuHSIWM2zzJ29oM2RcIpU41on6r0GZjR9k0jrodWVzvfZyf9QX2pFpSE2YBALQTh/fwMuBVkDfoNvmVbkr63q99uQ870giDhc6sPJxHpB5c99CfVsEixXbcP/QkcYw91U9rMu71PbIqegqw8HZNDmzrUdBV+JP++FPIxw+SPHC15ygZR2dcGniJ5O0gadUq3GF/rmPNobcr/ZQC04J/7VhbcMVgfqke3g6J8UUlrFU+sBuhhcb7TGo2rWoqV3QS9LaZ6tDVuQWJopJxEzE0c1Lp950EaejJ+qIMF5a+hJhCY0J/28n7lT8OuMQWfo+hTIjj7flrxKHVCbsH7hs/xgA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(7416014)(10067099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5r16lcbVJe8wzOG1XAKi6fGOQwugZ+XT3bByNlvWbUozZP7yP1gBCsBzxnOPflOLOz/h6hZr2HXMurju13YZZu++VFe9soZfzhM/FY5+tUh9/416qCJXnp9jLk8rvnAnElJ4jYNR3ias4gwqE3RuQh0DiqMsO6Bd9HwQnKvGN9FAgU54YuR52V5dlORBgupzMEew4hEhawkbeq840wlu4eNFoHi3VTbI5jY5FYeX7MfVfrprZ984tc94CR4vcztnpd3784dP/h2M442H7S2HLXp+xmBItOqAgg71q2wRiACBp+PO82jPPE5rMRnzcdWY1qc4rHgfz7dB4aonin7ThSIBQJF6DwlyB1xYojUlFjFM8FqqmZp7yfeK+D+UqLP896PWs7p1j6pkkNXDRiW4XEWbg89+gSD0dTd1z0n8JBXM2UkhkKnDJsy64CuW2czH
X-Exchange-RoutingPolicyChecked:
	jXppwu7Asrmk+gjiiJC8+CYIfOHAVvHNq6NEKmnxZfrSwoiUBbVmAI4XoD2HM8YzJEPoy2S+EqTxD7VWCqQVH8QUjxdN+JXss7O1rqEOZZ4Vqa0JZeY+YERFcfyEcPJz9IdOeXyj3i15pf02PbzQ/61y99VdyY2d1Pu4RwrO6lstw+/2ZWlzQoLSGwyRX8UR77TOmd4sVbSwFTz/rYGDVsJ8NfDFLFgNgkibCvj0Htx7ikME9L9XEC2hDybnQxDtL6x6wApaOqloMHrXIeRrLkZL45DIERmj9Zeb7JzS1F/qQjaNTz9btrckrSY4dviqkqWS5OWmFL2SWPLOiXSXdw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 09:06:25.5084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 523d92ca-4b6c-4a39-b7b3-08df162d4886
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5178
X-Authority-Analysis: v=2.4 cv=VKVIDNPX c=1 sm=1 tr=0 ts=6aae5096 cx=c_pps
 a=3V5Erj4uy8rJXAE3nhxHpg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=SvMZEjLkqTlyr2oEbH0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDEzMCBTYWx0ZWRfX64Ip90RJIfIu
 HLvTMUNUKajYSiGh7yGjBj3JFn16cRpgjGqM3HbkG3F5IALfLc+OQzASmfxgN0phdnVsuhgiHkb
 laLXisGu78JR6qUZFRsIR7KJHUMSEiYGUxRlH1HBAuy2qnuEcXdQ4Hg7vb9Osp73JC/+v6qMc7z
 6xmoCAaLIKlb+TUeOZLizFK8gifu8vjvpY/nFRvvJdVg/yRFEnBXPsqjgHe0R7a005a5RQTgNQa
 uGhTNpwNfgECJrFoTg860urom0flgBsBhXfXELTHk3jPHiwofDd6+TRWrOcl2R+IN9oonEIvCBq
 hUPXThkOxgVZqOvag1J4v9K0xzXBAEfTTs6EbA7swEBfUeS4PX83sDIUhwtXocxb8wpf8UinuuY
 TwDJFprWm5nd5jez13KA+idd2UwSbovA1ub+sjZP+AzvTjXCU+0JwAXiqlycUZ1OYvKd4Fe9xq9
 uHxUh5K+pZBg/dYracQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDEzMCBTYWx0ZWRfX9KlhT4v8vOM6
 EhJ5lj0KxTILUdmh1FhMVIeKKCj7k4DfgQa4x/xuLSqCmBJtsgbI7dvTRoYa3JSLdfeMCGapBrH
 XW2Ol6mOcx5yOu2VANQ179k8oOl8Imc=
X-Proofpoint-GUID: wVrnFYWOCrjhCzp22n1alDd7H7vBQs-Y
X-Proofpoint-ORIG-GUID: wVrnFYWOCrjhCzp22n1alDd7H7vBQs-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190130

Add new compatible and update driver to support Synopsys Advanced I2C
Controller (DWC_i2c [0]). This is needed since this controller differs
from the existing designware i2c (DW_apb_i2c [1]) in its register
offsets and some register definitions.

[0]: DWC_i2c_reference.pdf
[1]: DW_apb_i2c_databook.pdf

The new register offsets are handled by first refactoring the driver to
use a map of register IDs to their offsets, and then match the
compatible to the respective offset-map. Similarly, also update the
driver to use an updated CON-register definition.

The new compatible also updates driver logic due to changes in register
definitions:

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

The register offsets used for the new DWC_i2c are those present on TI
TDA54 SoC.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
Aniket Limaye (3):
      dt-bindings: i2c: dw: Add DWC_i2c compatible
      i2c: designware: Introduce per-variant register offset and bit-layout tables
      i2c: designware: Add snps,dwc-i2c support and new compatible

 .../bindings/i2c/snps,designware-i2c.yaml          |  33 +++
 drivers/i2c/busses/i2c-designware-amdisp.c         |   1 +
 drivers/i2c/busses/i2c-designware-common.c         | 281 ++++++++++++++++++---
 drivers/i2c/busses/i2c-designware-core.h           | 130 +++++++++-
 drivers/i2c/busses/i2c-designware-master.c         | 147 ++++++-----
 drivers/i2c/busses/i2c-designware-pcidrv.c         |   2 +
 drivers/i2c/busses/i2c-designware-platdrv.c        |   3 +
 drivers/i2c/busses/i2c-designware-slave.c          |  42 +--
 8 files changed, 507 insertions(+), 132 deletions(-)
---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4
change-id: 20260919-tda54-upstream-i2c-d0c67f16b4fc

Best regards,
-- 
Aniket Limaye <a-limaye@ti.com>

