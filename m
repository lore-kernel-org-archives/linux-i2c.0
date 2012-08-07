From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/1 v2] i2c: Add default configuration into the Nomadik
 I2C driver.
Date: Tue, 7 Aug 2012 11:47:38 +0200
Message-ID: <CACRpkdZjbyQbht+UpXrrVGhAzGYPjb=HRZhJ+TvsEXhGeviJLA@mail.gmail.com>
References: <1344266253-14050-1-git-send-email-lee.jones@linaro.org>
	<20120806153503.GH10524@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120806153503.GH10524@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, w.sang@pengutronix.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 6, 2012 at 5:35 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Looks like I introduced a merge error on the last patch. Trying again:

>  .../mali/mali400ko/driver/src/devicedrv/mali/arch  |    1 +
(...)
> diff --git a/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch b/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch
> new file mode 120000
> index 0000000..427334b
> --- /dev/null
> +++ b/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch
> @@ -0,0 +1 @@
> +/home/ljkenny/projects/linaro/snowball/snowball/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch-ux500
> \ No newline at end of file

NACK, what is this stuff? It's even out-of-tree code.

Please be careful with git add -A, I prefer to use git add <pathspec>
I suspect that may be why this happened...

Please fix it up and send a v3.

Yours,
Linus Walleij
