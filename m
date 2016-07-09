From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/7] i2c: improve error messages when registering an adapter
Date: Sat,  9 Jul 2016 13:34:57 +0900
Message-ID: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37712 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbcGIEfT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 9 Jul 2016 00:35:19 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

The goal of this series is to have proper error messages whenever something in
i2c_add_adapter() and friends fail. Then, we can hereafter drop all similar
messages in drivers which is largely duplicated code and often not very helpful
because they are too generic.

To achieve this goal, we make sure that dev_* is used whenever a device is
available. pr_* is used when we have at least an adapter name. If not, we use
WARN to show the user the code path that failed. Error messages were added,
fixed, and made consistent. Also, the first patch fixes a potential leak found
while creating this series. Also, i2c_register_adapter() was a bit refactored
to be easier to handle. Please look at the patch descriptions for details. A
brach is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git strings/i2c

Looking forward to comments.

   Wolfram

Wolfram Sang (7):
  i2c: free idr when sanity checks in i2c_register_adapter() fail
  i2c: cleanup i2c_register_adapter() by refactoring recovery init
  i2c: improve error messages in i2c_register_adapter()
  i2c: add error message when obtaining idr fails
  i2c: print more info when of_i2c_notify fails
  i2c: print more info when acpi_i2c_space_handler() fails
  i2c: use pr_fmt in the core

 drivers/i2c/i2c-core.c | 124 ++++++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 58 deletions(-)

-- 
2.8.1
