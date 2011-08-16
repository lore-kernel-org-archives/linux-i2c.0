From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] i2c: I2C_ELEKTOR should depend on HAS_IOPORT
Date: Tue, 16 Aug 2011 21:42:06 +0200
Message-ID: <4991605.b7BYCfYE3S@wuerfel>
References: <1312802446-19154-1-git-send-email-geert@linux-m68k.org> <20110816195033.014f302b@endymion.delvare> <CAMuHMdUk_xTwGbhG0MHkS-8rkF76b1fg193pPcs+9MVyB-qHQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUk_xTwGbhG0MHkS-8rkF76b1fg193pPcs+9MVyB-qHQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Hans Berglund <hb-wBUg6WsUcUgXWF+eFR7m5Q@public.gmane.org>, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 16 August 2011 21:14:42 Geert Uytterhoeven wrote:
> >>  config I2C_ELEKTOR
> >>       tristate "Elektor ISA card"
> >> -     depends on ISA && BROKEN_ON_SMP
> >> +     depends on ISA && HAS_IOPORT && BROKEN_ON_SMP
> >>       select I2C_ALGOPCF
> >>       help
> >>         This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
> >
> > How can ISA be set if HAS_IOPORT is not? This shouldn't be allowed.
> 
> It's always been like that. With CONFIG_ISA, we have inb() and friends. But not
> ioport_map(), which was introduced more recently.

Right. BTW, I'd really like to change that once I've picked up and fixed the
use of inb() in 8250.c. I think we should change CONFIG_HAS_IOPORT to mean
that inb(), ioport_resource and /proc/ioports are available, while a new
CONFIG_HAS_IOPORT_MAP can then replace the current CONFIG_HAS_IOPORT symbol.

	Arnd
