From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Push ioctl BKL down into the i2c code
Date: Fri, 23 May 2008 12:54:10 -0400
Message-ID: <9e4733910805230954r7bc9a46cgfcdb414e82cfa176@mail.gmail.com>
References: <20080522222327.1af72794@core>
	<20080523093545.175c769c@hyperion.delvare>
	<9e4733910805230723n2bbe9d4erf363b3c7b430d415@mail.gmail.com>
	<20080523184049.109ccc0a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080523184049.109ccc0a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 5/23/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Jon,
>
>
>  On Fri, 23 May 2008 10:23:46 -0400, Jon Smirl wrote:
>  > These BKL patches are part of a giant series of patches making the BLK
>  > easier to remove.
>  > There is a write up at LWN about the BKL.
>  > http://lwn.net/Articles/281437/
>
>
> Thanks for the pointer, it all makes sense now. I indeed didn't know
>  that all ioctls were taking the BKL.
>
>
>  > Higher up in the kernel a global lock (BKL - big kernel lock) was
>  > being taken before each IOCTL was called (and some other things). This
>  > has the effect of serializing all IOCTL calls in the kernel. There is
>  > no real need to serialize these IOCTLs in most cases.
>  >
>  > Alan has removed the global lock/unlock code and now replicated it
>  > across the 100s of IOCTLS in the kernel. This patch makes the
>  > lock/unlock calls explicitly visible in the i2c code. He is trying to
>  > remove this global lock since it hurts performance on SMP machines.
>  >
>  > Now some programming needs to happen. The i2c ioctls need to be
>  > inspected to see if they really need to be locked against multiple SMP
>  > processors simultaneously entering them. There are multiple answers to
>  > this question,  Do i2c IOCTLs need to be globally locked against all
>  > other BLK users? Or do you only need a lock which is local to i2c? Or
>  > is no lock needed at all? These question need to be answered for every
>  > IOCTL in Linux.
>
>
> My impression is that we don't need any locking at all. But I am no
>  locking expert, and it's easy to screw up that kind of things.
>
>
>  > i2c probably needs a lock per bus or controller to keep two SMP CPUs
>  > from trying to program the controller simultaneously. Previously the
>  > BKL had been serializing this.
>
>
> This problem already exists (and is already solved) for the various I2C
>  chip drivers inside the kernel: two drivers with chips on the same I2C
>  bus might try to access the bus concurrently. We have a per-adapter
>  mutex to protect against this. I fail to see how user-space access
>  through i2c-dev would be fundamentally different. The only difference I
>  can think of is that i2c-dev can create two clients at the same address
>  while kernel drivers can't - but it doesn't seem to make a difference
>  as far as locking is concerned.

This is the right way to look at the problem. The only code you need
to worry about is the kernel code. But also you need to assume that
most parts (not init/exit) of the i2c kernel code can get two SMP CPUs
in it unless you explicitly use locks to protect it.

Some things that need locks:
1) one user on a bus at a time. this lock should be in the bus driver
2) global lists, don't want two CPUs manipulating a list at the same time.
3) any other global variables

>
>
>  > So, the patch Alan supplied can be applied as is, it is just a
>  > mechanically generated push down of the BKL. Applying it will continue
>  > the same behavior as currently implemented in Linux. But Alan's patch
>  > is probably not the optimal solution for i2c.
>
>
> OK... But my impression is that it is adding code which we will end up
>  removing quickly because it's simply not needed. So I wonder if we
>  shouldn't simply keep:

Alan has just sent you the default solution. If you have a better
solution you can ignore his patch and use yours. He probably hopes
that every patch he is generating gets replaced with a more optimal
solution. He has sent out several hundred patches like this.

>  > >  > diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
>  > >  > index d34c14c..16cf0f2 100644
>  > >  > --- a/drivers/i2c/i2c-dev.c
>  > >  > +++ b/drivers/i2c/i2c-dev.c
>
> > >  > (...)
>
> > >  > @@ -487,7 +509,7 @@ static const struct file_operations i2cdev_fops = {
>  > >  >       .llseek         = no_llseek,
>  > >  >       .read           = i2cdev_read,
>  > >  >       .write          = i2cdev_write,
>  > >  > -     .ioctl          = i2cdev_ioctl,
>  > >  > +     .unlocked_ioctl = i2cdev_ioctl,
>  > >  >       .open           = i2cdev_open,
>  > >  >       .release        = i2cdev_release,
>  > >  >  };
>
>
> And discard all the rest.
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
