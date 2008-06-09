From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c-ibm_iic: Enable driver for all PPC4xx
	variants in arch/powerpc
Date: Mon, 9 Jun 2008 06:48:24 +0200
Message-ID: <200806090648.24339.sr@denx.de>
References: <1212653453-26093-1-git-send-email-sr@denx.de>
	<20080608144843.58857324@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080608144843.58857324-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Sunday 08 June 2008, Jean Delvare wrote:
> > This patch enables the IBM I2C driver for all PPC4xx variants by adding
> > "ibm,iic" to the compatible list. This way all currently available
> > arch/powerpc 4xx ports can make use of this driver without any changes.
> > Additionally all "other" compatible entries are removed since they are
> > not needed anymore.
> >
> > Currently all 4xx PPC's have the same compatible I2C macro. If at some
> > time an incompatibility is detected we can take care of this with an
> > additional property.
> >
> > Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-ibm_iic.c |    6 +-----
> >  1 files changed, 1 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-ibm_iic.c
> > b/drivers/i2c/busses/i2c-ibm_iic.c index 3a364a7..ed73801 100644
> > --- a/drivers/i2c/busses/i2c-ibm_iic.c
> > +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> > @@ -807,11 +807,7 @@ static int __devexit iic_remove(struct of_device
> > *ofdev) }
> >
> >  static const struct of_device_id ibm_iic_match[] = {
> > -	{ .compatible = "ibm,iic-405ex", },
> > -	{ .compatible = "ibm,iic-405gp", },
> > -	{ .compatible = "ibm,iic-440gp", },
> > -	{ .compatible = "ibm,iic-440gpx", },
> > -	{ .compatible = "ibm,iic-440grx", },
> > +	{ .compatible = "ibm,iic", },
> >  	{}
> >  };
>
> OK, I can take this in my tree, unless it depends on arch-specific
> patches which have not hit mainline yet.

No, this doesn't depend on other pathes.

> I guess this is 2.6.27 
> material?

Yes. No real hurry here.

Thanks.

Best regards,
Stefan

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
