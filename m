From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/4] i2c: octeon: thunderx: Limit register access retries
Date: Tue, 13 Dec 2016 21:32:51 +0100
Message-ID: <20161213203251.GA2889@katana>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-4-jglauber@cavium.com>
 <20161211220148.GG2552@katana>
 <20161212160711.GA2766@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20161212160711.GA2766@hardcore>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
List-Id: linux-i2c@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >=20
> > I can't apply this one?
> >=20
>=20
> Strange. Applies for me on top of 4.9 and also next-20161212.
> I can also apply if back from the mail. Is the mail messed up on your
> side?

My fault, sorry for the noise. My branch missed the latest revert for
4.9. I'll apply this patch for a second pull request during the merge
window.


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYUFrzAAoJEBQN5MwUoCm2TCwQAKPdTWSxHF/Xbt833qvazNvg
TkDIzaX+cCEhhfzhuJg+jbE5QvUknWqJWr/Z6i9fwqHHlh5xBYx1F2x4dYFsY+N8
CU+GM449tnS3zRA48gEqpHK45DVNlqb3TdeIjar7kzIc0gO1DTALgy7yRFyaePfY
xdQOTN/m+G/HvJJzXpWnnRGv7yJi4sM//CfIu17u56yJFw2hrJOxpfFDvjIvg8F/
sycFnPmP/Jq9tPXClBKiY1FlhdH6w04scocR8B9pXy66ew+WCamBe+Z97ZCHSpmm
ky8PIXXyfgu40Ut9yeTDp9yn4EEsYKg8m7aMGNgWNhaw6+ByUr0ycVuwjcx+sgOM
ELPXRYdLZoDrFdVge2gUkWDdUz1FtpJVByqBDTwaUdazS1y8T8b/fSo0puSOtOFF
HLLErq91E5w/mW0MGd14RW2EX2jdpDqqOpPhHojQT1pX/Y80vpdM3FMvY1+g3LUv
Zb4zne7fsabJpIB9nhe6Giy3NDSVTbr9J208w2rLBkNrB7CE2ZITJHl/il2o4R6V
J6aR/hf312K5hQqe51nvf/HwAnKoOOBp954EMoZ7gXqTVuJ4THRXlvrGipGrBGXH
x0Uws/UGOoRXoR09SZZ97AJahOAb/M3KUdPvtkEUQTyGWp7mCwBIfEI15uwg4jsv
76OmG6/MJdOtAVUMb1Ag
=Knrx
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
