From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v5 RESEND 4/5] Documentation: binding: add sclk
 adjustment properties to i2c-pxa
Date: Sun, 25 Oct 2015 09:37:48 +0100
Message-ID: <20151025083748.GC2159@katana>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-5-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440395978-9065-5-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2015 at 11:29:37AM +0530, Vaibhav Hiremath wrote:
> With addition of PXA910 family of devices, the TWSI module supports
> new feature which allows us to adjust SCLK. i2c-pxa driver takes input
> configuration in nsec and converts it to respective bit-fields,
>=20
>  - i2c-sclk-low-time-ns : SCLK low time (tlow)
>    This property is used along with mode selection.
>  - i2c-sclk-high-time-ns : SCLK high time (thigh)
>  - i2c-start-hold-time-ns : Used in case of high speed mode for start bit
>    hold/setup wait counter.
>  - i2c-stop-hold-time-ns : Used in case of high speed mode for stop bit
>    hold/setup wait counter.
>  - i2c-sda-hold-time-ns : Used to calculate hold/setup wait counter for
>    standard and fast mode.
>=20
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Ooookay, after checking some datasheets, I finally stumbled over the
fact that this driver is not using "clock-frequency" to determine the
bus speed. However, this is the standard way of defining that in DT, so
this driver should adhere to that, too, and not invent something new.
Previously, I was under the impression that the above parameters were
needed for fine-tuning and couldn't fully grasp why. But this is for
defining the bus speed which is a no-go.

It looks to me that older PXA only have a bit to select between 100 and
400kHz while this newer one can have arbitrary frequencies. Correct?

So, what the driver should do:

- Keep support for the old "mrvl,i2c-fast-mode" binding which should be
  marked as deprecated

- get the value of the standard property "clock-frequency"

- for old PXAs, complain if not 100 or 400kHz, otherwise set the bit
  accordingly

- for new PXAs, calculate the ilcr and iwcr values from
  "clock-frequency"

Makes sense?

Regards,

   Wolfram


--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLJTcAAoJEBQN5MwUoCm2bKQQAI86+iqOqYdyg9wvn5p5j3AS
qm4C78K+60FlPbuJ08IqNwUasWNgOzuMbFczu7pJACkIYCj5ZQvlTh+WUWYXIQ68
vQGs7x4A4Hjvd5C4DTvOWuroa/Kx/unBbaDTLdOpiaFeA1KXTD/TIlTlwfoLFWgL
2mFf8hSdv3dU3a9XXTcMXQbc6EEX1gxO36AT8H1f5UrfKpcQzYCE3pUXEvPjQBdp
g7WumB5LwtmPL22/d7Y8Yofk5v6QrAHjQY57ElYx45xZhHAlu9rbuEuOX7Qccbhb
EleZDa+Un6Wgd6qTaEW004FdCVn/XRyNXYYWvExavWSwmOE9ZmYBA8coDMBXxRmg
8aDs1kVhvWi340+SB/8JCJXJTQ9vadakbtf7Z/nhPceHdRQhXxx/r198Z6fZFxZI
mfUhn/Fm7eM7FT/n/a8bzq6gBQxkChbGX5zzBIBUX4pzpHhj0HFo+1nD8ukocJY9
Fa5PMMnfVmU/eSwefk5A+9hd3duZyeInvHk8ShGdVzd36Tehdqd+fgjiNmbo3ilv
kIH+zPEbrpEQG1Ihiu/si+/ZnCPtZ4GAc16eYI1K/Sfcw15dLCZsuXU4CG9yubcx
uO0eqR6mlHu5zD4xpDMiPU8qvuIhZWuZqqk6c618zCGDZPUrsnadlKS8psFAUysP
DQCFwFBIXD8hdSWR6SzV
=/J2e
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
