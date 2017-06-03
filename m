From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v10 0/5] i2c: aspeed: added driver for Aspeed I2C
Date: Fri,  2 Jun 2017 18:29:47 -0700
Message-ID: <20170603012952.2192-1-brendanhiggins@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org, ryan_chen@aspeedtech.com
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org

Addressed comments from:
  - Marc in: http://www.spinics.net/lists/devicetree/msg179432.html
  - Ben in: http://www.spinics.net/lists/devicetree/msg179491.html

Changes since previous update:
  - I2C irqchip: Unallocate resources on init failure
  - I2C driver: Added master_xfer_result field to struct aspeed_i2c_bus

As before, tested on Aspeed 2500 evaluation board and a real platform with an
Aspeed 2520.
