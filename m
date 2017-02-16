From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 0/3] ARM64: bcm2837-rpi: Fix random crashes caused by i2c
Date: Thu, 16 Feb 2017 21:20:44 +0000
Message-ID: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:50280 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbdBPVVs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Feb 2017 16:21:48 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Robinson <pbrobinson@gmail.com>
Cc: Martin Sperl <kernel@martin.sperl.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This patch series tries to fix the random crashes [1] which occur on the RPi 3.

The first patch fix the possible NULL pointer dereference and the rest tries
to fix the root cause of the unexpected interrupts.

Btw this should also fix the random i2c timeouts:

i2c-bcm2835 3f805000.i2c: i2c transfer timed out

In absence of a RPi 3 this is only compile tested.

[1] - https://github.com/anholt/linux/issues/89

Stefan Wahren (3):
  i2c: bcm2835: Avoid possible NULL ptr dereference
  ARM64: bcm2837: remove link to bcm2835
  ARM64: bcm2837-rpi: Fix pwm and i2c pin control

 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi    |    1 -
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts |    2 +-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi    |   89 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-bcm2835.c                 |    4 +-
 4 files changed, 93 insertions(+), 3 deletions(-)
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi

-- 
1.7.9.5
