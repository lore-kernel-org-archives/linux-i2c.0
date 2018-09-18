From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Properly handle DMA safe buffers
Date: Wed, 19 Sep 2018 00:16:46 +0200
Message-ID: <20180918221646.GA970@kunai>
References: <20180918194126.138455-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180918194126.138455-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This fixes a problem where the kernel oopses cleaning pages for a buffer
> that's mapped into the vmalloc space. The pages are returned from
> request_firmware() and passed down directly to the i2c master to write
> to the i2c touchscreen device. Mapping vmalloc buffers with
> dma_map_single() won't work reliably, causing an oops like below:

Exactly the reason why I implemented I2C_M_DMA_SAFE. Did you also notice
the helper i2c_get_dma_safe_msg_buf() which you maybe could use for
len > 32?


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluheUoACgkQFA3kzBSg
KbY5lg/+O6lcx0uYmTjDHz7bfAO3QH49D9q7kDhqGBmwkQ1szR0WtXQCF9oOmIKS
8yytXNLqBhMyijpcBeQ62iNk/FW2f6A7+wYSjsElC7lWmqgGsNtotTJqRVAYDtlK
5u9BgG3lAC40c7boLNzQ+5/3ivbxP/B+0nmoHcOpE9eRRHobwF87jkvMZILKxiCM
UgWjpheCWALbYItbkPSiLJTpxq8VtJZAwHNwuKctiPCG6tpQquJ903tBZs7VfAwU
3AUPhwalNLaK3QaZVwM2RAGW0H0FcCz/TsgpkWFoirGdxvE/wGWXIDe6Uoeet+7U
e3ltKNKc830tu4V8Tm6YYb2SfYquNbgQmsP2TnOmrqGsyNRZbTZEwIXJ4i8UkuyK
0Xwyzc23b0uReUF7mztp1p76eWaHl9/Rohk7EFmK9C+jnzg4rhj9WdIrtdxdQ54K
jwewNdmdkE06YS3x90ngONaONBnEuF0IM5VlKTT53mnFwpQl6ILd8p42qY6LFey9
lwhRuyhgURHd5GCvCNiNAJa240W26FKZwT96aZQjubPTb45wpYeoJNo8JbPHLB4n
Juxscuv2/Cf+yXGT4nH8/G8uqQnZfW8gvftGSxDxqevWcb09fIovxnbJqrhqSTuO
Aw9i6yzFYg+s4tvkQ1fCn6iKHVsaH25J2O2xH57ZnxBxhvb1WAg=
=UwD6
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
