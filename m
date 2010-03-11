From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/03] i2c: i2c-sh_mobile update for SH-Mobile ARM
Date: Thu, 11 Mar 2010 19:05:26 +0900
Message-ID: <20100311100526.15227.50813.sendpatchset@t400s>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, nishimoto.hiroki@renesas.com, morimoto.kuninori@renesas.com, lethal@linux-sh.org, khali@linux-fr.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-i2c@vger.kernel.org

i2c: i2c-sh_mobile update for SH-Mobile ARM

[PATCH 01/03] i2c: i2c-sh_mobile register access code break out
[PATCH 02/03] i2c: i2c-sh_mobile support for new ICIC bits
[PATCH 03/03] i2c: i2c-sh_mobile kconfig update for SH-Mobile ARM

These patches add support for a newer version of the IIC block
to the i2c-sh_mobile and enables the driver on SH-Mobile ARM.

Perhaps suitable for the SH tree?

---

 drivers/i2c/busses/Kconfig         |    2 
 drivers/i2c/busses/i2c-sh_mobile.c |  121 ++++++++++++++++++++++++------------
 2 files changed, 85 insertions(+), 38 deletions(-)
