From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V4 2/3] i2c: qup: Fix wrong value of index variable
Date: Sat, 18 Jun 2016 18:21:39 +0200
Message-ID: <20160618162138.GC3017@tetsubishi>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
 <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54347 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbcFRQVn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 18 Jun 2016 12:21:43 -0400
Content-Disposition: inline
In-Reply-To: <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org, absahu@codeaurora.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2016 at 11:38:20PM +0530, Sricharan R wrote:
> index gets incremented during check to determine if the
> messages can be transferred with dma. But not reset after
> that, resulting in wrong start value in subsequent loop,
> causing failure. Fix it.
>=20
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Applied to for-next, thanks!


--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZXUSAAoJEBQN5MwUoCm2NXUP/AkKEzUCZFmVuhwXbtQAIVjx
7ZSoeMSuReV6diqP/49qPhipJdTUpztQn5/PeVOnAl8fBZXWPRIm88kmeK8QZ9oc
4ufCWyQ2dJbRZYXWlHEkYGvRdQBf/rnxITdp3YOBGFoHH1CvQ7J7KtijSIVscU5o
2UUO1wS8xcn3cQFV9PzdKwQXAzv6cRhnOE4Z4sEe6JRExbA0Td3qACvacpGGVFw1
JoKIB16a/roe6BAsj3JPN/NEILcyM3NVasBBfy/BqsLIhumZXCl5FzzjZ+bRp/eg
yDi5HeF4SQu16X+vinmiqvF9wtkdffyLUM4oIWsq/V9fJR4GB3julgPhi4G4nZhd
rAUu6j++XGeC6SI1wST9y0OW4v292gv4wogy/1tGhn41qvQpkRNOMPCEMvje6GGH
aLJbKTqsxnWcQMn3pdRC3SB08P0ojvoLvOCxb90cMUqhsNNY2us2a0vBqDaAgXbw
U+0nYx1hVwGdEi0cZ3Ddsb4yvyYHVhKYPKegHe3giUeIpF/tKlI6rzjW0OwtgYhq
UzIPrKms0qdLqRddAoABn4mevsKQKWFxTu2f3tgl9vlppDF1l/oM6EKENg0FjYu2
DOCQad3nsrtQR5/bcKz6IF/rBGh3smNi0sYq7L78jlCKUCWux6oXF8OOdNIKe3X8
bg82KNp/mJ8Vjvtj690h
=ttcL
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
