From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c slave support =?utf-8?B?ZsO8?= =?utf-8?Q?r?= i.mx6
Date: Tue, 24 Nov 2015 09:08:30 +0100
Message-ID: <20151124080830.GA1645@katana>
References: <CAH-Fpeogk6kFAX9NtE3kJvi97ag9utMhUe+S0-mSJBm3eQCpxw@mail.gmail.com>
 <20151110085955.GA1532@katana>
 <CAH-Fpeouz=DKaNxegRkc5X4VB5y4r0kT3EnqNdB+_MqdPUs16w@mail.gmail.com>
 <20151118111142.GC11028@katana>
 <CAH-Fpeo6R1haEb0qdw5merP5tpAhaEL7FKJ3HV6WFLfiB_B0Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48685 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbbKXIIf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 24 Nov 2015 03:08:35 -0500
Content-Disposition: inline
In-Reply-To: <CAH-Fpeo6R1haEb0qdw5merP5tpAhaEL7FKJ3HV6WFLfiB_B0Cg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michael Bachmeier <michael.bachmeier.linux@gmail.com>
Cc: linux-i2c@vger.kernel.org, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Is the recognition of IAAS a hardware interrupt (according to manual,
> yes)? I set IEN (I2C enable) and IIEN (Interrupt Enable).

Ah, I thought you had a question about Renesas hardware. I dunno much
about Freescale anymore.

> I set the slave address to 0x1c (chosen at random). The IMX bus driver
> is unchanged. With my external Master I ask for the address on the
> bus. But the IAAS bit is never set.
> In this test, I want to see if the hardware interrupt work.
> Should i modified the bus driver (IRQ handler???) or is this a real
> hardware interrupt?
>=20
> Where is my misconception?

Please send patches what you did. That is easier to talk about.

BTW the video is online now:

https://www.youtube.com/watch?v=3DJdQ21jlwb58

Regards,

   Wolfram


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVBr9AAoJEBQN5MwUoCm2utkQALPErK+O1XlBg9Hwl+GSU5Qw
/TgapeBT+uq1N+9HSHM340zqVOhLNCDQte2gDSdQlEdDtu3g2GuqxW6Ny2zI+yPS
gNbStawbSU+nqTdHNNTtz4q4IBs4dQqoSC5iqBLoIrNt5aJw403kX2aWj2JfQy/q
Cm1rxHRMZjkyu0jZUvFnuVTnhK/uRKzGJBQv+Td+U08zD0zd6K0JNi10zEVbsDMp
o9h2j9UlxNkTF2FAxAJk5S/XgM9EPZ5KTx3p9Qmgb0C3wD0H62HFAwHq2TyMU/33
Ow94Vvs1suWmm0aDkxSkgkxvpyRfOEidd6QErPsqxVayIgsFDxZ6VoFQRkWG7p51
O1gm5C1GgymE3Skt1TFr+7F0FrXdJqE5dbtC/kTIj7kW+iZsgF6F2pkENd0NCmQL
ldG3GQPb3DqFF5N5Vh9U+3wvqPN7SeG8GkklXeEAmL7Nz1BY0R+o/6N8SihY4oDu
zuOaj4g7W2k0MwNLt9paeZVfV21oXfziv46f7mk1FQyj3F1aETmw7nm+RV9FQaxk
EOtEDduhiucGFMcQE3sA1SI7fivbHx51wVwpoGCAaaUD3c7xW2rnejhhTV5oa6MV
wzIhsLTLa04YLkzTp9XqLnixTCU+xQJZnBiennfB+U4UmJ16usn0DYpLtgkFStyp
GbHzMT3r+gK/L/dNgpRX
=QvxX
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
