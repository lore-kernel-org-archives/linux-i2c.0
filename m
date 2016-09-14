From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: RESEND:i2c-eg20t: fix race between i2c init and interrupt enable
Date: Wed, 14 Sep 2016 09:28:09 +0200
Message-ID: <20160914072809.GA1417@katana>
References: <1473240337-5694-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44559 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758116AbcINH2U (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Sep 2016 03:28:20 -0400
Content-Disposition: inline
In-Reply-To: <1473240337-5694-1-git-send-email-yadi.hu@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yadi Hu <yadi.hu@windriver.com>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> after testing last patch, replacing request_irq() location is not a
> good idea,it might produce a little time windows ,in which the interrupts
> occurring inside  will be omitted.

To give you a little feedback: I think I liked the previous patch
better, but need the weekend to think about it.

Thanks,

   Wolfram


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX2PwJAAoJEBQN5MwUoCm29/YP/Ra1b2QruNjyAhBCJHXM5fdg
e4/+NciWDSfGsenCxD5XjjAjsKsrNKRPFenAzPgqykNJ+9OgTAn9p8/yt6rQMfcC
o6GOMiSTDAPH1zHEPNLNQdXGYdjW8XlQtdE2RDGH+EOPxGrTrUPvk+EWcfEPi3MC
3HmdEM5kbBihh+odhfcrlUK6PmiHAWsrLhCiOTbn4n5+HQFl+chLrrBpOcsBfUWM
t18XPZFXymz1c4phJ+MC56DPd34/hZ5gQbwxzBXmo2XV3Ga5RVUz9+xaUtWVNWXV
uN5U8BvAzuWDNIJ1+6zdv2HSJsDk6Sayq5vjyT5djUXFtZawQfwDnyRHlJSaf2R4
yKzxuLeDc4+37OAiCozCYt4EkouvcsepfNW60UhH98svgCUj+wNILhrKbnFGju2A
p/1Shae4kYVdPm0yaw0IY/+IauGMyv3aiAvcdD3fMquFXAR+GkuM4wF4ktJwlIHT
GnhcrXBlDEqBInuz7E14T6ZyZ7VUWT7BU/qRYNYsW53PG+3W6kqrAU98t0cef4ce
KwH4pTnKXdCb99KcFsFOp/mrNu7GWmcDovBuZGWAPIckrAiPMPN5NlEKLp5HrNMF
n/a51FyfRN8XWqGOZBHfbvegsxpGIr/PMUTRZBua8SA96PuwZQRHfn3exENpMKJw
S5cAiFUNvFW0aKDTe6bd
=We6W
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
