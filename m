From: Max Staudt <mstaudt@suse.de>
Subject: Re: entering the error case of i2c-designware with a timeout at probe
Date: Tue, 21 Mar 2017 13:57:16 +0100
Message-ID: <88af9925-fea6-83af-a8ee-67feb87d59e6@suse.de>
References: <1490100731.8154.13.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53259 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757258AbdCUM53 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 08:57:29 -0400
In-Reply-To: <1490100731.8154.13.camel@suse.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Oliver Neukum <ONeukum@suse.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-i2c@vger.kernel.org

On 03/21/2017 01:52 PM, Oliver Neukum wrote:
> Hi Hans,
> 
> we found on our test systems with a bit of experimentation,
> that actually running into the timeout is bound to hang the whole
> system within only a few seconds.
> I was wondering whether the error handling needs to be changed.

In other words, whether we should rather wait for lock acquisition,
unconditionally. No timeout, just wait. That's what our hardware
seems to need.

It feels like once the lock has been requested by the Linux driver,
we can't cancel that request and have to actually follow through
with accepting the lock and only giving it back after that.
Resetting the "request" bit to 0 as it is done now doesn't work as
it leads to the hung system sometime soon after that.


Max
