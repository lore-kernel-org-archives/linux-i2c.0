From: Eduardo Valentin <eduval@amazon.com>
Subject: [PATCH 1/3] dt-bindings: i2c: document bindings for i2c-slave-mqueue
Date: Thu, 30 May 2019 21:33:45 -0700
Message-ID: <20190531043347.4196-2-eduval@amazon.com>
References: <20190531043347.4196-1-eduval@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190531043347.4196-1-eduval@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Haiyue Wang <haiyue.wang@linux.intel.com>, jarkko.nikula@linux.intel.com, andriy.shevchenko@intel.com, brendanhiggins@google.com, Eduardo Valentin <eduval@amazon.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Document the i2c-slave-mqueue binding by adding
descriptor, required properties, and example.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
 .../bindings/i2c/i2c-slave-mqueue.txt         | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-slave-mqueue.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-slave-mqueue.txt b/Documentation/devicetree/bindings/i2c/i2c-slave-mqueue.txt
new file mode 100644
index 000000000000..eb1881a4fc0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-slave-mqueue.txt
@@ -0,0 +1,34 @@
+===============================================
+Device Tree for I2C slave message queue backend
+===============================================
+
+Some protocols over I2C/SMBus are designed for bi-directional transferring
+messages by using I2C Master Write protocol. This requires that both sides
+of the communication have slave addresses.
+
+This I2C slave mqueue (message queue) is used to receive and queue
+messages from the remote i2c intelligent device; and it will add the target
+slave address (with R/W# bit is always 0) into the message at the first byte.
+
+Links
+----
+`Intelligent Platform Management Bus
+Communications Protocol Specification
+<https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmp-spec-v1.0.pdf>`_
+
+`Management Component Transport Protocol (MCTP)
+SMBus/I2C Transport Binding Specification
+<https://www.dmtf.org/sites/default/files/standards/documents/DSP0237_1.1.0.pdf>`_
+
+Required Properties:
+- compatible		: should be "i2c-slave-mqueue"
+- reg			: slave address
+
+Example:
+
+i2c {
+	slave_mqueue: i2c-slave-mqueue {
+		compatible = "i2c-slave-mqueue";
+		reg = <0x10>;
+	};
+};
-- 
2.21.0
