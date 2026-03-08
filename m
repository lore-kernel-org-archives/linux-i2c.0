Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C608346AF0;
	Sun,  8 Mar 2026 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772956202; cv=none; b=BZQqvWkqytY4RRi4Pde8ulyTyXoC/vHItIvtqCRm7QQvtyNXffLZH8mJEKjijrJDathGlB0CfnndAEFSZF6rMRkyZnn1mi7KdM4Mg78BiaBo7pwqFywTmztc5bbVNFKfFU9NqsnRZNkvfNlbSNnzD110YpH5w1Pdtso7/DHddM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772956202; c=relaxed/simple;
	bh=3v4pNYXE1KgqkgfxV4hZJ3pB5UY+2OrgggKz0k+/iMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SM/+MqWOpCcqBSJUkBfkiYAapmcsEtM3kw7M7nWZKBVLGdsuDJkieRzaH6aEjqtLLP6lL1vVuxPuDPusu6HprlrJTv7JS8JF7Y2VS0RtSKUfCBiBRG5NNO+EuOG5gHxqvnjVAiYupgh6lRwrf3KAZWXasQLuoIsza4ZnhqTlDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijtRE46M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijtRE46M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4CAC116C6;
	Sun,  8 Mar 2026 07:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772956202;
	bh=3v4pNYXE1KgqkgfxV4hZJ3pB5UY+2OrgggKz0k+/iMM=;
	h=Date:From:To:Cc:Subject:From;
	b=ijtRE46MGYNHrIGRqz5jJWlLRqSdY1H1VFARdQ/VIfkX/98Rspr4v0rRhtVw2mRNN
	 8cKqmV26LAq5EPcxtC5XqOuWjfp9Xx6DzcTS4A8HIDGt6g7QDBmBU+awZh6i86MCmN
	 J845vTXhtmVKfd99RQ1F4texjls1doplg9uFMN3UcJqFRO/TpCKaR04T2Z9mg4ZLrm
	 teVvWF5IndYAkZo4snax0YcrwhG4JA5wtXhd9kKpXUP+lbhFqptYUdxb4tbJDYLVEj
	 VJiQ3a/fm2hPOolpurEoIlJ5tW0gxQo2sQjT8281v+RJTjm0aCTWocwLCFL31lB8fe
	 OGyhOMwztZ0Lw==
Date: Sun, 8 Mar 2026 08:49:58 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.0-rc3
Message-ID: <aa0qJvLMHMrBOJvf@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+SpWsZfokBG5DI9G"
Content-Disposition: inline


--+SpWsZfokBG5DI9G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc3

for you to fetch changes up to cfc69c2e6c699c96949f7b0455195b0bfb7dc715:

  i2c: i801: Revert "i2c: i801: replace acpi_lock with I2C bus lock" (2026-03-04 12:44:14 +0100)

----------------------------------------------------------------
i2c-for-7.0-rc3

A revert for the i801 driver restoring old locking behaviour.

----------------------------------------------------------------
Charles Haithcock (1):
      i2c: i801: Revert "i2c: i801: replace acpi_lock with I2C bus lock"

 drivers/i2c/busses/i2c-i801.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--+SpWsZfokBG5DI9G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmmtKiYACgkQFA3kzBSg
KbYAlQ/+J39yTST3aiqad3f4omyFauHntWnfR/zn/tbynYE1IxyS/zRemQ0wpzpk
0tPTZjhSeydMgjiPobXu3OiPei+jty2+InyHsrWzqYyYVPSs2rGBollDUSvDFEdx
OlT79XX4gmmi7Lp2/FvG8jJK9SYQZiqH9OEUsOXNr9VO6x8LtGZiubsg9DW2BtYo
B5pgTf6RT/1H0PweCupjGRc894Sdt9Y4G2xZ+cBPTKQRRq0rz35ZYoxAuqRFfk5y
OmasSeWCMXGeKyNn9m0ONj3DuSgkdfb//xS8Vlnhb7y9adz2NKJEV6hRa+X4sU54
DejVsjOixY3j/I9BVjN+8hqup/od5YjsOpX1W6s0YC7xFS20QkEERad4nhJO7Nc2
6L48gNUwhy9ZCVRFm+YmzyhbIvGZQ0yBS6zpE1xaLuKrA+ySQnKw4yiydug7OLJc
e5I7fBvcHYxU9yRMecB3fnUL3UF96fHWmvr53sTqFpEscwa9XkP6zTSgkxAnD/60
oG2xlSIF/CH65K3ZeY5Xc3TcHf05HZPBEtfO1XnK+lOoKI3Qs5iJzJfmL80ZFlGd
kmsimowirIHbti3YfjV8k74ukkwQcjvQQqwmStw4/5yO0SW3FXq54PujedqzmDQP
BILCS6IWL/tK4oCbQ/FxTgRbsdH1mmxXm7ddw5yMYT2jM9IRiqM=
=5FPv
-----END PGP SIGNATURE-----

--+SpWsZfokBG5DI9G--
