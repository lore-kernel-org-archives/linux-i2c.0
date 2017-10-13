From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
Date: Fri, 13 Oct 2017 20:46:46 +0200
Message-ID: <20171013184646.cy5gmpwrxbacje3m@ninjato>
References: <20170916030252.10680-1-amworsley@gmail.com>
 <20171005120125.nnhomwg2e2twbaqm@ninjato>
 <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6f4hrvueqn5pdfmm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41558 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbdJMSqr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Oct 2017 14:46:47 -0400
Content-Disposition: inline
In-Reply-To: <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andrew Worsley <amworsley@gmail.com>, Harini Katakam <harinik@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org


--6f4hrvueqn5pdfmm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2017 at 04:32:29PM +1100, Andrew Worsley wrote:
> > Thank you for the bug report. I don't know the hardware in detail, but I
> > am a bit confused...
> >
> >> ---
> >>   This bug reliably caused a stack corruption when the hardware provid=
ed more data than
> >> asked for in the i2c request. The hardware (a tpm) very occasionally a=
ppends a burst of
> >> 0xff to the end of the data requested and the i2c interrupt handler mi=
ndlessly copies all
> >> the data right past the end of the buffer and in my case across the st=
ack. :-(
> >
> > ... because you as the master should have control over how many bytes
> > you want to have. If you are done, send NAK+STOP and the message is
> > over. Is it really the device (which one is it BTW?)? Or is the FIFO
> > handling of the master driver buggy?
> >
> > Michal, S=C3=B6ren?
>=20
> Just a quick comment - as I don't have time at the moment to look
> deeply into the driver at the moment.
>=20
> I was just looking at Ch 20 of the TRM on the i2c under Read Transfer
> and it says step 4 write the number of requested bytes to the Transfer
> Size Register.
>=20
> But in the code it talks about a work around for large receive operation.
>=20
> Looking at the change log: commit  9fae82e1acda
>=20
> Explains for transfers > 252 bytes that
>=20
>      "the transfer size register has to be maintained at a value >=3D 1
>=20
> So my guess is the code is trying to keep this transfer size non-zero
> and so just keeps pulling more bytes our of the slave i2c device. I
> find it is hard to follow the complex code though.
>=20
> My buggy condition was a transfer of 128 bytes so it is not hit this
> condition except in that the slave supplies way more bytes than was in
> the original i2c_transfer request.

So, let's add Harini Katakam to CC who implemented this. But I'd be
happy for anyone from Xilinx to respond...

>=20
> Andrew

--6f4hrvueqn5pdfmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhChYACgkQFA3kzBSg
Kbavcw//Zj5TS5pfc7dA6lMSUJ/Rh3JKBWW9m0e1GLi6cykYksqVd62i1q4yP1TK
TicXMjRtZa3oebF3l2EhbdkmLHiD9oldr5VgEuyq+0gC656ECNsfCPsynauTxHS4
SaM7pKxnoO0/ICGJA3dDPgHJScGXJl2Sn5NtGnYUw/tEgTGNfEqWZHhv5Fmsmayr
B2Ba1YG+KFqvNuGljmCXGr76c3kWDNrKkctHn0Lh3qMqqrozVMBJmETUebUJcRAp
dc6DCcIIq67tlUy+XHjVJqgwXrJzxsuaT7sAm3k+ECjEobwpn4ToWrJH44yUZ6G+
gF/PvgHE+V8GVoZb4uvm+Y/9OYuVBBJpWW/mVzKIaa0GTC4ad1z4ifm2PXxVt9hy
NA3uSFRUI4zjJ20JHOzhE8BMZIvZ0qSpMiSx0l7jfX8gNeXf0xHVfWhl1Y3TeTX6
24VJ6jmYjh+IxXl1/d7cSgQW7tAVCQN4jl+208BpL5koeX2Ccx5pPRmu1e2Lb8Cc
AW27UvWVq3Vbi9GWNcp7Iefa2zbAK2+h/UfHXsDjvUgxk9Q9vOtRPB8TEgdcmk4g
djhReKdk5YNomJRKdiTDobdTeYsgvNoaEJP9dn5TdWZKrGo/RFk8Yvntch/MEj0y
8bTgSIe/kpda7ddgmQ3ASzWhiAP1pjsP/iYNuVvo3MSpKaAQzvA=
=hwx4
-----END PGP SIGNATURE-----

--6f4hrvueqn5pdfmm--
