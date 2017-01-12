From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH linux v2 0/6] drivers: hwmon: Add On-Chip Controller
 driver
Date: Thu, 12 Jan 2017 10:56:43 +0100
Message-ID: <20170112095643.GA1477@katana>
References: <1484158237-10014-1-git-send-email-eajames.ibm@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484158237-10014-1-git-send-email-eajames.ibm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: eajames.ibm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andrew-zrmu5oMJ5Fs@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This patchset adds a hwmon driver to support the OCC (On-Chip Controller)
> on the IBM POWER8 and POWER9 processors, from a BMC (Baseboard Management
> Controller). The OCC is an embedded processor that provides real time
> power and thermal monitoring.

Please don't cc the I2C list for I2C client drivers unless you have a
specific question about the I2C framework. Same as you usually don't add
the PCI list for every PCI (client) card.


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYd1LbAAoJEBQN5MwUoCm2RF0QAIhuCMA/crRnFWORlUPBv9i8
eJsIpAARk4ed9n4P8cuW1tpzTHxb1k9O1W2VWTdin/fEIK4hIIOlZQrtisvTGfNF
ug9ErBdePTsnuFb4blStbAclqdIHX4eJBLMEZt2KJ8pq+Ny3dHy2lOUzikSGq6rF
H3NQH4m7mntXzScCzzeZauXddAIwxE7QexuHQ4RKpRwdGZg58dM7po92+FJoUHqc
ohv6uNwPzdsFFTn0aJ/eJWE52D6rJnSxuHSLMV6XMn0yU9WVSByzz05XrlluVbut
RBl1i5wD3aHUbavmIftvk8TN6/wXoKDOCZ4RAw0sYR/HmDvsY2UZ1K5Dx4b3752E
PSawVSVO60MUZLbMVoohoL7wf/Xczecbwx3X0xJjUXUp8ci3QCo6g8syYJ+cc1U3
MWdTuLQUxR1qQq520iaut5S38/vKi/p3ojNMEAT6YzjcMpOXZB2TcfgB6YttiUz4
b6GaJVM+fcwYw8LGVxCalPMznvBi2MFI1baP9aygshMfb2hOyiR0+Bjmmao0o5yC
7HhrGAX3yWuf9DFACSNxTFMnvxOzsrhQbm59HmRekwR7FCGU5swqDCmnlewbnruD
dUtYS1Afy3IV4lFY9svBgKeyPXXsho0NA9sqTl5EjOK6QPbyQNmSlg/KMg3Yu7UZ
48kRMHuUPMEROriTqu/N
=4r6S
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
