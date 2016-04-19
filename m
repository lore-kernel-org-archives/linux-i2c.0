From: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH v1 1/1] add missing UARTs pins for AllWinner
 H3 DTS + add new I2C entries for AllWinner H3 DTS
Date: Tue, 19 Apr 2016 07:46:08 -0700 (PDT)
Message-ID: <21e74cd8-2ec7-4fd3-aa5c-ba4eed29a6ab@googlegroups.com>
References: <8673D89D449742EAB9F6EBD05655A295@GirolesWin7>
 <CAGb2v67e_F1=VaY7ovzW7Whc2ToJU3YabeT-orrLTb0Pouhw_Q@mail.gmail.com>
Reply-To: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10802_869606498.1461077168916"
Return-path: <linux-sunxi+bncBDW4XUV4YULRBMMJ3G4AKGQEIJZSE2A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v67e_F1=VaY7ovzW7Whc2ToJU3YabeT-orrLTb0Pouhw_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jwrdegoede-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, jenskuske-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

------=_Part_10802_869606498.1461077168916
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi ChenYu,

Thanks for your comments.

On Tuesday, April 19, 2016 at 7:11:50 AM UTC-4, Chen-Yu Tsai wrote:
> Hi,
>=20
> >  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts  | 36 ++++++++++++++
> >  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 36 ++++++++++++++
> >  arch/arm/boot/dts/sun8i-h3.dtsi            | 75
>=20
> First of all, you are touching 3 different files here. These should
> be separate patches.

I'm trying to understand you here, but I can't. Those 3 files changed are r=
elated each other. I could have separated the UART changes from I2C changes=
, but still those 3 files would have been modified at the same time for a s=
ingle commit and "git patch-format" would still have created a single patch=
 for the 3 files commit.=20

Seeing all the patches that coming into the mailing lists, all of them cont=
ains multiple files patches, why should it be different here ?

>=20
> Secondly, our policy is to not have a default function for generic GPIO p=
ins.
>=20

If this is the official policy, then why so many DTS currently present are =
not following the same rules, such sun6i-a31-hummingbird, sun7i-a20-olinuxi=
no-micro, sun7i-a20-mk808c, sun7i-a20-cubietruck and so many others ?

I thought the rules were there to make DTS the most default common usage de=
finitions for most end-users in a general availability.=20
Then, if someone is really in shortage of GPIOs, they could easily turn the=
m back to "disabled" state.

Regards,
Martin.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_10802_869606498.1461077168916--
