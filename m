From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: Compatibles for i2c muxes nxp,pca954x and ti,tca954x
Date: Thu, 3 Aug 2017 16:22:33 +0200
Message-ID: <0103c2cc-ca1d-a2c1-347a-dd64f2492112@axentia.se>
References: <62519d0b-0b7b-9124-8481-9ef8de24eaf6@axentia.se>
 <20170803134401.GG15018@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170803134401.GG15018-g2DYL2Zd6BY@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-08-03 15:44, Andrew Lunn wrote:
> On Thu, Aug 03, 2017 at 12:00:27PM +0200, Peter Rosin wrote:
>> Hi!
>>
>> Texas has apparently made copies for some of the NXP devices
>> handled by the drivers/i2c/muxes/i2c-mux-pca954x.c driver.
> 
> This happens a lot in the i2c space. Look at all the at24 EEPROM
> clones. Yet they all use the same compatible string.

Errhm, no they don't. Hint, try

$ git grep 'compatible.*,24c'

There are all sorts of manufacturers in use.

atmel, microchip, onsemi, st, etc.

There are also "bad" manufacturers such as 'at,24c64' and "bad"
parts such as 'atmel,at24c16'. It's a mess.

Anyway, the only reason that ever works is because of loose
matching by the i2c core (it falls back to ignoring the
manufacturer or something like that, but I'm not sure about
the exact details). IIUC there is ongoing work to get rid of
that loose matching, and adding more of it is not the way
forward.

Cheers,
peda
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
