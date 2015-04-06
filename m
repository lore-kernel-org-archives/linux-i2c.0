From: <grygorii.strashko@linaro.org>
Subject: [PATCH v4 0/3] i2c: davinci improvements and fixes
Date: Mon,  6 Apr 2015 15:38:38 +0300
Message-ID: <1428323921-25832-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Sekhar Nori <nsekhar@ti.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: grygorii.strashko@ti.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>
List-Id: linux-i2c@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

This series converts driver to use I2C bus recovery infrastructure and
adds Davinci I2C bus recovery mechanizm based on using ICPFUNC registers.
These patches are combination of two patches from Ben Gardiner [1] and
Mike Looijmans [2] which i've reworked to use I2C bus recovery infrastructure

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/047305.html
"[PATCH 0/6] i2c-davinci gpio pulsed SCL recovery with ICPFUNC"
[2] https://lkml.org/lkml/2014/2/28/133
"[PATCH] i2c-davinci: Implement a bus recovery that actually works"

Changes in v4:
- no changes, re-besed on top of i2c/for-next, K4.1

Changes in v3:
- minor comments applied

Changes in v2:
- patch 1: error handling improved
- patch 2: commit message updated
- patch 4: minor comments applied
- patch 5: added new optional DT property "ti,has-pfunc"

Links
v3: http://www.spinics.net/lists/linux-i2c/msg17835.html
v2: https://lkml.org/lkml/2014/11/26/252
v1: http://www.spinics.net/lists/linux-i2c/msg17601.html

CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Santosh Shilimkar <ssantosh@kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>
CC: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Grygorii Strashko (3):
  i2c: recovery: change input parameter to i2c_adapter for prepare/unprepare_recovery
  i2c: davinci: use bus recovery infrastructure
  i2c: davinci: use ICPFUNC to toggle I2C as gpio for bus recovery

 .../devicetree/bindings/i2c/i2c-davinci.txt        |   3 +
 drivers/i2c/busses/i2c-davinci.c                   | 177 ++++++++++++++++-----
 drivers/i2c/i2c-core.c                             |   4 +-
 include/linux/i2c.h                                |   4 +-
 include/linux/platform_data/i2c-davinci.h          |   1 +
 5 files changed, 144 insertions(+), 45 deletions(-)

-- 
1.9.1
