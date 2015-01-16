From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in
 i2c_del_adapter
Date: Fri, 16 Jan 2015 08:36:11 +0100
Message-ID: <20150116083611.491dc0b8@endymion.delvare>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com>
	<20150113152957.GL7660@katana>
	<20150114144938.4e3c3f52@endymion.delvare>
	<B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com>
	<20150114161525.49c54acc@endymion.delvare>
	<20150114162442.GB18578@roeck-us.net>
	<20150114181426.3a39791b@endymion.delvare>
	<6680B42A-76E8-40CF-9574-ECD00B40AE98@konsulko.com>
	<20150114204122.GA31119@kroah.com>
	<E91AA1C8-64EE-4111-94BD-B8F05071D507@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E91AA1C8-64EE-4111-94BD-B8F05071D507-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Pantelis,

On Thu, 15 Jan 2015 18:25:22 +0200, Pantelis Antoniou wrote:
> The remove method of the mux gets called and on it=E2=80=99s remove m=
ethod i2c_del_mux_adapter is called,
> which in turn calls i2c_del_adapter() which hangs.
>=20
> Anyway, finally figured out what the problem was, a reference was hel=
d, and not released properly in
> the i2c notifier pathc.
>=20
> I=E2=80=99ll send out an updated patch later today.
>=20
> > Having that call "wait" for the other release call to happen is rea=
lly
> > old, as Jean points out, from 2003.  We have "fixed" sysfs since th=
en to
> > detach the files from the devices easier, we used to have some nasy
> > reference count issues in that area.  Perhaps this isn't needed any=
more,
>=20
> It=E2=80=99s awfully easy to get a hang with this blocking wait. Turn=
s a memory leak into a hard hang.

Turns an invisible memory leak into a visible bug, giving you the
opportunity to fix it. You should be grateful ;-)

That being said, if this completion serves no other purpose then it
can go away, I don't mind.

--=20
Jean Delvare
SUSE L3 Support
