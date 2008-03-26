From: Andre Haupt <andre@bitwigglers.org>
Subject: Re: [PATCH 1/1] Input/Joystick Driver: add support AD7142 joystick driver
Date: Wed, 26 Mar 2008 11:18:50 +0100
Message-ID: <20080326101850.GA9184@ahaupt-debian-vm.localdomain>
References: <1206579622-21915-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1206579622-21915-1-git-send-email-cooloney@kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: dmitry.torokhov@gmail.com, khali@linux-fr.org, linux-input@vger.kernel.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <bryan.wu@analog.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 26, 2008 at 06:00:22PM -0700, Bryan Wu wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Bryan Wu <bryan.wu@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> ---
>  drivers/input/joystick/Kconfig  |    6 +
>  drivers/input/joystick/Makefile |    1 +
>  drivers/input/joystick/ad7142.c |  447 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 454 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/joystick/ad7142.c
> 
> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> index 7c662ee..e65aeb6 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -282,4 +282,10 @@ config JOYSTICK_XPAD_LEDS
>  	  This option enables support for the LED which surrounds the Big X on
>  	  XBox 360 controller.
>  
> +config JOYSTICK_AD7142
> +	tristate "Analog Devices AD7142 Joystick support"
> +	depends on BLACKFIN && I2C
does this really have to depend on Blackfin?

regards,

Andre
