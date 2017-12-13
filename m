From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 0/2] eeprom: at24: coding style fixes
Date: Wed, 13 Dec 2017 11:56:22 +0100
Message-ID: <20171213105624.27058-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39788 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbdLMK4e (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 13 Dec 2017 05:56:34 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so4168961wmf.4
        for <linux-i2c@vger.kernel.org>; Wed, 13 Dec 2017 02:56:33 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joe Perches <joe@perches.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Just two patches fixing minor coding style issues. The first one
contains fixes for problems reported by checkpatch. The second adds
a common prefix to all symbols in at24.c.

v1 -> v2:
- don't break the user space: use module_param_named() for module
  parameters

v2 -> v3:
- s/at24_tool_until/at24_loop_until/g
- tweaked the commit message in patch 2/2

v3 -> v4:
- drop the octal permissions fix in module_param(): checkpatch.pl will
  be modified to not raise this error for perms == 0

Bartosz Golaszewski (2):
  eeprom: at24: fix coding style issues
  eeprom: at24: use a common prefix for all symbols in at24.c

 drivers/misc/eeprom/at24.c | 48 ++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

-- 
2.15.1
