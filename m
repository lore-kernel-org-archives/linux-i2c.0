From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH V1 2/2] i2c: tegra: support for I2C_M_NOSTART protocol
 mangling
Date: Tue, 24 Apr 2012 12:38:35 +0100
Message-ID: <20120424113834.GE12063@opensource.wolfsonmicro.com>
References: <1335251976-31925-1-git-send-email-ldewangan@nvidia.com>
 <1335251976-31925-3-git-send-email-ldewangan@nvidia.com>
 <20120424105557.7ac07232@endymion.delvare>
 <4F967089.3050004@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F967089.3050004-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2012 at 02:51:13PM +0530, Laxman Dewangan wrote:
> On Tuesday 24 April 2012 02:25 PM, Jean Delvare wrote:

> >>Adding support for protocol mangling I2C_M_NOSTART.
> >>When multiple message transfer request made through i2c
> >>and if any message is flagged with I2C_M_NOSTART then
> >>it will not send the start/repeat start/address of that
> >>message i.e. send the data directly.

> >What do you need this for?

> The primary use-case here is scatter-gather of multiple I2C
> messages; the first message will contain the START and perhaps some
> transfers, then subsequent messages will continue with more data
> transfers. This removes the need to put all the data transfers into
> a single message, and hence avoids some copying of commands/data.

> Mark Brown says this is important for regmap. This feature is
> implement gather support for I2C transfers - the resulting I2C
> transfer is entirely normal but this ends up being implemented by
> the controller doing two transfers back to back with no start on the
> second transfer. To the outside world it looks like a perfectly
> normal transfer. This behaviour can be emulated by allocating a
> buffer and coalescing the data into that buffer before sending it to
> the hardware but this introduces an avoidable and sometimes
> noticeable overhead.

I'm sure I've seen that block of text somewhere before :)

This is it, you've got some big blob like a firmware image somewhere=20
or perhaps even just a small block of data to write in one and you want
to put a register address on the front and send it.  It's much easier
and slightly faster if you can avoid having to allocate a temporary
buffer - not so much for I2C per se (it's generally very slow after all)
as for the overall system, often when you're doing this stuff when the
system is generally very busy so it's helpful to avoid introducing
needless extra work.

In the grand scheme it's not the end of the world if it's missing but
if the hardware supports it we may as well use it, it's usually just
setting a single register bit.

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlpCOAAoJEBus8iNuMP3d1TQQAIZp0Z0T74cWQ+75VBj7FKKZ
ie39Zbam6fRlZYxfERAmUTi38uL5gDNRuEWDYIAB+WkpxxRMmxUwmPt7wCNLRf5D
gVI/WyNERwla6fiqIA2G4gB8UqQPOmTKujaX8XyB0/RBqdxcbjp6Au+GmbLnqyd6
ZnW8vOkCvTShiGXawkiFnHVk/tpIcmoaahHjXfxikgyNlFRKxb9LLy4UjbSp3rMX
xyCthylB3bwDtMGKzjxQ+MXpdblvF5EKjopPr8+nSbwDmrABSZvmd9dkOE2gZhQl
gJsl7KqOPIM4UytF67OlZdzux58BoygT9QhZWilNXJ2BxTIaAWf2+eWj6zBQw8Ct
suyawO2G37p0GJeQAtIahFh3ZLXnesx0hoxMN9N0qHAQBzSDC43H2jJ1yGDuUjSf
/RbR9lpp4BcMcusndyqnYjUU5wAwzzq4JAu92PvM7h5SUgg2gBlc69znmSrpxt3E
rk8Vn9gdZQ4EAVZqQMacVze6qMrwUhxh/vZkJyTAczPInvre4Ob8MgyXZ2eo9Oor
vrHMeHeg9IE4IqQo/C+87erNQoifiNg/uKdkzNf9n3neRRgen+L9l0kwyb0d1i9W
dHJheNrMk5l8wGWRX5f3MFI6NFSOE0sb4BVTiVn2nPsZkICZF52XH30RwspKNq+O
4DN39W1CXyMC/Bwg57Q6
=/foX
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
