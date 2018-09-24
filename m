From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v3 0/3] Fix qcom geni i2c DMA handling
Date: Mon, 24 Sep 2018 16:52:33 -0700
Message-ID: <20180924235235.182649-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-i2c@vger.kernel.org

(Numbering is weird because I dropped patch 1 but left numbering
the same)

The qcom GENI I2C driver fails DMA sometimes when things
from request firmware are passed in as the message buffer.
This patch series fixes that problem in the first patch
and the second patch cleans up the code a little to reduce
lines and simplify lines.

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>

Changes from v2:
 * Dropped first patch because it's applied
 * New patch 3 to simplify irq handler
 * Updated patch 2 to hoist out common code and remove 'mode'
   local variable

Changes from v1:
 * Use i2c helpers to map buffers
 * New patch 2 to clean up seriously indented code

Stephen Boyd (2):
  i2c: i2c-qcom-geni: Simplify tx/rx functions
  i2c: i2c-qcom-geni: Simplify irq handler

 drivers/i2c/busses/i2c-qcom-geni.c | 149 +++++++++++++----------------
 1 file changed, 65 insertions(+), 84 deletions(-)

-- 
Sent by a computer through tubes
