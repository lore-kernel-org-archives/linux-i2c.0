From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: [PATCH v2 0/2] New driver: i2c_imc (Intel LGA2011 iMC SMBUS)
Date: Wed, 17 Jul 2013 12:12:13 -0700
Message-ID: <CALCETrV2aFXca6-vfo0ukK8YJBQuroKX=eMC2Ax3RfDH_L1OzQ@mail.gmail.com>
References: <cover.1374012684.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1374012684.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 16, 2013 at 3:23 PM, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org> wrote:
> Intel's LGA2011 chips (Core i7 Extreme and Xeon E5) have two SMBUS
> controllers per package, addressing up to 16 DIMM slots per package.
> This is a driver for those SMBUS channels.
>
> The first patch is a minor change to the i2c core to make it work
> better with extremely limited hardware like this.  The second patch is
> the driver.
>
> Changes from the RFC / v1: Work around an erratum that gave random
> incorrect reads on multi-socket systems.
>
> Andy Lutomirski (2):
>   i2c: Allow SPD probing with READ_BYTE_DATA and improve logging
>   i2c_imc: New driver for Intel's iMC, found on LGA2011 chips
>
>  drivers/i2c/busses/Kconfig   |  14 ++
>  drivers/i2c/busses/Makefile  |   1 +
>  drivers/i2c/busses/i2c-imc.c | 546 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/i2c-core.c       |   7 +-
>  4 files changed, 567 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/i2c/busses/i2c-imc.c

Please ignore this series.  I have a replacement that's far better.

>
> --
> 1.8.1.4
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
