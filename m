From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: MTD EEPROM support and driver integration
Date: Sat, 06 Jul 2013 21:06:49 +0200
Message-ID: <8997501.Dchyii8uWX@wuerfel>
References: <20130705201118.GM2959@lukather> <5811519.oHVuMujf0I@wuerfel> <20130706120112.GA11069@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130706120112.GA11069@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Artem Bityutskiy <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Saturday 06 July 2013 14:01:12 Maxime Ripard wrote:
> I'm not exactly sure on what happened to the previous mail that has been
> sent empty, but anyway:
> 
> On Sat, Jul 06, 2013 at 11:18:00AM +0200, Arnd Bergmann wrote:
> > On Saturday 06 July 2013 10:28:04 Maxime Ripard wrote:
> > > > a) like interrupts, regs, dmas, clocks, pinctrl, reset, pwm: fixed property names
> > > > 
> > > >       regmap = <&at25 0xstart 0xlen>;
> > > >       regmap-names = "mac-address";
> > > > 
> > > > b) like gpio, regulator: variable property names
> > > > 
> > > >       mac-storage = <&at25 0xstart 0xlen>;
> > > > 
> > > > It's unfortunate that we already have examples of both. They are largely
> > > > equivalent, but the tendency is towards the first.
> > > 
> > > I don't have a strong feeling for one against another, so whatever works
> > > best. Both solutions will be a huge improvement anyway 
> > > 
> > > Just out of curiosity, is there any advantages besides having a fixed
> > > property name to the first solution?
> > 
> > I think it's mostly for consistency: trying to get most subsystems to
> > do it the same way to make it easier for people to write dts files.
> > 
> > A lesser point is that it simplifies the driver code if you don't
> > have to pass a name.
> 
> So that leave us with mainly one path to achieve this goal:
>   - Add a regmap-mtd backend
>   - Add DT parsing code for regmap
>   - Move the EEPROM drivers from misc to mtd

Yes, I think that would be good. For the last step, we definitely need
buy-in from Wolfgand and Jean, as they are maintaining the current eeprom
drivers.

> What other option would we have?
> 
> I also thought about writing an EEPROM framework of its own, but the
> line is really thin between a large EEPROM and say a small SPI
> dataflash, which would make it pretty hard to choose between such a
> framework and MTD.

Isn't flash by definition block based, while EEPROM can be written
in byte or word units? I think that is a significant difference, although
it doesn't necessarily mean that we can't use MTD for both.

We also have a bunch of OTP drivers spread around the kernel, it probably
makes sense to consolidate them at the same time, at least on the DT binding
side if not the device drivers.

	Arnd
