From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] arm64: tegra: add unit address to nodes under
 i2c-tunnel
Date: Thu, 13 Feb 2020 23:33:29 +0100
Message-ID: <20200213223329.7onm5k6elqhrn7ty@earth.universe>
References: <20200213214656.9801-1-dafna.hirschfeld@collabora.com>
 <20200213214656.9801-2-dafna.hirschfeld@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="isksol5hrgo6yufk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200213214656.9801-2-dafna.hirschfeld-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dafna Hirschfeld <dafna.hirschfeld-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, helen.koike-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, ezequiel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, dafna3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--isksol5hrgo6yufk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2020 at 10:46:56PM +0100, Dafna Hirschfeld wrote:
> add unit address to the nodes bq24735, smart-battery
>=20
> This fixes the warning:
> 'bq24735', 'smart-battery' do not match any of the
> regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---

While fixing the node names, it makes sense to also
use device class instead of name as mentioned in
Documentation/devicetree/bindings/writing-bindings.txt

>  arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/=
boot/dts/nvidia/tegra132-norrin.dts
> index a0385a386a3f..a19171f6f0f7 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
> @@ -767,7 +767,7 @@
> =20
>  				google,remote-bus =3D <0>;
> =20
> -				charger: bq24735 {
> +				charger: bq24735@9 {

charger: charger@9 {

>  					compatible =3D "ti,bq24735";
>  					reg =3D <0x9>;
>  					interrupt-parent =3D <&gpio>;
> @@ -778,7 +778,7 @@
>  							GPIO_ACTIVE_HIGH>;
>  				};
> =20
> -				battery: smart-battery {
> +				battery: smart-battery@b {

battery: battery@b {

>  					compatible =3D "sbs,sbs-battery";
>  					reg =3D <0xb>;
>  					battery-name =3D "battery";

-- Sebastian

--isksol5hrgo6yufk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5FzrYACgkQ2O7X88g7
+pofkhAAoMoK8pmU5IM+7SKEC/t6gCHl3ZFxdr779uaNe2+xXryagiKWvr9VRlG3
9Qwf9HcECBHc09tSQ5UMdCrxvPdWE3vCzAtar3K7KCAsKt0J0chJNkM2gXmXm2p/
YODX06XMl604eMwz9XAWbBfZS/tEcfdRPb2s3r+vfBFm5ANNfdgCqI0ieCGzbnJO
4RsIKDagTObQ3YdRgi7I4DLuCMuKyDXOapAESTOHxgm7ngb1UDENN9zg2ljCIqDX
NbwOUsApIBPqETfrQBK2qCEuLLcVQVEB45/aWX2+8VJLX7EMgUvf07OcGVhOiwF8
7ii38FQxRJwrECcPvcP0oKHAey6Mm9W4vf6iHQdXstZM/G0BCHMjYzuQeR285xO/
1EgeoZzPNl0+x2Cl+rTXc32x3D64Zbhn2IPf47VcxQfxAb5ZzJCi6syax3q/ot1l
TYDxc7IRsOCp5KlDJEG6BjZvjg+l4o9naKQ5sKwIDpz9vaFDi3vCgERU5i74FQbC
3dyD1ycsPCmK9fTkKCKOBlcPaiXNMJ8xVMM1z9SZMYXix/ewMLZ//nb5BF1Hn8hx
wilUATeajQI/WyI6/0E9Whw+zKDwQoLfUefa72lCEBdDMIV75ud+hcreoTZFTFN2
J7KM/jLltPiBmyelrzBNMLQaIq/cAI6c2LG/B1O7Io5xmmSJRy8=
=QPMO
-----END PGP SIGNATURE-----

--isksol5hrgo6yufk--
