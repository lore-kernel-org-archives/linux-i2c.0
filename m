From: Romain Porte <romain.porte@nokia.com>
Subject: New patchset for risky addr, with lower bound support
Date: Mon, 29 Jan 2018 13:40:07 +0100
Message-ID: <20180129124010.4044-1-romain.porte@nokia.com>
References: <20180105150248.3170-1-romain.porte@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0126.outbound.protection.outlook.com ([104.47.2.126]:57376
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751370AbeA2MlX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 29 Jan 2018 07:41:23 -0500
In-Reply-To: <20180105150248.3170-1-romain.porte@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org

New patchset proposal with Wolfram's suggestions for
supporting risky lower-bound addresses too.

Changes from previous patchset:

 - Updated code for lower bound support from 0x00 to 0x02
 - Updated man pages for lower bound support
 - Fixed GCC warning: use %lx for long intead of %x
