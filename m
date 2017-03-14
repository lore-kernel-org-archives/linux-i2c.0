From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/4] misc: Add OF device table to I2C drivers that are missing it
Date: Tue, 14 Mar 2017 12:16:34 -0300
Message-ID: <20170314151638.23132-1-javier@osg.samsung.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:42387
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750980AbdCNPQx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Mar 2017 11:16:53 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Arnd Bergmann <arnd@arndb.de>, Wei Yongjun <weiyongjun1@huawei.com>, Serge Semin <fancer.lancer@gmail.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Julia Lawall <julia.lawall@lip6.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Colin Ian King <colin.king@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>

Hello,

This series add OF device ID tables to misc I2C drivers whose devices are
either used in Device Tree source files or are listed in binding docs as
a compatible string.

That's done because the plan is to change the I2C core to report proper OF
modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
a device was registered via DT or using the legacy platform data mechanism.

So these patches will make sure that misc I2C drivers modules will continue
to be autoloaded once the I2C core is changed to report proper OF modalias.

Best regards,
Javier


Javier Martinez Canillas (4):
  misc: tsl2550: Add OF device ID table
  misc: ds1682: Add OF device ID table
  eeprom: idt_89hpesx: Add OF device ID table
  eeprom: at24: Add OF device ID table

 drivers/misc/ds1682.c             |   7 ++
 drivers/misc/eeprom/at24.c        | 189 +++++++++++++++++++++++++++++++++++++-
 drivers/misc/eeprom/idt_89hpesx.c |  57 ++++++++++++
 drivers/misc/tsl2550.c            |   7 ++
 4 files changed, 259 insertions(+), 1 deletion(-)

-- 
2.9.3
