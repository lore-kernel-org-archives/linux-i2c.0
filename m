From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] platform/chrome: cros_ec: Rename cros_ec_dev to
 cros_ec_mfd_dev
Date: Fri, 22 Nov 2019 07:58:04 +0000
Message-ID: <20191122075804.GB3296@dell>
References: <20191121164458.1.Ie5c276b95210779fc2ca5651e46552236795b6b9@changeid>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191121164458.1.Ie5c276b95210779fc2ca5651e46552236795b6b9@changeid>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: enric.balletbo@collabora.com, Mauro Carvalho Chehab <mchehab@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, linux-iio@vger.kernel.org, Fabien Lahoudere <fabien.lahoudere@collabora.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, Enrico Granata <egranata@chromium.org>, linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Sebastian Reichel <sre@kernel.org>, Douglas Anderson <dianders@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-media@vger.kernel.org, linux-pm@vger.kernel.or
List-Id: linux-i2c@vger.kernel.org

On Thu, 21 Nov 2019, Raul E Rangel wrote:

> It's very confusing having cros_ec_dev and cros_ec_device. This makes it
> clear you are dealing with the mfd device.

An MFD isn't really a thing. It's a Linuxisum that doesn't really
describe anything meaningful. IMHO it would make more sense to follow
the same hierarchical structure that platform devices use:

  s/cros_ec_mfd_dev/cros_ec_parent/

> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> This is based on top of the i2c acpi tunnel patches:
> https://lore.kernel.org/patchwork/project/lkml/list/?series=419791
> 
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c       |  2 +-
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  2 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  2 +-
>  .../cros_ec_sensors/cros_ec_sensors_ring.c    |  2 +-
>  drivers/iio/light/cros_ec_light_prox.c        |  2 +-
>  drivers/iio/pressure/cros_ec_baro.c           |  2 +-
>  .../media/platform/cros-ec-cec/cros-ec-cec.c  |  2 +-
>  drivers/mfd/cros_ec_dev.c                     | 14 ++++-----
>  drivers/platform/chrome/cros_ec_chardev.c     | 21 +++++++-------
>  drivers/platform/chrome/cros_ec_debugfs.c     | 16 +++++-----
>  drivers/platform/chrome/cros_ec_lightbar.c    | 29 ++++++++++---------
>  drivers/platform/chrome/cros_ec_pd_sysfs.c    |  6 ++--
>  drivers/platform/chrome/cros_ec_pd_update.c   | 20 ++++++-------
>  drivers/platform/chrome/cros_ec_sysfs.c       | 16 +++++-----
>  drivers/platform/chrome/cros_ec_vbc.c         |  8 ++---
>  drivers/platform/chrome/cros_usbpd_logger.c   |  6 ++--
>  drivers/power/supply/cros_usbpd-charger.c     |  6 ++--
>  drivers/rtc/rtc-cros-ec.c                     |  2 +-
>  include/linux/mfd/cros_ec.h                   |  8 ++---
>  .../linux/platform_data/cros_ec_pd_update.h   |  4 +--
>  21 files changed, 87 insertions(+), 85 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
