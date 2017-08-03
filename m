From: Jean Delvare <jdelvare@suse.de>
Subject: i2c-tools 4.0
Date: Thu, 3 Aug 2017 15:34:14 +0200
Message-ID: <20170803153414.4c9135ff@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751143AbdHCNeQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 3 Aug 2017 09:34:16 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

Hi all,

I have been delaying this for too long, let's release i2c-tools 4.0. I
know that there are still a few things which I wanted to include in it
which aren't ready (specifically, merging (parts of) tools/i2cbusses
into the library, and documenting the API), but apparently I can't find
the time for them. So I have come to the conclusion that we should
release what we have, and build incrementally on top of it after it has
been adopted by distributions.

Therefore I would like to ask everyone to give good testing to the
master branch of:

https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/

because it will become i2c-tools 4.0 in a near future.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
