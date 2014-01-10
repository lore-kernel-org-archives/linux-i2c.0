From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Add bus driver for for OSIF USB i2c device.
Date: Fri, 10 Jan 2014 19:16:47 +0100
Message-ID: <20140110181647.GA3186@katana>
References: <20140104222842.GF3150@katana>
 <1388980536-7588-1-git-send-email-andrew@lunn.ch>
 <1388980536-7588-2-git-send-email-andrew@lunn.ch>
 <20140109214930.GC3866@katana>
 <20140110180154.GK9681@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140110180154.GK9681-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Emmanuel Deloget <logout-GANU6spQydw@public.gmane.org>, Barry Carter <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> Hi Wolfgang

Wolfram

> So is this a zero byte transfer? Is that not what i2cdetect does?

Yes, you can enforce it with -q. It will do it for some addresses
automatically and complain if it is not available. So, seems to work,
great!


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS0DkPAAoJEBQN5MwUoCm2CnoQAKMiI+szaqk99+Fwk90KiwAj
cCeMGuc3UcZXcNnGIdNj/W44Pv8kb2Ii0svMSbHdzpiPvnRbwsChRSCkHtGSx08G
hUOF7VPQU3ui4TP47V8+jMbV7dlLRbsn/sy8eh0qpYOR0BePIkrk2xZDiEFGt1Bf
8QMk8sarowubk2ZOGDXTl26/rvnvuVlXoUO3aua/Izgzje/gaeZkM4oAejMMCzVG
ULYEtUTr2LZAcrtURO7NtkZldQpD1ahC7Eryb7M6Zuyp98428FV+ZCyfevz81yD2
Gtcj+4wdQEqabq/nYaZdAc2ZL0xaBmCwYJAXfpUdp/Xyf1dHYUtjz0uujLr6tj/9
N58Ca/437woM8TgRqq2gxkVBF1nfHY5sVLEi7UpY+2198TrZ/jiqf7qZk/adn5ob
Uv6krHkD//QDuqsR6Wk+HbhSPArRCwL36R2h1t6iz46Bu2J7CIi8LAWCmC+OoOVN
Y8/5Hsz5+OPj8DuiNK0UHVLk6KJyM3eaTZVRvUtuTppeDrjUL+PXN+fPUV69zM2O
1fKrguC2XO5rguQDdB77bjPinL8o+KL+BOkX9So3Uw8xyMXrxMJSsMTNVuAWFmMn
fVnBQA7ybNC+wnMEIQUF4hz7E3TV8aMblYOdZMHhDk1txi7xFiZo9WPUhSF6+0MV
mwqNrhlxVvktdXrEbqJs
=t8HL
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
