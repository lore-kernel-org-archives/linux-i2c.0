From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Wed, 22 Oct 2008 23:15:26 -0700
Message-ID: <200810222315.26576.david-b@pacbell.net>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru> <20081022104606.GA510@oksana.dev.rtsoft.ru> <20081022183218.GA19025@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754755AbYJWGPk@vger.kernel.org>
In-Reply-To: <20081022183218.GA19025@oksana.dev.rtsoft.ru>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 22 October 2008, Anton Vorontsov wrote:
> --- a/drivers/gpio/pcf857x.c
> +++ b/drivers/gpio/pcf857x.c
> @@ -187,7 +187,7 @@ static int pcf857x_probe(struct i2c_client *clien=
t,
> =A0=A0=A0=A0=A0=A0=A0=A0struct pcf857x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0*gpio;
> =A0=A0=A0=A0=A0=A0=A0=A0int=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0status;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0pdata =3D client->dev.platform_data;
> +=A0=A0=A0=A0=A0=A0=A0pdata =3D pcf857x_get_pdata(client);
> =A0=A0=A0=A0=A0=A0=A0=A0if (!pdata)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> =A0

I suppose that can work.  Regardless, some OF-specific code will
need to map device tree state into a generic format that's fully
decoupled from OF.  (And there's something to be said to having
that mapping sit in the same directory as the driver needing it.)
