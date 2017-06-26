From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/5] i2c: pca-platform: updates
Date: Mon, 26 Jun 2017 12:44:29 +1200
Message-ID: <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34760 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdFZAop (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 25 Jun 2017 20:44:45 -0400
In-Reply-To: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

We're using a PCA9564 on an embedded platform to provide an i2c
controller. This adds devicetree support and I've included some
cleanups for the driver while I was at it.

Chris Packham (5):
  dt-bindings: add bindings for i2c-pca-platform
  i2c: pca-platform: switch to struct gpio_desc
  i2c: pca-platform: add devicetree awareness
  i2c: pca-platform: use device managed allocations
  i2c: pca-platform: use dev_warn/dev_info instead of printk

 .../devicetree/bindings/i2c/i2c-pca-platform.txt   |  29 +++++
 drivers/i2c/busses/i2c-pca-platform.c              | 125 +++++++++------------
 2 files changed, 84 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt

-- 
2.13.0
