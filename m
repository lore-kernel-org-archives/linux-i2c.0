From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
Date: Tue, 19 Feb 2008 09:59:40 +0100
Message-ID: <200802190959.41253.sr@denx.de>
References: <4784FED1.2040206@pikatech.com> <47BA3416.5080405@pikatech.com>
	<20080219092321.1fed233d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080219092321.1fed233d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 19 February 2008, Jean Delvare wrote:
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index b61f56b..44c0984 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -244,7 +244,6 @@ config I2C_PIIX4
> >
> >  config I2C_IBM_IIC
> >  	tristate "IBM PPC 4xx on-chip I2C interface"
> > -	depends on IBM_OCP
> >  	help
> >  	  Say Y here if you want to use IIC peripheral found on
> >  	  embedded IBM PPC 4xx based systems.
>
> With this Kconfig change, "make menuconfig" lets me select the
> i2c-ibm_iic driver on x86_64, but it fails to build horribly. I think
> that you want to restrict the build to PPC machines somehow, or at
> least make sure that either IBM_OCP or OF support is present.

How about this:

-	depends on IBM_OCP
+	depends on 4xx

Best regards,
Stefan

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
