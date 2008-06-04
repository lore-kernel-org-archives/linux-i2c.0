From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: Let bus drivers add SPD to their class
Date: Wed, 4 Jun 2008 00:18:10 -0700
Message-ID: <200806040018.10191.david-b@pacbell.net>
References: <20080603130221.1f819e64@hyperion.delvare>
	<200806031319.56606.david-b@pacbell.net>
	<20080604080933.456c8ce2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080604080933.456c8ce2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 03 June 2008, Jean Delvare wrote:

> > Few embedded platforms use discrete sticks of DRAM.
> > My two cents:  use the opposite default in those cases.
> =

> I wish I knew which of these bus drivers exactly are for embedded
> platforms.

To be strictly correct, "embedded" is an application issue
more than a hardware issue.  One can "embed" mainframes in
an Air Traffic Control system.

So the issue there is more whether such usage is common
or, in some cases, even practical.


> Would you be able to give me a list of all drivers under =

> drivers/i2c/busses that fall in this category? I would be able to update
> http://lists.lm-sensors.org/pipermail/i2c/2008-May/003713.html
> then.

Not really; sorry.


> Also, couldn't these platforms have other EEPROMs on these buses,
> either EDID EEPROMs or proprietary ones, for which people might be
> using the read-only eeprom driver at the moment? I don't want users to
> experience a regression by applying this patch set. I'd rather have
> them migrate their platform to the at24 driver once it is upstream and
> remove the I2C_CLASS_SPD flag when they do.

Unlikely.  At least in the cases I called out.

Oh, and parport.  DRAM sticks, or LCD displays, over parport
links would be strange.  ;)

- Dave



> > I'll highlight a few below, where I happen to have more
> > specific knowledge.
> > =

> > =

> > > So, bus driver maintainers and users =

> > > should feel free to remove the SPD class from drivers those buses nev=
er
> > > have SPD EEPROMs or they don't want the eeprom driver to bind to them.
> > > Likewise, feel free to add the SPD class to any bus driver I might ha=
ve
> > > missed.
> > > =

> > > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > ---
> > > =A0drivers/i2c/busses/i2c-ali1535.c =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-ali1563.c =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-ali15x3.c =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-amd756.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-amd8111.c =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-at91.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> > =

> > I've never heard of an AT91 board using DRAM sticks ...
> > =

> > > =A0drivers/i2c/busses/i2c-cpm.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-davinci.c =A0 =A0 =A0 | =A0 =A02 +-
> > =

> > ... or a DaVinci one ...
> > =

> > =

> > > =A0drivers/i2c/busses/i2c-elektor.c =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-gpio.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-i801.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-ibm_iic.c =A0 =A0 =A0 | =A0 =A04 ++--
> > > =A0drivers/i2c/busses/i2c-iop3xx.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-isch.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-mv64xxx.c =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-nforce2.c =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-ocores.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-omap.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> > =

> > ... or an OMAP one ...
> > =

> > > =A0drivers/i2c/busses/i2c-parport-light.c | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-parport.c =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-pasemi.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-piix4.c =A0 =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-pmcmsp.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-s3c2410.c =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-sibyte.c =A0 =A0 =A0 =A0| =A0 =A04 ++--
> > > =A0drivers/i2c/busses/i2c-sis5595.c =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-sis630.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-sis96x.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-stub.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-tiny-usb.c =A0 =A0 =A0| =A0 =A02 +-
> > =

> > ... DRAM-over-USB would be bizarre too ...
> > =

> > > =A0drivers/i2c/busses/i2c-via.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> > > =A0drivers/i2c/busses/i2c-viapro.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0drivers/i2c/busses/scx200_acb.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> > > =A0include/linux/i2c.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +
> > > =A035 files changed, 37 insertions(+), 36 deletions(-)
> =

> OK, I'll revert the change for these 4 drivers.



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
