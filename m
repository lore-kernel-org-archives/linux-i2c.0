From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 8/8] i2c: reformat core-base file header
Date: Fri, 26 May 2017 10:20:59 +0200
Message-ID: <20170526082101.4746-9-wsa@the-dreams.de>
References: <20170526082101.4746-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170526082101.4746-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Finally, apply modern comment rules to the file header. The old style
looked very non-Linuxish and challenged my eyes for some time now.

I took the liberty to a) drop the two credits for the multiplexing
support here in this file because there is no significant code in the
base file and the two guys are fully credited in the i2c-mux file and b)
add my own copyright for the period of me being the maintainer.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core-base.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 78135c1deaab59..2f742ffac8754c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1,21 +1,18 @@
-/* i2c-core.c - a device driver for the iic-bus interface		     */
-/* ------------------------------------------------------------------------- */
-/*   Copyright (C) 1995-99 Simon G. Vogl
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.			     */
-/* ------------------------------------------------------------------------- */
-
-/* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi>.
-   Mux support by Rodolfo Giometti <giometti@enneenne.com> and
-   Michael Lawnick <michael.lawnick.ext@nsn.com>
+/*
+ * Linux I2C core
+ *
+ * Copyright (C) 1995-99 Simon G. Vogl
+ *   With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi>
+ * Copyright (C) 2013-2017 Wolfram Sang <wsa@the-dreams.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
  */
 
 #define pr_fmt(fmt) "i2c-core: " fmt
@@ -57,9 +54,10 @@
 #define I2C_ADDR_7BITS_MAX	0x77
 #define I2C_ADDR_7BITS_COUNT	(I2C_ADDR_7BITS_MAX + 1)
 
-/* core_lock protects i2c_adapter_idr, and guarantees
-   that device detection, deletion of detected devices, and attach_adapter
-   calls are serialized */
+/*
+ * core_lock protects i2c_adapter_idr, and guarantees that device detection,
+ * deletion of detected devices, and attach_adapter calls are serialized
+ */
 static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
 
-- 
2.11.0
