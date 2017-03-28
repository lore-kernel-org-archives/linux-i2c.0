From: Hoan Tran <hotran@apm.com>
Subject: [PATCH 0/2] i2c: xgene-slimpro: Add ACPI support
Date: Tue, 28 Mar 2017 13:46:15 -0700
Message-ID: <1490733977-23760-1-git-send-email-hotran@apm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33590 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755295AbdC1Uqp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Mar 2017 16:46:45 -0400
Received: by mail-pg0-f53.google.com with SMTP id n5so75758742pgh.0
        for <linux-i2c@vger.kernel.org>; Tue, 28 Mar 2017 13:46:44 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Keyur Chudgar <kchudgar@apm.com>, Hoan Tran <hotran@apm.com>

This patch set adds ACPI support by using PCC mailbox communication interface.

Hoan Tran (2):
  i2c: xgene-slimpro: Use a single function to send command message
  i2c: xgene-slimpro: Add ACPI support by using PCC mailbox

 drivers/i2c/busses/i2c-xgene-slimpro.c | 246 +++++++++++++++++++++++++--------
 1 file changed, 192 insertions(+), 54 deletions(-)

-- 
1.9.1
