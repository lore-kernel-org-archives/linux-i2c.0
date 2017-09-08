From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3 0/2] ARM: dts: keystone-k2g: Add I2C support for 66AK2G
Date: Fri, 8 Sep 2017 12:54:46 -0500
Message-ID: <20170908175448.3367-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:51751 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756580AbdIHRzk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Sep 2017 13:55:40 -0400
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

Franklin S Cooper Jr (2):
  i2c: davinci: Add PM Runtime Support
  dt-bindings: i2c: i2c-davinci: Update binding for 66AK2Gx pwr dm
    property

 .../devicetree/bindings/i2c/i2c-davinci.txt        | 12 ++++
 drivers/i2c/busses/i2c-davinci.c                   | 64 ++++++++++++++++++----
 2 files changed, 65 insertions(+), 11 deletions(-)

-- 
2.9.4.dirty
