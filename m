From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [wsa:i2c/for-next 5/14] drivers/gpu/drm/drm_dp_helper.c:810:10:
 error: 'struct i2c_adapter' has no member named 'lock_bus'; did you mean
 'lock_ops'?
Date: Thu, 25 Aug 2016 22:13:26 +0200
Message-ID: <20160825201326.GG1614@katana>
References: <201608260342.3Jvnwngi%fengguang.wu@intel.com>
 <5112628f-7061-89f9-83a6-8786c701ac36@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47050 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756501AbcHYUNe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 16:13:34 -0400
Content-Disposition: inline
In-Reply-To: <5112628f-7061-89f9-83a6-8786c701ac36@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org


--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Sorry about this, I obviously didn't know about that new user. Should
> have looked closer...

I can recommend 'id-utils' to assist you with such things. Run 'mkid'
with every -rc1 release, then you can use 'gid <function_name>' to get
all users of the function in no time.

> Wolfram, should I send an amended patch so that you can replace this
> offender and keep things bisect-able, or do you want just a delta?

Please send an amended patch. I'll merge it into my for-next without
rebasing then.

Thanks!


--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXv1FmAAoJEBQN5MwUoCm2rk0QALPAkDPCNNgZtYhk8X/v7DKn
NHe2Fi6gc0IHM5/gg02ywZ+OW6STx+H6U7LaOh9bpDkoJ3zRwi7Z7zT3Z+7dnCiJ
x7pG0j7Cfcxy0wTZqZrOlv1xq3FwHwp6Qp/wYkS/gNWmsGkhS02u74PSbofY2+aw
7E9tQ6XX3YLPjhDWrvIpPK4tvvcwVDuQV1dtrMvNqa68pcR0c2mtMG+4XtqmEnXj
ROix1mtk34nrzDpOIg8tvOhhMqwQzsuIhqLH9NLO2fvMJnuOlJHyylkgCQkFG12m
pG4bZhDTZux/QUyqyZNeJazIbC0EynH/m6Z10GArSSsGEglAESlyXwCt/hiKE6ET
3lfZjJxNMBVsh0A3QeJNGs1Udxvasn2ppn8YGjOgiFH28D+mQ3M6w3K/BdhAzeP0
NI5PMJnkG9zDkkZJ6d+fS2o95l/cgmUQBoWEQbQy7JMPMSV9aIC1KFZHSJYnXzkp
keJb1DDpjxm7xvjbPUrDU6nDWfQNWTvLp8XzVa/yiSySyNPcVBtge66MpoafxetU
vek9W3q6pB6vwr5qAc3YEMzs0vWlPrz0ohhEO8YsSrSjaCf6CmHvmAvoytkZJlti
xORPaPwm/654uKXuqzESe1E5KYJ7XkKCM8SIkhxzqBPbw7hxrir8tqVNZb5ixRPW
Nb7ioJfmz0pIL9064oTh
=OoEa
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--
