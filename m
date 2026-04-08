Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143D28D8DA;
	Thu,  9 Apr 2026 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740779; cv=none; b=kTPgoHTgQzsob94ZrTqtcVm0M+5lQNejQqKjHiwf3vkotPn/ZpGKheOjLRUWgnsAOoSy7YwTLJGAYD/CYotYnacbhvBNTNSy8xGywu9InoFzztXW3TTblYpzzn9kcKjaxsZcURcuNUq2BrlciLlJuqpGgaE5CmhCYzsxThauluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740779; c=relaxed/simple;
	bh=6pT3nf54En6QIJ70bqQFJhTpUjDiHsfC62lwNpSsImQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X4TdWQlsM+id15KG61X5KKgQiNnjCG8L6mlCFliViig9JC/D4lTGBQp9Xmeth56cE8F7B37R99FEzytPW/71De1m/MIcW19CTNJJ16d6jPW1lIiAF+k8GxroM6CnVPJJ+H9jFgRaRcuUaAJE7/nG/oMZRDDBbHFZ5PnHScX28Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haSyy/CU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haSyy/CU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E279C4CEF7;
	Thu,  9 Apr 2026 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775740779;
	bh=6pT3nf54En6QIJ70bqQFJhTpUjDiHsfC62lwNpSsImQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=haSyy/CUItG2kPHoXwUw5/2YSU83RZoBl2z5Om+7/LZOCAvj/+26uHucssEMpCkiK
	 ofaFTt49wSwSWpEievhbeaEvA17sRags39RgAx1svuLQrDs0EM9e9PQy0dm8PHURgg
	 203fL4ST+OsFh9x/h6IaFaX4TLqw4BmB7NebHt18Ti0elg54Yl2ha5y7Loh9OSLSF+
	 xMpGicvBVhwb41ra3hDISdsbWFleNMWItI24tJcMYJZH8IbGdLZuc6tweu8dqv0E/Y
	 uahCvJQYRzrKTUdr81l2Zdvptb+vVJwyUvDwGjMt3bijVerwSgpIjz5I3lq7BDeE/y
	 SJsazz4qsTjSQ==
From: Mark Brown <broonie@kernel.org>
To: Nishanth Sampath Kumar <nissampa@cisco.com>
Cc: brgl@bgdev.pl, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, arnd@arndb.de
In-Reply-To: <20260407233927.498932-1-nissampa@cisco.com>
References: <20260407233927.498932-1-nissampa@cisco.com>
Subject: Re: [PATCH v2] regmap-i2c: add SMBus byte/word reg16 bus for
 adapters lacking I2C_FUNC_I2C
Message-Id: <177567169064.101848.12605250361585331832.b4-ty@b4>
Date: Wed, 08 Apr 2026 19:08:10 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6pT3nf54En6QIJ70bqQFJhTpUjDiHsfC62lwNpSsImQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp16dok7CQARPP5AoWs5zkUBcFVelKGCZOGTNA/
 IcHGxwunmGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadenaAAKCRAk1otyXVSH
 0LWkB/9i6gebEUiPrFGHWUrP7hcUH+dp20+tL1pv4d8AVa4txXps3QRzbE28gFC3oVyF6il4Lvv
 oeccZ9lM2qccy0BkRyaC5dx479scwtlYK/DwZFonvow3vyHkSYz07CJU04rZtns4z99lMopMjbT
 +WaUFKNsp7ElC/dpwOjkO6weheqaqm9jrMBbcbt08/Ift8pdRHxsgb2rOq8MnY3PguB7LMkvjno
 kZwDD0XRiAEDkls6iOKSkf8J7AmNe0lbuEJbaPuHnaflCAX49D8H05jT8GNy8yD+wwJlXLDGmn0
 qGeOXxJobJ1OLOOWKCPeUqL4sOcJUBYwNPb1xLGvYeHbw+jo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 07 Apr 2026 16:39:27 -0700, Nishanth Sampath Kumar wrote:
> regmap-i2c: add SMBus byte/word reg16 bus for adapters lacking I2C_FUNC_I2C

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-7.1

Thanks!

[1/1] regmap-i2c: add SMBus byte/word reg16 bus for adapters lacking I2C_FUNC_I2C
      https://git.kernel.org/broonie/sound/c/f7b242428c6c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

