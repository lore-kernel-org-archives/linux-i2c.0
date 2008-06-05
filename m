From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 00:04:00 -0400
Message-ID: <9e4733910806042104l70cf8a30sc6329b1c3016c879@mail.gmail.com>
References: <20080604201334.19636f30@hyperion.delvare>
	<200806041710.59338.david-b@pacbell.net>
	<9e4733910806041742va67401en608c8c4b8c4c11b9@mail.gmail.com>
	<200806041921.26293.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806041921.26293.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On 6/4/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Wednesday 04 June 2008, Jon Smirl wrote:
>
> > On 6/4/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
>  > >  > It then looks at that information and decides if it wants to
>  > >  > bind. Drivers return true/false if they want to bind.
>  > >
>  > >
>  > > Wrong.  The probe returns zero if it bound, else negative errno.
>  > >  Those functions don't return booleans.
>  >
>  > You guys are so literal. I should have said return 0 or -ENODEV or
>  > some other error.
>
>
> You seemed intent on describing some new and never-seen-before
>  model for how driver model probing works, though ...

I don't think it is out of the scope of what already exists. The
alternative is to add a new pre-probe() API which does the function of
the original probe and then calls the current probe(). Why don't we
just stick with probe() and use it like it was before we had things
like ACPI?

Now that we've had this discussion it looks to me that the scan
capability should be added to struct i2c_driver instead of being
standalone.

I guess what is a little strange to me is that the pre-probe()
function is like a static driver function and probe() is an instance
function. Are there other examples of static driver  functions? Which
way you do it is a style question, they will both work.

Doesn't something like this work? (obviously this isn't complete)

for (address = start; address <= stop;) {
	make a new client
	for (; address <=stop; address++) {
		client->address = address;
		res = device_register(&client->dev);
		if (res != -ENODEV)
			break;
	}
}
delete the extra client


Can these driver functions be eliminated?
	int (*attach_adapter)(struct i2c_adapter *);
	int (*detach_adapter)(struct i2c_adapter *);
	int (*detach_client)(struct i2c_client *);

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
