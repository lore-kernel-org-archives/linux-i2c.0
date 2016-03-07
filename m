From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v3 07/14] dt-bindings: i2c: Add Octeon cn78xx TWSI
Date: Mon,  7 Mar 2016 16:10:50 +0100
Message-ID: <f944dc3cd2df7957dbc5fb08cf7be007dd25ae29.1457362545.git.jglauber@cavium.com>
References: <cover.1457362545.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33654 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbcCGPLW (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2016 10:11:22 -0500
In-Reply-To: <cover.1457362545.git.jglauber@cavium.com>
In-Reply-To: <cover.1457362545.git.jglauber@cavium.com>
References: <cover.1457362545.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

Add compatible string for Cavium Octeon cn78XX SOCs TWSI.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
---
 Documentation/devicetree/bindings/i2c/i2c-octeon.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-octeon.txt b/Documentation/devicetree/bindings/i2c/i2c-octeon.txt
index dced82e..872d485 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-octeon.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-octeon.txt
@@ -4,6 +4,12 @@
 
   Compatibility with all cn3XXX, cn5XXX and cn6XXX SOCs.
 
+  or
+
+  compatible: "cavium,octeon-7890-twsi"
+
+  Compatibility with cn78XX SOCs.
+
 - reg: The base address of the TWSI/I2C bus controller register bank.
 
 - #address-cells: Must be <1>.
-- 
1.9.1
