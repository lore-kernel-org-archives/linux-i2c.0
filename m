From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [i2c: dev] d6760b14d4:  BUG: KASAN: slab-out-of-bounds in
 of_device_uevent at addr ffff8800091b4c49
Date: Sat, 28 May 2016 09:32:17 +0200
Message-ID: <20160528073217.GB1714@katana>
References: <57493af0.akIr4abjopweDkBu%fengguang.wu@intel.com>
 <20160528071234.GA1714@katana>
 <20160528072433.GA1844@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51971 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbcE1HcZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 28 May 2016 03:32:25 -0400
Content-Disposition: inline
In-Reply-To: <20160528072433.GA1844@wfg-t540p.sh.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Erico Nunes <erico.nunes@datacom.ind.br>, LKP <lkp@01.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ye Xiaolong <xiaolong.ye@intel.com>


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> There will be simple boot tests quickly after the compile tests.
> However boot tests typically need more time to be detected, bisected
> and especially manual checked. We are yet to automate more boot error
> reports.

Thanks for the heads up. Could there be success mails for boot tests,
too?


--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXSUmAAAoJEBQN5MwUoCm2cQsP/1BaPo7dY4Dg3bWD4OXxK2iF
on/4wxd6TbvlO0f779pVVZZfXxhbkfME57wO2uUzg/tfbRHC9U29W4AazmUNQ890
Da0IEeyqd9y4ACExcIvDt6PSKBR8SLVMe6XGObwDT5cSsX0uHrKLofTZ4MPKUT/i
f1XeRm6oQgM8wmR1zT7tc/DDp1HrvBszvRJ+a0dNH0X/GtmV2d74quIExMyr1Xv/
5ALXT+PH8TPepBJoqjAV1a/lwi3+6nbpiezaK9C5G77WoIju7SGrsTAptgqLd8NI
2C7eD1/i3rP8mh6L7+QTAIwtgdlyfzi+o+8wNSvSI2JIpvJRuvXMJaTvp70aDFlx
xMPLl70Ojc420QpYp5LjoSpvnOcC/0LHWUgXBOyhuGlS6prZTteu+sM3pVGm84+W
lQjXMjHl/axCFspGHjG5rg20tcUB6bGY8izBbTPpOlbCX3tr1+1t9WcOuvd+j3iW
7HQZJqUuJ40yObo4xDawpLzAGrzYPuNbOUfMb9BhhavjD/I29Qjj1FfPlSTIVUBJ
fx+CfjXaok+E0qgd2+wtoesTMVQJ+bynSqXGNPAJilOktYCaDhb+CLmozkHQ2AK2
ky2RHGNWwjRnLYfCh3eh16uFPYjVD9eOn4VOu+ldMrd8SL/IEPXJpJfd0JrbzSCV
uDz/tbnMLP9/ujrD0jqD
=c32S
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
