From: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH v2 0/1 resend] ARM: shmobile: r8a7790: add I2C support
Date: Mon,  5 Aug 2013 16:19:33 +0900
Message-ID: <1375687174-577-1-git-send-email-nv-dung@jinso.co.jp>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram
CC Morimoto

Please consider the following patch for the r8a7790 Soc.
This patch modify I2C driver of rcar-H1 to usable on both rcar-H1 and rcar-H2.
It was developed base on the renesas-next-20130528 branch and 
have tested on the Lager board.
Input clock of I2C is peripheral module clock that is named peripheral_clk.

V2: dropped patches 2,3,4 from the previous version.

Thanks,
Nguyen viet Dung

Nguyen Viet Dung (1):
  i2c: rcar: modify I2C driver

 drivers/i2c/busses/i2c-rcar.c |   17 +++++++++++++++--
 include/linux/i2c/i2c-rcar.h  |    4 ++++
 2 files changed, 19 insertions(+), 2 deletions(-)

-- 
1.7.9.5
