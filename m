From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 4/5] dt-bindings: i2c: pca9541: extend with compatible for
 PCA9641
Date: Wed, 6 Mar 2019 23:15:50 +0000
Message-ID: <20190306231521.29367-5-peda@axentia.se>
References: <20190306231521.29367-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306231521.29367-1-peda@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ken Chen <chen.kenyy@inventec.com>, Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
List-Id: linux-i2c@vger.kernel.org

The binding is equivalent apart from the compatible.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/i2c/nxp,pca9541.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt b/Docume=
ntation/devicetree/bindings/i2c/nxp,pca9541.txt
index 42bfc09c8918..17b4cb9d76da 100644
--- a/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
+++ b/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
@@ -1,8 +1,10 @@
-* NXP PCA9541 I2C bus master selector
+* NXP PCA9541/PCA9641 I2C bus master selectors
=20
 Required Properties:
=20
-  - compatible: Must be "nxp,pca9541"
+  - compatible: Must be either of
+		"nxp,pca9541"
+		"nxp,pca9641"
=20
   - reg: The I2C address of the device.
=20
--=20
2.11.0
