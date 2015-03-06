From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/4] i2c: sunxi: Add Reduced Serial Bus (RSB) support
Date: Fri, 6 Mar 2015 07:36:29 +0100
Message-ID: <20150306063628.GA883@katana>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-2-git-send-email-wens@csie.org>
 <20150304172710.GA884@katana>
 <20150305182817.GB4911@lukather>
 <20150305184044.GA881@katana>
 <20150305220801.GE4522@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150305220801.GE4522@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> From that regard, RSB is a multiple device bus, using addresses, just
> like I2C. The way it communicates is basically the one used by P2WI.

I am not keen to allow everything which "is a bus and has addresses"
into the I2C realm. The addresses are 12 bit, whilst I2C has at maximum
10 bit which is rarely used, so mostly 7 bit are used. It has a runtime
readdressing mechanism which is not present in standard I2C. And if you
look at the protocol with no acks but parities, IMO it doesn't look
closer to I2C than to other two wire protocols. So, being in I2C needs
more arguments.

And while the outcome could be that it really makes sense to add RSB to
I2C with I2C_FUNCS_RSB added, it could also be that there is a more
suitable place for custom busses in the kernel.

Also, the fact that P2WI is in I2C is not an argument IMO. It could have
been a mistake to pick it up.

> So really, it just is more I2C-alike than P2WI has ever been.

Because it has addresses? I disagree.

> Good thing that we are not talking about a full review then, but more
> a philosophical discussion.

Exactly. This is why I wanted to bring this in early.


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+UrrAAoJEBQN5MwUoCm2CgsP/1VPiw+MOixlHld3Zzso5KbC
fBRxamSAfvYlCDnazXByLZy6CN6hEbQVpvrLzhcoqfJCML0jtD/7Vi9qEewvW23H
mye/uRloe9MQ8+kTpQpGrGv0nWzeybet15AIdSXgP1V9JQSUCTsF1+zPwF+YX+aY
aBITIhMFA1AYLzwdrnlrpOLRp2x6l9BF6132MLAF0FnPxjg7zD0limG5fKnOvlVl
56gYY7EP8na42gXi9e7WsCnFsCXGWz+fdISzHvrD57JgFH1TKArs6KAeZ6BOORaa
bXFg07JH0pivfL6D6YjC+Dx+PVgKoe3ZpRyUy4x7qXa506mzgfJrSZMcJ1IbP2Q9
ekXHAVTJf9vSXorvcJfjlYWtxEOmjEZSzQ553ysLlR7j8tJ4DywWCUMDNuAUDxeb
+maoA17mO55/ycY7Y/RSqw6L+IlVMutzmp8YAl57Eu3YfWrCCbdqSTlaQgmHG7ze
11pSTo3yquA7gd1a2CBLoxsEylU28f8sZdAAcsigOpmJ4nS66a1RF1S5LRWaMHf3
lFP6NVN3fWZRXysUahBe0FPAAiElV+Ur2Ai9ZHemU/r8ZOcxfjuyRr/iFARlAncE
AgkciZu5EgOl4uADJTlUE7S7cGKlsb/Q3ZpMj5nBBopsor0Fy73OLTI6e6Bouj0N
uykOVxL624KL5769OCBx
=wAZ+
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
