From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/14] Various updates to the Nomadik I2C controller v2
Date: Fri, 13 May 2011 12:28:48 +0200
Message-ID: <1305282528-20499-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is an interation of the previous patch set that hopefully
adress Ben's comments: we took some runtime PM hooks out and
added a refactoring on the tail.

Actually the last patch fixing the platform config can be fed into the
I2C tree as well, if subsys maintainers are comfortable with it. I
won't be changing much stuff in the ux500 in this merge window due to
kernel consolidations taking place.

Jonas Aberg (1):
  i2c/i2c-nomadik: add regulator support

Linus Walleij (3):
  i2c/i2c-nomadik: fix speed enumerator
  i2c/i2c-nomadik: break out single messsage transmission
  mach-ux500: set proper I2C platform data from MOP500s

Rabin Vincent (1):
  i2c/i2c-nomadik: use pm_runtime API

Virupax Sadashivpetimath (8):
  i2c/i2c-nomadik: make i2c timeout specific per i2c bus
  i2c/i2c-nomadik: corrrect returned error numbers
  i2c/i2c-nomadik: correct adapter timeout initialization
  i2c/i2c-nomadik: print abort cause only on abort tag
  i2c/i2c-nomadik: add code to retry on timeout failure
  i2c/i2c-nomadik: change the TX and RX threshold
  i2c/i2c-nomadik: remove the unnecessary delay
  i2c/i2c-nomadik: reset the hw after status check

srinidhi kasagar (1):
  i2c/i2c-nomadik: remove the redundant error message

 arch/arm/mach-ux500/board-mop500.c       |   14 +-
 arch/arm/plat-nomadik/include/plat/i2c.h |    8 +-
 drivers/i2c/busses/i2c-nomadik.c         |  276 ++++++++++++++++++++----------
 3 files changed, 197 insertions(+), 101 deletions(-)

-- 
1.7.5.1
