From: Peter Rosin <peda@axentia.se>
Subject: [PULL REQUEST] i2c-mux for 4.12-rc2
Date: Mon, 15 May 2017 18:56:07 +0200
Message-ID: <2ee240a4-6031-3d80-f850-daff4b0182bf@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0098.outbound.protection.outlook.com ([104.47.2.98]:16131
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932514AbdEOQ4P (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 May 2017 12:56:15 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Wolfram,

This fixes an old bug in resource cleanup on failure in i2c-mux-reg and a
new log spamming bug from this merge window in the i2c-mux core.

Please pull.

Cheers,
peda

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git i2c-mux/for-current

for you to fetch changes up to 9fce894d03a98ec8e8e8106a964644633d2772ee:

  i2c: mux: only print failure message on error (2017-05-15 18:49:11 +0200)

----------------------------------------------------------------
Peter Rosin (3):
      i2c: mux: reg: put away the parent i2c adapter on probe failure
      i2c: mux: reg: rename label to indicate what it does
      i2c: mux: only print failure message on error

 drivers/i2c/i2c-mux.c           | 26 ++++++++++++++++----------
 drivers/i2c/muxes/i2c-mux-reg.c | 21 ++++++++++++++-------
 2 files changed, 30 insertions(+), 17 deletions(-)
