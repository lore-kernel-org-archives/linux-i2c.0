From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 0/4] i2c: slave: API updates
Date: Mon, 23 Mar 2015 09:26:35 +0100
Message-ID: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

So, after some more thoughts and people using the slave framework, some API
updates seemed in place. Also, the documentation is now here. Please read the
patch description for details. Thanks to all people joining the discussion,
especially Uwe and Geert!

Changes since V1:

* added acks, except for patch 2 which has too many changes to keep them IMO
* reworded/updated the issues found in patch 2
* added patch 4

Wolfram Sang (4):
  i2c: slave: rework the slave API
  Documentation: i2c: describe the new slave mode
  i2c: slave: add documentation for i2c-slave-eeprom
  i2c: slave-eeprom: add more info when to increase the pointer

 Documentation/i2c/slave-eeprom-backend |  14 +++
 Documentation/i2c/slave-interface      | 179 +++++++++++++++++++++++++++++++++
 Documentation/i2c/summary              |   4 -
 drivers/i2c/busses/i2c-rcar.c          |  10 +-
 drivers/i2c/i2c-slave-eeprom.c         |  18 ++--
 include/linux/i2c.h                    |   8 +-
 6 files changed, 213 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/i2c/slave-eeprom-backend
 create mode 100644 Documentation/i2c/slave-interface

-- 
2.1.4

