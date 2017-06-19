From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: Prevent race condition when removing i2c
 devices
Date: Mon, 19 Jun 2017 16:36:56 +0200
Message-ID: <20170619143656.zigxk77vegedscjx@ninjato>
References: <20170608024344.9311-1-david.thomson@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aw7o335wqsikqwdi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53518 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbdFSOhD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 10:37:03 -0400
Content-Disposition: inline
In-Reply-To: <20170608024344.9311-1-david.thomson@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Thomson <david.thomson@alliedtelesis.co.nz>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org


--aw7o335wqsikqwdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 02:43:44PM +1200, David Thomson wrote:
> There's a race condition that occurs when deleting & closing multiple
> i2c devices, which results in a kernel warning on an incorrect reference
> count:

Thanks for the report and patch!

CCing peda. Do you have time to look into it? Muxes and locking are
kinda calling for your expertise ;)

>=20
> Call Trace:
> [c00000007e2cfaf0] [c0000000000b84e4] .module_put+0x24/0xb0 (unreliable)
> [c00000007e2cfb70] [c0000000005db830] .i2c_put_adapter+0x30/0x50
> [c00000007e2cfbf0] [c0000000005deb74] .i2cdev_release+0x24/0x60
> [c00000007e2cfc70] [c00000000014015c] .__fput+0xbc/0x290
> [c00000007e2cfd10] [c000000000059b64] .task_work_run+0xf4/0x130
> [c00000007e2cfdb0] [c00000000000a0a4] .do_notify_resume+0x74/0x80
> [c00000007e2cfe30] [c000000000000acc] .ret_from_except_lite+0x78/0x7c
>=20
> The race is seen when an i2c adapter is being deleted while
> file descriptor on another i2c adapter is being closed. The following
> shows two threads executing concurrently (the first number is the thread
> id):
>=20
> 4580 i2c_del_mux_adapter adapter i2c-6-mux (chan_id 2)
> 4580 i2c_del_adapter adapter i2c-6-mux (chan_id 2)
> 4580 i2cdev_detach_adapter adapter i2c-6-mux (chan_id 2)
> 2627 i2cdev_release START adapter i2c-6-mux (chan_id 2)
> 2627 i2c_put_adapter START adapter i2c-6-mux (chan_id 2) owner (null)
> 2627 i2c_adapter_dev_release adapter i2c-6-mux (chan_id 2)
> 4580 i2c_del_mux_adapter adapter i2c-6-mux (chan_id 3)
> 4580 i2c_del_adapter adapter i2c-6-mux (chan_id 3)
> 4580 i2cdev_detach_adapter adapter i2c-6-mux (chan_id 3)
> 2627 i2c_put_adapter END adapter i2c-6-mux (chan_id 2) owner c0000000edf6=
6400
> 2627 i2cdev_release END adapter i2c-6-mux (chan_id 2)
> 2627 i2cdev_release START adapter i2c-6-mux (chan_id 3)
> 2627 i2c_put_adapter START adapter i2c-6-mux (chan_id 3) owner (null)
> 2627 i2c_adapter_dev_release adapter i2c-6-mux (chan_id 3)
> 2627 i2c_put_adapter END adapter i2c-6-mux (chan_id 3) owner (null)
> 2627 i2cdev_release END adapter i2c-6-mux (chan_id 3)
>=20
> When thread 4580 for chan_id 3 interrupts 2627 doing
> i2c_adapter_dev_release, the 'owner' field for chan_id 2 becomes
> non-null. This causes the code to attempt to decrement the reference for
> this owner, but the current reference count is invalid. I'm not sure how
> the owner is getting set, but adding a lock around the
> put_device/module_put calls resolves the issue.
>=20
> Signed-off-by: David Thomson <david.thomson@alliedtelesis.co.nz>
> ---
>  drivers/i2c/i2c-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 82576aaccc90..8831d9b363a7 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -3151,8 +3151,12 @@ void i2c_put_adapter(struct i2c_adapter *adap)
>  	if (!adap)
>  		return;
> =20
> +	mutex_lock(&core_lock);
> +
>  	put_device(&adap->dev);
>  	module_put(adap->owner);
> +
> +	mutex_unlock(&core_lock);
>  }
>  EXPORT_SYMBOL(i2c_put_adapter);
> =20
> --=20
> 2.13.0
>=20

--aw7o335wqsikqwdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH4YgACgkQFA3kzBSg
KbYkag/8CmmqT67mmHwFaHiMJNp7jBsosHJh4+Y0K5bemtqYrh1tzM4qPnccam7M
IgYyLuNFiCpl5+RfqZz98xzqFS+NvQOMwCaYIEeCD7Dwh9vtzPC5I0uX4NuozFj0
uAwhrjVplPUas5i6Yqg/8ciHbKZaG6NwC8W9Ig8GS5zUspAeV7QSytQi5wOADMMn
YQZsLrlAKarYXg5kSOSjzmkPlC3WARUVI3EFU3gmbzW2CKh/4LJYbCdxATV4fdeb
pUFmqNLVgAZiiNgLf47NhchYMdmH4VMqZBDT9YgpAcAHcSFzKNo9AGts3ze7Bcd7
gyZaEkPP3fLVCpu+Swy5/nsTD2LQx04VaBwWCCyMzSoxK9cvabUWjqBslcxbZ7qC
3fEXfQGXaKI+vJnCHvezmjAV40QYfNaJ0r9Drky1o7ExdGjuFTs0v6XcKpjTYwcb
KTqO4f4SL/Cu3ys/fB2X8e9tHZWEi/Ou37t5H/nMhty8E8tBwa+i7h4hDgHpFPE2
2KI/WOvgpXac8rnZPQ+LdYQWYb0Yz2kwme/LSAoq7bup24HeDG3eI3/jBA6wx3rM
zLEZ3EdKcQQFDOEvl9U4b2iNNcKfBqrTtvvCh95VR2n9/r0hJitrvLYZqMgztdRs
7ly2oXTIqkHt70Vp1HB5EQwPVXl9hFi9gjY0wiTJ4VwExaQMwBY=
=sbqb
-----END PGP SIGNATURE-----

--aw7o335wqsikqwdi--
