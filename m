From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/5] i2c: of: brush up the code a little
Date: Thu, 18 Jan 2018 13:11:28 +0100
Message-ID: <20180118121133.13554-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56569 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbeARMLk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Jan 2018 07:11:40 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Lixin Wang <alan.1.wang@nokia-sbell.com>, Wolfram Sang <wsa@the-dreams.de>

While debugging a refcounting problem with OF device nodes, I found a few small
issues in the code. This series addresses them.

Tested on a Renesas Salvator-XS (R-Car H3).

Looking forward for comments. Scheduled for 4.17.

@Lixin Wang: you were working on this code recently, so I added you to CC in
case you are interested in the changes.

Kind regards,

   Wolfram


Wolfram Sang (5):
  i2c: of: change log level of failed device creation
  i2c: of: make ref counting more visible
  i2c: of: rename variable to meet expectations
  i2c: of: remove duplicated check for valid address
  i2c: of: simplify reading the "reg" property

 drivers/i2c/i2c-core-of.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

-- 
2.11.0
