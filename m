From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] i2c: Revert back to old device naming for
 ACPI enumerated I2C slaves
Date: Tue, 25 Aug 2015 17:14:49 +0100
Message-ID: <20150825161449.GA5744@sirena.org.uk>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20150825052513.GI1654@sirena.org.uk>
 <20150825145756.GA4066@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1341723507603397754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150825145756.GA4066@schokonusskuchen.bad>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: alsa-devel@alsa-project.org, Jean Delvare <jdelvare@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux@roeck-us.net, Dustin Byford <dustin@cumulusnetworks.com>
List-Id: linux-i2c@vger.kernel.org


--===============1341723507603397754==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2015 at 04:57:56PM +0200, Wolfram Sang wrote:
> On Tue, Aug 25, 2015 at 06:25:13AM +0100, Mark Brown wrote:
> > On Mon, Aug 24, 2015 at 01:52:02PM +0300, Jarkko Nikula wrote:

> > > Commit 70762abb9f89 ("i2c: Use stable dev_name for ACPI enumerated I2C
> > > slaves") broke the lm-sensors which relies on I2C hwmon slave devices under
> > > /sys/bus/i2c/devices/ to be named as "x-00yz". However if those hwmon
> > > devices are ACPI 5 enumerated their name became "i2c-INTABCD:ij" and sysfs
> > > code in lm-sensors does not find them anymore:

> > Acked-by: Mark Brown <broonie@kernel.org>

> Don't you think there will be regressions given that the new naming
> scheme was around for 18 months?

That's a "whatever" from the ASoC point of view.  I don't particularly
care about the userspace ABI, on the one hand there aren't that many
ACPI 5 devices that might be affected and there's other devices that
won't work anyway.  On the other hand I guess there's other devices that
would have worked with the old kernel.

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3JR2AAoJECTWi3JdVIfQdc0H/3atV0RExfTiZSjfX9QA750J
ggo+xwE6rzB1/xXIR0neh8ZTbA7sQB/hYbk2CSbZ6a5AkNgsYRm9h5WULQVpekrY
Q6PxcFlLtNm11FOxJtuwJN3ik/3PvUOd9xOhh3BktcVmcUstipHesetvwScTeXwJ
GRPQ1yk8fXjIG7JhwGbA0mEMll/B94in+YEeRVqOMjyYYyEkbgei/U72a7CjIehR
umY5n4EPWBD703a4PmW7+FZeokn6EuwJn53JVji1OTr1oyqbfcREn5cAwKAn80fq
Yzb0vXBocdTE8Qp2PK6uiTxAWC67O8a19cdBQ2SETCbagvB70+1OzIkeVZRYFL4=
=W+uc
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

--===============1341723507603397754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1341723507603397754==--
