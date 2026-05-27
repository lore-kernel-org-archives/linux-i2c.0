Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2113.outbound.protection.partner.outlook.cn [139.219.17.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D730C19E97B;
	Wed, 27 May 2026 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872817; cv=fail; b=Rb7vwnmCqX5+dJ8BZ7EcTemAy1kgOtITz5uc4smNeKf+Q9/FiY7ffUtxfjd/lWaHlwFCEr7J/x6BJZHUZHAgokh3uVo0qLPx4N4KMIkT5TwCtP5v1df2Np2G6wBDN1t7xKjTLVnVUWjNr3/M6DIzYb8o9qyyKxMYEAVDuhCxB7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872817; c=relaxed/simple;
	bh=68+47IYUtKW+VSkGychc2ZjLUGWhDltJ9/gJVeWN4kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHBuXFiXKAIjQyVLydIsFcD0+RNKmEogdTlMlxiDuQ1W9PUx9/gZMp8vXSI+y2f4M/CvQKvCFieJ0TzsO5wTD6az0U6fwHEnnG5uWJtUxtHrN/Gh72Af1oChaJrdIy+rrp8d6KhBJKdGu09H9gmM/z3bsbbqy03gJ8AcK93CNMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXAP7YEBrkWMF0E0rve9TXxHhv06LiSSWoFyoH1eoKoaPf+7tN3g3bvd1ZOP7MaMoMXKth+6skBDYFqYTaSVH+bWpiu1A0wTJhYg14YfdFSgruJ8Lo3hR4RQ3/2bkvzuWL+W+Bs6fO1a08WOk5SmeCf7+y4PMFKKYfnZ5u4nqwnr50KYtNP5v3ZXqlpINDYPaJqBLlP4tmHQLLJ9akNtmoWdy1NjtIuaeTOEheVSJ74/TEZ4XTq81M5CyCw8JTWSx9OzqeAR6YX4c/uzPWjn0qqKgOVPZHSnUA6TYOjvEuiKRHuPuyP6a9p9kJ9AzZPnuhnobUApAqboZc/1zvvBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlTpH9TWkc0QG8EzGucS4j3sUwmtLBtVwkzY5wIon6Q=;
 b=EA/SpaY1VR2bUZR4Fj5qofTctOf9uYRAA62vZSHV3ZiihfiuKbO8qPTIvWgeqddPn5SvCpz7ariSOCPKQFa/Ez6qC1dVOygL7RiyJ56Tn8cyvgvQb15BFsar2YL5px1YAxxsfw3odRHlCE42F56mfz8v2WkP+OlnUufYJ5Z/u8PL6LQEV88dkhUFGXdHdI9VpWWx1OtYLqNjw/UvifakCB7RoZgnHx2eFok6QdcQrfiyqeMt5He3M3b/qbiaxHfMrOlb89SC2x7XwXERXAZBhs+DYAA+bbHdpJ+1EUzybTubCzMnDrypdHJ8qJVj/ACqhQBjrHHMWBtCccmvGlJ9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1301.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 08:50:47 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:50:47 +0000
From: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
Subject: [PATCH v2 1/3] dt-bindings: i2c: Add StarFive JHB100 I2C
Date: Wed, 27 May 2026 16:50:37 +0800
Message-Id: <20260527085039.44435-2-lianfeng.ouyang@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1301:EE_
X-MS-Office365-Filtering-Correlation-Id: a8edcd34-df9f-4912-2b8d-08debbcd0bd3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Gp/7lUQHNxMevwavsYzPa0itD2HQnbrfiFmEJHpgBz50fBet+LHmae2yhBqPcR4xsDp0v0K/nJSlzCrGMrJp+gxawCui15lV6nYPBrervJrvPiXJj7pbsBRuJg1SDikbrmXepm02K0IkAaI+P0x7wAyOPRrnImYDkm1Jb8r5dYR0GU3x7EDF/9y/9fr7cGAa9ydS8iYh+iM27av13+VpP58lnyE+IAfITmfSSL5dsHaH1c64Tybgd+RvC+cBi3fPXdn5xnDi8/Z9+NPdTNKSaMVlzCQfcc3fT2egg63jdhJm3YSUW8qL8rmoN/hW8P10+wXByEvR8KLeO+2DypMUcEJJct0S7+2J3Z3wvQ7yep2Hg6x2HBBKhn+rxiCtf7mpAjSL1Gm6Q1XbUiYhqXJfsmODt6do+ihbCieTGyls8AGlnsUfdvos5s0CyiucYr6Y/6JKPptzF3gxSZE1xbDvusPjLGN4lw93M2oObQxzI3sbNEmBeMtiFJkWCTWQ4HDMJZaa5Aoq81DScZxa9GBrzd1DSha69B0Vj42mBmno7ibSC6zNrybCUrGeqd944sv+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M2pBq9jOUM3CyQQOqpyehzExk3JKw5RFaPmznRFGEQPjNN2+WoZzpJxSFbcl?=
 =?us-ascii?Q?/CjakEtJETPuz84LwK1o7elUlzbbCadBwuZ7zaGa/r6who3V3BLBaxMr6aTk?=
 =?us-ascii?Q?C3XTKk4JnAa/hmbiKODzzSjsoFsAPJh+Bu0m8gHwduYdNRVGibldZHnjj3kg?=
 =?us-ascii?Q?9o2GGVclvnlcXAwfmmgYzmFda4sAl1+r4vlddP+4z++LZs4KmS+aoT0Zdgmz?=
 =?us-ascii?Q?m0b7Jkl49gO33KTvwa244x47LN3S9RlSMikk4N3Qxy7QgQFtncWq+b8y3k/N?=
 =?us-ascii?Q?bhiYA6eSJvTuJKqXIkl/bLGjBz2UJR0ni2OeoHFHyrFHr5WQrAra/P28hyqd?=
 =?us-ascii?Q?uAen8AFfTfwkR/LmHBqzQj/j07EM/jRJjdrrNl/e4aM3H6qYEx7y1lyWGdn3?=
 =?us-ascii?Q?TPX0fP8LWDEucRinxTYCMSclIvzl9oG7xccu7tBO8Gw2fNHIyQCl/ajydE/U?=
 =?us-ascii?Q?U8NmshQQBrFijmGlt49yzWUdOKMO1C6xV5thLza1rN7L8GBat2n7yyKLD7iv?=
 =?us-ascii?Q?/ls5G6nwz+tz0oN9RhUvZ8bwi1XG762v4QdA1gvt2lGYe9NpnTkorLZw0rsm?=
 =?us-ascii?Q?rhdVFrve4xIhMVOekwJV+D2JXY6XXwv7b52PBugywteU3eNO6bFAERlu80Sc?=
 =?us-ascii?Q?ilbvDnGMlrfy3XNiBHHlVOrl9sj7ruZ7Y7n8x69a6NAOIWugHHvjGb0aPooB?=
 =?us-ascii?Q?tMEokrlHuX9W9MYWrH6y+fEYDMBxN8/ITnQa+obyp+VHLrPFTpdJUCawA9X+?=
 =?us-ascii?Q?jmSAQnpdL8LIu+QjfOjVq/hVCJc7YRMZIfORRZGQfGT5IEu20XkwyDQdBdLW?=
 =?us-ascii?Q?wfDfJ5xcPy/ygSf/PsTiaXrCW/RS+P2oNUgGM/J7woVFSl28xmGI9ewD60Ov?=
 =?us-ascii?Q?4zA9q2biiHww32CUJblv4eqHNSQpvF9vZporjHOaIc9l6+5vQEEZS3Xwowt9?=
 =?us-ascii?Q?IEt8o+bSCxJPEMeDOCCY1T7YZ6mcihtnSd2vw+5sZ4dGQraBhOIxfXXw+cve?=
 =?us-ascii?Q?nuWJDS79Uui0GLL4rrBOcUJ421UpnAwza0ZORm19QTfSOmuumGm+FtuTfV66?=
 =?us-ascii?Q?9AWUxWDHluMvagl/xNAdWH4aSShxmrA2LxuIV/NO+cWFY4n5Ia2zWbzvvoo1?=
 =?us-ascii?Q?bdrDw4G3E+W7rs8Xk1xTOctQ8GAdgHLiBqyTsJCMr1kqfj0oUgFtt5C3SMe9?=
 =?us-ascii?Q?jF7zIC12Qpx8hbs5jDw5t/YMkVyQTIlvqCJ8VJnZFfEyN71b3+iM7NI0FQRv?=
 =?us-ascii?Q?ABdn+PoCDhgMJhuCFCLO/WcBbRto5n2VISkIfDaIaEJHd9A4kpk8rpZOuu61?=
 =?us-ascii?Q?RWryuB1laE34ggzDSKYCOZuo21TdIiJWkOvKfvW+dyc2iFuDcVfQjKogyaPT?=
 =?us-ascii?Q?SFIjoqTg3/8ZamLu9b3UNSAHR9R4c6TrVt/8gGMUphqVUyouCi/Lzkznr0LJ?=
 =?us-ascii?Q?RrbXN5u+ykiKD8ns8ZNkqu/2iaTnBjiq+dP4Mm5zwwlAODg/VMYU+W2dFysy?=
 =?us-ascii?Q?UYPCz+biqxfvCOhzqe15ujtfQIQ1LNr8NvbB4s/aeg+nM3rWqr9fcJPLgrTu?=
 =?us-ascii?Q?thMP+NanhiVeIxGh/TTE4KRL5QCLmW6FeD9BlYnZNkG/IA+Y8irwX3g+J7V7?=
 =?us-ascii?Q?fxLVNiW1ceaXFPhufYvnqPtPLGwQekR4LJrmIfYo5yEz+KYWuAEGhadGKnMJ?=
 =?us-ascii?Q?iBqSUOcuRnpchhGq82O8ytLcqthkpIKuEBdMTWAAqem4ep/aohiNe9rH5vVH?=
 =?us-ascii?Q?mLzJiQI27m1IVr/NJchL8P5bqhZBIpa2Fn9MtrKHFI0qm32vKhIQ?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8edcd34-df9f-4912-2b8d-08debbcd0bd3
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:50:47.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdd5xeEosFF9GCLP4ldvTiv/S5E95GD1V6gfuOoZKSRFXsP0ZJ22yvOrHU7x7dBH/hWb3R5x8vdoXZhI1VACB1EFYEvpA2NhRyq5+5KeJbE2byDXbc9MyPnLcD/nVvt/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1301

From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>

Add device tree bindings for the Starfive I2C controller
and its implementation

The binding defines two platform-specific compatibles for the StarFive
JHB100 implementation:
- "starfive,jhb100-i2c-master"
- "starfive,jhb100-i2c-slave"

The controller supports standard I2C and SMBus protocols, programmable
FIFO depths, and optional SMBus Alert routing. The binding documents
the necessary clocks, resets, and timing properties.

Signed-off-by: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
---
 .../bindings/i2c/starfive,jhb100-i2c.yaml     | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/starfive,jhb100-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/starfive,jhb100-i2c.yaml b/Documentation/devicetree/bindings/i2c/starfive,jhb100-i2c.yaml
new file mode 100644
index 000000000000..c8631348121c
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/starfive,jhb100-i2c.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 StarFive Technology Co., Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/starfive,jhb100-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive jhb100 I2C Controller
+
+maintainers:
+  - Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    description: |
+      Must be one of:
+      - "starfive,jhb100-i2c-master" for master mode controller
+      - "starfive,jhb100-i2c-slave" for slave mode controller
+    enum:
+      - starfive,jhb100-i2c-master
+      - starfive,jhb100-i2c-slave
+
+  reg:
+    maxItems: 1
+    description: StarFive I2C controller memory mapped registers
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+    items:
+      - description: I2C controller reference clock source
+      - description: APB interface clock source
+
+  clock-names:
+    minItems: 2
+    maxItems: 2
+    items:
+      - const: ref
+      - const: pclk
+
+  resets:
+    maxItems: 1
+    description: Phandle to the reset controller for the I2C controller
+
+  clock-frequency:
+    description: Desired I2C bus clock frequency in Hz
+    enum: [100000, 400000, 1000000, 3400000]
+    default: 400000
+
+  i2c-sda-hold-time-ns:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SDA hold time in nanoseconds, used to compute the value written into
+      the DW_IC_SDA_HOLD register.
+    default: 0
+
+  i2c-scl-falling-time-ns:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SCL falling time in nanoseconds, used to compute the tLOW period.
+    default: 300
+
+  i2c-sda-falling-time-ns:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SDA falling time in nanoseconds, used to compute the tHIGH period.
+    default: 300
+
+  starfive,mctp-i2c-ms:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the master I2C node associated with this slave controller.
+      Only used in slave mode, typically for MCTP applications.
+
+  starfive,i2c-tx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      TX FIFO depth of the I2C controller.
+    default: 8
+
+  starfive,i2c-rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      RX FIFO depth of the I2C controller.
+    default: 8
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+examples:
+  - |
+    i2c@2000 {
+      compatible = "starfive,jhb100-i2c-master";
+      reg = <0x2000 0x100>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      clock-frequency = <400000>;
+      clocks = <&i2c_refclk>, <&apb_pclk>;
+      clock-names = "ref", "pclk";
+      interrupts = <0>;
+
+      eeprom@64 {
+        compatible = "atmel,24c02";
+        reg = <0x64>;
+      };
+    };
+    |
+    i2c@3000 {
+      compatible = "starfive,jhb100-i2c-slave";
+      reg = <0x3000 0x100>;
+      clocks = <&i2c_refclk>, <&apb_pclk>;
+      clock-names = "ref", "pclk";
+      interrupts = <1>;
+      starfive,mctp-i2c-ms = <&i2c_master>;
+    };
+...
-- 
2.43.0

