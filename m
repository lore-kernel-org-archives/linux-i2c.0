From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: Re: How to put extra clock cycles on i2c cavinci, problems on
 omapl138 (logic pd som)
Date: Thu, 17 Mar 2011 09:25:00 -0400
Message-ID: <AANLkTinAgDKe8GD5GQoKaJ3p2s1Pj_DWduEnp6deZu=f@mail.gmail.com>
References: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3@sewerin.de>
	<AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs@mail.gmail.com>
	<OFCCCD2C6E.D899BA32-ONC1257856.00307955-C1257856.00323B2B@sewerin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <OFCCCD2C6E.D899BA32-ONC1257856.00307955-C1257856.00323B2B-qHSRieSIjQqELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Bastian,

On Thu, Mar 17, 2011 at 5:08 AM,  <Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org> wrote:
> Hello,
>
> [...]
>> >
>> > After some action on the touchscreen, there are communication erro=
rs
>> > on the i2c, and the bus stalled.
>> > In this state the SDA line is hold low and the driver gives repeat=
edly
>> > the following messages:
>> >
>> > tps6507x 1-0048: ADC result 1 read failed
>> > i2c_davinci i2c_davinci.1: controller timed out
>> > i2c_davinci i2c_davinci.1: initiating i2c bus recovery
>> > i2c_davinci i2c_davinci.1: controller timed out
>> > i2c_davinci i2c_davinci.1: initiating i2c bus recovery
>> > tps6507x 1-0048: TSC mode read failed
>> > i2c_davinci i2c_davinci.1: controller timed out
>> > i2c_davinci i2c_davinci.1: initiating i2c bus recovery
>> > i2c_davinci i2c_davinci.1: controller timed out
>> > i2c_davinci i2c_davinci.1: initiating i2c bus recovery
>> > tps6507x 1-0048: TSC mode read failed
>> > [...]
>>
>> I am also observing 'controller timed out' messages on v2.6.38-rc8 o=
n
>> the da850evm with the UI Board connected (the char-lcd one, no the
>> touchscreen).
>>
>> =A0The addresses 0x20 and 0x21 can be seen in the error output below
>> which I believe indicates that the slave(s) hanging the bus are the
>> gpio expanders on the baseboard and UI board.
>>
>> [...]
>> pca953x 1-0020: failed reading register
>> i2c_davinci i2c_davinci.1: controller timed out
>> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
>> pca953x 1-0021: failed reading register
>> i2c_davinci i2c_davinci.1: controller timed out
>> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
>> [...]
>>
>> The messages repeat with a mix of 0x20 and 0x21
>>
>> When I revert:
>> c5b4afec8e669bbe265daea24037fccfc42c4fe3 i2c-davinci: Fix TX setup
>> for more SoCs
>> 4bba0fd8d1c6d405df666e2573e1a1f917098be0 i2c-davinci: Fix race when
>> setting up for TX
>>
>> (CC'd the author, Jon Povey) -- I get the occasional:
>>
>> i2c_davinci i2c_davinci.1: abnormal termination buf_len=3D-1
>> pca953x 1-0020: failed reading register
>> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
>>
>> but not the long repeating string as before.
>>
>> I'm guessing there is some incompatibility between the recovery
>> procedure implemented by Philby John and the fix for the setup race
>> implemented by Jon Povey -- but I don't know enough about the driver=
s
>> to say what that might be.
>>
>
> Have you tested to recover the i2c bus by adding some SCL pulses manu=
ally
> (Shorten SCL to ground)?

I shorted I2C0_SCL at pin 22 of the PH146(tca416) on the baseboard.
The first time it appeared to work -- the repeating messages on the
console stopped. Sometime the messages started up again; I repeated
the procedure but this time the messages did not stop.

> I tried your patch:
>
>> Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
>> 15.03.2011 22:08
> [...]
>> I tried the following patch based on the description of the steps yo=
u
> took to
>> recover the bus. Is there anything you can add? I still get lots of
>> 'controller timed out' errors.
>>
>> Best Regards,
>>
>> Ben Gardiner
>>
>> Nanometrics Inc.
>> http://www.nanometrics.ca
>>
>> ---
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/
>> i2c-davinci.c
>> index 5795c83..52e5e60 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -89,6 +89,7 @@
>> =A0#define DAVINCI_I2C_MDR_XA =A0 BIT(8)
>> =A0#define DAVINCI_I2C_MDR_RM =A0 BIT(7)
>> =A0#define DAVINCI_I2C_MDR_IRS =A0 BIT(5)
>> +#define DAVINCI_I2C_MDR_FDF =A0 BIT(3)
>>
>> =A0#define DAVINCI_I2C_IMR_AAS =A0 BIT(6)
>> =A0#define DAVINCI_I2C_IMR_SCD =A0 BIT(5)
>> @@ -149,6 +150,36 @@ static void generic_i2c_clock_pulse(unsigned in=
t
> scl_pin)
>> =A0 =A0 }
>> =A0}
>>
>> +static void alternate_i2c_clock_pulse(struct davinci_i2c_dev *dev)
>> +{
>> + =A0 u32 flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>> + =A0 /* free data format mode */
>> + =A0 flag |=3D DAVINCI_I2C_MDR_FDF;
>> + =A0 /* receive byte */
>> + =A0 flag &=3D ~DAVINCI_I2C_MDR_TRX;
>> + =A0 /* repeat */
>> + =A0 flag |=3D DAVINCI_I2C_MDR_RM;
>> +
>> + =A0 /*
>> + =A0 =A0* Write mode register first as needed for correct behaviour
>> + =A0 =A0* on OMAP-L138, but don't set STT yet to avoid a race with =
XRDY
>> + =A0 =A0* occuring before we have loaded DXR
>> + =A0 =A0*/
>> + =A0 davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>> +
>> + =A0 /* Disable receive and transmit interrupts */
>> + =A0 flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
>> + =A0 flag &=3D ~DAVINCI_I2C_IMR_RRDY;
>> + =A0 flag &=3D ~DAVINCI_I2C_IMR_XRDY;
>> + =A0 davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, flag);
>> +
>> + =A0 /* Set STT to begin transmit now DXR is loaded */
>> + =A0 flag |=3D DAVINCI_I2C_MDR_STT;
>> + =A0 davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>> +
>> + =A0 udelay(40*9);
>> +}
>> +
>> =A0/* This routine does i2c bus recovery as specified in the
>> =A0 * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
>> =A0 */
>> @@ -163,8 +194,10 @@ static void i2c_recover_bus(struct davinci_i2c_=
dev
> *dev)
>> =A0 =A0 flag |=3D =A0DAVINCI_I2C_MDR_NACK;
>> =A0 =A0 /* write the data into mode register */
>> =A0 =A0 davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>> - =A0 if (pdata)
>> + =A0 if (pdata->scl_pin)
>> =A0 =A0 =A0 =A0generic_i2c_clock_pulse(pdata->scl_pin);
>> + =A0 else
>> + =A0 =A0 =A0alternate_i2c_clock_pulse(dev);
>> =A0 =A0 /* Send STOP */
>> =A0 =A0 flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>> =A0 =A0 flag |=3D DAVINCI_I2C_MDR_STP;
>
> It seems we are working on different trees.

I was working off of v2.6.38-rc8 here.

> git log drivers/i2c/busses/i2c-davinci.c
>
> gives me the following output.
>
> commit c5b4afec8e669bbe265daea24037fccfc42c4fe3
> Author: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
> Date: =A0 Tue Oct 12 13:47:05 2010 +0900
>
> =A0 =A0i2c-davinci: Fix TX setup for more SoCs
> [...]
> commit 4bba0fd8d1c6d405df666e2573e1a1f917098be0
> Author: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
> Date: =A0 Fri Sep 17 12:02:11 2010 +0900
>
> =A0 =A0i2c-davinci: Fix race when setting up for TX
> [...]
> commit 8574faf9a5ae71fdd84c6413779a9b076138eb9e
> Author: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> [...]
>
> ...so the patch doesn =B4t apply smooth.

You are missing the following commit

commit c5b4afec8e669bbe265daea24037fccfc42c4fe3
Author: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Date:   Tue Oct 12 13:47:05 2010 +0900

    i2c-davinci: Fix TX setup for more SoCs

    This patch is an improvement to 4bba0fd8d1c6d405df666e2573e1a1f9170=
98be0
    which got to mainline a little early.

    Sudhakar Rajashekhara explains that at least OMAP-L138 requires MDR=
 mode
    settings before DXR for correct behaviour, so load MDR first with
    STT cleared and later load again with STT set.

    Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985

    Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
    Acked-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
    Tested-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
    Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
    Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

> The alternate_i2c_clock_pulse function does not generate extra pulses=
 on
> the clock line.

Ok. I made the patch from the short snip of the method you described;
I was more wondering whether the patch was the same as what you've
tested.

> After applying this pach, i am not able to recreate the i2c bus with
> shortcutting SCL to ground anymore.

Yeah -- I can confirm also that with the patch applied I am unable to
free the bus by shorting SCL to ground. The patch is doing more harm
than good.

> Are there extra Clock cycles on your EVM UI Board?

I'm not sure. I'm sorry I don't have a logic analyzer available ATM.

I noticed on the e2e forums that there is a reason why the PSP uses a
bitbanging i2c interface -- since the 1.0v OPP makes the i2c
controller unusable [1] (I've added Sekhar to the CC since he pointed
out the problem in that post).

I had my kernel configured to use CPU frequency scaling -- I disabled
the feature but this did not fix the problem.

I wonder if there is YA hardware problem with i2c on the LogicPD
boards. I've noticed that when I don't have the UBI board connected
then I don't get the controller timeouts.

Have you tried using the bitbanging i2c driver? I suppose that using
the bitbanging i2c driver would be too much CPU overhead for polling
your touchscreen...

Have you asked about how to implement this FDF-SCL-toggle method on
the e2e forums?

Best Regards,
Ben Gardiner

[1] https://e2e.ti.com/support/embedded/f/354/p/68559/248084.aspx#24808=
4

---
Nanometrics Inc.
http://www.nanometrics.ca
