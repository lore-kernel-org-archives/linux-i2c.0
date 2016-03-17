From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: next-20160314 - crash in i2c_dev_init/bus_register_notifier at boot
Date: Thu, 17 Mar 2016 10:59:51 -0400
Message-ID: <5769.1458226791@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1458226791_2528P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:33208 "EHLO
	omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932879AbcCQPAB (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Mar 2016 11:00:01 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

--==_Exmh_1458226791_2528P
Content-Type: text/plain; charset=us-ascii

Seeing this consistent crash on next-20160314.  Sorry for shortened traceback,
hand-transcribed as the crash doesn't get logged to /sys/fs/pstore as
expected. next-20160307 works just fine.

BUG: unable to handle kernel NULL pointer dereference at 000000000260
IP: blocking_notifier_chain_register+0x37/0xd0
...
Call Trace:
bus_register_notifier+0x1c/0x20
i2c_dev_init+0x9c/0xf2
do_one_initcall_+0x99/0x210
? set_debug_rodata+0x12/0x12
kernel_init_freeable+0x1b3/0x240
kernel_init+0x3/0x100

'git blame' doesn't seem to find anything relevant and recent in
kernel/notifier.c or drivers/i2c/i2c-dev.c.  Does this ring any
bells, or is it time to bisect?

--==_Exmh_1458226791_2528P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVurGZwdmEQWDXROgAQKJDg/8D++dVdosjqpej2Gx6ePkKJEtrQGzwDQ1
wOmIOCkASffDqIqy+XKsQjy+L9JgTIKzxKP+C4A50NdNpq6aE2NJMbzkGm80ltZR
Xh6DORHFI8BtY60lLkwysXFCTSJJO9BGO/J+iTZkffcGlG4tqzIY+4i63sAhU2v9
VlI2yEbiV0pMdqj0/1ecc5i7mK3yLn478WEHe57zpD1N4fbQltnbCZYEd/b9Gyzo
FQRykcFUpXS0gFh1uWffrEM95jpf2sY97aHBFvmMBbs+qA/dRWGf7q95Emib3vKp
yo8ySXVWj4d8hWCZ9s4q4dAaZUggEOoUnnAb9Ji9GxuvE145IKUBXLRkpen6K+G/
RDOuboNA9KmbL4DNaQeUeWFjI5kL6mf12bXpLZoKmqUj+w3DdTXJMwQ/R/yGURxI
D+OwK4+WxbAfhEhRSV3IAa5lhc1IqEHwLxYl8ost7pfny981M2cvZXWC1jflk1Bi
RLNgMl7IVKY/Da3qQrHlOdpCNPbiDTZ8nD+zeGIHiUbUqJkz/dTXRM3gDA2dUkH6
pZ6iI+B8UGcne1gtT6v120U48hIPGge7+uUbRbzIm7C0KjQVPnJyb5a643uSqtlP
H++BM27v+4xElkpwOlHytCIdT2eXAgwF+fSkzqzE9N0BzRGeUmeLoLBIkq6hVHAT
KUDTfQ4rKVI=
=W9HE
-----END PGP SIGNATURE-----

--==_Exmh_1458226791_2528P--
