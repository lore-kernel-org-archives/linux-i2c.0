From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
Date: Wed, 9 Sep 2015 00:08:47 +0200
Message-ID: <20150908220847.GA1529@katana>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
 <CAD=FV=VuyQXNGt7dgF-YF7D7MDu31B-QuBdGpeC_+0b1F2=dKg@mail.gmail.com>
 <20150903091900.GX21084@n2100.arm.linux.org.uk>
 <20150903093910.GA4151@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150903093910.GA4151-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wolfram, do you know of any cases where adapter->dev.of_node would not
> be the same as adapter->dev.parent->of_node?

i2c-muxes, I'd say. dev.parent is the device of the parent I2C adapter,
while the devices get populated from the of_node of the muxing device.


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV71xuAAoJEBQN5MwUoCm2MGkP+wXYU9dhfuxjary/OvmkbAX7
FXvPTXkxCsdMm0xW31Nnbnesci5Uftscl0/KnNxRL9XJs3AmhKfNkmoZ8rT+I7P+
bm3k6DRRHdynwiUcD9NbZuuMZQkRYia1GHZwOJyQ/KzbIbko+UkhWXkQdWH8voCd
L4qEDqmkwdM1xpwLcpe6xUf9PSL2ZQbsKwZjwCEr1q/RimI9F0n4TQDYI30Sgx8B
Hgcj4NhzRzyb3NGcdD/m6MCErIDfg3iSrDYcD1k7dhG++JqU3Rp/9VmsHkX+TB4z
OQ43LFPQgDJWwTUUgm3Yc/Nvmk5XmBfJJL9N7mpSNZWmUqPauyus8ENYEuIE/Mdu
LmLtNZHSB057JZ5aOMInN5rsBNs+JkevFEv8Ps8+ex9BpnvCJqgUHqtDQaail3Os
K2tAtPhLozpEXImMdlVk2XFWwppaL9oCwPptP8fy6SErKObxZXn20BeneW83WoMq
TCDKBN+ePkCwzLknR2HLsy2nCXFK3u2uwU51tBkbUecldnHws/ZCnngoaJySlfAP
RrYdT1ZxLT6OazmB086/uM6tG2TvkfONtuf+MEjFZwpi0NgNV1UQa5eu26CLEK2m
JS7ty8FUIuVOntbrZxwwnDr2aQ38cWTzT9dKM2j2WNO9Wcl/VCwTt4TvIh9w62gM
u7J5GyUVQ/HRG6XnhxXP
=/MO5
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
