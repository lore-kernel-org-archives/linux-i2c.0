From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/5] Blackfin I2C updates
Date: Mon, 22 Mar 2010 03:23:15 -0400
Message-ID: <1269242600-30147-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

There were posted a few months ago, but seem to have stalled.

These can also be pulled from:
	  git://git.kernel.org/pub/scm/linux/kernel/git/vapier/blackfin.git for-i2c

Michael Hennerich (1):
  i2c-bfin-twi: add debug output for error status

Sonic Zhang (4):
  i2c-bfin-twi: integrate timeout timer with completion interface
  i2c-bfin-twi: fix lost interrupts at high speeds
  i2c-bfin-twi: remove redundant retry
  i2c-bfin-twi: return completion in interrupt for smbus quick
    transfers

 drivers/i2c/busses/i2c-bfin-twi.c |  168 +++++++++++++++++--------------------
 1 files changed, 78 insertions(+), 90 deletions(-)
