Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CA3909A6
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950767; cv=none; b=YLaKkJHGiWXMJH4TmWwbg+GmWgZvhNzXXdE69ealP+ZGVUdChOuSCA91i4ZEaSsBWz7nZjnGll3bpNgP1aOagokLnj4T07GEgEZ/X0KNp7ozuFufCXmfFP1NRYXSuchTBetstWL7N+dQd5PdROxqFaeMa6tJhsSadRoJibVQ70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950767; c=relaxed/simple;
	bh=wfg9u+8h7e6FXsAfeb1pW9vgRGYZ4l82lgad5GOd9BY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WBeUu8VnWe6cYLp31XaXO6Q3A8svk18qEhS7cPurHi39fcGs8++wNEnArG8a+5Xn2D1OyNRrjol7g3/LdTmv4lfyT+10os6cwcAonN9B1rTKgmbA7//l08G4sYKnLrf6eiQzdheZkOLot3ACBZTHO/AQLmlYk1zKFObPI+CHG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gS3+a6c2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gS3+a6c2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:mime-version:content-type; s=k1; bh=YULm4t7X286aWQwdFQF8he8Rwip
	nkAAK5Vobmhgvc28=; b=gS3+a6c2mEFrbf6DOjZFanR1LS7Z+GS6v8wEDvn6/xm
	emRwoDIfORwIy09k9kFlxspG0XOjCMj+cI4E+0b/MTrNP444veDaA61CNmSoZ2oL
	4IsyBseoL/Jxa6uzU4jW4fiRGpxoq2n5Q8AySGi1FioJR0GyEUTQioO6gnUTm7ar
	baDuoK+ddz2VtVcNRoicAUG3pVv5bLBDXrKKArgaoxs1okam6z1ob5EBNLZxIFA/
	Toqc6yYxmnJbekTSJgSJoU83Nq7ngNsarWtmIKuvzeFNfqjQ2sle/dj0HKlPNre2
	swQUasmFJGY5OwANg+4joWsFTV4VkSCRmXfk/CMjBuA==
Received: (qmail 985293 invoked from network); 8 Jun 2026 22:32:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Jun 2026 22:32:43 +0200
X-UD-Smtp-Session: l3s3148p1@FgaW6cNTvsMujntX
Date: Mon, 8 Jun 2026 22:32:42 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org
Subject: [PULL REQUEST?] i2c/for-andi for v7.2
Message-ID: <aicm6trmpoPZpT8v@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CSCwF4i7IoqxiBdh"
Content-Disposition: inline


--CSCwF4i7IoqxiBdh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andi,

I don't know if you want to pull this branch or pick the patches
individually. Anyhow, I want to let you know that here are some patches
I already reviewed. I think they are good to go for v7.2.

Happy hacking,

   Wolfram

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-andi

for you to fetch changes up to 583c45839cb343db171f5c5e40850d6eb906e949:

  dt-bindings: i2c: qcom-cci: Document Glymur compatible (2026-05-30 16:07:=
49 +0200)

----------------------------------------------------------------
Abdurrahman Hussain (1):
      i2c: mux: reg: use device property accessors

Andy Shevchenko (1):
      i2c: acpi: Return -ENOENT when no resources found in i2c_acpi_client_=
count()

Herve Codina (1):
      i2c: at91: Add MCHP_LAN966X_PCI dependency

Nihal Kumar Gupta (2):
      dt-bindings: i2c: qcom-cci: Document Shikra compatible
      dt-bindings: i2c: qcom-cci: Document Glymur compatible

Uwe Kleine-K=C3=B6nig (The Capable Hub) (1):
      i2c: Use named initializers for arrays of i2c_device_data


with much appreciated quality assurance from
----------------------------------------------------------------
Bryan O'Donoghue (1):
      (Rev.) dt-bindings: i2c: qcom-cci: Document Shikra compatible

 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml |  4 ++++
 drivers/i2c/busses/Kconfig                              |  2 +-
 drivers/i2c/i2c-core-acpi.c                             |  7 +++++--
 drivers/i2c/i2c-core-base.c                             |  4 ++--
 drivers/i2c/i2c-slave-eeprom.c                          | 16 ++++++++-----=
---
 drivers/i2c/i2c-slave-testunit.c                        |  2 +-
 drivers/i2c/i2c-smbus.c                                 |  2 +-
 drivers/i2c/muxes/i2c-mux-ltc4306.c                     |  4 ++--
 drivers/i2c/muxes/i2c-mux-pca9541.c                     |  4 ++--
 drivers/i2c/muxes/i2c-mux-pca954x.c                     | 36 +++++++++++++=
+++++------------------
 drivers/i2c/muxes/i2c-mux-reg.c                         | 90 +++++++++++++=
+++++++++++++++++++++++++--------------------------------------------------=
--
 11 files changed, 82 insertions(+), 89 deletions(-)

--CSCwF4i7IoqxiBdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmonJuoACgkQFA3kzBSg
KbaNvhAAtPIbbig36U4sOO5w0tse5NMnUGiNKYSR2wN6Q5eHx7QLGUmVViJpE2SI
nrpyJ5rbHXPqinFTWl8pHUVORmGAxRdTJunYMyTXgZZ7AfuqQPHLhCRWBcTh+GL8
81dh7KEN7OY0sxE8OBXFs1Ozi5AoRqIs7zPgxwDi2KIYaohou+YeWQoalBr6mdkV
1Ya3fz/1TCZEMx32HG2XZpRP6/ABujwpbhiztO3ch5qhesne5+1Usr0lM2ZL+1jJ
WGQZ1AnAX3A/Jt5hYxWvrrGHciDcn2mGniZS2h+eqfDT4MldcYSmKW9wKUY8m4aJ
XjmEaxGgLqXKzetG8rBnk6sJkCIKhSEM5ahUCZFh5+1lhpwxngqBxYKWEWetNq+4
bMuqyXqprNB/zxlKXOXSGvCt0WzllbsZrDdwjmIjnppemZ/urupvlO8CxpXsX+Ta
jlpqL7/zSb5sFR2zqOIUKwFrmoDV2/36kycSJk87IIPd1IDGGuUmvpes26+sb9ut
PR7r/4Udrfmh8vCJxVO4biHQdyZ8cr5ZXCinrL7Jp3Kci7EYaQbEEc1sUafJeFon
x4YOGsVCMy4X3qQUHkCa0oRbgQRV8DOKinPuiPXEfDJZQykIxHsx79HQhbD6cyP/
C8yhYPPoglAABGOWf/VF0ZygpGonllRKfKOjF3j+Di0OZ0jffBg=
=Pf0g
-----END PGP SIGNATURE-----

--CSCwF4i7IoqxiBdh--
