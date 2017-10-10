From: Kamlakant Patel <kamlakant.patel@cavium.com>
Subject: [PATCH v2 0/3] i2c-xlp9xx: update i2c driver to handle I2C_M_RECV_LEN flag
Date: Tue, 10 Oct 2017 11:57:53 +0530
Message-ID: <1507616876-17189-1-git-send-email-kamlakant.patel@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:18976
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751810AbdJJG1S (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 10 Oct 2017 02:27:18 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Kamlakant Patel <kamlakant.patel@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

This patch set has following changes:
 * Use Linux clk APIs to get input clock frequency for the I2C controller.
 * I2C driver update to handle I2C_M_RECV_LEN and I2C_CLIENT_PEC flags.

Changes since v1:
* Rebased to mainline(4.14-rc4).
* Removed unnecessary parens in i2c-xlp9xx.c.

Jayachandran C (2):
  ACPI / APD: Add clock frequency for ThunderX2 I2C controller
  i2c: xlp9xx: Get clock frequency with clk API

Kamlakant Patel (1):
  i2c: xlp9xx: Handle I2C_M_RECV_LEN in msg->flags

 drivers/acpi/acpi_apd.c         |  5 +++++
 drivers/i2c/busses/i2c-xlp9xx.c | 44 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 4 deletions(-)

-- 
2.7.4
