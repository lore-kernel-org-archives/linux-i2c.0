From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c: expose adapter probe and remove probed functions
Date: Fri, 16 Sep 2016 23:03:16 +0200
Message-ID: <20160916210315.GB2216@katana>
References: <1473108014-30787-1-git-send-email-david@lechnology.com>
 <1473108014-30787-4-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54632 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbcIPVDX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Sep 2016 17:03:23 -0400
Content-Disposition: inline
In-Reply-To: <1473108014-30787-4-git-send-email-david@lechnology.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The intended use of these functions is for LEGO MINDSTORMS sensors. These
> are hot-plugable I2C devices. When a sensor is connected, i2c_adapter_probe()
> is called to automatically configure the sensor. When the sensor is
> disconnected, i2c_adapter_remove_probed() is called to remove the
> automatically configured device.

How do you detect the hot-plug events?


--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX3F4TAAoJEBQN5MwUoCm2ascQAKl2Z7PQDbyEZbOxDJjw+vfW
V7PKIII2tKct8vZZ1/XRNkP3xHlVgnuQNR0/RMzkRBcUe6QplLh9F+NWh8EMDtze
q2zUiNIlgr3WlnKSv15pqwndP1G6ZTtuQOwx1b2ld2Ys7PWv7zExrGTy+X8beyUL
8J6J4fCQ/1NaL6R5kw1eUP14D7/d3Zr+sJemHA9oMuPmSmI89qu4GUDIrwpMtI/y
JXKjUQ6ucqz6Z8d22JaOBnyqxECmnJ1DselpA/ln7cSQYo4vOWIuN3rVcbrgcCV0
e9K3qCT1fbhtrBOfjauLN7Ix+qlSA96Vk6E1W3WHVhISQVM2C70Fgz8hQWFA98Sp
ZepDuKJEsSFx5gl/l5YA0x5U8Ub3ZoTOaRog5CeQdIzsJZWcsEmK8yKiVnad9F4h
S2o4meFsqRxKCBPem+uhrBbzUVYkj+NCmbWddaUwGFY94y+FZyfv4aTU/b3oNXAS
hFfWyKAoMDdpIttbUiDFnfEcLMqHZvMK10b+fzTMdo9VZsnwzlQ/g8zqnR+T7la/
EjluUn5q7RJme05hsSDHnCqkkcsKJlDoq+cqZijorbQRL0SBireZgtYDfbyVG1jv
2j1qibpAa/Hrisl/sP4JBevp06Hi+UxTjQ40lujqSnp6fnYaahLQdnx3Uh9FjfCc
LARYHsWlivRG9+AszDUT
=tSm3
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
