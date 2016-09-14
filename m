From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] i2c: meson: add gxbb compatible string
Date: Wed, 14 Sep 2016 11:49:15 +0200
Message-ID: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38022 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbcINJtX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Sep 2016 05:49:23 -0400
Received: by mail-wm0-f47.google.com with SMTP id 1so19828908wmz.1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Sep 2016 02:49:22 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>

This patchset adds a specific compatible string in the Meson I2C driver
for the Amlogic Meson gxbb SoC.

Other patch series (pinctrl and device tree) are being sent to complete
the i2c support on meson gxbb

Neil Armstrong (2):
  i2c: meson: add gxbb compatible string
  dt-bindings: i2c-meson: add gxbb compatible string

 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 2 +-
 drivers/i2c/busses/i2c-meson.c                      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4
