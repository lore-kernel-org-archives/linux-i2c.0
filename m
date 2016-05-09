From: Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 0/2] i2c: qup: Fixed the DMA transfer errors
Date: Mon,  9 May 2016 18:14:29 +0530
Message-ID: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
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
To: agross@codeaurora.org
Cc: architt@codeaurora.org, wsa@the-dreams.de, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>, linux-i2c@vger.kernel.org, andy.gross@linaro.org, sricharan@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

These patches contain the I2C QUP (Qualcomm Universal Peripheral) DMA
related fixes. The first patch cleared the error bits in ISR, which
resolves the kernel hang for I2C bus errors and DMA transfer. The
second patch fixed the DMA segments length, which resolves the issue
for I2C transfer failure over 255 bytes.

Abhishek Sahu (2):
  drivers: i2c: qup: Cleared the error bits in ISR
  drivers: i2c: qup: Fixed the DMA segments length

 drivers/i2c/busses/i2c-qup.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
