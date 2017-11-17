From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 0/3] imx i2c vs clk framework deadlock fix
Date: Fri, 17 Nov 2017 19:05:36 +0100
Message-ID: <20171117180539.4984-1-l.stach@pengutronix.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:32829 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753407AbdKQSFl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Nov 2017 13:05:41 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de, Lukas Rusak <lorusak@gmail.com>, Chris Healy <cphealy@gmail.com>

Hi all,

this series fixes a deadlock between the i2c and the clk framework as seen
on some i.MX machines. The basic issue is that both the i2c and clk framework
employ some big hammer locks (clk_prepare mutex and i2c bus mutex), which
potentially span across several devices.

The imx i2c driver needs to take the clk prepare mutex in its runtime PM
handlers, as it is switching the device clock on and off depending on the
RPM state. With the i2c bus mutex being taken before calling into the driver
xfer function and the xfer function handling the runtime PM state we get the
usual lock ordering of bus_lock->clk_prepare.

Now with an i2c attached clock source, clk framwork operations on this clock
which require the clk_prepare mutex to be locked get a lock ordering of
clk_prepare -> [i2c-transfer function] -> i2c bus_lock ->
[driver xfer function being called invoking RPM] -> clk_prepare.

The only reason that this isn't constantly deadlocking with i2c attached clk
sources is that the imx-i2c driver uses RPM autosuspend, so the device clk
is still running in a lot of cases rendering the RPM resume a no-op. Note
that the cyclic lock dependency above is only the simple case, we can also
run into a ABBA deadlock involving multiple device on the same i2c bus, so
a simple nested mutex lock of the clk_prepare lock won't do.

The simplest solution I came up with is to move runtime PM for i2c
controllers into the i2c framework itself, allowing the RPM handling to be
done outside of the i2c bus lock. It has the nice side-effect of simplifying
the actual hardware driver, but as it involves changes to the framework I
would really like to hear from i2c mainainers if this is looking fishy in
any way.

Regards,
Lucas

Lucas Stach (3):
  i2c: imx: use clk notifier for rate changes
  i2c: add runtime PM handling to core
  i2c: imx: use runtime PM provided by core

 drivers/i2c/busses/i2c-imx.c | 43 ++++++++++++++++++++++++++++---------------
 drivers/i2c/i2c-core-base.c  | 18 ++++++++++++++++--
 include/linux/i2c.h          |  1 +
 3 files changed, 45 insertions(+), 17 deletions(-)

-- 
2.11.0
