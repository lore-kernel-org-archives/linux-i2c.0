From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/6] R-Car D3 (r8a77995) I2C integration
Date: Wed, 15 Nov 2017 16:25:20 +0100
Message-ID: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37207 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbdKOPZa (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 15 Nov 2017 10:25:30 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, horms@verge.net.au, wsa@the-dreams.de, geert@linux-m68k.org
Cc: magnus.damm@gmail.com, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

This adds I2C controllers to the D3 device tree and enables I2C busses 0
and 1 on the Draak board. (I2C2 is not connected on that board.)

Includes missing pins, DMA support and the Draak's serial EEPROM.

CU
Uli


Ulrich Hecht (6):
  pinctrl: sh-pfc: r8a77995: add missing pins SCL0 and SDA0 to pinmux
    data
  i2c: rcar: enable for R-Car D3 (r8a77995)
  arm64: renesas: r8a77995: add I2C support
  arm64: renesas: draak: enable I2C controller 0 and EEPROM
  arm64: renesas: draak: enable I2C controller 1
  i2c: rcar: document R8A77970 bindings

 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |  1 +
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 28 ++++++++++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 64 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-rcar.c                      |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c              |  2 +
 5 files changed, 96 insertions(+)

-- 
2.7.4
