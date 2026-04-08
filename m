Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D5395242;
	Wed,  8 Apr 2026 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666103; cv=none; b=V9SMjK4EHqG0G5uF+VvXHIwwvjrriyKliwJLPqZfSRDOPWmY2UWwddOpn2V2tJXO5zPUY9ISip0d96Yk2NI8YhQA3To0qFBrxMN4yU6Rgj0YhEeVXC3g+v0lKgKI3qbWIfU5Dxzic3UsVwW7prxPjELO/q0GuGwp7mSFEzMVxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666103; c=relaxed/simple;
	bh=JK95LnGEZb2rGTFZpXUucLRp95zuUr44L2tfODkcSk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIiNIyd88jbd/KEBip1qceIlw9FN0MpkLrjQgmfWdql3MBQ7o5W68NWHgfKH9doQe55v5zOedJIHJluYTNq+o545ol/Sm4Nm05j+fd8k7Vfh7TWUfW8T7BXBOla35bTuyHD1UvW3YOjwxVp3RxFtoBmj/QO5AboLwaTWAkNi3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkwVeJ0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkwVeJ0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B0BC19421;
	Wed,  8 Apr 2026 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775666102;
	bh=JK95LnGEZb2rGTFZpXUucLRp95zuUr44L2tfODkcSk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkwVeJ0yQCnDB65YSgHCrg7ObQF7Yl3WsPJmJnOxXPGfoHowyQ0lm6dTcGgOvaqHB
	 kEa5jl61hxsGDigS+lQb+fAI3OZbyIRzGG6PkYw5r4ZoH2CqMu8wEHODIfCjRFaQwK
	 EhzlCL6UF/49DnOvX4qAe6/cJ5YWKzJeUm7qIhuSWSpeLvH6iUQAegAED3BPeDkTr3
	 VocdATQqKkss46jamlzdikAIuFkALE00xlAOpsV9dLDEizWBH+27uMBtLecWgg5cjr
	 yt3DYpUgB+YvI1UoK+QhiHsZbyGNyJgiyspVqVLVoFFIbPVTtxVVMIFNlDQyILPk8z
	 lOMPNibqP94IQ==
Date: Wed, 8 Apr 2026 17:34:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Nishanth Sampath Kumar <nissampa@cisco.com>
Cc: brgl@bgdev.pl, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, rafael@kernel.org, arnd@arndb.de
Subject: Re: [PATCH v2] regmap-i2c: add SMBus byte/word reg16 bus for
 adapters lacking I2C_FUNC_I2C
Message-ID: <86871ec7-61b1-4655-9b7a-18c0bb640240@sirena.org.uk>
References: <20260404021920.359902-1-nissampa@cisco.com>
 <20260407233927.498932-1-nissampa@cisco.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NZwBwpiiHejcu93U"
Content-Disposition: inline
In-Reply-To: <20260407233927.498932-1-nissampa@cisco.com>
X-Cookie: Often things ARE as bad as they seem!


--NZwBwpiiHejcu93U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2026 at 04:39:27PM -0700, Nishanth Sampath Kumar wrote:

> +static const struct regmap_bus regmap_smbus_byte_word_reg16 = {
> +	.write = regmap_smbus_word_write_reg16,
> +	.read = regmap_i2c_smbus_i2c_read_reg16,

Not an issue for this patch but the existing function is broken on big
endian systems, it needs to peer into reg with u8 pointers since the
core already put it into wire format.

--NZwBwpiiHejcu93U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnWg7EACgkQJNaLcl1U
h9DPMQf7BW/ZRknVizGtMAgNOpa+SMU+9q2miyDHxQ4zpzHXJLI0uIVd2OV4kJKu
xUAdR2GNIfObCQqHYSrhGl6IebwJ9omNBOic1PvMQGEvyWrrS3eRbU/EqyYis0aS
I1xAa0bm/+ljIK/P0KKJ78r6w8Vq5+vZstEIsNVnw5ZkEq9nP6JK1uxELOrMCGH3
UC897ceQ/uyG2UEv2O/thxiFixUwDq1yl27e9ZDmcs8kLkg3tJ/acq46HbOMTUin
Y/k/tFGxLrvCwOzkDbOZZ/CSKdIw1dmTr/zZSNK+wCr/3t6hm6uugwTHmN6AVtaD
BWtebhGdyHZpu2TqKgU1Mew1IIm0KQ==
=K8K9
-----END PGP SIGNATURE-----

--NZwBwpiiHejcu93U--
