From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/3] Add support for PCA953[4-8] I2C GPIO
	extenders to the pca953x driver
Date: Thu, 31 Jan 2008 13:20:57 -0800
Message-ID: <200801311320.57437.david-b@pacbell.net>
References: <Pine.LNX.4.64.0801311453470.8478@axis700.grange>
	<Pine.LNX.4.64.0801311500240.8478@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801311500240.8478-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> +/* This is only temporary - should go with 2.6.26. Only introduced now
> + * to avoid a sequence of strcmp() calls and just compare in a loop */
> +struct pca953x_desc {
> +=A0=A0=A0=A0=A0=A0=A0unsigned int=A0=A0=A0=A0gpios;
> +=A0=A0=A0=A0=A0=A0=A0char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*name;
> +};

This is a bit sub-optimal; if it were the same as i2c_device_id then
less code would need to change later.  So I'll probably tweak that bit
before sending it on.

Otherwise, fine ... thanks!

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
