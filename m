From: Naveen Kaje <nkaje@codeaurora.org>
Subject: Re: [PATCH 0/2] drivers: i2c: qup: Some misc fixes
Date: Wed,  4 May 2016 12:53:59 -0600
Message-ID: <1462388039-8518-1-git-send-email-nkaje@codeaurora.org>
References: <1462166637-16778-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462166637-16778-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sricharan@codeaurora.org, dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@vger.kernel.org
Cc: Naveen Kaje <nkaje@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

From: Naveen Kaje <nkaje@codeaurora.org>

Hi Sricharan,
I tested these changes. They did not cause any regressions on QDF2432. Note that QDF2432 does not use DMA mode.
I based my patches (http://marc.info/?l=linux-i2c&m=146231797008963&w=2 and http://marc.info/?l=linux-i2c&m=146231798708969&w=2) on top of these fixes.
There are no merge conflicts.

Thanks,
Naveen

---

One for fixing the bug with CONFIG_DEBUG_SG enabled and another
to suspend the transfer for all errors instead of just for nack.

Sricharan R (2):
  drivers: i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is enabled.
  drivers: i2c: qup: Fix error handling

 drivers/i2c/busses/i2c-qup.c | 87 +++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 45 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

