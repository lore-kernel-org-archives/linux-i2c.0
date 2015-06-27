From: "Matwey V. Kornilov" <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-tools: Implement Module.mk for eepromer subdir
Date: Sat, 27 Jun 2015 11:49:07 +0300
Message-ID: <1435394947-5228-1-git-send-email-matwey.kornilov@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, "Matwey V. Kornilov" <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

eepromer/Module.mk has to be present in order to do
    make EXTRA=eepromer

Signed-off-by: Matwey V. Kornilov <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
--- /dev/null
+++ i2c-tools-3.1.1/eepromer/Module.mk
@@ -0,0 +1,79 @@
+# eepromer
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+
+EEPROMER_DIR	:= eepromer
+
+EEPROMER_CFLAGS := -O2 -Iinclude -Wall 
+ifeq ($(USE_STATIC_LIB),1)
+EEPROMER_LDFLAGS	:= $(LIB_DIR)/$(LIB_STLIBNAME)
+else
+EEPROMER_LDFLAGS	:= -L$(LIB_DIR) -li2c
+endif
+
+EEPROMER_TARGETS	:= eepromer eeprom eeprog
+
+#
+# Programs
+#
+
+$(EEPROMER_DIR)/eepromer:  $(EEPROMER_DIR)/eepromer.o
+	$(CC) $(LDFLAGS) -o $@ $^ $(EEPROMER_LDFLAGS)
+
+$(EEPROMER_DIR)/eeprom: $(EEPROMER_DIR)/eeprom.o
+	$(CC) $(LDFLAGS) -o $@ $^ $(EEPROMER_LDFLAGS)
+
+$(EEPROMER_DIR)/eeprog: $(EEPROMER_DIR)/eeprog.o $(EEPROMER_DIR)/24cXX.o
+	$(CC) $(LDFLAGS) -o $@ $^ $(EEPROMER_LDFLAGS)
+
+#
+# Objects
+#
+
+$(EEPROMER_DIR)/eepromer.o: $(EEPROMER_DIR)/eepromer.c
+	$(CC) $(CFLAGS) $(EEPROMER_CFLAGS) -c $< -o $@
+
+$(EEPROMER_DIR)/eeprom.o: $(EEPROMER_DIR)/eeprom.c
+	$(CC) $(CFLAGS) $(EEPROMER_CFLAGS) -c $< -o $@
+
+$(EEPROMER_DIR)/eeprog.o: $(EEPROMER_DIR)/eeprog.c $(EEPROMER_DIR)/24cXX.h
+	$(CC) $(CFLAGS) $(EEPROMER_CFLAGS) -c $< -o $@
+
+$(EEPROMER_DIR)/24cXX.o: $(EEPROMER_DIR)/24cXX.c $(EEPROMER_DIR)/24cXX.h
+	$(CC) $(CFLAGS) $(EEPROMER_CFLAGS) -c $< -o $@
+
+#
+# Commands
+#
+
+all-eepromer: $(addprefix $(EEPROMER_DIR)/,$(EEPROMER_TARGETS))
+
+strip-eepromer: $(addprefix $(EEPROMER_DIR)/,$(EEPROMER_TARGETS))
+	strip $(addprefix $(EEPROMER_DIR)/,$(EEPROMER_TARGETS))
+
+clean-eepromer:
+	$(RM) $(addprefix $(EEPROMER_DIR)/,*.o $(EEPROMER_TARGETS))
+
+install-eepromer: $(addprefix $(EEPROMER_DIR)/,$(EEPROMER_TARGETS))
+	$(INSTALL_DIR) $(DESTDIR)$(sbindir) $(DESTDIR)$(man8dir)
+	for program in $(EEPROMER_TARGETS) ; do \
+	$(INSTALL_PROGRAM) $(EEPROMER_DIR)/$$program $(DESTDIR)$(sbindir) ; \
+	$(INSTALL_DATA) $(EEPROMER_DIR)/$$program.8 $(DESTDIR)$(man8dir) ; done
+
+uninstall-eepromer:
+	for program in $(EEPROMER_TARGETS) ; do \
+	$(RM) $(DESTDIR)$(sbindir)/$$program ; \
+	$(RM) $(DESTDIR)$(man8dir)/$$program.8 ; done
+
+all: all-eepromer
+
+strip: strip-eepromer
+
+clean: clean-eepromer
+
+install: install-eepromer
+
+uninstall: uninstall-eepromer
