From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] Blackfin I2C Driver: since only a few
	Blackfins lack TWI, just list them in the depends string
Date: Mon, 12 May 2008 20:02:15 +0800
Message-ID: <386072610805120502o617eca6fx30fb8a5e65543051@mail.gmail.com>
References: <1210565911-4633-1-git-send-email-cooloney@kernel.org>
	<20080512132734.10caa2af@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080512132734.10caa2af-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 12, 2008 at 7:27 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>
> On Mon, 12 May 2008 12:18:31 +0800, Bryan Wu wrote:
>  > From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>  >
>  > Signed-off-by: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>  > Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>  > ---
>  >  drivers/i2c/busses/Kconfig |    5 ++---
>  >  1 files changed, 2 insertions(+), 3 deletions(-)
>  >
>  > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>  > index 48438cc..b93186b 100644
>  > --- a/drivers/i2c/busses/Kconfig
>  > +++ b/drivers/i2c/busses/Kconfig
>  > @@ -101,10 +101,9 @@ config I2C_AU1550
>  >  config I2C_BLACKFIN_TWI
>  >       tristate "Blackfin TWI I2C support"
>  >       depends on BLACKFIN
>  > +     depends on !BF561 && !BF531 && !BF532 && !BF533
>  >       help
>  > -       This is the TWI I2C device driver for Blackfin BF522, BF525,
>  > -       BF527, BF534, BF536, BF537 and BF54x. For other Blackfin processors,
>  > -       please don't use this driver.
>  > +       This is the I2C device driver for Blackfin on-chip TWI interface.
>  >
>  >         This driver can also be built as a module.  If so, the module
>  >         will be called i2c-bfin-twi.
>
>  Applied, thanks. I've additionally changed "I2C device driver" to "I2C
>  bus driver" for clarity.
>

No problem. Thanks
-Bryan

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
