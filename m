From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv7 10/11] mfd: as3722: Rid driver of superfluous I2C
 device ID structure
Date: Tue, 8 Nov 2016 00:09:31 +0100
Message-ID: <20161107230931.GA1439@katana>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-11-git-send-email-kieran@bingham.xyz>
 <1ac3a33e-a85c-e781-81b6-c39f3d533da8@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1ac3a33e-a85c-e781-81b6-c39f3d533da8@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Kieran Bingham <kieran@ksquared.org.uk>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Remember that i2c_device_uevent() always reports modalias of the form
> MODALIAS=i2c:<foo> even when your series allows to match without a I2C
> device ID table.

Not always. Can't we do something similar like ACPI does with
acpi_device_uevent_modalias()?

I mean the whole point of this series is to remove the need of having an
I2C device ID table...


--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYIQmrAAoJEBQN5MwUoCm2Ok0P/3K62wFLPpNZnCuB2sfycnD4
HA3ZB9eaun6gLUCzsTXKyzJ7NmSPejjp4dH6oTJ8cfHgZxA6Ou9e3a9Ybuj0Ub8k
Ta5cihDQAwSljdnRmuP/B2KPzgnuXC1dAd/qVke+kel3uOyp4n3h/Mw+RfWDS0HX
Izj5PeBXCJrc7XmKEwNQAtc41bvimpWFGMswfLcwSJBt+8e2Lj1/mp92PxgVaBVN
n80eI2oiuPhqJ0bFLRbx4O9uRCM4Onmji4ojWToIdQCI49LxylxESKKfmRmsDI0+
xp26/Bdc0sm47HPLGAA7RCyz7avBa8EiQcvCkyeB9GZq8eFeh6leQVd+FleVd4Vi
JbkNkT3+1e9/qa8qI3Zcxd/NLaHiRUAAUxr8GouQquWDRTtQeW0r1xS47lZJEeej
Llp6mB9+3koq5BBKCsxODIsr86nMkMtuIZTs3KaRagJfmvE0J9+XSHAJiEXZiJ1V
JCoIszoaKtLx9836zlGNWcftO3udR1oB4BOYrTC8x9TLdXD119iaEVKRwwvLnGwg
28+maZRP7sqvypj2ihVdGjJ+b/9JZJ0XHxsdVi7x49zkIho2l1f5yhMtxnc+xN7i
iKx4TZrLcco77n/4vpHqftaGUWawj6xict4lIVjDQYLtZA12G6daTU58EuTpPwph
A7OVwRDDeMFrnoIqDsL6
=4yZI
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
