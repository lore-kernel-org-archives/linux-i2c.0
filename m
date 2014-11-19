From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] dt: Update I2C trivial devices list
Date: Wed, 19 Nov 2014 15:24:39 +0100
Message-ID: <20141119142438.GC1384@katana>
References: <1387239151-19226-1-git-send-email-bgamari.foss@gmail.com>
 <52B07870.6070809@wwwdotorg.org>
 <87a9fztofc.fsf@gmail.com>
 <20140113125128.GE2586@katana>
 <87r48cklgj.fsf@gmail.com>
 <52D41B14.6060701@wwwdotorg.org>
 <87ob3flrmw.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ob3flrmw.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2014 at 12:26:47PM -0500, Ben Gamari wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> writes:
>=20
> > On 01/13/2014 07:25 AM, Ben Gamari wrote:
> >> Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> writes:
> >>> What about putting this into a seperate paragraph prefixed with "Curr=
ent
> >>> Linux specific implementation:"?
> >>>
> >> This would address my concern quite nicely.
> >
> > The text should go into Documentation/ not the DT binding.
> >
> The problem here is that as it stands DT is quite daunting to pick
> up. My needs are pretty minimal yet I had to spend many hours sifting
> through source, blogs, and Documentation/* to get something that more or
> less worked. The bindings are generally well-documented, but there is no
> "start here" document in the tree giving conventions and an overview of
> how Linux in particular uses DT.
>=20
> The closest thing I know of is Documentation/devicetree/usage-model.txt.
> Perhaps this is where the language Wolfram suggested should be placed.

I appreciate your effort to improve documentation on how to get started.
Sadly, I don't know where the best place would be and I am too busy to
look it up. If you are interested, I'll happily apply the outcome,
otherwise we sadly have to wait until someone else comes up.


--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUbKgmAAoJEBQN5MwUoCm2C4kQAKh51kdxJbhxZn9cE/VSeCxv
KK+M59593BNjGSUwWpE0IsEAryqE/12/4ESacsmFAZE0q5RjTljddy0wm6//dQov
JUYCtSJ9ZSm7bgpCZnznEvFMk2MiH36N20HHtfoQeIqQTYPKNcNMx2OYIaQI2lZz
uUdJoAs+HATo8rRIIoznND6N+yYGYlAg7TDk5A1pMNoTp7adJ/VBxSZg/N21IZjz
DEJjlgXsn21hydY+YF45A332EfF8UoHnf+otLpEJ/t711PB2ejXyYJgJy94i8S+C
kdQ08nQaxBLhLCHnNw/Z2ks6gpOfDz4Yyt28IxnNu1cR1WFySm/k4EnBuDbbcX52
QrTseD9rIp8rPuFdpiMT8+x7bCVvdPNt6mQCBRp5TrjJN4/1hpIl6+ylR5cgXoiV
57dfJ2KLVqjiL9V7FODrlj+CjDN/JxaDDBX6EhwNHbBmrpe2PiBmOt2Jrf3yn24J
PtaT8gI6y3mgmdB/DWqMoHpVgfS+OFn15tksh7Gozzh0RHfYPUZyGnHYdcswrF1E
npooM/+yNm96TSMDvGKqNBXYd48I9mJI+QyBgSMRiR2wjJlqTJaBfLpbW44e6tsf
P56w71h2OQJOzLbg4+CClFnWCJGCR0no8Pa01fhGeCpnbkiODuxoRzzVGUJWm4fr
aF2HB+PNdL0oLgTvouWX
=UgyN
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
