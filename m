From: Joshua Frkuska <joshua_frkuska@mentor.com>
Subject: [[RFC V3] 0/1] i2c: imx: add slave support
Date: Wed, 14 Dec 2016 15:01:30 +0900
Message-ID: <1481695291-11444-1-git-send-email-joshua_frkuska@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:48091 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbcLNGCp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Dec 2016 01:02:45 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: joshua_frkuska@mentor.com, wsa@the-dreams.de, syrchin@dev.rtsoft.ru, peda@axentia.se, vladimir_zapolskiy@mentor.com, Jiada_Wang@mentor.com

This patch was tested on i.MX6q sabresd and sabreai development boards. It is a continuation of the work started in the following thread https://www.spinics.net/lists/linux-i2c/msg27340.html

Its purpose is to introduce i2c slave and multimaster capabilities to the imx i2c controller driver. Slave mode can be tested using the i2c test EEPROM i2c slave device available in tree. Multimaster can be tested by creating a bus with 1 or more slave devices with 2 masters. For the purpose of this test, a sabreai and sabresd board were hooked together to form a multimaster bus. In this configuration, slave and multimaster configurations can alternatively be stress tested.

Some points to note:

The patch considers when I2C_SLAVE support is not enabled but introduces unused data structs and members even in this case. This can still probably be cleaned up further but it is left this way to reduce the number of conditional code in the driver.

Furthermore the state machine introduced to handle the slave states does not handle the master mode behavior. This is also done in order to allow an evolutionary change to the driver. A future update can integrate the master entirely into the statemachine.

Any constructive comments would be greatly appreciated.

Thank you

Joshua Frkuska (1):
  i2c: imx: add slave support

 drivers/i2c/busses/i2c-imx.c | 724 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 694 insertions(+), 30 deletions(-)

-- 
2.5.5
