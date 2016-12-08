From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH] misc: eeprom: implement compatible DT probing
Date: Thu, 8 Dec 2016 19:23:03 +0100
Message-ID: <95d9c739-8a69-b990-2840-b5381d54a99d@axentia.se>
References: <1481219279-6982-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1481219279-6982-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2016-12-08 18:47, Linus Walleij wrote:
> The compatible string for an EEPROM in the device tree is currently
> completely ignored by the kernel, simply stated it will not make the
> corresponding AT24 EEPROM driver probe properly. It is instead still
> relying on the DT node name to be set to one of the I2C device IDs
> which works due to a side effect in the I2C DT parsing code.
> 
> Fix this up by making the DT probe mechanism a bit more elaborate:
> actually match on the compatible strings defined in the device
> tree bindings in Documentation/devicetree/bindings/eeprom/eeprom.txt:
> map these to the corresponding I2C IDs by name and look up the
> magic flags from the I2C ID before proceeding, also make the DT
> compatible string take precedence.
> 
> Keep the second DT parsing callback that sets up per-chip flags as
> this needs to happen after mangling the magic flags passed from the
> I2C ID table.
> 
> All vendor compatible strings listed in the binding document are
> added to the driver.
> 
> After this it is possible to name the device tree node for the EEPROM
> whatever you actually like to call it, and the probing will be done
> from the compatible string.
> 
> Before this patch, the following device tree node does not probe,
> which might be considered a bug:
> 
> eeprom@52 {
> 	compatible = "atmel,at24c128";

The way I read it, that should be "atmel,24c128", i.e. w/o the "at" prefix.

> 	reg = <0x52>;
> 	pagesize = <64>;
> };
> 
> After this patch, the driver probes fine from this node.

The bindings says:

	Required properties:

	  - compatible should be "<manufacturer>,<type>", like these:

and then lists the compatibles you have added to the match table (but you
have this extra "at" prefix for the atmel manufacturer).

The way I read the above, you are free to use any manufacturer and still
have it work, and indeed, I have success with this node:

	eeprom@50 {
		compatible = "nxp,24c02";
		reg = <0x50>;
		pagesize = <16>;
	};

I fear that your patch will regress this matching on the wildcard
manufacturer. I haven't tested that though, but there are enough
question marks anyway...

Cheers,
Peter

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
