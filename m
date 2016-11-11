From: Peter Rosin <peda@axentia.se>
Subject: [PULL REQUEST] i2c-mux for 4.10
Date: Fri, 11 Nov 2016 09:48:08 +0100
Message-ID: <7599c37b-c5b1-edb7-e8c2-5afa025a1233@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0110.outbound.protection.outlook.com ([104.47.0.110]:47520
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753405AbcKKMUg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 11 Nov 2016 07:20:36 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Wolfram,

here is a driver from Vadim Pasternak that I thought you were going
to pick up after I acked it, but that didn't happen for some reason?
Maybe I wasn't clear enough or my ack was buried too deep in some
thread you didn't follow or something? Then I forgot about it and
didn't follow up, so it missed the last merge window.

I'm sending the pull request this early so that the driver can get
some more bot exposure.

Cheers,
Peter

The following changes since commit bc33b0ca11e3df467777a4fa7639ba488c9d4911:

  Linux 4.9-rc4 (2016-11-05 16:23:36 -0700)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git i2c-mux/for-next

for you to fetch changes up to 60fef1374d38aa1182afd46368309f8f98ac435e:

  i2c: mux: mellanox: add driver (2016-11-11 09:09:14 +0100)

----------------------------------------------------------------
Vadim Pasternak (1):
      i2c: mux: mellanox: add driver

 MAINTAINERS                         |   7 ++
 drivers/i2c/muxes/Kconfig           |  11 ++
 drivers/i2c/muxes/Makefile          |   1 +
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 222 ++++++++++++++++++++++++++++++++++++
 include/linux/i2c/mlxcpld.h         |  53 +++++++++
 5 files changed, 294 insertions(+)
 create mode 100644 drivers/i2c/muxes/i2c-mux-mlxcpld.c
 create mode 100644 include/linux/i2c/mlxcpld.h
