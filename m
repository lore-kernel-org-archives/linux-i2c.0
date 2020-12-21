Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4156BC43381
	for <linux-i2c@archiver.kernel.org>; Mon, 21 Dec 2020 12:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0439522CA1
	for <linux-i2c@archiver.kernel.org>; Mon, 21 Dec 2020 12:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgLUMjm (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 21 Dec 2020 07:39:42 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:8429 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLUMjl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Dec 2020 07:39:41 -0500
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Dec 2020 04:38:47 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Dec 2020 04:38:45 -0800
X-QCInternal: smtphost
Received: from c-rojay-linux.qualcomm.com ([10.206.21.80])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Dec 2020 18:08:06 +0530
Received: by c-rojay-linux.qualcomm.com (Postfix, from userid 88981)
        id 5BDCD1ADD; Mon, 21 Dec 2020 18:08:05 +0530 (IST)
From:   Roja Rani Yarubandi <rojay@codeaurora.org>
To:     wsa@kernel.org
Cc:     swboyd@chromium.org, dianders@chromium.org,
        saiprakash.ranjan@codeaurora.org, gregkh@linuxfoundation.org,
        mka@chromium.org, akashast@codeaurora.org,
        msavaliy@qti.qualcomm.com, skakit@codeaurora.org,
        pyarlaga@codeaurora.org, rnayak@codeaurora.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: [PATCH V7 0/2] Implement Shutdown callback for geni-i2c
Date:   Mon, 21 Dec 2020 18:07:59 +0530
Message-Id: <20201221123801.26643-1-rojay@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi,

Posting V7 with comments answering.

Roja Rani Yarubandi (2):
  i2c: i2c-qcom-geni: Store DMA mapping data in geni_i2c_dev struct
  i2c: i2c-qcom-geni: Add shutdown callback for i2c

 drivers/i2c/busses/i2c-qcom-geni.c | 94 +++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 16 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

