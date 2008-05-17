From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.26-rc1-git] i2c-core: return -Errno, not -1
Date: Sat, 17 May 2008 08:15:37 +0200
Message-ID: <20080517081537.17220cd0@hyperion.delvare>
References: <200805031306.16698.david-b@pacbell.net>
	<200805111516.08453.david-b@pacbell.net>
	<20080516091458.28f9f5ca@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080516091458.28f9f5ca-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 16 May 2008 09:14:58 +0200, Jean Delvare wrote:
> Hi David,
> 
> On Sun, 11 May 2008 15:16:07 -0700, David Brownell wrote:
> > More updates to the I2C stack's fault reporting:  make the core stop
> > returning "-1" (usually "-EPERM") for all faults.  Instead, pass lower
> > level fault code up the stack, or return some appropriate errno.
> > 
> > This patch happens to touch almost exclusively SMBus calls.
> > 
> > Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > ---
> > This is an updated version of:
> > 	http://marc.info/?l=i2c&m=120984528415259&w=2
> > with some return codes updated to address feedback from the similar
> > patch for the x86 I2C/SMBus adapters.
> > 
> >  drivers/i2c/i2c-core.c |   78 +++++++++++++++++++++++++++----------------------
> >  1 file changed, 44 insertions(+), 34 deletions(-)
> > 
> 
> Looks very good, with just one suggested change:
> 
> > --- g26.orig/drivers/i2c/i2c-core.c	2008-05-11 13:07:56.000000000 -0700
> > +++ g26/drivers/i2c/i2c-core.c	2008-05-11 15:09:00.000000000 -0700
> > (...)
> > @@ -1568,7 +1576,7 @@ static s32 i2c_smbus_xfer_emulated(struc
> >  	default:
> >  		dev_err(&adapter->dev, "smbus_access called with invalid size (%d)\n",
> >  		       size);
> > -		return -1;
> > +		return -EOPNOTSUPP;
> >  	}
> 
> I'd rather use -EINVAL here. (...)

Hmh, scratch this. Thinking about it some more (night helps)
-EOPNOTSUPP is consistent with what we did for the bus drivers after
all, and it also anticipates addition of new transaction types to
<linux/i2c.h> or removal of support for some transaction types from
i2c_smbus_xfer_emulated() (which might as well happen, if you look
carefully you'll see that there are no in-kernel users of transaction
types I2C_SMBUS_PROC_CALL and I2C_SMBUS_BLOCK_PROC_CALL so we might
decide to remove thir support from i2c_smbus_xfer_emulated someday.)

> (..)
> BTW, feel free to adjust the debugging message above, as you did in
> some bus drivers already, to clearly say that we're speaking about a
> transaction type and not a "size".
> 
> All the rest looks OK to me from a functional point of view. As far as
> style is concerned, please keep the alignment on opening parenthesis
> when the original code did that. i2c-core uses this style consistently
> and I like it.

I'll do all this myself now, no need to resend.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
