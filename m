From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 0/2] Fix qcom geni i2c DMA handling
Date: Thu, 20 Sep 2018 11:03:21 -0700
Message-ID: <20180920180323.217377-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

The qcom GENI I2C driver fails DMA sometimes when things
from request firmware are passed in as the message buffer.
This patch series fixes that problem in the first patch
and the second patch cleans up the code a little to reduce
lines and simplify lines.

Changes from v1:
 * Use i2c helpers to map buffers
 * New patch 2 to clean up seriously indented code

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>

Stephen Boyd (2):
  i2c: i2c-qcom-geni: Properly handle DMA safe buffers
  i2c: i2c-qcom-geni: Simplify tx/rx functions

 drivers/i2c/busses/i2c-qcom-geni.c | 68 +++++++++++++++++-------------
 1 file changed, 39 insertions(+), 29 deletions(-)

-- 
Sent by a computer through tubes
