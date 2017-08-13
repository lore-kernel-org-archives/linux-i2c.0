From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/1] gpu: move include files out of include/linux/i2c
Date: Sun, 13 Aug 2017 16:05:16 +0200
Message-ID: <20170813140516.z5rhvezm5yksjcwx@ninjato>
References: <20170521221114.2685-1-wsa@the-dreams.de>
 <CAMeQTsYwaCerkPkCN5AwnOhwvNj+vF-ZH33-kzemu2O3VJ4rag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1194528902=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAMeQTsYwaCerkPkCN5AwnOhwvNj+vF-ZH33-kzemu2O3VJ4rag@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: linux-i2c@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--===============1194528902==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bhovmatprne5kfgw"
Content-Disposition: inline


--bhovmatprne5kfgw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 11:38:08PM +0200, Patrik Jakobsson wrote:
> On Mon, May 22, 2017 at 12:11 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > It doesn't make sense to use include/linux/i2c for client drivers which=
 may in
> > fact rather be hwmon or input or whatever devices. As a result, I want =
to
> > deprecate include/linux/i2c for good. This series moves the include fil=
es to a
> > better location, largely include/linux/platform_data because that is wh=
at most
> > of the moved include files contain. Please let me know if you think ano=
ther
> > location is more suitable.
> >
> > I prefer the series to go upstream via the subsystem tree; if you prefe=
r that I
> > take it via I2C, just let me know.
>=20
> I don't think it makes sense to take this through the drm/gma500 since
> it's platform data and does not really touch any gma500 specifics.
> What makes sense for I2C/platform is probably more important here.

Ok, thank you for the info! I will pick it then.

> > No runtime testing because of no HW, but buildbot is happy with this se=
ries at
> > least. A branch can be found here:
>=20
> Not sure anybody have hardware to test mdfld + tc358765. Perhaps some
> smartphone exists but I've never seen one.

There seems to be an upstream user:

arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c

> FWIW, for the small gma500 change you have my:
>=20
> Acked-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

Thanks again,

   Wolfram


--bhovmatprne5kfgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmQXJgACgkQFA3kzBSg
KbbltQ/+JoGOoKQpfmxgkGxoO7iYwyDM01lWfs9GpaXIToxBZ0Fa2WXTXHRzr6Mc
cHuAGZiWex90emxZPsLGi0T9V2oMAc/3HFoxq5bomloZVA6UzLTsA5ULniKwU6AQ
IJTfU7+cVSjiHD5icnh+ihKfLryqcU8kWHCzVVaRJ143kQHmBPVh5ho6rOevMfxv
tkq5S9l6OJrstOl35ZSlaMr1T4cUGZUd8X10XewBlCJhrULMTpObJzb/1Z4Df6DA
M3OUWYkXeMrq+t5UB8mhLBqFjZwJ1Gi7/L/3Li6065FSMvjeuv827UBIdwqk+fvr
FbJQKs4AWwH9RKi2ekUp7yVreDUdXAVky2/Gpt0hS8N4WcU16FNbEZIw39qwptjT
U/+Ec91oOiOx8twwTTIhWsJC0eOj8CXwaD7Z0mCLuUxbWqnAUS+Dv39jctKBTkgA
2Csvu6MkrEuYVP2p6VKQzKYrEaI0xVmFAEwtJZRCw9NqWuERoEr0I5f8mHcDRwov
bFqWirBowa466AwqRRzyc0O1KUSkJLY4gkGfhxTkwUFCiIgUOn5HN5UDQS5gdOro
ykkaaxnVcM6NbQ0xQQgp+BiTS4NjZYbW1xMEV+a9ODBYK4JIAYOsBQWtYl5+T/+o
IhwrLKdXSqqIRXN/txv5tLknOURkjZR8SXVDJ0PE85V3dhFZ+HE=
=G7mH
-----END PGP SIGNATURE-----

--bhovmatprne5kfgw--

--===============1194528902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1194528902==--
