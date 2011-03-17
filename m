From: Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org
Subject: Re: How to put extra clock cycles on i2c cavinci, problems on omapl138 (logic
 pd som)
Date: Thu, 17 Mar 2011 15:13:09 +0100
Message-ID: <OF533CF913.E277EFE5-ONC1257856.004C0321-C1257856.004E1D46@sewerin.de>
References: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3@sewerin.de>	<AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs@mail.gmail.com>
	<OFCCCD2C6E.D899BA32-ONC1257856.00307955-C1257856.00323B2B@sewerin.de> <AANLkTinAgDKe8GD5GQoKaJ3p2s1Pj_DWduEnp6deZu=f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinAgDKe8GD5GQoKaJ3p2s1Pj_DWduEnp6deZu=f@mail.gmail.com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org, Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>=20
> Hi Bastian,

Hello Ben,

[...]
> >>
> >
> > Have you tested to recover the i2c bus by adding some SCL pulses=20
manually
> > (Shorten SCL to ground)?
>=20
> I shorted I2C0_SCL at pin 22 of the PH146(tca416) on the baseboard.
> The first time it appeared to work -- the repeating messages on the
> console stopped. Sometime the messages started up again; I repeated
> the procedure but this time the messages did not stop.
>=20

Sometimes, when a slave "holds" the SDA it need some drive through i2c=20
clock.

> > I tried your patch:
> >
> >> Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
> >> 15.03.2011 22:08
> > [...]
> >> I tried the following patch based on the description of the steps =
you
> > took to
> >> recover the bus. Is there anything you can add? I still get lots o=
f
> >> 'controller timed out' errors.
> >>
> >> Best Regards,
> >>
> >> Ben Gardiner
> >>
> >> Nanometrics Inc.
> >> http://www.nanometrics.ca
> >>
> >> ---
> >>
> >> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses=
/
> >> i2c-davinci.c
> >> index 5795c83..52e5e60 100644
> >> --- a/drivers/i2c/busses/i2c-davinci.c
> >> +++ b/drivers/i2c/busses/i2c-davinci.c
> >> @@ -89,6 +89,7 @@
> >>  #define DAVINCI_I2C_MDR_XA   BIT(8)
> >>  #define DAVINCI_I2C_MDR_RM   BIT(7)
> >>  #define DAVINCI_I2C_MDR_IRS   BIT(5)
> >> +#define DAVINCI_I2C_MDR_FDF   BIT(3)
> >>
> >>  #define DAVINCI_I2C_IMR_AAS   BIT(6)
> >>  #define DAVINCI_I2C_IMR_SCD   BIT(5)
> >> @@ -149,6 +150,36 @@ static void generic_i2c_clock_pulse(unsigned =
int
> > scl_pin)
> >>     }
> >>  }
> >>
> >> +static void alternate_i2c_clock_pulse(struct davinci_i2c_dev *dev=
)
> >> +{
> >> +   u32 flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> >> +   /* free data format mode */
> >> +   flag |=3D DAVINCI_I2C_MDR_FDF;
> >> +   /* receive byte */
> >> +   flag &=3D ~DAVINCI_I2C_MDR_TRX;
> >> +   /* repeat */
> >> +   flag |=3D DAVINCI_I2C_MDR_RM;
> >> +
> >> +   /*
> >> +    * Write mode register first as needed for correct behaviour
> >> +    * on OMAP-L138, but don't set STT yet to avoid a race with XR=
DY
> >> +    * occuring before we have loaded DXR
> >> +    */
> >> +   davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> >> +
> >> +   /* Disable receive and transmit interrupts */
> >> +   flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
> >> +   flag &=3D ~DAVINCI_I2C_IMR_RRDY;
> >> +   flag &=3D ~DAVINCI_I2C_IMR_XRDY;
> >> +   davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, flag);
> >> +
> >> +   /* Set STT to begin transmit now DXR is loaded */
> >> +   flag |=3D DAVINCI_I2C_MDR_STT;
> >> +   davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> >> +
> >> +   udelay(40*9);
> >> +}
> >> +
> >>  /* This routine does i2c bus recovery as specified in the
> >>   * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
> >>   */
> >> @@ -163,8 +194,10 @@ static void i2c_recover_bus(struct=20
davinci_i2c_dev
> > *dev)
> >>     flag |=3D  DAVINCI_I2C_MDR_NACK;
> >>     /* write the data into mode register */
> >>     davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> >> -   if (pdata)
> >> +   if (pdata->scl_pin)
> >>        generic_i2c_clock_pulse(pdata->scl_pin);
> >> +   else
> >> +      alternate_i2c_clock_pulse(dev);
> >>     /* Send STOP */
> >>     flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> >>     flag |=3D DAVINCI_I2C_MDR_STP;
> >
> > It seems we are working on different trees.
>=20
> I was working off of v2.6.38-rc8 here.
>=20
> > git log drivers/i2c/busses/i2c-davinci.c
> >
> > gives me the following output.
> >
> > commit c5b4afec8e669bbe265daea24037fccfc42c4fe3
> > Author: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
> > Date:   Tue Oct 12 13:47:05 2010 +0900
> >
> >    i2c-davinci: Fix TX setup for more SoCs
> > [...]
> > commit 4bba0fd8d1c6d405df666e2573e1a1f917098be0
> > Author: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
> > Date:   Fri Sep 17 12:02:11 2010 +0900
> >
> >    i2c-davinci: Fix race when setting up for TX
> > [...]
> > commit 8574faf9a5ae71fdd84c6413779a9b076138eb9e
> > Author: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> > [...]
> >
> > ...so the patch doesn =B4t apply smooth.
>=20
> You are missing the following commit
>=20
> commit c5b4afec8e669bbe265daea24037fccfc42c4fe3
> Author: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
> Date:   Tue Oct 12 13:47:05 2010 +0900
>=20
>     i2c-davinci: Fix TX setup for more SoCs
>=20
>     This patch is an improvement to=20
4bba0fd8d1c6d405df666e2573e1a1f917098be0
>     which got to mainline a little early.
>=20
>     Sudhakar Rajashekhara explains that at least OMAP-L138 requires M=
DR=20
mode
>     settings before DXR for correct behaviour, so load MDR first with
>     STT cleared and later load again with STT set.
>=20
>     Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985
>=20
>     Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
>     Acked-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
>     Tested-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
>     Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>     Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>=20

Ok.

> > The alternate_i2c_clock_pulse function does not generate extra puls=
es=20
on
> > the clock line.
>=20
> Ok. I made the patch from the short snip of the method you described;
> I was more wondering whether the patch was the same as what you've
> tested.
>=20
> > After applying this pach, i am not able to recreate the i2c bus wit=
h
> > shortcutting SCL to ground anymore.
>=20
> Yeah -- I can confirm also that with the patch applied I am unable to
> free the bus by shorting SCL to ground. The patch is doing more harm
> than good.
>=20
> > Are there extra Clock cycles on your EVM UI Board?
>=20
> I'm not sure. I'm sorry I don't have a logic analyzer available ATM.
>=20
> I noticed on the e2e forums that there is a reason why the PSP uses a
> bitbanging i2c interface -- since the 1.0v OPP makes the i2c
> controller unusable [1] (I've added Sekhar to the CC since he pointed
> out the problem in that post).
>=20

Yes, i saw this post before, but our chip is driving 1.2V and we still=20
have=20
our problems.

> I had my kernel configured to use CPU frequency scaling -- I disabled
> the feature but this did not fix the problem.
>=20
> I wonder if there is YA hardware problem with i2c on the LogicPD
> boards. I've noticed that when I don't have the UBI board connected
> then I don't get the controller timeouts.
>=20

I have some effects here, too.
We have a i2c repeater solded on our board (PCA9515AD). With this repea=
ter=20

i can reproduce the errer pretty fast.
Without this repeater solded on, the mean time before failure is much=20
higher.

I can produce the error pretty fast with the ts_test tool. Without any=20
userland=20
tool using the touchscreen info or with the tool evtest, i can see the =
i2c=20

action on the oscilloscope but it is hard to produce the error.
What does this indicate to?=20
Is it possible that userland can influence the kernel driver timing to=20
promote=20
the error?=20

> Have you tried using the bitbanging i2c driver? I suppose that using
> the bitbanging i2c driver would be too much CPU overhead for polling
> your touchscreen...
>=20

Yes, the bitbanging driver gives me "boiled NACK" errors or so sometime=
s,=20
but the system do not stall. (In my opinion, bitbanging is not the eleg=
ant=20
way=20
to do i2c).

> Have you asked about how to implement this FDF-SCL-toggle method on
> the e2e forums?

No, i did not.

> Best Regards,
> Ben Gardiner
>=20

Regards,
=20
Bastian.
