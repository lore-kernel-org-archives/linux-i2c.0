From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v4 0/2] i2c: davinci: Add PM Runtime Support needed by 66AK2G
Date: Mon, 11 Sep 2017 15:11:43 -0500
Message-ID: <20170911201145.31257-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:52981 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdIKUMf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Sep 2017 16:12:35 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com, vigneshr@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>

Add I2C support to 66AK2G. Primary requirement is to add PM
Runtime support to the driver.

This has been tested on following platforms by performing simple i2c test
such as i2c detect and reading on board i2c devices:
K2G GP evm
OMAPL138
K2L GP EVM

and boot tested on:
K2E GP EVM
K2HK GP EVM

Version 2 changes:
Moved ordering of pm runtime calls

Version 3 changes:
Dropped first patch since it was pulled in.
Remove clk = NULL statements
Fix error path

Version 4 changes:
Fix typo in commit message
Fix error path


Franklin S Cooper Jr (2):
  i2c: davinci: Add PM Runtime Support
  dt-bindings: i2c: i2c-davinci: Update binding for 66AK2Gx pwr dm
    property

 .../devicetree/bindings/i2c/i2c-davinci.txt        | 12 ++++
 drivers/i2c/busses/i2c-davinci.c                   | 67 ++++++++++++++++++----
 2 files changed, 67 insertions(+), 12 deletions(-)

-- 
2.9.4.dirty
