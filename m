From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: MTD EEPROM support and driver integration
Date: Sat, 6 Jul 2013 21:55:26 +0200
Message-ID: <20130706215526.7fc3e191@endymion.delvare>
References: <20130705201118.GM2959@lukather>
	<5811519.oHVuMujf0I@wuerfel>
	<20130706120112.GA11069@lukather>
	<8997501.Dchyii8uWX@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8997501.Dchyii8uWX@wuerfel>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Artem Bityutskiy <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 06 Jul 2013 21:06:49 +0200, Arnd Bergmann wrote:
> On Saturday 06 July 2013 14:01:12 Maxime Ripard wrote:
> > So that leave us with mainly one path to achieve this goal:
> >   - Add a regmap-mtd backend
> >   - Add DT parsing code for regmap
> >   - Move the EEPROM drivers from misc to mtd
> 
> Yes, I think that would be good. For the last step, we definitely need
> buy-in from Wolfgand and Jean, as they are maintaining the current eeprom
> drivers.

I am maintaining the legacy eeprom driver, which nobody should be using
in conjunction with DT. So you don't need my approval for anything.

-- 
Jean Delvare
