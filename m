From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Date: Sat, 12 Jul 2008 23:59:03 -0400
Message-ID: <9e4733910807122059q6ca37b22i161a12cd7723ef2d@mail.gmail.com>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<20080711182323.GB15321@secretlab.ca>
	<20080712080004.GA16739@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080712080004.GA16739@pengutronix.de>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On 7/12/08, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Fri, Jul 11, 2008 at 12:23:23PM -0600, Grant Likely wrote:
>
> > On Fri, Jul 11, 2008 at 09:48:59PM +0400, Anton Vorontsov wrote:
>  > > Firstly kernel warns at set_irq_chip, and then dies completely:
>  > >
>  > > Trying to install chip for IRQ-1
>  > >
>  > > diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
>  > > index b2ccdcb..95a24de 100644
>  > > --- a/drivers/of/of_i2c.c
>  > > +++ b/drivers/of/of_i2c.c
>  > > @@ -93,10 +93,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  > >             if (info.irq == NO_IRQ)
>  > >                     info.irq = -1;
>  >
>  > What is the reason that info.irq is set to -1 in the first place?  This
>  > looks like another bug to me.  Does something in the i2c layer depend on
>  > the -1 value?
>  >
>
>
> You already acked a fix to this :) I wasn't sure if my patch would
>  make it on its own, as Jon Smirl was also working on fixes to of_i2c.c
>  and he seemed to pick up this issue, too.

I did another patch for the mpc-i2c driver changing all of the
comparisons to NO_IRQ. My understanding of this is the ppc has NO_IRQ
set to -1, and powerpc has NO_IRQ = 0. So to make all of this work
right you have to use the NO_IRQ symbol and you can't check against 0
or -1 directly. I also believe work is underway to get all platforms
to NO_IRQ = 0 but I don't know if it is completed yet.


>
>  (Original patch is here:
>  http://ozlabs.org/pipermail/linuxppc-dev/2008-June/058801.html
>  )
>
>  All the best,
>
>    Wolfram
>
>
>  --
>   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>
> -----BEGIN PGP SIGNATURE-----
>  Version: GnuPG v1.4.6 (GNU/Linux)
>
>  iD8DBQFIeGSED27XaX1/VRsRAr+EAJ948UwobnY7WSSR4i/ywjof1+8dJACfWzPN
>  bhW6NXgBCnwqITIC5rSXeAI=
>  =W3sj
>  -----END PGP SIGNATURE-----
>
> _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
