From: =?UTF-8?Q?Rados=C5=82aw_Pietrzyk?= <radoslaw.pietrzyk@gmail.com>
Subject: Re: [PATCH] i2c: stm32: Fixes multibyte transfer for STM32F4 I2C controller
Date: Tue, 17 Oct 2017 15:51:02 +0200
Message-ID: <CAFvLkMS9Q801biCBYp+fJeiOo22zr436Td43PH3GG8E6diSL3A@mail.gmail.com>
References: <1507722788-31224-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <990c3275-35b3-68da-453c-d1a80e867df7@st.com> <CAFvLkMS6+o3D88Rj23of56KtjonwFAVD_aEP3eWaA2H=U5WP4Q@mail.gmail.com>
 <2d892fec-0496-8a6f-51c9-439b933d9975@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2d892fec-0496-8a6f-51c9-439b933d9975@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

I can try of course but it means that any IRQ delay may cause the same
problem so the question is whether the driver should be vulnerable to
such use cases.

2017-10-17 15:18 GMT+02:00 Pierre Yves MORDRET <pierre-yves.mordret@st.com>=
:
>
>
> On 10/12/2017 11:55 AM, Rados=C5=82aw Pietrzyk wrote:
>> It looks like there is a use case when IRQ handler is delayed a bit
>> and the logic in the driver does not work. What is the real root cause
>> I don't know.
>>
>
> As far as I know on this STM32 F4 platform there is some trouble with tim=
er
> events that may have bad influences on scheduling. Some tasks could be de=
layed
> for some reasons.
> It would be great if the following patches below could help in your matte=
r
> https://patchwork.kernel.org/patch/9980961/
> https://patchwork.kernel.org/patch/9980963/
> https://patchwork.kernel.org/patch/9980965/
> https://patchwork.kernel.org/patch/9980967/
>
> Would you mind to test those ?
> Thanks
>
>> 2017-10-12 11:31 GMT+02:00 Pierre Yves MORDRET <pierre-yves.mordret@st.c=
om>:
>>>
>>>
>>> On 10/11/2017 01:53 PM, Radoslaw Pietrzyk wrote:
>>>>       Do not read data on RXNE but on BTF only due to HW
>>>>       synchronisation problems and NACKing read data too early.
>>>>       It was found during testing of stmpe811 touchscreen driver.
>>>>
>>>
>>> Would you mind to explain what is behind "hw sync issue" you've seen ?
>>>
>>>> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>>>> ---
>>>>  drivers/i2c/busses/i2c-stm32f4.c | 11 +----------
>>>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c=
-stm32f4.c
>>>> index 4ec1084..86bcf4c 100644
>>>> --- a/drivers/i2c/busses/i2c-stm32f4.c
>>>> +++ b/drivers/i2c/busses/i2c-stm32f4.c
>>>> @@ -409,16 +409,9 @@ static void stm32f4_i2c_handle_read(struct stm32f=
4_i2c_dev *i2c_dev)
>>>>        * So, here we just disable buffer interrupt in order to avoid a=
nother
>>>>        * system preemption due to RX not empty event.
>>>>        */
>>>> -     case 2:
>>>> -     case 3:
>>>> +     default:
>>>>               stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
>>>>               break;
>>>> -     /*
>>>> -      * For N byte reception with N > 3 we directly read data registe=
r
>>>> -      * until N-2 data.
>>>> -      */
>>>> -     default:
>>>> -             stm32f4_i2c_read_msg(i2c_dev);
>>>>       }
>>>>  }
>>>>
>>>> @@ -470,8 +463,6 @@ static void stm32f4_i2c_handle_rx_done(struct stm3=
2f4_i2c_dev *i2c_dev)
>>>>                */
>>>>               reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>>>>               stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
>>>> -             stm32f4_i2c_read_msg(i2c_dev);
>>>> -             break;
>>>>       default:
>>>>               stm32f4_i2c_read_msg(i2c_dev);
>>>>       }
>>>>
