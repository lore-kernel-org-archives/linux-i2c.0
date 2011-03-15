From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: Re: How to put extra clock cycles on i2c cavinci, problems on
 omapl138 (logic pd som)
Date: Tue, 15 Mar 2011 13:02:37 -0400
Message-ID: <AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs@mail.gmail.com>
References: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3@sewerin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3-qHSRieSIjQqELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Bastian,

On Fri, Mar 11, 2011 at 7:52 AM,  <Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org> wrote:
> Hello,
>
> we have problems with the davinci-i2c driver on an omapl-138 (Logic P=
D
> SOM) in
> conjunction with tps65070 hardware and tps6507x_ts touchscreen driver=
=2E
>
> (The following thread is related to this issue.
> http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/MDL2sXcvxsEg@public.gmane.org=
p.com/msg21162.html
> )
>
> After some action on the touchscreen, there are communication errors
> on the i2c, and the bus stalled.
> In this state the SDA line is hold low and the driver gives repeatedl=
y
> the following messages:
>
> tps6507x 1-0048: ADC result 1 read failed
> i2c_davinci i2c_davinci.1: controller timed out
> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> i2c_davinci i2c_davinci.1: controller timed out
> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> tps6507x 1-0048: TSC mode read failed
> i2c_davinci i2c_davinci.1: controller timed out
> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> i2c_davinci i2c_davinci.1: controller timed out
> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> tps6507x 1-0048: TSC mode read failed
> [...]

I am also observing 'controller timed out' messages on v2.6.38-rc8 on
the da850evm with the UI Board connected (the char-lcd one, no the
touchscreen).

 The addresses 0x20 and 0x21 can be seen in the error output below
which I believe indicates that the slave(s) hanging the bus are the
gpio expanders on the baseboard and UI board.

[...]
pca953x 1-0020: failed reading register
i2c_davinci i2c_davinci.1: controller timed out
i2c_davinci i2c_davinci.1: initiating i2c bus recovery
pca953x 1-0021: failed reading register
i2c_davinci i2c_davinci.1: controller timed out
i2c_davinci i2c_davinci.1: initiating i2c bus recovery
[...]

The messages repeat with a mix of 0x20 and 0x21

When I revert:
c5b4afec8e669bbe265daea24037fccfc42c4fe3 i2c-davinci: Fix TX setup for =
more SoCs
4bba0fd8d1c6d405df666e2573e1a1f917098be0 i2c-davinci: Fix race when
setting up for TX

(CC'd the author, Jon Povey) -- I get the occasional:

i2c_davinci i2c_davinci.1: abnormal termination buf_len=3D-1
pca953x 1-0020: failed reading register
i2c_davinci i2c_davinci.1: initiating i2c bus recovery

but not the long repeating string as before.

I'm guessing there is some incompatibility between the recovery
procedure implemented by Philby John and the fix for the setup race
implemented by Jon Povey -- but I don't know enough about the drivers
to say what that might be.

> When giving a short low impulse on the SCL wire by shortcutting
> this line with ground, the i2c is running again.
>
> Under http://processors.wiki.ti.com/index.php/I2C_Tips
> there is article about : External Slave Device Hanging the Bus by
> Holding SDA Low
>
> Option 1: For devices that mux the SCL/SDA pins with GPIO, the easies=
t
> thing is to configure the pins for GPIO operation and toggle SCL unti=
l
> the slave releases SDA. At this point you should be able to resume
> normal operation.
>
> Option 2: Many devices don't mux SCL/SDA with GPIO since the I2C I/O
> cells are often special open drain cells. A workaround has been
> reported to work even on these devices. By configuring the I2C for
> "free data format" and then reading a byte the I2C will immediately
> start sending clocks to input data (rather than trying to send an
> address). This can be used to free up the bus.
>
> We would like to have some extra SCL pulses in the function
> static void i2c_recover_bus(struct davinci_i2c_dev *dev).
>
> We tried to put the I2C in "free data format" and read one byte with
> the following lines:
>
> =A0 =A0 =A0 =A0 =A0 =A0flag |=3D DAVINCI_I2C_MDR_FDF;// free data for=
mat mode
> =A0 =A0 =A0 =A0 =A0 =A0flag &=3D ~DAVINCI_I2C_MDR_TRX;// receive byte
> =A0 =A0 =A0 =A0 =A0 =A0// Set STT to begin transmit now DXR is loaded
> =A0 =A0 =A0 =A0 =A0 =A0flag |=3D DAVINCI_I2C_MDR_STT;
> =A0 =A0 =A0 =A0 =A0 =A0davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG=
, flag);
>
> But that doesn`t work that way.
>
> We have problems to use the GPIO variant to toggle SCL or using the
> generic_i2c_clock_pulse function, too.
>
> Please tell me how to get extra clock cycles on i2c?
>
> Thank you, regards,
>
> Bastian Ruppert.
>
> P.S.
>
> [please put me on cc, i am not on the vger.kernel.org list, thx]
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
