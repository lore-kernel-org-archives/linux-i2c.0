From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Date: Fri, 21 Apr 2017 08:29:40 +0200
Message-ID: <20170421062940.GA1434@katana>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-5-jglauber@cavium.com>
 <20161211220434.GH2552@katana>
 <20170125204923.2mxtlszvco6wxjok@ninjato>
 <20170420091632.GA8383@hc>
 <20170420155529.riir2yqhddj4y7lj@ninjato>
 <20170420172728.GA4311@hc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:41042 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035686AbdDUG3n (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 21 Apr 2017 02:29:43 -0400
Content-Disposition: inline
In-Reply-To: <20170420172728.GA4311@hc>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-i2c@vger.kernel.org, Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> What is missing in the pci-driver for ACPI support? We already use ACPI
> to detect the sclk setting.

I noticed this in the driver:

134 static int thunder_i2c_smbus_setup(struct octeon_i2c *i2c,
135                                    struct device_node *node)
136 {
137         /* TODO: ACPI support */
138         if (!acpi_disabled)
139                 return -EOPNOTSUPP;
140=20
141         return thunder_i2c_smbus_setup_of(i2c, node);
142 }

And from a glimpse, I assumed this is the place to detect and
instantiate client devices.

> So, if you're ok with this I'll re-phrase the commit message and
> re-submit the patch.

I'm OK. It is basically your call. I just wanted to make sure you know
what it means adding the class to a master driver.

Regards,

   Wolfram


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY+abUAAoJEBQN5MwUoCm2zVkQAKUj/Qjp/N0lQGPxF2iQGPvQ
beDcT1b4sc3xtIqXQhCI5DubeoRn9/nmm4FQXd/j6NQNS0NPEnWaIENwCkmrB/Ia
e6sQcknnfrCiVjmcHn7KnOq1+u3VuaHk/+6o5a7pN3CJN3yCXBwW7EIfF0kw1KHG
WpM68tPKM0JuHIWVcFbz5jngRn1t5a7wakM+/HoKw9gt0JAr/kBSbq6430UKWmvS
hi3z2WLH4k/lJwq6BrzPyel6s6+iV5SU/DAaYKlzKHvWj5hcSSyaTzGmHKTTLT0Q
l3ZQpbLRud88zhA8mD/A2aYuj4Jl/2m4wkEZU/ijkErFiVjMa/1IccQil+uxjlfu
B3f0eRemVd8Ghz/yy87DHIQULkXb3pWHFmeRlHQrdZSNbc3tYKFv46pMbi3UroFI
y3I9Mi1rMKcPKuNBZ/fc8GXRwvVEPEz421gDVr/XynOoq4VKF3DzYI4uJnBRTHzF
+1X4HZruBRJLRXPnP9Xv9YzUELlIVUfqVknl0S6Zw0/e8CAi4wCCwgHDx2krPkBY
e2Ns/WDr1EmKM7QRZ0EdaUw8TysMvTQ4dDjjsb5iFAZYv2JXbYGdIoRLMBL2VIY1
qbkrisqKvY8fPVhXbVBw/tZV8a0krRGvknXeXfV78bvul1a0xH5f00fgygdoQgad
sbe9bt+/3RuTpcJFEpAa
=2qTT
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
