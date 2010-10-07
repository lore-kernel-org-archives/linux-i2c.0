From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix Kconfig dependencies
Date: Thu, 7 Oct 2010 15:24:42 +0200
Message-ID: <20101007152442.1901a630@endymion.delvare>
References: <1286199093-3576-1-git-send-email-mmarek@suse.cz>
	<20101004180346.59b10af7@endymion.delvare>
	<20101004223020.GA14702@sepie.suse.cz>
	<20101005100349.73914574@endymion.delvare>
	<20101005155631.GA9399@sepie.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101005155631.GA9399-pWU8U5UiEOyN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michal,

On Tue, 5 Oct 2010 17:56:31 +0200, Michal Marek wrote:
> On Tue, Oct 05, 2010 at 10:03:49AM +0200, Jean Delvare wrote:
> > Hmm, too bad. What about the following then? It's nor exactly elegant,
> > but if it works for you...
> > 
> > ---
> >  drivers/i2c/Kconfig       |    3 ++-
> >  drivers/i2c/algos/Kconfig |   13 +++++++++++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > --- linux-2.6.36-rc6.orig/drivers/i2c/algos/Kconfig	2010-10-05 09:01:34.000000000 +0200
> > +++ linux-2.6.36-rc6/drivers/i2c/algos/Kconfig	2010-10-05 09:40:40.000000000 +0200
> > @@ -15,3 +15,16 @@ config I2C_ALGOPCA
> >  	tristate "I2C PCA 9564 interfaces"
> >  
> >  endmenu
> > +
> > +# In automatic configuration mode, we still have to define the
> > +# symbols to avoid unmet dependencies.
> > +
> > +if I2C_HELPER_AUTO
> > +config I2C_ALGOBIT
> > +	tristate
> > +config I2C_ALGOPCF
> > +	tristate
> > +config I2C_ALGOPCA
> > +	tristate
> > +endif
> > +
> > --- linux-2.6.36-rc6.orig/drivers/i2c/Kconfig	2010-10-05 09:01:34.000000000 +0200
> > +++ linux-2.6.36-rc6/drivers/i2c/Kconfig	2010-10-05 09:04:57.000000000 +0200
> > @@ -75,7 +75,8 @@ config I2C_HELPER_AUTO
> >  	  In doubt, say Y.
> >  
> >  config I2C_SMBUS
> > -	tristate "SMBus-specific protocols" if !I2C_HELPER_AUTO
> > +	tristate
> > +	prompt "SMBus-specific protocols" if !I2C_HELPER_AUTO
> 
> This works for me, thanks!
> 
> Acked-by: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>

OK, I've applied this patch. I doubt I can get it in Linus' tree before
2.6.36 is release though, my previous pull request wasn't even
acknowledged yet.

Then we will have to discuss about a better solution with Roman Zippel,
because what we have now is all but elegant. Will you start the
discussion, or should I?

-- 
Jean Delvare
