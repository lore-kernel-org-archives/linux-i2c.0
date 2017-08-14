From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/3] i2c-cht-wc: Various fixes
Date: Mon, 14 Aug 2017 22:17:23 +0200
Message-ID: <20170814201726.21045-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbdHNUR2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 16:17:28 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org

Hi Wolfram,

Sorry for sending this out so shortly after you merged the
adapter driver itself, but while testing some code which
sits on top of the adapter + charger combo I noticed some
subtle issues, which took me most of my weekend to get
to the bottom too.

I guess in a way this way is better as it will lead
to a git log explaining all the bug-fixes.

Regards,

Hans
