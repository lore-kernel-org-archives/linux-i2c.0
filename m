From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6] eeprom: at24: Add OF device ID table
Date: Tue, 17 Oct 2017 23:40:40 +0200
Message-ID: <20171017214040.kak3kpvh6tunjjfp@ninjato>
References: <20171001104948.21663-1-javierm@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4gpoiumi3ryrhzfa"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54628 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937176AbdJQVkm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 17 Oct 2017 17:40:42 -0400
Content-Disposition: inline
In-Reply-To: <20171001104948.21663-1-javierm@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>


--4gpoiumi3ryrhzfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> +	{
> +		.compatible = "atmel,spd",
> +		.data = (void *)AT24_DEVICE_MAGIC(2048 / 8,
> +				AT24_FLAG_READONLY | AT24_FLAG_IRUGO)
> +	},

checkpatch reported this one as un-documented. And come to think of it,
since this is solely for EEPROMs on RAM modules, I think we can drop a
DT binding for it. Could you agree? I can do it locally, no need to
resend. I'll do HW testing later, but wanted to check on your opinion
already.

Thanks,

   Wolfram


--4gpoiumi3ryrhzfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmeNgACgkQFA3kzBSg
Kbax6Q//SLjgkjrkph54znqnJAGomVnNpCDVqFne7N3vBGrFgxbX7Bv7q5QGUx9B
HatTJv1XsjUPVzxuGmFKvEMuzFW1+5K5SWyBDw9aQzW9C7XHtojUmJbVr91ZShaL
isBT0cmDSATvce8hds/iVMTKCfqhvd01ihwmRwyqh1o73kkJpAby1pGSu5ONJMGe
R4I1IiPEuduiFMKio0+m/bxuxZYnYVW/jAxSWGQ1oaDandhQ3m1nn+1g6j/fhUE6
CVlTJHY19U3ZUtIpAx73Qskpm51u8INKYh0oAieTNdF2O15jnkIFg4UJLFXfyb1x
DdHZXybXKKsT2Kv6cIFfHiETMsRzxUA2Etx5wP8onCypKufIWXu9yhp/2EYp9TSq
xbL6F57CQDJZ9H/KdQrzt3nTxnzUq/GWBKHp5kurzBtvPw4G/DjY4EAjhSgmlmEx
r8siwDouKai8RgdCY1dzkoi31YW/I5l2MO0/RnzvAgmx6vFMN7R1V0pCE4FDMYd1
82hnLSkijqe+xHl7Sloz8pAom0NSh3rKpMJ0R4t+OLbpJO+jSNY5jdzh1Pd018PY
P3m+r5PFAfY6Mref5RLYK3ro1Swh/2mdBdep8Th2jj3XOArL0/astwFulfiPHZTA
D34w/Hqg7NdCiz7MtI4bepO4UW4J/3XoZ60NBS+8FNKQQykgRWE=
=ldSH
-----END PGP SIGNATURE-----

--4gpoiumi3ryrhzfa--
