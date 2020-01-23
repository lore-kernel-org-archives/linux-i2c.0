From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v2 06/28] docs: i2c: replace "I2C-transfer" -> "I2C transfer" consistently
Date: Thu, 23 Jan 2020 14:50:41 +0100
Message-ID: <20200123135103.20540-7-luca@lucaceresoli.net>
References: <20200123135103.20540-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:47618 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgAWNxD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 23 Jan 2020 08:53:03 -0500
In-Reply-To: <20200123135103.20540-1-luca@lucaceresoli.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org

"I2C transfer" is a legitimate english sentence, no need for a hyphen
between the two words, as as such it is used in most of the
documentation. Remove the hyphen in the few places where it is present.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Acked-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
---
 Documentation/i2c/i2c-topology.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/i2c/i2c-topology.rst b/Documentation/i2c/i2c-topology.rst
index b413ef6a6773..2a18b53e3508 100644
--- a/Documentation/i2c/i2c-topology.rst
+++ b/Documentation/i2c/i2c-topology.rst
@@ -137,14 +137,14 @@ Mux-locked Example
 
 When there is an access to D1, this happens:
 
- 1. Someone issues an I2C-transfer to D1.
+ 1. Someone issues an I2C transfer to D1.
  2. M1 locks muxes on its parent (the root adapter in this case).
  3. M1 calls ->select to ready the mux.
- 4. M1 (presumably) does some I2C-transfers as part of its select.
-    These transfers are normal I2C-transfers that locks the parent
+ 4. M1 (presumably) does some I2C transfers as part of its select.
+    These transfers are normal I2C transfers that locks the parent
     adapter.
- 5. M1 feeds the I2C-transfer from step 1 to its parent adapter as a
-    normal I2C-transfer that locks the parent adapter.
+ 5. M1 feeds the I2C transfer from step 1 to its parent adapter as a
+    normal I2C transfer that locks the parent adapter.
  6. M1 calls ->deselect, if it has one.
  7. Same rules as in step 4, but for ->deselect.
  8. M1 unlocks muxes on its parent.
@@ -169,7 +169,7 @@ PL1. If you build a topology with a parent-locked mux being the child
      of another mux, this might break a possible assumption from the
      child mux that the root adapter is unused between its select op
      and the actual transfer (e.g. if the child mux is auto-closing
-     and the parent mux issues I2C-transfers as part of its select).
+     and the parent mux issues I2C transfers as part of its select).
      This is especially the case if the parent mux is mux-locked, but
      it may also happen if the parent mux is parent-locked.
 
@@ -197,15 +197,15 @@ Parent-locked Example
 
 When there is an access to D1, this happens:
 
- 1.  Someone issues an I2C-transfer to D1.
+ 1.  Someone issues an I2C transfer to D1.
  2.  M1 locks muxes on its parent (the root adapter in this case).
  3.  M1 locks its parent adapter.
  4.  M1 calls ->select to ready the mux.
- 5.  If M1 does any I2C-transfers (on this root adapter) as part of
-     its select, those transfers must be unlocked I2C-transfers so
+ 5.  If M1 does any I2C transfers (on this root adapter) as part of
+     its select, those transfers must be unlocked I2C transfers so
      that they do not deadlock the root adapter.
- 6.  M1 feeds the I2C-transfer from step 1 to the root adapter as an
-     unlocked I2C-transfer, so that it does not deadlock the parent
+ 6.  M1 feeds the I2C transfer from step 1 to the root adapter as an
+     unlocked I2C transfer, so that it does not deadlock the parent
      adapter.
  7.  M1 calls ->deselect, if it has one.
  8.  Same rules as in step 5, but for ->deselect.
@@ -293,7 +293,7 @@ device lockups and/or other problems.
 
 The topology is especially troublesome if M2 is an auto-closing
 mux. In that case, any interleaved accesses to D4 might close M2
-prematurely, as might any I2C-transfers part of M1->select.
+prematurely, as might any I2C transfers part of M1->select.
 
 But if M2 is not making the above stated assumption, and if M2 is not
 auto-closing, the topology is fine.
-- 
2.25.0
