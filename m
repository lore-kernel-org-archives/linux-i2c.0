Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD1C4332F
	for <linux-i2c@archiver.kernel.org>; Wed,  9 Feb 2022 11:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiBILzV (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 9 Feb 2022 06:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiBILzO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 9 Feb 2022 06:55:14 -0500
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 02:48:00 PST
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6888AC004385;
        Wed,  9 Feb 2022 02:48:00 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
        id E0E2F2028E; Wed,  9 Feb 2022 18:31:41 +0800 (AWST)
From:   Matt Johnston <matt@codeconstruct.com.au>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH net-next v4 0/2] MCTP I2C driver
Date:   Wed,  9 Feb 2022 18:31:19 +0800
Message-Id: <20220209103121.3907832-1-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi,

This patch series adds a netdev driver providing MCTP transport over
I2C. 

Since the v3 submission I have switched to using I2C transfers
which support >32 bytes. It could be switch back to smbus transfers
once 255 byte support is ready. It now doesn't require any changes to
I2C core.

The dt-bindings patch went through review on the list.

Cheers,
Matt

--
v4:
 - Switch to __i2c_transfer() rather than __i2c_smbus_xfer(), drop 255 byte
   smbus patches
 - Use wait_event_idle() for the sleeping TX thread
 - Use dev_addr_set()
v3:
 - Added Reviewed-bys for npcm7xx
 - Resend with net-next open
v2:
 - Simpler Kconfig condition for i2c-mux dependency, from Randy Dunlap

Matt Johnston (2):
  dt-bindings: net: New binding mctp-i2c-controller
  mctp i2c: MCTP I2C binding driver

 Documentation/devicetree/bindings/i2c/i2c.txt |    4 +
 .../bindings/net/mctp-i2c-controller.yaml     |   92 ++
 drivers/net/mctp/Kconfig                      |   13 +
 drivers/net/mctp/Makefile                     |    1 +
 drivers/net/mctp/mctp-i2c.c                   | 1002 +++++++++++++++++
 5 files changed, 1112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mctp-i2c-controller.yaml
 create mode 100644 drivers/net/mctp/mctp-i2c.c

-- 
2.32.0

