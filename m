From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH][UPDATE] i2c: Add support for virtual I2C adapters
Date: Thu, 29 May 2008 13:54:51 +0200
Message-ID: <20080529135451.7aa9ffde@hyperion.delvare>
References: <20080528133015.GS9698@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080528133015.GS9698-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Rodolfo,

On Wed, 28 May 2008 15:30:15 +0200, Rodolfo Giometti wrote:
> I'd like to know why the patches at:
> 
>    http://lists.linuxcoding.com/kernel/2006-q1/msg32516.html
> 
> have never been applied to the main kernel tree.

There are two main reasons:

1* Nobody reviewed the patches in question. I don't even remember
seeing test reports about these patches, but this could as well be my
defective memory. A patch affecting i2c-core definitely needs good
review and testing before it can go upstream.

2* When this patch was sent, the i2c subsystem was still using the
legacy model where device drivers have to probe for and instantiate
their devices themselves. This model is fundamentally incompatible with
a generic for of I2C multiplexing support. So I didn't pay too much
attention to attempts to support multiplexing of i2c adapters because I
suspected it would be ugly at best. Now that we have new-style i2c
device/driver binding which follows the device driver model, it's
probably the right time to think about multiplexing support again.

Another reason, I guess, is that I do not have any system with a
multiplexed I2C bus myself, so I can't test the code and I also lack
personal motivation to push this forward.

There are still some cleanups needed in i2c-core, most notably with
respect to duplication and locking, and ideally I'd like to see it done
before we add multiplexing support, but admittedly there is no roadmap
so I can't make this a mandatory requirement.

> I'd like to use them and maybe I can update them to the latest kernel
> version for submission. :)

You are welcome to update and resubmit the patch, however I suspect
that what is needed is more than that. The code was written with the
legacy model in mind, while we want to support primarily (and maybe
even exclusively) the new-style binding model.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
