From: Romain Perier <romain.perier@free-electrons.com>
Subject: [PATCH v6 0/4] Add basic support for the I2C units of the Armada 3700
Date: Wed, 30 Nov 2016 15:00:13 +0100
Message-ID: <20161130140017.26307-1-romain.perier@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57640 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756796AbcK3OA3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Nov 2016 09:00:29 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw>

This series add basic support for the I2C bus interface units present
in the Armada 3700 to the pxa-i2c driver. It also add the definitions of
the device nodes to the devicetree at the SoC level and for its official
development board: the Armada 3720 DB.

Romain Perier (4):
  i2c: pxa: Add definition of fast and high speed modes via the regs
    layout
  i2c: pxa: Add support for the I2C units found in Armada 3700
  arm64: dts: marvell: Add I2C definitions for the Armada 3700
  dt-bindings: i2c: pxa: Update the documentation for the Armada 3700

 Documentation/devicetree/bindings/i2c/i2c-pxa.txt |  1 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts    |  4 ++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi      | 18 ++++++++++++++++
 drivers/i2c/busses/Kconfig                        |  2 +-
 drivers/i2c/busses/i2c-pxa.c                      | 26 +++++++++++++++++++++--
 5 files changed, 48 insertions(+), 3 deletions(-)

-- 
2.9.3
