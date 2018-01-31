From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] i2c-qup: reduce verbosity on DMA channel not found messages
Date: Wed, 31 Jan 2018 10:54:59 -0600
Message-ID: <CAOZdJXVKZfzXgAYtbr4j9EfcCDPx7io_LNw08aiCyYX9ZALdMQ@mail.gmail.com>
References: <1516138534-30842-1-git-send-email-austinwc@codeaurora.org> <1516138534-30842-2-git-send-email-austinwc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbeAaQzC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 31 Jan 2018 11:55:02 -0500
In-Reply-To: <1516138534-30842-2-git-send-email-austinwc@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Austin Christ <austinwc@codeaurora.org>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>

On Tue, Jan 16, 2018 at 3:35 PM, Austin Christ <austinwc@codeaurora.org> wrote:
> From: Sinan Kaya <okaya@codeaurora.org>
>
> QDF2400 product doesn't have any BAM DMA attached to the I2C channel. This
> causes code to spit an unnecessary error message during boot.

If that's the case, then qup->is_dma should be false, and then this
code should never be executed.

Wouldn't it be better if qup_i2c_probe() is modified to detect a
QDF2400 and not even try to enable DMA?  There's already code like
that for device tree:

    if (of_device_is_compatible(pdev->dev.of_node, "qcom,i2c-qup-v1.1.1")) {
        qup->adap.algo = &qup_i2c_algo;
        qup->adap.quirks = &qup_i2c_quirks;
    else
    ...
        qup->adap.algo = &qup_i2c_algo_v2;
        ret = qup_i2c_req_dma(qup);

On QDF2400, you should never be calling qup_i2c_req_dma() in the first place.
