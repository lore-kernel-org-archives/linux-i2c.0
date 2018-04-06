From: Andreas Radke <andyrtr@archlinux.org>
Subject: Re: [PATCH v2] i2c: i801: blacklist Host Notify on HP EliteBook G3
 850
Date: Fri, 6 Apr 2018 17:23:42 +0200
Message-ID: <20180406172342.4a2a3f15@laptop64.home>
References: <20180402122536.5083-1-jandryuk@gmail.com>
        <20180402123435.5587-1-jandryuk@gmail.com>
        <20180403211326.4907f1bc@laptop64.home>
        <CAKf6xpu4=kLuqZqFsxqFCzLMyLBZyi3C9W_yyssEt=56dhF6RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fi_D3D4OqpIVx+/SseD5T6."; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKf6xpu4=kLuqZqFsxqFCzLMyLBZyi3C9W_yyssEt=56dhF6RA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, benjamin.tissoires@redhat.com, aduggan@synaptics.com, linux-i2c@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

--Sig_/fi_D3D4OqpIVx+/SseD5T6.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

My boot issue happens right after the BIOS when the initrd should be
loaded and then no grub (v2.0) menu appears.

It seems I could fix it for me disabling  Host Notify + Interrupts with
options i2c_i801 disable_features=3D0x30 and then rebuilding initrd.
The touchpad is still working. Still testing more days if it will hang
again.

Is there anything further I can do to help? I can't tell when this hang
was introduced. When I received the HP Arch was running 4.9 lts kernel
and it already hung there.

-Andy
Arch linux

--Sig_/fi_D3D4OqpIVx+/SseD5T6.
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEErcih/MFeAdRTEEGelGV6sg8qCSsFAlrHkP4ACgkQlGV6sg8q
CSsIXQgAnnpv888Kyxh5T47Tb/5TqjrmL/yqssN9AgfmKtZgOgl6O66OhwwKRNnN
8iDT1OFw/kDHMwcElbq3yw1cxF2PUOsaaAwliATaNhJhg9ilqs5WNqiYcqqVluIa
QrP6cealS03I99a/N1KMNKjE9K52xjCSXi1xQjYYigARyXpzEP7vKsFB0zjm8EeM
wvjlSYY5zsrwbS9Q7Y7Io8pz37lBj+VIU9M1efz0kjKdcoLo1B4JthhGS6fGAwhm
/hlUZUcINs9N959aaCx/2/OUtC+vNYxtPgh0f61YcQhXAs4rZZgF2Sl9SPG59uYj
Sv34OUzq89u5kGVzHNtwpPNXe+LUjg==
=DiOx
-----END PGP SIGNATURE-----

--Sig_/fi_D3D4OqpIVx+/SseD5T6.--
