From: Peter Rosin <peda@axentia.se>
Subject: [PULL REQUEST] i2c-mux for 4.11
Date: Fri, 24 Mar 2017 12:31:13 +0100
Message-ID: <8b90ffb8-e404-2bbf-ba42-5cd244ca3797@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00102.outbound.protection.outlook.com ([40.107.0.102]:51392
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756100AbdCXLbV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 24 Mar 2017 07:31:21 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi Wolfram,

Here are some changes for the pca954x driver. It's a revert of the
un-endorsed ACPI support and a fixup in the handling of PCA9546.

Please pull.

Cheers,
peda

The following changes since commit 4495c08e84729385774601b5146d51d9e5849f81:

  Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git i2c-mux/for-current

for you to fetch changes up to dbe4d69d252e9e65c6c46826980b77b11a142065:

  i2c: mux: pca954x: Add missing pca9546 definition to chip_desc (2017-03-24 12:22:18 +0100)

----------------------------------------------------------------
Andy Shevchenko (1):
      Revert "i2c: mux: pca954x: Add ACPI support for pca954x"

Mike Looijmans (1):
      i2c: mux: pca954x: Add missing pca9546 definition to chip_desc

 drivers/i2c/muxes/i2c-mux-pca954x.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)
