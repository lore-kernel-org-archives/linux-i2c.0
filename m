From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C/ACPI: Fix possible ZERO_SIZE_PTR pointer
 dereferencing error.
Date: Tue, 30 Sep 2014 11:19:49 +0200
Message-ID: <20140930091949.GI1325@katana>
References: <1407810818-33672-1-git-send-email-Li.Xiubo@freescale.com>
 <20140819150355.GD15371@katana>
 <20140819151604.GU1660@lahna.fi.intel.com>
 <20140819153808.GE15371@katana>
 <20140819154555.GW1660@lahna.fi.intel.com>
 <53F4638F.5070704@intel.com>
 <20140820101814.GC1660@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140820101814.GC1660-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi people,

thanks for the additional information here.

> > Sorry for later response due to leave home today. acpi_gsb_i2c_read_bytes()
> > dedicates for GenericSerialBus Read/Write N Bytes protocol(ACPI Spec
> > 5.5.2.4.5.3.8). Bios wants to read N Bytes when uses this protocol and the
> > length specified by Bios should be greater than 1. If the Bios specified 0
> > bytes, the associated function(E,G read battery info) would be totally unusable.
> > I think such Bios can't pass through Windows certification:). From this point, I
> > think the check is not necessary.

The simple question behind this is: Do I trust the caller? When I look
at BIOS (or anything outside the kernel for that matter), I clearly say
no, so...

> > If you still thought this maybe happen, I think it makes more sense to add the
> > check length in the ACPICA. Because ACPICA will allocate a data buffer for I2C
> > ACPI operation region access before call the callback. The buffer length will be
> > result of protocol head length plus data length. If data length is 0 and this
> > means the access will be invalid and ACPICA should ignore it or produce a warning.

... I'd think such a check in ACPICA should be made. However, I can
still ask the question if I trust callers outside my subsystem. This is
more policy. We can demand that users of acpi_i2c_space_handler() should
sanity check their arguments. Any foreseeable chance there will be
another user other than ACPICA? I'd think no?

Regards,

   Wolfram


--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKnW1AAoJEBQN5MwUoCm2KJsP/15FOsVDyZ+VzRFtU536B909
DkA8RNO1pMA3gDSWoP5WQZVucPCb7HpzsrRoBCW0aVqUjneFYHeZ9jsLytqfd1qx
uOXn8pWkxGxhj/PI2r2g4xu3KPB8bClnbROKCcZWlbMcvTNRJuywEWme64+XGcQi
3VdUDl02pSlRJwuRsuYTo0TkpPi6MhzYPUO3CuAf12GVxSPLkAcIwuAO3t4NLzun
84InqbFQ+MZJzk8JJeF3vdmzCgI2RPgrUmuV4+vydH/aUarkH5fua0gucPt/cJoF
/Iv3jMBjqiTXirrQmL1WDC6SAfGKMIcTNtozO6OlSEZpxcZNqSi3BTEcEv2VqGdm
VmaO1it2mkfvRPc6WM9c0/LMpkA7kSjpeCUjd6gxHTPk9yhYdVn6GZ3eTV/mfc5g
UWGMUiHmJtBty4qEawcXnlLtckmiow2Na2a10dXShdedJx/+aOjS5bhn0l7CXHYi
qsRafdlR+kLP+nPRj7O2R4PxztnZ7kRS5ovKEKJus+J12ZVHfqQb9jCi1nYgDSEK
AidPUWP3Fxg4jLElAXnsBEVJ/2besFnE9RsrwQt9pZ/YoeN2iYpmTLUkcsOPew8s
gd6lr89puSc0sOufPK7zBiwSI75LmilWFEoqSTGuEDG0KyaWRx3w1CHKmV2TdTk5
B9V9UxuHTdzM5zgElznU
=3vlc
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--
