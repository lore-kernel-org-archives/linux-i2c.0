From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V4 0/3] i2c: qup: Some misc fixes
Date: Fri, 10 Jun 2016 23:43:01 +0530
Message-ID: <00a501d1c343$c03e2b60$40ba8220$@codeaurora.org>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org, absahu@codeaurora.org, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

+Wolfram. Sorry Missed.

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Sricharan R
>Sent: Friday, June 10, 2016 11:38 PM
>To: linux-arm-msm@vger.kernel.org; ntelkar@codeaurora.org; galak@codeaurora.org; linux-kernel@vger.kernel.org;
>andy.gross@linaro.org; linux-i2c@vger.kernel.org; agross@codeaurora.org; linux-arm-kernel@lists.infradead.org;
>nkaje@codeaurora.org; absahu@codeaurora.org
>Cc: sricharan@codeaurora.org
>Subject: [PATCH V4 0/3] i2c: qup: Some misc fixes
>
>One for fixing the bug with CONFIG_DEBUG_SG enabled, another
>to suspend the transfer for all errors instead of just for NACK
>and one for correcting the wrong initial value for index variable.
>
>[V4] Added little more description to patch#1 and split a
>     change in to a new patch.
>
>[V3] Added more commit description. Return more appropriate
>     error codes for NACK and other bus errors. Corrected
>     other bus errors handling procedure for dma mode as well.
>     Removed the dev_err log for NACKs.
>
>[V2] Removed the use of unnecessary variable assignment.
>
>Kept the reviewed and Tested by tag for patch#1,
>as there was no code change.
>
>Depends on patch[1] for the error handling to be complete.
>
>[1] https://lkml.org/lkml/2016/5/9/447
>
>Sricharan R (3):
>  i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is enabled
>  i2c: qup: Fix wrong value of index variable
>  i2c: qup: Fix error handling
>
> drivers/i2c/busses/i2c-qup.c | 128 ++++++++++++++++++++-----------------------
> 1 file changed, 58 insertions(+), 70 deletions(-)
>
>--
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux
>Foundation
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
