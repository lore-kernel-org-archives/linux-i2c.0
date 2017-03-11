From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 00/10] i2c: meson: series with improvements
Date: Sat, 11 Mar 2017 18:48:02 +0100
Message-ID: <a0ebd65b-712d-2b15-dcc6-3b8a9a619770@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32845 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755386AbdCKRsU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 11 Mar 2017 12:48:20 -0500
Received: by mail-wr0-f195.google.com with SMTP id g10so15199505wrg.0
        for <linux-i2c@vger.kernel.org>; Sat, 11 Mar 2017 09:48:18 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

This patch series includes several improvements for the i2c-meson
driver.

Changes in v2:
- removed patches 8 and 12
- removed one small change in patch 6
- don't print error message in patch 7

Changes in v3:
- changed order of patches 3, 4, 5 what makes the patches more simple
- remove one change from patch 7 to still properly deal with timeouts

Heiner Kallweit (12):
  i2c: meson: use min instead of min_t where min_t isn't needed
  i2c: meson: remove member irq from struct meson_i2c
  i2c: meson: set clock divider in probe instead of setting it for each transfer
  i2c: meson: use i2c core for DT clock-frequency parsing
  i2c: meson: use full 12 bits for clock divider
  i2c: meson: remove variable count from meson_i2c_xfer
  i2c: meson: improve interrupt handler and detect spurious interrupts
  i2c: meson: don't create separate token chain just for the stop command
  i2c: meson: remove meson_i2c_write_tokens
  i2c: meson: improve and simplify interrupt handler

 drivers/i2c/busses/i2c-meson.c | 132 ++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 82 deletions(-)

-- 
2.12.0
