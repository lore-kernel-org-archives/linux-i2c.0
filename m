From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 03/11] i2c: use SPDX identifier for Renesas drivers
Date: Wed, 22 Aug 2018 00:02:16 +0200
Message-ID: <20180821220233.9202-4-wsa+renesas@sang-engineering.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

To be applied individually per subsystem tree. Morimoto-san, could you maybe
ack this with your Renesas address?

 drivers/i2c/busses/i2c-emev2.c      |  5 +----
 drivers/i2c/busses/i2c-highlander.c |  5 +----
 drivers/i2c/busses/i2c-rcar.c       | 10 +---------
 drivers/i2c/busses/i2c-riic.c       |  5 +----
 drivers/i2c/busses/i2c-sh_mobile.c  | 10 +---------
 5 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
index ba9b6ea48a31..35b302d983e0 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * I2C driver for the Renesas EMEV2 SoC
  *
  * Copyright (C) 2015 Wolfram Sang <wsa@sang-engineering.com>
  * Copyright 2013 Codethink Ltd.
  * Copyright 2010-2015 Renesas Electronics Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index 56dc69e7349f..ff340d7ae2e5 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Solutions Highlander FPGA I2C/SMBus support.
  *
@@ -6,10 +7,6 @@
  * Copyright (C) 2008  Paul Mundt
  * Copyright (C) 2008  Renesas Solutions Corp.
  * Copyright (C) 2008  Atom Create Engineering Co., Ltd.
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License version 2. See the file "COPYING" in the main directory
- * of this archive for more details.
  */
 #include <linux/module.h>
 #include <linux/interrupt.h>
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 43ad933df0f0..52cf42b32f0a 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for the Renesas R-Car I2C unit
  *
@@ -9,15 +10,6 @@
  *
  * This file is based on the drivers/i2c/busses/i2c-sh7760.c
  * (c) 2005-2008 MSC Vertriebsges.m.b.H, Manuel Lauss <mlau@msc-ge.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #include <linux/bitops.h>
 #include <linux/clk.h>
diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 5f1fca7880b1..b75ff144b570 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas RIIC driver
  *
  * Copyright (C) 2013 Wolfram Sang <wsa@sang-engineering.com>
  * Copyright (C) 2013 Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 /*
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 9c7f6f8ceb22..439e8778f849 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH Mobile I2C Controller
  *
@@ -7,15 +8,6 @@
  *
  * Portions of the code based on out-of-tree driver i2c-sh7343.c
  * Copyright (c) 2006 Carlos Munoz <carlos@kenati.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
-- 
2.11.0
