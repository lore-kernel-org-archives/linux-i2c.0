From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
Date: Wed, 15 Jul 2009 10:10:18 -0700
Message-ID: <200907151010.18709.david-b@pacbell.net>
References: <1247643267.5981.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1247643267.5981.82.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 15 July 2009, Philby John wrote:
> =A0/*
> + * Configure the i2c data pin as a GPIO input and the i2c clock pin as=
 a
> + * high GPIO output.
> + */
> +static void disable_i2c_pins(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0unsigned long flags;
> +
> +=A0=A0=A0=A0=A0=A0=A0local_irq_save(flags);
> +=A0=A0=A0=A0=A0=A0=A0if (cpu_is_davinci_dm355()) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0gpio_direction_input(15);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0gpio_direction_output(14,=
 0);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0gpio_set_value(14, 1);

As noted:  gpio_direction_output(14, 1) is better.

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0davinci_cfg_reg(DM355_I2C=
_SDA);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0davinci_cfg_reg(DM355_I2C=
_SCL);
> +=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0local_irq_restore(flags);
> +}
> +
> +/* Connect the i2c pins to the i2c controller. */
> +static void enable_i2c_pins(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0unsigned long flags;
> +
> +=A0=A0=A0=A0=A0=A0=A0local_irq_save(flags);
> +=A0=A0=A0=A0=A0=A0=A0if (cpu_is_davinci_dm355()) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0davinci_cfg_reg(DM355_I2C=
_SDA);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0davinci_cfg_reg(DM355_I2C=
_SCL);
> +=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0local_irq_restore(flags);
> +}
> +
> +
> +/* Generate a pulse on the i2c clock pin. */
> +static void pulse_i2c_clock(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0if (cpu_is_davinci_dm355()) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0gpio_set_value(14, 0);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0udelay(20);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0gpio_set_value(14, 1);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0udelay(20);
> +=A0=A0=A0=A0=A0=A0=A0}
> +}
> +

The general problem with how that's done is that the SoC-specific
bits should not be in this file.  The mach-davinc/dm355.c file
should hold that configuration; likewise for other SoCs.


> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/=
* Disable i2c */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0d=
isable_i2c_pins();
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0f=
or (i =3D 0; i < 10; i++)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0pulse_i2c_clock();
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/=
* Re-enable i2c */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0e=
nable_i2c_pins();

A better description of this is that you're trying to follow
the I2Cv3 instructions about how to *reset* the bus, yes?

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i=
2c_davinci_init(dev);
> =A0
