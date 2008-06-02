From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2/8] I2C: S3C2410: Add MODULE_ALIAS() for s3c2440
 device.
Date: Mon, 2 Jun 2008 08:59:55 +0200
Message-ID: <20080602085955.5fe2f0fe@hyperion.delvare>
References: <20080529132244.818543231@fluff.org.uk>
	<20080529132406.186957190@fluff.org.uk>
	<20080530215452.2ee3d4a7@hyperion.delvare>
	<20080601215102.GJ7334@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080601215102.GJ7334-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 1 Jun 2008 22:51:02 +0100, Ben Dooks wrote:
> On Fri, May 30, 2008 at 09:54:52PM +0200, Jean Delvare wrote:
> > That being said, I think the approach is wrong. You shouldn't register
> > two different platform drivers just to be able to differentiate between
> > device types. You have platform_data for that, it's cleaner and cheaper.
> 
> Actually, there are down sides to doing it via platform data, and a few
> upsides to using the driver model. I do agree that >1 driver does mean
> that you end up allocating more space to the drivers, but I hope that
> I can convince you that this isn't without merit. 
> 
> The following are downsides:
> 
> 1) using platform data means that not only do all the boards that have
>    i2c busses on (or other peripherals using this method) need to carry[1]
>    and register platform data even if they do not need to.
> 
> 2) We currently change the name of the platform device in the cpu specific
>    architecture initialisation, which would mean either moving this to each
>    machine or have some form of sharing between the arch code and the board
>    init. 
> 
> 3) Some boards can have more than one cpu type on them, which makes life
>    even worse for the above.
> 
> The advantage of changing the name of the platform device means that the
> type of device is shown in the /sys/devices/platform heirachy without any
> need for code to add a new attribute to show it within the device itself.
> 
> 
> [1] Even if this is __initdata, it means the kernel has to carry it to
>     load it even if it gets dumped at startup, and we have a number of
>     boards that are available.
> 

Out of 6 platform driver in the kernel tree that do this, 5 were
written by you. So apparently not many developers share your opinion
that it's the best way to do it.

Anyway, I'm not going to argue any longer, it's your driver and your
platform and you do pretty much what you want with it.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
