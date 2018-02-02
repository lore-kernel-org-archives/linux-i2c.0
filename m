From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] i2c: qup: Add shutdown method
Date: Fri, 2 Feb 2018 15:36:26 -0800
Message-ID: <20180202233626.GA9465@builder>
References: <1516138534-30842-1-git-send-email-austinwc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46041 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeBBXg3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Feb 2018 18:36:29 -0500
Received: by mail-pl0-f67.google.com with SMTP id p5so7323089plo.12
        for <linux-i2c@vger.kernel.org>; Fri, 02 Feb 2018 15:36:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1516138534-30842-1-git-send-email-austinwc@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Austin Christ <austinwc@codeaurora.org>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org

On Tue 16 Jan 13:35 PST 2018, Austin Christ wrote:

> This shutdown method disables I2C to avoid corrupting a new kernel
> started with kexec.
> 

Can you elaborate on the issue you're seeing here? In what way is the
i2c-qup driver special, will there be similar patches for all other
drivers in the system?

Regards,
Bjorn
