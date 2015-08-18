From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Tue, 18 Aug 2015 18:44:39 +0200
Message-ID: <20150818164437.GA1750@katana>
References: <1434475692-4611-1-git-send-email-yorksun@freescale.com>
 <20150815202302.GB3463@katana>
 <55D20DC9.2060304@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55D20DC9.2060304-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> unused-but-set-variable by default. How did you enable this warning without
> being flooded by the warnings? (I tried W=1)

I use W=1. To prevent flooding, I used to replace all -I with -isystem
in the Kernel Makefile, but sadly this doesn't work anymore. And I had
no time to investigate why.


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV02D1AAoJEBQN5MwUoCm2zaAQAJxjs1iK9xJs7U7qsng6x879
WIKNKwgfOTnLVwZc7DNuMi1JmL3XWvWm22fHFZ8DNNuBBKF/EN3KBZCGhCvStq5M
tCHXrwx7Y+luwfgvWyg6/eYob0cDqb2o3Bm2JPOpSetzLThWCcqcj7sLIsiJitEs
yTfVirmKGidFqlT9704lSJ0VqeEXLiguvV8YuhSSjxrqIeEObTA2t3fGkM4tJvq8
w+kSRJLcdjKu5PXUoS1uL6yhsMB0C/DHODISJkk+r3uJPPeXNFEB86+EQTw3IPmz
izi9Ymc+rgN2DpL0tHGgbQ5Jfbe4+wC9BdXG4w+gtWlLQxizERbeK3t8J11HqAcV
wRpnCPAQGyayaHSnlzVzXVupcX5ibo0jjq3DFkHhTqSokWjemeoJyEt9Dbbnn//f
1DG2RIEwQnuuaRJtyexYImMt3HoOndJRQgnCjEnO1hvIsLstyeeKBC2ariAduiQ4
Dbj1X1E0RDtVLxo/PmSr2gAg3Gb3RD9XgCuz35RP0FRbuZO/CxvC+HZ7Z0iban+6
C/WOfcKG+K96P+IHe8yjNeOz6P4Ani+TDFPvm1summba4Muh8zxEvtLUMZLsdrh1
1M+yWvkgtjE0FkYZUjC1WM5Ox2KaEu08G5nXO1SNe1N0J7OTYnnlVrwY8fK+XSEc
W9bZjODMy75q5fYPsn/P
=+Gcx
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
