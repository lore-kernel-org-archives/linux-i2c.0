From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] Documentation: i2c: slave-interface: add note for driver development
Date: Thu, 25 Aug 2016 19:27:40 +0200
Message-ID: <20160825172740.25390-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46492 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754446AbcHYSC5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 14:02:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

Make it clear that adding slave support shall not disable master
functionality. We can have both, so we should.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/i2c/slave-interface | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/i2c/slave-interface b/Documentation/i2c/slave-interface
index 80807adb8ded52..7e2a228f21bccd 100644
--- a/Documentation/i2c/slave-interface
+++ b/Documentation/i2c/slave-interface
@@ -145,6 +145,11 @@ If you want to add slave support to the bus driver:
 
 * Catch the slave interrupts and send appropriate i2c_slave_events to the backend.
 
+Note that most hardware supports being master _and_ slave on the same bus. So,
+if you extend a bus driver, please make sure that the driver supports that as
+well. In almost all cases, slave support does not need to disable the master
+functionality.
+
 Check the i2c-rcar driver as an example.
 
 
-- 
2.9.3
