From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v1 1/1] add missing UARTs pins for AllWinner
 H3 DTS + add new I2C entries for AllWinner H3 DTS
Date: Tue, 19 Apr 2016 23:11:11 +0800
Message-ID: <CAGb2v65dsjbpGUrJXFG35cLGnFA6uDxtgMqupBN97=8XNnO68Q@mail.gmail.com>
References: <8673D89D449742EAB9F6EBD05655A295@GirolesWin7> <CAGb2v67e_F1=VaY7ovzW7Whc2ToJU3YabeT-orrLTb0Pouhw_Q@mail.gmail.com>
 <21e74cd8-2ec7-4fd3-aa5c-ba4eed29a6ab@googlegroups.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBJ4V3G4AKGQEFDZ7OQY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <21e74cd8-2ec7-4fd3-aa5c-ba4eed29a6ab-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Martin Ayotte <martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans De Goede <jwrdegoede-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jens Kuske <jenskuske-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Jean=2DFran=C3=A7ois_Moine?= <moinejf-GANU6spQydw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 19, 2016 at 10:46 PM,  <martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi ChenYu,
>
> Thanks for your comments.
>
> On Tuesday, April 19, 2016 at 7:11:50 AM UTC-4, Chen-Yu Tsai wrote:
>> Hi,
>>
>> >  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts  | 36 ++++++++++++++
>> >  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 36 ++++++++++++++
>> >  arch/arm/boot/dts/sun8i-h3.dtsi            | 75
>>
>> First of all, you are touching 3 different files here. These should
>> be separate patches.
>
> I'm trying to understand you here, but I can't. Those 3 files changed are=
 related each other. I could have separated the UART changes from I2C chang=
es, but still those 3 files would have been modified at the same time for a=
 single commit and "git patch-format" would still have created a single pat=
ch for the 3 files commit.

Try to wrap lines to 80 characters or less.

1 change per patch. You are making 3 changes here. a) adding shared
pinmux settings,
b & c) enabling uarts and i2c busses for 2 boards.

You could split them into 1 dtsi patch adding the pinmux setting, and
then 1 for each
board enabling the peripherals.

>
> Seeing all the patches that coming into the mailing lists, all of them co=
ntains multiple files patches, why should it be different here ?
>
>>
>> Secondly, our policy is to not have a default function for generic GPIO =
pins.
>>
>
> If this is the official policy, then why so many DTS currently present ar=
e not following the same rules, such sun6i-a31-hummingbird, sun7i-a20-olinu=
xino-micro, sun7i-a20-mk808c, sun7i-a20-cubietruck and so many others ?

Perhaps they were enabled before the policy was enacted, or it just
slipped through. I
contributed to a few. But for many boards we might not have schematics
or the actual
device to check.

Also, other boards having such settings is not a good argument.

> I thought the rules were there to make DTS the most default common usage =
definitions for most end-users in a general availability.
> Then, if someone is really in shortage of GPIOs, they could easily turn t=
hem back to "disabled" state.

How would you determine what the most common usage is for "development boar=
ds"?
If the vendor explicitly designed the pins to be used one way, and even pri=
nted
the description on the board, then you may have a valid argument. But even =
then,
with the C.H.I.P., they are going with DT overlays.

It shouldn't be hard for an end user to modify the DT. And with I2C devices=
, it
is almost a requirement.


Regards
ChenYu

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
