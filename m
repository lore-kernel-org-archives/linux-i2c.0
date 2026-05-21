Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2128.outbound.protection.partner.outlook.cn [139.219.17.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA732B115;
	Thu, 21 May 2026 03:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335981; cv=fail; b=mulrgm2QdvOIGOmwaYbdjMa03k3mBUZcnfAJUW/i2HR0YBsFrrm+4iQPHFae7rih/QLz23ZmBazMzGPI3Z6SzJtphEOBVo8kpu3/kFok5NlOFEc7dXxrETqOlSUTPot+hYHaq2ZBnjlpLc7GTpZjpetSWe6inwduxOUCvODRibE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335981; c=relaxed/simple;
	bh=d3fLM8WesRqb6mHhnu3lXFocusW2u1iExxED7b/j6Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NxztgRZZBG28b8nJx0yaWtOub5C0FwjjLxytbfsYxYIahPhEmWJY4onw82z3AYOvj2nypmJQcO15r+GI4R1gOPXA2uQDpyuKpnW0c8wW3RfK3Sg8+a29sN6uqq/vPIvdlwxe2lYWxY0v8ABV1NjJISkN/WlTwlb/GjtUJohlUHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmA2ArsiMovjvCz1Yyw9aSdr+Tu4oD6BNZIH2LaesCt09fCCCZ0bL2g7KWShtuC6iDHhmqrIbvTzn2LJ5gEiA9KkkJcycT2+z+lehLOYutXtn31czzANYbP97ocHgea5XZLmpCq9m7vqxUldQXQdXeRjXrna1rVnBpXXjWGwVr7YAvoTle5KuuP35q+IQKccAbnOy4r2tHOOzTxh+x/zRdQ0Bgc4d5F+ae2l2gO27ktYPb/qdzptHzSa0e4bEoB9qVHcK7SnOaFoQ8PERmKD3ybceRzoB2o1OwXtTi6g6P/KU36Jqf6RofnKtewsKzxxSD0wJjzGG44ooKOphHXlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtn0HAw0y7yUTZkb75DRK9RFYgrClQV2ckLQ5IS7Nn0=;
 b=Ner/z2yHEIKO3yFOo8YdkoBGBn4fAUQqm6AlJ3BXpffofQ3yvR7wz5pDXFg5SNeRrmMzuz8knbTgs5KJ3tH92Sx+eauVQJMYrz7HS5rjgXiFX4/x165RRxWJ87CIaM3mgzaMwhmlipCq6UB2oP/9re4mEizLM0kLXCqw405Aa3Ec0gP+bhGWn53iFvw81M2lBR+ZRwWdB7RRKL8VZ4T9LF9JgxqHLD+NmHy1RGpHOWG5Kp45dQ2N4DKJ6oc4FpkCartSAaLZpR6DasDXu368SNBbV0uyVPWLbHl0uu08N6IfGyodc0URm/Fj/kSxFbY4ydGqXicSaXIbEdGpgHEqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 03:43:48 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 03:43:48 +0000
From: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
Subject: [PATCH v1 1/3] dt-bindings: i2c: snps,dwc-i2c: Add StarFive JHB100 bindings
Date: Thu, 21 May 2026 11:43:38 +0800
Message-Id: <20260521034340.27837-2-lianfeng.ouyang@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521034340.27837-1-lianfeng.ouyang@starfivetech.com>
References: <20260521034340.27837-1-lianfeng.ouyang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1302:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec3ff07-8d3d-4a07-d9b8-08deb6eb2a97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|3023799007|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	qQ0ShVvRBeZiw3+it/rE4CYOW0hXHqntOrysX1zBn9UVKkvxfQpMXt9TnOvaulWQg6bokUHzMNlOEcNuzaRcI2vRxj6bC7Kb0F9eqScTcfYR9RWp0cxS46ztj0mANoM9I8pdlCNIfthrYh7RkNzm70ZC5ke9JHwM77nL8vhNHbtU8Ht1d8HZNOIBIiTjRkFniwPk/+eH+ojNF3nYXbTHf7iKJ2YhlMFQjOvrQp0gADM/hb8SZ5O7ry9kyZLvy3cP0ck5SlqYMgpcbLIoSXXYBea9FaScECm1c1VE3eQgHQvXmlZtLKvFPx1m4raU6gV3xFxGNnKvwrFBDrS+5hbm963hMlwU1HY+eoljLqbltmPzOuzaNjIxJrRxc3Z5yB3dLY01W9vfmjiRxIpEMCozCl0RkOoABSnwHw6ZyOOrHc6sdeN+IXX4rZgjDdhk5iqoiAMYd34Eyhj/4sv0D6tlMCjLvOva+dZptMnYyoEkBUMcSRYrrPiui7Pqxrl/bFOR+CIOWE00KBA83IbGVpQIZsR8w954O85/ecOWIEDEQnbB6lgvNRHGPd+X+ixCp2xV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(3023799007)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wlTZ2KGF68+oHRPaeVOLESEqd1USY4A8DYxjaXHjDzE7MDK6WII0bRRWQSpS?=
 =?us-ascii?Q?XB91Wsy9oe1kytG7BM7XBAgReQe2SEK6L4hHz+w7xfYijBwuDFGHLV7QZDEK?=
 =?us-ascii?Q?KEt/iq17QO+XEf+s3/A0gEurmD7b/bQiPbWL5FGUdoGIsMT2GJ4l3U4Pq0yO?=
 =?us-ascii?Q?ETzEMEXponEWFT+20e2b6xponzjqTslfikbDiHaGz7491L+xDVxijMq8pevF?=
 =?us-ascii?Q?+Pyqv42bUTaEP4mB1QDRxF3TXRVGdG18iRCP9+gZXZ0vYgd+B9K5Bocyfo6Y?=
 =?us-ascii?Q?QCS7ALp2nKlT9KakMiJXCO0uvb6mgXawx4OxKrbzDHtxEskJpPd86rwC6at3?=
 =?us-ascii?Q?eW81JM+UN15WglBZbpL6YFlLZHZTgvPAmtfh/vPpFV5jvjqzNctGzhPD52Se?=
 =?us-ascii?Q?0EolUH+zfvWYOn57nQ4Cyd0cudDb4xjsxbxUtsNEcDowmzejIKeAytfUYy+o?=
 =?us-ascii?Q?WLlNhjvviMbQNMwaSs465XWpIU5iocwM5PjxZepZiYFGtuze3bBn9syn96Jp?=
 =?us-ascii?Q?pDaMaBDe64q3yKNw6DDHPna+J2QDqUngYpG4vTwIMHVkeiqlNWUYgf/nAVYh?=
 =?us-ascii?Q?TMmRmLUGiRW+kF6LWXHAb6oGoMLSttU977zxICaqLnkVe7aPxCfCoG4Zdq8z?=
 =?us-ascii?Q?v13R0ShxToTU1POcFg58+Ts+yFDWVH2+Ir3i6qpTwliRQn13yQ9VbY817Cgr?=
 =?us-ascii?Q?w3IrrIj/C4bNtOlTlfooOMAD2gwuXYqnCYi3UtbAuNIaI/K+W9VaHifcBUe0?=
 =?us-ascii?Q?cG9F7O8n/1nRGA0SXujrlz26T5MgmDOUGkWVq9tpjazk+2J50GA/EEYs8/rM?=
 =?us-ascii?Q?1V2FVDjv+7XjF92y0qaW6V/d6k27Mq65pXLfAkpx97PqE6MGFakcgK7JfcSQ?=
 =?us-ascii?Q?qgFbAz+LhQ91JA7ZwQvfB0/UPiomVirf5JU03TWl19rP9sEaXLw843yZ/zG3?=
 =?us-ascii?Q?vzXDLnSGVD/sKhstw5HFKJdKw76Utmt6pGcg6enCYu2ee2CMVIBYZygZpZ5c?=
 =?us-ascii?Q?cf9fr1jfueZmgUmysu/BOR91vYFLoh/984CACm5UwSwZzGtZ2lg/PfkNcNvf?=
 =?us-ascii?Q?CscvuA2sdbTqwHv00wW6dw1zrWJTUJsZTTZ9yTF2oY884xL2ZsDb2veuVLm9?=
 =?us-ascii?Q?f/Uaciq6aKCBuftcVFbyTxDHvrmS5FzQD0YN1VXLxgojGs+pAcrCJtR2X8Fm?=
 =?us-ascii?Q?DW0GVMt9dQ3L+uCpPEPr+7G0IDjKCXOBzx6FMcOhzZFOiY/LrO+cjpUwFne2?=
 =?us-ascii?Q?q5/bRkWjRqYPnwaOnTM+ccRyIlmNGL3TsjKqUXa6bgmmOkKXt4yBGEUxLndg?=
 =?us-ascii?Q?0Y6QKtQ4KdPRpghzPcWu4CingubZ3n8KO2PWzK+wmnPYbtNGWdl9OMn0zd4J?=
 =?us-ascii?Q?wTKtG/eQHa2yyMMEi1HplMfgqNlBT8aqPGXuTwAKwrrr7hxqlCVChgq1Ft9z?=
 =?us-ascii?Q?B5kGSe/XttdD1Ay5AXlI0FRyJFhHPU3AGnjBm0QFuVSV+3dQ8F5qFsjN3BeJ?=
 =?us-ascii?Q?6ZJUMAFRsfDUqi4xWzMJ6c1t9z6wcvuF+3fRD2Ng7iqNokwi9bCDRtYX+dcE?=
 =?us-ascii?Q?o2EsYqP6QSfkdn0bPFlVWd4cwWfNkjaecL/KDzAjyp5W+o/Ouz9evcjKoKQS?=
 =?us-ascii?Q?wZe3J7kS/6zmX5qc5l8zNAEp1thn6P+GmidXQmxS19YuuEPySU8V71+9IkPP?=
 =?us-ascii?Q?a1gLqoVYpPh7cz3fbynakfPpMRovRoATDoAPFBttooh2hVoeGjSxARizJfN5?=
 =?us-ascii?Q?S61sKl8YqB1ZuKhQiLL9c+mUF3u9PZbIIjUApthFvTRjAW43SObz?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec3ff07-8d3d-4a07-d9b8-08deb6eb2a97
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:43:48.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEauTZ66TljJ5adcgKr6kYD4O3+Uy4jjCJ5N6z3t2oTV4ypCgV5bJhnRR9pPQtzAxX/9kOW9Dgf/c1GPR0F/6arje2bXbGkapDHLq9W6rYk1rHvkmXyjewCp3j7z70GZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1302

From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>

Add device tree bindings for the Synopsys DesignWare Core (DWC) I2C
controller and its StarFive JHB100 implementation

The binding introduces a new compatible string: "snps,dwc-i2c", intended
for the generic IP. It also defines two platform-specific compatibles
for the StarFive JHB100 implementation:
- "starfive,jhb100-dwc-i2c-master"
- "starfive,jhb100-dwc-i2c-slave"

The controller supports standard I2C and SMBus protocols, programmable
FIFO depths, and optional SMBus Alert routing. The binding documents
the necessary clocks, resets, and timing properties.

Signed-off-by: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
---
 .../devicetree/bindings/i2c/snps,dwc-i2c.yaml | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml
new file mode 100644
index 000000000000..7227f24f7cbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 StarFive Technology Co., Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/snps,dwc-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DWC I2C Controller
+
+maintainers:
+  - Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - description: Generic Synopsys DWC I2C controller
+        const: snps,dwc-i2c
+      - description: StarFive JHB100 I2C master controller
+        items:
+          - const: starfive,jhb100-dwc-i2c-master
+          - const: snps,dwc-i2c
+      - description: StarFive JHB100 I2C slave controller
+        items:
+          - const: starfive,jhb100-dwc-i2c-slave
+          - const: snps,dwc-i2c
+
+  reg:
+    description: DWC I2C controller memory mapped registers
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: I2C controller reference clock source
+      - description: APB interface clock source
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: ref
+      - const: pclk
+
+  resets:
+    maxItems: 1
+
+  clock-frequency:
+    description: Desired I2C bus clock frequency in Hz
+    enum: [100000, 400000, 1000000, 3400000]
+    default: 400000
+
+  i2c-sda-hold-time-ns:
+    description: |
+      The property should contain the SDA hold time in nanoseconds.
+      This value is used to compute value written into DW_IC_SDA_HOLD register.
+
+  i2c-scl-falling-time-ns:
+    description: |
+      The property should contain the SCL falling time in nanoseconds.
+      This value is used to compute the tLOW period.
+    default: 300
+
+  i2c-sda-falling-time-ns:
+    description: |
+      The property should contain the SDA falling time in nanoseconds.
+      This value is used to compute the tHIGH period.
+    default: 300
+
+  starfive,mctp-i2c-ms:
+    description: |
+      The property should contain reference to the master node associated with the slave.
+      This value is only used in slave mode, especially for MCTP application.
+
+  dwc-i2c-tx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The property describes the tx fifo depth.
+    default: 8
+
+  dwc-i2c-rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The property describes the rx fifo depth.
+    default: 8
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    i2c@f0000 {
+      compatible = "snps,dwc-i2c";
+      reg = <0xf0000 0x1000>;
+      interrupts = <11>;
+      clock-frequency = <400000>;
+    };
+  - |
+    i2c@2000 {
+      compatible = "snps,dwc-i2c";
+      reg = <0x2000 0x100>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      clock-frequency = <400000>;
+      clocks = <&i2cclk>;
+      interrupts = <0>;
+
+      eeprom@64 {
+        compatible = "atmel,24c02";
+        reg = <0x64>;
+      };
+    };
+...
-- 
2.43.0

