From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v6 07/19] i2c: octeon: Use i2c recovery framework
Date: Thu, 21 Apr 2016 15:08:35 +0200
Message-ID: <20160421130835.GA2623@hardcore>
References: <cover.1460387640.git.jglauber@cavium.com>
 <ab24627b5928f23967633243639b431d2113dbe1.1460387640.git.jglauber@cavium.com>
 <20160420213121.GC1546@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1bon0061.outbound.protection.outlook.com ([157.56.111.61]:30337
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751302AbcDUNXD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Apr 2016 09:23:03 -0400
Content-Disposition: inline
In-Reply-To: <20160420213121.GC1546@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

On Wed, Apr 20, 2016 at 11:31:21PM +0200, Wolfram Sang wrote:
> On Mon, Apr 11, 2016 at 05:28:38PM +0200, Jan Glauber wrote:
> > Switch to the i2c bus recovery framework using generic SCL recovery.
> > If this fails try to reset the hardware. The recovery is triggered
> > during START on timeout of the interrupt or failure to reach
> > the START / repeated-START condition.
> > 
> > The START function is moved to xfer and while at it:
> > - removed xfer debug message (i2c core already provides debugging)
> > - removed length is zero check
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > ---
> >  drivers/i2c/busses/i2c-octeon.c | 178 +++++++++++++++++++++++++---------------
> >  1 file changed, 111 insertions(+), 67 deletions(-)
> 
> Interesting, it got larger...
> 
> > 
> > +/**
> > + * octeon_i2c_write_int - read the TWSI_INT register
> 
> read_int

OK

> > +	int ret, retries = 2;
> 
> I don't think 'retries' makes sense here. On failure, you return
> -EAGAIN, so the core will retry 'adapter->retries' times anyhow.

OK. I'll remove the retry looping and call recovery once
if the START condition is not reached. If recovery succeeds
I'll return -EAGAIN, otherwise the error code.

> > -	if (length < 1)
> > -		return -EINVAL;
> 
> So, the adapter support 0-length messages now? Or why was it there? I
> have the feeling this is a seperate patch.

I assumed this check was bogus and there are no valid 0-length
messages...
If 0-length messages can indeed happen I'll keep this check (but why
would the i2c core not check for that in a central place and return
an error before calling xfer() ?).

> > +static void octeon_i2c_prepare_recovery(struct i2c_adapter *adap)
> > +{
> > +	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
> > +
> > +	/*
> > +	 * The stop resets the state machine, does not _transmit_ STOP unless
> > +	 * engine was active.
> > +	 */
> > +	octeon_i2c_stop(i2c);
> > +
> > +	octeon_i2c_write_int(i2c, 0);
> 
> Maybe a comment why the delay?

Later patch "Flush TWSI writes with readback" adds synchronization after
octeon_i2c_write_int(), so the delays in prepare/unprepare_recovery can
go away.

> > +	udelay(5);
> > +}
