From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/1] add missing UARTs pins and I2C
 entriesfor AllWinner H3 DTSI
Date: Mon, 2 May 2016 08:46:45 +0200
Message-ID: <20160502064645.GK17159@lukather>
References: <CAKQ8BtjPhfJC+njOUvo-4ZQ+Oj==LqQEhJ1LQROjY85hswE9Mg@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBYHPTO4QKGQEYEYPUUY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAKQ8BtjPhfJC+njOUvo-4ZQ+Oj==LqQEhJ1LQROjY85hswE9Mg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Martin Ayotte <martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans De Goede <jwrdegoede-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jens Kuske <jenskuske-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Jean-Fran=E7ois?= Moine <moinejf-GANU6spQydw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 19, 2016 at 03:50:39PM -0400, Martin Ayotte wrote:
> Hi everyone,
>=20
> This patch is submit to provide endusers access to additional UARTs on
> AllWinner H3 SoC along with I2C ports.

Unfortunately, your patch cannot be applied in its current form, both
because of process and technical reasons:

  * Every commits should have a commit title and log. While you do
    have a title, you used the log to store your cover letter. This is
    an issue, because that will be kept in the git history, which is
    obviously something we don't want.
    If you want to make a cover letter, you can either send it as a
    separate mail, or after the "---" below that will be ignored when
    applying the mails.
    On the other hand, the commit log should be used to say why =C3=BDour
    doing this patch and why it was needed.

  * You do not have a Signed-off-by tag in your commit log. This and
    the point above is documented in Documentation/SubmittingPatches,
    please make sure to read that first.

  * Your mailer completely corrupted the patch when you sent it,
    replacing all tabs by spaces, and wrapping the longer lines. That
    means that the patch cannot be applied anymore. Please fix your
    mailer, or use one that just works, like git send-email.

  * Finally, like Chen-Yu already told you, you're doing several
    different things here in a single patch, while you should have
    done separate patches. From what I can see, you're adding pinctrl
    groups for the uart and i2c pins, and adding the i2c controller
    nodes. That should have been ideally 3 patches: 1 for the uart
    pinctrl groups, 1 for the i2c pinctrl groups, 1 for the i2c
    controller nodes. We also don't take pinctrl groups that are not
    enabled on any boards to keep the DT size as small as possible.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXJvfVAAoJEBx+YmzsjxAg54AP/j4AaHpB8U/Y3B5D2Chf1Jmh
AgTpgoDYHkB2JOzoajDw5Aqn+CZZ/P13LLEL/nMOJcyHRyYzwm13LbYngC3LB8vh
VBspZqqFcB2KMy//CxFbguzkNtiyQH6ZGPhB+ckx5CaMawCYNDvX1mLDPI2OMbsf
u61acF3a1C619NvlUJKfJr8yb1Om0JUe1LseyVAPCKWWg7mDGfPuwTthtcZFrg5i
8gL7pAEeMzqpPzMqGmfcoyEd9D7MK3eMnYGfEcLpgrtcDRwKGLmRbPTQ29a03hCk
qd516/xdJSWpBnVD99Lq306hF22CFTYcy0m+ij5MT1odpj6uNKV0D7P6CmNKbieh
hW2Ou8eFnVE8hUlnU+dHLYKKK5Q/c8pv8Z3HI1MewIWVEQqJFPiC75hL02fhpqU8
WEWnZoZXIoYe+5uiFpZmjsHio+Ezk5Dds0r0J/Ooz6pPRiLxibakPDjaxej4H9O/
x+jmVf85Ar2a0fMaIk8vxUyiv+JzBy0GPT1oV5XrxyhXcp7jnhqRT82RRZUVbnWL
JqLEpJTUXxLYEIl5dHwSVro+/RQaFne6xDN/wKjri3Fec6/gTJEkge1ZZ9DxaAUE
2Fs3AeXfdLkkTAxmhWJ5atwQeUaKcOvm2ee3S75iWoLNHalp/ZAUUSSYfeQTJnq5
oQil2dgBvf35kkNmfRhp
=42fP
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--
