Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9138AC433F5
	for <linux-i2c@archiver.kernel.org>; Wed, 23 Mar 2022 09:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiCWJV1 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243126AbiCWJV0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Mar 2022 05:21:26 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746F974DD2;
        Wed, 23 Mar 2022 02:19:55 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 100D6E0007;
        Wed, 23 Mar 2022 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648027192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bc9aFIMo/gS0lgPxSg8VWvqzq4M9fELbHd4r1mwuqDE=;
        b=ZWNA5IXngqliIZnCtatPGnVxAONEBF5V9xVrCpYzuUy1D099p41BHJpReYXHX9LPFYr7r9
        rZSQlAt8unifff0oNqAOHr7Y3gWh9zVCt+U1rM9+vfzPT3NZHITQg8xoFxrTDkMoPJYeNH
        kG0pNwEWe9hVILYx/RNoBr2mOA43eb6VVuhilhusE8Xl2O+hDGC6AIhMpEIyQZe7WwtF9s
        dmQno9BV8lMz85hlUzbWSrdU0vc0noIPrrjeMGZ7C474W49v7oXpzDPr4h11edzXa2KOld
        XYzy6KdAIX02T6lVreClneJGUwJ/f2vuEO1BZKclcpUPnGwtoiGex5eRtpD4xA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v2 0/7] introduce fwnode in the I2C subsystem
Date:   Wed, 23 Mar 2022 10:18:03 +0100
Message-Id: <20220323091810.329217-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

In order to allow the I2C subsystem to be usable with fwnode, add
some functions to retrieve an i2c_adapter from a fwnode and use
these functions in both i2c mux and sfp. ACPI and device-tree are
handled to allow these modifications to work with both descriptions.
I2C mux support has also been modified to support fwnode based
descriptions.

This series is a subset of the one that was first submitted as a larger
series to add swnode support [1]. In this one, it will be focused on
fwnode support only since it seems to have reach a consensus that
adding fwnode to subsystems makes sense.

[1] https://lore.kernel.org/netdev/YhPSkz8+BIcdb72R@smile.fi.intel.com/T/

---------------

Changes in V2:
 - Remove sfp modifications
 - Add property_read_string_index fwnode_operation callback
 - Implement .property_read_string_index for of and swnode
 - Renamed np variable to fwnode

Clément Léger (7):
  device property: add fwnode_property_read_string_index()
  of: property: implement .property_read_string_index callback
  software node: implement .property_read_string_index callback
  i2c: fwnode: add fwnode_find_i2c_adapter_by_node()
  i2c: of: use fwnode_get_i2c_adapter_by_node()
  i2c: mux: pinctrl: remove CONFIG_OF dependency and use fwnode API
  i2c: mux: add support for fwnode

 drivers/base/property.c             | 26 +++++++++++++++++
 drivers/base/swnode.c               | 40 +++++++++++++++++++++++++
 drivers/i2c/Makefile                |  1 +
 drivers/i2c/i2c-core-fwnode.c       | 45 +++++++++++++++++++++++++++++
 drivers/i2c/i2c-core-of.c           | 30 -------------------
 drivers/i2c/i2c-mux.c               | 39 ++++++++++++-------------
 drivers/i2c/muxes/Kconfig           |  1 -
 drivers/i2c/muxes/i2c-mux-pinctrl.c | 23 ++++++++-------
 drivers/of/property.c               | 11 +++++++
 include/linux/fwnode.h              |  6 ++++
 include/linux/i2c.h                 |  8 ++++-
 include/linux/property.h            |  3 ++
 12 files changed, 169 insertions(+), 64 deletions(-)
 create mode 100644 drivers/i2c/i2c-core-fwnode.c

-- 
2.34.1

