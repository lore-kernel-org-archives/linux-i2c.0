From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
Subject: Re: [PATCH 7/8] drivers/i2c/busses/i2c-amd8111.c: Fix unsigned return
   type
Date: Wed, 29 Sep 2010 21:47:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009292147060.25609@ask.diku.dk>
References: <Pine.LNX.4.64.1009080757050.27892@ask.diku.dk>
 <20100908093449.0adef429@hyperion.delvare> <Pine.LNX.4.64.1009081148040.3297@ask.diku.dk>
 <20100929174606.616e564c@endymion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100929174606.616e564c-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Ben Dooks (em, bedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 29 Sep 2010, Jean Delvare wrote:

> Hi Julia,
> 
> On Wed, 8 Sep 2010 11:48:17 +0200 (CEST), Julia Lawall wrote:
> > OK, thanks. I will look at the code again.
> 
> Any update on this patch?

No, I'm sorry.  I haven't forgotten it, but I haven't looked at it 
either.  I should be able to do so in a few days.

julia

> > On Wed, 8 Sep 2010, Jean Delvare wrote:
> > 
> > > Hi Julia,
> > > 
> > > On Wed, 8 Sep 2010 07:58:45 +0200 (CEST), Julia Lawall wrote:
> > > > From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
> > > > 
> > > > In each case, the function has an unsigned return type, but returns a
> > > > negative constant to indicate an error condition.  The result of calling
> > > > the function is always stored in a variable of type (signed) int, and thus
> > > > unsigned can be dropped from the return type.
> > > > 
> > > > A sematic match that finds this problem is as follows:
> > > > (http://coccinelle.lip6.fr/)
> > > > 
> > > > // <smpl>
> > > > @exists@
> > > > identifier f;
> > > > constant C;
> > > > @@
> > > > 
> > > >  unsigned f(...)
> > > >  { <+...
> > > > *  return -C;
> > > >  ...+> }
> > > > // </smpl>
> > > > 
> > > > Signed-off-by: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
> > > > 
> > > > ---
> > > >  drivers/i2c/busses/i2c-amd8111.c |    4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
> > > > index af1e5e2..02a3726 100644
> > > > --- a/drivers/i2c/busses/i2c-amd8111.c
> > > > +++ b/drivers/i2c/busses/i2c-amd8111.c
> > > > @@ -69,7 +69,7 @@ static struct pci_driver amd8111_driver;
> > > >   * ACPI 2.0 chapter 13 access of registers of the EC
> > > >   */
> > > >  
> > > > -static unsigned int amd_ec_wait_write(struct amd_smbus *smbus)
> > > > +static int amd_ec_wait_write(struct amd_smbus *smbus)
> > > >  {
> > > >  	int timeout = 500;
> > > >  
> > > > @@ -85,7 +85,7 @@ static unsigned int amd_ec_wait_write(struct amd_smbus *smbus)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static unsigned int amd_ec_wait_read(struct amd_smbus *smbus)
> > > > +static int amd_ec_wait_read(struct amd_smbus *smbus)
> > > >  {
> > > >  	int timeout = 500;
> > > >  
> > > > 
> > > 
> > > Thanks for reporting. Unfortunately the fix above is incomplete.
> > > amd_ec_wait_write() and amd_ec_wait_read() are called by amd_ec_read()
> > > and amd_ec_write(), which will now attempt to return negative error
> > > codes as unsigned ints. So amd_ec_read() and amd_ec_write() must have
> > > their return type fixed too.
> > > 
> > > Note that the driver code never checks for errors returned by
> > > amd_ec_read() or amd_ec_write() anyway, so the fix alone is a no-op. A
> > > real fix would have to also update the caller sites to properly deal
> > > with errors if then happen.
> > > 
> > > -- 
> > > Jean Delvare
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> > > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> -- 
> Jean Delvare
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
