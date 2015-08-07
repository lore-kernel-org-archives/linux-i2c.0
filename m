From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/8] misc: remove boundary checks from bin attr users
Date: Sat, 8 Aug 2015 00:34:56 +0200
Message-ID: <20150807223456.GA1527@katana>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
 <20150807161055.GD25357@katana>
 <55C4D9B2.3000708@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C4D9B2.3000708@mleia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean Delvare <jdelvare@suse.com>, Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> if we're talking about this particular series, you should have them in
> your mailbox, since you have them applied in wsa/i2c/for-next:

Those are already in linus tree. I mean all drivers which use struct
i2c_driver. Or do you prefer they go via Greg? I am fine with both.


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxTKQAAoJEBQN5MwUoCm2EWIP/RU7JTgjtGACCq42fx0JqEN1
ta9GKrK1LCbdJtarMgM2JguNFCNEM5ZXBzscgkmC1n1qCGCXTIKI3mpSpUa6jadJ
sI0Vc+EfM777WLTQAxz/j5ZR7qFR+b20CRrwEQCIt4/9UlNsbYZkDr2hl9TdVcDq
L5oePCyfPqHXHF5cvdC1XZqGEkX1xzZTKBnxxMysRJ1FnNNGfj5l/fHZJfNgXqQr
hiWRXWrHkuGi2whXAcniBbHZ6/WR7sIkhLSR8LK1SKCj1RJlNc73QoGjf8DR4RqC
C/g/TzWql4Tp1mthq6yfIloIRbSJDyzxJChMOPouQB2yFIH/nxS+vjfDBPE4vgbF
7/Pzx8Wp463VihqJnW8lbrBgOKHnu01s3aSUED2RyBIky47PSIneoL9QvIt8pH48
LDVfNpAGcFLPMkhtBl7oS4/e07iYTcN0zUSpVQSgOwpbRmKnHp6j+r8oznX8kNGA
D2nXMFCLghPvRdUr+VLcDnbTpQybkgvJwGlfGRsMAMQeajEaANNc4isAmUJCaPbl
DZqMic5mVM79YiXiJXawDGW+7FepZeVj0tX4kZAzkb1sH80f+HiwDtqn02oiftj2
0swhlCXF2lK8h3koO+M1qI3dcudeq6rQmaisqcy2lliTf/h2JxF6OJhkZX/mIhun
R3Det08n+d4+j8VdnwxL
=qjG3
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
