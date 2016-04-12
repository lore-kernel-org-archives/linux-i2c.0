From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: mediatek: i2c multi transfer optimization
Date: Tue, 12 Apr 2016 23:13:56 +0200
Message-ID: <20160412211355.GA1526@katana>
References: <1457375031-3769-1-git-send-email-liguo.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457375031-3769-1-git-send-email-liguo.zhang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liguo Zhang <liguo.zhang@mediatek.com>
Cc: srv_heupstream@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for the submission!

On Tue, Mar 08, 2016 at 02:23:51AM +0800, Liguo Zhang wrote:
> Signal complete() in the i2c irq handler after one transfer done,
> and then wait_for_completion_timeout() will return, this procedure
> may cost much time, so only signal complete() when the entire
> transaction has been completed, it will reduce the entire transaction
> time.
>=20
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>

I wonder. You have less context switches, yes. On the other hand, you
likely have bigger interrupt latency because you do more stuff in the
interrupt handler. Is it really a gain in the end?

Regards,

   Wolfram


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDWUTAAoJEBQN5MwUoCm2WqEP/iYiA940CEMWOPhx/RgpbdHq
+PoAO7geqKgb/u6b/HAtVdyXFpsnC3db3C6PFWg84q8gesh3HrmfarekIXcKQiGo
/VHwXhSTbxu4KE4T4XlSzOlokb7Er7cJmg+P5Jv99CjpTAZGo00UfsxkUArca+5s
J2fDV5/T1Q1hg8UFxdYTAukm7gB+lDyL8jBnDl9qCz4wWn5lfR0B1FBp8tyzjOIE
CoWxx3B6FBAZh8pQYTHtWGf0TW1lIvG/bqu24upfV0Yf8m9UIFr2W1Op2v/Y5GC2
JVnqJXZ7GtCbZTSMK5cU3yEHiRQE+dbPy017j3N4Ul6NUMYMv5aontfAt/Af1Nhx
ruY8tDuk/izDN+zN4nTSCT4B6r/jMLpkCBoMHuKpXL6CsbJbiT+huYDubuxzAuH3
YoJP/Nhoz98JFtYuBTk6L1l8UFK3w0V8paIwrSii92SdMvnntPaTUkBqMmtkn11a
40Lq+OYLGGT5XDuPp91KFrRFhO5PLPSgZwt0KCjLVC3HN6dcnd7rQbRbP50yanZB
EB8vPOwjKHjLaMBtjwSM85Gzv7PVjfw3YLEwSD0yg6bNjHE5f0wz74le/Y4tKYW5
zSXIlnCyv3+DoWMNr6sQu/aiHnlm5chUT5EcgJFXSYpm/Eb5QN6Dh8XqHXf8DrQ/
ZQTnCbTXdgklOqhSVrlg
=83yL
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
