From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c-fixes
Date: Mon, 18 Oct 2010 01:31:11 +0100
Message-ID: <E1P7dd9-0006Jv-Rv@ben-laptop>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 2b666ca4a68cbc22483b0f2e1ba3c0e59b01ae9e:
  Linus Torvalds (1):
        Merge branch 'fix/misc' of git://git.kernel.org/.../tiwai/sound-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c/2636-rc8

Jon Povey (1):
      i2c-davinci: Fix TX setup for more SoCs

Marc Kleine-Budde (1):
      i2c-imx: do not allow interruptions when waiting for I2C to complete

 drivers/i2c/busses/i2c-davinci.c |   24 +++++++++++++++---------
 drivers/i2c/busses/i2c-imx.c     |   12 +++---------
 2 files changed, 18 insertions(+), 18 deletions(-)
