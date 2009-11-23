From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
Date: Mon, 23 Nov 2009 20:53:56 +0530
Message-ID: <1258989836.20007.236.camel@localhost.localdomain>
References: <1247643267.5981.82.camel@localhost.localdomain>
	 <200907151010.18709.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200907151010.18709.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello David,

On Wed, 2009-07-15 at 10:10 -0700, David Brownell wrote:
> On Wednesday 15 July 2009, Philby John wrote:
> >  /*
> > + * Configure the i2c data pin as a GPIO input and the i2c clock pi=
n as a
> > + * high GPIO output.
> > + */
> > +static void disable_i2c_pins(void)
> > +{
> > +       unsigned long flags;
> > +
> > +       local_irq_save(flags);
> > +       if (cpu_is_davinci_dm355()) {
> > +               gpio_direction_input(15);
> > +               gpio_direction_output(14, 0);
> > +               gpio_set_value(14, 1);
>=20
> As noted:  gpio_direction_output(14, 1) is better.

Now Corrected!

>=20
> > +               davinci_cfg_reg(DM355_I2C_SDA);
> > +               davinci_cfg_reg(DM355_I2C_SCL);
> > +       }
> > +       local_irq_restore(flags);
> > +}
> > +
> > +/* Connect the i2c pins to the i2c controller. */
> > +static void enable_i2c_pins(void)
> > +{
> > +       unsigned long flags;
> > +
> > +       local_irq_save(flags);
> > +       if (cpu_is_davinci_dm355()) {
> > +               davinci_cfg_reg(DM355_I2C_SDA);
> > +               davinci_cfg_reg(DM355_I2C_SCL);
> > +       }
> > +       local_irq_restore(flags);
> > +}
> > +
> > +
> > +/* Generate a pulse on the i2c clock pin. */
> > +static void pulse_i2c_clock(void)
> > +{
> > +       if (cpu_is_davinci_dm355()) {
> > +               gpio_set_value(14, 0);
> > +               udelay(20);
> > +               gpio_set_value(14, 1);
> > +               udelay(20);
> > +       }
> > +}
> > +
>=20
> The general problem with how that's done is that the SoC-specific
> bits should not be in this file.  The mach-davinc/dm355.c file
> should hold that configuration; likewise for other SoCs.

Not quite sure what you were expecting here. What I could do is to set
sda_pin and scl_pin in struct davinci_i2c_platform_data, for all davinc=
i
platforms there is, rather than make davinci specific changes to
i2c-gpio.c I would also prefer not to make changes to
board-dm646x-evm.c/board-dm365-evm.c/board-dm355-evm.c etc...
Please let me know what you think.

>=20
> > +                       /* Disable i2c */
> > +                       disable_i2c_pins();
> > +                       for (i =3D 0; i < 10; i++)
> > +                               pulse_i2c_clock();
> > +                       /* Re-enable i2c */
> > +                       enable_i2c_pins();
>=20
> A better description of this is that you're trying to follow
> the I2Cv3 instructions about how to *reset* the bus, yes?

This is correct. To be precise, I am following the bus recovery
procedure as outlined in AN10216-01 I2C Manual. Reproducing here as
general information.

=E2=80=A2SDA line is then non usable anymore because of the
=E2=80=9CSlave-Transmitter=E2=80=9Dmode.
=E2=80=A2Methods to recover the SDA line are:
=E2=80=93Reset the slave device (assuming the device has a Reset pin)
=E2=80=93Use a bus recovery sequence to leave the =E2=80=9CSlave-Transm=
itter=E2=80=9D mode
=E2=80=A2Bus recovery sequence is done as following:
1-Send 9 clock pulses on SCL line
2-Ask the master to keep SDA High until the =E2=80=9CSlave-Transmitter=E2=
=80=9D releases
the SDA line to perform the ACK operation
3-Keeping SDA High during the ACK means that the =E2=80=9CMaster-Receiv=
er=E2=80=9Ddoes
not acknowledge the previous byte receive
4-The =E2=80=9CSlave-Transmitter=E2=80=9D then goes in an idle state
5-The master then sends a STOP command initializing completely the bus


Thank you for your comments.
Regards,
Philby
