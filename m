From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv3 5/5] i2c: i801: Use managed pcim_* PCI device
 initialization and reservation
Date: Sat, 7 Mar 2015 00:51:19 +0100
Message-ID: <20150306235119.GA993@katana>
References: <1423835545-17991-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1423835545-17991-5-git-send-email-jarkko.nikula@linux.intel.com>
 <20150216102918.53042ba0@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150216102918.53042ba0-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2015 at 10:29:18AM +0100, Jean Delvare wrote:
> On Fri, 13 Feb 2015 15:52:25 +0200, Jarkko Nikula wrote:
> > Simplifies the code a bit and makes easier to disable PCI device on dri=
ver
> > detach by removing the pcim_pin_device() call in the future if needed.
> >=20
> > Reason why i2c-i801.c doesn't ever call pci_disable_device() was becaus=
e it
> > made some systems to hang during power-off. See commit d6fcb3b9cf77
> > ("[PATCH] i2c-i801.c: don't pci_disable_device() after it was just enab=
led")
> > and
> > http://marc.info/?l=3Dlinux-kernel&m=3D115160053309535&w=3D2
> >=20
> > Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> > Changes from v2:
> > - over 80 characters long pcim_iomap_regions line splitted
> > - gotos and error labels removed
> > ---
> >  drivers/i2c/busses/i2c-i801.c | 25 +++++++++----------------
> >  1 file changed, 9 insertions(+), 16 deletions(-)
> > (...)
>=20
> Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
>=20
> Wolfram, please commit this series, I have reviewed all patches and
> tested the updated driver successfully on 3 different machines.
>=20
> Thanks Jarkko for the good work.

Applied to for-next, thanks!


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+j13AAoJEBQN5MwUoCm2AFoQAKXwat/OV5BjN1Stt6Pf6wiA
Z/BhLd5wS+dHEYX2WwKO5hn/RIZxAVvvZUcd+zMNpg0yuXdcnunXNIqXTO+dg4H4
lLQ5aH0TLYJrbiSvOhC8h9EYKNl3mjvVdSAGvpV38u9QTNusi+Q3bvdgCWjgA0KW
Pq7LmMjHhCrLaTVClvSg3T+lXdxtIRq7kwgeEi03SwY8h++xwK7xJf0qsulUJ9TD
Ge7gZhL6xnKx8y2XkiPn9lL2viTHGk/GNi6EEcp1PT+awfSOq4RxQz9y4yX8Dtox
jpxK/sQszLWuISOBb4oEL5RtH7l/Gbc8cEKxM04ViQh01FimjzXJVejJSmvhV3RG
LwwS8GMdc8LQXEnDFRyVP39HoWLPwfseu7sBVL35zEbaLE3xMbVItio7waW74yKo
Y3RUILRe4zSJSr+xKz/BdAiVikus/FHc1mF6ehTWMoaL1yCvbCc8GZDHGil94x5w
j5WnXSDlMVR/DQjsom6oSTNV2ikdRrTwkYx2hddFusWhDsfDXR0d1uc7zxZ1U4O2
wRHcJMfPjCtJIsEHCrwKQVrIqkFhkUTUI/yitR5vMzlZ0MelJ32eHzVBx2CfpROB
MR1ELJ+0niau9gXNCMIdrOeKTHxo5m0Kt8ZgmeHdlrf3BlG4oyx30H3MiNVR8p4d
6Svf1I9o9d6aH4nVWiG3
=6gim
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
