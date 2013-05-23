From: Libo Chen <libo.chen@huawei.com>
Subject: [PATCH RFC v3 0/3] i2c: fix bugs and update API
Date: Thu, 23 May 2013 20:00:01 +0800
Message-ID: <1369310401-31732-1-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: guz.fnst@cn.fujitsu.com, sonic.zhang@analog.com, uclinux-dist-devel@blackfin.uclinux.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, lizefan@huawei.com, libo.chen@huawei.com
List-Id: linux-i2c@vger.kernel.org

this patchset does 3 jobs:
1. fix two bugs in probe
2. convert to devm_* API
3. use module_platform_driver() replace init/exit

v2->v3:
   * convert to devm_* API suggested by Wolfram Sang <wsa@the-dreams.de>
   * use module_platform_driver() replace init/exit 

Libo Chen (3):
  i2c: i2c-bfin-twi: convert to devm_* API
  i2c: pxa: convert to devm_* API
  i2c: pxa: use module_platform_driver() replace init/exit

 drivers/i2c/busses/i2c-bfin-twi.c |   38 +++++--------------
 drivers/i2c/busses/i2c-pxa.c      |   73 ++++++++-----------------------------
 2 files changed, 26 insertions(+), 85 deletions(-)
