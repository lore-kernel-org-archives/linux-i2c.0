From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Mon, 25 Apr 2016 09:39:41 +0200
Message-ID: <20160425073940.GD1541@katana>
References: <20160415080111.GD1714@lahna.fi.intel.com>
 <1460992811.8946.22.camel@linux.intel.com>
 <5714FCBE.3060009@metafoo.de>
 <20160419124028.GF1725@lahna.fi.intel.com>
 <57162C4E.9090904@metafoo.de>
 <20160419131631.GG1725@lahna.fi.intel.com>
 <5716333D.1040106@metafoo.de>
 <20160419144027.GH1725@lahna.fi.intel.com>
 <20160424201437.GA2123@katana>
 <20160425072553.GK1725@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43920 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbcDYHjt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Apr 2016 03:39:49 -0400
Content-Disposition: inline
In-Reply-To: <20160425072553.GK1725@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jean-Michel Hautbois <jhautbois@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, laurent.pinchart@ideasonboard.com, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 10:25:53AM +0300, Mika Westerberg wrote:
> On Sun, Apr 24, 2016 at 10:14:37PM +0200, Wolfram Sang wrote:
> >=20
> > > The above should work with both DT and ACPI so I'm OK with the current
> > > patch. We can add ACPI parts later when needed.
> >=20
> > Just to make sure, I read this as an ack for the original patch?
>=20
> Yes :)

Thanks! Could you use the formal tag for that in the future please?
Patchwork automatically collects them and that saves me some work. (I
even have a keyboard macro for that and use it a lot)


--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHcm8AAoJEBQN5MwUoCm2u9oQAKlHFkE6s8t/taCZFBw0aVGw
e5y1pYDMwvjjxFVQnOwohOZtM+/aYKUQC6ZtYE/3hUj4bdFP01Un2Yz2Rq4bjqhV
3i77dy7Tj/QtC+Qp7OP4qlYJosovFRyiyL7wtmYioTH+m7U5lMYs7207psbgSdUC
ip+AsuIUV34jrPbwVYzfY8+Cu0SHWtc6qFkj8gnDfMhjxFPoY+gLHq/0biGO+7In
IKhTi5ArIgFA/fkIg96TlcAf6PaTVvoG7+VU1pkcCbPQYQ6vz1WCjrJzc3HO1s3W
04OC3yCTxOsq6fydynFcRKDosQM2zCWk/upkQ7MIx51kXiDwnpVUUS7+yu26fb6/
GrWdjYhOCSDqPTywb9eSBkS8MnRH9z31Dv5ALNsSPC4ykKnBfQLqnT959CrtMFWM
ft6XYtlJGssck/O3yEtGqjs039TRiabw2UxrfPGl2tNABUF9Zej5u62He7sWN6XC
hMjx8SxUnM/iEeNCeIGXaC/TM623M79YRNmR1xOJUdnK1ExQPLlOjKOTsLDVuE03
M2zF6/i+w2BHLcFk6X1arOhF/t45r5LhWxefBu5yPEIJddToM7+/UZfl5TF8MC6w
dVRWbLuj9/uWOY/uRsSlUmbN954ATYdLx+aGKudC29rJHpoMigHwy+Qx9YT3nVbK
T7NRvWAI05A6olXXOnYr
=N4od
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
