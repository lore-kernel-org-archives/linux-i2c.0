From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH i2c-tools] tools/Module.mk: Add missing dependencies
Date: Tue, 12 Dec 2017 21:33:55 +0100
Message-ID: <20171212213355.5f25754e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751281AbdLLUd6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 Dec 2017 15:33:58 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3C155AD6A
        for <linux-i2c@vger.kernel.org>; Tue, 12 Dec 2017 20:33:57 +0000 (UTC)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>

Better build the library before building the tools which link against
it, otherwise parallel builds could run into a race and break.
---
 lib/Module.mk   |    7 +++++++
 tools/Module.mk |   10 +++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/lib/Module.mk
+++ b/lib/Module.mk
@@ -35,6 +35,13 @@ LIB_TARGETS	+= $(LIB_STLIBNAME)
 LIB_OBJECTS	+= smbus.ao
 endif
 
+# Library file to link against (static or dynamic)
+ifeq ($(USE_STATIC_LIB),1)
+LIB_DEPS	:= $(LIB_DIR)/$(LIB_STLIBNAME)
+else
+LIB_DEPS	:= $(LIB_DIR)/$(LIB_SHBASENAME)
+endif
+
 #
 # Libraries
 #
--- a/tools/Module.mk
+++ b/tools/Module.mk
@@ -24,19 +24,19 @@ TOOLS_TARGETS	:= i2cdetect i2cdump i2cse
 # Programs
 #
 
-$(TOOLS_DIR)/i2cdetect: $(TOOLS_DIR)/i2cdetect.o $(TOOLS_DIR)/i2cbusses.o
+$(TOOLS_DIR)/i2cdetect: $(TOOLS_DIR)/i2cdetect.o $(TOOLS_DIR)/i2cbusses.o $(LIB_DEPS)
 	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
 
-$(TOOLS_DIR)/i2cdump: $(TOOLS_DIR)/i2cdump.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
+$(TOOLS_DIR)/i2cdump: $(TOOLS_DIR)/i2cdump.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o $(LIB_DEPS)
 	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
 
-$(TOOLS_DIR)/i2cset: $(TOOLS_DIR)/i2cset.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
+$(TOOLS_DIR)/i2cset: $(TOOLS_DIR)/i2cset.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o $(LIB_DEPS)
 	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
 
-$(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
+$(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o $(LIB_DEPS)
 	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
 
-$(TOOLS_DIR)/i2ctransfer: $(TOOLS_DIR)/i2ctransfer.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
+$(TOOLS_DIR)/i2ctransfer: $(TOOLS_DIR)/i2ctransfer.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o $(LIB_DEPS)
 	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
 
 #


-- 
Jean Delvare
SUSE L3 Support
