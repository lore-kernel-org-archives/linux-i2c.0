From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-davinci: Handle signals gracefully
Date: Sun, 9 Mar 2014 21:21:07 +0100
Message-ID: <20140309202107.GA2835@katana>
References: <1389265885-26777-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1295960731=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1389265885-26777-1-git-send-email-mike.looijmans-Oq418RWZeHk@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Cc: khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============1295960731==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 12:11:25PM +0100, Mike Looijmans wrote:
> When a signal is caught while the i2c-davinci bus driver is transferring,
> the drive just "abandons" the transfer and leaves the controller to fend
> for itself. The next I2C transaction will find the controller in an
> undefined state and often results in a stream of "initiating i2c bus reco=
very"
> messages until the controller arrives in a defined state. This behaviour
> also sends out "half" or possibly even mixed messages to I2C client
> devices which may put them in an undesired state as well.
>=20
> This patch fixes this issue by always attempting to finish the current
> transaction, and then check on a pending signal. It either reports
> success if all data has been transferred, or it returns failure when
> the transaction was aborted. This keeps the controller in a defined
> state, and is also much friendlier towards client devices, because
> it will only send complete messages.

Even more, you should complete the whole transfer. There are devices
where things can really go wrong if you send a half-complete command and
then start with the next one. So, not checking signals at all is the way
to go for I2C drivers. There is some cruft left, so I am happy about
patches fixing that, with testing on real HW. Like yours here.


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHM0zAAoJEBQN5MwUoCm2owMQAIwH+1ONRQ+4QYjubu020Agg
zzlbzOfBgKkIQ9KdsfBlZX9G5NJBKTAPZgGELllq5DfNbN9z332MPtddhGgW7Q+M
FJBw99w/b+b/zVODXMQzH5gjj0AojeIOJj3JV86lK8KnCf1Tl2K3iTyQNzw+3NTl
539dmZqfBwDq2lovR/MIdi09Q04nZez+N5oU7+tDhKyb/T6SSERtkFZdZQ/rnji4
BdYs7QTWKfCMnVpMlSzZWHPLTH2f2obqgZFlEkLalbXLhs6LnO1ytEivW1K8FqZ7
zYF7W8zuwDFPlqkV2wHdudcNPsm1bV6lFpZW4BXBpOjmGGZk5lwGpUa6eJiUOBhL
lx5ecjhQUmctJMj8OYBHUjk5yt5ZC2S/uqaUW/AMBllC69BzteKip2BUKXr08SHd
NuC/WQOQCB/0QSomviUf6mNm6+D/a+sL8SobUdbk1GU6VL7ApKZQqQanlZUOaKle
Dp+U78oHlTrEp1rj0dK0PM1QzM6nF10lRex06jetSGq31iMLvQp1x2vtFlDnt7fG
nasli1qrmdjyJD4gM8fgtdOSJIdmhGrTeJ8KNudpFs8rApFsuqTvoAa6xFQ1GKdM
iSMBXT2TBrBvf33mj+twqthc1xtadgAeu1BfCXgeIsctNqdZBUgEa2BJk7HaX+Pz
kvxZ7cQOdanuO8oBIJq2
=ux7p
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--===============1295960731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1295960731==--
