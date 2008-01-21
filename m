From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: convert to platform driver #4
Date: Mon, 21 Jan 2008 13:30:18 +0100
Message-ID: <20080121133018.24054319@hyperion.delvare>
References: <20071006161606.GB9270@roarinelk.homelinux.net>
	<20071027200521.3d800147@hyperion.delvare>
	<20080118095320.GA20550@roarinelk.homelinux.net>
	<20080118195546.1d3818a9@hyperion.delvare>
	<20080121084706.GA12519@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080121084706.GA12519-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Manuel,

On Mon, 21 Jan 2008 09:47:06 +0100, Manuel Lauss wrote:
> Hi Jean,
> 
> Fixed all your concerns, except this one:
> 
> > > +	release_resource(priv->ioarea);
> > > +	kfree(priv->ioarea);
> > 
> > I expected a call to release_mem_region() instead... but maybe that
> > works as well.
> 
> Yes it does.  I like this one better because it only takes one parameter.

OK, that's fine with me.

> (...)
> Convert the i2c-au1550 bus driver to platform driver, and
> register a platform device for the Alchemy Db/Pb series of
> boards.
> 
> Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> ---
>  arch/mips/au1000/common/platform.c |   21 +++++
>  drivers/i2c/busses/i2c-au1550.c    |  166 ++++++++++++++++++++++--------------
>  drivers/i2c/busses/i2c-au1550.h    |   32 -------
>  3 files changed, 123 insertions(+), 96 deletions(-)
>  delete mode 100644 drivers/i2c/busses/i2c-au1550.h

Patch applied, thanks!

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
