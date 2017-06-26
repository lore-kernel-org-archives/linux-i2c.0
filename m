From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH 6/6] Documentation/devicetree: Add FSI-attached I2C master dt bindings
Date: Mon, 26 Jun 2017 14:29:35 -0500
Message-ID: <1498505375-1454-7-git-send-email-eajames@linux.vnet.ibm.com>
References: <1498505375-1454-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751798AbdFZTaD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 26 Jun 2017 15:30:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5QJT9UG080680
        for <linux-i2c@vger.kernel.org>; Mon, 26 Jun 2017 15:30:02 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bb2yw6ucd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-i2c@vger.kernel.org>; Mon, 26 Jun 2017 15:30:02 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-i2c@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Mon, 26 Jun 2017 13:30:00 -0600
In-Reply-To: <1498505375-1454-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, gregkh@linuxfoundation.org, jk@ozlabs.org, joel@jms.id.au, andrew@aj.id.au, eajames@linux.vnet.ibm.com, "Edward A. James" <eajames@us.ibm.com>

From: "Edward A. James" <eajames@us.ibm.com>

Document the bindings.

Signed-off-by: Edward A. James <eajames@us.ibm.com>
---
 Documentation/devicetree/bindings/i2c/i2c-fsi.txt | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-fsi.txt b/Documentation/devicetree/bindings/i2c/i2c-fsi.txt
new file mode 100644
index 0000000..fffc067
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-fsi.txt
@@ -0,0 +1,31 @@
+Device-tree bindings for FSI-attached I2C master driver
+-------------------------------------------------------
+
+Required properties:
+ - compatible = "ibm,i2cm-fsi";
+ - reg = < address size >;		: The FSI CFAM address and address space
+					  size.
+ - #address-cells = <1>;		: Number of address cells in child nodes
+ - #size-cells = <0>;			: Number of size cells in child nodes.
+ - child nodes				: Nodes to describe ports off the I2C
+					  master.
+
+Child node required properties:
+ - reg = < port number >		: The port number on the I2C master.
+
+Examples:
+
+    i2cm@1800 {
+        compatible = "ibm,i2cm-fsi";
+        reg = < 0x1800 0x400 >;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+            reg = <0>;
+        };
+
+        port@1 {
+            reg = <1>;
+        };
+    };
-- 
1.8.3.1
