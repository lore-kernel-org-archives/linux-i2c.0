From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: i2c: xiic: Strange clk_prepare_enable() in xiic_i2c_remove()
Date: Sat, 17 Dec 2016 00:54:45 +0300
Message-ID: <1481925285-594-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:55512 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757526AbcLPVy7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Dec 2016 16:54:59 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhraj@xilinx.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Rob Herring <robh@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

Dear Shubhrajyoti,

Looking at 36ecbcab84d0 ("i2c: xiic: Implement power management")
it is not clear why clk_prepare_enable(i2c->clk) is required in
xiic_i2c_remove()?

It is enabled in xiic_i2c_probe() and disabled/enabled in
cdns_i2c_runtime_suspend()/cdns_i2c_runtime_resume().

Could you please clarify the point.

--
Alexey Khoroshilov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
