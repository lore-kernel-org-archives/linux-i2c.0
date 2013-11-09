From: Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GPF in i2cdev_release with i2c_tiny_usb
Date: Sat, 9 Nov 2013 15:30:15 +0100
Message-ID: <CAOE8yMA4RSnY0=PhB4qf0d5f9QF8n5pLozdM3wFiaoAb=9bt0Q@mail.gmail.com>
References: <CAOE8yMAKrU3zFe9VU7sFdjRK_0_Kj4gT6_APptabsJ4t+w=U1w@mail.gmail.com>
	<CAOE8yMBDtvcXMVqWatrSaW+873-ezF2GYt4ttvd-8oQbuYgYvg@mail.gmail.com>
Reply-To: mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOE8yMBDtvcXMVqWatrSaW+873-ezF2GYt4ttvd-8oQbuYgYvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Sat, Nov 9, 2013 at 1:52 PM, Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> No. I think the GPF only happens if an application has an open
> file descriptor.
> Just tested ~5 dis/reconnect USB without problem,
> started an application which opens i2c-7 USB disconnect->crash.

I have modified i2cdev_release in i2c-dev.c to:

static int i2cdev_release(struct inode *inode, struct file *file)
{
        struct i2c_client *client = file->private_data;
        pr_debug("i2c-dev: i2cdev_release -1:%p\n",client);
        pr_debug("i2c-dev: i2cdev_release -1a:%p\n",client->adapter);
        return 0;       // DO NOTHING

        i2c_put_adapter(client->adapter);
        pr_debug("i2c-dev: i2cdev_release -2\n");
        kfree(client);
        file->private_data = NULL;
        pr_debug("i2c-dev: i2cdev_release -3\n");
        return 0;
}

with this the kernel crash is gone.
Thus not calling i2c_put_adapter(client->adapter); helps.
Both pointers (client,client->adapter) are not NULL, but I cannot
say if they contain anything still valid.
But even doing the call to i2c_put_adapter and modifing it to:

void i2c_put_adapter(struct i2c_adapter *adap)
{
        pr_debug("i2c-dev: i2c_put_adapter:\n");
        //module_put(adap->owner);
}

crashes the kernel. which is strange because its a NOP.


Btw: if the crash occurs a reboot is not necessary.
For testing I have removed the i2c-dev module with:

rmmod -f i2c-dev

regards,

Martin
