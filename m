From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: Let bus drivers add SPD to their class
Date: Tue, 3 Jun 2008 17:12:24 -0400
Message-ID: <9e4733910806031412t52e7ed1bl8fd56751bef12a7a@mail.gmail.com>
References: <20080603130221.1f819e64@hyperion.delvare>
	<200806031319.56606.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806031319.56606.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 6/3/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Tuesday 03 June 2008, Jean Delvare wrote:
>  >
>  > Note that I took a conservative approach here, adding I2C_CLASS_SPD to
>  > all drivers that had I2C_CLASS_HWMON before. This is to make sure that
>  > the eeprom driver doesn't stop probing buses where SPD EEPROMs live.
>  > But the truth is that, for most of these, I simply have no idea whether
>  > they can host SPD EEPROMs or not.
>
>
> Few embedded platforms use discrete sticks of DRAM.
>  My two cents:  use the opposite default in those cases.
>
>  I'll highlight a few below, where I happen to have more
>  specific knowledge.
>
>
>
>  > So, bus driver maintainers and users
>  > should feel free to remove the SPD class from drivers those buses never
>  > have SPD EEPROMs or they don't want the eeprom driver to bind to them.
>  > Likewise, feel free to add the SPD class to any bus driver I might have
>  > missed.
>  >
>  > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>  > ---
>  >  drivers/i2c/busses/i2c-ali1535.c       |    2 +-
>  >  drivers/i2c/busses/i2c-ali1563.c       |    2 +-
>  >  drivers/i2c/busses/i2c-ali15x3.c       |    2 +-
>  >  drivers/i2c/busses/i2c-amd756.c        |    2 +-
>  >  drivers/i2c/busses/i2c-amd8111.c       |    2 +-
>  >  drivers/i2c/busses/i2c-at91.c          |    2 +-
>
>
> I've never heard of an AT91 board using DRAM sticks ...
>
>
>  >  drivers/i2c/busses/i2c-cpm.c           |    2 +-
>  >  drivers/i2c/busses/i2c-davinci.c       |    2 +-
>
>
> ... or a DaVinci one ...
>
>
>
>  >  drivers/i2c/busses/i2c-elektor.c       |    2 +-
>  >  drivers/i2c/busses/i2c-gpio.c          |    2 +-
>  >  drivers/i2c/busses/i2c-i801.c          |    2 +-
>  >  drivers/i2c/busses/i2c-ibm_iic.c       |    4 ++--
>  >  drivers/i2c/busses/i2c-iop3xx.c        |    2 +-
>  >  drivers/i2c/busses/i2c-isch.c          |    2 +-
>  >  drivers/i2c/busses/i2c-mpc.c           |    2 +-

Freescale embedded, no sticks

>  >  drivers/i2c/busses/i2c-mv64xxx.c       |    2 +-
>  >  drivers/i2c/busses/i2c-nforce2.c       |    2 +-
>  >  drivers/i2c/busses/i2c-ocores.c        |    2 +-
>  >  drivers/i2c/busses/i2c-omap.c          |    2 +-
>
>
> ... or an OMAP one ...
>
>
>  >  drivers/i2c/busses/i2c-parport-light.c |    2 +-
>  >  drivers/i2c/busses/i2c-parport.c       |    2 +-
>  >  drivers/i2c/busses/i2c-pasemi.c        |    2 +-
>  >  drivers/i2c/busses/i2c-piix4.c         |    2 +-
>  >  drivers/i2c/busses/i2c-pmcmsp.c        |    2 +-
>  >  drivers/i2c/busses/i2c-s3c2410.c       |    2 +-
>  >  drivers/i2c/busses/i2c-sibyte.c        |    4 ++--
>  >  drivers/i2c/busses/i2c-sis5595.c       |    2 +-
>  >  drivers/i2c/busses/i2c-sis630.c        |    2 +-
>  >  drivers/i2c/busses/i2c-sis96x.c        |    2 +-
>  >  drivers/i2c/busses/i2c-stub.c          |    2 +-
>  >  drivers/i2c/busses/i2c-tiny-usb.c      |    2 +-
>
>
> ... DRAM-over-USB would be bizarre too ...
>
>
>  >  drivers/i2c/busses/i2c-via.c           |    2 +-
>  >  drivers/i2c/busses/i2c-viapro.c        |    2 +-
>  >  drivers/i2c/busses/scx200_acb.c        |    2 +-
>  >  include/linux/i2c.h                    |    1 +
>  >  35 files changed, 37 insertions(+), 36 deletions(-)
>
>
>
>
> _______________________________________________
>  i2c mailing list
>  i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
>  http://lists.lm-sensors.org/mailman/listinfo/i2c
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
