From: Loc Ho <lho@apm.com>
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Thu, 10 Dec 2015 14:19:15 -0700
Message-ID: <1449782357-22982-1-git-send-email-lho@apm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34517 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbLJVT1 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 10 Dec 2015 16:19:27 -0500
Received: by obciw8 with SMTP id iw8so68751923obc.1
        for <linux-i2c@vger.kernel.org>; Thu, 10 Dec 2015 13:19:27 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, Ken.Xue@amd.com, Jeff.Wu@amd.com, rjw@rjwysocki.net, mika.westerberg@linux.intel.com, lenb@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>

Add APM X-Gene ACPI I2C device support. These patches follow
the same implementation as AMD I2C driver - changes in ACPI APD
and Designware I2C drivers.

v2:
* Spilt the acpi_apd change with defines for AMD and X-Gene I2C's

Signed-off-by: Loc Ho <lho@apm.com>
---
Loc Ho (2):
  acpi:apd: Add APM X-Gene ACPI I2C device support
  i2c:dw: Add APM X-Gene ACPI I2C device support

 drivers/acpi/acpi_apd.c                     |   16 +++++++++++++++-
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 2 files changed, 16 insertions(+), 1 deletions(-)
