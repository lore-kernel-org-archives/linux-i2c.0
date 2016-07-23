From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/2] Documentation: i2c: slave: give proper example for pm usage
Date: Sat, 23 Jul 2016 22:06:52 +0200
Message-ID: <1469304412-2652-2-git-send-email-wsa@the-dreams.de>
References: <1469304412-2652-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35344 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbcGWUHC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 23 Jul 2016 16:07:02 -0400
In-Reply-To: <1469304412-2652-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

pm_runtime_forbid was the wrong knob, this is the better one.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/i2c/slave-interface | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/slave-interface b/Documentation/i2c/slave-interface
index abd10186a9e9fc..80807adb8ded52 100644
--- a/Documentation/i2c/slave-interface
+++ b/Documentation/i2c/slave-interface
@@ -139,9 +139,9 @@ If you want to add slave support to the bus driver:
 * implement calls to register/unregister the slave and add those to the
   struct i2c_algorithm. When registering, you probably need to set the i2c
   slave address and enable slave specific interrupts. If you use runtime pm, you
-  should use pm_runtime_forbid() because your device usually needs to be powered
-  on always to be able to detect its slave address. When unregistering, do the
-  inverse of the above.
+  should use pm_runtime_get_sync() because your device usually needs to be
+  powered on always to be able to detect its slave address. When unregistering,
+  do the inverse of the above.
 
 * Catch the slave interrupts and send appropriate i2c_slave_events to the backend.
 
-- 
2.8.1
