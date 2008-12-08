From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2/2] i2c: trivial endian casting fixes in
 i2c-highlander.c
Date: Mon, 8 Dec 2008 09:21:15 +0100
Message-ID: <20081208092115.15e15131@hyperion.delvare>
References: <200812012217.mB1MHeUA011076@imap1.linux-foundation.org>
	<20081205144605.755f2445@hyperion.delvare>
	<20081208030757.GC8860@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081208030757.GC8860-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Paul,

On Mon, 8 Dec 2008 12:07:58 +0900, Paul Mundt wrote:
> On Fri, Dec 05, 2008 at 02:46:05PM +0100, Jean Delvare wrote:
> > On Mon, 01 Dec 2008 14:17:40 -0800, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:
> > > From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > 
> > > Fixes sparse warnings:
> > > drivers/i2c/busses/i2c-highlander.c:95:26: warning: incorrect type in argument 1 (different base types)
> > > drivers/i2c/busses/i2c-highlander.c:95:26:    expected restricted __be16 const [usertype] *p
> > > drivers/i2c/busses/i2c-highlander.c:95:26:    got unsigned short [usertype] *<noident>
> > > drivers/i2c/busses/i2c-highlander.c:106:15: warning: incorrect type in assignment (different base types)
> > > drivers/i2c/busses/i2c-highlander.c:106:15:    expected unsigned short [unsigned] [short] [usertype] <noident>
> > > drivers/i2c/busses/i2c-highlander.c:106:15:    got restricted __be16
> > > 
> > > Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> > > ---
> > > 
> > >  drivers/i2c/busses/i2c-highlander.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff -puN drivers/i2c/busses/i2c-highlander.c~i2c-trivial-endian-casting-fixes-in-i2c-highlanderc drivers/i2c/busses/i2c-highlander.c
> > > --- a/drivers/i2c/busses/i2c-highlander.c~i2c-trivial-endian-casting-fixes-in-i2c-highlanderc
> > > +++ a/drivers/i2c/busses/i2c-highlander.c
> > > @@ -92,7 +92,7 @@ static void highlander_i2c_setup(struct 
> > >  static void smbus_write_data(u8 *src, u16 *dst, int len)
> > >  {
> > >  	for (; len > 1; len -= 2) {
> > > -		*dst++ = be16_to_cpup((u16 *)src);
> > > +		*dst++ = be16_to_cpup((__be16 *)src);
> > >  		src += 2;
> > >  	}
> > >  
> > > @@ -103,7 +103,7 @@ static void smbus_write_data(u8 *src, u1
> > >  static void smbus_read_data(u16 *src, u8 *dst, int len)
> > >  {
> > >  	for (; len > 1; len -= 2) {
> > > -		*(u16 *)dst = cpu_to_be16p(src++);
> > > +		*(__be16 *)dst = cpu_to_be16p(src++);
> > >  		dst += 2;
> > >  	}
> > >  
> > 
> > Ben, Paul, any comment on this?
> > 
> It's fine with me, do you want to take this, or should I fold it in to my
> tree?
> 
> Acked-by: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>

This patch is in my tree and will go to Linus at the end of the week,
unless you prefer to pick it.

Thanks,
-- 
Jean Delvare
