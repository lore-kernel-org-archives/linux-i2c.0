From: minyard@acm.org
Subject: [PATCH v2 0/3] Add parameters for sysfs added I2C devices
Date: Tue, 10 May 2016 11:11:36 -0500
Message-ID: <1462896699-1627-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35860 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcEJQLr (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 10 May 2016 12:11:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id g132so1275635pfb.3
        for <linux-i2c@vger.kernel.org>; Tue, 10 May 2016 09:11:47 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Cc: minyard@acm.org

This is a set of patches I posted earlier, it allows you to pass in
parameters when adding I2C devices through sysfs.

I really need this for the IPMI over I2C driver (The SSIF driver)
for a couple of reasons.

The SSIF driver itself needs to take a parameter to tell it's
address on the IPMI bus in case it's not the default.  It's also
nice to be able to pass in debug parameters this way.

Second, the IPMI driver can use SMBus alerts, but if the SMBus
alert device is added via sysfs, there is no way to specify the
interrupt information, thus it's fairly useless.

The first patch adds the ability to have parameters for sysfs added
I2C devices.  The second patch adds interrupt parameters for the
SMBus alert device.  The last is the IPMI SSIF changes, just for
example, I can add those in the IPMI tree.

-corey
