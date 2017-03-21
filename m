From: Oliver Neukum <oneukum@suse.com>
Subject: entering the error case of i2c-designware with a timeout at probe
Date: Tue, 21 Mar 2017 13:52:11 +0100
Message-ID: <1490100731.8154.13.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756964AbdCUMxB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 08:53:01 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-i2c@vger.kernel.org, mstaudt@suse.com

Hi Hans,

we found on our test systems with a bit of experimentation,
that actually running into the timeout is bound to hang the whole
system within only a few seconds.
I was wondering whether the error handling needs to be changed.

	Regards
		Oliver
