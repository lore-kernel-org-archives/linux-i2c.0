From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: i2c bus multiplexing (Version 1).
Date: Wed, 28 Jan 2009 22:14:32 +0100
Message-ID: <1233177275-21700-1-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch set adds to the I2C core the ability to handle multiplexed I2C bus
topologies by presenting each multiplexed segment as a I2C adapter.

Rodolfo

--

 b/drivers/i2c/Kconfig         |   10 +
 b/drivers/i2c/Makefile        |    3 
 b/drivers/i2c/i2c-core.c      |    4 
 b/drivers/i2c/i2c-mux.c       |  180 +++++++++++++++++++++++
 b/drivers/i2c/muxes/Kconfig   |    8 +
 b/drivers/i2c/muxes/Makefile  |    6 
 b/drivers/i2c/muxes/pca954x.c |  325 ++++++++++++++++++++++++++++++++++++++++++
 b/include/linux/i2c-id.h      |    3 
 b/include/linux/i2c.h         |   14 +
 b/include/linux/i2c/pca954x.h |   13 +
 drivers/i2c/muxes/Kconfig     |    9 +
 drivers/i2c/muxes/Makefile    |    2 
 12 files changed, 574 insertions(+), 3 deletions(-)
