From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 3/3] i2c: qcom-geni: Drop of_platform.h include
Date: Tue,  4 Feb 2020 11:31:52 -0800
Message-ID: <20200204193152.124980-4-swboyd@chromium.org>
References: <20200204193152.124980-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38237 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgBDTb5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 4 Feb 2020 14:31:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so1830642pjz.3
        for <linux-i2c@vger.kernel.org>; Tue, 04 Feb 2020 11:31:57 -0800 (PST)
In-Reply-To: <20200204193152.124980-1-swboyd@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Girish Mahadevan <girishm@codeaurora.org>, Dilip Kota <dkota@codeaurora.org>, Alok Chauhan <alokc@codeaurora.org>, Douglas Anderson <dianders@chromium.org>

This driver doesn't call any DT platform functions like of_platform_*().
Remove the include as it isn't used.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 192a8f622f3d..4378eb7b6633 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -10,7 +10,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/qcom-geni-se.h>
-- 
Sent by a computer, using git, on the internet
