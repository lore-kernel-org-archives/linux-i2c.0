From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] i2c: designware: add reset interface
Date: Fri, 06 Jan 2017 12:32:52 +0100
Message-ID: <3024749.v77eulNknP@wuerfel>
References: <1482500451-30137-1-git-send-email-zhangfei.gao@linaro.org>
 <2921529.fKUMSWjgsl@wuerfel> <1483544119.9552.223.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1483544119.9552.223.camel@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Wolfram Sang <wsa@the-dreams.de>, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, p.zabel@pengutronix.de, Zhangfei Gao <zhangfei.gao@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On Wednesday, January 4, 2017 5:35:19 PM CET Andy Shevchenko wrote:


> > > @@ -270,10 +280,18 @@ static int dw_i2c_plat_probe(struct
> > > platform_device *pdev)
> > >         }
> > >  
> > >         r = i2c_dw_probe(dev);
> > > -       if (r && !dev->pm_runtime_disabled)
> > > -               pm_runtime_disable(&pdev->dev);
> > > +       if (r)
> > > +               goto exit_probe;
> > >  
> > >         return r;
> > > +
> > > +exit_probe:
> > > +       if (!dev->pm_runtime_disabled)
> > > +               pm_runtime_disable(&pdev->dev);
> > > +exit_reset:
> > > +       if (!IS_ERR_OR_NULL(dev->rst))
> > > +               reset_control_assert(dev->rst);
> > > +       return r;
> > > 
> > 
> > try to avoid the IS_ERR_OR_NULL() check, it usually indicates either
> > a bad interface, or that the interface is used wrong.
> 
> Please, fix reset framework first than.
> 
> For my understanding:
> It should return NULL for optional reset control.
> It should not fail on NULL argument.

I think we discussed that a few times. Your suggestion makes sense
to me, but I don't know why we don't already do that, maybe there
is a good reason.

	Arnd
