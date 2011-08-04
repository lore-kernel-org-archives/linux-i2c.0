From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: add OF binding support
Date: Thu, 4 Aug 2011 23:12:18 +0100
Message-ID: <CACxGe6um0SOvhoFcTeNFCBzYd9M5SBhSPZOAy_rqhHK3PCcsGw@mail.gmail.com>
References: <1312401863-25822-1-git-send-email-robherring2@gmail.com>
	<20110804091223.GA19115@trinity.fluff.org> <4E3ABE96.9020402@gmail.com>
	<4E3B14B1.4090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4E3B14B1.4090604-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 4, 2011 at 10:52 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 08/04/2011 10:45 AM, Rob Herring wrote:
>> Ben,
>>
>> On 08/04/2011 04:12 AM, Ben Dooks wrote:
>>> On Wed, Aug 03, 2011 at 03:04:23PM -0500, Rob Herring wrote:
>>>> From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>>>>
>>>> Add of_match_table and DT style i2c registration to designware i2c
>>>> driver.
>>>>
>>>> Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>>>> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>>> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
>>>> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>>>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> ---
>>>> =A0Documentation/devicetree/bindings/i2c/dw-i2c.txt | =A0 23 +++++++++=
+++++++++++++
>>>> =A0drivers/i2c/busses/i2c-designware.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 13 ++++++++++++
>>>> =A02 files changed, 36 insertions(+), 0 deletions(-)
>>>> =A0create mode 100644 Documentation/devicetree/bindings/i2c/dw-i2c.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/dw-i2c.txt b/Docume=
ntation/devicetree/bindings/i2c/dw-i2c.txt
>>>> new file mode 100644
>>>> index 0000000..cbcb404
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/i2c/dw-i2c.txt
>>>> @@ -0,0 +1,23 @@
>>>> +* Synopsys DesignWare I2C
>>>> +
>>>> +Required properties :
>>>> +
>>>> + - compatible : should be "snps,designware-i2c"
>>>> + - reg : Offset and length of the register set for the device
>>>> + - interrupts : <IRQ> where IRQ is the interrupt number.
>>>> +
>>>> +Recommended properties :
>>>> +
>>>> + - clock-frequency : desired I2C bus clock frequency in Hz.
>>>> +
>>>> +Example :
>>>> +
>>>> + =A0 i2c@f0000 {
>>>> + =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>>>> + =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
>>>> + =A0 =A0 =A0 =A0 =A0 compatible =3D "snps,designware-i2c";
>>>> + =A0 =A0 =A0 =A0 =A0 reg =3D <0xf0000 0x1000>;
>>>> + =A0 =A0 =A0 =A0 =A0 interrupts =3D <11>;
>>>> + =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <400000>;
>>>> + =A0 };
>>>> +
>>>
>>> looks good to me.
>>>
>>>> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/=
i2c-designware.c
>>>> index b7a51c4..2911a49 100644
>>>> --- a/drivers/i2c/busses/i2c-designware.c
>>>> +++ b/drivers/i2c/busses/i2c-designware.c
>>>> @@ -37,6 +37,7 @@
>>>> =A0#include <linux/platform_device.h>
>>>> =A0#include <linux/io.h>
>>>> =A0#include <linux/slab.h>
>>>> +#include <linux/of_i2c.h>
>>>>
>>>> =A0/*
>>>> =A0 * Registers offset
>>>> @@ -770,12 +771,17 @@ static int __devinit dw_i2c_probe(struct platfor=
m_device *pdev)
>>>> =A0 =A0 adap->algo =3D &i2c_dw_algo;
>>>> =A0 =A0 adap->dev.parent =3D &pdev->dev;
>>>>
>>>> +#ifdef CONFIG_OF
>>>> + =A0 r =3D i2c_add_adapter(adap);
>>>> +#else
>>>> =A0 =A0 adap->nr =3D pdev->id;
>>>> =A0 =A0 r =3D i2c_add_numbered_adapter(adap);
>>>> +#endif
>>>
>>> I would say that doing the #ifdef CONFIG_OF is dangerous here when we
>>> are in a mixed OF/platform enviromnent as we're depending on compile
>>> time selection.
>>>
>>> I'm also wondering whether we have an of helper macro which takes
>>> a pdev and gives you an adapter number either given on pdev->id or
>>> -1 for the case when we're using the OF bindings.
>>>
>>> It might be worth talking to Grant about setting pdev->id to -1 if we
>>> are using an OF device.
>>>
>>
>> As Grant said, that's already done and this hunk is not needed.
>>
>>>> =A0 =A0 if (r) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failure adding adapter\n"=
);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
>>>> =A0 =A0 }
>>>> + =A0 of_i2c_register_devices(adap);
>>>
>>> If we did that, we could add a of_i2c_register_adapter() call which
>>> would take the platform device and then do the of_i2c_register_devices()
>>> and do these steps.
>>>
>>
>> Better yet, how about putting of_i2c_register_devices into
>> i2c_register_adapter? Everywhere that calls of_i2c_register_devices is
>> preceded by a call to i2c_add_numbered_adapter or i2c_add_adapter. It
>> seems logical to put it with i2c_scan_static_board_info. I'll prepare a
>> patch to add that and remove all the other callers unless you think
>> that's a bad idea.
>>
>
> Nevermind. That would be undoing this commit:
>
> =A0 =A0of/i2c: Fix module load order issue caused by of_i2c.c

The other alternative would be to move the i2c dt parsing code into
drivers/i2c.  I'm already planning to do that for spi and gpio dt
parsing code.

g.
