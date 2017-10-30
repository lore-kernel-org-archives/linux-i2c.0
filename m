From: Jean Delvare <jdelvare@suse.de>
Subject: i2c-tools 4.0 has been released
Date: Mon, 30 Oct 2017 11:10:50 +0100
Message-ID: <20171030111050.31f82e26@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50873 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752473AbdJ3KKz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 30 Oct 2017 06:10:55 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>, rpjday@crashcourse.ca, =?UTF-8?B?T25kxZllaiBMeXNvbsSbaw==?= <olysonek@redhat.com>

Hi all,

After 6 years of waiting, a new version of i2c-tools is finally out. It
marks a significant milestone of the project, because we finally got
rid of the huge ugly i2c-dev.h header file full of inline functions
that was interfacing with the kernel, and replaced it with a small
library. This means no more code duplication, no more compiler
warnings, and no more confusion and collision with kernel header files.
Hopefully.

Note that libi2c is released under the LGPL, as you would expect for a
library.

You can download i2c-tools 4.0 at the usual place:
https://www.kernel.org/pub/software/utils/i2c-tools/

You can check the CHANGES file for a list of other improvements. Most
notably:
 * Many fixes and improvements to decode-dimms, although unfortunately
   it is still missing DDR4 support.
 * New manual pages and examples added to existing manual pages.
 * New tool written by Wolfram Sang to transfer raw I2C messages:
   i2ctransfer.
 * Support for python 3.

Please let me know if anything doesn't work or doesn't look good.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
