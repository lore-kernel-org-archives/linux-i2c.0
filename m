From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v2 0/8] i2c: bcm2835: Bring in changes from downstream
Date: Tue, 27 Sep 2016 13:56:58 +0200
Message-ID: <1474977426-3272-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.55]:37006 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932876AbcI0L5w (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 27 Sep 2016 07:57:52 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, swarren@wwwdotorg.org, eric@anholt.net
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>

This patchset tries to bring in the lessons learned in the downstream
driver i2c-bcm2708. The downstream clock stretcing timeout patch has
been left out since clock stretching is broken/unreliable on this
controller, so no point in setting it.

This second version of the patchset has been expanded to try and
encompass all the differences between mainline and downstream.
Hopefully downstream can now start using this driver.

Thanks to Martin for jogging my memory with his comments which led to
the discovery that interrupt could be used instead of polling for the
Transfer Active state.

Noralf.


Noralf Trønnes (8):
  i2c: bcm2835: Fix hang for writing messages larger than 16 bytes
  i2c: bcm2835: Protect against unexpected TXW/RXR interrupts
  i2c: bcm2835: Use ratelimited logging on transfer errors
  i2c: bcm2835: Can't support I2C_M_IGNORE_NAK
  i2c: bcm2835: Add support for Repeated Start Condition
  i2c: bcm2835: Support i2c-dev ioctl I2C_TIMEOUT
  i2c: bcm2835: Add support for dynamic clock
  ARM: bcm2835: Disable i2c2 in the Device Tree

 arch/arm/boot/dts/bcm2835-rpi.dtsi |   4 -
 drivers/i2c/busses/i2c-bcm2835.c   | 210 +++++++++++++++++++++++--------------
 2 files changed, 131 insertions(+), 83 deletions(-)

--
2.8.2
