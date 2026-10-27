Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793100779;
	b=QHoTciTmfbnEUSvvbUFRuANKsIuKQ+krSTE+cSZqBt4E+gpT1it4SC6HXGuXgxxnB9sU
	 BBXlubzJ7tHFn44YryoPm9YJ+fSJ2PiQxMwgQAatb7BKO5Q7cW6tn376JzN/az9KCMesv
	 MSCxqdov6z+0NlejmFhWlcq4n5Iy0qwiy4E7x2MpaqweaSHSulGRFNUzPtT7Vm2esTPgb
	 72Uxi6P82u25ocg2qNEYVJ6R0jpMPhHZH4nf8dyriFl9ADq8NwQ5d1MqI/24y/0p8TEsX
	 a8KPvhBciwk9mUwPI9l3gJTjnTa3MS8d95n8j7u1j6ujyTzMb6V9W1HA1YVVSFW2z+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100779;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-EOPAttributedMessage:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=edrBBTpgeD3pBoqTJMhrAgBh+KHkcqQKsWH8mfjNP8U=;
	b=Vpo+rQPNniaTv8MfmkzlMxB9dbgav8pGE/vQoC7woCcFw1FGTYHO7hDxA4oL+iHwlmgr
	 fXsl2n7G6kIxMTmwP07lGLUwK8R/FV/sVwcxK0sHfCwlAtYJPuKEO3BhwXSZnTQWLQ5vG
	 X6WjY5CpsEtxtg+OINBrA3fdRwdL4UOEu4a21y0DIDuh2n1KLcpLIyOljz514sT+Uh9GZ
	 SvfPBrAjKFTeuIkI1J/40/WH3kS4trLu6RvB0+rVE8e2FgLHBFYggQ2Bcf+OvMcL/qmeL
	 Tom+nQzGqptQhkg95f/OXwUWmha0dKk4HFxtpVSMatqKqzEIULSQYyygYPPu5SlHn/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=c95Cx36v;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=OJpEYMYK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10AB60A380F;
	Tue, 27 Oct 2026 11:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E10AB60A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=c95Cx36v;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=OJpEYMYK
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69R9RDU7748475;
	Tue, 27 Oct 2026 06:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=edrBBTpgeD3pB
	oqTJMhrAgBh+KHkcqQKsWH8mfjNP8U=; b=c95Cx36vhqvOdhO2q4ZUIqanLBDzy
	Reg3MS9OoZrGBgefH95997TbTjYv/SrGoK4fXadMXq9688p5goqYcvEljvvGh+t0
	Ln0nKS9BHYN/+ZO8koYWkpa6e2RPa4B3AOMyeLNjGb0M+rCrSfl/8HlmfyrTm36c
	mo7++UorY/d1LBWXKd+7D/LXNFkE8OlG6jrEKh7sJSyYXlN1xK65n66TD1cXqAvE
	N9ooM1Z31Cws/6X5Wcz2rJ7a+ybLnMyjH6M6BZUvbx85Pj7+QbARf/vrmW2pksee
	Ii9KTqnKxbpoa1q7nxs6c9pH9o/shmaRMgm8tU8MMETxmJ6HLg1wchK9g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hjsbb8mf5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 06:32:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKNmZOSOHwRpdfHK3sobn9W6W5hriblCULCzEv8lrfJTypFBmGErMD+SUi3xRDXwoB1Za/brHVNSIYPXYz0d1o+y5KCbF1jsEPT/8Or+E0ZiCtMvfn9S6R60mwbXtFC/vKWCbod3R0KV7yGKD53qochRfUA3ztTIEIMnfH0cZLrfLqG4FBJKAyETRxXVCSfOy5CAbLyIrHEkrdNCnBjV1cDfqPS11xq5Vbkpk+T/Dm9zv3XHNKrs+9cpqrGkZAQZk4LGzM8gPoryvRslkaiaZY31UzxBux9vNvN82KOVXmQTAAnapRkAd/3k99IX3iWBFbOVGjOYTIWU05m+0Tt9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edrBBTpgeD3pBoqTJMhrAgBh+KHkcqQKsWH8mfjNP8U=;
 b=QtC80/k/IAN8hpk/WWfio1i+75l0tn0/TurIZ1sM78L/AcAy4HiJGa35snVMrTnPc13R5vlZ4m5aPDanVKC2+AG6kgqthNlH7/gmn9HqmKfxG+PB1RwWaDVbihaMi87Ih+83dX95n0BkUOwD226i9Pcx5w1RvvQoUUtEIXJapPc6G2RhtWsevGMeVERhk0P4lE6AX2jFztggGCUwtwuMzsLQd5835G7fBAsFgI9qRtTch6iZF3LrEG2eCtYML1kLiaQ5u8Z/NjyArdnDIyr9xmqfwrHB53Acl0mI9/d28R76TbFhep0wQ+V1iEe2oRFaTt2FanXzytzUNF+H4HwzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edrBBTpgeD3pBoqTJMhrAgBh+KHkcqQKsWH8mfjNP8U=;
 b=OJpEYMYK0dsrbU9Zt+g3jAGPsEZb5Y1JzhWmMAqfvb2EVl7KsSLqLPrTPfk0pvIdsultAO5NRCJ8qVkJGpmkIRqqNQDfVlsCzFdbCcs+vHCnFLN8dxpWrqswrjQPHiR2qoVzIxEceRCrqY5g9SW67UPgrWh/tTsp80w+aJb/zaE=
Received: from BN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:ee::7)
 by PH3PPF079E800A3.namprd10.prod.outlook.com (2603:10b6:518:1::786) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:31:44 +0000
Received: from LV8PEPF0000006B.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::64) by BN0PR04CA0002.outlook.office365.com
 (2603:10b6:408:ee::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 11:31:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 LV8PEPF0000006B.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 11:31:44 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 06:31:14 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 06:31:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 06:31:13 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69RBVAHR1817461;
	Tue, 27 Oct 2026 06:31:11 -0500
From: Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v4 0/2] i2c: Add Synopsys Advanced I2C (DWC_i2c) support
 for TI TDA54
Date: Tue, 27 Oct 2026 17:00:34 +0530
Message-ID: <20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com>
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
X-B4-Tracking: v=1; b=H4sIAFuL4GoC/4XNQQ7CIBCF4as0rMUAhVJceQ/josBgWdQ2gETT9
 O7SLowmRpf/JN+bGUUIHiI6VDMKkH3047UE31XI9N31Atjb0ogR1hBFFU62ExzfppgCdAP2zGB
 LTCMdbTR3BhU4BXD+vo2ezqV7H9MYHtuPTNfrz7lMMcGaaOWk1EBbfUx+b8YBrVuZvXkmvnpWP
 GuobAWIlqv6w9f/fV284NxKDkox515+WZYnUESC6jEBAAA=
X-Change-ID: 20260919-tda54-upstream-i2c-d0c67f16b4fc
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006B:EE_|PH3PPF079E800A3:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d28b847-9ff1-4264-9855-08df341de140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|261026140227099003|56012099006|261022113327099003|261021123027099003|261009220027099003|261009223327099003|261022105027099003|261009223027099003|261009221727099003|261022075727099003|261009221227099003|261021121427099003|10067099003|18002099003|261026121527099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	zEkz1XX7yycl8JHMeiFJ0GbdpGoXbRICFN/gcbPUJsGTtVqNnoKNo4ugGO3jtDqYpPIyU6vbm+eluxHeKf/COCALeZ7xOYyNtZrz32FmmRAlWK5oMECkmpitOhCUhSU4Lf/bsc2XIDrvBjiX7dX9tC0zjvB4kjbkatTj8+zQKfXUAoOpyn0ijdM0Ohf5Sgz2zEPXVW9V9fPIL5BhGImc7K1gAw9SBeYpmcYbrODfxQ13u5r+HmX14XwFXHPvyURjqsIOqy8+gV3oAMwaJoeZ4aq+EIRm7vy9oliVLIy7u4p/H1VJBKjwCjlY7BkouOvE7dYp7gdsBS8P0P+lnSio21tW0cU+M8GqM7gON3YpknggsNGHG0itLpjAAE7eMO9gTpnm7l14kL+fdM0wwRqVfbfP3G1QjUTny77QZYyqpYJ129HmOUXyaham1u/8e35qwGQF7dYcCirbVlzlYOMzdhxh8GLZgCjd1KlkufZBesURDSvt6x+1Qbo+VfuJ7TnM1CXBOVpRnqfOUHnOfiSh/ZDH49n4pnmbZunSJHGVgv7tKfzYRDA+B5wMqb2TI9NOL4oYZ+t3sRre6lNxsVkyRzwx3hYVhpKs6I1bZAH7RpX7KNq2WVOyCIVRlZegAD2YWiLUFx7eqXVWoeOJRD5+7RYrM7z8wouHvUPwOmgoEK4=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(261026140227099003)(56012099006)(261022113327099003)(261021123027099003)(261009220027099003)(261009223327099003)(261022105027099003)(261009223027099003)(261009221727099003)(261022075727099003)(261009221227099003)(261021121427099003)(10067099003)(18002099003)(261026121527099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2b9YTqkPiOuV/eIvitPmRjruxsREa2HmRMX6JoGzgNSO7ZwKF43tb1SOJgyZeHj4NOis1g9vuorS8JXihjxCI0dV09nJu0Fn9cP8mDBYlRmaaT1K2vhDpQFv8bHT66cqa4m7l5tgDdHMSsupobHMoy7H7/RHVcSkcNmvc3gsqV9ZiZQXWyw7VOZMUGW4gBWeAfKqVdDU4rZElcyeRMLNHGsi4p24wDOxbaCZeX9hMok4rvdxln8dp0y5QgdtYI75PzIMToUuj+FvrYOuLClIvGV+MNQBneJj65LKj9BAqea1KKulfcaEKzJAMh5cdqWC3BSjahXcK0cyrEdXqg/j/vFFxd+4cbD8xKBD2iw/t/Nk8mox57FMbwacyzRMpfZEvxB+/n5sZeZ4SvfhlIi8sZLXlp27UCokeJZjWK8uWAWk/6XO8Z8qsY9mPm4ceICf
X-Exchange-RoutingPolicyChecked:
	HgLFFoGZVmHsSQxXvXXIuCOUIHhr1hFbYoicOVkruiZwbDxfbmaLOgCqY744k4oKRgMKeF6/Znp7oI0zAIMYF9pvPCbhki4tZcI+GWyuhObu6L62akIZx1z+sAdnRJymkbehjq6iu3oPnIUy5X7Qsdk2wVfCwRnXzCNFDA7WelJIFp4wX58xq6w99c1X6Z/PTzcqt6IMVf+ULmlardC4H6QjQL1XRL/63p2Ka1OcLuHhxQR4Un78Hk17cS7Yq+CrmYvjc9ulzFi49ZMuZXyOfNcg+Y0nSNhVJCj1khIFdBGyfKSkGhA9GU9DtYA03/t1fXrP0lZaaSSGKnm224aUaA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:31:44.6548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d28b847-9ff1-4264-9855-08df341de140
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF079E800A3
X-Proofpoint-ORIG-GUID: hYi8utULhAFkJJQH1QSdmYujzyKXpdWl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfXzXrTYOifbtki
 MPmTtDcZ6g+B0bEz5StvNNAmYPv7+KfpUh/zlNluNVUNyS1/AB/uB4URy3513iL8l0x8YkmUTRE
 xfStAsmhvaMYnVqEd1IIpen587Wu3UemFezetTy7R7Y1tFnesZk5TGTuVswn4RJRYpi9cWUzDmN
 G76eGIRGLmf0Cr1YpKzwvQJrAyukrDuCG1xlfEqaStR31YG0Xv0FrDYvdEpTt+Op0PQy/PbdhA5
 /hnLq2xGAqRCx+QHqfxFIfoMatN7sMRlmDHhHC+AXAJz0pvEF560Q92ZE+O9SjKMnxKhmfU3jFy
 D1ikUGY43jjYRsQfWykUAZJEUrCl3qgpmdUvxoFElnJFavpIznWXx8Mh4610pXWKXHw+C3YlqNF
 9ZjRhugH/ffJqKKis/ppp226K1RtR5pA1AGg/esqoJTv7drgWIA6/hR52QlV1jfbbZLkA/B7d4J
 JJBNuP7ai//hzUg1B6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX0y/JUiBmAIA8
 jrDGklOUgWIy4AoGDfW3vd06RQkE2ro1iK5Anp+AjN8pnorcfHyHVZ3hMMq1SBN7/I5Oes7/Hap
 nwitgmfpv2xec4GE4ogjvTAzmfX2WTw=
X-Proofpoint-GUID: hYi8utULhAFkJJQH1QSdmYujzyKXpdWl
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6ae08be0 cx=c_pps
 a=9AcDkMntNQwiSFi2uhiI7g==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=Bq6zwJu1AAAA:8 a=sozttTNsAAAA:8 a=Lf1tmZEFbzhW_XPW6wsA:9 a=QEXdDO2ut3YA:10
 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270045

Add support for the Synopsys Advanced I2C (DWC_i2c [0])
controller present on the TI TDA54 SoC.

This series supports controller mode only: no target mode support. TI
TDA54's DWC_i2c instance does not implement an SMBus block, so the new
driver does not touch any SMBus registers.

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

 .../devicetree/bindings/i2c/snps,dwc-adv-i2c.yaml  |   75 ++
 drivers/i2c/busses/Kconfig                         |   11 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-dwc-adv.c                   | 1333 ++++++++++++++++++++
 4 files changed, 1420 insertions(+)
---
base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
change-id: 20260919-tda54-upstream-i2c-d0c67f16b4fc

Best regards,
-- 
Aniket Limaye <a-limaye@ti.com>

