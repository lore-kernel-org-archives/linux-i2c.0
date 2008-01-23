From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
Date: Wed, 23 Jan 2008 14:11:21 +1100
Message-ID: <20080123141121.02c69526.sfr@canb.auug.org.au>
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123020914.31675.35659.stgit@terra.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1198286633=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080123020914.31675.35659.stgit@terra.home>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

--===============1198286633==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__23_Jan_2008_14_11_21_+1100_h4GJT6VfBaCy5jA9"

--Signature=_Wed__23_Jan_2008_14_11_21_+1100_h4GJT6VfBaCy5jA9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jan 2008 21:09:14 -0500 Jon Smirl <jonsmirl@gmail.com> wrote:
>
> +static struct of_device_id mpc_i2c_of_match[] =3D {

(sfr winds up his broken record :-))  const, please.

> +#else
> +
>  static int fsl_i2c_probe(struct platform_device *pdev)

While this code is still here, you should still explicitly include
<linux/platform.h>

> -      fail_add:
> +fail_add:

If you are going to move labels, many people leave a single space in
front of them so that "diff -p" picks up the function name instead of the
label name.

> +void of_register_i2c_devices(struct i2c_adapter *adap, struct device_nod=
e *adap_node)

> +		compatible =3D of_get_property(node, "compatible", &len);

You can specify NULL instead of &len since you don't use the returned value.

> +		if (!compatible) {
> +			printk(KERN_ERR "i2c-mpc.c: invalid entry, missing compatible attribu=
te\n");

Some of these printk lines are a bit long.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jan_2008_14_11_21_+1100_h4GJT6VfBaCy5jA9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlrBdTgG2atn1QN8RAgluAJ0dgJHkgENGQtD+Udhh/xm3a+r18QCgjc4n
jCTKu89FeANYXB07ChDVUKU=
=6TQZ
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jan_2008_14_11_21_+1100_h4GJT6VfBaCy5jA9--

--===============1198286633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============1198286633==--
