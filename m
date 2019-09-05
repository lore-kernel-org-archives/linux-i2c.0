From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/1] i2c: qcom-geni: Provide an option to disable DMA
 processing
Date: Thu, 5 Sep 2019 15:49:41 +0200
Message-ID: <20190905134941.GG1157@kunai>
References: <20190905102247.27583-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190905102247.27583-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, bjorn.andersson@linaro.org, vkoul@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

I understand you are in a hurry, but please double check before
sending...

On Thu, Sep 05, 2019 at 11:22:47AM +0100, Lee Jones wrote:
> We have a production-level laptop (Lenovo Yoga C630) which is exhibiting
> a rather horrific bug.  When I2C HID devices are being scanned for at
> boot-time the QCom Geni based I2C (Serial Engine) attempts to use DMA.
> When it does, the laptop reboots and the user never sees the OS.
>=20
> The beautiful thing about this approach is that, *if* the Geni SE DMA
> ever starts working, we can remove the C code and any old properties
> left in older DTs just become NOOP.  Older kernels with newer DTs (less
> of a priority) *still* will not work - but they do not work now anyway.

=2E.. becasue this paragraph doesn't fit anymore. Needs to be reworded.

>=20
> Fixes: 8bc529b25354 ("soc: qcom: geni: Add support for ACPI")

As said in the other thread, I don't get it, but this is not a show
stopper for me.

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

I'd like Vinod to resend his review. Because IMO the change since v2 was
not trivial, so the old rev-by has to be dropped.

Other than that, the code looks good to me!

Regards,

   Wolfram


--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1xEnUACgkQFA3kzBSg
KbZADQ//bVc8JLCde99ZKqUN8Y09DkUCfN9nWo2ec5DwxFmDGC8HdJ6mtz50/MLV
jBJDWvml349aU4YwpmGf5ON51GWxey0iWmJ0Fo/km09XZp3JVHObxS+66M1y7p34
T60tKi6kct3QpVwT+jaqMimTvGDGY6W78cG/GCVErlFbthDEEeDfPzy1iuU0D/OW
j/rdRGz6Q8VlN2CvN6EPPn9njVwBQBIgsSAGeUULgGxb6dUs9oVp6CbRvPQMzwPV
7sPJzdV5bZ5YPWRaExFUiR6AfCkeDtJwK26jWKVVVLh2Xfc+FMSJ/pOQrQfzoGDA
Dv50xlVGa3oQV3zeyHzOIFhUZpjsTChbfzVNSt0GGzgYlc09U3ltyWZBR6iEyPfm
00x/oA1oyMjLpsaOq3xf5+AP7+PScfvB0910iujc+nPd2agCZRRDtl8hCmCiisBK
W2RB7RnLd3ZKf09bqU0xwkMNUXHSllk0bZK27lxdGFXIK8XCRjf9SJ6bQe1jvXWO
P5FG1/PuaQIjh8l7u2t15uFpzISvYvKAhypuSpV1Sbgc9fOfZSlbo20SrVkYAmd1
Y2JcfmTJBjlmRfpyXoVEzOGJclp1AlyrFQd955dzl/LAVBUdvDlHLaFkZ1molQF4
Ou0LwmX7yn69/N//1QKohUFuLjAkW+tJHd17zYtqMF/HAPcmZl0=
=pZZv
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
