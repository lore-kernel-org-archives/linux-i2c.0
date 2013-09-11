From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
Date: Wed, 11 Sep 2013 10:55:52 +0100
Message-ID: <20130911095552.GI29403@sirena.org.uk>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <3397524.g9aUWuArnm@vostro.rjw.lan>
 <20130910213522.GG29403@sirena.org.uk>
 <2029393.u6DaKBPszu@vostro.rjw.lan>
 <522FC0DC.9030708@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A1AeHK3WkQzeMGLU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <522FC0DC.9030708@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--A1AeHK3WkQzeMGLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2013 at 09:01:16AM +0800, Aaron Lu wrote:

> Looks like, it all boils down to how many I2C devices should be allowed
> for runtime PM by default and how many I2C devices should be forbidden.
> , and then we allow/forbid runtime PM for the majority case in I2C core
> while individual driver can still forbid/allow it in their own code.

> So if the majority case is runtime PM should be allowed by default, I'm
> also OK to not forbid runtime PM for I2C client device in I2C core. My
> original intention to forbid runtime PM by default is to make sure no
> adverse effect would occur to some I2C devices that used to work well
> before runtime PM.

The really big problem here is that there are I2C devices currently
using runtime PM quite happily and forbidding it by default will break
them.

In general though requiring userspace to manually activate power saving
features isn't going to make people happy.

--A1AeHK3WkQzeMGLU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMD4lAAoJELSic+t+oim9MKAP/jfLtDWtc+xh1vePSJpB1iDP
6FDiNmIpxf9Sa4o7J614lrEwB8FkBH2fhWkJXZVPsZZ0tI3n75uXfasJmwxDH9Cm
mfPK+Xl7gxss+qiHL/vhlGe2k+ti1bE7wprEE1MXZpGbgCuXPgvRyaZvpzMabqyF
DHiRqr/dVwaBIwNveMaaiwTLvbT83V+/MWMYCzVUl2xQ1LoDx52JsnyBDy4oLAWV
SimlDwDY4kHZP+mRoR5kZlAkNeKpHkGktJBQHvt3oyrXn9MzMQ98LlzXhL9X6jW/
2sP2t5pDf24Ch8WISUOHsO27Jybjdy2ZbRfhugLsGG5mMRjuqxliU0sHfrT5TIDU
nzXgIeIwPueLNiw5soFmbnr4X2wa8N/EoIxrkdS34lS3Zd45n3tXDOW/UsCKP2lZ
CZHcJqCbwxGGmBpwtqvs9OYC6bTtUUFzan2Dj7lZfmFSa2HtjZzHvVVXkBOQUFF9
8SMvjjZhFspxYP7vGGPdotxIoakWMwkkUTBZ9JiKTwyqC79f3a+TJW7UCCdj4Qwf
WzHASdUMu/sI8WburE/aUufuysVKWACcdzFkgX91u/b3Wn9NYdz5sAhm+rxWgmMu
xdq1sl7+hEuKTHO3og6mryoKDI80EgZXCsM1MBQe32cvhyuehCdAeG88q95XiGS6
WB1/8/y8XSVVUebhafYX
=SvlW
-----END PGP SIGNATURE-----

--A1AeHK3WkQzeMGLU--
