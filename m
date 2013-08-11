From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 3.11
Date: Sun, 11 Aug 2013 11:55:25 +0200
Message-ID: <20130811095525.GA7926@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Linus,

here are some driver bugfixes for the I2C subsystem. Please pull.

Thanks,

   Wolfram


The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:

  Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to f480adaf1b7130ad43760f627b762f771fcfc5f5:

  i2c: mv64xxx: Document the newly introduced allwinner compatible (2013-08-07 16:57:53 +0200)

----------------------------------------------------------------
Fabio Estevam (1):
      i2c: i2c-mxs: Use DMA mode even for small transfers

Maxime Ripard (1):
      i2c: mv64xxx: Document the newly introduced allwinner compatible

Michael Brunner (1):
      i2c: Fix Kontron PLD prescaler calculation

 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt |    2 +-
 drivers/i2c/busses/i2c-kempld.c                       |    4 ++--
 drivers/i2c/busses/i2c-mxs.c                          |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
