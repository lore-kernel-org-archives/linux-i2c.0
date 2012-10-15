From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2] i2c: change the id to let the i2c-gpio work
Date: Mon, 15 Oct 2012 08:42:14 +0200
Message-ID: <507BB046.8010702@atmel.com>
References: <1350034971-1050-1-git-send-email-voice.shen@atmel.com>
 <CAGhQ9VxRGQ8JAygxJreNDJY=tJ67yt2CM9NHvW3VyhjxooXuig@mail.gmail.com>
 <507B7066.4060802@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <507B7066.4060802@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bo Shen <voice.shen@atmel.com>
Cc: broonie@opensource.wolfsonmicro.com, Joachim Eastwood <manabian@gmail.com>, n.voss@weinmann.de, nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, linux-i2c@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, hskinnemoen@gmail.com
List-Id: linux-i2c@vger.kernel.org

Le 10/15/2012 04:09 AM, Bo Shen a =E9crit :
> Hi Joachim Eastwood,
>
> On 10/13/2012 1:42, Joachim Eastwood wrote:
>> Hi Bo Shen,
>>
>> On Fri, Oct 12, 2012 at 11:42 AM, Bo Shen <voice.shen@atmel.com> wrote:
>>> The i2c-gpio driver will turn the platform device ID to busnum.
>>> When using platfrom device ID as -1, it means dynamically assigned
>>> the busnum. When writing code, we need to make sure the busnum,
>>> and call i2c_register_board_info(int busnum, ...) to register device
>>> if using -1, we do not know the value of busnum.
>>>
>>> In order to solve this issue, set the platform device ID as a fix number
>>> Here using 0 to match the busnum used in i2c_regsiter_board_info().
>>
>> I have been bitten by this myself on RM9200.
>>
>>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>>> ---
>>> Change since v1
>>>    Make the commit message more clear
>>> ---
>>>   arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
>>
>> This pattern exist in at91rm9200_devices.c, at91sam9261_devices.c,
>> at91sam9263_devices.c and at91sam9rl_devices.c you might want to fix
>> them as well.
>
> Thanks for your information.
> After I test these boards, I will send patches to fix them, while not in
> this patch.
>
>>
>> I assume we have the same problem if CONFIG_I2C_AT91 is set?
>> See further down in at91sam9260_devices.c we have another:  ".id =3D -1,"
>
> Maybe Nikolaus Voss will deal with this case.
>

Yes the problem is the same, I have encountered it and solved it in the =

same way but I was thinking there was a better way to correct it than =

removing dynamic id assignment.
Since setting the id to a fix value is acceptable this change can be =

done also when using i2c-at91.

>>
>> regards
>> Joachim Eastwood
>>
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c
>>> b/arch/arm/mach-at91/at91sam9260_devices.c
>>> index 0f24cfb..805ef95 100644
>>> --- a/arch/arm/mach-at91/at91sam9260_devices.c
>>> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
>>> @@ -389,7 +389,7 @@ static struct i2c_gpio_platform_data pdata =3D {
>>>
>>>   static struct platform_device at91sam9260_twi_device =3D {
>>>          .name                   =3D "i2c-gpio",
>>> -       .id                     =3D -1,
>>> +       .id                     =3D 0,
>>>          .dev.platform_data      =3D &pdata,
>>>   };
>>>
>>> --
>>> 1.7.9.5
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
