From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 00/12] i2c: meson: series with improvements
Date: Wed, 8 Mar 2017 07:41:21 +0100
Message-ID: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34003 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755447AbdCHGl4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 01:41:56 -0500
Received: by mail-wr0-f194.google.com with SMTP id u48so2838480wrc.1
        for <linux-i2c@vger.kernel.org>; Tue, 07 Mar 2017 22:41:33 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

This patch series includes several improvements for the i2c-meson
driver.

Heiner Kallweit (12):
  i2c: meson: use min instead of min_t where min_t isn't needed
  i2c: meson: remove member irq from struct meson_i2c
  i2c: meson: use i2c core for DT clock-frequency parsing
  i2c: meson: use full 12 bits for clock divider
  i2c: meson: set clock divider in probe instead of setting it for each transfer
  i2c: meson: remove variable count from meson_i2c_xfer
  i2c: meson: improve interrupt handler and detect spurious interrupts
  i2c: meson: explicitly ignore messages with length zero
  i2c: meson: don't create separate token chain just for the stop command
  i2c: meson: remove meson_i2c_write_tokens
  i2c: meson: improve and simplify interrupt handler
  i2c: meson: use state in meson_i2c_prepare_xfer

 drivers/i2c/busses/i2c-meson.c | 157 ++++++++++++++++-------------------------
 1 file changed, 62 insertions(+), 95 deletions(-)

-- 
2.12.0
