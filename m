From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: PMBus and SMBUS_BLOCK with "extended" lenght
Date: Fri, 31 Mar 2017 19:17:27 +1100
Message-ID: <1490948247.3177.233.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47810 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932509AbdCaIRb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 31 Mar 2017 04:17:31 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v2V8HSPm031003
        for <linux-i2c@vger.kernel.org>; Fri, 31 Mar 2017 03:17:29 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c <linux-i2c@vger.kernel.org>

Hi folks !

Did anybody give thoughts to how we could support "smbus" block
transfers with a size up to 0xff ? This is an extension of smbus
that part of the PMbus protocol spec.

Our current code has a lot of places where I2C_SMBUS_BLOCK_MAX is
hard wired. Including down in almost all drivers.

So it would have to be an evolutionary process.

I was thinking a message flag along with a functionality bit
maybe ?

Cheers,
Ben.
 
