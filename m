From: "Christian Gmeiner" <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fix Kconfig for I2C-Algos
Date: Tue, 17 Jun 2008 06:01:52 +0000
Message-ID: <3192d3cd0806162301r1acdc66eo7f0676b17db8ddee@mail.gmail.com>
References: <3192d3cd0806161024u6a07abddpe4af78b3bb6ec4e7@mail.gmail.com>
	<20080616201545.7e514d36@hyperion.delvare>
	<3192d3cd0806162300j2b8e93a4h3d3c17919d0d562@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <3192d3cd0806162300j2b8e93a4h3d3c17919d0d562-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>
> So, it's not a bug, it's a feature. If you have some i2c bus driver
> which needs an i2c algorithm driver and doesn't select it, fix that
> driver.

I see, but whats the plan with external drivers, like
http://dxr3.sourceforge.net/ ?
Without the manual selection it is not possible to get it working.

Christian

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
