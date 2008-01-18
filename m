From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: convert to platform driver
Date: Fri, 18 Jan 2008 13:38:59 +0100
Message-ID: <20080118133859.0271541c@hyperion.delvare>
References: <20071006161606.GB9270@roarinelk.homelinux.net>
	<20071027200521.3d800147@hyperion.delvare>
	<20080118090913.GA19940@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080118090913.GA19940-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
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
Cc: cd-8pe3aW1LYQuzSzjNS9e3XA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Manuel,

On Fri, 18 Jan 2008 10:09:13 +0100, Manuel Lauss wrote:
> Hi Jean,
> 
> On Sat, Oct 27, 2007 at 08:05:21PM +0200, Jean Delvare wrote:
> > 
> > > +/* All Alchemy demoboards with I2C have this #define in their headers */
> > > +#ifdef SMBUS_PSC_BASE
> > > +static struct resource pbdb_smbus_resources[] = {
> > > +	{
> > > +		.start	= SMBUS_PSC_BASE,
> > > +		.end	= SMBUS_PSC_BASE + 0x24 - 1,
> > > +		.flags	= IORESOURCE_MEM,
> > 
> > Aren't resources supposed to have a name, so that they are displayed
> > properly in /proc/iomem)?
> 
> it looks okay to me the way it is, so I didn't change it:
> 
> b1a00000-b1a00023 : au1xpsc_smbus.0
>   b1a00000-b1a00023 : au1xpsc_smbus

Ah, OK, I didn't know that. I guess that the driver core can give
default names to resources that have no name at registration time.
Thanks for the info!

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
