From: Daniel Versick <danls@versick.de>
Subject: i2c-ismt timeout
Date: Tue, 26 Sep 2017 09:50:40 +1000
Message-ID: <0564ED57-D2B8-4192-8747-283F8DCCDEC5@versick.de>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from versick.de ([54.229.28.156]:36159 "EHLO www.versick.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965022AbdIZAAj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 25 Sep 2017 20:00:39 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi,

I am trying to resolve the known issue of ‘completion timed out’ in the i2c-ismt driver which has been reported a couple of times. I’ve seen few requests referring to it but no working solution yet.

I can reliably reproduce that problem on an Intel Atom C2xxx-based device and I found out that the driver does not receive interrupts anymore after getting into the timeout state. Even changing the driver to a polling version shows the same behaviour. It just does not receive a status bit change after transaction. So there is no problem with the MSI interrupt system which has been my first guess.

When being in the timeout state, the SMbus controller seems to be in such a bad condition that I cannot revive it at all. I tried different resets (such as ISMT_GCTRL_SRST and reseting the driver data structures). Only rebooting the device resolves the problem until next occurrence. A scope shows that data and clock lines are high.

I found a patch on the Internet which slows down the I2C communication by adding a delay to ismt_access. This patch probably refers to a known errata of the Atom S1200 and might work there but is no solution for the problem I am currently facing.

Are there any ideas or further information which might help? I tend to believe that this might be a silicon issue. Is there anything known?

Thanks and regards,
Daniel
