From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 10:55:28 -0400
Message-ID: <9e4733910806050755n3835d20xfc4d018c2222d5d3@mail.gmail.com>
References: <20080604201334.19636f30@hyperion.delvare>
	<200806041921.26293.david-b@pacbell.net>
	<9e4733910806042104l70cf8a30sc6329b1c3016c879@mail.gmail.com>
	<200806050118.23706.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806050118.23706.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 6/5/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Wednesday 04 June 2008, Jon Smirl wrote:
>
> > Now that we've had this discussion it looks to me that the scan
>  > capability should be added to struct i2c_driver instead of being
>  > standalone.
>  >
>  > I guess what is a little strange to me is that the pre-probe()
>  > function is like a static driver function and probe() is an instance
>  > function.
>
>
> The problem there is:  how do you know which pre-probe()
>  function(s) to try?  If you could answer that reliably
>  you'd be able to probe() directly.  If you can't, you'd
>  need to load all I2C driver modules until one works...
>  not the desired system model.
>

I see now that the adapter class should be added to the driver name
alias string. The we could load all modules of a given class.

But I don't think we need to go searching for the right module to load
since i2c is not generally a dynamic bus. If you install a video card
with an i2c bus, the driver for the video card can just load_module
the right i2c driver modules.

I do wonder if we could get hardware monitors to autoload. When the
adapter driver for the motherboard loads, it could load module all
drivers of class hardware_monitor. Then each one could do its
detection thing. Unload the ones that weren't found. That would really
help people who can figure out the right driver module to load. You
could even get fancy and generate a uevent after the right module was
found. A script in the uevent could save the info so you don't have to
repeat on each boot. Of course this assume that the hardware monitor
modules can reliably autodetect.


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
