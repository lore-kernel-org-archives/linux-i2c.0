From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Subject: [PATCH v4 0/1] ARM: shmobile: r8a7790: add I2C support
Date: Thu, 29 Aug 2013 18:36:34 +0900
Message-ID: <1377768995-13880-1-git-send-email-nv-dung@jinso.co.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc: linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram
CC Morimoto

Please consider the following patch for the r8a7790 Soc.
This patch modify I2C driver of rcar-H1 to usable on both rcar-H1 and rcar-H2.
It was developed base on the renesas-devel-20130722 branch and
have tested on the Lager board.

Thanks,
Nguyen viet Dung

Nguyen Viet Dung (1):
  i2c: rcar: modify I2C driver

 drivers/i2c/busses/i2c-rcar.c |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
1.7.9.5
