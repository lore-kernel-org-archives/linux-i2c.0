From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] assign a default class to MPC adapter
Date: Tue, 21 Apr 2009 08:47:41 +0200
Message-ID: <49ED6C0D.2060607@gmx.de>
References: <49E6F4F9.3060705@gmx.de> <20090416092012.GB3052@pengutronix.de> <49E7101E.6070806@gmx.de> <20090416114701.GD3052@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090416114701.GD3052-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang said the following:
>> Could you please elaborate?
> 
> Instead of probing you specify the devices on the i2c-bus in the dts. Example
> for the pcm032 looks like this (from the kernel-tree):
> 
> i2c@3d40 {
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> 	reg = <0x3d40 0x40>;
> 	interrupts = <2 16 0>;
> 	fsl5200-clocking;
> 
> 	rtc@51 {
> 		compatible = "nxp,pcf8563";
> 		reg = <0x51>;
> 	};
> 	eeprom@52 {
> 		compatible = "at24,24c32";
> 		reg = <0x52>;
> 	};
> };
> 
> Boards which relied on probing need to have such child nodes added.

This entry forces the sysFs basic entries, but instantiation of
_new-style_ drivers still fails, at least on my system.

I now proposed a patch for loading the class parameter of the adapter
from device tree.(--><49ED6AD3.2060808-Mmb7MZpHnFY@public.gmane.org>) and hope to get an ACK.

-- 
Kind regards,
Michael
