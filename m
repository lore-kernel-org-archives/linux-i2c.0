From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/3] Second stage extending the pca953x GPIO
	driver - change Kconfig, "sed" files
Date: Thu, 31 Jan 2008 13:25:38 -0800
Message-ID: <200801311325.38412.david-b@pacbell.net>
References: <Pine.LNX.4.64.0801311453470.8478@axis700.grange>
	<Pine.LNX.4.64.0801311456280.8478@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801311456280.8478-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
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
> +=A0=A0=A0=A0=A0=A0=A0 =A0Say yes here to support the PCA9534 (8-bit), PC=
A9535 (16-bit),
> +=A0=A0=A0=A0=A0=A0=A0 =A0PCA9536 (4-bit), PCA9537 (4-bit), PCA9538 (8-bi=
t), and PCA9539
> +=A0=A0=A0=A0=A0=A0=A0 =A0(16-bit) I/O ports. These parts are made by NXP=
 and TI.

Yeah, let's ignore the pca9554/55/56/57/58 for now.
Even though this driver should handle those too.  ;)

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
