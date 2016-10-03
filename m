From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v4 0/7] i2c: bcm2835: Bring in changes from downstream
Date: Mon,  3 Oct 2016 22:06:07 +0200
Message-ID: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.55]:45716 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbcJCUGo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 3 Oct 2016 16:06:44 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, swarren@wwwdotorg.org, eric@anholt.net
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>

This patchset tries to bring in the lessons learned in the downstream
driver i2c-bcm2708. The downstream clock stretcing timeout patch has
been left out since clock stretching is broken/unreliable on this
controller, so no point in setting it.

Changes since version 3:
- Add comment about I2C_C_CLEAR on error

Noralf.


Noralf Trønnes (7):
  i2c: bcm2835: Fix hang for writing messages larger than 16 bytes
  i2c: bcm2835: Protect against unexpected TXW/RXR interrupts
  i2c: bcm2835: Use dev_dbg logging on transfer errors
  i2c: bcm2835: Can't support I2C_M_IGNORE_NAK
  i2c: bcm2835: Add support for Repeated Start Condition
  i2c: bcm2835: Support i2c-dev ioctl I2C_TIMEOUT
  i2c: bcm2835: Add support for dynamic clock

 drivers/i2c/busses/i2c-bcm2835.c | 218 +++++++++++++++++++++++++--------------
 1 file changed, 139 insertions(+), 79 deletions(-)

--
2.8.2
