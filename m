From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] dt-bindings: deprecate trivial-devices.txt for i2c
Date: Thu, 26 Jan 2017 23:55:43 +0100
Message-ID: <20170126225544.5431-2-wsa@the-dreams.de>
References: <20170126225544.5431-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47816 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbdAZW4N (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Jan 2017 17:56:13 -0500
In-Reply-To: <20170126225544.5431-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, robh+dt@kernel.org, Wolfram Sang <wsa@the-dreams.de>

The idea to collect trivial devices in a seperate file is coming from
the early DT days and turned out to be a bad decision. It regularly
creates maintenance pain and the information is not where users would
expect it (i2c folder is for i2c bus drivers not clients). Also, we do
not maintain such a file for other subsystems, so we should put an end
to this as well. First step is to deprecate it and mention that it
should be refactored into proper bindings.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index cdd7b48826c38f..39570a1ca5919f 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -1,11 +1,15 @@
+*** This file is DEPRECATED! ***
+
 This is a list of trivial i2c devices that have simple device tree
 bindings, consisting only of a compatible field, an address and
 possibly an interrupt line.
 
-If a device needs more specific bindings, such as properties to
-describe some aspect of it, there needs to be a specific binding
-document for it just like any other devices.
+The entries here need to be refactored to proper binding descriptions in
+their relevant subdirectories.
+
+New items will not be added to this file.
 
+*** This file is DEPRECATED! ***
 
 Compatible		Vendor / Chip
 ==========		=============
-- 
2.10.2
