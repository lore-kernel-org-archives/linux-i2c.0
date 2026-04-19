Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294310F1;
	Sun, 19 Apr 2026 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776558947; cv=none; b=InRXo8FHRuaNNSuSMQ/NQmashnIH/f0phypKN+84UAAHCfVvppzQx6EIT8FP736k888mZc7wX/UCPJ9G51mBh9Au8c8+fcJXbyebjNT29hcGTh7jYSjhqdTLuaNsQTabWT0DPGBfsOElfTJsohQtl4mUws9elrh2I3z60SzY7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776558947; c=relaxed/simple;
	bh=fGfQheFVnz4gYDAPncw2Y/UiHK5bX+WjRgWclUkmQoY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FSWABMfnQMLuQMCdTjCgPXmpaL6lnaiV6j+FGurpAlB2nIg/A1r83irQhJiwe+fUqxaNr2WqhR1AjP4cK7Nzzqg/CUnG2ddlCK01JtoqOa134bR/2ieJLSRtE4pUOwc7nekiqHg4hBtkkgN/E++JZDexI8NZjQO+ay04i599Hmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+flYtr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+flYtr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D3FC19424;
	Sun, 19 Apr 2026 00:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776558946;
	bh=fGfQheFVnz4gYDAPncw2Y/UiHK5bX+WjRgWclUkmQoY=;
	h=Date:From:To:Cc:Subject:From;
	b=u+flYtr0jTamDoNfoMR8vmpRu5SVehgysVtYe8XbYpogrorKQzYdCDo3M8PwqLvIX
	 wDFvxHyrw3YzIcgfZj+UKsxxrWSmb+fmkjjjzgcABYhLpRCwq09dQOgWHXizqnvkiO
	 OkiVx0NkoZ/y/JoxT4lOFcGinc6LDKf0Djq0CNIUoU9T/bRuh8z4OEm99FcszdZIox
	 wzOHj9tCzepdWdkyon21NDpWEKlLCoMEQfXvvdhdgF0hmAiximrNxtSREoVBjtkGRU
	 HLIKm+V4Cr9YAdonEEJIdANLWXK9BlywpbBsEP6z35+gBhCm1aLoN0rhyaRcgu3uTo
	 0X/mX8NTIS1ew==
Date: Sun, 19 Apr 2026 02:35:42 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host for v7.1, part 2
Message-ID: <aeQgYZcS1FjB1KwJ@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

here is the second part of the i2c-host pull request for v7.1.

Just three patches, all tested in i2c-host-next for quite some
time. The pxa change is the second patch of a two-patch series.
The first one [*] went in as a fix in -rc5.

Note that this pull request is in i2c/i2c-host-2 instead of the
usual i2c/i2c-host. I created that branch for part 2 and last
rebased it on top of v7.0.

Thank you and have a great Sunday,
Andi

[*] 78a6ee14f8b9 ("i2c: pxa: defer reset on Armada 3700 when
    recovery is used")

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-host-7.1-part2

for you to fetch changes up to faed986de5250e1cd1296e82d1fcb4c03997e02a:

  i2c: mediatek: add bus regulator control for power saving (2026-04-15 00:54:34 +0200)

----------------------------------------------------------------
i2c-host for v7.1, part 2

- cx92755: convert I2C bindings to DT schema
- mediatek: add optional bus power management during transfers
- pxa: handle early bus busy condition

----------------------------------------------------------------
Adlavinitha Reddy (1):
      i2c: mediatek: add bus regulator control for power saving

Gabor Juhos (1):
      i2c: pxa: handle 'Early Bus Busy' condition on Armada 3700

Shi Hao (1):
      dt-bindings: i2c: cnxt,cx92755-i2c: Convert to DT schema

 Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/i2c/i2c-digicolor.txt     | 25 -------------------------
 drivers/i2c/busses/i2c-mt65xx.c                             | 13 ++++++++++++-
 drivers/i2c/busses/i2c-pxa.c                                | 18 ++++++++++++------
 4 files changed, 73 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-digicolor.txt
