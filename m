From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] i2c: sh_mobile: handle deferred probe properly when requesting DMA channels
Date: Tue, 16 Dec 2014 13:31:24 +0100
Message-ID: <1418733086-26324-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-i2c@vger.kernel.org

Here is the resend of my RFC series. Only patch description updates and
whitespace fixes since then. But it seems we agreed on this approach based on
the discussions so far: Geert's discovery [1], the RFC [2]. See there for a
complete description.


[1] http://thread.gmane.org/gmane.linux.drivers.i2c/20565/focus=41758
[2] http://thread.gmane.org/gmane.linux.ports.sh.devel/41806

Wolfram Sang (2):
  i2c: sh_mobile: refactor DMA setup
  i2c: sh_mobile: rework deferred probing

 drivers/i2c/busses/i2c-sh_mobile.c | 111 ++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 58 deletions(-)

-- 
2.1.3

