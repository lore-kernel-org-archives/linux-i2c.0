From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 1/8] i2c: core: Add support for best effort block read
 emulation
Date: Wed, 12 Aug 2015 16:49:06 +0200
Message-ID: <20150812144905.GA1524@katana>
References: <1438697056-2946-1-git-send-email-irina.tirdea@intel.com>
 <1438697056-2946-2-git-send-email-irina.tirdea@intel.com>
 <20150809073135.GB1526@katana>
 <1F3AC3675D538145B1661F571FE1805F2F0B0B8C@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0B0B8C-pww93C2UFcwu0RiL9chJVbfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> to print any error messages, but I was not sure. Anyway, I think I'll drop the error
> message entirely and leave error handling to the calling code.

Even better :)

Thanks,

   Wolfram


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy1zhAAoJEBQN5MwUoCm2+psQAKp4zUBlayuLpYgrDrk8/0eY
9jbOqM438HuiC1t0LDMhVx54a+sDpTfIkc4RiCMTgUlAiYiLB6XIbDGSrtiP5SEa
kH0ioj66ILE26vob9whwafpNRC+DSofuVGHdmI1ooPbJh2q+zi7R6Jsr8uhecM4F
tEkZZESBWmWigHqqMVlbvQal8RjqwfqZVi7miT5GtHcq3UORKqPgQlVzOTljTQq5
uk7HrTuVjn7UHdlSWY4tSz/HcSjR5LwEts0JDqfbkhjdLdioU3S/UUbIZ6mHe0zk
3MQXTe9UWWFhGKIhJFEy3M9MMbs5I4ZC7qo0IUTnJsybZCbLUClAj69lKI+tNxR9
CZLa2Fr4NFbidD2jMSQTc7ds4yrj9IrxB+bkPohrcLDHr30Y6lfzEWP5PtS90XYB
4EUgrIRbxUEFiwkMgPVm91FHRb76yjLBNxNxMHz/leomyI/streC3Ya4gqQgtH5P
qPeK8LnUbG4UIWTyT/YHJi2H9a2GONIOQQwzeKnty03IdZfIRgfygfi3sse89vt+
QHFRUIVrJHmtdQnjX4V0u67V0hSIPjwOSsQM1broFE+A4NfZo+Z7paHiAU/Wd0EJ
yI9RJxgRrusmFjOl+CQ4Iakce1ykAZQNahZZwsoIGEIi/gubCpBK4RaZZj8AP8DM
dLuD7BVGu5BFPcca0Clj
=AJ5e
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
