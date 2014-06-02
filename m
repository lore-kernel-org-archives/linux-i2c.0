From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: bfin: turn to Resource-managed API in probe
 function
Date: Mon, 2 Jun 2014 14:42:46 +0200
Message-ID: <20140602124246.GC2654@katana>
References: <1400751219-7943-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400751219-7943-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	if (IS_ERR((void *)iface->regs_base)) {

You missed this cast.


--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJTjHFGAAoJEBQN5MwUoCm2a/QP93gY0CuJQv6VcB9vJNQ6k4P3
SjT0hNLWRzEiAJWWVT2qLcBRjPpHHY7u4CmIxQMz2RsgbYuqdZjJhWDBlcb9BB+i
URC40BjxU4d+Tz2pKYWIBLx6lvobja03QR22mwSFLSnLISko3+c5byoQMxj3xq+V
EQZorJX/peTtpxgXR5rRtt16sJplVAMZEAsPmzwu3ejTVoVSobbPcsM2AFJqKbBW
Sibf8DwX1gB1KyM05XBAn1mHEF8PUfb+1DzM21qU3BVVLtzdPPDMBO8h0i9pvKRN
L4qBcEAB4IwjfMzM5tl0dXk/woUTSa0OAA1RixsOtj/HZa3UrNzYF671PwZN+Uye
AGy75KXgDITecFArzC4kgJu2wWEFXDRKCMDSUINqpSf8qvtihH0CQiPuVYkchtwm
O0yLM9oZ69HuqMyRKEBMMoIKqMQn1jSFXWIDmqInExVI+7JVK81SW3FkNHYS0sJH
wYIBc6o9QBaTcn5wG/vZ29rcpJRDhuWzTic78mboxKq2yhckzILGO8/WIf+YpCrh
FPCBCZ4hDRqGho7OJyK6S2RE1hfIcWEfgD7iBmyeDGguaCoGNVMVdL1+1Dzpa9fN
2u4p+DCcaz480EKeuFokouUmOrqMMIy4/ncQgEdZMsokwOpEDnPFRiK6Xse5L3OM
FuqT1Jc8LIEEK2ELaHc=
=U8LH
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
