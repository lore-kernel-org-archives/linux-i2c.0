From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 0/4] i2c: at91: add support for SDA HOLD
Date: Thu, 3 Dec 2015 10:53:49 +0100
Message-ID: <1449136434-27619-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:23315 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932468AbbLCJxe (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 3 Dec 2015 04:53:34 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>

Changes:
- from v1:
  - fix typos,
  - change MAX_HOLD macro to follow Nicolas' advice,
  - make it clear that sama5d2 also support i2c-sda-hold-time-ns.

Ludovic Desroches (4):
  i2c: at91: add support for the HOLD field
  i2c: at91: update bindings documention
  ARM: at91/dt: sama5d4: update i2c compatible string
  ARM: at91/dt: sama5d2 Xplained: pmic needs a specific sda hold time

 Documentation/devicetree/bindings/i2c/i2c-at91.txt |  5 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  1 +
 arch/arm/boot/dts/sama5d4.dtsi                     |  6 +--
 drivers/i2c/busses/i2c-at91.c                      | 53 ++++++++++++++++++++--
 4 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.5.0
