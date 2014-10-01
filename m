From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Fwd: [Proposal] PM sleep children of inactive I2C bus segments
 off Masters in multi-master systems
Date: Wed, 1 Oct 2014 23:10:47 +0200
Message-ID: <20141001211046.GA2368@katana>
References: <CAAVjN7dwS62EKMnuZc_P1UjkbRVk6RXqJ91GwWZ96bbY5Ct-rg@mail.gmail.com>
 <CAAVjN7eUmBVcAGPbcn3qsJ9M9uu2nkFoKHqGhhKGekZSceGiMw@mail.gmail.com>
 <20141001184304.GA6832@svl-evodev-groeck.juniper.net>
 <CAAVjN7edpkXYMHBm+wLegA_pc0hnm_YZf_z=Ni3h=EbDTmfegQ@mail.gmail.com>
 <20141001194115.GA6948@svl-evodev-groeck.juniper.net>
 <CAAVjN7fGRzyu7gxavJUay+K_Mm-0t1T_0Bysk6-sdaqu5=5k5A@mail.gmail.com>
 <20141001202058.GB6948@svl-evodev-groeck.juniper.net>
 <CAAVjN7e4nO579TfAJ5zMNe__Q9yU_-6naq4-0vm1rimespSrsw@mail.gmail.com>
 <20141001204302.GA7744@svl-evodev-groeck.juniper.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141001204302.GA7744-VN48AwQc75yrkUfnaQMJWRyWsx42SBjsMbKr+jor3Jc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
Cc: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rajat Jain <rajatjain-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Maybe you can find an error code which with some level of confidence
> reflects "lost mastership". Then you can implement whatever makes sense
> for your use case in your user space application(s).

We have a documented fault code for ArbitrationLost and that is -EAGAIN
(see Documentation/i2c/fault-codes). If a driver does use something
else, patches are very welcome.

Other than that, I find this thread very confusing. Of course can
another master modify the clients, this is what multi-master is all
about, no?


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULG3WAAoJEBQN5MwUoCm2pC4P/RbvbS/H65+KWbaMGdD6IpQy
kIYe6cwTXFrJYPT4s5igfoFmXjpSF6BB6cBFnziv9sPd4yY+OkHJUV4oNy9dik4v
GLLgnrHXGxnY3HjXEBZYK0o3t4FRnovWuSsXSW+Vfspfo/4CEq5Bns6B8C4ArxT2
ozg3wZm86I1HvzSBemH8ZwO01tIIvHfu3kupsqoy5+lC1kr8MWcXmXt6Mm24w+jl
dX+DJlvPvq+/lcdotZU3RdGcKvBKTteYqmDbti1g8U1GhKu40FPmllZECYI+K3kO
v0/mJVs/9rf9UQJx8cRNf3rmr9mV9PpDn1CKYKp32bfQwZgwjfn2w/J910dkM8dH
aF5NVrUfGpzZ+E0yuD0e1oUsUpnSuN1HWy2tvzy0TK+FZ81UP0ku8LHxgXoclL+1
ExrY4a8psG5fTA4XVDJrdT+MBxM3d0j3eIejMBlQYeKJ1Mgj1eMQ6FTkxNyQWKeT
qG9oj8wTDgIRDdtmmhQKtXfb4CJ1tjQ7daDxohxaCnQkdf9AtK4amZqI9O+tB3D5
/Vkcqo83m93nzUCyHHjWDb5P9OC+JRTUiVrEamKSwXcAgOIqoiu8/AMULZNE+pM0
RKJsPLtWtMIPdzrSQHcenYIosREJuvxezEtWRkmuGKc/zLFKORmPoRQgxzmqv48T
L9YeptF+SGSK6HRYjRim
=78pa
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
