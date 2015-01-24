From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Sat, 24 Jan 2015 05:26:24 +0100
Message-ID: <20150124042623.GB1190@katana>
References: <1421346798-17148-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150122144818.GG3413@katana>
 <CAL_JsqKEBYwX=5zgWbdVRxm-H-sFiDa9rAp26BvuKNECoNW=uQ@mail.gmail.com>
 <20150122150243.GI3413@katana>
 <CAL_JsqKYvcec=xWQM7_Dgrr5zmkefXqGCQvHwJ+uxNgfiv7fcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKYvcec=xWQM7_Dgrr5zmkefXqGCQvHwJ+uxNgfiv7fcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Feel free to apply it for 3.19 with my ack. You then want to pick up
> v1 of this patch.

Sigh, I give up, this is too confusing. I don't know which one is V1,
they are not numbered in any way. And I have been holding back my pull
request for too long already.

I'll drop this patch. Whatever should be applied should be resent,
mentioning the release it is aimed for and how the planning/dependency
on the DT patch is.


--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwx7vAAoJEBQN5MwUoCm2J40QAJqSvd5pdpfXt34uOKHpTlBU
m1z3PMy8Q48hB0nraQ8jEprnKZUH5cAHhb+t8p1Ii4D5sVnnFbi9lq1GO78Ved44
4IGNDjBbfYaR/sdGz7tTuaM3/oSlStfJ4z2W43m11vGM3kqQjP77tlS/8FITkWLC
80Bmc7LrOU6NTaL1nMz14kPwAXpL3kRsfqa9uabUpL7jsaZKIOd7VE7KRaalYkz2
kJ6GLbHk1id0Ta/q6KQONamQTz3cTsem20HxrWtEOuH136gw4tUoY+KKV75xsHfN
VGAIlAC8p6Jtb4zvb/DQD5/SdkhLDlpB2RMxzrcbiw5rbuOulUmstkFwv7ZsYm03
4CdCX+RuJbLwFvtAShhX02FEvwCaXAa5EcrxhWZiUjaeySGWVkiiv0/f6hwQ1HVS
uVBKRkDYGsAw5kvSS1okc8Odvio8QxCz1KFJe5abjvKG8HChbf3+pQn4y1puwiZG
W8GK0rgFeCtevonrDiODm3yJjPAkA0ktYBKMEh5p/GSLgQxlUaEVgb9hV9PLBK40
yKLNx7CZacN1UfJ9XluQEJzkQeFJQQnpio45P0/rxwq4PSeEaVKbximX6S05pw/X
/QMcPqrhiPd4z+L7a3vvCiGx8aiAv/v1acU4lGlN8ILGu2P8yy9FaxKNUl1B9wfM
wKWeQfBLuPwd50JyDA+4
=QYDW
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
