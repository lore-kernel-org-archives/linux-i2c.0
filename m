From: Joshua Frkuska <joshua_frkuska@mentor.com>
Subject: [RFC V4 0/2] i2c: imx: add slave support
Date: Thu, 8 Jun 2017 11:51:02 +0900
Message-ID: <1496890264-10150-1-git-send-email-joshua_frkuska@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:54697 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdFHCvT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Jun 2017 22:51:19 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, vladimir_zapolskiy@mentor.com, wsa@the-dreams.de
Cc: joshua_frkuska@mentor.com, peda@axentia.se, syrchin@dev.rtsoft.ru

Purpose:
Its purpose is to introduce i2c slave with multimaster capabilities to the imx i2c controller driver.

This patch was tested on i.MX6q sabresd, sabreai and UDOO boards. It is a continuation of the work started in the following thread https://www.spinics.net/lists/linux-i2c/msg27340.html

The current version is version 4 and is a continuation of the discussion in http://www.spinics.net/lists/linux-i2c/msg27563.html

v4 change summary:
1. preserved Maxim's authorship, added rework note with signoff
2. re-arranged #include ordering
3. fixed check-patch warnings
4. redefined MAX_EVENTS to an integer
5. removed introduction of error codes
6. changed last_error (atomic_t) to type int
7. removed white lines
8. fixed multiple parenthesis alignment issues
9. removed explicit casting
10. replace udelay with usleep_range
11. removed multiple excess spacing issues
12. check for return of wait_event_interruptible_timeout
13. simplified conditional statements
14. removed dubious pinctrl handling
15. updated commit message

Testing: (validated locally with 3 different imx6q devices) For the purpose of this test, any 2 imx6 boards were hooked together to form a multimaster bus. In this configuration, slave and multimaster configurations can alternatively be stress tested. It is rebased and tested on the i2c/for-next branch.
1. enable CONFIG_I2C_SLAVE=y
2. enable CONFIG_I2C_SLAVE_EEPROM=y[m]
3. enable CONFIG_I2C_CHARDEV=y[m]
4. build the kernel
5. install the kernel/drivers on 2 imx devices
6. wire the i2c busses of both devices together
7. load kernel modules if needed
8. instantiate a slave eeprom on device 1 with address A on whatever bus it corresponds to
9. instantiate a slave eeprom on device 2 with address B on whatever bus it corresponds to
10. using i2cget/set on the appropriate bus, randomly read/write on device 1 from/to address B.
11. using i2cget/set on the appropriate bus, randomly read/write on device 2 from/to address A.
12. confirm operation between devices by observing the input and output of the i2cget/set functions as well as dumping the contents of the eeprom via the sysfs entry (/sys/bus/i2c/devices/i2c-<BUS #>/new_device)

Notes:
1. The patch considers when I2C_SLAVE support is not enabled but introduces unused data structs and members even in this case. This can still probably be cleaned up further but it is left this way to reduce the number of conditional code in the driver.
2. When a slave is not being used, it drops down to an idle state. This allows operation between master and slave modes to be handled near simultaneously. As a result when i2cdetect is used on a bus whose i2c controller is both to act as a master and slave, timeouts occur as the hardware is shared between driving the bus as a master and responding as a slave. In general, this is thought to be an invalid use-case and iscurrently a limitation of this driver.
3. The defconfig patch is just to test the driver with.
4. Only imx6 was tested. older imx platforms are believed to work but have not been tested.

Any constructive comments would be greatly appreciated.

Thank you

Joshua Frkuska (1):
  i2c: imx: add slave support

 drivers/i2c/busses/i2c-imx.c | 724 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 694 insertions(+), 30 deletions(-)


Joshua Frkuska (1):
  ARM: imx_v6_v7_defconfig: Test imx i2c slave support

Maxim Syrchin (1):
  i2c: imx: add slave support

 arch/arm/configs/imx_v6_v7_defconfig |   7 +-
 drivers/i2c/busses/i2c-imx.c         | 730 +++++++++++++++++++++++++++++++++--
 2 files changed, 695 insertions(+), 42 deletions(-)

-- 
2.5.5
