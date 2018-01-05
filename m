From: Romain Porte <romain.porte@nokia.com>
Subject: Patch proposal for risky i2c addresses in i2c-tools
Date: Fri, 5 Jan 2018 16:02:45 +0100
Message-ID: <20180105150248.3170-1-romain.porte@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0102.outbound.protection.outlook.com ([104.47.0.102]:18412
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751514AbeAEPDd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 5 Jan 2018 10:03:33 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jdelvare@suse.de

This patchset proposes a new option for risky i2c addresses between 0x78
and 0x7f that are currently disabled. This behavior is marked as not
recommended, but is sometimes needed if you have a device using an
address in this range.

It was inspired by an email from Wolfram Sang [1] that encouraged to add
this option for using i2c-tools with devices using this address range.

[1]: https://www.spinics.net/lists/linux-i2c/msg25295.html

Please review!

Romain.
