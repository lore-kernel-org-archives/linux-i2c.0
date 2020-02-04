From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 0/3] Misc qcom geni i2c driver fixes
Date: Tue,  4 Feb 2020 11:31:49 -0800
Message-ID: <20200204193152.124980-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Here's a small collection of qcom geni i2c driver fixes that
simplify the code and aid debugging.

Stephen Boyd (3):
  i2c: qcom-geni: Let firmware specify irq trigger flags
  i2c: qcom-geni: Grow a dev pointer to simplify code
  i2c: qcom-geni: Drop of_platform.h include

 drivers/i2c/busses/i2c-qcom-geni.c | 54 ++++++++++++++----------------
 1 file changed, 25 insertions(+), 29 deletions(-)

-- 
Sent by a computer, using git, on the internet
