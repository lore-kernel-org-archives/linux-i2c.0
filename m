Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED98C43334
	for <linux-i2c@archiver.kernel.org>; Tue, 28 Jun 2022 19:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiF1Ttp (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 28 Jun 2022 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiF1Tt0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Jun 2022 15:49:26 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62D282F38C;
        Tue, 28 Jun 2022 12:45:50 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,229,1650898800"; 
   d="scan'208";a="125967111"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Jun 2022 04:45:49 +0900
Received: from localhost.localdomain (unknown [10.226.92.14])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2ADFC400D4E5;
        Wed, 29 Jun 2022 04:45:43 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Sven Peter <sven@svenpeter.dev>, Jan Dabros <jsd@semihalf.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tyrone Ting <kfting@nuvoton.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/2] i2c: Add new driver for Renesas RZ/V2M controller
Date:   Tue, 28 Jun 2022 20:45:24 +0100
Message-Id: <20220628194526.111501-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi,

The Renesas RZ/V2M SoC (r9a09g011) has a new i2c controller. This series
add the driver. One annoying problem is that the SoC uses a single reset
line for two i2c controllers, and unfortunately one of the controllers
is managed by some firmware, not by Linux. Therefore, the driver just
deasserts the reset.

v2:
  dt-binding:
  - Use an enum and set the default for clock-frequency
  - Add resets property
  driver:
  - Use the new NOIRQ_SYSTEM_SLEEP_PM_OPS() as suggested by Arnd
  - Lots of small fixes based on Geert's review

Phil Edworthy (2):
  dt-bindings: i2c: Document RZ/V2M I2C controller
  i2c: Add Renesas RZ/V2M controller

 .../bindings/i2c/renesas,rzv2m.yaml           |  80 +++
 drivers/i2c/busses/Kconfig                    |  10 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-rzv2m.c                | 530 ++++++++++++++++++
 4 files changed, 621 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
 create mode 100644 drivers/i2c/busses/i2c-rzv2m.c

-- 
2.34.1

