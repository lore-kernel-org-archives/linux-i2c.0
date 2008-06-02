From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on Freescale
	CPM1/CPM2 controllers
Date: Mon, 2 Jun 2008 14:03:46 -0700
Message-ID: <200806021403.46232.david-b@pacbell.net>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
	<20080602192630.GD6226@fluff.org.uk>
	<20080602215343.07ad6e02@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080602215343.07ad6e02-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 02 June 2008, Jean Delvare wrote:
> 
> > Sorry, I meant what happens if a NAK is received after the address
> > part of the i2c_msg has been sent, when sending the msg data? Is this
> > a case for an error like EPIPE, ENOLINK or EREMOTEIO?
> 
> Our current error codes document suggests EIO.

And also says it's sufficiently vague as to make avoiding it
be worthwhile.  :)


> EPIPE and ENOLINK do not 
> make much sense IMHO. EREMOTEIO would make some sense, but I suspect
> that many drivers won't be able to isolate this specific error and thus
> will still return EIO. David, what do you think?

This is one of those cases where the I2C programming interface is
insufficient.  As noted in the comment added to i2c_transfer() by
the patch updating fault code passthrough handling in i2c-core.c:

> >          *  - When we get a NAK after transmitting N bytes to a slave,
> >          *    there is no way to report "N" ... or to let the master
> >          *    continue executing the rest of this combined message, if
> >          *    that's the appropriate response.
 
As I mentioned earlier, the best way to address this issue would
be to carve a 16 bit field out of the existing struct padding and
use that from updated i2c_adapter drivers to report N (actual_len).

The standard way to report short writes is not via errno values...
but by reporting how many bytes were written.  See "man 2 write".
It's not what the I2C stack does now, though.

That could be done if i2c-core got some updates, at least with
any i2c adapters that get updated to better report this fault
(using that new field living in what's now struct padding).

Failing such updates, I'd avoid EREMOTEIO since that's what USB
uses to indicate short *reads* (not writes) when they're flagged
for reporting as errors (not the default).  EFBIG (too big)
would make more sense if short writes must be reported as some
kind of fault.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
