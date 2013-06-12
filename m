From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH REBASE] i2c-designware: make SDA hold time configurable
Date: Wed, 12 Jun 2013 16:47:45 +0200
Message-ID: <20130612144743.GB8102@ab42.lan>
References: <20130514110745.GA10906@intel.com>
 <1368536642-7158-1-git-send-email-christian.ruppert@abilis.com>
 <20130610152954.GE2987@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130610152954.GE2987@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2013 at 05:29:55PM +0200, Wolfram Sang wrote:
> On Tue, May 14, 2013 at 03:04:02PM +0200, Christian Ruppert wrote:
> > This patch makes the SDA hold time configurable through device tree.
> >=20
> > [rebased to i2c-current/i2c-next/mainline-3.10-rc1]
> >=20
> > Signed-off-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
>=20
> Hmm, I really have problems adding a generic property. I need to better
> understand why this is needed? What is the usecase? Can't a safe value
> be calculated depending on the bus-speed? Is there a public datasheet
> available somewhere?

I checked with our PCB/Applications team and the data sheets for the
peripherals in question (DVB demodulator front ends) are under NDA.
Mika, you seem to be interested in this patch as well. Do you know of
any publicly available data sheets for hardware requiring this
adjustment?

In the case of the Designware block, the parameter both changes SDA and
START hold times, however, and you'll find lots of data sheets for
hardware with START hold time requirements on the net, e.g.
http://ww1.microchip.com/downloads/en/DeviceDoc/21805B.pdf

The empirical solution in the function i2c_dw_scl_hcnt does not seem to
work in all cases: Our lab guys confirmed that we have several PCB
designs which do not work without adjusting the sda-hold-time parameter
to an appropriate value. The value seems to be different for different
PCBs.

I suspect that this kind of configurability is not the same for all i2c
bus master hardware. If you don't want to add a generic property, would
you accept the patch with the property renamed to dwi2c,sda-hold-time?

Greetings,
  Christian


--=20
  Christian Ruppert              ,          <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-Fleuri
                             _// | bilis Systems   CH-1228 Plan-les-Ouates

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlG4ig8ACgkQbI8SbDT4m4+xQACgudMzzFq2VpdSrGO40HHOo3kV
HDgAmgP9Yvcdkp4fZng0JyHCgfBqCd/A
=4bpo
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
