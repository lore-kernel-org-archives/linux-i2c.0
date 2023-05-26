Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818BCC7EE23
	for <linux-i2c@archiver.kernel.org>; Fri, 26 May 2023 13:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbjEZNeD (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 26 May 2023 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243408AbjEZNeC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 26 May 2023 09:34:02 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FAAEE66;
        Fri, 26 May 2023 06:33:35 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.00,194,1681138800"; 
   d="scan'208";a="160953931"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 May 2023 22:33:08 +0900
Received: from localhost.localdomain (unknown [10.226.93.166])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 426544216EE7;
        Fri, 26 May 2023 22:33:05 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-i2c@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/3] RZ/V2M I2Cdriver clean ups
Date:   Fri, 26 May 2023 14:33:00 +0100
Message-Id: <20230526133303.309582-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

This patch series aims to do the following clean ups based on feedback
from Pavel while backporting this driver to 5.10.y-cip kernel.

Drop extra space from config help description, Replace lowercase macros
with static inline functions and finally in probe disable the operation
of unit in case of error similar to remove and suspend callbacks.

v1->v2:
 * Added Rb tag from Geert.
 * Updated commit header and description for patch#2.
 * Replaced macros bit_setl and bit_clrl with static inline functions.
 * Introduced rzv2m_i2c_disable() and shared the code between
   probe error path, remove and suspend callbacks.

Biju Das (3):
  i2c: rzv2m: Drop extra space
  i2c: rzv2m: Replace lowercase macros with static inline functions
  i2c: rzv2m: Disable the operation of unit in case of error

 drivers/i2c/busses/Kconfig     |  2 +-
 drivers/i2c/busses/i2c-rzv2m.c | 43 +++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.25.1

