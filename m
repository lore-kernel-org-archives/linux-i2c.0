From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 13:34:59 -0400
Message-ID: <9e4733910806051034k2e40082focaaa03b124fcd4ad@mail.gmail.com>
References: <20080604201334.19636f30@hyperion.delvare>
	<200806041921.26293.david-b@pacbell.net>
	<9e4733910806042104l70cf8a30sc6329b1c3016c879@mail.gmail.com>
	<200806050118.23706.david-b@pacbell.net>
	<9e4733910806050755n3835d20xfc4d018c2222d5d3@mail.gmail.com>
	<20080605190034.16f06604@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080605190034.16f06604-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 6/5/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Thu, 5 Jun 2008 10:55:28 -0400, Jon Smirl wrote:
>  > I see now that the adapter class should be added to the driver name
>  > alias string. The we could load all modules of a given class.
>
>
> Ah ah. Oh wait, you were serious? Come on, why would anyone on earth
>  want to load all modules of a given class?
>
>
>  > But I don't think we need to go searching for the right module to load
>  > since i2c is not generally a dynamic bus. If you install a video card
>  > with an i2c bus, the driver for the video card can just load_module
>  > the right i2c driver modules.
>
>
> Sometimes yes, sometimes no. For most V4L/DVB, the main driver should
>  know which i2c chip drivers it needs, but unfortunately for old drivers
>  such as bttv this knowledge has never been recorded, so there is no
>  alternative to (at least partial) probing in practice. For video
>  adapters, they could load the eeprom driver as they all give access to
>  EDID EEPROMs, but if the card also has a hardware monitoring chip, we
>  simply don't know what it is. We just can't record in the kernel
>  drivers what hardware monitoring chip exists on thousands of cards out
>  there (same problem as for motherboards.)
>
>
>  > I do wonder if we could get hardware monitors to autoload.
>
>
> Only if they don't do the device detection/identification themselves.
>  I've considered it for a moment but now I'm fairly certain that it
>  would be a dangerous and unmaintainable mess. Better let each driver
>  include its detection/identification routine, and delegate the
>  responsibility of loading the right driver to user-space (as is already
>  the case.)
>
>
>  > When the
>  > adapter driver for the motherboard loads, it could load module all
>  > drivers of class hardware_monitor.
>
>
> No, really, forget about this, that's simply never going to happen.
>  That's way too costly and dangerous.
>
>
>  > Then each one could do its
>  > detection thing. Unload the ones that weren't found.
>
>
> And do it all over again when the graphics adapter driver is loaded?
>  And when an parport-to-I2C or USB-to-I2C adapter is plugged?
>
>
>  > That would really
>  > help people who can figure out the right driver module to load.
>
>
> If people can't run "sensors-detect" there's not much we can do for
>  them ;)

What about live CDs and things like that? I do agree that there is no
immediate need to do something like this. But in the long run a scheme
like this could eliminate the need for sensors-detect.

It doesn't take as long to load/unload the modules as you might think,
they would all be on an initrd. The probing time should be the same as
the sensors-detect script. Maintenance would be better since the
detection code would only exist in one place instead of two.

File this away to think about for the future. After the drivers are
converted to the new model and have the ability to detect this can be
experimented with.


>
>
>  > You
>  > could even get fancy and generate a uevent after the right module was
>  > found. A script in the uevent could save the info so you don't have to
>  > repeat on each boot. Of course this assume that the hardware monitor
>  > modules can reliably autodetect.
>
>
> You mean, instead of just using the sensors-detect script which we
>  already have and has worked fine for (almost) everyone for 8 years now?
>  And the few cases where sensors-detect didn't work are a very good
>  reason to _not_ attempt to do the same in the kernel. SMBus probing is
>  _very_ tricky and we really want to control everything that happens.
>
>  --
>
> Jean Delvare
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
