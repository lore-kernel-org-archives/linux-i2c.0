From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [RFC,v2 4/6] media: dt-bindings: add DS90UB953-Q1 video serializer
Date: Tue, 23 Jul 2019 22:37:21 +0200
Message-ID: <20190723203723.11730-5-luca@lucaceresoli.net>
References: <20190723203723.11730-1-luca@lucaceresoli.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723203723.11730-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-media@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>, Vladimir Zapolskiy <vz@mleia.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

Describe the Texas Instruments DS90UB953-Q1, a video serializer with remote
access to I2C and GPIOs.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes RFCv1 -> RFCv2: none, this patch is new in RFCv2
---
 .../bindings/media/i2c/ti,ds90ub953-q1.txt    | 42 +++++++++++++++++++
 include/dt-bindings/media/ds90ub953.h         | 16 +++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ti,ds90ub953-q1.txt
 create mode 100644 include/dt-bindings/media/ds90ub953.h

diff --git a/Documentation/devicetree/bindings/media/i2c/ti,ds90ub953-q1.txt b/Documentation/devicetree/bindings/media/i2c/ti,ds90ub953-q1.txt
new file mode 100644
index 000000000000..ba24f887b607
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ti,ds90ub953-q1.txt
@@ -0,0 +1,42 @@
+Texas Instruments DS90UB953-Q1 video serializer
+===============================================
+
+The TI DS90UB953-Q1 is a MIPI CSI-2 video serializer that forwards a MIPI
+CSI-2 input video stream over an FPD Link 3 connection to a remote
+deserializer. It also allows access to I2C and GPIO from the deserializer.
+
+The DT definitions can be found in include/dt-bindings/media/ds90ub953.h
+
+When used as a the remote counterpart of a deserializer (e.g. the
+DS90UB954-Q1), the serializer is described in the
+"deserializer/ports/port@<N>/endpoint/remote-chip" node.
+
+Required properties:
+
+ - compatible: must be "ti,ds90ub953-q1"
+
+Optional properties:
+
+ - gpio-functions: a list of 4 values defining how the 4 GPIO pins are
+   connected in hardware; possible values are:
+    - DS90_GPIO_FUNC_UNUSED (0): the GPIO is not connected
+    - DS90_GPIO_FUNC_INPUT (1): the GPIO is an input to the ds90ub953
+    - DS90_GPIO_FUNC_OUTPUT_REMOTE (2): the GPIO is an output from the
+      ds90ub953, to be driven from the remote chip (deserializer)
+
+ - ti,ds90ub953-q1-clk-inv-pol-quirk: the MIPI CSI-2 input clock lane has
+                                      inverted polarity
+
+
+Device node example
+-------------------
+
+&ds90ub954_fpd3_in0 {
+	remote-chip {
+		compatible = "ti,ds90ub953-q1";
+		gpio-functions = <DS90_GPIO_FUNC_OUTPUT_REMOTE
+				  DS90_GPIO_FUNC_OUTPUT_REMOTE
+				  DS90_GPIO_FUNC_UNUSED
+				  DS90_GPIO_FUNC_UNUSED>;
+	};
+};
diff --git a/include/dt-bindings/media/ds90ub953.h b/include/dt-bindings/media/ds90ub953.h
new file mode 100644
index 000000000000..5359432968e9
--- /dev/null
+++ b/include/dt-bindings/media/ds90ub953.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * Definitions for the Texas Instruments DS90UB953-Q1 video serializer
+ *
+ * Copyright (c) 2019 Luca Ceresoli <luca@lucaceresoli.net>
+ */
+
+#ifndef _DS90UB953_H
+#define _DS90UB953_H
+
+#define DS90_GPIO_FUNC_UNUSED             0
+#define DS90_GPIO_FUNC_INPUT              1
+#define DS90_GPIO_FUNC_OUTPUT_REMOTE      2
+#define DS90_GPIO_N_FUNCS                 3
+
+#endif /* _DS90UB953_H */
-- 
2.17.1
