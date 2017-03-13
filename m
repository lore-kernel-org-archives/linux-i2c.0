From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [i2c-tools PATCH v2] i2ctransfer: add new tool
Date: Mon, 13 Mar 2017 13:28:59 +0100
Message-ID: <20170313122859.GA1439@katana>
References: <20170306142931.10457-1-wsa@the-dreams.de>
 <20170306195038.6d6a5y5luyuuy7jv@pengutronix.de>
 <20170313110140.GA2476@tetsubishi>
 <20170313120725.43uy64azuixdt5qz@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170313120725.43uy64azuixdt5qz@pengutronix.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.de>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
List-Id: linux-i2c@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > +.RI [ data ]
> > > > +.RI [ desc
> > > > +.RI [ data ]]
> > >=20
> > > You could join the previous two lines.
> >=20
> > Try it. You will miss some spaces, then.
>=20
> It works fine with quoting:
>=20
> 	.RI [ "desc " [ data "]] ..."
>=20
> . But ok, it's at least arguable if this is better than your solution.

I prefer my solution ;)

> > I wonder: will another I2C master start a transfer on a repeated start?
> > Need to investigate.
>=20
> I'd say it must not. It should have logic to detect bus busy and delay
> any transfers until the bus becomes idle. With a repeated start the bus
> doesn't become idle between two transfers.

I totally agree. However, I think I'll try to stress-test a little when
I use my scope next time. Just to have some real world experiences...

> ah, ok. BTW, I like tools that clean up after themselves. This way
> debugging is much easier if you look for lost memory. And yes, this
> doesn't matter much for short-living programs like i2c-tools, but I like
> being consistent here and also do the cleanup for this this type of
> program.

I see this point. And I see that the program became quite more complex
which makes future modifications more error prone. Your exit path
consolidation suggestion was a good example for that. But anayway, the
cleanup is there now, hope you'll all be happy :)


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYxpCLAAoJEBQN5MwUoCm2zDsP/jz6iPTgvh8xzFxtyUNXHpys
tx89CwEmXe6krVJoCNSLc60YdHlcuWvAZfq2j/gxuWAZWR4jmAn7btNHjBmmKUR6
fSeDfayY9bz8yzvTtEnByA3V5laztoudf2rgw4D9q3uC0eNywCNsaj/0JYR+R4P1
Oo6I2p9T1cHvoGpYOalmi34RNIlIRvytUbhi5oDqF2aDlbW9stibfPfYbOklP/Vq
P2u7DxD9pdW+Jsj3OzsfZcBVq7WJFTTHXAqW8PlJMiJdANZ1clZrl38NfqnHGWpS
gAwk3CzJ7m9Z2vdb50lfazPmlqIG5tO8MdnH6zj+vlP61dhPdCIeDa+8+43Mo4jS
XKeaOjXEtrLCh8GXHfOzcmoKWxiP7KmF2cUQZ4ZRTD6NZVpZF4YBa3XSnvFICmbG
+j5cJ/kkkmCZ11GohTZavVZ7070KqpWENDPjFyvUMb4i9XM+kIywygZb+XzoIQmN
uF/qM4lgdZPamRX3qSqacocM0Nv67r10A92nijccD7QldJoTfCgk5S5jWB/xVJWb
ExlG7owa/BDfAhwjL+uPOoPUOGi65EfL2h94sqcbWW1C+r0Is6BkOFqFbViQMUfn
mQ0JsJEpSHvuf3EcToX9pQyJe0oX5xAFuY9lsu9JKNQoDe01ZfZgI/a4RlmdPx2Q
gK2Pe51vAhDOowZEaRvL
=DGkY
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
