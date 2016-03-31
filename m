From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v4 03/14] i2c-octeon: Change adapter timeout and retry
 default values
Date: Thu, 31 Mar 2016 12:13:19 +0200
Message-ID: <20160331101319.GA31112@hardcore>
References: <cover.1458289385.git.jglauber@cavium.com>
 <dd3af500365eeeac662a097441259e90a0d3e303.1458289385.git.jglauber@cavium.com>
 <20160323195517.GE19849@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160323195517.GE19849@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 23, 2016 at 08:55:18PM +0100, Wolfram Sang wrote:
> On Fri, Mar 18, 2016 at 09:46:28AM +0100, Jan Glauber wrote:
> > Convert the adapter timeout to 2 ms instead of a fixed number of
> > jiffies and set retries to 10.
> 
> You describe what you change, but not why this is needed. Why 10
> retries? And shouldn't that be 20ms seeing the HZ/50 ?

The timeout value is not changed, i2c-octeon is bound to Octeon SOC
which has CONFIG_HZ=100. I would prefer to use an absolute value for
a timeout that should not change with the value of CONFIG_HZ.

For the retries, I'll change it to 5 which is what many i2c drivers
use. I thought the reason to use a non-zero value for retries might
be obvious, like "retry in case of a failed operation" ?!

With the updated driver I do not see retry attempts, but it might
not hurt the robustness of the driver to benefit from i2c core
retry logic, or am I missing something?

> Also, please use "i2c: octeon: " as prefix in the subject.

OK.

Thanks,
Jan

> Thanks,
> 
>    Wolfram
> 
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > ---
> >  drivers/i2c/busses/i2c-octeon.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
> > index 9240037..e616e4c 100644
> > --- a/drivers/i2c/busses/i2c-octeon.c
> > +++ b/drivers/i2c/busses/i2c-octeon.c
> > @@ -414,7 +414,6 @@ static struct i2c_adapter octeon_i2c_ops = {
> >  	.owner = THIS_MODULE,
> >  	.name = "OCTEON adapter",
> >  	.algo = &octeon_i2c_algo,
> > -	.timeout = HZ / 50,
> >  };
> >  
> >  /* calculate and set clock divisors */
> > @@ -541,6 +540,8 @@ static int octeon_i2c_probe(struct platform_device *pdev)
> >  	octeon_i2c_set_clock(i2c);
> >  
> >  	i2c->adap = octeon_i2c_ops;
> > +	i2c->adap.timeout = msecs_to_jiffies(2);
> > +	i2c->adap.retries = 10;
> >  	i2c->adap.dev.parent = &pdev->dev;
> >  	i2c->adap.dev.of_node = node;
> >  	i2c_set_adapdata(&i2c->adap, i2c);
> > -- 
> > 1.9.1
> > 
