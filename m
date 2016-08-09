From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: [PATCH] video: don't print error when adding adapter fails
Date: Tue,  9 Aug 2016 13:27:38 +0200
Message-ID: <1470742059-12341-1-git-send-email-wsa-dev@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55430 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbcHIL1p (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 9 Aug 2016 07:27:45 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, linux-fbdev@vger.kernel.org

Since v4.8-rc1, the I2C core will print detailed information when adding an I2C
adapter fails. So, drivers can skip this now.

Should go via subsystem tree, I'd think.

Wolfram Sang (1):
  video: fbdev: mb862xx: mb862xx-i2c: don't print error when adding
    adapter fails

 drivers/video/fbdev/mb862xx/mb862xx-i2c.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

-- 
2.8.1
