From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 0/2] i2c: octeon: thunderx: Recovery fixes and improvements
Date: Fri, 23 Sep 2016 11:40:37 +0200
Message-ID: <cover.1474565039.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35080 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755168AbcIWJkx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 23 Sep 2016 05:40:53 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>, Jan Glauber <jglauber@cavium.com>

Hi Wolfram,

here are the remaining two patches with iopoll.h usage and a timed wait
before entering the recovery on a failed bus check.

thanks,
Jan

---------------------

Jan Glauber (2):
  i2c: octeon: thunderx: Check bus state before starting a transaction
  i2c: octeon: thunderx: Limit register access retries

 drivers/i2c/busses/i2c-octeon-core.c | 33 ++++++++++++++++++++++++++++++++-
 drivers/i2c/busses/i2c-octeon-core.h | 27 ++++++++++++++++-----------
 2 files changed, 48 insertions(+), 12 deletions(-)

-- 
1.9.1
