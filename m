Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61A4BF957;
	Mon, 12 Oct 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826604; cv=fail; b=n4P6KcuXdSz/pIN6/iO6PpYATGhO1CudhYAqTtsugIO7jqCh/ch9VmaoBtLQJLxox4Wbn0BqSyWkuo7JU7CrzBnJn0ffxzTeZ/2eLqrAkFcug1NXuH3bv/oS1BC2OCB6j3qOlYaAbiZJzcy4/pWqXKvwiAPE/y7hlYPcpyc6twE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826604; c=relaxed/simple;
	bh=pNWfLrzQki4KHvyyIHaBHh05AMb7lzwUhSxqd5QGcDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RpiYCQT++3E37jEPNltrB7Hw5w0+0ChOiMsj6qzceX2/MudB6esMWX2G7SPuqFmV+7pTFDXhuggleL9Q8Kq0UqSZHJt8zTYrXVNA5G/lZpOuYx6RDmdKQE099AQdNPOQgze8C2M7LiZsMoQL7AJ0O+JP3yp74m/9L9CFBe05sk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hxbdBbFK; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hxbdBbFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIGK7QeviZw4ddW9Xfo+3W/eIPCe/newzz6qYzpUT4Oc8adZAWTTllsXDxHQeCbK1R2fFss1n2gCteOkO+LGqJJT7M9IBYQvADrHQju8RUXic7OKuLOgfrkWomjrIYifxo+Hu+XE9CnGZtZzTLiVlcOQArz3zcHAd8d3O+CbwcmniK2tnV42TIwJaDZDhhnjTF86bTGaYHPw3m0LM2R4TDxEIAPlIg4eVOEqmwWWZfpynFjLm1jI5Z46zZzHbvVYRGLUybFwFxHt1gJnEiA+BODRHJKXlATWz13AG8z53j/Ga8rhG1bZ9LabjodSuobQPgcbzjy9/WsfWT3EA/jf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+SHtNctOYyNVjI18g6S/a53/XjIZsrdhxxWTUO0iYY=;
 b=DOQxye/73VRDDt/IdbPv30IhpfSxnFkDIZR7LzpcrIt7MYMFkzpw4gteMHYXO3JspxOAQkXdi93a6u4nVAoP42KhfxdunNjnmueAdnW+18jQGNpfDMb5GffnrRJUY5n2QhxcxEc2q2K3Eqm2jIt8y2/i2Sl0+CcSqR2rnB2LMgfxiGHlZou8ITcUaaclaRh/c7iTRGrWME0nyApOxr2+ef41/DWSMOyClOlBFS6R2NqPDBcuDq8EUiGNhMcpt4SZAHFhxkQAGdVNl6D14PIK821ra43DGnRDdWaeX6qbCB8upJxGG2DlC1TQqsvwJ0LKX4sE+Px4QGNOC/85Ly9sSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+SHtNctOYyNVjI18g6S/a53/XjIZsrdhxxWTUO0iYY=;
 b=hxbdBbFKDfsObrajrBAk8mCKYgcEv0eFGjxAHZC6hsFbOnZ1hKacbTVEX6YeMn1msSvinmd0crkjEiFE9IYFcxTHuq+4FhbYjx6Vtqb803IRmc/lWr4nkmuNJgWX0mW5sd8cAbKlAJAGCs37iZ9p2CkoalNpTmuh9EMp0Ynq4eBC8Qk2BqtRzDkVXZ6Q5hWTs0qWxBTS+IIbjTokweVnERGnq9dw2spU4UIMeG+BAydrQk8Jgpa/wVB8jY+4gEQcA6KW6UVJROFZdcXZbhxWLVYoM0MHzAIglhZAGdiF4wKkIvZKM61rHtDB9T4AaFnfPWuIL2aRFEIQj04rR13hJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 17:36:39 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 17:36:39 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Donald Shannon <donalds@nvidia.com>,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/11] dt-bindings: i2c: Add NVIDIA LSTP I2C
Date: Mon, 12 Oct 2026 20:36:00 +0300
Message-ID: <20261012-lstp-usb-adapter-v1-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::10) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ee431f-7684-46c0-7edc-08df28875f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	9R4Ro2qhEeq6v0X5FBpzgZUu5NCCzikrk0m8xWZxXWAIjBovQw7nB1hr2mnAc9tyzX1KRFD+aYQa1FWIu/ocGl9/f1BVHvGFovTaFnkJRR5qT648s7WSefWnCJX7MRts+HRMx7h4u3GnCao54ai3Cqu/cJhfiT/4k1rgQpitRrjIg3z/C5l2JThoxtosbN5K8SdcPpaWNH823zndGFFffV4gLJDO/sL8EINP/vLY3T7lTslQhkAutX9sa6d3YFf8bxfqRZXyKShQvALHstg5iUvzud4H1zRAgt+7N481TD4Bgab05WkhwYyNF8g1aifohWm8Trs0MuGKZYXN9+cD49u6jwvOG6VIjHraJ4+7+C08eGzsGfgRLRCa5EOKITbFgGlFC9FLipvBnR8VYWqs0JTLiuSy593NXnarAe4va8D7hmegbJbfdaSrGHWuGIF7uGxUc2VFk6LWaLZpJKUi1t1lAffkriWYspLCN7gzLYxp3llPBHc+gvrWKdEGiy8qPrlY+XEa/sUYGHFJt34Brm0OC3z0+V8J9X1PZkX0veDS/0gYKMF7zPHKnRk1m4NdSkq0vy8WmbZN6x3qQJufFAhVC+nwAraNfJgWxD+fm96j1yyS5N6/CSdCKdEK3x4Oywd3FZ0O7QuS73EMm659J2+O5hThnmzNAwYeCiu5Yfg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1iqY9NnZAO7X0i1iMNcSLFG69xApxSAHZHJ5itdCOyUxzNhVhPdnqxGG99PP?=
 =?us-ascii?Q?Qb7dYFBV1BqD3C2dugtAg62ExKhLQ/HeTN5KoruuZwg1fXpdGsKrqYKn9fkn?=
 =?us-ascii?Q?bohPsfj5fNq5EQfaQZT+t7Va+o3tVJ8gsDKaz2kQq7+HWh79pkFe8VPK52JU?=
 =?us-ascii?Q?wiEcF4B90OAY/60lh7XWlmLaac0l25TeF5niEk+3Ckk3PTHnolmogRJYgnod?=
 =?us-ascii?Q?5ruPQf8XhEcCHsmC+EszUzAiJiByetv023DoCO3mueDd1oJtWirkkwtYgq1G?=
 =?us-ascii?Q?yCtN4l/mmGgQfYUOr2Zv/fSkidJBCENPPWpclGP0T7El4tj5kI+fv1va7sjO?=
 =?us-ascii?Q?FKvD5wjF/MdJR4Ucmb4TsTxasrEou3xxxC+2Nt1phbBWhh8w/eQviSnrpO/n?=
 =?us-ascii?Q?taIW2sWD+NBHhi6TYUgrpprQbnj4XsFOTBeEkYe0iWDzyXa4Z6AGpS5VxhC+?=
 =?us-ascii?Q?5odbJXXdxuBB2opqtCdMDqqFwaGsb3jnfOx5wFt06H21B2yyMxjvd7Tj7D7C?=
 =?us-ascii?Q?WcRPMlWFC8caXAlkUOMwNreY37RjbqZlfQywsgb6RLHZ3AYPRardq4rYlO2O?=
 =?us-ascii?Q?VjV+QaV1TxxSolspkh5J80oPeM9YH7mkubJ5KpikIngqlucthY93OBa+wxsT?=
 =?us-ascii?Q?H7kI1S2I+IIdoguuHu0Bv+alUfLF7QTla6vlfotIWQgayQHcFFpZJS0S1S1K?=
 =?us-ascii?Q?ae3WeMtSnwnW/XM3c28zWh5TZNNzYNnFI9EYSeZ7jdqIO5pGze9qN5/EUyGd?=
 =?us-ascii?Q?qeWJY/ctpR/43hnYUkafEHgp9VdLLLIot3X93GLuHDMfCuIza36K2yMnFQ69?=
 =?us-ascii?Q?4M6rOfFlmjNLtCm+1llhtriDuXjUy/chFi3u5Nv6TN3ls054xniIyKVKxqTm?=
 =?us-ascii?Q?uyes9LW7GN1GtkMO0vjoZDyAKfSuyAUgt6qYT4JUaLYCE6SYikr9ru1YG4N/?=
 =?us-ascii?Q?Tb1J+uO7m6Hf6twFJGa5GB6UnfPMYUeU8lKpXjGUIB34L/9onuB8SNUi3Sus?=
 =?us-ascii?Q?JLblq1uom7HYqm8AC6HobKbENhI7kbJsi99Hvv4NYYUqeRxdga6Rks5XhrHR?=
 =?us-ascii?Q?0JcCSsUkwHOX+wNYAjEmU56wwMRVj6HoH9QrGqq4F5MtjA9IogaDUJiS/YlD?=
 =?us-ascii?Q?eT3ZOqxpBreJL+rM+XqO4WIBvn7O+f+adb++G+R5zC0WrojQNUvh8C+nM5qc?=
 =?us-ascii?Q?9SNNfE9Ev4r9HO+iAmPPHFTYv/YnYVO4ekEeJxWMLoTQ79W9MYkBTFiNaVPr?=
 =?us-ascii?Q?a/t82clZTqkWVVZpwBX6GOmEAU0ZcmXTn6as7FOauZ1TeDUgZJ7RMgI5Timc?=
 =?us-ascii?Q?LmzoyQblmDRbDVaJMZH/9toDmbKTA6KOWSoa/QHRaeROMmBVVgRuWTrpEHVG?=
 =?us-ascii?Q?qHvzSSSAis/PwXzbIAtTazrtx5hn3W44/ssVssBLhZusjFXU2Zd+tuM1peQj?=
 =?us-ascii?Q?RKRh4ZXuoYni50h7GPG/ptki/OrqsfZ8Qi+8a04NuxZRTVZLHqcUSwmMXdK8?=
 =?us-ascii?Q?u/iXv08GiFjkmFJ8TI8NcjjPpvHHVbYZnv/Ff8DIs8NAp9a+A2ujLaqT3UkB?=
 =?us-ascii?Q?540DpXUIUZAeuZFhytTJGRzpZAbfUrfIWQMWF0DEYqewPCuWiAk7qVVl5Tcx?=
 =?us-ascii?Q?OkegM9/Q5iVLVR0k3bXW2A8z/3erO4pR0vbaCMlzvTdaZz40JrAuhVUy+NXv?=
 =?us-ascii?Q?5lcbH7laytiLS9G00bMmRKXBJ433OrfiUFjS0suyOjotwtnVHGs/Tt5nYsHB?=
 =?us-ascii?Q?mpLFTB+glg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ee431f-7684-46c0-7edc-08df28875f64
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:36:39.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQz91Vf5glnmZk9H4/iuELFOyyVmgryei2z/pQthq2ukysfDQKFGR7ldfA5ekS8jyzw9bqKrNt5AEcbzCxqxOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

Add the binding for an I2C controller channel of an NVIDIA LSTP USB
adapter. Peripherals on the bus are child nodes, as for any I2C
controller. The device sets the bus speed and the protocol cannot
change it, so clock-frequency is not supported.

nvidia,retries sets how many times the host re-issues a transfer that
failed on arbitration loss or a busy bus (default 3). The generic I2C
controller schema has no property for this. A device that reports its
own arbitration retries handles both cases itself, and the property is
ignored for it.

Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 .../bindings/i2c/nvidia,lstp-i2c.yaml         | 71 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml b/Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml
new file mode 100644
index 000000000000..eacabed52cd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/nvidia,lstp-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA LSTP I2C Channel
+
+maintainers:
+  - Adrian Ambrozewicz <aambrozewicz@nvidia.com>
+  - Donald Shannon <donalds@nvidia.com>
+
+description: |
+  I2C controller channel on an NVIDIA LSTP USB device.
+
+  Peripherals on the bus are described as child nodes.  An i2c alias
+  gives the bus a fixed number.
+
+  The bus speed is set by the device.  The LSTP protocol has no way to
+  change it, so clock-frequency is not supported and is ignored.
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: nvidia,lstp-i2c
+
+  reg:
+    description: Channel ID reported by the device firmware.
+    maxItems: 1
+
+  nvidia,retries:
+    description: |
+      Number of times the host re-issues a transfer that fails on
+      arbitration loss or a busy bus before giving up.
+
+      Ignored when the channel config reports non-zero bus arbitration
+      retries.  Such a device is expected to retry both arbitration loss and
+      a busy bus itself before reporting failure, so the host adds no
+      attempts on top.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 255
+    default: 3
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interface {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c@2 {
+            compatible = "nvidia,lstp-i2c";
+            reg = <2>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            nvidia,retries = <5>;
+
+            temperature-sensor@48 {
+                compatible = "ti,tmp102";
+                reg = <0x48>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 284000589694..d8092f6d91b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19571,6 +19571,7 @@ M:	Donald Shannon <donalds@nvidia.com>
 L:	linux-usb@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/gpio/nvidia,lstp-gpio.yaml
+F:	Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml
 
 NVIDIA VRS RTC DRIVER
 M:	Shubhi Garg <shgarg@nvidia.com>
-- 
2.43.0

