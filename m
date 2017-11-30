From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v2] i2c: stm32: Fix copyrights
Date: Thu, 30 Nov 2017 09:43:57 +0100
Message-ID: <20171130084357.23327-1-benjamin.gaignard@st.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40195 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdK3IoE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 03:44:04 -0500
Received: by mail-wm0-f68.google.com with SMTP id v19so10823647wmh.5
        for <linux-i2c@vger.kernel.org>; Thu, 30 Nov 2017 00:44:03 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>, M'boumba Cedric Madianga <cedric.madianga@gmail.com>

Uniformize STMicroelectronics copyrights headers
Add SPDX identifier

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
CC: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 drivers/i2c/busses/i2c-stm32.h   | 3 ++-
 drivers/i2c/busses/i2c-stm32f4.c | 3 ++-
 drivers/i2c/busses/i2c-stm32f7.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32.h b/drivers/i2c/busses/i2c-stm32.h
index dab51761f8c5..d4f9cef251ac 100644
--- a/drivers/i2c/busses/i2c-stm32.h
+++ b/drivers/i2c/busses/i2c-stm32.h
@@ -1,10 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * i2c-stm32.h
  *
  * Copyright (C) M'boumba Cedric Madianga 2017
+ * Copyright (C) STMicroelectronics 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #ifndef _I2C_STM32_H
diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index 4ec108496f15..47c8d00de53f 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for STMicroelectronics STM32 I2C controller
  *
@@ -6,11 +7,11 @@
  * http://www.st.com/resource/en/reference_manual/DM00031020.pdf
  *
  * Copyright (C) M'boumba Cedric Madianga 2016
+ * Copyright (C) STMicroelectronics 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
  * This driver is based on i2c-st.c
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #include <linux/clk.h>
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index d4a6e9c2e9aa..b445b3bb0bb1 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for STMicroelectronics STM32F7 I2C controller
  *
@@ -7,11 +8,11 @@
  * http://www.st.com/resource/en/reference_manual/dm00124865.pdf
  *
  * Copyright (C) M'boumba Cedric Madianga 2017
+ * Copyright (C) STMicroelectronics 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
  * This driver is based on i2c-stm32f4.c
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.15.0
