From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dt: Update I2C trivial devices list
Date: Tue, 17 Dec 2013 11:47:19 -0500
Message-ID: <87a9fztofc.fsf@gmail.com>
References: <1387239151-19226-1-git-send-email-bgamari.foss@gmail.com> <52B07870.6070809@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52B07870.6070809-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--=-=-=
Content-Type: text/plain

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> writes:

> On 12/16/2013 05:12 PM, Ben Gamari wrote:
>
>> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>
>>  This is a list of trivial i2c devices that have simple device tree
>>  bindings, consisting only of a compatible field, an address and
>> -possibly an interrupt line.
>> +possibly an interrupt line. The compatible field is used to lookup the
>> +modalias of the driver which will handle the device. The compatible
>> +string may begin with a manufacturer prefix (separated from the
>> +modalias by a comma) which will be stripped off during lookup.
>
> This part of the patch described Linux-specific behaviour, whereas DT
> bindings should be OS-agnostic.
>
I see your point but it would be nice to have language like this
somewhere. One of the biggest challenges in diving in to writing a
devicetree is figuring out details like this.

> BTW, you didn't CC the DT binding maintainers.
>
Very true. Fixed.

Cheers,

- Ben

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBAgAGBQJSsIAXAAoJEErkyLZmeNiDl4AH/RSSkiNYwaZLG+zZEixmYXT4
T53NPBK72eQxSiilfETc2TJT8RbCHlLWckIwttrUkIIYlknbfOxVQrdZg9vMxu4K
cM2zX//wQ4AQkO4b9jsgQ0y98YUFTBOZRFmefMogg28DB8VMGNB+qxlT5nFcwPdx
XIYIqjrnO6yWOEgmZ2ZI4NP8PAz9njNTT2vdNYhGYet6jBztOgpoMEPvjNPz6K9a
vb68ptYk2EmtHrZAk2jE4MFQalMO/g1m5Hd/pscc1Y7KBHDZYtBgqwsFo1GnTOCj
G5iYt4JUQIOaNKzyJ0xgHydg2VUAsdX0dP6GYfN6k0a+HEymKSlCHdIl6FaoafE=
=SdHL
-----END PGP SIGNATURE-----
--=-=-=--
