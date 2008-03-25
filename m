From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] Blackfin I2C TWI driver: ADSP-BF52x arch/mach
	support
Date: Tue, 25 Mar 2008 11:55:14 +0800
Message-ID: <386072610803242055h648bc250sa27f7193044f18d5@mail.gmail.com>
References: <1205479360-25240-7-git-send-email-cooloney@kernel.org>
	<20080324223310.7e3df49b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080324223310.7e3df49b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 25, 2008 at 5:33 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>
> On Fri, 14 Mar 2008 00:22:40 -0700, Bryan Wu wrote:
>  > From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>  >
>  > Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>  > Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>  > Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>  > ---
>  >  drivers/i2c/busses/Kconfig |    6 +++---
>  >  1 files changed, 3 insertions(+), 3 deletions(-)
>  >
>  > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>  > index 476b0bb..a1351ce 100644
>  > --- a/drivers/i2c/busses/Kconfig
>  > +++ b/drivers/i2c/busses/Kconfig
>  > @@ -100,10 +100,10 @@ config I2C_AU1550
>  >
>  >  config I2C_BLACKFIN_TWI
>  >       tristate "Blackfin TWI I2C support"
>  > -     depends on BF534 || BF536 || BF537 || BF54x
>  > +     depends on BF534 || BF536 || BF537 || BF54x || BF522 || BF525 || BF527
>  >       help
>  > -       This is the TWI I2C device driver for Blackfin 534/536/537/54x.
>  > -       This driver can also be built as a module.  If so, the module
>  > +       This is the TWI I2C device driver for Blackfin 522/525/527/534/536/537/54x.
>  > +       This driver can also be built as a module. If so, the module
>  >         will be called i2c-bfin-twi.
>
>  Now that the i2c-bfin-twi driver no longer requires special defines in
>  the arch/mach header files, wouldn't it be more simple to just make it
>  depend on BLACKFIN? Otherwise we'll have to update the "depends on"
>  statement over and over again with every new machine.
>

Unfortunately, 2 important Blackfin processor family BF533 and  BF561
do not integrate on-chip i2c twi controller.
They can use this driver. I plan to define HAVE_BFIN_I2C_TWI in each
Blackfin family, then Blackfin I2C TWI driver just "depends on
BLACKFIN && HAVE_BFIN_I2C_TWI". We don't change this configuration
again when new machine born.

Thanks
-Bryan

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
