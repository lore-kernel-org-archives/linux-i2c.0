From: Loc Ho <lho@apm.com>
Subject: [PATCH 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Mon,  7 Dec 2015 17:16:12 -0700
Message-ID: <1449533774-22672-1-git-send-email-lho@apm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33085 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbbLHAQZ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Dec 2015 19:16:25 -0500
Received: by pabur14 with SMTP id ur14so2094993pab.0
        for <linux-i2c@vger.kernel.org>; Mon, 07 Dec 2015 16:16:25 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, Ken.Xue@amd.com, Jeff.Wu@amd.com, rjw@rjwysocki.net, mika.westerberg@linux.intel.com, lenb@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>

Add APM X-Gene ACPI I2C device support. These patches follow
the same implementation as AMD I2C driver - changes in ACPI APD 
and Designware I2C drivers.

Signed-off-by: Loc Ho <lho@apm.com>
---
Loc Ho (2):
  acpi:apd: Add APM X-Gene ACPI I2C device support
  i2c:dw: Add APM X-Gene ACPI I2C device support

 drivers/acpi/acpi_apd.c                     |    8 +++++++-
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)
