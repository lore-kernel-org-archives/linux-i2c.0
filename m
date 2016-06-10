From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V4 2/3] i2c: qup: Fix wrong value of index variable
Date: Fri, 10 Jun 2016 23:45:37 +0530
Message-ID: <00af01d1c344$1cd02310$56706930$@codeaurora.org>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org> <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53871 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbcFJSPu (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 10 Jun 2016 14:15:50 -0400
In-Reply-To: <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
Content-Language: en-us
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org, absahu@codeaurora.org, wsa@the-dreams.de

+Wolfram Sang

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Sricharan R
>Sent: Friday, June 10, 2016 11:38 PM
>To: linux-arm-msm@vger.kernel.org; ntelkar@codeaurora.org; galak@codeaurora.org; linux-kernel@vger.kernel.org;
>andy.gross@linaro.org; linux-i2c@vger.kernel.org; agross@codeaurora.org; linux-arm-kernel@lists.infradead.org;
>nkaje@codeaurora.org; absahu@codeaurora.org
>Cc: sricharan@codeaurora.org
>Subject: [PATCH V4 2/3] i2c: qup: Fix wrong value of index variable
>
>index gets incremented during check to determine if the
>messages can be transferred with dma. But not reset after
>that, resulting in wrong start value in subsequent loop,
>causing failure. Fix it.
>
>Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>---
> drivers/i2c/busses/i2c-qup.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
>index 43adc2d..b8116e5 100644
>--- a/drivers/i2c/busses/i2c-qup.c
>+++ b/drivers/i2c/busses/i2c-qup.c
>@@ -1260,6 +1260,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
> 		}
> 	}
>
>+	idx = 0;
>+
> 	do {
> 		if (msgs[idx].len == 0) {
> 			ret = -EINVAL;
>--
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux
>Foundation
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
