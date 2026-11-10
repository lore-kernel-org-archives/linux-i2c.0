Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343071;
	b=rXjy+VElTG+BQIbXYQiu63YOZeBaUAxrWURpPdUUqxicOIZgarsznmq2fL1kHcOi0zj1
	 xKC09LIV8HIdKNuF2AMZl+1j0EORJTXKoWltdiqZXerdMwRrivPPrf9PDieBXNIuAJmtH
	 pBLPA2KMDOi/4PyqFBrBhiatvIHzirBRLIheF3oOED4ZcewGR9Sl7P4mjTHdWroem1JHX
	 c05Eoq7V6fhxNhUcNtKS27wSq9K9DsWNXdJzGLFyzMYHfedeRmzq99jcwmhax1VhEsyCl
	 +NHse9Pvnb6A3LxKsV52y7iJF/Y0Agjj4I3p569EsdEXdodHic+pqs5RiNxXLf1ayww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343071;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:
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
	bh=m+51iQbTqdUuDs1cI8mOff0o3f/Qhq2EcIsq6ZLw2y0=;
	b=Dnel59rTPEO8vxW/8O7IWVf3D/ajX2wf/xaQn7yxTNfGNjrzAu45zp3V2T24kkoDtxeQ
	 VDD8bh2ixUmew7XZJMGnHyWEKP8lkJYm9oRYwSN+FMcvD+7bNdyDRsecMLFSOLDEu6Qri
	 KGAxFCUU/7OaackCYuwIV3NAL83l19UIsxJogQ6xl7a71Oc1qzuhpjCx9e389isq3DlvZ
	 dhpgNaHiZlCUWneJM5wo2Mzi3IKPIVBzHtHdiCXKWRZJY6lE7Pss8AyDjbnNMFBwlVBTv
	 cmD2LWw5ez2VDcx/+Bs0P3kBHmY7yGmEWrF6+oalYb/QQD9g3sjyQM0f3I5/W3NWqIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TdDY2zWT;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=JTWmgMUw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD80606A332;
	Tue, 10 Nov 2026 20:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD80606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TdDY2zWT;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=JTWmgMUw
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAIobjQ2078043;
	Tue, 10 Nov 2026 14:37:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=m+51iQbTqdUuD
	s1cI8mOff0o3f/Qhq2EcIsq6ZLw2y0=; b=TdDY2zWTwktqordZxd50vhnmGXfS0
	D6+J+uXnaj49yEnZa4CRrpf2rzDpoEPGmWU5nc/GmLMD8sCJUSv6tqhKMzVe9ZQT
	Q2i+Ow4GYz6fzSpUSquMea22veYgl1N0x4L7RxC5//KIt98XnQwSPdzgGG/a01LH
	zPG4iFnCKE9vzPjsQTMsvnSe0aZBuIQ2qgemOW17JPHGX4t9FHL4XvCLjzlXw7vE
	nmhxyFyHXnWdddh1PY524jXsrt2p1dB0p53DdnhELOg//TubNqg22zjSNxe07s4u
	N10qDnAU/ZC4G9dqY9Nczy6s3nylY1b4TeBn3uk3aWpbaeiAjTXYV8zlQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hv0ksus4g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 14:37:26 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVCEuGU1lXTMh3pd5vhb0lxCmkHsvTfvfGBMiid9HNbbaYhlu77XBt8WjstPj8yFqoRaYsuDVeTOsxoP+04qv66ZT0a+lmYdYgzFfDkPgnpPdLk9nXNp78IgvNFjV6/MOHLRxQG+/Y1lKH5hq3ML/ht2Ij5xvlJTrb6XJmtNphQgDbNFS6j4B9wFWXZfoShCtQEITgz7MW14Br2LrJaRS9N9gE2bfoLqTiPXu4QVAGZTH8d6NytTvMGrE4p4xGwBXT5c4QNljOb8MIvtgZtMe9IyYvPuybU4LRirqHdPUUyvM/q9sZgulnBGArsxdqU8nSaATk3jCIicuYY97eY5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+51iQbTqdUuDs1cI8mOff0o3f/Qhq2EcIsq6ZLw2y0=;
 b=QsRQ6Ve/o0OWEvfiLdkWh4bJVkGd75eUVcjg1YzLQVZKCygNspVEENfmbxjqCRcemLL9pOGSSEZ2Pdj/uddK2SP/2OlMbQ4C3VgQqoEgZyJoc65lVJv+7QzqpoQ2644YSeCMQEl2IjOaYXb3xlUM121yKaBHtoUxbo0ANhDrCOtWAlxs2ViXyb/0u1oGhlOwhFKy+iL0ZBCkyQtlaoN/Ir663cLg0TVqF7EM3gKDf7Oti4PgvaFIABFkOXuiKfyPpQG3mQ4Zmq49B0BE8dsn2wqtWPX6MfAo2TvhlOdvOGp6wYa3Fq/mu9OT9hLfiTvdBh/MLLOaRouBa3ZUPbn2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=debian.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+51iQbTqdUuDs1cI8mOff0o3f/Qhq2EcIsq6ZLw2y0=;
 b=JTWmgMUwpoiFWgPwGnn0cq4AjN6kiTzNvm0iq5JqGu6v+z2dpSrPmZevUisQKa0f0ulEohOAIY32ARqE6o1riKnPwD3fzA6IUp4pqYc+gnq/5t+FJJ6Cb0f5ryQNlsRdK2c/2jFBjcY7hRSg4G0QDSr6xo/JrttBw011df6ZiyY=
Received: from BY3PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:39b::10)
 by IA4PR10MB794518.namprd10.prod.outlook.com (2603:10b6:207:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:37:21 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::46) by BY3PR05CA0035.outlook.office365.com
 (2603:10b6:a03:39b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:37:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 20:37:20 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 14:36:34 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 14:36:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 14:36:34 -0600
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAKaTkl2513238;
	Tue, 10 Nov 2026 14:36:30 -0600
From: Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v5 0/2] i2c: Add Synopsys Advanced I2C (DWC_i2c) support
 for TI TDA54
Date: Wed, 11 Nov 2026 02:05:47 +0530
Message-ID: <20261111-tda54-upstream-i2c-v5-0-280a4a779b24@ti.com>
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
X-B4-Tracking: v=1; b=H4sIACOA82oC/4XNQQ7CIBCF4asY1mKYKRRw5T2MiwKDstA2UBuN6
 d1FF0YTo8t/ku/NjRXKiQpbL24s05RK6k811HLB/KE77YmnUJuhwFZYsHwMnZL8PJQxU3fkCT0
 Pwrc6Qutk9KzCIVNMl+fodlf7kMrY5+vzxwSP68+5CbjgTjgbtXYExm3GtPL9kT22JnzzqL56r
 B5b0EaRMtI2H77575vqlZRBS7IWY/zw8uVBoP7qZfXkiLpodAADLz/P8x0kpM+0cQEAAA==
X-Change-ID: 20260919-tda54-upstream-i2c-d0c67f16b4fc
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aniket Limaye <a-limaye@ti.com>,
        <lianfeng.ouyang@starfivetech.com>, <s-jain1@ti.com>,
        <broonie@debian.org>, <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794342990; l=10814;
 i=a-limaye@ti.com; s=20261015; h=from:subject:message-id;
 bh=MTgm+OYtFCDiwCL8LrI5j6JkgJQujUzdz0RdVWOooak=;
 b=RFEWeagDeQyGK2w7sy+peUDYzikEiipjK2hh1MgnmKEB18Ynls9Pu55eT7m9NCLjVwRRnlSaS
 /AdcEH79I6rCQg0CIZCiN6VJoDau/nsouLhO0xwdM1I5qpjaT0UfaGv
X-Developer-Key: i=a-limaye@ti.com; a=ed25519;
 pk=n08rZiCmdy5/1c6+3QoI+fu2cHoQt9cw7543u1YgAyw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|IA4PR10MB794518:EE_
X-MS-Office365-Filtering-Correlation-Id: 760b7940-738e-47e0-2845-08df3f6a6b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|23010399003|1800799024|56012099006|18002099003|6133799003|10067099003|261009223327099003|261009221727099003|261009223027099003|261009220027099003|261009221227099003|261026121527099003|261026140227099003|261102123227099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|261021123027099003|3023799007|261028144727099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	iZrAM0SrNuSIgtxJELXQzr2dE6Oqzl9wl+O10V5owLLYGL46tf7qTUyUWIxz76zMFQR7tmVtvO7PFrRJvrShT90bfwqHDOGplPD6Y8tqU9GVTn9BQ6ESEbiRm0NjBxQOJlAfIZ2q5cbJgCMiLRJAk/wZk2sOTxnuXiDzI3DMbcslwtvSuoU+6KKnRzvhHQs4MP0xpHA6tHdvV8CKjEFfD7JHZbHeIAlQL1c1T0Sg8lJFTAtf/7R2PUf8M/SCwM7TLxIC0a14NajdlJlE84mSlaB56ltaOvRGVEao6pWcITAfxoTpCfV2fEWNBUcxNizB1JPeUEqFg5KURf8eXjgWbSRt2HVFrCP+nkrp+xzn1pVOCUBT9CraUcly4ceyMxxZivi0KdLUcYw8+e6nM6zUgEfrAO0sen7a8P+sLLHHtD5b/pSgYhR3iyYVojiMCSN7Z+JJ/95wxrbPAxqjtjjIGwD/J39HPfL/yluOGgkHNTbH3NzEbhdJ1emkH5c5JoTyoWIpOtI7ndgfZoe5UmnTmCmXI8Y8Nx4HR6bcOFdDAjF09trxfC3xvb0AE/AxrCxvhNY4jH13jdPnLwltuTOdUj7BxbpJOBnh7p/X/UjRjJbCMXnMTnxs4MNbpsDIMyRsYV/IgOmb3CfB34VGb6iFj6gRPhdzS4g2y4aBiDbD3Wg=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(18002099003)(6133799003)(10067099003)(261009223327099003)(261009221727099003)(261009223027099003)(261009220027099003)(261009221227099003)(261026121527099003)(261026140227099003)(261102123227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021123027099003)(3023799007)(261028144727099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zFTtGKv7SgLvqGHpgLrgqDJkbM2/2+M+4DMtQ0MH20DhsRhTYSZo+tln76Q3SZxJaVa0MJ5qtqAL0HnjUP3VyVChvwD5O9jJ5+fWJLumArCrUKdhRfmNopdI10VHAYqhnhzpNkT/aW6VFWPIHfa52Dj/9ZkayCdWJ1OTF2C3Sub39rVtBqO/7gBWZd4JLuchfhvm1DiUZ7kiRoHQrwp6oYbuh2DmmBardEDc1ZOHXoKbzix+/lqPUpy8edFwPkr6i+YW0yxhP2mNf6go0WbI/YGUCYHczjIb7dQvRfVatFh3uWEy9fJO0YwBYY0TtOfOPD+RLzpIqpG2zw/F7vWimGuymXSmE+0rpgnsr+wUXTg99Ea98GD1rixb60Y6guOBjUnNxB98AlBwXumQgR7vk8xhwKGRnAUxGPe46xUqSTfRYb4mPU83AH5ePC+d/ceG
X-Exchange-RoutingPolicyChecked:
	i/0JGhfxcQYLu9f2buMIi3+I5VAP6NndQB2fkN/aLL1Wz3ykYkrmNP3RftVrONntjMa6V28f0AM6GALtJDHk44OyyGXgHpeLPncTAP3ZUu/p1Rz61QBl4mfSZusCUnsm4Umk9pgCIdSxz9SkggXidaUhhom7js27S4bqIgeN16JrBaDYxttsWmYptbFf4alRzSA4H+3IvRezSx3kddD/ITVAOsXAlGNMySKD1OE17q+iyQ9ky3W4jxoeXzS9tk9OrhppPxHwfFTnASHGIH19bcqQnQl6Rl2F8R581W3S6hhpiZI6v1amCqL58nNsWdK5tJibSqAaVxXp7NP/DzW+qg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:37:20.3261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760b7940-738e-47e0-2845-08df3f6a6b06
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB794518
X-Proofpoint-ORIG-GUID: B-9MKb4dAFxwUG6mRXa_lyFrYswlkeHb
X-Authority-Analysis: v=2.4 cv=bcH+w+PB c=1 sm=1 tr=0 ts=6af38086 cx=c_pps
 a=NlF6qXdsITzFGNsd7EO88Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=Bq6zwJu1AAAA:8
 a=sozttTNsAAAA:8 a=alYgQKMRslDQVeSeVE4A:9 a=QEXdDO2ut3YA:10
 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4MSBTYWx0ZWRfX6SgB2JB60OaY
 M2kcUC/PtlZUEMIs07ANeGZFZsw2diUdbW3uAEsmzEVPm+z9gowlMeG/+UkwD5YPjPWX9s1/vOK
 jahgYW/IfQXx4dPNUMh3Ls9g9Pms/b3kyLkkajIAj/HtEW+VpamPoThqv6IrIzcCzzC8RwnxH4N
 lSMWbLFNTlLYs0V6zuu2gpAi8CxFrzkY6dV47Y/b2y7RtkOR07pWaTt/52qKPtqRAt467ymJcve
 tYjNtNQ0vPvsXNGKwTBGzAAmNIjNPgvMqBQXLQ1k6OkIyiJTuIJINKidKMTg26zp7jDTSC9a7ZI
 vK29hDse0/OTMhCjvJMEvtAWXgt1d6Bsxr4ROv7mEFa8L8m3pnqgUG743MudFxJnvttn1EbCS7b
 spTXLjGBdWW4LOz5mCOKe/tNlgt/aO9/lBaXbsdE2YpG7N1+Fd8vRM4rCprgJnBp18T5Fc5Wo5U
 I8VPQmGhbWOSMCCuLoA==
X-Proofpoint-GUID: B-9MKb4dAFxwUG6mRXa_lyFrYswlkeHb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4MSBTYWx0ZWRfXyx05R0h4cnci
 fx7I95ca+dK3/PfMl1ZDfBLEJnASkkMKRkvniu0euaPCRxp7r6QjpA0PaWFkDhx4hvwCmvQ5q95
 iqlr0/EPury6ZWaBEQnWyAa6tTZK+Ss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100081

Add support for the Synopsys Advanced I2C (DWC_i2c [0])
controller present on the TI TDA54 SoC.

This series supports controller mode only: no target mode support. TI
TDA54's DWC_i2c instance does not implement an SMBus block, so the new
driver does not touch any SMBus registers.

* Dependencies:

- The dt-bindings patch depends on unreleased dt-schema commit
  d1fbcafd6716 ("schemas: i2c: Document i2c-sda-hold-time-ns") [0] for
  newly added "i2c-sda-hold-time-ns" property, without which
  dt_binding_check will fail for Unevaluated properties.
- [0]: https://github.com/devicetree-org/dt-schema/commit/d1fbcafd67168c1f736d81f335a05e18183148c3

* Why a separate driver:

Earlier revisions of this series extended the existing DW_apb_i2c
driver (drivers/i2c/busses/i2c-designware-*) to also handle DWC_i2c,
selecting between the two register layouts at runtime via a new
MODEL_TI_TDA54 flag.

This revision instead adds a new, separate, standalone driver
(drivers/i2c/busses/i2c-dwc-adv.c) and a new binding
(Documentation/devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml), since
DWC_i2c is not register compatible with DW_apb_i2c. Based on review
feedback from previous versions, extending the existing DW_apb_i2c is
not attempted to get away from any hacks and workarounds added there
over the years and to avoid all of the complexity of v3 resulting from
updating each regmap access.

The cost is that the message xfers, abort handling and timing formulas
follow i2c-designware-master.c closely and are duplicated, so fixes
there have to be mirrored by hand. Sharing them would need every
register access, and the interrupt acknowledgment abstracted, with some
possible special casing; same as v3.

* Delta from DW_apb_i2c:

DWC_i2c differs from DW_apb_i2c as follows:

  - Register layout (see below): DW_apb_i2c uses a flat set of fixed
    register offsets. DWC_i2c groups registers into blocks (OPERATION,
    CORE, TIMING, FIFO, INTR, DEBUG, ...) that are discovered at runtime
    by walking a chain of block headers, each encoding the length to the
    next block and an ID that the driver validates.
  - CON register bitfield (see below): DWC_i2c's CON register has no
    RESTART_EN or SLAVE_DISABLE bits; restart is implicitly always
    enabled in hardware.
  - Interrupt acknowledgment: DW_apb_i2c acknowledges interrupts by
    reading from N dedicated CLR_* registers. DWC_i2c instead writes a
    bitmask to a single CLR_INTR register.
  - Shared SS/FS Timing registers: DW_apb_i2c has separate HCNT/LCNT
    register pairs for standard and fast speed. DWC_i2c shares a single
    HCNT/LCNT pair between the two; whichever value set matches the
    configured speed is written at init time.
  - Bus capacitance for HS mode: DW_apb_i2c modelled this through DT,
    while in DWC_i2c this can be read (100/400pf) from
    IC_I2C_CAPABILITIES.IC_CAP_LOADING
  - FIFO depth / high-speed mode: DW_apb_i2c has a COMP_PARAM_1
    register that can be used to autodetect FIFO depth and high-speed
    support. DWC_i2c has no such register; FIFO depth comes from the
    compatible string's driver match data instead. High speed mode is
    always supported.

Register layout differences from i2c-designware (DW_apb_i2c):
(New driver does not make use of flat map like below, and instead only
stores offsets from respective headers)

1.  Reg offsets                         DW_apb_i2c      DWC_i2c (TDA54)

    DWC_ADV_IC_I2C_CAPABILITIES         NA              0x10
    DWC_ADV_IC_I2C_BLOCK_OFFSET         NA              0x14
    DWC_ADV_IC_I2C_CORE_HEADER          NA              0x28
    DWC_ADV_IC_TIMING_CTRL_HEADER       NA              0x44
    DWC_ADV_IC_FIFO_CTRL_HEADER         NA              0x7c
    DWC_ADV_IC_INTR_DEBUG_HEADER        NA              0xbc
    DWC_ADV_IC_HWID_HEADER              NA              0xf8
    [DW_IC_CON]                         0x00            0x2c
    [DW_IC_TAR]                         0x04            0x30
    [DW_IC_SAR]                         0x08            0x34
    [DW_IC_DATA_CMD]                    0x10            0x80
    [DW_IC_SS_SCL_HCNT]                 0x14            0x4c
    [DW_IC_SS_SCL_LCNT]                 0x18            0x50
    [DW_IC_FS_SCL_HCNT]                 0x1c            NA    /* same as SS */
    [DW_IC_FS_SCL_LCNT]                 0x20            NA    /* same as SS */
    [DW_IC_HS_SCL_HCNT]                 0x24            0x54
    [DW_IC_HS_SCL_LCNT]                 0x28            0x58
    [DW_IC_INTR_STAT]                   0x2c            0xc0
    [DW_IC_INTR_MASK]                   0x30            0xc4
    [DW_IC_RAW_INTR_STAT]               0x34            0xc8
    [DW_IC_RX_TL]                       0x38            0x84
    [DW_IC_TX_TL]                       0x3c            0x88
    [DW_IC_CLR_INTR]                    0x40            0xcc
    [DW_IC_CLR_RX_UNDER]                0x44            NA
    [DW_IC_CLR_RX_OVER]                 0x48            NA
    [DW_IC_CLR_TX_OVER]                 0x4c            NA
    [DW_IC_CLR_RD_REQ]                  0x50            NA
    [DW_IC_CLR_TX_ABRT]                 0x54            NA
    [DW_IC_CLR_RX_DONE]                 0x58            NA
    [DW_IC_CLR_ACTIVITY]                0x5c            NA
    [DW_IC_CLR_STOP_DET]                0x60            NA
    [DW_IC_CLR_START_DET]               0x64            NA
    [DW_IC_CLR_GEN_CALL]                0x68            NA
    [DW_IC_ENABLE]                      0x6c            0x04
    [DW_IC_STATUS]                      0x70            0xd8
    [DW_IC_TXFLR]                       0x74            0xdc
    [DW_IC_RXFLR]                       0x78            0xe0
    [DW_IC_SDA_HOLD]                    0x7c            0x5c
    [DW_IC_TX_ABRT_SOURCE]              0x80            0xd4
    [DW_IC_ENABLE_STATUS]               0x9c            0xd0
    [DW_IC_CLR_RESTART_DET]             0xa8            NA
    [DW_IC_SMBUS_INTR_STAT]             0xc8            NA
    [DW_IC_SMBUS_INTR_MASK]             0xcc            NA
    [DW_IC_CLR_SMBUS_INTR]              0xd4            NA
    [DW_IC_COMP_PARAM_1]                0xf4            NA
    [DW_IC_COMP_VERSION]                0xf8            0x100
    [DW_IC_COMP_TYPE]                   0xfc            0x104

2. DW_IC_CON bitfields:

    DW_IC_CON_MASTER                    BIT(0)         BIT(0)
    DW_IC_CON_SPEED_STD                 (1 << 1)       (1 << 4)
    DW_IC_CON_SPEED_FAST                (2 << 1)       (2 << 4)
    DW_IC_CON_SPEED_HIGH                (3 << 1)       (3 << 4)
    DW_IC_CON_SPEED_MASK                GENMASK(2, 1)  GENMASK(5, 4)
    DW_IC_CON_10BITADDR_SLAVE           BIT(3)         BIT(8)
    DW_IC_CON_10BITADDR_MASTER          BIT(4)         BIT(9)
    DW_IC_CON_RESTART_EN                BIT(5)         NA
    DW_IC_CON_SLAVE_DISABLE             BIT(6)         NA
    DW_IC_CON_STOP_DET_IFADDRESSED      BIT(7)         BIT(10)
    DW_IC_CON_TX_EMPTY_CTRL             BIT(8)         BIT(11)
    DW_IC_CON_RX_FIFO_FULL_HLD_CTRL     BIT(9)         BIT(12)
    DW_IC_CON_BUS_CLEAR_CTRL            BIT(11)        BIT(14)

The same IP is also used by the StarFive JHB100 SoC [1]. The block
header walk is meant to accommodate such SoC specific layouts, with
their own compatible and match data.

[0]: Synopsys Advanced I2C Controller Reference Manual (Version 2.00a-lca00)
[1]: https://lore.kernel.org/r/20260527085039.44435-1-lianfeng.ouyang@starfivetech.com
[2]: https://github.com/devicetree-org/dt-schema/commit/d1fbcafd67168c1f736d81f335a05e18183148c3

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
Changes in v5:
- Drop the local i2c-sda-hold-time-ns declaration, now provided by
  dt-schema (needs dt-schema commit d1fbcafd67). (Krzysztof Kozlowski)
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
- Link to v4: https://lore.kernel.org/r/20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com

Changes in v4:
- Drop the approach of extending the existing i2c-designware-* driver
  with a MODEL_TI_TDA54 variant. Instead, add a new standalone driver
  (i2c-dwc-adv.c) and a new binding (snps,dwc-adv-i2c.yaml), since
  DWC_i2c is not register compatible with DW_apb_i2c. (Andy Shevchenko)
- Drop the snps,tx-fifo-depth/snps,rx-fifo-depth DT properties from
  the new binding; FIFO depth is now tied to the compatible string via
  driver match data instead. (Conor Dooley)
- Link to v3: https://lore.kernel.org/r/20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com

Changes in v3:
- [PATCH 2/3] Revert to special handling for the max_register in regmap
  for MODEL_AMD_NAVI_GPU instead of unconditionally including
  AMD_UCSI_INTR_REG in the legal regmap range. (sashiko)
- Link to v2: https://lore.kernel.org/r/20260925-tda54-upstream-i2c-v2-0-261785e58493@ti.com

Changes in v2:
- Rename compatible/flag: snps,dwc-i2c -> ti,tda54-i2c,
  MODEL_DWC_I2C -> MODEL_TI_TDA54.
- Move the Reg ID -> Offset mapping inside the regmap functions such
  that existing calls to reg_read/write are unaltered. This does change
  the reg_read()/reg_write() functions to take reg IDs as input rather
  than their physical offsets, which also requires updates to the
  xe_i2c.c driver to handle the same mapping.
- Remove i2c_dwc_has_smbus(); just skip the SMBUS_INTR_MASK write under
  MODEL_TI_TDA54.
- Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com

---
Aniket Limaye (2):
      dt-bindings: i2c: Add Synopsys DWC_i2c controller
      i2c: Add Synopsys Advanced I2C (DWC_i2c) driver

 .../devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml  |   73 ++
 drivers/i2c/busses/Kconfig                         |   11 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-dwc-adv.c                   | 1355 ++++++++++++++++++++
 4 files changed, 1440 insertions(+)
---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20260919-tda54-upstream-i2c-d0c67f16b4fc

Best regards,
-- 
Aniket Limaye <a-limaye@ti.com>

