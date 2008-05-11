From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Sun, 11 May 2008 01:17:22 -0700
Message-ID: <200805110117.23023.david-b@pacbell.net>
References: <200805012046.07885.david-b@pacbell.net>
	<20080510225548.36297637@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080510225548.36297637-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Saturday 10 May 2008, Jean Delvare wrote:
> >  drivers/i2c/.............................
> >  15 files changed, 176 insertions(+), 142 deletions(-)

So I'll probably respond to your comments in smaller chunks.  ;)

Arguably this should become a bunch of smaller patches, but that 
would of course make more confusion during initial review for
this type change ... harder to notice the patterns.


> > --- g26.orig/drivers/i2c/algos/i2c-algo-bit.c	2008-05-01 16:01:38.000000000 -0700
> > +++ g26/drivers/i2c/algos/i2c-algo-bit.c	2008-05-01 16:02:58.000000000 -0700
> > 		...
> > @@ -465,9 +465,12 @@ static int bit_doAddress(struct i2c_adap
> >  	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
> >  
> >  	unsigned char addr;
> > -	int ret, retries;
> > +	int ret;
> > +	unsigned retries;
> >  
> > -	retries = nak_ok ? 0 : i2c_adap->retries;
> > +	retries = (nak_ok || i2c_adap->retries < 0)
> > +			? 0
> > +			: i2c_adap->retries;
> >  
> >  	if (flags & I2C_M_TEN) {
> >  		/* a ten bit address */
> 
> I'd rather not bother with the adap->retries stuff which we agreed
> should be removed anyway.

Until it's gone, I just wanted to be sane with it.  Or should
we just rip it out of this driver?  Negative retries is a very
nonsensical notion, and that's the only way I recall algo-bit
seemed to have obvious (albeit potential) fault code goofiness.

(Other than returning an odd code for devices that don't ACK
their address; see below.)


> > --- g26.orig/drivers/i2c/busses/i2c-ali1535.c	2008-05-01 16:01:39.000000000 -0700
> > +++ g26/drivers/i2c/busses/i2c-ali1535.c	2008-05-01 16:02:58.000000000 -0700
> > 			...
> > @@ -295,7 +295,7 @@ static int ali1535_transaction(struct i2
> >  	 * do a printk.  This means that bus collisions go unreported.
> >  	 */
> >  	if (temp & ALI1535_STS_BUSERR) {
> > -		result = -1;
> > +		result = -EIO;
> 
> Given the comment above I'd make this -ENODEV. 99% of the time, no ack
> means no device.

Either ENODEV or ENXIO for "it didn't ACK the address".  Any
other code will make the driver core emit diagnostics when the
probe() fails ... diagnostics we want to avoid, when probe()
code does the Right Thing and just returns such fault codes.

That's probably an issue with most of these updates.


>		...
> > @@ -359,7 +359,7 @@ static s32 ali1535_access(struct i2c_ada
> >  	switch (size) {
> >  	case I2C_SMBUS_PROC_CALL:
> >  		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
> > -		result = -1;
> > +		result = -EOPNOTSUPP;
> >  		goto EXIT;
> 
> Side note for a next patch: there's a bug here, this should be handled
> by a catch-all at the end on the switch, but I see it is missing.

Right, several drivers copied the same goofy template and
its bugs.  (So assume I agree on repeatis of those issues,
in the interest of brevity.)


> > --- g26.orig/drivers/i2c/busses/i2c-amd756-s4882.c	2008-05-01 16:01:38.000000000 -0700
> > +++ g26/drivers/i2c/busses/i2c-amd756-s4882.c	2008-05-01 16:02:58.000000000 -0700
> > @@ -58,7 +58,7 @@ static s32 amd756_access_virt0(struct i2
> >  	/* We exclude the multiplexed addresses */
> >  	if (addr == 0x4c || (addr & 0xfc) == 0x50 || (addr & 0xfc) == 0x30
> >  	 || addr == 0x18)
> > -		return -1;
> > +		return -EINVAL;
> >  
> >  	mutex_lock(&amd756_lock);
> >  
> > @@ -86,7 +86,7 @@ static inline s32 amd756_access_channel(
> >  
> >  	/* We exclude the non-multiplexed addresses */
> >  	if (addr != 0x4c && (addr & 0xfc) != 0x50 && (addr & 0xfc) != 0x30)
> > -		return -1;
> > +		return -EINVAL;
> >  
> >  	mutex_lock(&amd756_lock);
> 
> For these two I'd go for -ENODEV as well. It's a little unfair to
> return -EINVAL, given that we are hiding the devices from the caller on
> purpose and they couldn't guess.

That might be a case where -ENXIO could provide a useful distinction.
"No such device *OR ADDRESS*" vs "No such device".  ;)

 
> > --- g26.orig/drivers/i2c/busses/i2c-amd756.c	2008-05-01 16:01:39.000000000 -0700
> > +++ g26/drivers/i2c/busses/i2c-amd756.c	2008-05-01 16:02:58.000000000 -0700
> > @@ -151,17 +151,17 @@ static int amd756_transaction(struct i2c
> >  	}
> >  
> >  	if (temp & GS_PRERR_STS) {
> > -		result = -1;
> > +		result = -EIO;
> >  		dev_dbg(&adap->dev, "SMBus Protocol error (no response)!\n");
> 
> This one would be -ENODEV.

How are you knowing all these things?  I wouldn't interpret
"protocol error" as "no device".  And while I do happen to
have amd756 docs around (board broken though, sigh) I didn't
dig that info out ... I'd be less concerned with reporting
needlessly generic (EIO) errors than with wrongly reporting
ones that are too specific (ENODEV).

That's kind of a general issue with this patch.  I think my
first idea was to stop reporting "-EPERM" for everything and
provide plausible codes, but allow updates later.  I can't
imagine every fault report, the first time around, will be
the best one we could be reporting.


> > --- g26.orig/drivers/i2c/busses/i2c-i801.c	2008-05-01 16:01:38.000000000 -0700
> > +++ g26/drivers/i2c/busses/i2c-i801.c	2008-05-01 16:02:58.000000000 -0700
> > 			....

Though didn't I see a patch removing this driver?


> > @@ -179,19 +179,19 @@ static int i801_transaction(int xact)
> >  	}
> >  
> >  	if (temp & SMBHSTSTS_FAILED) {
> > -		result = -1;
> > +		result = -EIO;
> >  		dev_dbg(&I801_dev->dev, "Error: Failed bus transaction\n");
> >  	}
> >  
> >  	if (temp & SMBHSTSTS_BUS_ERR) {
> > -		result = -1;
> > +		result = -EIO;
> >  		dev_err(&I801_dev->dev, "Bus collision! SMBus may be locked "
> >  			"until next hard reset. (sorry!)\n");
> >  		/* Clock stops and slave is stuck in mid-transmission */
> >  	}
> >  
> >  	if (temp & SMBHSTSTS_DEV_ERR) {
> > -		result = -1;
> > +		result = -EIO;
> >  		dev_dbg(&I801_dev->dev, "Error: no response!\n");
> 
> -ENODEV

Is that *really* a "no response to address" error?

But there's another issue with that type of code.  This
particular one looks maybe sane ... in the sense that it
seems to replace generic fault codes with more specific
ones (maybe), but I don't think all the I2C adapters were
doing that.  Some of them looked like they were testing
the specific faults first, then clobbering them with vague
generic idicators...


> > +	if (status)
> > +		return status;
> >  
> >  	if (read_write == I2C_SMBUS_READ) {
> >  		len = inb_p(SMBHSTDAT0);
> >  		if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
> > -			return -1;
> > +			return -EILSEQ;
> 
> Huh, definitely not. This error code has to so with multi-byte
> character encoding, that's inappropriate here.

No; most of the errno values get recycled.  "Illegal Byte Sequence"
is exactly what we got there, in fact!  I know that USB has used
EILSEQ for some years (indicating a lowlevel bit protocol failure),
and MMC is using it too.

So if you want to say "not", it should be for some better reason
than that...


> I'd return -EINVAL, or 
> -EREMOTEIO if you think EINVAL is unfair for the caller.

It's not an I/O error; the I/O actually worked, it's the bytes
that were wrong.  It's not an "argument" provided by the caller.
So neither of those codes seems appropriate.


> But most 
> likely, if the returned length is not within the SMBus specifications,
> it means that the caller ran an SMBus block transaction at the wrong
> offset or on a device that doesn't support it, so -EINVAL seems
> reasonable to me.

That's only a guess though.  All we *know* is that we saw an
illegal byte sequence...

 
... enough for now.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
