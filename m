From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 1/1] i2c_gpio: keep probe resident for hotplugged
 devices.
Date: Wed, 2 Jul 2008 12:44:06 +0200
Message-ID: <20080702124406.2f3d1384@hskinnemo-gx745.norway.atmel.com>
References: <20080702101611.757880819@fluff.org>
	<20080702101611.858837181@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080702101611.858837181-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Ben-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> Change the i2c_gpio driver to use platform_driver_register()
> instead of platform_driver_probe() to ensure that is can
> attach to any devices that may be loaded after it has initialised.

Does anyone actually do that?

Haavard

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
