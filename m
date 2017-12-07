From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 0/2] eeprom: at24: coding style fixes
Date: Thu,  7 Dec 2017 14:39:13 +0100
Message-ID: <20171207133915.29448-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Just two patches fixing minor coding style issues. The first one
contains fixes for problems reported by checkpatch. The second adds
a common prefix to all symbols in at24.c.

v1 -> v2:
- don't break the user space: use module_param_named() for module
  parameters

v2 -> v3:
- s/at24_tool_until/at24_loop_until/g
- tweaked the commit message in patch 2/2

Bartosz Golaszewski (2):
  eeprom: at24: fix coding style issues
  eeprom: at24: use a common prefix for all symbols in at24.c

 drivers/misc/eeprom/at24.c | 48 ++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

-- 
2.15.1
