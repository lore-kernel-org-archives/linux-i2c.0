From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v17] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Date: Mon, 25 Mar 2019 15:37:52 +0100
Message-ID: <20190325143752.GA4456@kunai>
References: <20190305151319.GA22819@syn-yoga530>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190305151319.GA22819@syn-yoga530>
Sender: linux-kernel-owner@vger.kernel.org
To: Elie Morisse <syniurge@gmail.com>
Cc: linux-i2c@vger.kernel.org, Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com, sandeep.singh@amd.com, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 12:13:19PM -0300, Elie Morisse wrote:
> MP2 controllers have two separate busses, so may accommodate up to two I2C
> adapters. Those adapters are listed in the ACPI namespace with the
> "AMDI0011" HID, and probed by a platform driver.
>=20
> Communication with the MP2 takes place through MMIO registers, or through
> DMA for more than 32 bytes transfers.
>=20
> This is major rework of the patch submitted by Nehal-bakulchandra Shah fr=
om
> AMD (https://patchwork.kernel.org/patch/10597369/).
>=20
> Most of the event handling of v3 was rewritten to make it work with more
> than one bus (e.g on Ryzen-based Lenovo Yoga 530), and this version
> contains many other improvements.
>=20
> Signed-off-by: Elie Morisse <syniurge@gmail.com>

OK, there are still some parts I am not exactly happy with (e.g. the
find/match_device mechanism), but the driver seems to work and I don't
see major blockers anymore. The remaining issues can be fixed
incrementally. Hopefully the driver will become more visible now.

Applied to for-next, thanks everyone, especially Elie!


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyY57sACgkQFA3kzBSg
KbYxyg//QUXfuBk4tLCzSfFI0a3XLH6nmMw1M0/P7AB51RmOzXycsof23GrJsRXM
LiWyD+czqk9ts+nsDVrgKoTyON/WusdvX13QbiVLOV8kWrsS43rNvDZSXjL19Y13
G/aeGkpfyhEQ8x+qs7cxYNabNDX3RhigUFElPMydjs0HDNG6CodQICDWCRbCFC5B
wk0FTYHMLYAYTW9sXb9K6QYDW8EQgx/iwGdEC8A1C6DeI5zAfIgsMc/YdTtnLjbi
XF7YUsp30qwevUUN9VBN2sEBqCBVXqNdpJ8WoyzDLm0fZTpD54dWjpibmPELc0xN
ITtJmRwJOGUKY1mtYqDTD2zFuqo4iOza9gkm1PdhJnzjyrheObLF5ZPGkNRPuE9Y
8eGWP6AUYMgiMQT7SrWKIw9f958QHoMLJK5p898eIcdlJIeG769RHUhWqc+dwf7M
BGBywRXcyEMd8+ohN0mlaEKZDzYTEthVyZYPBITxg40mBv6XZzdKr4pACixvl17Z
d71xg8mRZe5j0NLsJE+txQe09LP1UBqRYAoP+lK8CEf6pSDeua3z5edsjKO7XeRI
55wuvU9wxsltltv09LCCyffrg6Y3uQt11tf24jpDzMI1rbth2zyZ6yastn/Ay+XK
l7zLsA8ZEgnlM/0NwrC1iXD8fFVGxvrue5YWKFBZmGghKp5NXxY=
=jTqF
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
