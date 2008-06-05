From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 10:30:05 -0400
Message-ID: <9e4733910806050730i26ed3276me23e18d1b208d621@mail.gmail.com>
References: <20080604201334.19636f30@hyperion.delvare>
	<200806041710.59338.david-b@pacbell.net>
	<9e4733910806041742va67401en608c8c4b8c4c11b9@mail.gmail.com>
	<200806041921.26293.david-b@pacbell.net>
	<9e4733910806042104l70cf8a30sc6329b1c3016c879@mail.gmail.com>
	<20080605104914.2dd622b2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080605104914.2dd622b2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
>  > Doesn't something like this work? (obviously this isn't complete)
>  >
>  > for (address = start; address <= stop;) {
>  >       make a new client
>  >       for (; address <=stop; address++) {
>  >               client->address = address;
>  >               res = device_register(&client->dev);
>  >               if (res != -ENODEV)
>  >                       break;
>  >       }
>  > }
>  > delete the extra client
>
>
> You don't seriously propose to scan all addresses on every I2C bus for
>  every i2c chip driver that we load, do you? This would be awfully slow
>  and dangerous. No way.

This is just a small part of the code, you need to add in all the
other parts from the patch.
Exactly the same addresses would be scanned  under each scheme. .My
question is, does the driver need two entry points (detect and probe)
or could only one (probe) be used? I think detect and probe can be the
same function.

With the detect() function it would look somthing like this:

for (address = start; address <= stop;) {
      for (; address <=stop; address++) {
             do a generic detect
              if (driver->detect(address) {
                     make a new client
                     client->address = address;
                     res = device_register(&client->dev);
                     if (!res)
                            delete the extra client
             }
       }
}





-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
