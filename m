From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: another i2c/for-next branch
Date: Mon, 5 Mar 2012 10:43:20 +1100
Message-ID: <20120305104320.0bede668b3b054bea69b8f2a@canb.auug.org.au>
References: <20120302134305.GA19451@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__5_Mar_2012_10_43_20_+1100_Gwuzfncr9k3ligwx"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120302134305.GA19451-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--Signature=_Mon__5_Mar_2012_10_43_20_+1100_Gwuzfncr9k3ligwx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Fri, 2 Mar 2012 14:43:05 +0100 Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrot=
e:
>
> I am also collecting patches for the i2c-subsystem. Can you add my branch=
 to
> linux-next, please?
>=20
> git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-next

I have added that from today with you as the contact.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Mon__5_Mar_2012_10_43_20_+1100_Gwuzfncr9k3ligwx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPU/4YAAoJEECxmPOUX5FEnwMQAILk5eL7g1RB1otkNJRSsPwV
0ZbeTzcNjzYW9nkhmFPXZOnmR3N8o+asMVjqxR4WG6aYiVWkUACbuQL6/+vonYid
2XjU5+fbH6t2sh1HdfuEw14prfu0T0QjzrPCmQIgNaWMh/panlgeODVSdKoFTP7U
UjS4LdXhWGxyaRz1ly5Xoh17hefPlG++yTA3jUjHToyZ8KSG9JmH3JnDNzKlt/EC
/za8MK3mDIVsIMjiVzvL35YBHTdbfU+3V5vTVkfIxLH1FnKxKUjoKfGIzpoJNipT
NFthqVsgxYZsiRJJHhowXv2IWRzANRPzoBoiNXCR2JeBPesYEFMUF/BSOs1HZuVk
YvLgyRdSaFvK44iQSpaekdc0HlSBS+UeFuRSknxs30V5HSt2ezj7XFi9zXmAbXJ+
H0zCVvrF2OH8PuJc4IrjsWK7gnfzybOiHLORpbQKbYh4XW2FtlKtwqUarT3DQ2I6
tev+y8M8YpXFYA2+aH/cA69xXaZRKvnpn06y3tov7pGxMMvu11eJ9ykzDbniMeU/
j6Qx5DvkxvgZ2MEEv5uOsj6rokpslSskoeE7G0M1QZJRnZfDuuz/IB8vhI0htxuU
vm6owCtaEUluuixUPUGTWbhEYn65TSPw6yom1FCO41HKkG0wp9we9E+tX+SCgm4X
grIMJZt7LLeRU5Vhbnug
=IEL0
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Mar_2012_10_43_20_+1100_Gwuzfncr9k3ligwx--
