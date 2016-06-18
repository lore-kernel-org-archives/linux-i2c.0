From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V4 2/3] i2c: qup: Fix wrong value of index variable
Date: Sat, 18 Jun 2016 18:26:18 +0200
Message-ID: <20160618162618.GE3017@tetsubishi>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
 <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
 <20160618162138.GC3017@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160618162138.GC3017@tetsubishi>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org, absahu@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 18, 2016 at 06:21:39PM +0200, Wolfram Sang wrote:
> On Fri, Jun 10, 2016 at 11:38:20PM +0530, Sricharan R wrote:
> > index gets incremented during check to determine if the
> > messages can be transferred with dma. But not reset after
> > that, resulting in wrong start value in subsequent loop,
> > causing failure. Fix it.
> >=20
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>=20
> Applied to for-next, thanks!

Reconsidered and applied to for-current.



--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZXYqAAoJEBQN5MwUoCm2pDsP/1nA7BArWYmQzj35z/KFlUNu
mz30/ld5+sNr6CYsqSOVc2pKVy9k6bk8BBJ2SlwPO1LVX2apWMkVxBUigOqLiBDT
gm6d+R86TC+MnI6TQvvXUs4XOqWcIXnd5nwWNevjUfZ85dhW8Gyif3WLbUAxbl3t
DLFd7NnS7CvCIq8MkyJIY9iGoyit+kgQ8UE1+PzfPLmoPtceiylHQPVH51aEuMCO
jFM5nQRdREPc2L3IIHT/RG9ve/o+P4F5b2q5//0auAbK5h103QIcSiD9tr1VmUCJ
DSN+ZpJBCi6Asir2kOwziPueUE/8iDro43KZ8DsOYiiNUOtGLIH+KPdsGcT55GGo
K9eLF+oYCGsbWaaN1nreycwpGudMlQ9ZS3M9q12I5iNFc2Z29bpaVaDVdxvJNMDK
+LsjEb08kdhW8nZ2LHLRkh5w0KhtKUf4255PyUHkGqWiFzxDTis7LwX4V6T+PNze
MAsBBHS9NBcbzIpI+cz4j4RQYW86AqYy7nG9lWwnS1y64xGSQtw0qwEPrUYXOpaT
dB4K8gW38SQYTNX/G519kM/ncUrAlYdx1aUJrsPivtFH58zg0+fbuhox62nwb/vU
q/K3G6cUZCkp/01V2u2+bzFphoGvOfNxefMAyhDCo3YhX6ZtYS+m295xvSbfNy1K
kc9Ma9j2zKiM9tTpT5SW
=AlLo
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
