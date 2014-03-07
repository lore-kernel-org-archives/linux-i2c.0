From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 1/5] i2c: mv64xxx: Add reset deassert call
Date: Fri, 7 Mar 2014 11:37:30 +0100
Message-ID: <20140307103730.GA12274@katana>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140307095222.GG21483@n2100.arm.linux.org.uk>
 <20140307100751.GN607@lukather>
 <20140307103433.GH21483@n2100.arm.linux.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-sunxi+bncBDP47C6LHEIPJQXGTACRUBBKJFOAC-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140307103433.GH21483-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Since RESET_CONTROLLER is not required for those platforms, it really
> should be optional - and I think the real fix is for the reset controller
> support to provide stub functions.

I agree; and I assumed it already does. Will resend a patch posted
earlier [1] to fix the issue. And still debugging why my build-tests
didn't get it :(

[1] https://lkml.org/lkml/2013/8/9/442


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTGaFqAAoJEBQN5MwUoCm2aiIQALNJ3UVkUhX6WpZdiVuGk4lk
jW68GiRe++yFRidhVjRKvchJ/0D/8IPE7ZNIsEOeBkJDq4/AxWEGlZOL0bUn5Ou2
n3TP6tMn1RJi14mayKtaSk33Kqr6gMr+7PUcB6x8pEYoTs0WucnYWPgSCNehX+Hn
ducnOKa1m9iQ+d4KIkWF22pTfkPrJzZXfP7jc3XZcQ0xF+s9QIM+V1y1JJKN1mC8
erCcwBpb8H0SX6nN7tTLlFyYG8cnFLiHR/92Jfz+y5h23E73sDzLzmZwmg/yQXCj
s6BfBrWB4/xgv/4A6FLGlUKm05CmZnNguFzC2iW4NiqoJsL02VAr0MP8pgqaoFPa
xq2uUpw1fSVorjPR4X6rXOpbmOwHWjSUhfJP0bzYQeFJwKWM+dYGLIDY0l29G6Cc
1EXYi+U9Wf/hD4YQWczq/gKsjc2V79F3B0b/+XR22XhogzEkOvP4JUyunhswrbdg
TJbDWkUwxX0rIhdT5PAg8eKjrsAROX+LGV4PA6m9sL//xZJrb1FarlYR91n/2ST4
4FTU6MfZxQH+B8X4yEYMybNLXSUWC1fhKIFC7KocEhfoBY8m0dC4VXSM4z7nkbgf
GwsJQki5bleYP8tksIj9ETFrxXdFJZ5UBOD0u+bB91M5TiPOcmgXdEIn/S2IQJAg
NhXsyCRz0fhiG5twDYz9
=VYea
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
