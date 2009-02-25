From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Wed, 25 Feb 2009 21:21:19 +0100
Message-ID: <20090225212119.67402391@hyperion.delvare>
References: <1235592618-10880-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1235592618-10880-1-git-send-email-daniel-rDUAYElUppE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

On Wed, 25 Feb 2009 21:10:18 +0100, Daniel Mack wrote:
> This patch adds a driver for Intersil's ISL29003 ambient light sensor
> device plus some documentation. Inspired by tsl2550.c, a driver for a
> similar device.
> 
> Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> ---
>  Documentation/i2c/chips/isl29003 |   62 +++++
>  drivers/i2c/chips/Kconfig        |   10 +
>  drivers/i2c/chips/Makefile       |    1 +

Please read the header of these 2 files again.

>  drivers/i2c/chips/isl29003.c     |  517 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 590 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/i2c/chips/isl29003
>  create mode 100644 drivers/i2c/chips/isl29003.c

-- 
Jean Delvare
