From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Support for Netlogic XLP9XX/5XX I2C controller.
Date: Mon, 9 Feb 2015 18:23:01 +0100
Message-ID: <20150209172301.GA11749@katana>
References: <1421393020-18807-1-git-send-email-jchandra@broadcom.com>
 <1421393020-18807-2-git-send-email-jchandra@broadcom.com>
 <20150209152805.GC8024@katana>
 <20150209161549.GA2787@jayachandranc.netlogicmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150209161549.GA2787-l4W0uAg2RDvWG0bvociYJ/An/qbn1+6FOui0OUZsNXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jayachandran C." <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Given that we have already have i2c/busses/i2c-xlr.c upstream (and updates
> to i2c-ocores.c for our earlier chip), I was hoping that we have got thin=
gs
> right this time.

=46rom the glimpse I had, it was mostly OK. Yet, a number of nits in
regard to API updates, superfluous things. Stuff like that.

You could also check earlier reviews from me and check if there are
issues which apply to your driver as well.

> Anyway, I will forward it internally to Ray for review, and if necessary
> submit another patch.

Thanks!


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2Oz1AAoJEBQN5MwUoCm2sgEP/iIcDo9zN5pyxDM1cNIAY3pp
9c5Ithwp8aEQnBVJO7S73hQtrBooAhu6HHLK/D1+ZgNngcbqe0Yp1VgIINfbMFrU
NQX2YXq2AdeJPqFpqmauZ14PMgB0vp1jF6Z1LK8hWVFmV5R70uH/Z/eoSlykxLrO
Y4JRnIvzePFump7L+RkNAwbvx4pq7atMCZvEJxSwMpROedj4vYLvP38iNHJzU4pb
9uy6onkUiri6UE1L8zewjiXyNaIsey+HrZVg4DxNOiV8uKfN9QrknbmBLOgvTAGb
KyaNI3q/in+8jQqbdy45fT/K5yfuq2nDrkfXdbnTXTAXaXui81P2XM8egmKA8xNJ
YRWb42T737boyDgNhjbxBATRDtQinsOHiCcEVI9DHrgUYFC4DpAxfDIqDhbwzZbb
s8JP7VqyarsGkcthcG9iLx05SweBq7A/yvIbYUBc1kpciiirWXOK48srsv0yscSl
4Da2PSNMn/q8ipX/ls39vGz6KxZg9jeU75X8PjPe5MiXBPjxqHE6GGmuUjQhhuWh
GXckFtns7/4kzezVhXEWqLNzLNPwIPBWlKMBnYsHeh6gBfF+q9JrUNe5pDpuq2Sz
Pt4GvpIuxR5k6r+8HFiW7MlErP5paIyTM+oQc+Enl/PDY8I4+OmfJBnzYsjd7Kap
0kylaI0w38Gzkn0qG/Ib
=iOeU
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
