From: Jan Kandziora <jjj@gmx.de>
Subject: Re: Introducing a kernel driver for the DS28E17 Onewire to I2C master
 bridge; Feature request: introduce I2C_FUNC_STOP
Date: Fri, 15 Jul 2016 13:13:16 +0200
Message-ID: <5788C54C.20705@gmx.de>
References: <578612EB.1060709@gmx.de> <20160714095812.GA1563@tetsubishi>
 <57878B55.1030200@gmx.de> <20160714131921.GE4149@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:59626 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932511AbcGOLNU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jul 2016 07:13:20 -0400
In-Reply-To: <20160714131921.GE4149@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 14.07.2016 um 15:19 schrieb Wolfram Sang:
> 
>> The datasheet says it can at least for a write to the pointer
>> byte followed by a read but it doesn't seem to work.
>> 
>> - From my tests, it doesn't work, or it least it doesn't work the
>> way the ds28e17 bus master does the repeated start.
> 
> It would be really good if that would work. Having a STOP betwen
> those messages is unsafe. It won't probably matter for your setup,
> but still...
> 
I checked it again and it turned out to be a bug in my driver code,
living there from my very first tries. The DS28E17 and DS7505 in
conjunction support the Restart Condition.

So, please discard my request for I2C_FUNC_STOP. It's not needed.


But I have another question, this time regarding I2C_FUNC_NOSTART. The
DS28E17 can do an I2C write transfer without Start Condition, to
continue a previous write without Stop Condition. My driver already
uses that internally to do continous writes of more than 255 bytes,
the buffer limit of the DS28E17.


BUT, the DS28E17 can only do this for writes. Not for reads. Does it
make sense to expose that feature and announce it as I2C_FUNC_NOSTART
then?

Kind regards

	Jan





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAleIxUYACgkQzGZqmZvWQdnypwCgnrHFhOnGesAwn9P6qnrRA+UK
yZ0An02KMy1Z+vKB8VO8Pn0XKFXP4e0t
=Tqkg
-----END PGP SIGNATURE-----
