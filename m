From: Romain Porte <romain.porte@nokia.com>
Subject: Patch proposal for using all addresses in i2c-tools
Date: Fri, 2 Feb 2018 13:45:15 +0100
Message-ID: <20180202124518.2663-1-romain.porte@nokia.com>
References: <20180105150248.3170-1-romain.porte@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0102.outbound.protection.outlook.com ([104.47.1.102]:36389
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751718AbeBBMql (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Feb 2018 07:46:41 -0500
In-Reply-To: <20180105150248.3170-1-romain.porte@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: jdelvare@suse.de, peda@axentia.se, linux-i2c@vger.kernel.org

This new patchset mainly removes any references to 'risky' addresses,
but uses the 'all' addresses instead. This reflects the name of the
chosen '-a' option that is already present in i2cdetect.

Changes from previous version:

 - Use 'all_addrs' name instead of 'risky_addr'
 - Remove 'risky' mentions in man pages
 - Remove 'risky' mentions in commits

Please review.
