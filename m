From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH 0/2] drivers: i2c: qup: Some misc fixes
Date: Mon,  2 May 2016 10:53:55 +0530
Message-ID: <1462166637-16778-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43837 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbcEBFYI (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 2 May 2016 01:24:08 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: sricharan@codeaurora.org

One for fixing the bug with CONFIG_DEBUG_SG enabled and another
to suspend the transfer for all errors instead of just for nack.

Sricharan R (2):
  drivers: i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is enabled.
  drivers: i2c: qup: Fix error handling

 drivers/i2c/busses/i2c-qup.c | 87 +++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 45 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
