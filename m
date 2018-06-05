From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 9/9] i2c: i2c-cros-ec-tunnel: Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 11:22:09 +0200
Message-ID: <20180605092209.22887-10-enric.balletbo@collabora.com>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605092209.22887-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index eb76b76f4754..82bcd9a78759 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -1,13 +1,7 @@
-/*
- *  Copyright (C) 2013 Google, Inc
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- * Expose an I2C passthrough to the ChromeOS EC.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Expose an I2C passthrough to the ChromeOS EC.
+//
+// Copyright (C) 2013 Google, Inc.
 
 #include <linux/module.h>
 #include <linux/i2c.h>
-- 
2.17.1
