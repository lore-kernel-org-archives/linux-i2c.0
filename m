From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 0/2] davinci i2c fixes for 2.6.31
Date: Mon,  6 Jul 2009 15:48:34 -0700
Message-ID: <1246920516-31462-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Here are a couple fixes for the i2c driver on the TI DaVinci family
of SoCs.  These have been tested for awhile in the DaVinci git
repo are needed for 2.6.31.

These apply on v2.6.31-rc2.

David Brownell (1):
  i2c-davinci: behave with i2cdetect

Kevin Hilman (1):
  i2c-davinci: convert clock usage after clkdev conversion

 drivers/i2c/busses/i2c-davinci.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)
