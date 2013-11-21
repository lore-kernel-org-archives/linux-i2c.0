From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c : i2c-ibm-iic : use interrupts to perform the data
 transfer
Date: Thu, 21 Nov 2013 11:43:11 +0100
Message-ID: <20131121104311.GA5013@katana>
References: <1384960134-24039-1-git-send-email-jean-jacques.hiblot@jdsu.com>
 <528CDAEC.3040307@free-electrons.com>
 <528DD837.5060005@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528DD837.5060005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Jacques Hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I haven't reviewed the patch itself yet, just noticed the discussion.

> >
> >>+		if (ext_status & EXTSTS_LA)
> >>+			dev_dbg(dev->dev, "Lost arbitration\n");
> >
> >Ditto
> I don't know if this is really an error. Arbitration loss wan be very
> common in a multi master environement. What about dev_warn ou dev_info

I think a dbg is okay.


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSjeO/AAoJEBQN5MwUoCm2rHUP/2sOyQAFaN/yryl8b9zZv+HP
HAgrMxDo3vzjQczTQ63oN3N9v/G7GjbQuMkPEveAhyecY9zSPaRYHg1eEVK6p7A0
tjAaI7mfdNfgw2UKI4MXj7OncOz+6RdEva93PYiAAyQNJ5NEF4/QOF8mwmVRj3at
bTER7rjHGne3g9PW7G4ZybMC0ML1rUTkNQ+FDxpcs0p6MJJxD6LojAnaxwgP1gK/
3t+CBFHU9hYjWJkEJyGiwd1+MMknl/ZxGL7sufUl5BPcFy7hxYp3RSAZm+EGuYdJ
teo+UcphyvQopqr7MmxXykhlIniZkJjkzae0G/ZJfNDmFaRu1oUjK+osM+qTyigf
kynQsv9S/y0o5gpAo6xfY23YelDa0Nxxpqd/GFQJKOg9WWziiZOZXRR8937leVfa
jzkI2E/wqk8R57aRvh5Yo2m+uY4yELn0bUoQtR31Fapgsf0mSltiQ01j5QtDQCPi
8Rwq6qAsBCzOt7yte4ElLG3Oy1rQZD5oWMWcn9wuUPFtAfbms4elQuKWDxxb6eKx
1jhpLqEJEU45/FE4aEeitR3f7qiUjyDFT+yWWaC2wsU5FSIzOCbLp5P82PyhmkpH
E5PGj+RnOLOQ62k4jlLkeSvthJp8Fa2+xUGaTJDZFDlNgz3BzMuBAQovx6No7El8
09OAbTV5ZDcuCI+idISP
=CyFf
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
