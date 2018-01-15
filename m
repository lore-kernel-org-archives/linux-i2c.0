From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-tools] CHANGES: add i2ctransfer
Date: Mon, 15 Jan 2018 18:36:44 +0100
Message-ID: <20180115173644.12342-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40718 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755445AbeAORgw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 12:36:52 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>

So people know from CHANGES when it has been added.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 CHANGES | 1 +
 1 file changed, 1 insertion(+)

diff --git a/CHANGES b/CHANGES
index 1ddaa9c..7ad9e21 100644
--- a/CHANGES
+++ b/CHANGES
@@ -63,6 +63,7 @@ master
             Marked as deprecated
   i2cdetect: Do a best effort detection if functionality is missing
              Clarify the SMBus commands used for probing by default
+  i2ctransfer: new tool to send user-defined I2C messages in one transfer
   i2c-dev.h: Minimize differences with kernel flavor
              Move SMBus helper functions to include/i2c/smbus.h
   i2c-stub-from-dump: Be more tolerant on input dump format
-- 
2.11.0
