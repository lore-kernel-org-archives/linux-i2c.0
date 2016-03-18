From: Valdis.Kletnieks@vt.edu
Subject: Re: next-20160314 - crash in i2c_dev_init/bus_register_notifier at boot
Date: Thu, 17 Mar 2016 22:55:28 -0400
Message-ID: <3731.1458269728@turing-police.cc.vt.edu>
References: <5769.1458226791@turing-police.cc.vt.edu>
 <20160317205225.GA1482@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1458269728_3195P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35128 "EHLO
	omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751655AbcCRC4D (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Mar 2016 22:56:03 -0400
In-Reply-To: <20160317205225.GA1482@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

--==_Exmh_1458269728_3195P
Content-Type: text/plain; charset=us-ascii

On Thu, 17 Mar 2016 21:52:25 +0100, Wolfram Sang said:

> Can you try a newer -next or apply this patch on top?
>
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/patch/drivers/i2c?id=3Db980a26d02d1f54be31346666222304fcd27ea33
>
> I think this should solve it.

Confirming that issue is fixed in next-20160317.

Now on to fix the *next* problem :)

--==_Exmh_1458269728_3195P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVutuIAdmEQWDXROgAQKbog/+M4Q02o0jemxuvNNUtaEeMzWRad1Gm+tH
powWSno8oBTtpd/MKCrDFGewaRFZLmqYkltO+IuAflxKl8YirOHlkhuxjhsaXNAW
lTYiqaUUyZhv3BVr/x2GdsCJefTiUYHcHc3DU2XIwLS6YEVSDJwsjaYFUcK2whF+
EwXUEvFjpnlLImtAveisBXHKdz10c0X+0HmvmpdeUbclGwQWrI1O+zLdIqhMRxj9
nSpibR7kw+ytviNsTtY/BMY+t4udJXbgqE27+Hv0L6EQXWz7uwc5xWdXfDUUqOVH
cxoMYwwzuHc08XF9MLAIx3pz3j+FDOd/yCjpNOn064sLFJLs0VOZgP9YHbCeUOJk
tZqT4s9OVzWM4s95j9qU2pKBGLvpDzR/IEMB/mY6M9FzSuJVqlVmOZB54YWJROBz
NDijyBrVqzr0KF/1ml7Nl9s18X81xlliT5lbzfrmwBCrkHRJN3IzebGwVLZxeEY3
/YlzUDByR3QN+XjTf/KUAQaTyRAezTC01c++IfReGr+upQ4IBL+1fdKK4yKy7MaT
7eWhLcbP3IT2iBlj4WYUWJgTo7yP6aLyTJ6OroLBQgKrSaNu+twYsSV6g/h5zMCi
YBrjwm5AEpkkOVoxn3xSQUSqm5uMtInxgtxR+dVEvAig9aDQTHVs9ZMjPL4amr/U
QDa+YgIgL0I=
=yZUw
-----END PGP SIGNATURE-----

--==_Exmh_1458269728_3195P--
