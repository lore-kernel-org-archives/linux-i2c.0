From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/8] i2c: Remove redundant driver field from the
 i2c_client struct
Date: Sun, 29 Sep 2013 19:41:30 +0200
Message-ID: <20130929174130.GA3367@katana>
References: <1380444666-12019-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380444666-12019-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 29, 2013 at 10:50:58AM +0200, Lars-Peter Clausen wrote:

> This series removes the redundant driver field from the i2c_client struct. The
> field is redundant since the same pointer can be accessed through
> to_i2c_driver(client->dev.driver). The commit log suggests that the field has
> been around since forever (since before v2.6.12-rc2) and it looks as if it was
> simply forgotten to remove it during the conversion of the i2c framework to the
> generic device driver model.

Great! Looks proper from a first glimpse. I'd think it makes sense to
take all patches via I2C. So, I am looking for ACKs for other subsystems
touched.

Thanks,

   Wolfram


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSSGZKAAoJEBQN5MwUoCm2/TkP/iB3Li27waUCgxPpQKf4gPQi
49GJQg2lbVxpE+YpFHUiVbOrYY6sESM3Qtj4QpdsEhNulqujDJBtMK2Ie7eWyCFp
TjyOJCjP8m0br6cUExHkxF+Pxt0YDoxbxkzKx2TGqxaNc9rCl2m7Mc8utzXWcSOd
UIv5RhXPTwVLCtnP1aYSzRPK2kAe9R0vmZjTXYO2ogrlk7PTCTjwabekzPb/xcG9
xJuEhgh7OguGtwDiCse6CUzCmmeNid5pPMdRDmlxz4EyvsI0n7veWLsCaNBQ9Tle
1VY14aVx7rfMwsTDO2EBdUtqb6184wY2TD8osxtXcc9x8xwEU2RXZgPTcWspx9WB
f+1sG/USwmFup2YEV3APVJlLQs+CyUIKDCoaDMEU1JKMFCSz9OwKnC5uoq5qf9fN
kfSYjkqVsNFcQVsudHPrjAKhcL8QJADzmVDt7mMI/BWsAEmEy9w+VPe4MsHmYQAV
J9blY7uTkIRSYtYYgRH2CcgxM5ucGf0taIzcgNqzMSyfHjRe6Z36s4hK2ftR6pWu
o1lqKhk3mKdb9VS/ZNuZx7M9yqUOL/9fRIDbYbWVmFIqBVmKheZ/mNgR1wVBIZrK
C45Tggj3qZPG5ILOB6LjowsDia+QQ8/rbUvrqoTPLhR13M0Ql8nJT9jycG/pjLtt
Fpu3snXkRcaIxjZS7pQM
=pXY2
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
