From: "M'boumba Cedric Madianga" <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 4/5] ARM: dts: Add I2C1 support for STM32429 eval board
Date: Thu, 8 Dec 2016 09:47:46 +0100
Message-ID: <CAOAejn239D+R9AZuCVB8MChidAcQqWZvFzkkTTJF7s9UprzoaQ@mail.gmail.com>
References: <1481185563-8735-1-git-send-email-cedric.madianga@gmail.com>
 <1481185563-8735-5-git-send-email-cedric.madianga@gmail.com> <e61ae4d6-a65a-5cfa-6845-27351ac43af6@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e61ae4d6-a65a-5cfa-6845-27351ac43af6-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alex,


2016-12-08 9:39 GMT+01:00 Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>:
> Hi Cedric,
>
> On 12/08/2016 09:26 AM, M'boumba Cedric Madianga wrote:
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/stm32429i-eval.dts | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
> Can you change the commit header by: ARM: dts: stm32: Add I2C1 support for
> STM32429 eval board
Ok, I will use this typo in the next version

>
> thx
> Alex
>
>
>> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts
>> b/arch/arm/boot/dts/stm32429i-eval.dts
>> index afb90bc..74e0045 100644
>> --- a/arch/arm/boot/dts/stm32429i-eval.dts
>> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
>> @@ -141,3 +141,9 @@
>>         pinctrl-names = "default";
>>         status = "okay";
>>  };
>> +
>> +&i2c1 {
>> +       pinctrl-0 = <&i2c1_pins_b>;
>> +       pinctrl-names = "default";
>> +       status = "okay";
>> +};
>>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
