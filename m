From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: enable i2c device to suspend/resume
 asynchronously
Date: Tue, 20 Oct 2015 17:02:00 +0200
Message-ID: <20151020150200.GE5379@katana>
References: <5603978F.8020403@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43255 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbbJTPCH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 11:02:07 -0400
Content-Disposition: inline
In-Reply-To: <5603978F.8020403@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2015 at 02:26:23PM +0800, Fu, Zhonghui wrote:
> Now, PM core supports asynchronous suspend/resume mode for devices
> during system suspend/resume, and the power state transition of one
> device may be completed in separate kernel thread. PM core ensures
> all power state transition timing dependency between devices. This
> patch enables i2c device to suspend/resume asynchronously. This will
> take advantage of multicore and improve system suspend/resume speed.
>=20
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>

Does it always work when say a PMIC or clock controller is connected to
the I2C bus?


--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJldoAAoJEBQN5MwUoCm26NwQALLbUlHLAC+G5XZ7wmETZj73
tIlayE846j/T7HijGz/29uVfbLvS1ElqSAbnJ79RJDjpb6Mq5+URlNsmpY9MQbMi
LhtbkTNWBJRf7u8A5nSaJeoi/jdLY0HFQyIKHKrjh4zht3IVJYTjfbGL+OgWLCad
84GRn5lDSWxg2UAt33XsXx7bi7t6naFOGn5rS1jKW0AN261vvqn5wbmlHoRPFPbI
K4hpqzMgJrgnx8DooFE/eEiP6gHpAAFH/xChNhXOxveYpz72F94e2eD/m9UyyRjl
3rGGiZbyP8UdqDP7M/WPBJZQ2bnJoDjyLVEmqtcttcIgBdtFj89YzU7HsejeYHNe
8oahqFwo8TsLxGd9aZMVKkg+zAoovjQ1E/R87BCXWo+NqREu9Da8mrbBG1e/qYc9
MgbuJlLRGp2ioq0+uscKbD56Va7XC+pX29O+eHq+0LFbKmo3S0tuVGkfXuIn3mIU
iyzDYOyjCd37rMnUQAZ5jPm06noj4OwxHdbecSnuS8B19RRUMU/3GsKWXZr2i2GJ
ftwq/OXRT8xhX8WMsXYa8sMnCxLd2drNz/C/GmNRtIrhGih0lkrYjHmnTNvuuW2+
GoQBCLmtsVDKaB4Y1FWvFreaiKeIA81PcSkSmVY7g8WCXsY25198a/AG7KtYGGeO
uVcVY6TRYv6iGll90KlN
=ZH6E
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
