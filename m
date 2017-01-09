From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] drivers/i2c/i2c-dev: Fix kernel memory disclosure
Date: Mon, 9 Jan 2017 15:48:01 +0100
Message-ID: <20170109144801.GA1555@katana>
References: <1476190348-37589-1-git-send-email-vlad@tsyrklevich.net>
 <20161025094512.GF1597@katana>
 <CAH0z3hP9NRf87WNmtQjXKW7u5ZN=0rcwUWBJvHGFeSywRNvUOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:35194 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033886AbdAIOsG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 9 Jan 2017 09:48:06 -0500
Content-Disposition: inline
In-Reply-To: <CAH0z3hP9NRf87WNmtQjXKW7u5ZN=0rcwUWBJvHGFeSywRNvUOQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Cc: linux-i2c@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 05:19:23PM +0700, Vlad Tsyrklevich wrote:
> I apologize for the long delay, this reply got lost in my inbox. I've
> added an updated patch below:

No problem, thanks for doing it. Looks good. Can you please resend as a
seperate patch (not embedded in the midst of a message?) Thank you!

> i2c_smbus_xfer() does not always fill an entire block, allowing
> kernel stack memory disclosure through the temp variable. Clear
> it before it's read to.
>=20
> Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYc6KhAAoJEBQN5MwUoCm2mmMQAKnFpFn1aq74rSJ7v/2hwXfL
rP6qgZRn6STbaul18MQJV23U8XEVfnF7t4KpbZOmQcUepi+fvDatRPqfqh6OKnMA
Dk36u6BtbweEHqJCqm3dydmjY6gIo3dfttYgCqUmzInJyKoK2HvEoWsKNv9E0x4E
/Cahkf6NmqT7jl/rR3UW1OOL+u7nK0FmQR9QQr/RkwsiJHNuEf0U62L6ZypQDrrZ
ODWEiE/nGAw7gtaLbMwW3DEOKeuFeAILBadx8tldZHjLktCyCuen+ebAbq+p7QJF
Y7n3TdiDEIQLR+oNUcft0KHrqNL/RwKouCfR6eqhM8FTtqRrSnGr/YUhxljFGoxd
0V9xQ3dnYznj5jTFDtxfO7IoJiIqmKIx9mIxRaWEwMGf8vXFHLq8AWFbFNmCQdhe
V2+POffJUJZEoNAJRr4hflL6ahwNHiwQux8EOR6w3lBZKxEKh8UE/vTW+XX9QMjQ
Tk5YngeJehdPTVGMoUzo11pnIgczUbYaBKn3LMZ8Cq2/eudXEWU44N8Th7EAGjds
gwAaem8sLTc36pFgXsmOysT7bqrg2F6zxTDTAz9nkSQu71BMsEQcaxX10pbXRd8n
zi8OLldnAdNea6rtKNFqty9jYarbmcl+GxLYH1Y6IxYEZQ++D0VHxVdJyfdvlXUh
st2chB6lE6XBWk7kNhA4
=/W+w
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
