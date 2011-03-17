From: Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org
Subject: Re: How to put extra clock cycles on i2c cavinci, problems on omapl138 (logic
 pd som)
Date: Thu, 17 Mar 2011 10:08:35 +0100
Message-ID: <OFCCCD2C6E.D899BA32-ONC1257856.00307955-C1257856.00323B2B@sewerin.de>
References: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3@sewerin.de> <AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

[...]
> >
> > After some action on the touchscreen, there are communication error=
s
> > on the i2c, and the bus stalled.
> > In this state the SDA line is hold low and the driver gives repeate=
dly
> > the following messages:
> >
> > tps6507x 1-0048: ADC result 1 read failed
> > i2c_davinci i2c_davinci.1: controller timed out
> > i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> > i2c_davinci i2c_davinci.1: controller timed out
> > i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> > tps6507x 1-0048: TSC mode read failed
> > i2c_davinci i2c_davinci.1: controller timed out
> > i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> > i2c_davinci i2c_davinci.1: controller timed out
> > i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> > tps6507x 1-0048: TSC mode read failed
> > [...]
>=20
> I am also observing 'controller timed out' messages on v2.6.38-rc8 on
> the da850evm with the UI Board connected (the char-lcd one, no the
> touchscreen).
>=20
>  The addresses 0x20 and 0x21 can be seen in the error output below
> which I believe indicates that the slave(s) hanging the bus are the
> gpio expanders on the baseboard and UI board.
>=20
> [...]
> pca953x 1-0020: failed reading register
> i2c_davinci i2c_davinci.1: controller timed out
> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> pca953x 1-0021: failed reading register
> i2c_davinci i2c_davinci.1: controller timed out
> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> [...]
>=20
> The messages repeat with a mix of 0x20 and 0x21
>=20
> When I revert:
> c5b4afec8e669bbe265daea24037fccfc42c4fe3 i2c-davinci: Fix TX setup=20
> for more SoCs
> 4bba0fd8d1c6d405df666e2573e1a1f917098be0 i2c-davinci: Fix race when
> setting up for TX
>=20
> (CC'd the author, Jon Povey) -- I get the occasional:
>=20
> i2c_davinci i2c_davinci.1: abnormal termination buf_len=3D-1
> pca953x 1-0020: failed reading register
> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
>=20
> but not the long repeating string as before.
>=20
> I'm guessing there is some incompatibility between the recovery
> procedure implemented by Philby John and the fix for the setup race
> implemented by Jon Povey -- but I don't know enough about the drivers
> to say what that might be.
>=20

Have you tested to recover the i2c bus by adding some SCL pulses manual=
ly
(Shorten SCL to ground)?


I tried your patch:

> Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>=20
> 15.03.2011 22:08
[...]
> I tried the following patch based on the description of the steps you=
=20
took to=20
> recover the bus. Is there anything you can add? I still get lots of=20
> 'controller timed out' errors.
>=20
> Best Regards,
>=20
> Ben Gardiner
>=20
> Nanometrics Inc.
> http://www.nanometrics.ca
>=20
> ---
>=20
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/
> i2c-davinci.c
> index 5795c83..52e5e60 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -89,6 +89,7 @@
>  #define DAVINCI_I2C_MDR_XA   BIT(8)
>  #define DAVINCI_I2C_MDR_RM   BIT(7)
>  #define DAVINCI_I2C_MDR_IRS   BIT(5)
> +#define DAVINCI_I2C_MDR_FDF   BIT(3)
>=20
>  #define DAVINCI_I2C_IMR_AAS   BIT(6)
>  #define DAVINCI_I2C_IMR_SCD   BIT(5)
> @@ -149,6 +150,36 @@ static void generic_i2c_clock_pulse(unsigned int=
=20
scl_pin)
>     }
>  }
>=20
> +static void alternate_i2c_clock_pulse(struct davinci_i2c_dev *dev)
> +{
> +   u32 flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> +   /* free data format mode */
> +   flag |=3D DAVINCI_I2C_MDR_FDF;
> +   /* receive byte */
> +   flag &=3D ~DAVINCI_I2C_MDR_TRX;
> +   /* repeat */
> +   flag |=3D DAVINCI_I2C_MDR_RM;
> +
> +   /*
> +    * Write mode register first as needed for correct behaviour
> +    * on OMAP-L138, but don't set STT yet to avoid a race with XRDY
> +    * occuring before we have loaded DXR
> +    */
> +   davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> +
> +   /* Disable receive and transmit interrupts */
> +   flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
> +   flag &=3D ~DAVINCI_I2C_IMR_RRDY;
> +   flag &=3D ~DAVINCI_I2C_IMR_XRDY;
> +   davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, flag);
> +
> +   /* Set STT to begin transmit now DXR is loaded */
> +   flag |=3D DAVINCI_I2C_MDR_STT;
> +   davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> +
> +   udelay(40*9);
> +}
> +
>  /* This routine does i2c bus recovery as specified in the
>   * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
>   */
> @@ -163,8 +194,10 @@ static void i2c_recover_bus(struct davinci_i2c_d=
ev=20
*dev)
>     flag |=3D  DAVINCI_I2C_MDR_NACK;
>     /* write the data into mode register */
>     davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> -   if (pdata)
> +   if (pdata->scl_pin)
>        generic_i2c_clock_pulse(pdata->scl_pin);
> +   else
> +      alternate_i2c_clock_pulse(dev);
>     /* Send STOP */
>     flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>     flag |=3D DAVINCI_I2C_MDR_STP;

It seems we are working on different trees.=20

git log drivers/i2c/busses/i2c-davinci.c

gives me the following output.

commit c5b4afec8e669bbe265daea24037fccfc42c4fe3
Author: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Date:   Tue Oct 12 13:47:05 2010 +0900

    i2c-davinci: Fix TX setup for more SoCs
[...]=20
commit 4bba0fd8d1c6d405df666e2573e1a1f917098be0
Author: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Date:   Fri Sep 17 12:02:11 2010 +0900

    i2c-davinci: Fix race when setting up for TX
[...]
commit 8574faf9a5ae71fdd84c6413779a9b076138eb9e
Author: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
[...]

=2E..so the patch doesn =B4t apply smooth.=20
I put your changes in manually.

The alternate_i2c_clock_pulse function does not generate extra pulses o=
n=20
the clock line.
After applying this pach, i am not able to recreate the i2c bus with=20
shortcutting SCL to ground anymore.=20

Are there extra Clock cycles on your EVM UI Board?=20

Regards,

Bastian.
