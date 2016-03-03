From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] drivers: i2c: Fix qup fifo handling
Date: Thu, 3 Mar 2016 22:14:18 +0100
Message-ID: <20160303211418.GA1501@katana>
References: <1456502334-8687-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456502334-8687-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: gpramod@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 09:28:54PM +0530, Sricharan R wrote:
> After the addition of V2 support, there was a regression observed
> when testing it on MSM8996. The reason is driver puts the controller
> in to RUN state and writes the data to be 'tx' ed in fifo. But controller
> has to be put in to 'PAUSE' state and data has to written to fifo. Then
> should be put in to 'RUN' state separately.
>=20
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Changed the subject to "i2c: qup: Fix fifo handling after adding V2
support". Please note the prefixes and the more detailed description.

Applied to for-next, thanks!


--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2KkqAAoJEBQN5MwUoCm2UIUQAKN1quQyZ0xnDaHPRmy+5mTZ
5mszacgOcIeKgmO+3g/42k9Q9mmd992sj6OCK3WWn1BUJYx4TlvFeaBnSVGbGKiA
pmUoymhLfFQgLxV3eLVYmk5vLc694w0hInkMG2qBRpBP3PlvAFfXFgCry1stnMFD
gz6oB2RU1MYp9SwfUKgiX8eQqMEltL2nTgGTsWifUn2SRfCXe1iT/B1zivyyK25E
CyPDfVtDZ6H8kpPOTD88Ey5+8Vst3/CQMXg8WozzsliX0facQZ452TvDdKqgkPo2
LzpLucicgPBfd5XauOD98CtycEvVpsIyGuR8erFyCY376fZL++1mQiDFUgBwZZvk
CZmNpWw8qkyj/Id6lz3oo5Bqx1KpmCis0EmfuO32kSWQyctbP/Du7b19PoZaQ5QW
kviHFqIHFZxUe7AIedoXNP4QbumuOyUYXCOamTzMueWFEb710UliiG4icft+UaBD
J2AVmBZQeTBlaXXz7WG7vSfZWQPN83XwehD29T593jmp7xjryghXUH2ASFO3+AW1
XhXCffzfS42TVeBefP++7b3YAaNMulC2B4WtvK2oPQxdQPyogq2/3LVPpmzBUrVG
YQcb7lQOIPnTfLMz0+t9MqghfLRMxjM47/wiEV+zYGtaL6D+oA0ElftHIZzQK33d
hVM5zpf1qqR7bXgH1x04
=JWQ3
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
