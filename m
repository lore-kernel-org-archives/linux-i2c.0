From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 0/3] Misc qcom geni i2c driver fixes
Date: Tue, 10 Mar 2020 08:43:55 -0700
Message-ID: <20200310154358.39367-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Here's a small collection of qcom geni i2c driver fixes that
simplify the code and aid debugging. 

Changes from v1;
 - Simplified code some more and commented about platform_get_irq()
   in commit text for patch 2
 - Picked up reviewed by tags
 - Fixed first patch to use &pdev->dev so it keeps compiling
 - Rebased to v5.6-rc5

Stephen Boyd (3):
  i2c: qcom-geni: Let firmware specify irq trigger flags
  i2c: qcom-geni: Grow a dev pointer to simplify code
  i2c: qcom-geni: Drop of_platform.h include

 drivers/i2c/busses/i2c-qcom-geni.c | 58 ++++++++++++++----------------
 1 file changed, 26 insertions(+), 32 deletions(-)


base-commit: 2c523b344dfa65a3738e7039832044aa133c75fb
-- 
Sent by a computer, using git, on the internet
