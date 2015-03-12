From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Another problem with I2C multiplexer bus naming
Date: Thu, 12 Mar 2015 10:42:27 +0100
Message-ID: <20150312094227.GA4225@katana>
References: <1426133507.16219.YahooMailNeo@web181502.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426133507.16219.YahooMailNeo-XYahOdtEMNm2Y7dhQGSVAJOW+3bF1jUfVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> [    2.951717] omap_i2c 44e0b000.i2c: failure adding adapter
> ...snipped...
> [    2.964249] omap_i2c: probe of 44e0b000.i2c failed with error -16
> ... snipped ...

Thanks! After a first glimpse, this seems to be a bug. The omap driver
uses i2c_add_numbered_adapter here in DT context, and thus
__i2c_first_dynamic_bus_num is not properly increased because there is
no static board_info. Will have a look.

> Will the future "multiple i2c multiplexers on the same bus" solution
> fix this problem?

I don't know what you are referring to here?

Regards,

   Wolfram

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAV+DAAoJEBQN5MwUoCm2HikP/io6Qjzma69S/vMbKWYODMvP
AaTKfne5IAt7BgUIxZJcFJ0GrEN3/n7FeCybh/PjRiN/VsT2JgvuXoyaEM5BVaO+
N/l0hBKwaSTTN0BN3lZ4JoxUdl6G68p1lRvlj0U9FniXmWtQViMEYX3RbLZuS4RW
WoOoU+hTZzSrKUJ26dGXKROidJW07XsHQqwjKuHfMVeFAGZk+g4lV0M2XdzTqqgF
7rqmlLTMqxuyImW0IL/r49EMOJxeQ67arVIXtderNp3sCuSKfpkObF/S2m5/hed5
2w01JV3AZuXhVRD5NxXObAlF6nEPB8jPBriFbHkkjh8/WEbnVHMGCtlqMcVdtimV
JPgc+Sbg0ot89FAzJYSgdVuichYkoTeVFkidfJi4XHU4c9SAs8CQYUlOXsAmK28T
gUMYtHRsaf58b9mR/gng8y6Q5pAmb4zEf9T0stsvSn4zn4VzseuJkO4CXK8REcWo
x9P8hOaKkXRfSVhnOFJ0y2HJIaX+34hRzFJpAIAavm/+p2jxq6Ix6o1bcxX2fvki
VBd/si9U2fCtGrh/iycnnaXts0RdEK8MRbSNPbPB2I4QInNBga/yPpy8HTqd3Yk2
ouRTAyQ9bv3LRx10zXNpMVkwYzwr94yq0cj93UDP4ZpdxnFbATxEL+Ic8Vmzgjhp
409NGnFEEEzpC/FfOiVa
=o4EU
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
