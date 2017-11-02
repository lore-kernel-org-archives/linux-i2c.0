From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT 0/5] i2c: sh_mobile: refactor HW init/deinit
Date: Thu,  2 Nov 2017 13:47:26 +0100
Message-ID: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33841 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbdKBMrl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 2 Nov 2017 08:47:41 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jacopo Mondi <jacopo@jmondi.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

When clearing the ICE bit, all registers fall back to their defaut value. That
allows for some simplifications in the code.

Tested on a Renesas Lager board (R-Car H2) doing a bunch of consecutive
commands. No spurious interrupts have been observed and the signals look
exactly the same when visualized with sigrok.

According to the docs, the ICE bit behaviour is the same since the beginning of
this driver (sh7722) for the migo-r board.

jacopo: can you please test this series while you work on migo-r anyhow? Thank
you a ton for that!

Looking forward to other comments, as well...


Wolfram Sang (5):
  i2c: sh_mobile: remove redundant initialization
  i2c: sh_mobile: remove redundant deinitialization
  i2c: sh_mobile: manually "inline" two short functions
  i2c: sh_mobile: use direct writes when accessing ICE bit
  i2c: sh_mobile: shorten exit of xfer routine

 drivers/i2c/busses/i2c-sh_mobile.c | 50 +++++++++-----------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

-- 
2.11.0
