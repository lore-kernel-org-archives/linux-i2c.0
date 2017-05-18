From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC] i2c-stub: make it usable with DT when booting
Date: Thu, 18 May 2017 11:30:54 +0200
Message-ID: <20170518093054.GA2740@katana>
References: <20170516112758.2842-1-wsa+renesas@sang-engineering.com>
 <20170518105253.058a90a6@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39492 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751486AbdERJa5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 May 2017 05:30:57 -0400
Content-Disposition: inline
In-Reply-To: <20170518105253.058a90a6@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-renesas-soc@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jean,

> I get the idea and I understand the need to emulate the devices early
> in the boot process. However, how do you deal with the I2C devices
> pre-initialization (setting initial register values)? This is typically
> done in user-space with the i2c-stub-from-dump script, or manual calls
> to i2cset, but that would be too late in your case, wouldn't it?

Yes. In my case, all 0 memory is fine. I needed to check writes which
were enabling "channels" allowing me to do further initialization.

I see the point, though, that we likely want to address your question
before going upstream.

> Code looks sane, but I can't comment on the bindings side of things as
> this isn't my area.

Sure, thanks for checking the code!

Regards,

   Wolfram


--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkdacoACgkQFA3kzBSg
KbZqiA/9FqHSEKfryZel5QTUibYwcJ/wikhdR3VLqCa5OG0D8h7pMYJOdXhBKtsv
EadPYgEyzffR9LOR6j5/7pgvun7nIMm5X/NtQ1gjHwMx/hH1cwQDn65gkwgtT/cN
CcT8sAeFa8AJzUMWrb9ZkUOlFgOF2l+ojexWI5rz3W/yvEkhfEH5cBMWGXoyV70F
i3QKI7/ZXfjN2WNbfzsdiewkr4PNNNxnnt++b5IrgAOp6QR56p802JO/0lGIaf2g
cq60CqNDy4kEw7k+l8GwWp6YL2zCn4HhCsJTN5EXgjdkACjlqwBgzrfrWWAxjKFF
M4LQVtdhQDTgTJj1d2e72OZyGQedvixAXMEtdTc47zTJVQO7sH1S/ivOAU45myOf
GQVhPNrj9ckc2scTerkok4ZmSqLse2Mjz5KCnxqhX4r7LnQSgu+T4RMIL0HMlq/B
n3mIsxkjSVsmqxf+5v9eEcnpgRu99L4hMhRqTfODZIlK7Va4NArcrMD3PvhCssnf
dk6n1rH8/A0+4krMdcwnm2dlDiI218q/Q6gJ+HimFGFEOXTKJ2miiOyeOpD/o9Gy
hR1MlZ0iRAeQZY6m5Zjg68c6lLLEkwnE9vhX2cA2ANmfR/+oe0nY53k8HWBJFGNK
GOexH3VB5UQcMEkX7ZaHr5ramecq5z8Zi/CeYnt0KeK+bSt/his=
=Kg3u
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
