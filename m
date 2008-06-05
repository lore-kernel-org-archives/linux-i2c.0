From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 20:29:11 +0200
Message-ID: <20080605202911.7b4c3ee4@hyperion.delvare>
References: <20080604201334.19636f30@hyperion.delvare>
	<200806041921.26293.david-b@pacbell.net>
	<9e4733910806042104l70cf8a30sc6329b1c3016c879@mail.gmail.com>
	<200806050118.23706.david-b@pacbell.net>
	<9e4733910806050755n3835d20xfc4d018c2222d5d3@mail.gmail.com>
	<20080605190034.16f06604@hyperion.delvare>
	<9e4733910806051034k2e40082focaaa03b124fcd4ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910806051034k2e40082focaaa03b124fcd4ad-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 5 Jun 2008 13:34:59 -0400, Jon Smirl wrote:
> What about live CDs and things like that? I do agree that there is no
> immediate need to do something like this. But in the long run a scheme
> like this could eliminate the need for sensors-detect.

Why do you want to eliminate sensors-detect in the first place? If you
really want to load the sensor drivers automatically, just run
sensors-detect at boot time.

> It doesn't take as long to load/unload the modules as you might think,

I just tested, that's 2.3 s on my system, and then 0.85 s to unload the
drivers. So, total 3 s. I certainly don't want my system to take 3 more
seconds to load. And that's the best case, at HZ=1000. At HZ=100 it
will be worse.

Anyway, if you really want to load all the drivers at boot time, this
should be a user-space decision and not a kernel-space decision. It can
already be done in user-space today (but note that no distribution does
this, thankfully), so you're trying to solve a problem that doesn't
really exist.

> they would all be on an initrd. The probing time should be the same as

2.1 MB of hwmon drivers in initrd? To be added to all the i2c bus
drivers... I doubt anybody wants this. These drivers aren't needed to
boot the system so why put them in initrd? Furthermore, I don't see how
we care if the drivers are in initrd or not.

> the sensors-detect script. Maintenance would be better since the
> detection code would only exist in one place instead of two.

Admittedly it would be nice to have only one set of detection code to
maintain. But there are many drawbacks. For example, how do you detect
devices we don't yet support? Or devices that are supported in a later
kernel? Devices for which the user didn't build the driver yet? It is
very easy to point users to the latest version of sensors-detect and ask
them to run it. Compare this to "you have to upgrade to the latest
kernel and build all the drivers first and only then we can tell you
the one you need".

> File this away to think about for the future. After the drivers are
> converted to the new model and have the ability to detect this can be
> experimented with.

You are free to experiment with whatever you want, of course, but my
feeling is that you are going in the wrong direction. If anything, I'd
rather make sensors-detect safer, faster and more controllable (command
line interface...) than trying to move it inside the kernel.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
