From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: Prevent race condition when removing i2c
 devices
Date: Mon, 31 Jul 2017 15:38:14 +0200
Message-ID: <20170731133814.b5lyujdl5iwhcalx@ninjato>
References: <20170608024344.9311-1-david.thomson@alliedtelesis.co.nz>
 <20170619143656.zigxk77vegedscjx@ninjato>
 <24ee1e30-1737-e3ef-a23e-01d41a29d45f@axentia.se>
 <2e4c5807-3d3c-1ce2-da35-3e37b2e3b08b@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="klaquncw2eqqdmau"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49300 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbdGaNiP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Jul 2017 09:38:15 -0400
Content-Disposition: inline
In-Reply-To: <2e4c5807-3d3c-1ce2-da35-3e37b2e3b08b@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: David Thomson <david.thomson@alliedtelesis.co.nz>, linux-i2c@vger.kernel.org


--klaquncw2eqqdmau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 19, 2017 at 09:30:06PM +0200, Peter Rosin wrote:
> On 2017-06-19 18:34, Peter Rosin wrote:
> > It would certainly be nice to know why .owner is clobbered, because I
> > don't see it. But then again, I don't know what sources I should be
> > reading...
>
> BTW, one thing I noticed when reading the current code is that I see this
> at the end of i2c_del_adapter:
>
> 	/* Clear the device structure in case this adapter is ever going to be
> 	   added again */
> 	memset(&adap->dev, 0, sizeof(adap->dev));
> }
> EXPORT_SYMBOL(i2c_del_adapter);

It was added with commit bd4bc3dbded9cd ("i2c: Clear i2c_adapter.dev on
adapter removal") with this commit message:

    i2c: Clear i2c_adapter.dev on adapter removal

    Clear i2c_adapter.dev on adapter removal. This makes it possible to
    re-add the adapter at a later point, which some drivers
    (i2c-amd756-s4882, i2c-nforce2-s4985) actually do.

    This fixes a bug reported by John Stultz here:
      http://lkml.org/lkml/2008/7/15/720
    and by Ingo Molar there:
      http://lkml.org/lkml/2008/7/16/78

So, despite the docs, it used to be an issue actually...


--klaquncw2eqqdmau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/MsYACgkQFA3kzBSg
KbaORA/9GRW1nkvbk3TQ5+sv3fovuXUUQlZtvJ8Bqtwx7bFzwNKytzoVjrFhFlIX
0gHWCwlwYt7qCM5JmTxSuXOIZRiVbIsByObwrJGoYRKeLYNSD4E+gVTfqT/DZqWZ
MFCV4KhR+GeTiINWNZsl+GJVUJNAY9OeFUKa3ftjBz7eMoU0OG4JEt0mdUp2Y0WD
OI32Gb8dbEcDPCCnG36j1v2ob+q0NL7hziySpOoIcVn1cmn8YW0nmQVsfXpbH5b6
7E/S9pbRSk3rYJ9SdaIuoSFGE2NrOh3Gao6uAUUVnzg0GaPhT7dGeN2QtldwXTYR
jBEBO0fn9gstDP0dulpjjwimTvGRyFoh0a50KVcKvIKEs299/UBIFo2xy9C3tlJp
XYXz4ZaI2BMCiunndSkIiyNpql6/mhRZstIuEh27M6Kqh0+pTym/9xn5wREHXsva
QICZjg52pcWavKvCe6RLb2XluyfFgSm/C+BmKKajX1JDA0v90wpRi8xtsQhXp0t7
KG7FL2988/CnCi3Nmptwa2uiG3wt3VtfGblM4f6Zn4NpHMoD/GnB+pNBaTu2MA4n
pdawQjnaVgjSSkBsmYBfZyi5Kan5cFPxTo6brHVCjMVnZKOVC3GhtU3qtdXRD1R3
7idIwBfMCT+z2eLPw7m1T3YPJFxa/fIEwEyavFOZwHxkwL0s3+I=
=7E55
-----END PGP SIGNATURE-----

--klaquncw2eqqdmau--
