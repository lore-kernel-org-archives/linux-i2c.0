From: maxin.john@gmail.com
Subject: [PATCH] i2c-tools: eeprog/Module.mk: Add missing dependency
Date: Mon, 18 Dec 2017 16:11:37 +0200
Message-ID: <1513606297-5072-1-git-send-email-maxin.john@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10082 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752997AbdLROLQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 18 Dec 2017 09:11:16 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jdelvare@suse.de, "Maxin B. John" <maxin.john@intel.com>

From: "Maxin B. John" <maxin.john@intel.com>

Absence of this dependency caused parallel build to run into a race
and break.

Signed-off-by: Maxin B. John <maxin.john@intel.com>
---
 eeprog/Module.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/eeprog/Module.mk b/eeprog/Module.mk
index 9d36869..d215855 100644
--- a/eeprog/Module.mk
+++ b/eeprog/Module.mk
@@ -20,7 +20,7 @@ EEPROG_TARGETS	:= eeprog
 # Programs
 #
 
-$(EEPROG_DIR)/eeprog: $(EEPROG_DIR)/eeprog.o $(EEPROG_DIR)/24cXX.o
+$(EEPROG_DIR)/eeprog: $(EEPROG_DIR)/eeprog.o $(EEPROG_DIR)/24cXX.o $(LIB_DEPS)
 	$(CC) $(LDFLAGS) -o $@ $^ $(EEPROG_LDFLAGS)
 
 #
-- 
2.4.0
