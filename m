From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/1] eeprom: at24: switch to device-managed version of
 i2c_new_dummy
Date: Mon, 4 Dec 2017 20:49:23 +0100
Message-ID: <cad1fbce-58b8-c99e-7b7c-b4978c8f8f92@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39129 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdLDTtb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Dec 2017 14:49:31 -0500
Received: by mail-wr0-f195.google.com with SMTP id a41so16744681wra.6
        for <linux-i2c@vger.kernel.org>; Mon, 04 Dec 2017 11:49:30 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Some time ago I submitted a patch for introducing a device-managed
version of i2c_new_dummy [1]. It was not applied yet because a
use case was missing. Recent changes to the at24 driver now allow
to make use of devm_i2c_new_dummy.

[1]
https://patchwork.ozlabs.org/patch/804276/

Heiner Kallweit (1):
  eeprom: at24: switch to device-managed version of i2c_new_dummy

 drivers/misc/eeprom/at24.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

-- 
2.15.1
