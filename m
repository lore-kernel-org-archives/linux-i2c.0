From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] Documentation: i2c: slave: describe buffer problems a bit better
Date: Sat, 23 Jul 2016 22:06:51 +0200
Message-ID: <1469304412-2652-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35343 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbcGWUHC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 23 Jul 2016 16:07:02 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/i2c/slave-interface | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/i2c/slave-interface b/Documentation/i2c/slave-interface
index 61ed05cd95317f..abd10186a9e9fc 100644
--- a/Documentation/i2c/slave-interface
+++ b/Documentation/i2c/slave-interface
@@ -173,13 +173,14 @@ During development of this API, the question of using buffers instead of just
 bytes came up. Such an extension might be possible, usefulness is unclear at
 this time of writing. Some points to keep in mind when using buffers:
 
-* Buffers should be opt-in and slave drivers will always have to support
-  byte-based transactions as the ultimate fallback because this is how the
-  majority of HW works.
-
-* For backends simulating hardware registers, buffers are not helpful because
-  on writes an action should be immediately triggered. For reads, the data in
-  the buffer might get stale.
+* Buffers should be opt-in and backend drivers will always have to support
+  byte-based transactions as the ultimate fallback anyhow because this is how
+  the majority of HW works.
+
+* For backends simulating hardware registers, buffers are largely not helpful
+  because after each byte written an action should be immediately triggered.
+  For reads, the data kept in the buffer might get stale if the backend just
+  updated a register because of internal processing.
 
 * A master can send STOP at any time. For partially transferred buffers, this
   means additional code to handle this exception. Such code tends to be
-- 
2.8.1
