From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: int vs uint
Date: Sun, 20 Jul 2008 12:47:38 -0400
Message-ID: <9e4733910807200947t7abeb0f3i8217766b5392096a@mail.gmail.com>
References: <9e4733910807191746oe5aca3av581bdc5cfab293c3@mail.gmail.com>
	<20080720162356.GA8318@fluff.org.uk>
	<9e4733910807200944m71728a9eldd5a9099ff2829a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910807200944m71728a9eldd5a9099ff2829a5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 7/20/08, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 7/20/08, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
>  > On Sat, Jul 19, 2008 at 08:46:41PM -0400, Jon Smirl wrote:
>  >  > There are a lot places in the i2c API where int is used when the
>  >  > parameter can't be negative. For example, there are more....
>  >  >
>  >  > /*
>  >  >  * The master routines are the ones normally used to transmit data to devices
>  >  >  * on a bus (or read from them). Apart from two basic transfer functions to
>  >  >  * transmit one message at a time, a more complex version can be used to
>  >  >  * transmit an arbitrary number of messages without interruption.
>  >  >  */
>  >  > extern int i2c_master_send(struct i2c_client *,const char* ,int);
>  >  > extern int i2c_master_recv(struct i2c_client *,char* ,int);
>  >  >
>  >  > /* Transfer num messages.
>  >  >  */
>  >  > extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg
>  >  > *msgs, int num);
>  >  >
>  >  >       u8 level;                       /* nesting level for lockdep */
>  >  >
>  >  >
>  >  > Wouldn't these generate more efficient code if switched to uints?
>  >
>  >
>  > I'm not sure, most of the time there's not a lot of difference
>  >  between the signed and unsigned case. If you can provide an example
>  >  of where this is actually true then I would be interested to see...
>
>
> Assigning between lengths causes sign extended instructions. Mixing
>  signed and unsigned in expressions can cause them too.
>
>  You get the best code generation by using int or unsigned int as
>  appropriate and supplying the compiler with the correct description of
>  the variable.

The compiler is also able to catch more errors. If the math can only
yield a negative result and it is being compared to a unsigned int,
you'll get compiler errors like " expression is constant".

>
>
>  >
>  >  Technically, an unsigned int or simply an unsigned would be a
>  >  reasonable change given that you can't really have a minus number
>  >  of transfers.
>  >
>  >
>  >  --
>  >  Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
>  >
>  >   'a smiley only costs 4 bytes'
>  >
>
>
>
> --
>  Jon Smirl
>  jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
