From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 0/2] i2c: {sh_mobile,rcar}: Trivial fixes of smatch warnings
Date: Tue, 15 Aug 2017 22:36:22 +0200
Message-ID: <20170815203624.19274-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:35203 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbdHOUp5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Aug 2017 16:45:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>

Hello Wolfram,

These simple fixes make smatch happy.
Thanks for taking them into account.

Best regards,
Eugeniu.

Eugeniu Rosca (2):
  i2c: rcar: avoid unused return
  i2c: sh_mobile: avoid unused return

 drivers/i2c/busses/i2c-rcar.c      | 5 ++---
 drivers/i2c/busses/i2c-sh_mobile.c | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.14.1
