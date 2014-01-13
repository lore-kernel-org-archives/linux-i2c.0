From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dt: Update I2C trivial devices list
Date: Mon, 13 Jan 2014 12:26:47 -0500
Message-ID: <87ob3flrmw.fsf@gmail.com>
References: <1387239151-19226-1-git-send-email-bgamari.foss@gmail.com> <52B07870.6070809@wwwdotorg.org> <87a9fztofc.fsf@gmail.com> <20140113125128.GE2586@katana> <87r48cklgj.fsf@gmail.com> <52D41B14.6060701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52D41B14.6060701-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--=-=-=
Content-Type: text/plain

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> writes:

> On 01/13/2014 07:25 AM, Ben Gamari wrote:
>> Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> writes:
>>> What about putting this into a seperate paragraph prefixed with "Current
>>> Linux specific implementation:"?
>>>
>> This would address my concern quite nicely.
>
> The text should go into Documentation/ not the DT binding.
>
The problem here is that as it stands DT is quite daunting to pick
up. My needs are pretty minimal yet I had to spend many hours sifting
through source, blogs, and Documentation/* to get something that more or
less worked. The bindings are generally well-documented, but there is no
"start here" document in the tree giving conventions and an overview of
how Linux in particular uses DT.

The closest thing I know of is Documentation/devicetree/usage-model.txt.
Perhaps this is where the language Wolfram suggested should be placed.

Cheers,

- Ben

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBAgAGBQJS1CHXAAoJEErkyLZmeNiDjJwH/RIvVaEN9geH5GXI4X7Y2X2u
6PgeRboCcxv+9a2BoZt1Poq/6HkskO4G0gmElUrJb1dQBQhEc7a25m5Gcc7Sh9SR
gjU2pJUZmMGq7py2GPmrRmlDkDtvjN3+jG3HEDxuDxmaOE/zwPO+SEU0FQbBZhaH
C07QSuy8cHuaKEXnBGqBxfjfqwKWh2V9BGWQsFjocma8Gh5A5PMtPwp8Lh4Yvpcs
GHPE5yrnAJzNOonKaNVzh2wYIrG5JgLPyyfVQ5hx1E5DftyUsiaPHA7i2vpPNEej
ZkAjKU5UAyY6gBeyJyVnlN9SdMwLlWmN89SfKKkORyDGzy1rhz/Qig8h63Un6SA=
=rg6N
-----END PGP SIGNATURE-----
--=-=-=--
