From: "Eric Miao" <ymiao3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [patch 6/6] Minor fixes for pxa-driver
Date: Thu, 14 Feb 2008 16:43:59 -0800
Message-ID: <E913911567467945BBEB9277E27868B0880976@msiexch01.marvell.com>
References: <20080121142010.988419876@pengutronix.de><20080121143659.089906703@pengutronix.de><20080213095839.5d99d48a@hyperion.delvare><fp22ri$d97$1@ger.gmane.org>
	<20080214231138.3c696384@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I modified this by hand when the compiler complains, I thought it was typo
and ignored this :-(

- eric

> -----Original Message-----
> From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]
> Sent: Friday, February 15, 2008 6:12 AM
> To: Wolfram Sang
> Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org; Eric Miao; Mike Rapoport
> Subject: Re: [i2c] [patch 6/6] Minor fixes for pxa-driver
> 
> On Thu, 14 Feb 2008 19:55:46 +0100, Wolfram Sang wrote:
> > Hi Jean.
> >
> > Jean Delvare wrote:
> >
> > >  	.driver		= {
> > >  		.name	= "pxa2xx-i2c",
> > > +		.owner	= THIS_DRIVER,
> > THIS_MODULE? Was it just too obvious to be mentioned or how come it
> > builds at all? My platform driver complains...
> 
> Oops, you are totally right, thanks for catching my mistake.
> 
> This makes me wonder what Mike and Eric actually tested...
> 
> --
> Jean Delvare
_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
