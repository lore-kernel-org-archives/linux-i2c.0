From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-algo-bit: Refactor adapter registration
Date: Mon, 13 Dec 2010 23:47:23 +0000
Message-ID: <20101213234723.GZ20097@trinity.fluff.org>
References: <20101207110631.6222cfed@endymion.delvare> <20101207115131.GM20097@trinity.fluff.org> <4CFE21A7.9020901@gmx.de> <20101207182943.1e31507b@endymion.delvare> <4CFF56F6.1000606@gmx.de> <20101208143236.5f9082af@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101208143236.5f9082af-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 08, 2010 at 02:32:36PM +0100, Jean Delvare wrote:
> On Wed, 08 Dec 2010 10:59:18 +0100, Michael Lawnick wrote:
> > Jean Delvare said the following:
> > > Hi Michael, Ben,
> > > 
> > > On Tue, 07 Dec 2010 12:59:35 +0100, Michael Lawnick wrote:
> > >> Ben Dooks said the following:
> > >> > On Tue, Dec 07, 2010 at 11:06:31AM +0100, Jean Delvare wrote:
> > >> >> Use a function pointer to decide whether to call i2c_add_adapter or
> > >> >> i2c_add_numbered_adapter. This makes the code more compact than the
> > >> >> current strategy of having the common code in a separate function.
> > >> > 
> > >> > ok, how about changing i2c_add_numbered_adapter to take a -1 to mean
> > >> > assign bus number automatically? or something similar?
> > >> 
> > >> IMHO better: i2c_add_adapter with optional (-1) bus parameter?
> > > 
> > > Which problem are you both trying to solve, please?
> >
> > Function pointers tend to hide information. Seeing the targeted function
> > in source code makes it more clear, IMHO.
> 
> This doesn't sound like a valid argument when the provider of the
> function pointer is only 20 lines away from the call site in the very
> same file, sorry.
> 
> Adding a parameter to i2c_add_adapter would mean changing 105 calling
> sites. You have to understand that we aren't going to do that without a
> very good reason. Ben's proposal is equally invasive, as every current
> call to i2c_add_adapter would have to set the id to -1 before. This
> means changing 74 drivers for a marginal benefit.
> 
> If someday calls to i2c_add_numbered_adapter() outnumber calls to
> i2c_add_adapter() by a factor 3, we can reconsider. But this isn't the
> case today. I am not particularly happy with the current situation
> myself, but it seemed like the best option when
> i2c_add_numbered_adapter() was introduced, and I see no reason to
> reconsider at this point in time.

How about adding an in-lined (in header) something this like:

static inline int i2c_add_adapter(struct i2c_adapter *adap)
{
	return i2c_add_numbered_adapter(-1, adap);
}

anyway, not desperately important (and code not tested either)

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
