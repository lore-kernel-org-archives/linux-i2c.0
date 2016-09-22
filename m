From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH 0/2] Fix warnings for i2c-rk3x.c
Date: Thu, 22 Sep 2016 19:29:22 +0800
Message-ID: <1474543764-51135-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:50954 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbcIVLaK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 22 Sep 2016 07:30:10 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: dianders@chromium.org, huangtao@rock-chips.com, wxt@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

David Wu (2):
  i2c: rk3x: Fix sparse warning
  i2c: rk3x: fix variable 'min_total_ns' unused warning

 drivers/i2c/busses/i2c-rk3x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
1.9.1
