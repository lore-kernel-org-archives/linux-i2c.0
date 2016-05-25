From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V3 0/2] i2c: qup: Some misc fixes
Date: Wed, 25 May 2016 13:46:50 +0530
Message-ID: <1464164212-11377-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org, wsa@the-dreams.de, absahu@codeaurora.org
Cc: sricharan@codeaurora.org
List-Id: linux-i2c@vger.kernel.org

One for fixing the bug with CONFIG_DEBUG_SG enabled and another
to suspend the transfer for all errors instead of just for NACK.

[V3] Added more commit description. Return more appropriate
     error codes for NACK and other bus errors. Corrected
     other bus errors handling procedure for dma mode as well.
     Removed the dev_err log for NACKs.

[V2] Removed the use of unnecessary variable assignment.

Kept the reviewed and Tested by tag for patch#1,
as there was no code change.

Depends on patch[1] for the error handling to be complete.

[1] https://lkml.org/lkml/2016/5/9/447

Sricharan R (2):
  i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is enabled
  i2c: qup: Fix error handling

 drivers/i2c/busses/i2c-qup.c | 129 +++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 71 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
