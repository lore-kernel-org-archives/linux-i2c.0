From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: next-20160314 - crash in i2c_dev_init/bus_register_notifier at
 boot
Date: Thu, 17 Mar 2016 21:52:25 +0100
Message-ID: <20160317205225.GA1482@katana>
References: <5769.1458226791@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58210 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030465AbcCQUwc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 17 Mar 2016 16:52:32 -0400
Content-Disposition: inline
In-Reply-To: <5769.1458226791@turing-police.cc.vt.edu>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2016 at 10:59:51AM -0400, Valdis Kletnieks wrote:
> Seeing this consistent crash on next-20160314.  Sorry for shortened trace=
back,
> hand-transcribed as the crash doesn't get logged to /sys/fs/pstore as
> expected. next-20160307 works just fine.
>=20
> BUG: unable to handle kernel NULL pointer dereference at 000000000260
> IP: blocking_notifier_chain_register+0x37/0xd0
> ...
> Call Trace:
> bus_register_notifier+0x1c/0x20
> i2c_dev_init+0x9c/0xf2
> do_one_initcall_+0x99/0x210
> ? set_debug_rodata+0x12/0x12
> kernel_init_freeable+0x1b3/0x240
> kernel_init+0x3/0x100
>=20
> 'git blame' doesn't seem to find anything relevant and recent in
> kernel/notifier.c or drivers/i2c/i2c-dev.c.  Does this ring any
> bells, or is it time to bisect?

Can you try a newer -next or apply this patch on top?

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/patch/driv=
ers/i2c?id=3Db980a26d02d1f54be31346666222304fcd27ea33

I think this should solve it.

Thanks for reporting!

   Wolfram


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6xkJAAoJEBQN5MwUoCm2/zUQAKxPbYfxEmiUH3uNPdnssOtK
1W2aiu4QHBnZqKloCH2Us+cvxMrm0z+VH8nbLwpakl1257B5jmxSDn9vQBFcjx3u
iwvG+12GmQ/dLRBYoINLO/mne5sroEJwZCRCPeaOP2P/hrAkUMcJvsmRlLumGcb+
zvYWtTNtM0CI3VRmcsksp5THCdx5BC5+iN5l5dM4FI/ESQixaBIDtS/XII3LhVGM
O1THxqR2cfoMO3/GGq5f3Csudu9JtZ57hvnLNflO6jWP7lLIZh5xkTgkMVz4slEL
TMjih6G0qUPQZDu8qR+x7zV2M+CV8mmTlh4jo7sO2lUcG2oPk0a8Z7YkL9plBq5s
/QWqZOk+CcZX+rQ7gtHgmyP73WKIxkDn9iGzRmTbdKAEv53cdnS1bKR7Bw1ijjr+
9sNE378qdGn+47b6VxrJuKECNcOOzMFPQcdeEfc33b6S6knIaqahUj4/kJ0W2Iz2
37cAgny8WGSgize5LrXvX+LPjWF3tQOpFqQ7KnXlqWx9GTByMqexUp3Roa75lwFG
kvKvFmsUNx9/+Yhd/vS4gR3HgaFJ5HHNGPC5BgNguFGSQLRJarU70kmGzd3bWUmp
HG5T3C2ZI8I2l8Iczfh2OdduBe5dvdjUbZqxdfi8Ft7VNjYt2SkLc+zBcr1OBMXa
P1NjEyVhuD2ZDTZzhGR8
=RQSs
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
