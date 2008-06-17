From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Fix Kconfig for I2C-Algos
Date: Tue, 17 Jun 2008 08:36:17 +0200
Message-ID: <20080617083617.6b50ff2d@hyperion.delvare>
References: <3192d3cd0806161024u6a07abddpe4af78b3bb6ec4e7@mail.gmail.com>
	<20080616201545.7e514d36@hyperion.delvare>
	<3192d3cd0806162300j2b8e93a4h3d3c17919d0d562@mail.gmail.com>
	<3192d3cd0806162301r1acdc66eo7f0676b17db8ddee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <3192d3cd0806162301r1acdc66eo7f0676b17db8ddee-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Jun 2008 06:01:52 +0000, Christian Gmeiner wrote:
> > So, it's not a bug, it's a feature. If you have some i2c bus driver
> > which needs an i2c algorithm driver and doesn't select it, fix that
> > driver.
> 
> I see, but whats the plan with external drivers, like
> http://dxr3.sourceforge.net/ ?

First of all: drivers living outside of the kernel tree, get the pain
the deserve. Their authors should really merge their work in the kernel
tree, to avoid this kind of problem and many others.

> Without the manual selection it is not possible to get it working.

Simply select any driver which needs i2c-algo-bit in the kernel tree.
For example "I2C Hardware Bus support > Parallel port adapter (light)".
This will select i2c-algo-bit for you.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
