From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH -next v4 2/3] media: ov772x: use SCCB regmap
Date: Mon, 23 Jul 2018 18:13:02 +0300
Message-ID: <20180723151302.7uhfsm7fyrlq62qq@valkosipuli.retiisi.org.uk>
References: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
 <1531756070-8560-3-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531756070-8560-3-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-media@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Wolfram Sang <wsa@the-dreams.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hans.verkuil@cisco.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>
List-Id: linux-i2c@vger.kernel.org

Hi Mita-san,

On Tue, Jul 17, 2018 at 12:47:49AM +0900, Akinobu Mita wrote:
> Convert ov772x register access to use SCCB regmap.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  drivers/media/i2c/Kconfig  |   1 +
>  drivers/media/i2c/ov772x.c | 192 +++++++++++++++++++--------------------------
>  2 files changed, 82 insertions(+), 111 deletions(-)

I'll pick the two patches up when the SCCB regmap support has reached media
tree master. Thanks.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
