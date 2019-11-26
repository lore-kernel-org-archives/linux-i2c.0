From: Tali Perry <tali.perry1@gmail.com>
Subject: Re: [PATCH v7 2/2] i2c: npcm: Add Nuvoton NPCM I2C controller driver
Date: Tue, 26 Nov 2019 11:27:54 +0200
Message-ID: <CAHb3i=s+u1gHXwi7j7V_N-c8f8n7c1XB3QhkY8EAJuv6PA5GNw@mail.gmail.com>
References: <20191121095350.158689-1-tali.perry1@gmail.com>
 <20191121095350.158689-3-tali.perry1@gmail.com> <20191125151618.GE2412@kunai> <CAHb3i=tGTcu2q15E5CL_od1rDgRDyx=ygoGSCu88AfBrnFn71w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHb3i=tGTcu2q15E5CL_od1rDgRDyx=ygoGSCu88AfBrnFn71w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nancy Yuen <yuenn@google.com>, Patrick Venture <venture@google.com>, Benjamin Fair <benjaminfair@google.com>, avifishman70@gmail.com, joel@jms.id.au, Tomer Maimon <tmaimon77@gmail.com>, syniurge@gmail.com, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thanks for your comments.

The NPCM7XX BMC I2C\SMB controller HW module supports both SMB and I2C.
It's main features are:
1. Supports Fast-Mode (400 KHz clock) I2C and Fast-Mode-plus (1 MHz clock) =
I2C
2. Supports the =E2=80=98fairness=E2=80=99 arbitration protocol defined by =
the MCTP
SMBus/I2C Transport Binding Specification v1.0.0
3. 32KB packets : this is an I2C spec limitation. The HW has no limit
on packets size. It has a 16 bytes FIFO which can be reloaded over and
over.
4. w\o size byte (for SMB block protocol).
5. Both master and slave. It can also replace modes in run time
(requirement for IPMB and MCTP).
6. Bus timing is selected to support both specs.

Originally the HW spec stated SMB everywhere .

Should I rename the SMB to I2C all over the driver?

Thanks,
Tali Perry


On Tue, Nov 26, 2019 at 8:47 AM Tali Perry <tali.perry1@gmail.com> wrote:
>
> Hi Wolfram,
>
> Thanks for your comments.
>
> The NPCM7XX BMC I2C\SMB controller HW module supports both SMB and I2C.
> It's main features are:
> 1. Supports Fast-Mode (400 KHz clock) I2C and Fast-Mode-plus (1 MHz clock=
) I2C
> 2. Supports the =E2=80=98fairness=E2=80=99 arbitration protocol defined b=
y the MCTP SMBus/I2C Transport Binding Specification v1.0.0
> 3. 32KB packets : this is an I2C spec limitation. The HW has no limit on =
packets size. It has a 16 bytes FIFO which can be reloaded over and over.
> 4. w\o size byte (for SMB block protocol).
> 5. Both master and slave. It can also replace modes in run time (requirem=
ent for IPMB and MCTP).
> 6. Bus timing is selected to support both specs.
>
> Originally the HW spec stated SMB everywhere .
>
> Should I rename the SMB to I2C all over the driver?
>
> Thanks,
> Tali Perry
>
>
> On Mon, Nov 25, 2019 at 5:16 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>> On Thu, Nov 21, 2019 at 11:53:50AM +0200, Tali Perry wrote:
>> > Add Nuvoton NPCM BMC i2c controller driver.
>> >
>> > Signed-off-by: Tali Perry <tali.perry1@gmail.com>
>>
>> Looking at all this SMB_* naming of the registers and also the quirks,
>> this looks more like an SMBUS controller to me?
>>
>> > +     // currently I2C slave IF only supports single byte operations.
>> > +     // in order to utilyze the npcm HW FIFO, the driver will ask for=
 16bytes
>> > +     // at a time, pack them in buffer, and then transmit them all to=
gether
>> > +     // to the FIFO and onward to the bus .
>> > +     // NACK on read will be once reached to bus->adap->quirks->max_r=
ead_len
>> > +     // sending a NACK whever the backend requests for it is not supp=
orted.
>>
>> This for example...
>>
>> > +static const struct i2c_adapter_quirks npcm_i2c_quirks =3D {
>> > +     .max_read_len =3D 32768,
>> > +     .max_write_len =3D 32768,
>> > +     .max_num_msgs =3D 2,
>> > +     .flags =3D I2C_AQ_COMB_WRITE_THEN_READ
>> > +};
>>
>> ... and this. Like SMBus with the only exception of being able to send
>> 32K in a row. Or?
>>
