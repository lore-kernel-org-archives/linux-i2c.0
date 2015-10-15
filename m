From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/6] i2c: designware: Remove interrupt clearing from
 i2c_dw_pci_probe()
Date: Thu, 15 Oct 2015 14:01:15 +0200
Message-ID: <20151015120115.GF1546@katana>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1441031493-18938-2-git-send-email-jarkko.nikula@linux.intel.com>
 <20151010075337.GE1619@katana>
 <561B960A.7060400@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38225 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035AbbJOMBT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 15 Oct 2015 08:01:19 -0400
Content-Disposition: inline
In-Reply-To: <561B960A.7060400@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Although I don't think there is any need to add clearing to probe path as
> clearing happens beginning of transmit before enabling the interrupts.

Well, in case the firmware left interrupts dangling, they would still be
dangling unless someone starts some communication. Chances are small,
but better safe than sorry? Could be an incremental patch on top of your
V2 if you are up to it.

Thanks,

   Wolfram


--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWH5WLAAoJEBQN5MwUoCm2W2AQALT8A/oYSZCSAGqzE+VUdgoG
L/4ZaCPiYD9kNxQ9bYLQ9vZdo3ozNm/15zWxN+buB3Z+CWxHx6o66FC/Y1GErQiY
6H39UfmY2wvjkk1ShiwNiJJhPo3JpiNH+MRfoWlF1zX+8mRI7g/AJ5R/0vBbxmrs
GI0W7ulMSdHqXapF/zoIB8OERV58bbZuoXFjyuvYn5jr//Km+s+tlkH8ltHqYBbQ
gxmNv2IL3rkgQg54bZDIaBG9u7JDqC1f7Fh4kB1WPxKD1XNCWf8uvtFbwKsCuEou
24GsxEI86sug5vQyiMWDL4WO2jivFGmDLuG18gTkKgYwRvq49hXVtFnHgkqioi/D
WMim82EPcPrZRez0KPECdp/g9HsJ//wXvawpvRPv/dUiwMTAe3ln+86t20fZrCug
3oLMmsEbyCIMSo4eNZu4TkL59NuOAsZxEYJZgXqrike1puxzh5eNmy219V+zQxBf
P1iUIGqnBoWNQwYl2AFkOglglUIYRXS37V/LeWCmLC6MyQbzBmx648DH/CbfyMdv
6k+rKlH/et5iohcGdnEqcEJv8Su29QXch13q3up3Hq7Pp4Im01a70f9iIRaYySpF
oeUOkV5PviaRrjTwqbzW40qIo/641C6wcPUzbIcsgUaT8WEVT5zT3D5u1gZERI7N
0v2N2Ois9EYBVP1AwZ80
=AdO8
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
