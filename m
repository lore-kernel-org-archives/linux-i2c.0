From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 0/2] i2c: sh_mobile: don't regress on deferred probing
Date: Wed, 10 Dec 2014 14:21:47 +0100
Message-ID: <1418217709-26392-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

Okay, here is my take on solving the problem found by Geert. I still don't like
it much but it is not as bad as I expected it to be ;) Let me know what you
think.

Thanks,

   Wolfram


Wolfram Sang (2):
  i2c: sh_mobile: refactor DMA setup
  i2c: sh_mobile: rework deferred probing

 drivers/i2c/busses/i2c-sh_mobile.c | 111 ++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 58 deletions(-)

-- 
2.1.3

