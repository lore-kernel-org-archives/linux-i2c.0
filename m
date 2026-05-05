Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020137.outbound.protection.outlook.com [52.101.85.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A917A31E;
	Tue,  5 May 2026 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777962980; cv=fail; b=Xw9SNVMpKm68y2SJnfHFcNI5ja++HV/8KAnSzZPDET/m4Wl4XLN3oxih77vScmpJaisJnWg8U9S1wzruhFPVo/PAiIOWl4NmvQsgSYEnnaTMtys6BX0SOgCLuluIjaibI3DtJqheTIGhVhFqfOMqkmBMTIGeQHhZpPgS6/kkro4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777962980; c=relaxed/simple;
	bh=gwYab6ttU0EkSheWIhCwBRAhBw/J/KUGWK9+7yhs9EI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e49rPh/2I5Ud7FGVZ+jT+V1UgRlny0oXC7ngLuYnCdGdRThzNAzV+pp1RR7OTk8CdzzgBczvl7lvbVS9/UfP8oSzhL3+Czpxc9aRJIfIiBG/2C2K3E6HhNrkeWqAHpyf3jIsGWf+8gglffIEsKfD4+HA1t3097PluZsADH7gl3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=lELeIF9k; arc=fail smtp.client-ip=52.101.85.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="lELeIF9k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQS1iKw8P6TzGHbwwWb3s2D6uFkeVLJ3Z2iyL5JqnzW1XiT4NVE3zzrM5nL0Ix3QSMfVLLp4K0ZgINGmL4EZA2KjL/GXpDG/doavexM8lx/h4GTDzwA3YiDFyKtgmx4ZD7FwWQlf9zvD3aCyMtYaOw1UuAOJz8L2uzilto6e2L7bLRjfxyIGGe42WZ48L8q34hbjms+3mQ88eKRqy+/zEMg5DhlHcCUoaBqnmL55+mTMbkQivOSy/2mEJ0NaR/+46glg8UbY29DqmMoTBC7KG5cONX58+wv3Ab0Fgjdns/BxnCEjFTO/d2JRz6qJJVO+nG1udJMgOwj+dcxVbEV2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTVFQwgMYIiz/XpCTxRLejiMXDTEmPadaBW0re1XD5U=;
 b=B67rDwZG6eWsQuTkbPSDHoSzBTSQSRhbCixPRndhJ0e3hVU1tPZUAl9nHkwSf6M/ETTA6CaHnKKX4ByFKOKFhkptkPlXv3WejWfbjQV1MWzeXLGJ/2w1hnMCFjxG2FtKwPcG+kE7H1U0ABbqVLnjSUqH5dFRlZNKxmGVFb4xDgaPPN14KO2t8VjIJyWgq87jIbsOS8jlRAbCfBdAFeBqZt7K9kGHS+iYpX0IzxLey/GibcnuXwBiihTZFAgySsTy5udZiI8akoc0V3hyFAMcKbXAyFe1yT0cZS42BWtSO8hn0hrw66YFLXAQjpjo07ovTA1NahTA5c42dmVv7TVwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTVFQwgMYIiz/XpCTxRLejiMXDTEmPadaBW0re1XD5U=;
 b=lELeIF9kmznSumw393WmxHL/bGTqAMKBxBBrtNp+VEEAgM15bHACgC4AnFRQm/ip3jecdNF+Alftk5ptjvs2vMGXUrg9nATq7RfEMbmIQkpXcPS9oZFdUc65CRcoUrIZerrcKAF6y83m0q+SCqsjba+xjH0C+p1VxpKz6BIkwaaEYPB/ZgRrGkHxB4QY2l3jLimdJhO/KB5rUtvzouG5970vwz2UtbMRGXXUm0LlBTdqH4i/UStvzW67vAYH+1zzss1h6XLh6XTOWZ65MC9jmjubcJAU3sLf/lORNB3FrJWZ2nSQ9LmZ1Tj1J70DCOTZ+NIIQ9yXdBB8TqgpdTHYMg==
Received: from BN0PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:e8::17)
 by LV2PR18MB988368.namprd18.prod.outlook.com (2603:10b6:408:379::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 06:36:16 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::b3) by BN0PR04CA0042.outlook.office365.com
 (2603:10b6:408:e8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 06:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Tue, 5 May 2026 06:36:15 +0000
Received: from [127.0.0.1] (vm-swbuild01.axiadoRD [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id C0FBF4186B5A;
	Mon,  4 May 2026 23:34:17 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Mon, 04 May 2026 23:26:43 -0700
Subject: [PATCH 1/2] dt-bindings: i2c: cadence: Add Axiado AX3000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-axiado-ax3000-cadence-i2c-support-v1-1-97ed2fdc0b7b@axiado.com>
References: <20260504-axiado-ax3000-cadence-i2c-support-v1-0-97ed2fdc0b7b@axiado.com>
In-Reply-To: <20260504-axiado-ax3000-cadence-i2c-support-v1-0-97ed2fdc0b7b@axiado.com>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Swark Yang <syang@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=syang@axiado.com;
 h=from:subject:message-id; bh=gwYab6ttU0EkSheWIhCwBRAhBw/J/KUGWK9+7yhs9EI=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhsyf/ff8U59n2H3byi3LfTErZdbhaUftLrB0xZ3mt3N+z
 2aVKbCoo5SFQYyDQVZMkeWrzrf8k7na9zr3riyFmcPKBDKEgYtTACay+TvDf5f6BxwffNOKXkjz
 Gau8qPDoXCRu+4jr0b6IHSKy5nd0pjEy7LaNNWI6z3/6mFrQnjeyD/9pacXldoof4qnqNt2s/NO
 bFQA=
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|LV2PR18MB988368:EE_
X-MS-Office365-Filtering-Correlation-Id: 577e2c4f-213d-4798-b4e4-08deaa709bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|34020700016|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	eJ0c29u188e9uV6PuXerXucTqNWjIHruLbOOutrDD/yF899CArXAwAGJC+vmUT8Mn0PVvDzMqgkEpB0VaZp+hhPLczRK9at+47b+JLnhT3kuHmjsXpnuYfUx8Md5zX+OCHyqG2P0PSaIsKZlwRPjzbaKl2qoxNzfX8qYrH2CJsXfrf8js7kIeiKaxIQuy0p7W6nOuKOkPTMqBjZ9aemSvawbd9W2hgM663a4bq8POV1qYP8fdt+JNlQZdZcvD7EYEixJlihFxe+6wz+7C/EALbrRMigjl7WGcjYRzSdo6LJ015zRdB/jlWtKLornVr4YrGLK8/21cwyae4BrG8Mq4HmG/yp8dGbGH0hjT4urKmUwFN4SkO2+267pw3bfCF4FVl7uYaFeLFGe+qOYV8VxzXUhhEmKu37vghRRfzYml68Mwv2QNa/NVXp4AgaIUc9N+HgSEplz1Zyfm0bwnjL0UxkswUcrlxJ6Mpwr3OlhbNZH/7/MkRyMIZWX7JkTTQMSdNSVSsHP059stzxDXiSlmJamDwlLdqpjZCFk0Wna1XGwjadw6f4d0NcU7MHfAGQMIhDkydkpaC6rvEWs9bmFbvn8w4S/0Pmbg3xcbYEpMYgrl6vZjn6mLKrPAsKASGlkzAgkGYlhHAILlvf3Fyj5F9mYq3Uw6wCAalhNkt/hfpStMpkCB3EB7cOCnDYidb6kGAv2XDlU1/w4ga2fYXvMh8MXPLTL/ojQop83/Cyw6dM=
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(34020700016)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rXnZc1FU9HZfXO/F6QtqmgPgHBYx0tB0S10feBIsHNuzELpcVIQYnLhXA6qdiQuJHeY2gI6/Qpqygdm/v4h1aBQV8j49Fa8ya3e3JPDrpWzp/ba2DnPE/hY9C/Vmr8SY4we0vCRL0n1yMWIHN60HuZ1q/McmjDVZ6qSIKcf/qQZxAobA2dSWe7BuIyc4YY763WwubntZD66yKINeaLzRa4XH/EAic6UU0zuWQFtYiNryRvGTaLwnfQxAQmVGehYyTr7jVj2WPTYYqbPA+V29ErGLBGaNg29U2HBKfqC8E3gOB652V05+6motVXJevOrbMxYQd2JbImbKBHJMiasen7MirYhNDJ1YH+kJa5USgBEmuyYTHSfmRcmWP33hM/h7NFm9AiY31/vywSbNjZxTschMvIJnBNPPZ7tZTQdHnLXMdsxMOOYZXYT8FqONmw9H
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 06:36:15.6192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577e2c4f-213d-4798-b4e4-08deaa709bb4
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR18MB988368

The Axiado AX3000 SoC integrates the Cadence I2C controller.
Add a specific compatible string "axiado,ax3000-i2c" to support
its hardware features, including SMBus Quick command capability.

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

