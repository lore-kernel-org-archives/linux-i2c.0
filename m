From: Peter Rosin <peda@axentia.se>
Subject: [PULL REQUEST] i2c-mux for v4.12-rc1 #2
Date: Wed, 19 Apr 2017 13:06:23 +0200
Message-ID: <8a8af32d-bac2-c28f-8d97-d5da24f5b079@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr30128.outbound.protection.outlook.com ([40.107.3.128]:57579
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933747AbdDSLGa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 19 Apr 2017 07:06:30 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi Wolfram,

I thought Mauro would take this patch, but then he just added a tag. So,
here's a late incremental pull request for v4.12-rc1 with incredibly
important stuff :-)

Feel free to skip it and I'll get it to you for the next merge window
instead...

Cheers,
peda


The following changes since commit dbed8a803bd3fb64339a6180adaff2cec46242ce:

  i2c: mux: ltc4306: LTC4306 and LTC4305 I2C multiplexer/switch (2017-04-12 17:10:31 +0200)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git tags/i2c-mux/for-4.12-2

for you to fetch changes up to f6cfec891622f7bc3fb04170b7d7cb8bfebc82a7:

  [media] cx231xx: stop double error reporting (2017-04-19 12:49:29 +0200)

----------------------------------------------------------------
Peter Rosin (1):
      [media] cx231xx: stop double error reporting

 drivers/media/usb/cx231xx/cx231xx-i2c.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)
