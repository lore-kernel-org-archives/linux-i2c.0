From: Baurzhan Ismagulov <ibr-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Subject: Re: status of i2c-cpm and ds2482
Date: Sat, 9 Jan 2010 00:19:43 +0100
Message-ID: <20100108231942.GA3699@radix50.net>
References: <20100108020253.GJ3388@radix50.net> <4B471647.8050806@scram.de> <20100108121723.GD4004@radix50.net> <20100108135222.49d7b834@hyperion.delvare> <20100108140111.GF4004@radix50.net> <4B473BCE.8060803@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B473BCE.8060803-NIgtFMG+Po8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 08, 2010 at 03:06:06PM +0100, Jochen Friedrich wrote:
> 	I2C0: i2c@860 {
...
> 		w1@aa {
> 			reg = <0xaa>;
> 			compatible = "dallas,ds2482";
> 		};
> 	};

This worked, thanks much Jochen and Jean!

I had to use "reg = <18>;", it didn't build with "0x".

FWIW, I've also tried restoring 0x18 in normal_i2c in ds2482.c, and
i2c-core complained about quick not being supported. Where can I read
about what it is? Why is it now required, whereas this worked in
2.6.25.7?

With kind regards,
Baurzhan.
