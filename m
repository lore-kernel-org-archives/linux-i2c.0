From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [PATCH 4/6]: i2c-pcf: Add a way for bus driver to ask for
 no smbus quick mode support.
Date: Thu, 16 Oct 2008 12:25:42 -0700 (PDT)
Message-ID: <20081016.122542.30729839.davem@davemloft.net>
References: <20081015143321.7df02b35@hyperion.delvare>
	<20081015.143452.114860633.davem@davemloft.net>
	<20081016121315.2adb5de1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081016121315.2adb5de1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Date: Thu, 16 Oct 2008 12:13:15 +0200

> Hi David,
> 
> On Wed, 15 Oct 2008 14:34:52 -0700 (PDT), David Miller wrote:
> > From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Date: Wed, 15 Oct 2008 14:33:21 +0200
> > 
> > > For another, with the introduction of I2C classes several years ago,
> > > I2C device drivers should no longer probe random I2C adapters.  
> > 
> > Jean, they do, that's why I wrote this change.
> > 
> > > They should only probe adapters which share a class bit with them,
> > 
> > The pcf driver sets the class bit used by FAN and temperature sensors,
> > so the I2C layer goes poking around all of the standard address
> > locations each of those drivers list.
> 
> By setting this class flag in your driver, you ask for these probes.

The PCF driver sets this flag by default, and my patch which you're
reviewing here allows my sparc specific backend driver (the last
patch in the series) to turn the bit off.

So you are arguing for exactly what I'm adding support for.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
