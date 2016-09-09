From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH 0/2] i2c: aspeed: added driver for Aspeed I2C
Date: Fri,  9 Sep 2016 12:54:28 -0700
Message-ID: <1473450870-10333-1-git-send-email-brendanhiggins@google.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33579 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754657AbcIITz5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Sep 2016 15:55:57 -0400
Received: by mail-pa0-f53.google.com with SMTP id cm16so31335237pac.0
        for <linux-i2c@vger.kernel.org>; Fri, 09 Sep 2016 12:55:57 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au, jk@ozlabs.org

This patch set adds initial master mode and slave mode support for the Aspeed
24xx and 25xx I2C controllers, as well as device binding documentation for the
new driver.

These changes have been tested on the ast2500 evaluation board from Aspeed.

Work still to be done:
 - The driver supports I2C protocol mangling in the form of sending stops after
   every transaction, the remaining mangling support has not yet been added.
 - SMBus Alert support.

Cheers!
