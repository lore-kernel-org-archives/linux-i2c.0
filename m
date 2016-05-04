From: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH v2 1/1] add missing UARTs pins and I2C
 entriesfor AllWinner H3 DTSI
Date: Wed, 4 May 2016 11:15:55 -0700 (PDT)
Message-ID: <c17544c6-2b49-44cc-b2f9-537d94f276ef@googlegroups.com>
References: <CAKQ8BtjPhfJC+njOUvo-4ZQ+Oj==LqQEhJ1LQROjY85hswE9Mg@mail.gmail.com>
 <20160502064645.GK17159@lukather>
Reply-To: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_875_1838026450.1462385755952"
Return-path: <linux-sunxi+bncBDW4XUV4YULRBXHYVC4QKGQEN65KYUA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160502064645.GK17159@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jwrdegoede-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, jenskuske-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

------=_Part_875_1838026450.1462385755952
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Bonjour Maxime,

On Monday, May 2, 2016 at 2:46:57 AM UTC-4, Maxime Ripard wrote:
> Hi,
>=20
> On Tue, Apr 19, 2016 at 03:50:39PM -0400, Martin Ayotte wrote:
> > Hi everyone,
> >=20
> > This patch is submit to provide endusers access to additional UARTs on
> > AllWinner H3 SoC along with I2C ports.
>=20
> Unfortunately, your patch cannot be applied in its current form, both
> because of process and technical reasons:
>=20
>   * Every commits should have a commit title and log. While you do
>     have a title, you used the log to store your cover letter. This is
>     an issue, because that will be kept in the git history, which is
>     obviously something we don't want.
>     If you want to make a cover letter, you can either send it as a
>     separate mail, or after the "---" below that will be ignored when
>     applying the mails.
>     On the other hand, the commit log should be used to say why =C3=BDour
>     doing this patch and why it was needed.
>=20
>   * You do not have a Signed-off-by tag in your commit log. This and
>     the point above is documented in Documentation/SubmittingPatches,
>     please make sure to read that first.
>=20
>   * Your mailer completely corrupted the patch when you sent it,
>     replacing all tabs by spaces, and wrapping the longer lines. That
>     means that the patch cannot be applied anymore. Please fix your
>     mailer, or use one that just works, like git send-email.
>=20
>   * Finally, like Chen-Yu already told you, you're doing several
>     different things here in a single patch, while you should have
>     done separate patches. From what I can see, you're adding pinctrl
>     groups for the uart and i2c pins, and adding the i2c controller
>     nodes. That should have been ideally 3 patches: 1 for the uart
>     pinctrl groups, 1 for the i2c pinctrl groups, 1 for the i2c
>     controller nodes. We also don't take pinctrl groups that are not
>     enabled on any boards to keep the DT size as small as possible.
>=20
> Thanks,
> Maxime
>=20
> --=20
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

Thanks for your help and make me understanding more the process.

I've now prepared a new v3 for that, and just send it.
Strangely, it seems that the 3 patches been sent separately.=20
I will try to figure out what happened.

Regards,
Martin.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_875_1838026450.1462385755952--
