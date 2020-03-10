From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 3/3] i2c: qcom-geni: Drop of_platform.h include
Date: Tue, 10 Mar 2020 08:43:58 -0700
Message-ID: <20200310154358.39367-4-swboyd@chromium.org>
References: <20200310154358.39367-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200310154358.39367-1-swboyd@chromium.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-i2c@vger.kernel.org

This driver doesn't call any DT platform functions like of_platform_*().
Remove the include as it isn't used.

Cc: Alok Chauhan <alokc@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 2f5fb2e83f95..18d1e4fd4cf3 100644
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
