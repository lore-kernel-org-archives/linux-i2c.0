From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] i2c: s3c24xx: allow compile-testing
Date: Wed, 8 Jan 2020 07:59:22 +0100
Message-ID: <CAJKOXPfYYyBWED-f67-suWPOzwRjB3VtncnkDPeiTMiankTR8w@mail.gmail.com>
References: <20200107215406.1632417-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107215406.1632417-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Max Staudt <max@enpas.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, Stefan Roese <sr@denx.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 7 Jan 2020 at 22:54, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The PHY_EXYNOS5250_SATA driver can now be selected on
> any platform for compile testing, but this results in a Kconfig
> warning:
>
> WARNING: unmet direct dependencies detected for I2C_S3C2410
>   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && HAVE_S3C2410_I2C [=n]
>   Selected by [y]:
>   - PHY_EXYNOS5250_SATA [=y] && (SOC_EXYNOS5250 || COMPILE_TEST [=y]) && HAS_IOMEM [=y] && OF [=y]
>
> Allow the I2C driver to be compile-tested as well.
>
> Fixes: 1544133d48c3 ("phy: Enable compile testing for some of drivers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi,

I already posted this with my first patchset of compile test addons:
v2: https://lore.kernel.org/lkml/1578384779-15487-1-git-send-email-krzk@kernel.org/
v1: https://lore.kernel.org/lkml/20191230172751.17985-5-krzk@kernel.org/

Best regards,
Krzysztof
