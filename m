From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 01:18:23 -0700
Message-ID: <200806050118.23706.david-b@pacbell.net>
References: <20080604201334.19636f30@hyperion.delvare>
	<200806041921.26293.david-b@pacbell.net>
	<9e4733910806042104l70cf8a30sc6329b1c3016c879@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910806042104l70cf8a30sc6329b1c3016c879-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 04 June 2008, Jon Smirl wrote:
> Now that we've had this discussion it looks to me that the scan
> capability should be added to struct i2c_driver instead of being
> standalone.
> =

> I guess what is a little strange to me is that the pre-probe()
> function is like a static driver function and probe() is an instance
> function.

The problem there is:  how do you know which pre-probe()
function(s) to try?  If you could answer that reliably
you'd be able to probe() directly.  If you can't, you'd
need to load all I2C driver modules until one works...
not the desired system model.


> Are there other examples of static driver =A0functions? =


Module load and unload code; platform_driver_probe() type stuff.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
