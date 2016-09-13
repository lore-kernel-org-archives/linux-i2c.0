From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v7] i2c: imx: make bus recovery through pinctrl optional
Date: Tue, 13 Sep 2016 08:47:29 +0200
Message-ID: <20160913064729.6jtwlpkpi36gxtpj@pengutronix.de>
References: <1473718950-6667-1-git-send-email-leoyang.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473718950-6667-1-git-send-email-leoyang.li@nxp.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Li Yang <leoyang.li@nxp.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Gao Pan <pandy.gao@nxp.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 12, 2016 at 05:22:30PM -0500, Li Yang wrote:
> Since commit 1c4b6c3bcf30 ("i2c: imx: implement bus recovery") the
> driver starts to use gpio/pinctrl to support optional bus recovery
> feature.  But pinctrl is not always usable.  There are platforms such
> as ls1021a and ls1043a that don't support pinctrl, and it could just
> be broken due to old/broken device tree.  The patch makes it really
> optional that the probe function won't bailout on pinctrl problems
> instead it just disables bus recovery and prints out notification when
> there is problem with pinctrl.  Since pinctrl is only used by bus
> recovery in this driver, move pinctrl initialization into bus recovery
> init function to prevent confusion.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Cc: Gao Pan <pandy.gao@nxp.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

> Acked-by: Linus Walleij <linus.walleij@linaro.org>

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
