From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V10 Resend] i2c/designware: Provide i2c bus recovery support
Date: Wed, 24 Jul 2013 14:46:55 +0530
Message-ID: <CAKohpokWrC3Zp6vmtOXoGDaD_GkDV6cLwTVAoDUcLSLb6tjAxw@mail.gmail.com>
References: <70c7ee79478cc2b89ad876d814207c6433e26a59.1371474881.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <70c7ee79478cc2b89ad876d814207c6433e26a59.1371474881.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 17 June 2013 18:46, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Add bus recovery support for designware_i2c controller. It uses generic gpio
> based i2c_gpio_recover_bus() routine. Platforms need to pass struct
> i2c_bus_recovery_info as platform data to designware I2C controller.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>
> This patch isn't drawing attention since sometime, so sending it again.
>
>  drivers/i2c/busses/i2c-designware-core.c    | 5 ++++-
>  drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)

Ping!!
