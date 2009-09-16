From: "Chuck Kamas" <ckamas-mizZ2TCXIxVBDgjK7y7TUQ@public.gmane.org>
Subject: How to manually call i2c_client's probe from i2c-dev.c ioctl
Date: Wed, 16 Sep 2009 09:56:37 -0700
Message-ID: <C62896630644CE43BF64B0FF0AC27F0E18153F@mail.ad.skymv.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

I am trying to backport Michael's patch to add PROBE and REMOVE ioctls
to 2.6.21
http://article.gmane.org/gmane.linux.drivers.i2c/3339/match=ioctls+probe

I have been able to add the IOCTLS and re-compile the kernel module, but
am confused as to what function to call in the old device model.  I
believe that I should use i2c_attach_client() from i2c-core.c.  Is this
correct?

This is what I have so far:

I2c-dev.c:
static int i2cdev_ioctl(struct inode *inode, struct file *file,
		unsigned int cmd, unsigned long arg)
{
	char   *colon, request[I2C_NAME_SIZE + 5];
	char   probeTemp[I2C_NAME_SIZE];
	int    addr;
...
	case I2C_PROBE:
		res = copy_from_user(request, (char *)arg,
sizeof(request));
		if (res)
			return res;
		colon = strchr(request, ',');
		if((!colon) || (colon - request > I2C_NAME_SIZE - 1))
			return -EINVAL;
		memset (probeTemp,0,sizeof(probeTemp)); // set the whole
buffer to 0 so that when the string is added it is automatically null
terminated.
		strncpy(probeTemp, request, colon - request);
		addr = simple_strtoul(colon + 1, NULL, 0);
		printk (KERN_ERR "got %s and %d\n",probeTemp,addr);
		printk (KERN_ERR "client info name: %s\n",
client->name);
		printk (KERN_ERR "client's adapter's name: %s\n",
client->adapter->name); // this is what probe wants
		/* Check for address business */
		if (i2c_check_addr(client->adapter, client->addr))
			return -EBUSY;

??? What call to put here to probe the actual chip ???

		return 0;


Thanks!
Chuck
