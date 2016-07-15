From: Jan Kandziora <jjj@gmx.de>
Subject: Re: Introducing a kernel driver for the DS28E17 Onewire to I2C master
 bridge; Feature request: introduce I2C_FUNC_STOP
Date: Fri, 15 Jul 2016 19:27:16 +0200
Message-ID: <57891CF4.9010605@gmx.de>
References: <578612EB.1060709@gmx.de> <20160714095812.GA1563@tetsubishi>
 <57878B55.1030200@gmx.de> <20160714131921.GE4149@tetsubishi>
 <5788C54C.20705@gmx.de> <20160715112559.GA1695@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:52856 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbcGOR1U (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jul 2016 13:27:20 -0400
In-Reply-To: <20160715112559.GA1695@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 15.07.2016 um 13:26 schrieb Wolfram Sang:
> 
> I would say no, since it is not generic.
> 
> You should also populate an i2c_adapter_quirks structure and limit
> reads to 256 (and maybe other stuff), if not done already.
> 
Done.


Next quirk with the DS28E17: It can do an arbitrary number of write
messages, followed by ONE read message in one transfer. As there is no
"Read Without Stop Condition".

My driver code just ignores the fact there always is a Stop Condition
after a read. As the DS28E17 is hardly ever used in a multi-master
setup, that should be okay.

For the combined transfer the DS28E17 also supports, my driver code
checks if all of the conditions are met inside its
i2c_master_transfer() function and uses that function automatically
when applicable.


The current quirks flags only allows to limit the number of messages
to two in general. How to announce the behaviour correctly?


Kind regards

	Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAleJHPIACgkQzGZqmZvWQdkQFACfUYomuw8JYMdNqouP8sjpd6Nm
U5EAoJ+U6G2gDoZbJ+lGpIAGOxiTTJ52
=SCdT
-----END PGP SIGNATURE-----
