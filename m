From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 5/5] i2c: Add Actions Semi OWL family S900 I2C driver
Date: Tue, 26 Jun 2018 20:18:44 +0300
Message-ID: <CAHp75VdR5UbGvM3AOu21+Hp1xqPgtSnjRSKyhnCeB8ebAmF7eQ@mail.gmail.com>
References: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
 <20180623161147.15672-6-manivannan.sadhasivam@linaro.org> <CAHp75Vf_JR6scrwnomiu62_x2idgCGH63UdMf2bhfy8VNaijXQ@mail.gmail.com>
 <20180626170125.GB5241@Mani-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626170125.GB5241@Mani-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-i2c <linux-i2c@vger.kernel.org>, =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com, 96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hzhang@ucrobotics.com, bdong@ucrobotics.com, Mani Sadhasivam <manivannanece23@gmail.com>, Thomas Liau <thomas.liau@actions-semi.com>, jeff.chen@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 26, 2018 at 8:01 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Mon, Jun 25, 2018 at 12:38:50PM +0300, Andy Shevchenko wrote:
>> On Sat, Jun 23, 2018 at 7:11 PM, Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:

>> > +#define OWL_I2C_REG_CTL                (0x0000)
>> > +#define OWL_I2C_REG_CLKDIV     (0x0004)
>> > +#define OWL_I2C_REG_STAT       (0x0008)
>> > +#define OWL_I2C_REG_ADDR       (0x000C)
>> > +#define OWL_I2C_REG_TXDAT      (0x0010)
>> > +#define OWL_I2C_REG_RXDAT      (0x0014)
>> > +#define OWL_I2C_REG_CMD                (0x0018)
>> > +#define OWL_I2C_REG_FIFOCTL    (0x001C)
>> > +#define OWL_I2C_REG_FIFOSTAT   (0x0020)
>> > +#define OWL_I2C_REG_DATCNT     (0x0024)
>> > +#define OWL_I2C_REG_RCNT       (0x0028)
>>
>> I don't understand why these have parents?
>>
>
> I'm not sure what you mean here! Can you please elaborate?

One has to read 'parens'. Sorry for confusion.

>> > +#define OWL_I2C_TIMEOUT                (msecs_to_jiffies(4 * 1000))
>>
>> Ditto.

> Same as above

Ditto.

>> > +       /* Wait until FIFO reset complete */
>> > +       do {
>> > +               val =3D readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
>> > +               if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR=
)))
>> > +                       break;
>> > +       } while (1);
>>
>> No way. Get rid of infinite loop.

> Okay. Can I change it to max of 50 retries with 1ms delay?

Whatever suitable for HW. Rely on datasheet or other source of
information about this timeouts.

>> > +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)

>> > +               dev_warn(&i2c_dev->adap.dev, "received NACK from devic=
e");
>>
>> And if it happens hundreds times in a row?

> Should I change it to dev_dbg?

>> > +               dev_warn(&i2c_dev->adap.dev, "bus error");

> Same as above?

ratelimit, another level, tracepoints, getting rid of them completely
=E2=80=94 your call.

--=20
With Best Regards,
Andy Shevchenko
