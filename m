Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021113.outbound.protection.outlook.com [52.101.57.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C219D07E;
	Wed,  1 Jul 2026 04:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782881363; cv=fail; b=tb3t3ZH0PqwuKk/egscclA+jR12Tq8LeeDOyOOK0v67MbFV4cVfI9D2Q+MNMqGZPEHDJDvE/HAjp6tvmtd8Ew3EnT+X4RK28IN1PVObhst7tdeOQiLONcVMW1Kj3Uj3I00MaTjIVvs6O/AIYNVr2YJP8Xx0iG9GsCD8WEdedv6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782881363; c=relaxed/simple;
	bh=TkSXC4qzID2jUyQceZnzGevfYjclKCs2KXsFLzBDCII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bl2MA5Df27G+rNSjoRpsWpKForDqYYhfHFQjZCpDl658cgbLXdzCIsXY8KYGB8e+rcmgzKGzhYVGwSr2NzRPzecwaco7G/6Pq1LXVQCjpKcXfQurJktNo52QWbmOYw0NYEB8mv8lP1NRYNaNGV5cifwXf2OHuJtbPr/8nxRxQF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=X0wCHvVe; arc=fail smtp.client-ip=52.101.57.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="X0wCHvVe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS7+KImtg2mAQKAWArZAgO4CIxRZIABbYL+hg2dYjXsFjgsJB4ozcuW41fCipg89qo0vK23pNSjymxqBW6R94KHHJiqkCAkaZnxKs1wZ7tNTutViNT72ceDjpZyPRGR5WhGeXlDsxtAccTTwaIeOVN1XOC68SnSpUGU9oOxB2iiPIVCmgcvmjOmSJgJM9aTOWH1d5ynA3JiOCk+k3PDu5WpldRm2hvuuKEUy3ngn7xWcv0EVTZVkG9vIP/8AIZCNfjeMFUPsxbBCsFDXser+rQNyvznpoZKpEIuhpaqlRE/o0H6T0sop+prp4zx6wyK5G2Am3iaDQlKCpc7UUINYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjFMzFJ6yUksF5dhFWE0k43oVd1xQxTozEctMgcE/10=;
 b=CFzc+Glg7+lvhJUTjT+lYFoLn5Nq7PpDEa1ZHR0QMNvFkReS1+4JDilv+oyoN1268rBot1ZJpDA9Kv+mlqboQOEiGWMViBohFTpRjlg0+dudzKl3WHz6FM+vuGyv0rUnQdaHIIfTsL1Oq6njkltilsWfRubns5Nft5ha1k4MIcgxC+zV9pGLlVbggq+Fy2sP/05KG6rkvJaXhPIIxoBJsaJCRaPPJmDu1oL1wfs3DC10yC2NvXryIsEbNadJhbOqQm4XsrStcwwSdjI0ByRqopJ2n8KwzqoKBxNBythbzzEmI3CgsvjY4AlUN8LpqUEg2ms2e4iYm2aBuPq4zI+3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjFMzFJ6yUksF5dhFWE0k43oVd1xQxTozEctMgcE/10=;
 b=X0wCHvVecbE6Xpik5g8P5F9tCFwmIBVH4+UwrIjeFvPhYwSbBDSsxbRK2d6T1gOBxEcdMTWjVX71Iu5wnoRm87QyKsbUPwvBYn7hebR99VFitEnL6vl62krBeUxb+xjNvi9E+Iv6hk7rh5sUpo5Lp/n45uHu1FZ6j5lMvm1bg39bvCh0M0sUj6BB0LatYaJoN3oHvgdR0V6cxJZd2B0QXawv8rmUrS4AQQtARUcZKqxAEB4RHJeRuO18tJ/o/5slFR2XQhmiAtnlr87odM3inpMw+eU9705TNfw+9MzpHTwuOk2TI2NhHmDWEW4Al0XhSDKUpVz03M3wql5tUtJ1vw==
Received: from SJ0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:33b::6)
 by SA3PR18MB5389.namprd18.prod.outlook.com (2603:10b6:806:2f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 04:49:17 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::94) by SJ0PR05CA0001.outlook.office365.com
 (2603:10b6:a03:33b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Wed, 1
 Jul 2026 04:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Wed, 1 Jul 2026 04:49:17 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id 6EC8F4186B5A;
	Tue, 30 Jun 2026 21:46:24 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Tue, 30 Jun 2026 21:48:58 -0700
Subject: [PATCH v3 1/2] dt-bindings: i2c: cadence: Add Axiado AX3000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-axiado-ax3000-cadence-i2c-support-v3-1-4e217cfe5904@axiado.com>
References: <20260630-axiado-ax3000-cadence-i2c-support-v3-0-4e217cfe5904@axiado.com>
In-Reply-To: <20260630-axiado-ax3000-cadence-i2c-support-v3-0-4e217cfe5904@axiado.com>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Swark Yang <syang@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=syang@axiado.com;
 h=from:subject:message-id; bh=TkSXC4qzID2jUyQceZnzGevfYjclKCs2KXsFLzBDCII=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhiyXOT52MZub8/U8vTcqlW5z2GlXvkJPv+Nrw+Xob85mj
 OV/RSd0lLIwiHEwyIopsnzV+ZZ/Mlf7XufelaUwc1iZQIYwcHEKwEQeFzP80yuPepYVn+ugeYT7
 h9rz00aSj6sLPGJN2aIWvaj5eGxTHCPD+sk98wP6+vp4/CTmabXnakq+XFOzQqP28f/Ig7ZpHiV
 MAA==
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|SA3PR18MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: edd81562-648f-4d80-809e-08ded72c1b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|82310400026|36860700016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	iuV+nPRJ0h4F9JTK+CMMp45KeOotsesjdyGj9Tw5CkXF5CDm9xuhTDIGYdmxJeG2LU3i6zNgoYqHjtqRDq9ftTDzaTs2zHqXnySdfoRK72PuJKjz+yFbAWRoZwNY/Xd+jSqrSZP4QxhjxzupcTZgNGGXiFhfmGumsjgrNr0y+C/JkiUSAR7S1DG+9CccU4ItSlmWzJ2sCJnhznIA13ZfFi0G9FAkrxHRIjZWjQ0Gq5CJVU1un6Kk91Z/+/kC/jqw5KaIKvmjWJRwnt9QfEgh+iMLB066XdFCj7KPYIydCPJnJ+U2SraNWka5jXc8aVRm8kbD9I2ut5/ju8yherJcgJs64xZP9Ht7Rr3BCsHnzS1taL/o4uW6s9Y/WBUmVUEIYNYOTJHDAMWPNp4IiQsjvroJ9NLqmL/+fJ9sGcRIzgNZS/3uzRa08v95+Vx56JBtDzqCTPM/O1URvD6baGIi7ij3A59YyYFLihdoslyQ6iFQOlsDUfdQxVaOjp1EO9O9a+icFuxxCtaAwwwM7ykN77Kw50M5qok073c1stkhJ1BbI/3dtTeKP51MWdte3TIuNjBSmlO/ssGBfHHoYStXq30KWjtTIMakTQSjxCFri3rM8Ju6wFhduI3A/zG093oPaKHWJ+gJ6sfEesMUr+IgEIlsN4oB/FxeirjHfLP9iprBADMuB/3nzjzJ71y7aUpW359LuicubaJMAtz9BHTdww==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4cAWxQ9fqoIpV87rf4oxSD0e6zU2MdEE163Iahjck7Whg88fvwEdLoQJm8lf7QJ3S1XQhv019/F225CuXlxo7/FmAQrDAgahMKMymUbpxXq82S2DmPcs7sxOVWILXSxvA8nTw0G2LO1DlrYti6MqW9vh26f+JFsvcY5nLaQGgzd31ufjcTAPEqKoFBGeTTXaLQCDmQSa253VLaVoTeSpfBljr3mijRVrdFIAwvon/s7coRcFcDdvFjdbzVuj+CHBNorU8qR8VbDYwEzKFiaiCsWHpRNP0jKIA0vmgT9UnurnmFeuTjN8eOvMtPq4jWag29vp2LwkmdLzTVk7lB9TonX0/VRP1w6isw9MZaFJRZQYwOMZXrMRtTwgSq18gZH9E8B0MhSnti+P5WiSyXRJrpDBv8r9+6vRvviCtF+2DOC5gr3BjDUGrd4TpgxO1j0m
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 04:49:17.2771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd81562-648f-4d80-809e-08ded72c1b88
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5389

The Axiado AX3000 SoC integrates the Cadence I2C controller.
Add a specific compatible string "axiado,ax3000-i2c" to support
its hardware features, including SMBus Quick command capability.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Swark Yang <syang@axiado.com>
---
 Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml b/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
index 9f1d35ce1fe8..de2110376a3f 100644
--- a/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
+++ b/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
@@ -14,9 +14,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - cdns,i2c-r1p10 # cadence i2c controller version 1.0
-      - cdns,i2c-r1p14 # cadence i2c controller version 1.4
+    oneOf:
+      - items:
+          - const: axiado,ax3000-i2c
+          - const: cdns,i2c-r1p14
+      - enum:
+          - cdns,i2c-r1p10 # cadence i2c controller version 1.0
+          - cdns,i2c-r1p14 # cadence i2c controller version 1.4
 
   reg:
     maxItems: 1

-- 
2.34.1

