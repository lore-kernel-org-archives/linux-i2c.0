From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] 2c: mv64xxx: Use clk_enable_prepare and
 clk_disable_unprepare
Date: Fri, 22 Jul 2016 09:28:36 +0200
Message-ID: <20160722072836.GO5368@pengutronix.de>
References: <20160720051417.GA21765@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160720051417.GA21765@amitoj-Inspiron-3542>
Sender: linux-kernel-owner@vger.kernel.org
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
List-Id: linux-i2c@vger.kernel.org

there is an i missing in the Subject.

On Wed, Jul 20, 2016 at 10:44:18AM +0530, Amitoj Kaur Chawla wrote:
> Replace clk_enable and clk_prepare with clk_enable_prepare and
> clk_disable and clk_unprepare with clk_disable_unprepare.
>=20
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> expression e;
> @@
>=20
> - clk_prepare(e);
> - clk_enable(e);
> + clk_prepare_enable(e);
>=20
> @@
> expression e;
> @@
>=20
> - clk_disable(e);
> - clk_unprepare(e);
> + clk_disable_unprepare(e);
>=20
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
> Changes in v2:
>         -Rebased patch
>=20
>  drivers/i2c/busses/i2c-mv64xxx.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2=
c-mv64xxx.c
> index 43207f5..79bae48 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -910,10 +910,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  #if defined(CONFIG_HAVE_CLK)
>  	/* Not all platforms have a clk */
>  	drv_data->clk =3D devm_clk_get(&pd->dev, NULL);
> -	if (!IS_ERR(drv_data->clk)) {
> -		clk_prepare(drv_data->clk);
> -		clk_enable(drv_data->clk);
> -	}
> +	if (!IS_ERR(drv_data->clk))
> +		clk_prepare_enable(drv_data->clk);

When you touch this, better add error checking. I wonder why these
functions are not marked __must_check.

Also using IS_ERR(drv_data->clk) is wrong here, becauce devm_clk_get
might return -EPROBE_DEFER.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
