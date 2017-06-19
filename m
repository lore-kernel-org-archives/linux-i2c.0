From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: core: Prevent race condition when removing i2c
 devices
Date: Mon, 19 Jun 2017 21:30:06 +0200
Message-ID: <2e4c5807-3d3c-1ce2-da35-3e37b2e3b08b@axentia.se>
References: <20170608024344.9311-1-david.thomson@alliedtelesis.co.nz>
 <20170619143656.zigxk77vegedscjx@ninjato>
 <24ee1e30-1737-e3ef-a23e-01d41a29d45f@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00102.outbound.protection.outlook.com ([40.107.0.102]:20811
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752910AbdFSTaP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 15:30:15 -0400
In-Reply-To: <24ee1e30-1737-e3ef-a23e-01d41a29d45f@axentia.se>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, David Thomson <david.thomson@alliedtelesis.co.nz>
Cc: linux-i2c@vger.kernel.org

On 2017-06-19 18:34, Peter Rosin wrote:
> It would certainly be nice to know why .owner is clobbered, because I
> don't see it. But then again, I don't know what sources I should be
> reading...

BTW, one thing I noticed when reading the current code is that I see this
at the end of i2c_del_adapter:

	/* Clear the device structure in case this adapter is ever going to be
	   added again */
	memset(&adap->dev, 0, sizeof(adap->dev));
}
EXPORT_SYMBOL(i2c_del_adapter);


which is not very compatible with this part of the device_add() docs:


 * Do not call this routine or device_register() more than once for
 * any device structure.  The driver model core is not designed to work
 * with devices that get unregistered and then spring back to life.
 * (Among other things, it's very hard to guarantee that all references
 * to the previous incarnation of @dev have been dropped.)  Allocate
 * and register a fresh new struct device instead.


That, of course, probably have no bearing on the problem/patch in this
thread...

Or maybe struct device reuse is exactly what is going on???

Cheers,
peda
