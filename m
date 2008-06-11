From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver (with
	device_ids)
Date: Wed, 11 Jun 2008 09:49:16 -0700
Message-ID: <200806110949.16286.david-b@pacbell.net>
References: <20080605193103.GA13062@pengutronix.de>
	<20080611073323.GA4257@pengutronix.de>
	<20080611110921.5bf770dd@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080611110921.5bf770dd-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 11 June 2008, Jean Delvare wrote:
> On Wed, 11 Jun 2008 09:33:25 +0200, Wolfram Sang wrote:
> > > > AT24_FLAG_24C00 (doesn't really matter), and AT24C01 needs 128
> > > > addresses?? (please, someone, prove me wrong)
> > > 
> > > Why do you think so? ...
> > 
> > No I2C-address is mentioned in the whole datasheet; all the timing
> > diagrams put the memory offset to the place where one would expect the
> > I2C-address; the pins usually named A0-A2 are not connected...
>
> Ooch. I didn't notice the timing diagrams... OMG.

You mean, the obsolete 24c01, rather than the 24c01b or newer?


> > Maybe it once made the chip one cent cheaper, I dunno, but I wouldn't be
> > that surprised :) Doesn't really matter for at24, luckily.
> 
> Indeed. If this chip is the crazy thing you suspect (and I now fear you
> are correct), it's not compatible with the other EEPROMs, so we don't
> really care about it.

Right ... worth a comment in the chip ID table that 24c01b (and newer)
entries really mean that, since the original 24c01 parts were broken by
design (no on-wire chip address byte).

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
