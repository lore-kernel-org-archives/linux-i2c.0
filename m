Return-Path: <SRS0=QTNc=DI=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E897C4727E
	for <linux-i2c@archiver.kernel.org>; Thu,  1 Oct 2020 08:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F40220B1F
	for <linux-i2c@archiver.kernel.org>; Thu,  1 Oct 2020 08:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJAIpJ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 1 Oct 2020 04:45:09 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:45387 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbgJAIpI (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 1 Oct 2020 04:45:08 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Oct 2020 01:45:07 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Oct 2020 01:45:06 -0700
X-QCInternal: smtphost
Received: from c-rojay-linux.qualcomm.com ([10.206.21.80])
  by ironmsg02-blr.qualcomm.com with ESMTP; 01 Oct 2020 14:14:29 +0530
Received: by c-rojay-linux.qualcomm.com (Postfix, from userid 88981)
        id 9989D22A4; Thu,  1 Oct 2020 14:14:28 +0530 (IST)
From:   Roja Rani Yarubandi <rojay@codeaurora.org>
To:     wsa@kernel.org
Cc:     swboyd@chromium.org, dianders@chromium.org,
        saiprakash.ranjan@codeaurora.org, gregkh@linuxfoundation.org,
        mka@chromium.org, akashast@codeaurora.org,
        msavaliy@qti.qualcomm.com, skakit@codeaurora.org,
        vkaur@codeaurora.org, pyarlaga@codeaurora.org,
        rnayak@codeaurora.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: [PATCH V5 0/3] Implement Shutdown callback for geni-i2c
Date:   Thu,  1 Oct 2020 14:14:22 +0530
Message-Id: <20201001084425.23117-1-rojay@codeaurora.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

 - As per Stephen's comments prepared separate patches for rx/tx
   transfer cleanup and shutdown callback

Roja Rani Yarubandi (3):
  soc: qcom: geni: Remove "iova" check
  i2c: i2c-qcom-geni: Store DMA mapping data in geni_i2c_dev struct
  i2c: i2c-qcom-geni: Add shutdown callback for i2c

 drivers/i2c/busses/i2c-qcom-geni.c | 101 ++++++++++++++++++++++++-----
 drivers/soc/qcom/qcom-geni-se.c    |   4 +-
 2 files changed, 87 insertions(+), 18 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

