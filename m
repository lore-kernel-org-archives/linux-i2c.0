From: Hoan Tran <hotran@apm.com>
Subject: [PATCH v2 0/2] i2c: xgene-slimpro: Add ACPI support
Date: Mon, 24 Apr 2017 11:00:24 -0700
Message-ID: <1493056826-16776-1-git-send-email-hotran@apm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34489 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972774AbdDXSBK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 24 Apr 2017 14:01:10 -0400
Received: by mail-pg0-f50.google.com with SMTP id v1so5059042pgv.1
        for <linux-i2c@vger.kernel.org>; Mon, 24 Apr 2017 11:01:10 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Keyur Chudgar <kchudgar@apm.com>, Hoan Tran <hotran@apm.com>

This patch set adds ACPI support by using PCC mailbox communication interface.

v2:
 * Alphabeltical order
 * Use reinit_completion
 * Remove mutex
 * Use ENOENT instead of ENODEV

Hoan Tran (2):
  i2c: xgene-slimpro: Use a single function to send command message
  i2c: xgene-slimpro: Add ACPI support by using PCC mailbox

 drivers/i2c/busses/i2c-xgene-slimpro.c | 241 +++++++++++++++++++++++++--------
 1 file changed, 187 insertions(+), 54 deletions(-)

-- 
1.9.1
