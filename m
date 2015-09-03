From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] drivers/i2c/muxes/i2c-mux-reg: Change ioread endianness
 for readback
Date: Thu, 3 Sep 2015 11:59:09 +0200
Message-ID: <20150903095909.GC720@katana>
References: <1441212046-2976-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441212046-2976-1-git-send-email-yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2015 at 11:40:46AM -0500, York Sun wrote:
> Reading the register (if allowed) after writing is to ensure writing
> is completed on a posted bus. The endianness of reading doesn't matter.
>=20
> Signed-off-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to for-next, thanks!


--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6BnsAAoJEBQN5MwUoCm2PjoP/2gi4VIOtHl8sTAszrYLoXDI
DJjy/AaRxHzHXMXfMD6FRfN1WQ+oev/9jwmGNZiwqcgUEr/aVC4Gq8RUD9eYfgYl
lrguFytA2FJuc2TMhSX+8piwflgnEA+DCRFatawHicWhahKY1S5qsqfYJY0tlwir
F/+v2fS4S72zcPcMviRJI9ypeaoGGklPCfaLEvdoAmoNIXn7VsHyMLC60OUBduV9
VLXDNArF3HjFA/9EiY9O2w+v9kJC6Kqo8J1fvmuB7mjjEnOrevyjqSKylzQK0b87
RVKZbJU6Tpn9KTR8kgt3bisDZwJPSqmbw378Xu4l0u9sEkwlC+1xuVotf+s9z6Mn
wieToqktsEFxRJrBla9oYkyJNrVEZmITGEL1RBD4ZQ3G9ScgbD5EC2ANiOlL82cu
wg5z5mAN/2l+QWdugGVxRcUPyN1oa55sbQrGcN2mt7VpxkHkoIXNwuaoqNsmgAcR
9NeaDADz8DCQA2YUXwWG2r7U9cbYpdqNK/xwV4jbv2MF8Y4WMK4lsLI+GWbknWFz
V6gq7zq3RQI/Ndz7dLjuYiEF7jMsFgYco+0l4PGutQBGoECEdomlB+yVcqkUI8zc
/1DWS9nMae6KvREBsytT1VuPS68VCPGbEWWOYlHG7nDys9hkOAaR8gQ2TrNeVXNR
hTk9ksVY3mZ9LEd/gSgy
=Bvah
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
