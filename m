From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Date: Mon, 6 Feb 2012 10:20:36 +0800
Message-ID: <CAGsJ_4zNjkLOs_A8H1-yteDTZodFGjh=3k9x0P-hmBb1w2q4vg@mail.gmail.com>
References: <1327846668-3053-1-git-send-email-21cnbao@gmail.com>
 <20120205223757.GA10680@nekote.pengutronix.de> <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <ninja-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfi=
g
>>> index 3101dd5..a3c43fc 100644
>>> --- a/drivers/i2c/busses/Kconfig
>>> +++ b/drivers/i2c/busses/Kconfig
>>> @@ -618,6 +618,16 @@ config I2C_SH_MOBILE
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver can also be built as a modu=
le. =C2=A0If so, the module
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 will be called i2c-sh_mobile.
>>>
>>> +config I2C_SIRF
>>> + =C2=A0 =C2=A0 tristate "CSR SiRFprimaII I2C interface"
>>> + =C2=A0 =C2=A0 depends on ARCH_PRIMA2
>>> + =C2=A0 =C2=A0 help
>>> + =C2=A0 =C2=A0 =C2=A0 If you say yes to this option, support will =
be included for the
>>> + =C2=A0 =C2=A0 =C2=A0 CSR SiRFprimaII I2C interface.
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 This driver can also be built as a module. =C2=
=A0If so, the module
>>> + =C2=A0 =C2=A0 =C2=A0 will be called i2c-sirf.
>>> +
>>
>> Sorting is broken, same with Makefile.
>
> sorry. i don't get this. I2C_SIRF have be placed in "I2C system bus
> drivers (mostly embedded / system-on-chip)" submenu and placed betwee=
n
> "I2C_SH_MOBILE" and "I2C_SIMTEC".
> what is the problem?
>

Oh.... i was making some stupid mistake. i thought R is earlier than
M. in fact,  it is L->M->N->O->P->Q->R, so move I2C_SIRF behind
"I2C_SIMTEC".
-barry
