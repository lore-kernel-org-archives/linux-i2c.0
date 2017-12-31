From: Peter Rosin <peda@axentia.se>
Subject: [PULL REQUEST] i2c-mux for 4.16-rc1
Date: Sun, 31 Dec 2017 08:58:54 +0100
Message-ID: <4a49b5a6-266c-afb3-8c41-88b46a449609@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr40126.outbound.protection.outlook.com ([40.107.4.126]:8655
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750724AbdLaH7C (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 31 Dec 2017 02:59:02 -0500
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Wolfram,

A couple of patches this time. Just some more compatibles for the pca954x
driver and an error handling tweak for the reg driver.

Please pull!

Cheers,
Peter

The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git i2c-mux/for-next

for you to fetch changes up to ac5b85de17cb96445c51bd1a1c53c3f675582f26:

  i2c: mux: reg: don't log an error for probe deferral (2017-12-30 23:12:34 +0100)

----------------------------------------------------------------
Adrian Fiergolski (1):
      i2c: mux: pca954x: add support for NXP PCA984x family

Tomasz Bachorski (1):
      i2c: mux: reg: don't log an error for probe deferral

 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    | 13 ++++++--
 drivers/i2c/muxes/Kconfig                          |  6 ++--
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 38 +++++++++++++++++++---
 drivers/i2c/muxes/i2c-mux-reg.c                    |  3 ++
 4 files changed, 51 insertions(+), 9 deletions(-)
