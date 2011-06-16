From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-ocores timeout bug
Date: Thu, 16 Jun 2011 18:52:09 +0200
Message-ID: <20110616185209.08ef41ed@endymion.delvare>
References: <BANLkTikEESnV9+hc=VFg=qFGOXeg4o0sOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTikEESnV9+hc=VFg=qFGOXeg4o0sOQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Worsley <amworsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On Wed, 15 Jun 2011 08:33:45 +1000, Andrew Worsley wrote:
> Hi, I have hit upon a bug in this driver in the 2.6.32 which caused
> memory corrupt and crash in my kernel. It appears to be still present
> in 3.0-rc3 so as you are listed as the current  kernel i2c maintainers
> which covers i2c-ocores I thought you could comment on it and the
> proposed fix I enclose below.

The same MAINTAINERS file also says that Peter Korsgaard is maintaining
the i2c-ocores driver, so he would be an even better recipient for your
request. Cc'd. Peter, can you please review the patch? Thanks.

> 
> Basically the i2c-ocores xfer function, kicks off an interrupt driven
> array of i2c_msg transfers and waits 1second for it to complete and
> just
> returns -ETIMEDOUT if it times out. The interrupt driven transfer is
> *not* stopped on a time out and continues referencing the i2c_msg
> structure. In my
> case an i2c read the interrupt handler keeps adding bytes to the
> structure. Unfortunately after the time out the structure was released
> and it's length field was changed to a large number and the interrupt
> driver kept happily writing bytes way past the end of the original
> buffer until the kernel crashed or locked up!
> 
> Below is a fix that works for me in 2.6.32 which removes the i2c_msg
> buffer from the interrupt handler and changes the handler to check for
> it's removal.
> 
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index 8dee246..21e57a0 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -137,6 +137,12 @@ static void ocores_process(struct ocores_i2c *i2c)
>                 wake_up(&i2c->wait);
>                 return;
>         }
> +       if (msg == 0) {
> +       /* Caller has with drawn the request, buffer no longer available */
> +           i2c->state = STATE_ERROR;
> +           oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
> +           return;
> +       }
> 
>         /* error? */
>         if (stat & OCI2C_STAT_ARBLOST) {
> @@ -223,8 +229,13 @@ static int ocores_xfer(struct i2c_adapter *adap,
> struct i2c_msg *msgs, int num)
>         if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
>                                (i2c->state == STATE_DONE), HZ))
>                 return (i2c->state == STATE_DONE) ? num : -EIO;
> -       else
> +       else {
> +               printk(KERN_NOTICE
> +               "ocores_xfer() i2c transfer to %d-%#x timed out\n",
> +                       i2c_adapter_id(adap), msgs->addr);
> +               i2c->msg = 0; /* remove the caller's request which
> will be re-used */
>                 return -ETIMEDOUT;
> +       }
>  }
> 
>  static void ocores_init(struct ocores_i2c *i2c)
> 
> Andrew
> 
> Some more details of the failure -
> 
> Here's the user space command that causes the lock up:
> 
>    i2cdump -y 4 0x50 i
> 
> Note: With out the i, it performs one byte transfers and is fine. It
> seems my i2c-ocores i2c transfers go *very* slowly and in order to get
> the above command to not time out I had to bump up the i2c-ocores time
> out value to 3s. I suspect that's not necessary for normal situation
> which is why this bug may not have been noticed before. Also most
> other transactions are usually one byte device probes which don't get
> a response. In my case the interrupts appear to be slow - taking some
> 15 bytes over one second and there is plenty more data if the
> interrupt driver wants to keep reading.
> 
> Here's the transfer function and you can see how it just waits for
> 1sec and then fails the request with out stopping the interrupt driver
> from continuing to reference the request data:
> 
>  static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> {
> 	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> 
> 	i2c->msg = msgs;
> 	i2c->pos = 0;
> 	i2c->nmsgs = num;
> 	i2c->state = STATE_START;
> 
> 	oc_setreg(i2c, OCI2C_DATA,
> 			(i2c->msg->addr << 1) |
> 			((i2c->msg->flags & I2C_M_RD) ? 1:0));
> 
> 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
> 
> 	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
> 			       (i2c->state == STATE_DONE), HZ))
> 		return (i2c->state == STATE_DONE) ? num : -EIO;
> 	else
> 		return -ETIMEDOUT;
> }
> 
> My kernel would crash with various faults including:  "Thread overran
> stack, or stack corrupted".
> I added in some debugging into the i2c-ocores module and traced things
> down to apparently a corruption of the len field of the i2c transfer
> i2c_msg structure:
> 
> The above i2cdump command generates an i2c_msg read transfer for 32
> bytes of data. At the 16th byte of read data the length field is
> over-written with 49844 :
> 
> Read finished 1 xfers left
> ocores_process() state=1 status=0x41
> ocores_process() Read addr=0x50 len=32
> ocores_process() state=3 status=0x41
> Read [0] = 0x6 len=32
> ocores_process() state=3 status=0x41
> Read [1] = 0x40 len=32
> ocores_process() state=3 status=0x41
> Read [2] = 0x55 len=32
> ocores_process() state=3 status=0x41
> Read [3] = 0x0 len=32
> ocores_process() state=3 status=0x41
> Read [4] = 0xfb len=32
> ocores_process() state=3 status=0x41
> Read [5] = 0x0 len=32
> ocores_process() state=3 status=0x41
> Read [6] = 0x50 len=32
> ocores_process() state=3 status=0x41
> Read [7] = 0x0 len=32
> ocores_process() state=3 status=0x41
> Read [8] = 0x0 len=32
> ocores_process() state=3 status=0x41
> Read [9] = 0x0 len=32
> ocores_process() state=3 status=0x41
> Read [10] = 0xcf len=32
> ocores_process() state=3 status=0x41
> Read [11] = 0xde len=32
> ocores_process() state=3 status=0x41
> Read [12] = 0xe6 len=32
> ocores_process() state=3 status=0x41
> Read [13] = 0xdc len=32
> ocores_process() state=3 status=0x41
> Read [14] = 0xea len=32
> ocores_process() state=3 status=0x41
> Read [15] = 0xff len=49844
> ocores_process() state=3 status=0x41
> Read [16] = 0x96 len=49844
> ocores_process() state=3 status=0x41
> ....
> 
>         It happily continues past the end of the buffer at 32 ...
> 
> Read [28] = 0x18 len=49844
> ocores_process() state=3 status=0x41
> Read [29] = 0xa5 len=49844
> ocores_process() state=3 status=0x41
> Read [30] = 0x31 len=49844
> ocores_process() state=3 status=0x41
> Read [31] = 0x27 len=49844
> ocores_process() state=3 status=0x41
> Read [32] = 0x1f len=49844
> ocores_process() state=3 status=0x41
> Read [33] = 0x7 len=49844
> ocores_process() state=3 status=0x41
> Read [34] = 0x3d len=49844
> ocores_process() state=3 status=0x41
> Read [35] = 0xe6 len=49844
> ocores_process() state=3 status=0x41
> Read [36] = 0x0 len=49844
> ocores_process() state=3 status=0x41
> Read [37] = 0x64 len=49844
> .....
> 
>    It then continues till it stomps on something and gets some sort of fault....
> 
> Read [220] = 0x8 len=58644
> ocores_process() state=3 status=0x41
> Read [221] = 0x60 len=58644
> ocores_process() state=3 status=0x41
> Read [222] = 0x43 len=58644
> ocores_process() state=3 status=0x41
> Read [223] = 0x49 len=58644
> ocores_process() state=3 status=0x41
> Read [224] = 0x0 len=58644
> PANIC: double fault, gdt at c1400000 [255 bytes]
> double fault, tss at c1404300
> eip = c032b5a3, esp = c03fa000
> eax = c03fa020, ebx = df16e4e0, ecx = 0000007b, edx = 00000009
> esi = de545580, edi = c0119427
> Read [28] = 0x18 len=49844

-- 
Jean Delvare
