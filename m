From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
Date: Mon, 30 Nov 2009 23:19:20 +0000
Message-ID: <20091130231920.GB10705@n2100.arm.linux.org.uk>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <083DF309106F364B939360100EC290F804F55C9225-SIPbe8o7cfX8DdpCu65jn8FrZmdRls4ZQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 25, 2009 at 10:23:21PM +0100, Kevin Wells wrote:
> Remove suspend/resume functionality, I2C driver gates clock on
> only when an I2C transaction is in progress

Well, I'm happy with this (we have other drivers which don't do anything
spectacular in their suspend handling as well.)

Can you submit it to the patch system please?
