From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on Freescale
 CPM1/CPM2 controllers
Date: Tue, 3 Jun 2008 12:06:25 +0200
Message-ID: <20080603120625.7bde7698@hyperion.delvare>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
	<20080602192630.GD6226@fluff.org.uk>
	<20080602215343.07ad6e02@hyperion.delvare>
	<200806021403.46232.david-b@pacbell.net>
	<20080602221923.GF6226@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080602221923.GF6226-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben, hi David,

On Mon, 2 Jun 2008 23:19:23 +0100, Ben Dooks wrote:
> On Mon, Jun 02, 2008 at 02:03:46PM -0700, David Brownell wrote:
> > On Monday 02 June 2008, Jean Delvare wrote:
> > > 
> > > > Sorry, I meant what happens if a NAK is received after the address
> > > > part of the i2c_msg has been sent, when sending the msg data? Is this
> > > > a case for an error like EPIPE, ENOLINK or EREMOTEIO?
> > > 
> > > Our current error codes document suggests EIO.
> > 
> > And also says it's sufficiently vague as to make avoiding it
> > be worthwhile.  :)
> > 
> > 
> > > EPIPE and ENOLINK do not 
> > > make much sense IMHO. EREMOTEIO would make some sense, but I suspect
> > > that many drivers won't be able to isolate this specific error and thus
> > > will still return EIO. David, what do you think?
> > 
> > This is one of those cases where the I2C programming interface is
> > insufficient.  As noted in the comment added to i2c_transfer() by
> > the patch updating fault code passthrough handling in i2c-core.c:
> > 
> > > >          *  - When we get a NAK after transmitting N bytes to a slave,
> > > >          *    there is no way to report "N" ... or to let the master
> > > >          *    continue executing the rest of this combined message, if
> > > >          *    that's the appropriate response.
> 
> I thought the i2c_msg flag to ignore NAK was the way to let the master
> continue, although this does mean that you loose the fact that a NAK
> actually happened.
> 
> The case of letting the master continue after such an error still
> makes reporting the amount of data written difficult, how do you
> indicate I wrote m bytes, got an error, and then continued on to
> write all n bytes of the i2c_msgs provided? Can anyone think of
> an actual example of where this would be useful?

The "ignore nack" flag is a hack, it's a divergence from the I2C
standard to support a couple broken devices out there. We don't give a
damn to reporting fine-grained errors when using it.

>   
> > As I mentioned earlier, the best way to address this issue would
> > be to carve a 16 bit field out of the existing struct padding and
> > use that from updated i2c_adapter drivers to report N (actual_len).
> 
> So you are suggesting adding a done field to the i2c_msg structure
> that is updated by the bus driver as it goes along? For arm, this
> should fit, but are there any other architectures out there that are
> going to be affected by this change in structure (it does, iirc, get
> exported to userspace).

Yes, it is exported to user-space. But I guess that the binary
compatibility constraints are the same for user-space and kernel-space.

> 
> If you add a __u16 done field to the i2c_msg, then you either have to
> find a special value for 'not filled in' and have the i2c core fill
> in the i2c_msg array at start time?
> 
> > The standard way to report short writes is not via errno values...
> > but by reporting how many bytes were written.  See "man 2 write".
> > It's not what the I2C stack does now, though.
> 
> Yes, that does make sense to return the amount of data written to
> the user, however having a quick look through all users of
> i2c_transfer() all just want to know if all the messages where
> sent (which is an easier check that to compute the amount of
> data in all the messages).
> 
> Would it better to add an new i2c_transfer-alike call which would
> return the amount of data written, instead of going around modifying
> all users of i2c_transfer() ? This would also make transfering from
> one call to the other, with i2c_transfer becoming deprecated?
> 
> I was just wondering if it would be useful to add an extra field
> after the buffer to indicate the error that happened to the message
> such as NAK, bus arbitration, etc.

The main question here is: who needs this? I2C errors don't happen
frequently, and when they happen, how many devices are able to recover
with a partial transaction based on how far the initial transaction
went? I suspect that most devices will need to restart the transaction
from scratch anyway, and for those who could spare a few bytes, it it
really worth it? Driver authors most certainly won't bother.

Given the compatibility constraints, this all looks like a lot of work
and pain for a benefit which is essentially aesthetic. I agree that the
current API isn't nice, but very much doubt that there's anything to
win by reworking it in practice. So I think my time will be much better
used for other matters.

>  
> > That could be done if i2c-core got some updates, at least with
> > any i2c adapters that get updated to better report this fault
> > (using that new field living in what's now struct padding).
> 
> As noted above, is it padding on _all_ architectures?
>  
> > Failing such updates, I'd avoid EREMOTEIO since that's what USB
> > uses to indicate short *reads* (not writes) when they're flagged
> > for reporting as errors (not the default).  EFBIG (too big)
> > would make more sense if short writes must be reported as some
> > kind of fault.
> 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
