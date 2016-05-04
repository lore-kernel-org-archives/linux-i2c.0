From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 16/24] i2c: allow adapter drivers to override the
 adapter locking
Date: Wed, 4 May 2016 14:07:28 +0200
Message-ID: <20160504120728.GA2120@tetsubishi>
References: <1461165484-2314-1-git-send-email-peda@axentia.se>
 <1461165484-2314-17-git-send-email-peda@axentia.se>
 <20160503213807.GA2018@tetsubishi>
 <0b4136b2-e555-9bc0-9003-898d686de7a1@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0b4136b2-e555-9bc0-9003-898d686de7a1@axentia.se>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Antti Palosaari <crope@iki.fi>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Jiri Slaby <jslaby@suse.com>, Daniel Baluta <daniel.baluta@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Adriana Reus <adriana.reus@intel.com>, Matt Ranostay <matt.ranostay@intel.com>, Krzysztof Kozlowski <k.kozlo>
List-Id: linux-i2c@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

thanks for the detailed explanation!

> So maybe there should be only one flag, e.g. I2C_LOCK_ROOT_ADAPTER?
> I.e. perhaps leave the future for later?

I think this makes the current code easier understandable at this point,
but I'll leave the decision to you. I am fine with both. Maybe a few
words of explanation would be good if you want to keep both flags.

> Hmmm, I just now realized that you were not really suggesting any
> changes other than to the commit message. Oh well, I can perhaps
> rephrase some of the above in the commit message if you think that
> we should not unnecessarily touch the code at this point...

Yes, updated commit description is enough for me now. If you want to
change to one flag, we should do it incrementally. I think I can apply
this as a fixup until around rc3 I'd say.

> > I think this kerneldoc should be moved to i2c_lock_adapter and/or
> > i2c_lock_bus() which are now in i2c.h. This is what users will use, not
> > this static, adapter-specific implementation. I think it is enough to
> > have a comment here explaining what is special in handling adapters.
>=20
> Yes, I was not really satisfied with having documentation on static
> functions. But if I move it, there is no natural home for the current
> i2c_trylock_adapter docs, and I'd hate killing documentation that
> still applies. Do you have a suggestion? Maybe keep that one doc at
> the static i2c_trylock_adapter for now and move it to ->trylock_bus
> when someone decides to write kerneldoc for struct i2c_adapter?

Well, because I think redundancy is acceptable when it comes to
documentation, how about keeping the chunks you already have and copy an
adapted one over to the functions in i2c.h?

Regards,

   Wolfram


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXKeX/AAoJEBQN5MwUoCm2NhUP+gJfYDPv13oeKO37qURjrb6m
SGtDXU6IBzsRuaSyeuyw3u1HF/r5MqkhpCnzHNbi2Y+zUNEVdUCAd2Fio4YSmaRg
A2ltXMJ0UYY8m7atTw783cFQrJjAwe5UKeeKyACnHtRWAsmMq+VOEEJ5pTwgi781
mCly/bHhOWdxdX4NiIulKpsi63B1EbUV4FfS316IWwXVaPdkZhHePABLk3AyS/vL
CpyUacaFKFj64KzzNbb/jxMGghaTi8UTMf4Gpwx3C8jvOn0YpOBciQmcVmmI78XB
BhNEPRxkpS7Eq+bNTr7bAKVv2vNEHryJksWndIZdbXhNEE/B5Fk8mMddr05BnVVq
0ilfFNrC67u19Q/+Eaol8nREbZd2QFs4wvpW7I/KcG6Wt8N6OSFAgN0W+7r3v46d
txQn6TnhIFdHTDm6uHZWES8/OlTqsYQprRHwrfQL7cJciqEgvPcu6j2YDtsAR474
FvWtkZ5aIQ9sxpybIdfrIc9qX+zfdrhw0FjdGr9rjgT7lmz8GlK+3EG1DfvWysSj
V2C57p01OZmsa9G+agbiCWksdsoQVSwXuhEGeyugPetTxM4tFgNL3WE854cKXfIf
KzaNqJjJ3JkWzGEIXvnkhkEoWAH6lrgS6fVlg6ZgnBUGQ4v9MIxMCL16F+9c0jDO
hzSohn+EASvNcWA11Oza
=FVh7
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
