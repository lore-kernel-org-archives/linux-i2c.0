From: Romain Porte <romain.porte@nokia.com>
Subject: Patch proposal for risky addr, with updated help messages
Date: Mon, 29 Jan 2018 14:57:25 +0100
Message-ID: <20180129135728.2313-1-romain.porte@nokia.com>
References: <20180105150248.3170-1-romain.porte@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr20119.outbound.protection.outlook.com ([40.107.2.119]:46747
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751378AbeA2N6O (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 29 Jan 2018 08:58:14 -0500
In-Reply-To: <20180105150248.3170-1-romain.porte@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: jdelvare@suse.de, peda@axentia.se, linux-i2c@vger.kernel.org

Nice remark from Peter Rosin about not updated help messages.
I however did not update the i2ctransfert help message due to
no mention to i2c address limits in the original help message.

Changes from PATCH v2:

 - Updated help messages in tools in order to see -a influence
   where explicit i2c limits are mentionned to the user.
