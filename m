From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Rename last mux driver to standard pattern
Date: Tue, 1 May 2012 08:45:50 +0200
Message-ID: <20120501084550.259d31f0@endymion.delvare>
References: <20120428153206.00c1e226@endymion.delvare>
	<87lilghrow.fsf@thor.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87lilghrow.fsf-1Ae4nN3xCbAluPl5bxqUMw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 28 Apr 2012 16:11:27 +0200, Peter Korsgaard wrote:
> >>>>> "JD" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
> JD>  Documentation/i2c/muxes/gpio-i2cmux  |   65 ------------
> JD>  Documentation/i2c/muxes/i2c-mux-gpio |   65 ++++++++++++
> JD>  MAINTAINERS                          |    6 -
> JD>  drivers/i2c/muxes/Kconfig            |    2 
> JD>  drivers/i2c/muxes/Makefile           |    2 
> JD>  drivers/i2c/muxes/gpio-i2cmux.c      |  173 ----------------------------------
> JD>  drivers/i2c/muxes/i2c-mux-gpio.c     |  173 ++++++++++++++++++++++++++++++++++
> JD>  include/linux/gpio-i2cmux.h          |   38 -------
> JD>  include/linux/i2c-mux-gpio.h         |   38 +++++++
> 
> git diff -M patches are a lot easier to read for this kind of change.

Sure, but I'm not using git, and I don't think GNU diff has the option.

-- 
Jean Delvare
