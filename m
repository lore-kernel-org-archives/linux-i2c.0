From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c: bcm-kona: register with subsys_initcall
Date: Wed, 5 Feb 2014 10:08:18 +0100
Message-ID: <20140205090818.GA2614@katana>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-2-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391516352-32359-2-git-send-email-mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 07:19:07AM -0500, Matt Porter wrote:

> Voltage regulators are needed very early due to deferred probe
> being incompatible with built-in USB gadget drivers.

What does it need to fix those instead?


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS8f+CAAoJEBQN5MwUoCm2jrMP/iAt/1pOvXO6wzRAhEAkgd7+
9CYqnCEJNQputd/wgGOcpXOrOEZBu4eNApKmBu7FErq6Ilrlj5bn/Ughu6/qRS20
+LwvjYd0GGNpos4JOQ9aJCefMPinj6M3Yghw9rfD67a8f0qTdVjamwehk8mjDwkK
KOiz2f0ipcL3emm32JBZDkrIG/mFj8FId0VHNS51HJP5bWyf9VITwJygy3mlH8jP
QKQMfRtr19bVpzyKgcpxm6cT1G8skjSJY+ZJBA/FNK+LSMeQIrrwJD5JI8tviB9R
lI+w0H9RDel15yv+uDcAcNY8AJ36rAbKTPw9VObB6CRbz3qLhPg99SA3YF2h2+3F
/FESjXlmaZHBdTQ9iIdaIk65a0qrLIJ2HHje3hvNoKp54yjcDVugdBHfuRq/a8pU
cH9qRauX5mHOon4oTI7q/8e4TR8LgxTeHZ2hoDfFyy8EqvHpBdlTgnR1Qt8kJku8
7LqDbAIJrMEYmgbZmJKHopNUOEu7oUxt4XYnTxyIarxbIkGzt1fMwg+/dJSnF1uw
CLSfwdF7Zxrh9Ms/AyBR/og3uggVKARAMIxEpj2qMTJqotaRIqIxR/WFwoA8WR9+
+4TJC5moZH6dZFNR62Cv8b7oV3QoSzFDgkv007btur25MFMZ7oh56689KHUMXrq+
SPVMSgHQnnB8hx8bkAxY
=uyoI
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
