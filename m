Return-Path: <SRS0=l8pq=5X=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0372CC2BB1D
	for <linux-i2c@archiver.kernel.org>; Tue,  7 Apr 2020 13:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39A9206F7
	for <linux-i2c@archiver.kernel.org>; Tue,  7 Apr 2020 13:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgDGNfV (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:35:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:26208 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbgDGNfV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 7 Apr 2020 09:35:21 -0400
IronPort-SDR: EMYNDylrvLf3evf5i8JZwOUYKTDeAnE93yvsoV3YVcUDTtz8sUHvOM/N8ziKegqz+qUwgEqZVq
 P6qEcQZgJW4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 06:35:20 -0700
IronPort-SDR: aJYPjk9EJDKvJDuQm6kKfjl66dBGA6a9fg7FdM1taLW8FwB1wV0m0UujTEBPzXbqL28vLq89WW
 2VTX1xXOjNjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,354,1580803200"; 
   d="scan'208";a="424748773"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga005.jf.intel.com with ESMTP; 07 Apr 2020 06:35:18 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com
Cc:     linux-i2c@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 0/2] i2c: designware: Calculate *CNT for Fast Mode Plus
Date:   Tue,  7 Apr 2020 21:34:37 +0800
Message-Id: <20200407133439.23422-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi.

Custom parameters for HCNT/LCNT are not available for OF based system.
We will use existing SCL timing parameter calculation functions to
get HCNT/LCNT value for Fast Mode Plus and High Speed Mode.

The patches were tested on Keem Bay EVM (OF based system), and using
Tiger Lake platform and Leaf Hill board to cover ACPI and PCI mode.

Thank you.

Best regards,
Zainie.


Wan Ahmad Zainie (2):
  i2c: designware: Calculate SCL timing parameter for Fast Mode Plus
  i2c: designware: Calculate SCL timing parameter for High Speed Mode

 drivers/i2c/busses/i2c-designware-master.c | 37 ++++++++++++++++++----
 1 file changed, 31 insertions(+), 6 deletions(-)

-- 
2.17.1

