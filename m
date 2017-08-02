From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/2] i2c: mux: pinctrl: remove platform_data and cleanup
Date: Wed,  2 Aug 2017 09:27:26 +0200
Message-ID: <20170802072728.24586-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr10105.outbound.protection.outlook.com ([40.107.1.105]:45235
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751177AbdHBH1r (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 2 Aug 2017 03:27:47 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@nvidia.com>, linux-i2c@vger.kernel.org

Hi!

As previously discussed [1], the platform_data interface of the i2c mux
pinctrl driver has never been used (upstream at least). Deleting code
is always nice, so here are two patches that gets rid of some lines...

Cheers,
peda

[1] https://lkml.org/lkml/2017/5/22/104

Peter Rosin (2):
  i2c: mux: pinctrl: remove platform_data
  i2c: mux: pinctrl: drop the idle_state member

 drivers/i2c/muxes/Kconfig           |   1 +
 drivers/i2c/muxes/i2c-mux-pinctrl.c | 223 ++++++++++++------------------------
 include/linux/i2c-mux-pinctrl.h     |  41 -------
 3 files changed, 72 insertions(+), 193 deletions(-)
 delete mode 100644 include/linux/i2c-mux-pinctrl.h

-- 
2.11.0
