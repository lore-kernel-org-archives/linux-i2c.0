From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: i2c-tools release?
Date: Thu, 15 Jun 2017 11:47:12 +0200
Message-ID: <20170615094712.n5vgfjgwrlaho5e2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57763 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751620AbdFOJvx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 15 Jun 2017 05:51:53 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <ukl@pengutronix.de>)
        id 1dLRRQ-0006z5-HD
        for linux-i2c@vger.kernel.org; Thu, 15 Jun 2017 11:51:52 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.84_2)
        (envelope-from <ukl@pengutronix.de>)
        id 1dLRRQ-0008L5-9x
        for linux-i2c@vger.kernel.org; Thu, 15 Jun 2017 11:51:52 +0200
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, aurel32@debian.org

Hello Jean,

to get i2ctransfer into Debian it would be great to have a i2c-tools
release that contains it. Also

	2b4135907c1a ("decode-dimms: Correctly check for out-of-bounds vendor ID")

might be worth to "get in".

Could I lure you to cut a release?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
