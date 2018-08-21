From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] i2c: remove deprecated attach_adapter callback
Date: Tue, 21 Aug 2018 17:02:38 +0200
Message-ID: <20180821150240.19964-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

So, I wanted to do this in the next cycle, but Linus seems to want it this
cycle already [1], so here it is:

Remove the attach_adapter callback from the 2.4 times by converting
the last user to a custom probing mechanism based on deferred probing. We used
this already in commit ac397c80de89 ("ALSA: ppc: keywest: drop using attach
adapter") successfully on HW, so we agreed to use it on the windtunnel driver
as well.

With the last user gone, we can then remove the callback \o/ I think this
allows for more cleanup in the core, but let's do this later and focus on the
removal for now.

Tested on a Renesas R-Car Salvator-XS board (M3N) by using and rebinding
various I2C busses. Build bot and checkpatch are happy, too.

I'd like to send a pull request to Linus this merge window, so looking forward
to super fast comments, acks, etc...

Thanks,

   Wolfram

[1] http://patchwork.ozlabs.org/patch/959322/#1976742

Wolfram Sang (2):
  macintosh: therm_windtunnel: drop using attach_adapter
  i2c: remove deprecated attach_adapter callback

 drivers/i2c/i2c-core-base.c          | 11 +----------
 drivers/macintosh/therm_windtunnel.c | 25 +++++++++++++++++++++++--
 include/linux/i2c.h                  |  6 ------
 3 files changed, 24 insertions(+), 18 deletions(-)

-- 
2.11.0
