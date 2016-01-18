From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v3] i2c: imx: make bus recovery through pinctrl optional
Date: Mon, 18 Jan 2016 16:22:51 +0800
Message-ID: <CADRPPNR2YDj43XjJUQszEUkKDj256L6p=N2QYteFG8uAfBYdMw@mail.gmail.com>
References: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
	<20160115075356.GI24441@pengutronix.de>
	<CADRPPNT=+amxRcea=N7m96=wKgdbRmU8R5cBACvTn7XffKofzQ@mail.gmail.com>
	<20160115090343.GK24441@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160115090343.GK24441@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Gao Pan <pandy.gao@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>, linux-gpio@vger.kernel.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 15, 2016 at 5:03 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Li,
>
> On Fri, Jan 15, 2016 at 04:46:06PM +0800, Li Yang wrote:
>> On Fri, Jan 15, 2016 at 3:53 PM, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> >> -     i2c_imx_init_recovery_info(i2c_imx, pdev);
>> >> +     if (IS_ERR_OR_NULL(i2c_imx->pinctrl))
>> >
>> > I'd prefer to set i2c_imx->pinctrl to NULL if it's not used and th=
en use
>> >
>> >         if (!i2c_imx->pinctrl)
>> >
>> > here. (Or maybe make i2c_imx_init_recovery_info aware of this situ=
ation
>> > to keep the caller simple?)
>>
>> Setting not used pointer to NULL might be a good coding practice
>> generally.  But in this case neither the driver nor gpio framework
>> checks if the pinctrl is NULL before accessing it.  We still need th=
e
>> driver to make sure pinctrl is not used in this situation.  The
>> benefit of the proposed change seems to be pretty limited.  :)
>
> At least it gets rid of IS_ERR_OR_NULL which is used wrongly more oft=
en
> than not.

It's true that this API is not used a lot.  Are you suggesting that it
is poorly designed and probably should be removed?  But I still don't
quite get the point why it tends to be wrongly used.  Do you consider
the use in this patch a wrongly used case?

Regards,
Leo
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
