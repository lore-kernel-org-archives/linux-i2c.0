From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] eeprom: at24: coding style fixes
Date: Wed,  6 Dec 2017 11:19:24 +0100
Message-ID: <20171206101926.14995-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35292 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754707AbdLFKTb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Dec 2017 05:19:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id f9so6206381wmh.0
        for <linux-i2c@vger.kernel.org>; Wed, 06 Dec 2017 02:19:30 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Just two patches fixing minor coding style issues. The first one
contains fixes for problems reported by checkpatch. The second adds
a common prefix to all symbols in at24.c.

Bartosz Golaszewski (2):
  eeprom: at24: fix coding style issues
  eeprom: at24: use a common prefix for all symbols in at24.c

 drivers/misc/eeprom/at24.c | 48 ++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

-- 
2.15.1
