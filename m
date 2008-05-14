From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Wed, 14 May 2008 07:48:36 -0700
Message-ID: <200805140748.36400.david-b@pacbell.net>
References: <200805012046.07885.david-b@pacbell.net>
	<200805120948.23842.david-b@pacbell.net>
	<20080514141738.327be680@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080514141738.327be680-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 14 May 2008, Jean Delvare wrote:
> Hi David,
> 
> On Mon, 12 May 2008 09:48:23 -0700, David Brownell wrote:
> > On Saturday 10 May 2008, Jean Delvare wrote:
> > > ... list your error value choices for the common
> > > error conditions of I2C and SMBus controllers ...
> > 
> > Here's a patch adding such information ... against 2.6.26-rc2 and
> > in synch with both the "-Errno not -1" patches I've sent.
> 
> Thanks for doing this. This document will be very helpful both for me
> when reviewing your patches, and for both I2C bus and I2C device driver
> authors later.

Exactly.  ;)

I addressed your comments; no further responses except as below.


> > +EBADMSG
> > +	Returned by SMBus logic when an invalid Packet Error Code byte
> > +	is received.  This code is a CRC covering all bytes in the
> > +	transaction, and is sent before the terminating STOP.  This
> > +	fault is only reported on read transactions; the SMBus slave
> > +	may have a way to report PEC mismatches on writes from the
> > +	host.  Note that even if PECs are in use, you should not rely
> > +	on these as the only way to detect incorrect data transfers.
> 
> As far as I can see, only the i2c-core is returning this error when
> SMBus is emulated over I2C, SMBus master drivers do not? 

I didn't check hardware specs or driver details for the three
adapters currently reporting I2C_FUNC_SMBUS_PEC:  amd8111, i801,
and nforce2.  So I don't know what they report ...


> If it is a 
> hardware limitation of most SMBus controllers then I wonder if it is
> worth having a separate error code just for i2c-core.

As a rule, it's important to know that an error is "soft" (like
PEC corruption) or not ... soft errors are very amenable to retries.

So even if those SMBus controllers have braindead designs which
don't let drivers know if the failure was from PEC, I'd think that
it's worth having such a code.  After all, it's not like there's
anything *preventing* sane nardware.  (Right?!?)


> > +EOPNOTSUPP
> > +	Returned by an adapter when asked to perform an operation
> > +	that it doesn't, or can't, support.  For example, if an
> > +	adapter doesn't support SMBus block transfers, this would
> > +	be returned when it is asked to issue one.  Or if an I2C
> > +	adapter can't execute all legal I2C messages, it should
> > +	return this in some cases.
> 
> It might be worth mentioning here that I2C device drivers are supposed
> to check the adapter functionality before they run any transaction. 

Done.


> So, 
> in most cases, I2C bus drivers would be in their own right to return
> -EINVAL when requested to perform operations they don't support.

I'll disagree.  The request was valid, and the only thing that
was inappropriate was sending it to *this* adapter.  Whether a
request is valid (or not) should be minimally context-sensitive.

It's an error to make a given valid request to certain adapters;
sure.  But the *reason* is that the adapter doesn't support such
calls ... not that the request itself is invalid.


>	As far as I remember, clock stretching by a slave during the
> address byte is not even allowed.

It's allowed anywhere.  Remember that one of the reasons to stretch
is to make sure the device has enough time to react ... and also
that multi-master configurations will effectively need to arbitrate
the clock signal (looks just like clock stretching), not just the
data signal.


> So, there is no need to mention ENXIO and the address byte here.

Right, I realized that but it was time to send for review rather
than make more edits.  ;)

Updated patch in a separate message.

- Dave




_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
