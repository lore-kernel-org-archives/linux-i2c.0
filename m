From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-algo-bit: Refactor adapter registration
Date: Tue, 14 Dec 2010 08:46:09 +0100
Message-ID: <20101214084609.5fcc7cd6@endymion.delvare>
References: <20101207110631.6222cfed@endymion.delvare>
	<20101207115131.GM20097@trinity.fluff.org>
	<4CFE21A7.9020901@gmx.de>
	<20101207182943.1e31507b@endymion.delvare>
	<4CFF56F6.1000606@gmx.de>
	<20101208143236.5f9082af@endymion.delvare>
	<20101213234723.GZ20097@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101213234723.GZ20097-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 13 Dec 2010 23:47:23 +0000, Ben Dooks wrote:
> On Wed, Dec 08, 2010 at 02:32:36PM +0100, Jean Delvare wrote:
> > On Wed, 08 Dec 2010 10:59:18 +0100, Michael Lawnick wrote:
> > > Function pointers tend to hide information. Seeing the targeted function
> > > in source code makes it more clear, IMHO.
> > 
> > This doesn't sound like a valid argument when the provider of the
> > function pointer is only 20 lines away from the call site in the very
> > same file, sorry.
> > 
> > Adding a parameter to i2c_add_adapter would mean changing 105 calling
> > sites. You have to understand that we aren't going to do that without a
> > very good reason. Ben's proposal is equally invasive, as every current
> > call to i2c_add_adapter would have to set the id to -1 before. This
> > means changing 74 drivers for a marginal benefit.
> > 
> > If someday calls to i2c_add_numbered_adapter() outnumber calls to
> > i2c_add_adapter() by a factor 3, we can reconsider. But this isn't the
> > case today. I am not particularly happy with the current situation
> > myself, but it seemed like the best option when
> > i2c_add_numbered_adapter() was introduced, and I see no reason to
> > reconsider at this point in time.
> 
> How about adding an in-lined (in header) something this like:
> 
> static inline int i2c_add_adapter(struct i2c_adapter *adap)
> {
> 	return i2c_add_numbered_adapter(-1, adap);
> }
> 
> anyway, not desperately important (and code not tested either)

i2c_add_numbered_adapter doesn't take the bus number as a parameter, it
reads it from adap->nr. So the inline function would rather be:

static inline int i2c_add_adapter(struct i2c_adapter *adap)
{
	adap->nr = -1;
	return i2c_add_numbered_adapter(adap);
}

But then again, which problem are you trying to solve? What you propose
it different from what we have today, but I fail to see how it would be
_better_ than what we have today.

-- 
Jean Delvare
