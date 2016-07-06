From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/2] i2c-dev: Don't let userspace block adapter
Date: Tue,  5 Jul 2016 19:57:05 -0700
Message-ID: <cover.1467772840.git.viresh.kumar@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34846 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbcGFC5M (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Jul 2016 22:57:12 -0400
Received: by mail-pf0-f180.google.com with SMTP id c2so75744329pfa.2
        for <linux-i2c@vger.kernel.org>; Tue, 05 Jul 2016 19:57:12 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

Hi Wolfram/Jean,

I am part of the kernel team for Google's projectara [1], where we are
building a module smart phone.

This series tries to fix one of the problems we hit on our system as we
are required to hotplug pretty much every thing on the phone and so this
fixes hotplug issues with i2c-dev.

As described in the second patch, the current implementation of i2c-dev
file operations doesn't let the modules (hardware attached to the phone)
eject from the phone as the cleanup path for the module hasn't finished
yet (i2c adapter not removed).

We can't let the userspace block the kernel devices forever in such
cases.

I was able to test them on the ARA phone with kernel 3.10 only and not
mainline.

--
viresh

[1] https://atap.google.com/ara/

Viresh Kumar (2):
  i2c-dev: don't get i2c adapter via i2c_dev
  i2c-dev: Don't block the adapter from unregistering

 drivers/i2c/i2c-dev.c | 79 ++++++++++++++++++++++++++++++++++++++++++---------
 include/linux/i2c.h   |  1 +
 2 files changed, 67 insertions(+), 13 deletions(-)

-- 
2.7.4
