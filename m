From: Juergen Fitschen <me@jue.yt>
Subject: [PATCH RFC 0/4] i2c: at91: slave mode support
Date: Fri, 27 Oct 2017 17:10:58 +0200
Message-ID: <cover.1509112910.git.me@jue.yt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from srv1.host37.de ([176.28.54.59]:34402 "EHLO srv1.host37.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932195AbdJ0PLC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 27 Oct 2017 11:11:02 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Based on the discussion we had on the i2c-linux list [1], I wrote a patch for
AT91 hardware and tried to fulfill the Linux I2C slave interface description
[2] as good as possible. This enables aforementioned hardware to act as an I2C
slave that can be accessed by a remote I2C master.

I have tested this patchset successfully on an ATSAMA5D27 with the
i2c-slave-eeprom backend for some time and I'm convinced that it works stable
enough to be reviewed by you.

Since I am a newcomer to kernel coding, I really would like to hear your
comments on this patchset.

[1] https://marc.info/?t=150824004800001&r=1&w=1
[2] https://www.kernel.org/doc/Documentation/i2c/slave-interface

Juergen Fitschen (4):
  i2c: at91: segregate master mode specific code from probe and init
    func
  i2c: at91: split driver into core and master file
  i2c: at91: added slave mode support
  i2c: at91: take slave mode capabilities of hardware into account

 MAINTAINERS                          |    3 +-
 drivers/i2c/busses/Makefile          |    4 +
 drivers/i2c/busses/i2c-at91-core.c   |  390 +++++++++++
 drivers/i2c/busses/i2c-at91-master.c |  804 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-at91-slave.c  |  147 ++++
 drivers/i2c/busses/i2c-at91.c        | 1243 ----------------------------------
 drivers/i2c/busses/i2c-at91.h        |  184 +++++
 7 files changed, 1531 insertions(+), 1244 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-at91-core.c
 create mode 100644 drivers/i2c/busses/i2c-at91-master.c
 create mode 100644 drivers/i2c/busses/i2c-at91-slave.c
 delete mode 100644 drivers/i2c/busses/i2c-at91.c
 create mode 100644 drivers/i2c/busses/i2c-at91.h
