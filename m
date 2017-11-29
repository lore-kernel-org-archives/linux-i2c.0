From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH] i2c: stm32: Fix copyrights
Date: Wed, 29 Nov 2017 15:21:42 +0100
Message-ID: <20171129142142.23183-1-benjamin.gaignard@st.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:42971 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbdK2OVr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Nov 2017 09:21:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id l141so6635090wmg.1
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 06:21:46 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>

Uniformize STMicroelectronics copyrights headers

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/i2c/busses/i2c-stm32.h   | 1 +
 drivers/i2c/busses/i2c-stm32f4.c | 1 +
 drivers/i2c/busses/i2c-stm32f7.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-stm32.h b/drivers/i2c/busses/i2c-stm32.h
index dab51761f8c5..490f6e6bebc2 100644
--- a/drivers/i2c/busses/i2c-stm32.h
+++ b/drivers/i2c/busses/i2c-stm32.h
@@ -2,6 +2,7 @@
  * i2c-stm32.h
  *
  * Copyright (C) M'boumba Cedric Madianga 2017
+ * Copyright (C) STMicroelectronics SA 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
  * License terms:  GNU General Public License (GPL), version 2
diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index 4ec108496f15..f399ef344d30 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -6,6 +6,7 @@
  * http://www.st.com/resource/en/reference_manual/DM00031020.pdf
  *
  * Copyright (C) M'boumba Cedric Madianga 2016
+ * Copyright (C) STMicroelectronics SA 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
  * This driver is based on i2c-st.c
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index d4a6e9c2e9aa..e85f4b7aedf6 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -7,6 +7,7 @@
  * http://www.st.com/resource/en/reference_manual/dm00124865.pdf
  *
  * Copyright (C) M'boumba Cedric Madianga 2017
+ * Copyright (C) STMicroelectronics SA 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
  * This driver is based on i2c-stm32f4.c
-- 
2.15.0
