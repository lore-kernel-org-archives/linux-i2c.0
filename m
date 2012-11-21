From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-s3c2410: Remove recently introduced performance overheads
Date: Tue, 20 Nov 2012 21:08:32 -0800
Message-ID: <CAOesGMhBZo6gKfzs1A954a_vaAMzy4px3TsgKE2rac_igH3sLw@mail.gmail.com>
References: <1353471131-23975-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353471131-23975-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 20, 2012 at 8:12 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> The changes in "i2c-s3c2410: use exponential back off while polling for
> bus idle" remove the initial busy wait for I2C transfers to complete and
> replace it with usleep_range() calls which will schedule.
>
> Since for older SoCs I2C transfers would usually complete within an
> extremely small number of CPU cycles there is a win from not having to
> schedule.  This happens because on the older SoCs the cores run at a
> smaller multiple of the speeds that the I2C bus is operating at; on more
> modern SoCs the busy wait is less likely to be effective.
>
> Fix the issue by restoring the busy wait, reducing the number of spins
> from 20 to 3 which covers the overwhelming majority of I2C transfers on
> the SoCs where the busy wait is effective.
>
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

Acked-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>


-Olof
